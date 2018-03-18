Received: from eggs.gnu.org ([2001:4830:134:3::10]:40448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1exh6K-0000Jv-By
	for qemu-devel@nongnu.org; Sun, 18 Mar 2018 18:48:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1exh6H-0000wX-AJ
	for qemu-devel@nongnu.org; Sun, 18 Mar 2018 18:48:28 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
	<1521232280-13089-21-git-send-email-alindsay@codeaurora.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b8b7a898-b714-3563-7f7a-84374db2b283@amsat.org>
Date: Sun, 18 Mar 2018 23:48:22 +0100
MIME-Version: 1.0
In-Reply-To: <1521232280-13089-21-git-send-email-alindsay@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v3 20/22] target/arm: PMU: Add
 instruction and cycle events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <alindsay@codeaurora.org>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Michael Spradling <mspradli@codeaurora.org>, qemu-devel@nongnu.org, Digant Desai <digantd@codeaurora.org>

On 03/16/2018 09:31 PM, Aaron Lindsay wrote:
> The instruction event is only enabled when icount is used, cycles are
> always supported. Always defining get_cycle_count (but altering its
> behavior depending on CONFIG_USER_ONLY) allows us to remove some
> CONFIG_USER_ONLY #defines throughout the rest of the code.
> 
> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> ---
[...]>  #define SUPPORTED_EVENT_SENTINEL UINT16_MAX
>  static const pm_event pm_events[] = {
> +#ifndef CONFIG_USER_ONLY
> +    { .number = 0x008, /* INST_RETIRED */

"Instruction architecturally executed" seems more explicit to me.

> +      .supported = instructions_supported,
> +      .get_count = instructions_get_count
> +    },
> +    { .number = 0x011, /* CPU_CYCLES */
> +      .supported = event_always_supported,
> +      .get_count = cycles_get_count
> +    },
> +#endif
[...]

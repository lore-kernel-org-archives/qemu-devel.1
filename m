Received: from eggs.gnu.org ([2001:4830:134:3::10]:47384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6f5p-0005hG-OU
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 12:29:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6f5o-0005jc-Rm
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 12:29:01 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:39621)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f6f5o-0005im-Mr
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 12:29:00 -0400
Received: by mail-ot0-x241.google.com with SMTP id a14-v6so6691904otf.6
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 09:29:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1521232280-13089-8-git-send-email-alindsay@codeaurora.org>
References: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
	<1521232280-13089-8-git-send-email-alindsay@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Apr 2018 17:28:39 +0100
Message-ID: <CAFEAcA-NGpHKHUiQPYKofKB5CA0q3fsgMkm6kc8=dS6N4Tdn1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 07/22] target/arm: Fetch GICv3 state
 directly from CPUARMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <alindsay@codeaurora.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On 16 March 2018 at 20:31, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> This eliminates the need for fetching it from el_change_hook_opaque, and
> allows for supporting multiple el_change_hooks without having to hack
> something together to find the registered opaque belonging to GICv3.
>
> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> ---
>  hw/intc/arm_gicv3_cpuif.c | 10 ++--------
>  target/arm/cpu.h          | 10 ----------
>  2 files changed, 2 insertions(+), 18 deletions(-)

I'm not wonderfully happy about this, because the original aim
here was to try to keep the GICv3 device end reasonably decoupled
from the CPU proper. On the other hand since d3a3e529626fb we've had
this pointer because we ended up needing it in the KVM reset codepath,
so we might as well use it here too. Maybe one day I'll come back
to this and clean it up.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

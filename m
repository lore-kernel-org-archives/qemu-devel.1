Received: from eggs.gnu.org ([2001:4830:134:3::10]:41546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffSZd-0001q7-8T
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 12:11:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffSZc-0002jR-HL
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 12:11:37 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:45901)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ffSZc-0002j4-Bk
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 12:11:36 -0400
Received: by mail-oi0-x243.google.com with SMTP id q11-v6so3034741oic.12
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 09:11:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1529699547-17044-10-git-send-email-alindsay@codeaurora.org>
References: <1529699547-17044-1-git-send-email-alindsay@codeaurora.org>
	<1529699547-17044-10-git-send-email-alindsay@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jul 2018 17:11:15 +0100
Message-ID: <CAFEAcA--ZGyr7i_HGwZNwKQJsvQ1WsvHomT=tMxiLdTAQhV60Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 09/13] target/arm: PMU: Add instruction
 and cycle events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <alindsay@codeaurora.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <aclindsa@gmail.com>

On 22 June 2018 at 21:32, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> The instruction event is only enabled when icount is used, cycles are
> always supported. Always defining get_cycle_count (but altering its
> behavior depending on CONFIG_USER_ONLY) allows us to remove some
> CONFIG_USER_ONLY #defines throughout the rest of the code.
>
> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

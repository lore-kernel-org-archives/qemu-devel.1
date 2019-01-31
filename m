Received: from eggs.gnu.org ([209.51.188.92]:56585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpCcQ-0001sR-B5
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:43:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpCcP-0002A3-Nq
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:43:02 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:45166)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpCcP-00029s-HK
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:43:01 -0500
Received: by mail-oi1-x241.google.com with SMTP id y1so2688114oie.12
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 05:43:01 -0800 (PST)
MIME-Version: 1.0
References: <20190124162401.5111-1-aaron@os.amperecomputing.com>
In-Reply-To: <20190124162401.5111-1-aaron@os.amperecomputing.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Jan 2019 13:42:48 +0000
Message-ID: <CAFEAcA-5X8SL5kSCztpEr7dR5Nz8h3QSrYVJs_1+MVZiEdFhxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v12 0/2] More fully implement ARM PMUv3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay OS <aaron@os.amperecomputing.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On Thu, 24 Jan 2019 at 16:24, Aaron Lindsay OS
<aaron@os.amperecomputing.com> wrote:
>
> Most of this patchset implementing the PMU has been merged already, but
> the interrupt-on-overflow behavior had some additional review comments.
> This most recent version fixes a type promotion issue and adds Richard's
> Reviewed-by's.
>
> Aaron Lindsay (2):
>   target/arm: Send interrupts on PMU counter overflow
>   target/arm: Add a timer to predict PMU counter overflow
>



Applied to target-arm.next, thanks.

-- PMM

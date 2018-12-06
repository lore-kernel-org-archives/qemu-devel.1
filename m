Received: from eggs.gnu.org ([2001:4830:134:3::10]:59296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUw1b-00014L-E4
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 10:57:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUw1W-0006RA-8S
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 10:57:15 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gUw1T-0006Lb-O1
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 10:57:09 -0500
Received: by mail-ot1-x343.google.com with SMTP id 81so860675otj.2
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 07:57:04 -0800 (PST)
MIME-Version: 1.0
References: <20181205134243.4791-1-aaron@os.amperecomputing.com>
	<20181205134243.4791-8-aaron@os.amperecomputing.com>
In-Reply-To: <20181205134243.4791-8-aaron@os.amperecomputing.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Dec 2018 15:56:52 +0000
Message-ID: <CAFEAcA8EcYu6SWYzQzLL1136RZh1XQnhcFitSkd8koMgJJ3MgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v9 07/14] target/arm: Define FIELDs for
 ID_DFR0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <aaron@os.amperecomputing.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On Wed, 5 Dec 2018 at 13:43, Aaron Lindsay <aaron@os.amperecomputing.com> wrote:
>
> This is immediately necessary for the PMUv3 implementation to check
> ID_DFR0.PerfMon to enable/disable specific features, but defines the
> full complement of fields for possible future use elsewhere.
>
> Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
> ---
>  target/arm/cpu.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 627e5c1995..304e6e47b3 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1586,6 +1586,14 @@ FIELD(ID_AA64PFR0, GIC, 24, 4)
>  FIELD(ID_AA64PFR0, RAS, 28, 4)
>  FIELD(ID_AA64PFR0, SVE, 32, 4)
>
> +FIELD(ID_DFR0, COPDBG, 0, 4)
> +FIELD(ID_DFR0, COPSDBG, 4, 4)
> +FIELD(ID_DFR0, MMAPDBG, 8, 4)
> +FIELD(ID_DFR0, COPTRC, 12, 4)
> +FIELD(ID_DFR0, MMAPTRC, 16, 4)
> +FIELD(ID_DFR0, MPROFDBG, 20, 4)
> +FIELD(ID_DFR0, PERFMON, 24, 4)

Also
FIELD(ID_DFR0, TRACEFILT, 28, 4)

(this is a v8.4 field; we might as well add it since you
have another minor tweak that needs a respin.)

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

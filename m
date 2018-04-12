Received: from eggs.gnu.org ([2001:4830:134:3::10]:58595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6eoV-00028e-Hr
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 12:11:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6eoU-0004hJ-JD
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 12:11:07 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:40448)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f6eoU-0004h0-E9
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 12:11:06 -0400
Received: by mail-oi0-x241.google.com with SMTP id x9-v6so5674585oig.7
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 09:11:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1521232280-13089-5-git-send-email-alindsay@codeaurora.org>
References: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
	<1521232280-13089-5-git-send-email-alindsay@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Apr 2018 17:10:45 +0100
Message-ID: <CAFEAcA8vjBaExLH_EfbWZ3nwxksL1eY67V4gkWTmu3431Az_Hg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 04/22] target/arm: Treat PMCCNTR as
 alias of PMCCNTR_EL0
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
> They share the same underlying state
>
> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> ---
>  target/arm/helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 5e48982..5634561 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -1318,7 +1318,7 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
>        .fieldoffset = offsetof(CPUARMState, cp15.c9_pmselr),
>        .writefn = pmselr_write, .raw_writefn = raw_write, },
>      { .name = "PMCCNTR", .cp = 15, .crn = 9, .crm = 13, .opc1 = 0, .opc2 = 0,
> -      .access = PL0_RW, .resetvalue = 0, .type = ARM_CP_IO,
> +      .access = PL0_RW, .resetvalue = 0, .type = ARM_CP_ALIAS | ARM_CP_IO,
>        .readfn = pmccntr_read, .writefn = pmccntr_write32,
>        .accessfn = pmreg_access_ccntr },
>      { .name = "PMCCNTR_EL0", .state = ARM_CP_STATE_AA64,
> --

Does this fix an observed bug (presumably migration related),
or is it just something you saw in code inspection ?
Worth noting in the commit message if the former.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

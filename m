Received: from eggs.gnu.org ([2001:4830:134:3::10]:53956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDVfn-0007IC-EK
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 10:22:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDVfm-0000pX-Gi
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 10:22:43 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:44762)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gDVfm-0000Qb-8g
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 10:22:42 -0400
Received: by mail-oi1-x241.google.com with SMTP id u74-v6so26923818oia.11
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 07:22:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181019015617.22583-2-richard.henderson@linaro.org>
References: <20181019015617.22583-1-richard.henderson@linaro.org>
	<20181019015617.22583-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 15:22:05 +0100
Message-ID: <CAFEAcA_S7wpekvkebJDOMfWpqQpGU3CJf=9bbjcfH1WWJdrjyw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 1/3] target/arm: Remove writefn from
 TTBR0_EL3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 19 October 2018 at 02:56, Richard Henderson
<richard.henderson@linaro.org> wrote:
> The EL3 version of this register does not include an ASID,
> and so the tlb_flush performed by vmsa_ttbr_write is not needed.
>
> Reviewed-by: Aaron Lindsay <aaron@os.amperecomputing.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index e3946562aa..24bbde4f76 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -4214,7 +4214,7 @@ static const ARMCPRegInfo el3_cp_reginfo[] = {
>        .fieldoffset = offsetof(CPUARMState, cp15.mvbar) },
>      { .name = "TTBR0_EL3", .state = ARM_CP_STATE_AA64,
>        .opc0 = 3, .opc1 = 6, .crn = 2, .crm = 0, .opc2 = 0,
> -      .access = PL3_RW, .writefn = vmsa_ttbr_write, .resetvalue = 0,
> +      .access = PL3_RW, .resetvalue = 0,
>        .fieldoffset = offsetof(CPUARMState, cp15.ttbr0_el[3]) },
>      { .name = "TCR_EL3", .state = ARM_CP_STATE_AA64,
>        .opc0 = 3, .opc1 = 6, .crn = 2, .crm = 0, .opc2 = 2,
> --
> 2.17.2
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

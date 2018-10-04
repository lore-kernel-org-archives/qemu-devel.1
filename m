Received: from eggs.gnu.org ([2001:4830:134:3::10]:33153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g85tl-000477-DW
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:50:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g85tg-00045M-B5
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:50:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g85tg-00043N-1j
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:50:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id a13-v6so10469623wrt.5
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 08:50:39 -0700 (PDT)
References: <1538656491-22950-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1538656491-22950-2-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e4b5917b-2d47-378f-ce78-d8fa9051b053@redhat.com>
Date: Thu, 4 Oct 2018 17:50:37 +0200
MIME-Version: 1.0
In-Reply-To: <1538656491-22950-2-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/4] target/mips: Add bit definitions for
 DSP R3 ASE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org, Stefan Markovic <smarkovic@wavecomp.com>
Cc: dnikolic@wavecomp.com, richard.henderson@linaro.org, amarkovic@wavecomp.com, pjovanovic@wavecomp.com, aurelien@aurel32.net

Hi Aleksandar and Stefan,

On 04/10/2018 14:34, Aleksandar Markovic wrote:
> From: Stefan Markovic <smarkovic@wavecomp.com>
> 
> Add DSP R3 ASE related bit definition for insn_flags and hflags.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  target/mips/cpu.h       | 1 +
>  target/mips/mips-defs.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index 28af4d1..4160699 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -598,6 +598,7 @@ struct CPUMIPSState {
>      /* MIPS DSP resources access. */
>  #define MIPS_HFLAG_DSP   0x080000  /* Enable access to MIPS DSP resources. */
>  #define MIPS_HFLAG_DSPR2 0x100000  /* Enable access to MIPS DSPR2 resources. */
> +#define MIPS_HFLAG_DSPR3 0x20000000 /* Enable access to MIPS DSPR3 resources.*/

I find it confusing to add this in the middle (rather that at the end)
of this list. It looks also bug prone, if someone add another definition
at the end of the list he might use the same value.

>      /* Extra flag about HWREna register. */
>  #define MIPS_HFLAG_HWRENA_ULR 0x200000 /* ULR bit from HWREna is set. */
>  #define MIPS_HFLAG_SBRI  0x400000 /* R6 SDBBP causes RI excpt. in user mode */
> diff --git a/target/mips/mips-defs.h b/target/mips/mips-defs.h
> index c8e9979..b27b7ae 100644
> --- a/target/mips/mips-defs.h
> +++ b/target/mips/mips-defs.h
> @@ -47,6 +47,7 @@
>  #define   ASE_MDMX      0x00040000
>  #define   ASE_DSP       0x00080000
>  #define   ASE_DSPR2     0x00100000
> +#define   ASE_DSPR3     0x02000000

Ditto.

>  #define   ASE_MT        0x00200000
>  #define   ASE_SMARTMIPS 0x00400000
>  #define   ASE_MICROMIPS 0x00800000

What about adding this patch on top of the "mips: Clean the 'insn_flags'
namespace" patch which use your suggestion and let available space for
this ASE flag?

https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg04070.html

Thanks,

Phil.

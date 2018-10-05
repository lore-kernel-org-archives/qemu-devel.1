Received: from eggs.gnu.org ([2001:4830:134:3::10]:57209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g8Tv8-0004oC-6M
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 13:29:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g8Ti5-0001o2-SF
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 13:16:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40768)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g8Ti5-0001ng-Lv
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 13:16:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id d2-v6so9871401wro.7
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 10:16:17 -0700 (PDT)
References: <1538752793-6875-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1538752793-6875-7-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1fc4e222-260e-5c75-5dff-7695f034f0bb@redhat.com>
Date: Fri, 5 Oct 2018 19:16:14 +0200
MIME-Version: 1.0
In-Reply-To: <1538752793-6875-7-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 6/7] target/mips: Add opcodes for
 nanoMIPS EVA instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: smarkovic@wavecomp.com, riku.voipio@iki.fi, richard.henderson@linaro.org, laurent@vivier.eu, amarkovic@wavecomp.com, pjovanovic@wavecomp.com, aurelien@aurel32.net

On 05/10/2018 17:19, Aleksandar Markovic wrote:
> From: Dimitrije Nikolic <dnikolic@wavecomp.com>
> 
> Add opcodes for nanoMIPS EVA instructions: CACHEE, LBE, LBUE, LHE,
> LHUE, LLE, LLWPE, LWE, PREFE, SBE, SCE, SCWPE, SHE, SWE.

B.44 of "nanoMIPS32 Instruction Set Technical Reference Manual"

> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  target/mips/translate.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index d64a1da..b0b2f40 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -16499,6 +16499,22 @@ enum {
>      NM_P_SC      = 0x0b,
>  };
>  
> +/* P.LS.E0 instruction pool */
> +enum {
> +    NM_LBE      = 0x00,
> +    NM_SBE      = 0x01,
> +    NM_LBUE     = 0x02,
> +    NM_P_PREFE  = 0x03,
> +    NM_LHE      = 0x04,
> +    NM_SHE      = 0x05,
> +    NM_LHUE     = 0x06,
> +    NM_CACHEE   = 0x07,
> +    NM_LWE      = 0x08,
> +    NM_SWE      = 0x09,
> +    NM_P_LLE    = 0x0a,
> +    NM_P_SCE    = 0x0b,
> +};
> +
>  /* P.LS.WM instruction pool */
>  enum {
>      NM_LWM       = 0x00,
> 

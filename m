Received: from eggs.gnu.org ([2001:4830:134:3::10]:60972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fao7N-0000Wm-Rg
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 16:11:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fao7J-0005Rs-Ab
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 16:11:13 -0400
Received: from mail-qk0-x234.google.com ([2607:f8b0:400d:c09::234]:37043)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fao7J-0005RF-55
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 16:11:09 -0400
Received: by mail-qk0-x234.google.com with SMTP id t79-v6so3408456qke.4
	for <qemu-devel@nongnu.org>; Wed, 04 Jul 2018 13:11:09 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1530732637-28606-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1530732637-28606-3-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f5f4cd65-545e-42f7-3d8d-1d57ced676d7@amsat.org>
Date: Wed, 4 Jul 2018 17:11:03 -0300
MIME-Version: 1.0
In-Reply-To: <1530732637-28606-3-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/8] target/mips: Workaround for
 checkpatch.pl hanging on msa_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

Hi Aleksandar,

On 07/04/2018 04:30 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> If checkpatch.pl is applied (using switch "-f") on file
> target/mips/msa_helper.c, it will hang.
> 
> This is a workaround by correcting the source file. The workaround is
> found by partial deleting and undeleting of the code in msa_helper.c
> in binary search fashion.
> 
> The bug (for checkpatch.pl) is already reported to the qemu-devel list.

Paolo already sent a fix for this bug:
http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg01250.html

Can you test it?

> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  target/mips/msa_helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
> index c74e3cd..1691b70 100644
> --- a/target/mips/msa_helper.c
> +++ b/target/mips/msa_helper.c
> @@ -2750,8 +2750,8 @@ void helper_msa_ftq_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
>  
>  #define FMAXMIN_A(F, G, X, _S, _T, BITS, STATUS)                    \
>      do {                                                            \
> -        uint## BITS ##_t S = _S, T = _T;                            \
> -        uint## BITS ##_t as, at, xs, xt, xd;                        \
> +        uint## BITS ## _t S = _S, T = _T;                           \
> +        uint## BITS ## _t as, at, xs, xt, xd;                       \
>          if (NUMBER_QNAN_PAIR(S, T, BITS, STATUS)) {                 \
>              T = S;                                                  \
>          }                                                           \
> 

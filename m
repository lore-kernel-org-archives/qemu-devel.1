Received: from eggs.gnu.org ([2001:4830:134:3::10]:59778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fbSp6-0007KQ-TO
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 11:39:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fbSp3-00018T-OV
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 11:39:04 -0400
Received: from mail-eopbgr680121.outbound.protection.outlook.com
	([40.107.68.121]:31373
	helo=NAM04-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fbSp3-00018J-I8
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 11:39:01 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 6 Jul 2018 15:38:56 +0000
Message-ID: <BN7PR08MB4868AC9B85699C8293579F63C6470@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1530877732-26557-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1530877732-26557-3-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1530877732-26557-3-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 2/8] target/mips: Workaround for
 checkpatch.pl hanging on msa_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

Hi, Paolo,

It was an incredibly fast fix! :)

I already confirmed that the fix fixes the problem on msa_helper.c. I would=
 nevertheless like to have this workaround applied. Can you perhaps give it=
 "Reviewed-by"?

Regards,
Aleksandar


> Subject: [PATCH v4 2/8] target/mips: Workaround for checkpatch.pl hanging=
 on > msa_helper.c
>
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
> @@ -2750,8 +2750,8 @@ void helper_msa_ftq_df(CPUMIPSState *env, uint32_t =
df, > uint32_t wd,
>
>  #define FMAXMIN_A(F, G, X, _S, _T, BITS, STATUS)                    \
>      do {                                                            \
> -        uint## BITS ##_t S =3D _S, T =3D _T;                            =
\
> -        uint## BITS ##_t as, at, xs, xt, xd;                        \
> +        uint## BITS ## _t S =3D _S, T =3D _T;                           =
\
> +        uint## BITS ## _t as, at, xs, xt, xd;                       \
>          if (NUMBER_QNAN_PAIR(S, T, BITS, STATUS)) {                 \
>              T =3D S;                                                  \
>          }                                                           \
> --
> 2.7.4

Received: from eggs.gnu.org ([2001:4830:134:3::10]:53322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gDYJq-0007c5-4f
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:12:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gDYJm-0004vU-VQ
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:12:14 -0400
Received: from mail-bl2nam02on0132.outbound.protection.outlook.com
	([104.47.38.132]:43338
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gDYJm-0004nC-IA
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:12:10 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 19 Oct 2018 17:12:05 +0000
Message-ID: <BN6PR2201MB1251E2C9DB7A33A53B49965EC6F90@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1539966828-20947-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1539966828-20947-6-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539966828-20947-6-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 05/14] target/mips: Add bit encoding for
 MXU add/subtract patterns 'aptn2'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, "jancraig@amazon.com" <jancraig@amazon.com>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>


> From: Aleksandar Markovic <> aleksandar.markovic@rt-rk.com>
> Sent: Friday, October 19, 2018 6:33 PM
> Subject: [PATCH v5 05/14] target/mips: > Add bit encoding for MXU add/sub=
tract > patterns 'aptn2'
>=20
> From: Craig Janeczek <> jancraig@amazon.com>
>=20
> Add bit encoding for MXU add/subtract patterns 'aptn2'.
>=20

'eptn2' is very similar to 'aptn2', but we need a similar patch for 'eptn2'=
 too.

This is needed so that we are as close to the documentation as possible.

'aptn1' and 'strd2', in my opinion, do not need any preprocessor definition=
, since they can be only 0 and 1, and 0, 1, 2 respectively... What do you t=
hink, Craig?

Thanks,
Aleksandar

> Signed-off-by: Craig Janeczek <> jancraig@amazon.com>
> Signed-off-by: Aleksandar Markovic <> amarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/target/mips/translate.c b/> target/mips/translate.c
> index 5f8dcc9..f465635 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -23311,6 +23311,13 @@ static void > decode_opc_special(CPUMIPSState *e=
nv, > DisasContext *ctx)
>      }
>  }
>=20
> +/* MXU add/subtract patterns 'aptn2' */
> +#define MXU_APTN2_AA    0
> +#define MXU_APTN2_AS    1
> +#define MXU_APTN2_SA    2
> +#define MXU_APTN2_SS    3
> +
> +
>  /*
>   *
>   * Decode MXU pool00
> --
> 2.7.4
>=20

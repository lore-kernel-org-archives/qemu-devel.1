Received: from eggs.gnu.org ([2001:4830:134:3::10]:50241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gCQEw-0005xN-B8
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 10:22:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gCQEo-0007Uz-2h
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 10:22:29 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:51244)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1gCQEk-0007Mq-Jf
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 10:22:20 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181016135927.GH7995@redhat.com>
References: <20181016100918.21030-1-berrange@redhat.com>
	<20181016100918.21030-6-berrange@redhat.com>
	<w51bm7uypyy.fsf@maestria.local.igalia.com>
	<20181016135927.GH7995@redhat.com>
Date: Tue, 16 Oct 2018 16:22:12 +0200
Message-ID: <w518t2yynsb.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/8] crypto: convert xts_mult_x to use
 xts_uint128 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue 16 Oct 2018 03:59:27 PM CEST, Daniel P. Berrang=C3=A9 wrote:
> In fact I could do the following:
>
> @@ -59,12 +59,13 @@ static void xts_mult_x(xts_uint128 *I)
>      xts_uint128_cpu_to_les(I);
>=20=20
>      tt =3D I->u[0] >> 63;
> -    I->u[0] =3D I->u[0] << 1;
> +    I->u[0] <<=3D 1;
>=20=20
>      if (I->u[1] >> 63) {
>          I->u[0] ^=3D 0x87;
>      }
> -    I->u[1] =3D (I->u[1] << 1) | tt;
> +    I->u[1] <<=3D 1;
> +    I->u[1] |=3D tt;
>=20=20
>      xts_uint128_le_to_cpus(I);
>  }

Yep, that looks good.

Berto

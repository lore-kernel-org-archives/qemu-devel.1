Received: from eggs.gnu.org ([2001:4830:134:3::10]:60894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1eFQRt-0001Ml-WD
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 15:07:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1eFQRp-0002QJ-Nc
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 15:07:45 -0500
Received: from mail.weilnetz.de ([37.120.169.71]:60224
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1eFQRp-0002PH-HU
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 15:07:41 -0500
References: <20171116022832.24894-1-maozy.fnst@cn.fujitsu.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <b6ef2227-c462-ccec-9e37-d29a0cdace59@weilnetz.de>
Date: Thu, 16 Nov 2017 21:07:38 +0100
MIME-Version: 1.0
In-Reply-To: <20171116022832.24894-1-maozy.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] colo-compare: fix the dangerous assignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>

Am 16.11.2017 um 03:28 schrieb Mao Zhongyi:
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Zhang Chen <zhangckid@gmail.com>
> Cc: Li Zhijian <lizhijian@cn.fujitsu.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Fixes: 8ec14402029d783720f4312ed8a925548e1dad61
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Reported-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> ---
>  net/colo-compare.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index ccdcba2..1ce195f 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -179,7 +179,7 @@ static int packet_enqueue(CompareState *s, int mode=
, Connection **con)
>                           "drop packet");
>          }
>      }
> -    con =3D &conn;
> +    *con =3D conn;
> =20
>      return 0;
>  }

The patch is definitely needed if the new function parameter con
should work.

It also fixes a gcc compiler warning:
net/colo-compare.c:139:67: warning: parameter =E2=80=98con=E2=80=99 set b=
ut not used
[-Wunused-but-set-parameter]

I=E2=80=8C think using -Wextra would be really good to catch such bugs ea=
rlier.

Regards,
Stefan

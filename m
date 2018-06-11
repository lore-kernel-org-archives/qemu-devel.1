Received: from eggs.gnu.org ([2001:4830:134:3::10]:54175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fSQSQ-0003w8-KJ
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:18:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fSQSN-00050W-Be
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:18:18 -0400
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:49282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fSQSN-0004ya-5k
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:18:15 -0400
Received: from player795.ha.ovh.net (unknown [10.109.120.10])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 9869213B7B5
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 19:18:13 +0200 (CEST)
References: <20180611171518.3390-1-clg@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <bfdc313f-f8b0-77a5-e87b-cc9c75f8e110@kaod.org>
Date: Mon, 11 Jun 2018 19:18:06 +0200
MIME-Version: 1.0
In-Reply-To: <20180611171518.3390-1-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] m25p80: add support for two bytes WRSR for
 Macronix chips
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: qemu-block@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 06/11/2018 07:15 PM, C=C3=A9dric Le Goater wrote:
> On Macronix chips, two bytes can written to the WRSR. First byte will
> configure the status register and the second the configuration
> register. It is important to save the configuration value as it
> contains the dummy cycle setting when using dual or quad IO mode.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  hw/block/m25p80.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index b49c8e9caa04..29775e055a24 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -699,6 +699,7 @@ static void complete_collecting_data(Flash *s)
>          case MAN_MACRONIX:
>              s->quad_enable =3D extract32(s->data[0], 6, 1);
>              if (s->len > 1) {
> +                s->volatile_cfg =3D s->data[1];
>                  s->four_bytes_address_mode =3D extract32(s->data[1], 5=
, 1);
>              }
>              break;
>=20

I sent this patch to qemu-ppc instead of qemu-devel ...

Sorry for the noise.

C.=20

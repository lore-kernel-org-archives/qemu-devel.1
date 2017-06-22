Received: from eggs.gnu.org ([2001:4830:134:3::10]:54596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1dO1rz-0005Lx-RQ
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 09:10:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1dO1rx-0008Hw-4t
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 09:09:59 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:42256
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1dO1rw-0008HY-UB
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 09:09:57 -0400
References: <20170622124204.19407-1-marcandre.lureau@redhat.com>
	<20170622124204.19407-32-marcandre.lureau@redhat.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <4c3acdae-a0b6-38a3-ee74-e774ea94c56a@weilnetz.de>
Date: Thu, 22 Jun 2017 15:09:53 +0200
MIME-Version: 1.0
In-Reply-To: <20170622124204.19407-32-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 31/31] eepro100: replace
 g_malloc()+memcpy() with g_memdup()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>

Am 22.06.2017 um 14:42 schrieb Marc-Andr=C3=A9 Lureau:
> I found these pattern via grepping the source tree. I don't have a
> coccinelle script for it!
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/net/eepro100.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
> index 4bf71f2d85..7d3b2e52c7 100644
> --- a/hw/net/eepro100.c
> +++ b/hw/net/eepro100.c
> @@ -1894,8 +1894,7 @@ static void e100_nic_realize(PCIDevice *pci_dev, =
Error **errp)
> =20
>      qemu_register_reset(nic_reset, s);
> =20
> -    s->vmstate =3D g_malloc(sizeof(vmstate_eepro100));
> -    memcpy(s->vmstate, &vmstate_eepro100, sizeof(vmstate_eepro100));
> +    s->vmstate =3D g_memdup(&vmstate_eepro100, sizeof(vmstate_eepro100=
));
>      s->vmstate->name =3D qemu_get_queue(s->nic)->model;
>      vmstate_register(&pci_dev->qdev, -1, s->vmstate, s);
>  }
>=20

Reviewed-by: Stefan Weil <sw@weilnetz.de>

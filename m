Received: from eggs.gnu.org ([2001:4830:134:3::10]:45511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cdGjj-0000Fb-Kh
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 08:32:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cdGjg-0007bh-Fp
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 08:32:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cdGjg-0007bV-8v
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 08:32:08 -0500
Message-ID: <1486992725.19677.20.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 13 Feb 2017 14:32:05 +0100
In-Reply-To: <CAJ+F1CJBwjp70CgzTCwXYQzcpn6X0r9ka80rc6DmqnJbgHZNUA@mail.gmail.com>
References: <20170212112118.16044-1-marcandre.lureau@redhat.com>
	<CAJ+F1CJBwjp70CgzTCwXYQzcpn6X0r9ka80rc6DmqnJbgHZNUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] spice: allow to specify drm rendernode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org

On Mo, 2017-02-13 at 08:37 +0000, Marc-Andr=C3=A9 Lureau wrote:
> Hi Gerd,
>=20
>=20
> Rendernode are not stable across reboots, it depends on module order.
>=20
> I have further patches to specify a pci address instead:
> rendernode=3D<file|pciaddr>. Does that seem fine?

No, IMO we should use udev rules to generate stable paths then
(/dev/disk/by-* style).

cheers,
  Gerd

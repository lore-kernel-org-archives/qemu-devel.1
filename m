Received: from eggs.gnu.org ([2001:4830:134:3::10]:42941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAG56-00050X-LD
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:30:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAG55-00032H-L7
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:30:36 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:34275)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dAG55-00030y-EF
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:30:35 -0400
Received: by mail-lf0-x242.google.com with SMTP id q24so3259107lfb.1
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 06:30:35 -0700 (PDT)
Date: Mon, 15 May 2017 14:30:31 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170515133031.GH1201@stefanha-x1.localdomain>
References: <20170512122158.32032-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o71xDhNo7p97+qVi"
Content-Disposition: inline
In-Reply-To: <20170512122158.32032-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PULL 0/6] usb patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org


--o71xDhNo7p97+qVi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 12, 2017 at 02:21:52PM +0200, Gerd Hoffmann wrote:
>   Hi,
>=20
> Here comes the usb patch queue, with a bugfix collection and a
> documentation update.
>=20
> please pull,
>   Gerd
>=20
> The following changes since commit 76d20ea0f1b26ebd5da2f5fb2fdf3250cde887=
bb:
>=20
>   Merge remote-tracking branch 'armbru/tags/pull-qapi-2017-05-04-v3' into=
 staging (2017-05-09 15:49:14 -0400)
>=20
> are available in the git repository at:
>=20
>   git://git.kraxel.org/qemu tags/pull-usb-20170512-1
>=20
> for you to fetch changes up to aa612b364ecbe1dc034efcabb04526f24e56c145:
>=20
>   hw/usb/dev-serial: Do not try to set vendorid or productid properties (=
2017-05-12 12:30:23 +0200)
>=20
> ----------------------------------------------------------------
> usb: bugfixes, doc update
>=20
> ----------------------------------------------------------------
> Gerd Hoffmann (1):
>       usb-redir: fix stack overflow in usbredir_log_data
>=20
> Ladi Prosek (3):
>       xhci: fix logging
>       usb-hub: clear PORT_STAT_SUSPEND on wakeup
>       xhci: relax link check
>=20
> Thomas Huth (2):
>       qemu-doc: Update to use the new way of attaching USB devices
>       hw/usb/dev-serial: Do not try to set vendorid or productid properti=
es
>=20
>  docs/qdev-device-use.txt |  6 ++--
>  hw/usb/dev-hub.c         |  1 +
>  hw/usb/dev-serial.c      | 24 ++++---------
>  hw/usb/hcd-xhci.c        |  9 ++---
>  hw/usb/redirect.c        | 13 +------
>  qemu-doc.texi            | 91 +++++++++++++++++++++++++++---------------=
------
>  6 files changed, 64 insertions(+), 80 deletions(-)
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--o71xDhNo7p97+qVi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZGa13AAoJEJykq7OBq3PIgCUIAKoy6jJAXGxqtJdQkBoNDhNa
50/R3Lg3LfGBK+JBQYFejKPy+17SqO9SeEMoKjLSlQ5Xn5mpGIQrC5yJm1/0RSkE
B2Q2gdt0vF91f4u5Ev2rtMjBuXuYmHn8m93XZMrqmLe/5jbTns6/H5NA/pVwjiqn
jNFgJcKLyWC/Mz7Qgp/cFTakSPhAhez8GcjhbBQ6xm/4VIJRG/f1S4zcJECKF/6z
QLedTCkpaw+iyA2gW9vhyMgGY9elxHd+/pVsCexxd2QX47rwROm8HSxUoqvYmRZv
IwygCT7nu/PA3QLRoI2aDldDUsfq68W83AVbS/tmlLy1hp/nqW2d7J7V+PXuVak=
=7Pqn
-----END PGP SIGNATURE-----

--o71xDhNo7p97+qVi--

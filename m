Received: from eggs.gnu.org ([208.118.235.92]:52905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gfRBJ-0004LR-Uv
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:14:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gfRBG-00054A-Sq
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:14:41 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:53354)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gfRBG-00053O-Lv
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:14:38 -0500
Received: by mail-wm1-x32a.google.com with SMTP id d15so1420894wmb.3
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 07:14:38 -0800 (PST)
Date: Fri, 4 Jan 2019 15:14:35 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190104151435.GJ30381@stefanha-x1.localdomain>
References: <51912a3cd93dc66e03425eba04ae041d@grossmann-venter.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fU0UwhtRbpo05rnG"
Content-Disposition: inline
In-Reply-To: <51912a3cd93dc66e03425eba04ae041d@grossmann-venter.com>
Subject: Re: [Qemu-devel] Qemu  the right way.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: liebrecht@grossmann-venter.com
Cc: qemu-devel@nongnu.org


--fU0UwhtRbpo05rnG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 25, 2018 at 05:48:50PM -0500, liebrecht@grossmann-venter.com wr=
ote:
> I have been using Qemu in the past about 8 years ago or so to run legacy
> windows software.
>=20
> I installed the latest qemu and noticed a lot changed and cant find
> conclusive answers online.
>=20
> I am writing this post to find what is the right way to start to set up q=
emu
> with a windows 7 pro guest. I want to try and eliminate the iterations and
> find out what is really possible for the guest.
>=20
> Hardware used"
> 24 Core AMD rackserver.
> Host OS Debian 9 Stretch
> Guest Windows 7 Pro 32 bit
>=20
> Requirements:
> 1) I need to be able to run at least 4 processors in the guest. Is this
> possible with qemu as hosts ?
> 2) I need to at least have sound working from applications in the guest w=
ith
> pulseaudio on the Debian host. Is it  possible ?
> 3) USB, what is the level of support 2.0 3.0 ?
> ( However windo$ 7 cannot really do USB3. so usb-3 is moot anyway)
> 4) What kind of devices can be run through usb ?
>=20
> The answers to 1-4 will be really helpful to decide if I should even be
> using it. The documentation is schetchy about all this.
> I tried Virtualbox, but it is just a nice looking empty promisebox yieldi=
ng
> nothing. Since Qemu helped me a lot in the past I will have better chances
> here.
>=20
> 5) I am currently installing win7pro guest with command
> $] qemu-system-x86_64 -boot c -cdrom /dev/cdrom -m 2048M
>=20
> and left out all the network card and sound driver switches as I have no
> clue what I should choose.
> Can they be configured afterwards ?

Running QEMU manually is pretty complex.  It's often used as a component
underneath libvirt - with nicer GUIs on top.

Have you tried virt-manager (https://virt-manager.org/) or GNOME Boxes
(https://wiki.gnome.org/Apps/Boxes)?

That way you don't need to learn all the details of QEMU command-line
options (and there are many!).

Stefan

--fU0UwhtRbpo05rnG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcL3hbAAoJEJykq7OBq3PIZ9QH/16UXXRHyRtt1C3Pg/Dypb+o
hKXCunlkjiuh85Gfwu1YU9zc4O1dx6ifGXtddsLcjj8ydFNDFh0zZy0CJLvTaXEy
7wj/auIzi2PzrZP3fNsfZtHTT/8fhX9u8aKndaCWB6UBxv699h2wRm6Xfk17eABJ
k6tYIK59iVMlVBEuWbDn2M4wJktNbJC95T9Vk9GYGpd9qiyPseuwYGrD91W242eJ
1/gqznt1XgyHC0dhWbmhtN6yzUep8BeCkK7yo+6USTv8nbiPieeGx4+8gFVI9VmW
cGQx1Odr59TOYNrLxTqMwqhAMkB72b2C/5DLLZnb87H1Esm7fD6jK6W9Wu/Mlc0=
=IHR4
-----END PGP SIGNATURE-----

--fU0UwhtRbpo05rnG--

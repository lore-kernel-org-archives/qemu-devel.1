Received: from eggs.gnu.org ([2001:4830:134:3::10]:58242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fD8ZO-0007el-Do
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 09:10:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fD8ZK-0003O6-3o
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 09:10:18 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:41369)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fD8ZJ-0003Np-SV
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 09:10:14 -0400
Received: by mail-wr0-x22b.google.com with SMTP id g21-v6so7989417wrb.8
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 06:10:13 -0700 (PDT)
Date: Mon, 30 Apr 2018 14:10:11 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180430131011.GC10576@stefanha-x1.localdomain>
References: <152465178789.21509.8085388028037824608.malonedeb@soybean.canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Izn7cH1Com+I3R9J"
Content-Disposition: inline
In-Reply-To: <152465178789.21509.8085388028037824608.malonedeb@soybean.canonical.com>
Subject: Re: [Qemu-devel] [Bug 1766841] [NEW] QEMU 2.12 Running Problem in
 Windows 7 Installation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1766841 <1766841@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>


--Izn7cH1Com+I3R9J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2018 at 10:23:07AM -0000, Justin wrote:
> Public bug reported:
>=20
> QEMU Version: 2.12 (Binary installer qemu-w64-setup-20180424.exe  from St=
efan Weil's website so I am not sure I should report it to Weil by email or=
 by this bug report system.)
> Host System: Windows 7 64bit
> Guest System: 9front 6350 (Codename=E2=80=9CCONTENTS, MAINTAINED, STABLE=
=E2=80=9D, Release 2018/02/02)
>=20
> QEMU Command:
> qemu-system-x86_64 -usb -device usb-mouse -hda plan9.qcow2.img -cdrom 9fr=
ont-6350.iso -boot d
>=20
> QEMU warning:=20
> (qemu-system-x86_64.exe:8844): GdkPixbuf-WARNING **: Cannot open pixbuf l=
oader module file 'D:\qemu\lib\gdk-pixbuf-2.0\2.10.0\loaders.cache': No suc=
h file or directory
>=20
> This likely means that your installation is broken.
> Try running the command
>   gdk-pixbuf-query-loaders > D:\qemu\lib\gdk-pixbuf-2.0\2.10.0\loaders.ca=
che
> to make things work again for the time being.
>=20
> (qemu-system-x86_64.exe:8844): Gtk-WARNING **: Could not find the icon 'w=
indow-minimize-symbolic-ltr'. The 'hicolor' theme was not found either, per=
haps you need to install it.
> You can get a copy from:
>         http://icon-theme.freedesktop.org/releases
>=20
> ** Affects: qemu
>      Importance: Undecided
>          Status: New
>=20
>=20
> ** Tags: installation windows
>=20
> --=20
> You received this bug notification because you are a member of qemu-
> devel-ml, which is subscribed to QEMU.
> https://bugs.launchpad.net/bugs/1766841

CCing Stefan Weil in case he hasn't seen this yet.

Stefan

--Izn7cH1Com+I3R9J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa5xWzAAoJEJykq7OBq3PIH2kIAIdKTjZK8Cft6XtJ/zuA9wEA
k77NsWThtJQ9/0eWjPN8AzwB8N3ipGVOy6D8LduukMTHooRBoiNHzq/h0up0aE4M
qSgpY+u830YNvyA+27osx/ABPKiKIy7vHtEHk1oOkD372yQL4iv4xn5oYqCsNZR5
w8P890gKVBXnGIaE/RKNtpUe/wriXi0AfVPB0d088dwt4ExQDFIJrmsxYvJFzXuA
tlrVBWapgOBM9WE8UcCrcey0UnhvaLb3w7dB51Vbe+fas8dlwH7pjzgDGnRhrQfg
WNBHqexlyo2xcabVJKiC5n1BxdbHSAeIiP5OzsnoFLpfFfD8JWZE4xEC6vd6Fl0=
=StB4
-----END PGP SIGNATURE-----

--Izn7cH1Com+I3R9J--

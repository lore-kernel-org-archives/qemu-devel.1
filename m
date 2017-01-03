Received: from eggs.gnu.org ([2001:4830:134:3::10]:49571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cOS58-0000mx-CR
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 11:37:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cOS54-0007yx-F8
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 11:37:02 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:33259)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cOS54-0007yV-8o
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 11:36:58 -0500
Received: by mail-wm0-x244.google.com with SMTP id u144so87435349wmu.0
	for <qemu-devel@nongnu.org>; Tue, 03 Jan 2017 08:36:58 -0800 (PST)
Date: Tue, 3 Jan 2017 16:36:55 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170103163655.GK14707@stefanha-x1.localdomain>
References: <CAE519-=M-FrxibKuJNpUGTCtVCC6YVC-R_zSSUKhShfw8EfubQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9kwpIYUMbI/2cCx"
Content-Disposition: inline
In-Reply-To: <CAE519-=M-FrxibKuJNpUGTCtVCC6YVC-R_zSSUKhShfw8EfubQ@mail.gmail.com>
Subject: Re: [Qemu-devel] (no subject)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: morgenlette madeBy <sgh8183@gmail.com>
Cc: qemu-devel@nongnu.org


--M9kwpIYUMbI/2cCx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 02, 2017 at 09:03:55PM +0900, morgenlette madeBy wrote:
> I got problem using QEMU.
>=20
> when i turn on virtual machine,
>=20
> this message was shown,
>=20
>=20
> virsh: error while loading shared libraries: libapparmor.so.1: cannot open
> shared object file: No such file or directory
>=20
> I have no idea about libapparmor.
>=20
>=20
> What should I do?

Hi,
Looks like the libvirt packages do not have all dependencies installed.

If you are using Ubuntu try "apt-get install libapparmor1" to install
the missing library.  I looked up the package that provides the
"libapparmor.so.1" filename here:
http://packages.ubuntu.com/search?searchon=3Dcontents&keywords=3Dlibapparmo=
r.so.1&mode=3Dexactfilename&suite=3Dxenial&arch=3Dany

If you have further questions please try asking for help from your Linux
distribution (e.g. #ubuntu on irc.freenode.net) since this question is
not directly related to QEMU.

Good luck,
Stefan

--M9kwpIYUMbI/2cCx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYa9MnAAoJEJykq7OBq3PIFdwH/RgotdU+Gf7Op2/Q5kYyxeBz
vOdjphRuUnEkZTow2mYYOR64TI1tHCfNbt0FyXH2tNttsmjLddymnnzP4nHp11D/
DZoXoq6vW/qkjYAjvuCbZB9dW3aGHIOx3y5slUzk6ZTES7/BlKfacydIZqy/M2Un
oWucKE0YIQ575xeZjQdjRXcdKYZp0YAU0pF3LXlnh6NBs+DyhPxhgvMr1JKcB26v
26RTuh4xLJsgNz4aa0DAmapfPHw/JkSNOfD4dLb77lVLQkHqerrcSZP3hyrQCN7I
nIPHuubIqrzr2RwOAguJdApCTuYrJGUyJzW9OHHoTtfaWdlGHQ87XOpvTKksZTw=
=8nZ8
-----END PGP SIGNATURE-----

--M9kwpIYUMbI/2cCx--

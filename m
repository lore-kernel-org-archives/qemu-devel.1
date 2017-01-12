Received: from eggs.gnu.org ([2001:4830:134:3::10]:41378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cRgCx-0006m0-Cz
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:18:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cRgCs-0002FB-Qs
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:18:27 -0500
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:37445)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cRgCs-0002Eq-Kk
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:18:22 -0500
Received: by mail-wm0-x22a.google.com with SMTP id c206so22037420wme.0
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 06:18:22 -0800 (PST)
Date: Thu, 12 Jan 2017 14:18:13 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170112141813.GC14042@stefanha-x1.localdomain>
References: <20170111212721.20360.4397.malonedeb@wampee.canonical.com>
	<20170111215835.26958.78968.malone@chaenomeles.canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xo44VMWPx7vlQ2+2"
Content-Disposition: inline
In-Reply-To: <20170111215835.26958.78968.malone@chaenomeles.canonical.com>
Subject: Re: [Qemu-devel] [Bug 1655764] Re: qemu-img convert -c compression
 can't decompress
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1655764 <1655764@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org


--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 11, 2017 at 09:58:35PM -0000, Jignasha wrote:
> When tried zlib-flate -uncompress < cirros-0.3.4-x86_64-disk.img,
> getting below error
>=20
> data: incorrect header check

QEMU image compression uses the compression feature available in some
disk image formats (like qcow2).  This is not the same as compressing a
file with gzip, bzip2, or similar tools.

Therefore this error is expected and not a bug.

--xo44VMWPx7vlQ2+2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYd5AlAAoJEJykq7OBq3PIfWcH/3EOX79fwj/5o2ZtxJb4duK5
UU9rmWP46JVDPTfXM9ONN8+7wOcr0/Ksc9tP1xUoa0dq8mH9CF68ai2qJTR0WlQN
JCVFKNTFyYH6v4Hou+fKWd3DmVwv+31XKxPLXWkmXHIpqFzaZAGYw10KeQdE6j51
sQWfxwUpBcFEjAm3bCI+3Oy0lopsdQRyQt6Zk3sP9xDQNbQkUFM49sjBC1aoRV8p
qgNfPkrBEH0qFPQt3z9llibOrcsntSsDrmKh1g+MGV6cXig7LndYVi2/Jw49p6gd
IUnSgUSuUwOCVEDq1Wzgb4OlxG+UDfndNj2wOD2hVslUt8pl6anRs3zfPNjhDMg=
=kDdQ
-----END PGP SIGNATURE-----

--xo44VMWPx7vlQ2+2--

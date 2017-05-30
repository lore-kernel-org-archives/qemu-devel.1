Received: from eggs.gnu.org ([2001:4830:134:3::10]:35592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dFgyA-0000rZ-43
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:13:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dFgy5-0003gw-Bx
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:13:54 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:33067)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dFgy5-0003gc-5w
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:13:49 -0400
Received: by mail-wr0-x233.google.com with SMTP id v104so353380wrb.0
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 06:13:49 -0700 (PDT)
Date: Tue, 30 May 2017 14:13:46 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170530131346.GB11356@stefanha-x1.localdomain>
References: <20170505101337.4650-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline
In-Reply-To: <20170505101337.4650-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PULL 00/21] Misc patches for 2017-05-05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 05, 2017 at 12:13:16PM +0200, Paolo Bonzini wrote:
> The following changes since commit e619b14746e5d8c0e53061661fd0e1da01fd4d=
60:
>=20
>   Merge remote-tracking branch 'sthibault/tags/samuel-thibault' into stag=
ing (2017-05-02 15:16:29 +0100)
>=20
> are available in the git repository at:
>=20
>   git://github.com/bonzini/qemu.git tags/for-upstream
>=20
> for you to fetch changes up to 95615ce5a1beffff1a5dd3597d8cb6ba83f0010e:
>=20
>   vhost-scsi: create a vhost-scsi-common abstraction (2017-05-05 12:10:00=
 +0200)
>=20
> ----------------------------------------------------------------
> A large set of small patches.  I have not included yet vhost-user-scsi,
> but it'll come in the next pull request.
>=20
> * use GDB XML register description for x86
> * use _Static_assert in QEMU_BUILD_BUG_ON
> * add "R:" to MAINTAINERS and get_maintainers
> * checkpatch improvements
> * dump threading fixes
> * first part of vhost-user-scsi support
> * QemuMutex tracing
> * vmw_pvscsi and megasas fixes
> * sgabios module update
> * use Rev3 (ACPI 2.0) FADT
> * deprecate -hdachs
> * improve -accel documentation
> * hax fix
> * qemu-char GSource bugfix

I had to drop this pull request because vhost-user-scsi breaks the mingw
build.  I've replied to the patch in question with the detailed compiler
message.

Stefan

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLXAKAAoJEJykq7OBq3PIExoIAMTEdV4Tvxi00CXASzv4Gvm0
mC4OfcHax9sFGqE0mp6JDvBVLfnrLruiMTTMxXTUWLwiPgbS5ymI7ZJ1BzQh/iec
yD+B/rPdNvi332miIFiCk9ZBkq3nivqy5yUvimEnmU6XX1nZ0QT9dSxmKtkgIExw
gS5v5Zcr/2UpqVZocqlG3XRw0GWSE/FYi9MRfhD24wpU4ljHnTooDVGAgDdASyY3
mnREAzbUUtRyUENCLRWpjMxdChhpEzyYDAxrEoMPx8HI5ueqIa6sK5YjGIx2FaeL
syyBKJDwYN39WvZNnUb4dGNGTiBxijwgdo9Euo/jRGKc8F2GoAPmqzdVgJqkfaE=
=PNfM
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:35782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1db4s5-0005tR-6G
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:00:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1db4s0-0000Ce-MD
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:00:01 -0400
Date: Fri, 28 Jul 2017 13:59:52 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170728125952.GP12364@stefanha-x1.localdomain>
References: <20170725211523.3998-1-eblake@redhat.com>
	<20170725211523.3998-9-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jXoUnAu9pZeaHebo"
Content-Disposition: inline
In-Reply-To: <20170725211523.3998-9-eblake@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 08/12] qtests: convert
 tests to use qmp_cmd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, "open list:IDE" <qemu-block@nongnu.org>, armbru@redhat.com, stefanha@redhat.com


--jXoUnAu9pZeaHebo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2017 at 04:15:19PM -0500, Eric Blake wrote:
> Now that we have the qmp_cmd() helper, we can further simplify
> some of the tests by using it.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/device-introspect-test.c |  3 +--
>  tests/ide-test.c               |  2 +-
>  tests/libqos/libqos.c          |  5 +++--
>  tests/libqos/pci-pc.c          |  4 ++--
>  tests/libqos/usb.c             | 18 +++++++++---------
>  tests/pc-cpu-test.c            | 10 +++++-----
>  tests/postcopy-test.c          |  9 +++++----
>  tests/vhost-user-test.c        | 12 ++++++------
>  8 files changed, 32 insertions(+), 31 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--jXoUnAu9pZeaHebo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZezVIAAoJEJykq7OBq3PICAQIAL5o7aMX6FjZcVQuNlbTIp40
mzaUA8Hl1rY8qTX7drNH9+S1cqojAMD9P5gBJ1k3esJ77V7K8ftpfHrX9nY/ynDy
VsQgxoJlTnuF8oOotpNrvoHUgALExVI40+ERTIR31BgHq2TZzXysdUjOJYjesv9b
zDS+ukVgDjKXIZqhPH/eZ+MDhqtoa/KRg7iBor3N/REJBqHfExx4qvhMcmUsG7zH
yKshcnidzBPd7P6TeFQr+PbRNeHAoITPYdASMTKJEVV+CgtE/qqvCVWTbMd6x/Wl
YaKrJabFyTMw4nXkbOLI85Wca+/4Q0w//kx2tTTaQokPPdoidQGqqyLE/ApLJOY=
=LnBA
-----END PGP SIGNATURE-----

--jXoUnAu9pZeaHebo--

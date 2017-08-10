Received: from eggs.gnu.org ([2001:4830:134:3::10]:59827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dfkAY-0005yl-Ex
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 05:54:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dfkAX-0005fo-8T
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 05:54:22 -0400
Date: Thu, 10 Aug 2017 10:54:01 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170810095401.GA20945@stefanha-x1.localdomain>
References: <20170809160212.29976-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <20170809160212.29976-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] IDE: Do not flush empty drives
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: P J P <ppandit@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 09, 2017 at 05:02:10PM +0100, Stefan Hajnoczi wrote:
> John Snow is offline until Monday, QEMU 2.10-rc3 is due to be tagged on
> Tuesday, and so I've taken two patches John sent for 2.10 and addressed r=
eview
> comments.
>=20
> Kevin Wolf (1):
>   IDE: test flush on empty CDROM
>=20
> Stefan Hajnoczi (1):
>   IDE: Do not flush empty CDROM drives
>=20
>  hw/ide/core.c    | 10 +++++++++-
>  tests/ide-test.c | 19 +++++++++++++++++++
>  2 files changed, 28 insertions(+), 1 deletion(-)

John: I am sending a pull request to get this fix into -rc3 (Aug 15th).
Feel free to send a follow-up/revert if you want to make changes when
you get back online.

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZjC05AAoJEJykq7OBq3PIjpMH/AvNIzykev+LKhFwTy0okGvr
gpBEZt4Z67rm+PpdjOvfUmfzT4T4NxpzkB9ivko5TwRnI9jZo0ssyK3qLmtvZGGK
HoI09+TKo+4AB1FG7r0eUgHJ/HCnSj/TwBvW/dBQGPqqPdW1CPU/KiS/k+PXq/ze
abh13NSLnsy1xod8PMh8JqKwvL/gfmSoUw8mEj5i8LH95A00E5QotTeaidlyTTXD
y1EPFTM89v2+KHiKTmcLgUWi4MxIU8LiF3f+WnhQl/ZybRQUXdTyzLIcgbPlp3dU
Bu6HLAAj5YpIbdYtX5h4NTzgrqzfhoRcYJqN+4ONvrWtB/adyKL46ZrR14mPrcg=
=kPm6
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:60116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dAe3I-0005sm-Qs
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:06:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dAe3I-00015E-1f
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:06:20 -0400
Date: Tue, 16 May 2017 16:05:59 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170516150559.GN8498@stefanha-x1.localdomain>
References: <20170511144208.24075-1-pbonzini@redhat.com>
	<20170511144208.24075-17-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qYrsQHciA3Wqs7Iv"
Content-Disposition: inline
In-Reply-To: <20170511144208.24075-17-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 16/18] block: protect modification of dirty
 bitmaps with a mutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org


--qYrsQHciA3Wqs7Iv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 11, 2017 at 04:42:06PM +0200, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>         v1->v2: remove bdrv_get_dirty from API [Stefan]
>                 convert block migration from bdrv_get_dirty to _locked [S=
tefan]
>=20
>  block/dirty-bitmap.c         | 68 ++++++++++++++++++++++++++++++++++++++=
------
>  block/mirror.c               | 11 +++++--
>  include/block/block_int.h    |  4 +--
>  include/block/dirty-bitmap.h | 25 +++++++++++-----
>  migration/block.c            | 10 ++++---
>  5 files changed, 94 insertions(+), 24 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--qYrsQHciA3Wqs7Iv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZGxVXAAoJEJykq7OBq3PIJbMH+wTvLdGmw8Jzj+CMdAAuWc+i
UyjERxEsfo80K+qUcFFqzqy6RUkulw74UhszEujEAmdspOdSYtl8usgFZyfEE5bV
hDAPZ8dR4s0N3S4M/OyslVojXdbS0/ez4E6QAB9iEcYhrG2QJsg7INmJN3iXsQL9
m6cIj4/CPZmbgjsWDfeGTCX0J5xxsKuj4aTXnUuu/hFMk/RCbARsKyIym0tATZ1m
Ya+U4QFFq4BSjD5GGh23gRcHXr/EmINXCWOpJWzHKiIntQ/t1FQtdbBcUh32batT
a8uDcTqbT3MTQM8zi7dxUKFrF6/ZRG2EWSA9SWrl2Mh4Op9YfpZFBi/+f0ILtB0=
=b1pA
-----END PGP SIGNATURE-----

--qYrsQHciA3Wqs7Iv--

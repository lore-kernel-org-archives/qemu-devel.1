Received: from eggs.gnu.org ([2001:4830:134:3::10]:37313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dAcpl-0004i6-UK
	for qemu-devel@nongnu.org; Tue, 16 May 2017 09:48:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dAcpl-0000ng-5s
	for qemu-devel@nongnu.org; Tue, 16 May 2017 09:48:18 -0400
Date: Tue, 16 May 2017 14:48:03 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170516134803.GF8498@stefanha-x1.localdomain>
References: <20170511144208.24075-1-pbonzini@redhat.com>
	<20170511144208.24075-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A9z/3b/E4MkkD+7G"
Content-Disposition: inline
In-Reply-To: <20170511144208.24075-6-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/18] block: access wakeup with atomic ops
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


--A9z/3b/E4MkkD+7G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 11, 2017 at 04:41:55PM +0200, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>         v1->v2: add comment [Fam]
>=20
>  block/io.c                | 3 ++-
>  block/nfs.c               | 4 +++-
>  block/sheepdog.c          | 3 ++-
>  include/block/block.h     | 5 +++--
>  include/block/block_int.h | 7 +++++--
>  5 files changed, 15 insertions(+), 7 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--A9z/3b/E4MkkD+7G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZGwMTAAoJEJykq7OBq3PIir0H+wcIX7vptHbsNsoQhBlv+vwl
+Hgip44Z8uH1aos4YBKJlUe6PI+EWKGahAYB27X5QZjbxxpTCiL8Tm9iwKPY6JbB
5nB16Sh8Bh6mXpr3m9RRIbCGg+oWPROyH7KZRuExPE8p3kZNBYGVUSRciNp38NVF
/6E+BAM7+6V0wXHeBZcdWtuVqdndWhhRWxat6dKVtWMYMLfHGN8QIkwOVNQ2Q5n1
+fVUhycFHGfhJ5pOseZLB4VONKB0RMauM7MLkNYBSPH8hB9a4s4xxkud0vFhcTya
UScf5OEMFxatl3pMVqFzZmiPaom6UVJ1mLpCgaEBuRSSwfi4J/Nv+SASsommtKM=
=TiTu
-----END PGP SIGNATURE-----

--A9z/3b/E4MkkD+7G--

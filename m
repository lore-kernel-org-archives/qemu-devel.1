Received: from eggs.gnu.org ([2001:4830:134:3::10]:38577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPUQb-0001UJ-CQ
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 08:19:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPUQW-0004mD-GO
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 08:19:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40620)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cPUQW-0004lW-7n
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 08:19:24 -0500
References: <1483692945-9866-1-git-send-email-kraxel@redhat.com>
	<1483692945-9866-14-git-send-email-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <631582f2-9b54-6c57-5d8d-cc04a0399aa9@redhat.com>
Date: Fri, 6 Jan 2017 07:19:21 -0600
MIME-Version: 1.0
In-Reply-To: <1483692945-9866-14-git-send-email-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jhg8sgUDBsh3ljSSCowCFL6NH2rnHU2Bp"
Subject: Re: [Qemu-devel] [PATCH 13/17] wctablet: drop DPRINTF,
 add trace events instead
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: avg.tolik@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jhg8sgUDBsh3ljSSCowCFL6NH2rnHU2Bp
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: avg.tolik@gmail.com
Message-ID: <631582f2-9b54-6c57-5d8d-cc04a0399aa9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 13/17] wctablet: drop DPRINTF, add trace
 events instead
References: <1483692945-9866-1-git-send-email-kraxel@redhat.com>
 <1483692945-9866-14-git-send-email-kraxel@redhat.com>
In-Reply-To: <1483692945-9866-14-git-send-email-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/06/2017 02:55 AM, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  Makefile.objs         |  1 +
>  backends/trace-events |  8 ++++++++
>  backends/wctablet.c   | 18 +++++++-----------
>  3 files changed, 16 insertions(+), 11 deletions(-)
>  create mode 100644 backends/trace-events

Is this worth squashing into 1/17? It would be less churn, but then
diverges more from the original author's patch.


> =20
> -#define DEBUG_WCTABLET_MOUSE
> -
> -#ifdef DEBUG_WCTABLET_MOUSE
> -#define DPRINTF(fmt, ...) \
> -do { fprintf(stderr, fmt , ## __VA_ARGS__); } while (0)
> -#else
> -#define DPRINTF(fmt, ...) \
> -do {} while (0)
> -#endif

I ask because I wonder if we should even (if only temporarily) have this
poor style of DPRINTF in the tree, compared to a version not prone to
bitrot (see my comments on patch 1).

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--jhg8sgUDBsh3ljSSCowCFL6NH2rnHU2Bp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYb5lZAAoJEKeha0olJ0Nqq7QH/2bnijLE+bDwWelpcWPb2MZL
UM6MsTynJagYY27koWh0Ql00gRMASPXRUf2an+QDHnbOI9tI+p+8RVRABRaJhDP/
9c5GHseEJXlyFr/0k05ccjTdsAXGCl5i4ZYmmVhfNQNnRwCDbLsuyQzJhhFoG1Km
XKPCEmzSR0dWhhcUdoN4VuLNReCo720fV94m+EeoCEUyc3mxhQzdhZ4ujeJWVS5n
LxuabyD6C1g+dT1hxNoIzL3ODe3d7DjodwcxqXRVq1Xu3dC4iTPB8pqVaOJbOr7Z
LgntcNckS8L1lIDrbueFbY0xRDBvx+GG4U3Mr9QYwKqMYw2HgZXxDs4tCBNNN+A=
=Lpxg
-----END PGP SIGNATURE-----

--jhg8sgUDBsh3ljSSCowCFL6NH2rnHU2Bp--

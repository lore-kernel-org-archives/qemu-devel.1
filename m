Received: from eggs.gnu.org ([2001:4830:134:3::10]:34953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgXa5-0001Ps-S1
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:07:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgXa4-0000nr-VF
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:07:45 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-18-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b72cc2cd-73f5-108d-cc5d-4a6ac10b829c@redhat.com>
Date: Wed, 22 Feb 2017 15:07:35 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-18-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3JqN4r14voap8aLCDPSr7g204drgnm3x4"
Subject: Re: [Qemu-devel] [PATCH 17/54] block: Request child permissions in
 filter drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3JqN4r14voap8aLCDPSr7g204drgnm3x4
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <b72cc2cd-73f5-108d-cc5d-4a6ac10b829c@redhat.com>
Subject: Re: [PATCH 17/54] block: Request child permissions in filter drivers
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-18-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-18-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> All callers will have to request permissions for all of their child
> nodes. Block drivers that act as simply filters can use the default
> implementation of .bdrv_child_perm().
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/blkdebug.c    | 2 ++
>  block/blkreplay.c   | 1 +
>  block/blkverify.c   | 1 +
>  block/quorum.c      | 2 ++
>  block/raw-format.c  | 1 +
>  block/replication.c | 1 +
>  6 files changed, 8 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--3JqN4r14voap8aLCDPSr7g204drgnm3x4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlitmycSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AaogH/jyhNf/QGtYVSck3KDytTryqJHJ/j7Oz
rHfS6rFzZ51arA6PINMrC3SkVkf+lzuChZVnh8FhrgCvUe9CWI8AdNM4xN1lQ3aQ
WpBU367kVziIx2bupLRw3hDAWfVIeCm0IvnTeiAwSMbYEWwvkmF82IQM/wFUi5OK
Wdg4Ws2L2gO6Z5umIaA04kB/0uKlN7rWFCEY/tBNWT8KBCsbJBDXWyEm9s2Lkk7d
X1M1quwv5Ao3okDldhSH8XBAPD1i0LAuTMsGKX6vVN2cuUc2JT+igAy9AbvdiBOU
rnXYGKR286Pe89KHNsK4w4jEPH83/mFAlZh8tM/e9sUFDFFTy1kmRDc=
=+ozY
-----END PGP SIGNATURE-----

--3JqN4r14voap8aLCDPSr7g204drgnm3x4--

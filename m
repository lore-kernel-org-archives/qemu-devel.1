Received: from eggs.gnu.org ([2001:4830:134:3::10]:38651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cbEfz-0006d4-TX
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 17:55:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cbEfy-0007aJ-TG
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 17:55:55 -0500
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
	<20170203154757.36140-9-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4cfafc14-f9af-f992-b0be-8f283d0ddcfa@redhat.com>
Date: Tue, 7 Feb 2017 16:55:45 -0600
MIME-Version: 1.0
In-Reply-To: <20170203154757.36140-9-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KuqDe2AuKAtSSjLktCXvlIMARP6DxVj9I"
Subject: Re: [Qemu-devel] [PATCH 08/18] hbitmap: add next_zero function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, armbru@redhat.com, den@virtuozzo.com, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KuqDe2AuKAtSSjLktCXvlIMARP6DxVj9I
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 pbonzini@redhat.com, armbru@redhat.com, den@virtuozzo.com,
 stefanha@redhat.com
Message-ID: <4cfafc14-f9af-f992-b0be-8f283d0ddcfa@redhat.com>
Subject: Re: [PATCH 08/18] hbitmap: add next_zero function
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
 <20170203154757.36140-9-vsementsov@virtuozzo.com>
In-Reply-To: <20170203154757.36140-9-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/03/2017 09:47 AM, Vladimir Sementsov-Ogievskiy wrote:
> The function searches for next zero bit.
> Also add interface for BdrvDirtyBitmap.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/dirty-bitmap.c         |  5 +++++
>  include/block/dirty-bitmap.h |  2 ++
>  include/qemu/hbitmap.h       |  8 ++++++++
>  util/hbitmap.c               | 26 ++++++++++++++++++++++++++
>  4 files changed, 41 insertions(+)
>=20

It would be nice to enhance the testsuite to cover hbitmap_next_zero().

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--KuqDe2AuKAtSSjLktCXvlIMARP6DxVj9I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYmlBxAAoJEKeha0olJ0Nqk6sH/3SkfImEftzppDWXr66DzHnB
490kItKX21B8SMQGGu5OAN1httPoVpZoi+XasqF20FycYeHz7O1IzjM44jX0V/QV
Q8BKDhDSvPqEw2pVP/J2aPQ2KEZqiWga/Ham81OraBr9SUSo8ESCGGjseykCUuD1
S7lC6HapZiK5Gzod3wAatWmMtgH10Dcf4dWx3BN9zqsh++gWXlCT7DAUR8ZvxnX/
Uad1Dt2e4r4VYOOEmk8lU+SePoW7ksty32b1MgpCqDEoMiJkVgGIkDtCU1Rigmfm
MFqbaOyO4GDfRUFLk83Y2fGlWpfFaq9fDFZKfGTvEt7JsbkihH/W0VRSd67GBfI=
=Z91D
-----END PGP SIGNATURE-----

--KuqDe2AuKAtSSjLktCXvlIMARP6DxVj9I--

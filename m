Received: from eggs.gnu.org ([2001:4830:134:3::10]:43337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cguus-0002hh-K6
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:02:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cguun-0001HS-U5
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:02:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cguun-0001H1-Ma
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:02:41 -0500
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
	<148760161575.31154.505252736798591155.stgit@bahia.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2e9357a4-34ad-9cc1-db39-5ed00bdc015d@redhat.com>
Date: Thu, 23 Feb 2017 09:02:39 -0600
MIME-Version: 1.0
In-Reply-To: <148760161575.31154.505252736798591155.stgit@bahia.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9qNbGs58hjKJ8JxoUuQAl6hsfmRiEGES0"
Subject: Re: [Qemu-devel] [PATCH 07/29] 9pfs: local: introduce
 symlink-attack safe xattr helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Jann Horn <jannh@google.com>, Prasad J Pandit <prasad@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9qNbGs58hjKJ8JxoUuQAl6hsfmRiEGES0
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Jann Horn <jannh@google.com>, Prasad J Pandit <prasad@redhat.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <2e9357a4-34ad-9cc1-db39-5ed00bdc015d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 07/29] 9pfs: local: introduce symlink-attack
 safe xattr helpers
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
 <148760161575.31154.505252736798591155.stgit@bahia.lan>
In-Reply-To: <148760161575.31154.505252736798591155.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/20/2017 08:40 AM, Greg Kurz wrote:
> All operations dealing with extended attributes are vulnerable to symli=
nk
> attacks because they use path-based syscalls which can traverse symboli=
c
> links while walking through the dirname part of the path.
>=20
> The solution is to introduce helpers based on opendir_nofollow(). This
> calls for "at" versions of the extended attribute syscalls, which don't=

> exist unfortunately. This patch implement them by simulating the "at"
> behavior with fchdir(). Since the current working directory is process
> wide, and we don't want to confuse another thread in QEMU, all the work=

> is done in a separate process.

Can you emulate *at using /proc/fd/nnn/xyz?  Coreutils was one of the
early adopters of the power of *at functions, and found that emulation
of *at via procfs was a LOT more efficient than emulation via fchdir
(although both emulations still exist in gnulib, since procfs is not
universal).

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--9qNbGs58hjKJ8JxoUuQAl6hsfmRiEGES0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYrvmPAAoJEKeha0olJ0Nq8g0IAKBJAS+y//UDWsMFLqboZXoj
PG8/KRlSZCaNWzuhiRTE1a/P/pT0ld+4NGZ2K+eXHWPBelr6UrvYO17Fs3ZnC+gY
RLDMisT96C85xgTOFmjmi2DIGHX/73Hs1J8A/yIzTe8m90hQcvs/wpX1tEH2ISod
/GrAZ2EnTPovn+GIu9YrYzBBzkBhhTmoLve/1sjC4G+Rl84JlSpCzbdhsHQKazzw
QQcTd//bvEh0QlQxVBKoPEvOKKrywntXau0BzMT2vXYin7P9wmja3v9Lw7SWewEF
FosTbHm59m7o06VPI7ULGJLJuCVca41kpTZ6NUhas6gSjVeLU8ZsCM1MyFwyZEs=
=l6fp
-----END PGP SIGNATURE-----

--9qNbGs58hjKJ8JxoUuQAl6hsfmRiEGES0--

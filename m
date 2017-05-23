Received: from eggs.gnu.org ([2001:4830:134:3::10]:47215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDAu4-0004vF-Uc
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:35:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDAu0-0000qY-TX
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:35:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dDAu0-0000q0-KZ
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:35:12 -0400
References: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3768e2ea-9333-750f-0228-1014863223b1@redhat.com>
Date: Tue, 23 May 2017 09:35:08 -0500
MIME-Version: 1.0
In-Reply-To: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tbwOAHwVQcc02j3RQcNHvcDm6nSDELArh"
Subject: Re: [Qemu-devel] [PATCH v1 00/13] qcow2: space preallocation and
 COW improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@virtuozzo.com, mreitz@redhat.com, Alberto Garcia <berto@igalia.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tbwOAHwVQcc02j3RQcNHvcDm6nSDELArh
From: Eric Blake <eblake@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@virtuozzo.com, mreitz@redhat.com,
 Alberto Garcia <berto@igalia.com>
Message-ID: <3768e2ea-9333-750f-0228-1014863223b1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 00/13] qcow2: space preallocation and COW
 improvements
References: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/19/2017 04:34 AM, Anton Nefedov wrote:
> This pull request is to address a few performance problems of qcow2 for=
mat:
>=20
>   1. non cluster-aligned write requests (to unallocated clusters) expli=
citly
>     pad data with zeroes if there is no backing data. This can be avoid=
ed
>     and the whole clusters are preallocated and zeroed in a single
>     efficient write_zeroes() operation, also providing better host file=

>     continuity
>=20
>   2. moreover, efficient write_zeroes() operation can be used to preall=
ocate
>     space megabytes ahead which gives noticeable improvement on some st=
orage
>     types (e.g. distributed storages where space allocation operation i=
s
>     expensive)
>=20
>   3. preallocating/zeroing the clusters in advance makes possible to en=
able
>     simultaneous writes to the same unallocated cluster, which is benef=
icial
>     for parallel sequential write operations which are not cluster-alig=
ned
>=20
> Performance test results are added to commit messages (see patch 3, 12)=


And now Berto has posted parallel patches. I'm not sure which ones to
focus on, or if you can work it out between you on the best approach
forward...

https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg05236.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--tbwOAHwVQcc02j3RQcNHvcDm6nSDELArh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZJEicAAoJEKeha0olJ0NqtWMH/3vdDPwc5L6ywkEyJQafn2UI
m9mhGi3208xlndogCH0bjGSmWrA8tZpjBEp6IAJrXfWjd89OA2fK4LMUzBAsTzdy
MxTlMtB3e7AloR52l8CJ71OdDXQuCV8O4v5m5FNsDkFI87XTs7rS4cKC5nyiuP3h
zdpB+luSUUFqQE8Xp1NbEderEx/M0qhoeEDOtvAM6jsv6nV7P2kBc0rBDzG3AUjj
tr4w1IMjH7/ebinGpgaLczPxWyxz3P0L5SnHG/U1dEOpp1Rj9c9shPUukW5DXIuE
DZHWXzZSmRnkMWsVz6h3qhlqAqFwTCS0nfnVEb9VMMlPT6VcROeMtFJ3lBJ9p6I=
=36TM
-----END PGP SIGNATURE-----

--tbwOAHwVQcc02j3RQcNHvcDm6nSDELArh--

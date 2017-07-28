Received: from eggs.gnu.org ([2001:4830:134:3::10]:50323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1db41E-0000fF-0G
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:05:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1db41C-0007rU-Kq
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:05:23 -0400
References: <20170606162652.112122-1-vsementsov@virtuozzo.com>
	<20170606162652.112122-2-vsementsov@virtuozzo.com>
	<50f19b1d-9736-b8b3-5616-67c3393336f3@redhat.com>
	<7c610bc7-a4f7-e6d6-2464-7bbb1b24002b@virtuozzo.com>
	<26ba2b60-5135-d509-b3bc-392152a8bf0a@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <499609a4-79d4-f990-c312-048fd1f78ab8@redhat.com>
Date: Fri, 28 Jul 2017 07:05:09 -0500
MIME-Version: 1.0
In-Reply-To: <26ba2b60-5135-d509-b3bc-392152a8bf0a@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jdG7ju20cxsPCve3R0viOkFBt8TFjBhDa"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 1/3] block: add
 bdrv_get_format_alloc_stat format interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jdG7ju20cxsPCve3R0viOkFBt8TFjBhDa
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com, den@openvz.org
Message-ID: <499609a4-79d4-f990-c312-048fd1f78ab8@redhat.com>
Subject: Re: [Qemu-block] [PATCH v3 1/3] block: add bdrv_get_format_alloc_stat
 format interface
References: <20170606162652.112122-1-vsementsov@virtuozzo.com>
 <20170606162652.112122-2-vsementsov@virtuozzo.com>
 <50f19b1d-9736-b8b3-5616-67c3393336f3@redhat.com>
 <7c610bc7-a4f7-e6d6-2464-7bbb1b24002b@virtuozzo.com>
 <26ba2b60-5135-d509-b3bc-392152a8bf0a@redhat.com>
In-Reply-To: <26ba2b60-5135-d509-b3bc-392152a8bf0a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/27/2017 04:23 PM, John Snow wrote:

>>>
>>> "Allocations may be considered either used or unused by the format
>>> driver interpreting those allocations. It is at the discretion of the=

>>> format driver (e.g. qcow2) which regions of its backing storage are
>>> considered in-use or not."
>>
>> So we are saying about "allocations". But unallocated data may be
>> used/unused too, so,
>> can we call unallocated areas "allocations"?
>>
>=20
> You're right, "allocation" may imply something that is extant, but thes=
e
> are more like regions ...

Even 'extent' might have a connotation of something reserved; other
related words like 'block' are bad (a block of a block device?).

>=20
> Uh;
>=20
> "Regions" may be considered either used or unused?
>=20
> or
>=20
> "Regions of the underlying protocol file may be considered used or
> unused by the format driver interpreting these regions."

So this is one of the better variations I've seen, and works for me.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--jdG7ju20cxsPCve3R0viOkFBt8TFjBhDa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll7KHUACgkQp6FrSiUn
Q2qKTwgAh2j7AYtC4iPU1XQUjiRH+X0OIAWu2bU66oA5uduJjDxahfte1srHA9El
4qDEaMe/V2WIcJHPvgtCcxnuqYSd6EDgRUsLfh87SXm8bYOQVdcgpljpPd+roxmz
IXZFKo017PkL3LGF68TUDREaWRBV05KSIvfR0hffwOrKg61aGZL18zkIHq4vmrZn
ekl2uNYwoEA197hXx3uOHH1vFn75hPj7tTPKxtxEM+9WhVFhCu8XbMUTr97b+GJb
r7CvYzUHWNRmPpglM2kIsdP/ptDyNukMcRdjTvQTuVTN45Oq/XRd3qLdoPGKyRSQ
g8Ny4txVvT0qv3puv0sb+CItsaadIg==
=xIRZ
-----END PGP SIGNATURE-----

--jdG7ju20cxsPCve3R0viOkFBt8TFjBhDa--

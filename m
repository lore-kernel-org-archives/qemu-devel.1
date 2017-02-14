Received: from eggs.gnu.org ([2001:4830:134:3::10]:42659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cdisb-0001qw-Ni
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 14:35:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cdisa-0000rJ-Is
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 14:35:13 -0500
References: <1487083704-51658-1-git-send-email-vsementsov@virtuozzo.com>
	<20170214150539.GC20715@lemon.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <244acac1-4179-42d3-35c8-847539c2c244@redhat.com>
Date: Tue, 14 Feb 2017 13:35:05 -0600
MIME-Version: 1.0
In-Reply-To: <20170214150539.GC20715@lemon.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0qqxaFUCnnvrxQcuv69GExBtigfTWgXWV"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] backup: allow target without
 .bdrv_get_info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0qqxaFUCnnvrxQcuv69GExBtigfTWgXWV
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Message-ID: <244acac1-4179-42d3-35c8-847539c2c244@redhat.com>
Subject: Re: [Qemu-block] [PATCH] backup: allow target without .bdrv_get_info
References: <1487083704-51658-1-git-send-email-vsementsov@virtuozzo.com>
 <20170214150539.GC20715@lemon.lan>
In-Reply-To: <20170214150539.GC20715@lemon.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/14/2017 09:05 AM, Fam Zheng wrote:
>> Proposed NBD protocol extension - NBD_OPT_INFO should finally solve th=
is problem.
>> But until it is not realized, we need allow backup to nbd target due t=
o backward
>> compatibility.
>>
>> Furthermore, is it entirely ok to disallow backup if bds lacks .bdrv_g=
et_info?
>> Which behavior should be default: to fail backup or to use default clu=
ster size?
>>

>=20
> Target not having .bdrv_get_info means 'some sane assumptions are okay'=
 to me, so
>=20
> Reviewed-by: Fam Zheng <famz@redhat.com>
>=20
> (But we are going to have a .bdrv_get_info after NBD_OPT_INFO, right?)

Yes. I'm reposting that series today.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--0qqxaFUCnnvrxQcuv69GExBtigfTWgXWV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYo1vpAAoJEKeha0olJ0NqI1wH/2U3evCClDvQ4DDrkywD5zWr
HZ72eyvLtXv//eZrMTddeUw0BhNujcJ73noGuUL0jZkwpy+vuW8/N2mDhM7pNpqO
abA9nVyn6COtYnChcxfejRTWSNccwnsHNk+A2kWho61alx589gyL5vRzxaQg63v4
hfAgGtbqbTppVpDFcDlffB26AQ5XX1MfttD9kyGyqUhP03fZzkKnQHgHSGjNd57h
p8ZnMmxbnmrYbwE93fVO3+qNc1+Y+1ohsbx7HZrZQx+hpJKbawT4olZDBuDsvj7s
0iyg0s6mcNJ4s+czylxHPFKd2TelnCDciVFKmY8lnEPynUDQ4HEUWlH9wum9zzM=
=52vD
-----END PGP SIGNATURE-----

--0qqxaFUCnnvrxQcuv69GExBtigfTWgXWV--

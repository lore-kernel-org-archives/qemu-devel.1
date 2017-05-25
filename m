Received: from eggs.gnu.org ([2001:4830:134:3::10]:41891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDwqf-0006bM-L1
	for qemu-devel@nongnu.org; Thu, 25 May 2017 13:46:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDwqe-0005Ar-L6
	for qemu-devel@nongnu.org; Thu, 25 May 2017 13:46:57 -0400
References: <20170525152628.37628-1-vsementsov@virtuozzo.com>
	<20170525152628.37628-2-vsementsov@virtuozzo.com>
	<3fdd3178-89d7-2819-d040-1e5132d655ec@redhat.com>
	<28332b32-f9e8-d426-9b54-d46e5774366c@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7f22ab2c-e87a-ac26-fe47-7ba0068762c8@redhat.com>
Date: Thu, 25 May 2017 12:46:46 -0500
MIME-Version: 1.0
In-Reply-To: <28332b32-f9e8-d426-9b54-d46e5774366c@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GxqhFtw71sbLx2XHFn8xCCWJvBCJX5oho"
Subject: Re: [Qemu-devel] [PATCH 1/7] block: fix comment for
 bdrv_get_allocated_file_size()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GxqhFtw71sbLx2XHFn8xCCWJvBCJX5oho
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Message-ID: <7f22ab2c-e87a-ac26-fe47-7ba0068762c8@redhat.com>
Subject: Re: [PATCH 1/7] block: fix comment for bdrv_get_allocated_file_size()
References: <20170525152628.37628-1-vsementsov@virtuozzo.com>
 <20170525152628.37628-2-vsementsov@virtuozzo.com>
 <3fdd3178-89d7-2819-d040-1e5132d655ec@redhat.com>
 <28332b32-f9e8-d426-9b54-d46e5774366c@virtuozzo.com>
In-Reply-To: <28332b32-f9e8-d426-9b54-d46e5774366c@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/25/2017 12:03 PM, Vladimir Sementsov-Ogievskiy wrote:
> 25.05.2017 19:32, Eric Blake wrote:
>> On 05/25/2017 10:26 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> Current comment is not clear enough: which sparseness is meant, comin=
g
>>> from sparse image format or from sparse file system?
>>>
>>> For example, if we have qcow2 above raw file on non-sparse file syste=
m,
>>> this function will say nothing about unallocated (by qcow2 layer)
>>> clusters.
>>>

>>> + * Size of allocated in underlying file system area. Sparseness is
>>> taken into
>> Doesn't read well.  Maybe: s/Size of allocated/Allocation size/ ?
>>
>>> + * account for sparse file systems. Return < 0 if error or unknown.
>> I still don't get what we are trying to present.
>>

>>
>> I think we still need to do a better job at writing a precise comment.=

>>
>=20
> bdrv_get_allocated_file_size is not related to qcow2, as qcow2 doesn't
> support it. So, it is finally just raw_get_allocated_file_size, which
> returns st.st_blocks * 512 after fstat(s->fd).
>=20
> It will correspond to qcow2 sparseness if qcow2 discarded corresponding=

> clusters in bs->file and if underlying fs is sparse.

Okay, that helps.  How about this wording:

Allocation size of the underlying file system area.  Sparseness is taken
into account (holes do not contribute to this size).  Return < 0 if
error or unknown.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--GxqhFtw71sbLx2XHFn8xCCWJvBCJX5oho
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZJxiGAAoJEKeha0olJ0Nq6TYH+wd7k9Tl2lhre9FPETUDDEZE
HJC12Lt+WilZoW+2OIVOTw5+ufBHKoAJmX+SxlUf+PrEAdpCoBT5xyXfklr2gdIT
cs+6JYFoi7ziM5giFRsHtMpvfrppquf8ZASw9NWjdgtpvtY1sLiG9+y/PxLc68Se
vj/TXsKGafv/yXCX+GMjNMEa69L2yWoWRwmOWXguuNn1OVPMdeIubTBYUITHsQgc
Utb8JCb9kr2uj2rbPoo12VDhB8QyuCi9mWuXs7uaZELwUVNCelsdmMmtRozbrbja
t5tikTltDDvhUgL6cOl1k3uFooKqvIjTS80hQnVoaW6888UHp1+eSUe7QLQLEHs=
=oqad
-----END PGP SIGNATURE-----

--GxqhFtw71sbLx2XHFn8xCCWJvBCJX5oho--

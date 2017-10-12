Received: from eggs.gnu.org ([2001:4830:134:3::10]:50059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2dXV-0007WQ-7T
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:28:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2dXU-0006Aa-84
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:28:41 -0400
References: <150780535623.288.12272299760364683981@b58463cdfd5f>
	<da4434ac-e912-172e-7d04-af09e11f813a@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <12b1ce4d-ce89-e2f4-e6fb-e057c6377972@redhat.com>
Date: Thu, 12 Oct 2017 08:28:29 -0500
MIME-Version: 1.0
In-Reply-To: <da4434ac-e912-172e-7d04-af09e11f813a@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KQvMDeqONGw8IjjOs5TjgRdlOwDkbLad2"
Subject: Re: [Qemu-devel] [PATCH v3 00/13] nbd minimal structured read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KQvMDeqONGw8IjjOs5TjgRdlOwDkbLad2
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <12b1ce4d-ce89-e2f4-e6fb-e057c6377972@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 00/13] nbd minimal structured read
References: <150780535623.288.12272299760364683981@b58463cdfd5f>
 <da4434ac-e912-172e-7d04-af09e11f813a@virtuozzo.com>
In-Reply-To: <da4434ac-e912-172e-7d04-af09e11f813a@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/12/2017 06:15 AM, Vladimir Sementsov-Ogievskiy wrote:
> This is a code movement, no changes.
>=20

>> Checking PATCH 11/13: nbd: share some nbd entities to be reused in
>> block/nbd-client.c...
>> ERROR: return of an errno should typically be -ve (return -EPERM)
>> #46: FILE: include/block/nbd.h:206:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return EPERM;

Indeed.  We could avoid the false positive by doing:

case ...:
    ret =3D EPERM;
    break;
=2E..
return ret;

to hide the positive errno value, but I'm also fine ignoring checkpatch
on this one.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--KQvMDeqONGw8IjjOs5TjgRdlOwDkbLad2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnfbf4ACgkQp6FrSiUn
Q2oRtQf/T3XZBxjAKdKUu9tK8yfpLkLLmeJJfk1wkJ6eLMg9RlNa4a1WcDd1DTbp
olU0Q29aTDkAnaBsLYr99WJm8CdZhIxy4/KN9h94sY0jQlTwzoIiiY613hv/bEnw
vlcEefUJ05U7BMRytNbFyHOKTb9+MHukdwUineXdGha6f7fIuDmudzp2h1d0lZgK
r7IFbXYvU7ytHqsjhRD6t0IMXzFaxGd2z0/IUXb+T7UIMx9e6Le4K1/KqIIZ2NzD
Q30/mMEIT9E/6wQRufdbddpYY4DaTK8rCIg0/whgTybtNMQVnR5NuErzYSE6AvNo
2yqni0/MZQUefD/ulccvTafFEXkaLA==
=Nn5D
-----END PGP SIGNATURE-----

--KQvMDeqONGw8IjjOs5TjgRdlOwDkbLad2--

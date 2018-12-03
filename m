Received: from eggs.gnu.org ([2001:4830:134:3::10]:37965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gTolW-0003O4-9Y
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:00:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gTolU-0005Mu-Dk
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:00:02 -0500
References: <20181129101801.6421-1-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <da28be03-4e8a-c75f-8bfa-35e24ad14cca@redhat.com>
Date: Mon, 3 Dec 2018 14:59:40 +0100
MIME-Version: 1.0
In-Reply-To: <20181129101801.6421-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Plhjxc5pXWIfGPPnql7tkr1TMPY7lZ3Bc"
Subject: Re: [Qemu-devel] [PATCH v2 0/2] mirror dead-lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, pbonzini@redhat.com, dplotnikov@virtuozzo.com, den@openvz.org, qemu-stable@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Plhjxc5pXWIfGPPnql7tkr1TMPY7lZ3Bc
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, pbonzini@redhat.com,
 dplotnikov@virtuozzo.com, den@openvz.org, qemu-stable@nongnu.org
Message-ID: <da28be03-4e8a-c75f-8bfa-35e24ad14cca@redhat.com>
Subject: Re: [PATCH v2 0/2] mirror dead-lock
References: <20181129101801.6421-1-vsementsov@virtuozzo.com>
In-Reply-To: <20181129101801.6421-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.11.18 11:17, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
>=20
> v2: add fix:)
>=20
> We've faced the following mirror bug:
>=20
> Just run mirror on qcow2 image more than 1G, and qemu is in dead lock.

So because apparently there is going to be an rc4 anyway (like basically
always...), I'd really like to bring this fix into it, unless there are
any objections from anyone (though all of you are more than welcome to
explicitly agree, too :-)).

Do you have any plans for the iotest?  Right now, I'd rather just take
patch 1 as-is and add the test later, but then again, adding a patch for
rc4 without a test is not so nice either, I suppose.

Max


--Plhjxc5pXWIfGPPnql7tkr1TMPY7lZ3Bc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlwFNswACgkQ9AfbAGHV
z0Cx1QgAuX8dXPQpkQmQ/lz7IRRhSfeP4ODLud9NzX9z/CHU5XkMNO+NfGmyV9mu
JwixfcaU8pVNcJy+nPdYtEMPf+9xroQDbAvMsBjqOqsRWmolZhnek99rC2lc+FBR
PzvbU/RSulxaEooP46dqhQLhlvSBHHJ92nekxFwDdo04hdHwmWIcHC25RYMRQHqp
+2VGHY/N3B8Ll3r1MzP57bZse7P0Lg1rpfsiSyi2IbzD5TCUNx1JUOVBltyaLh3g
QgEJS0MnQsP9nD9EmSXGheaUrNt6Nc0xUdwT8wGRphVJu5hzSTwFUoVcxFvMjOit
Bk6FKAKHrHKfTy+fA4YF/sLsUu/uwQ==
=apmr
-----END PGP SIGNATURE-----

--Plhjxc5pXWIfGPPnql7tkr1TMPY7lZ3Bc--

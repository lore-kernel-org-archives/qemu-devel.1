Received: from eggs.gnu.org ([2001:4830:134:3::10]:58956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1df8I6-0001Oy-Uk
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 13:27:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1df8I5-0006GK-No
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 13:27:38 -0400
References: <20170807141630.105066-1-vsementsov@virtuozzo.com>
	<20170807155717.GI6578@localhost.localdomain>
	<692a163e-acce-e594-896d-da96b7a099e9@virtuozzo.com>
	<20170808085352.GF4850@dhcp-200-186.str.redhat.com>
	<896f8482-6e3a-13e9-4cce-ca115a6c8881@virtuozzo.com>
	<645f5e9d-6a4b-1d7b-6907-6ab27e1ffa7e@virtuozzo.com>
	<51899b88-6b4b-88ce-f820-f62bc944c034@redhat.com>
	<2983bfe2-0646-2a50-0025-0211c4725f63@virtuozzo.com>
	<20170808151600.GN4850@dhcp-200-186.str.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1d6823a2-a459-6dc8-428b-b5d0fee3db39@redhat.com>
Date: Tue, 8 Aug 2017 12:27:25 -0500
MIME-Version: 1.0
In-Reply-To: <20170808151600.GN4850@dhcp-200-186.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QFgKBc8KasD3LbbuAnodtEoE1o4a2D836"
Subject: Re: [Qemu-devel] [PATCH] iotests: fix 185
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: jsnow@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QFgKBc8KasD3LbbuAnodtEoE1o4a2D836
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: jsnow@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Message-ID: <1d6823a2-a459-6dc8-428b-b5d0fee3db39@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: fix 185
References: <20170807141630.105066-1-vsementsov@virtuozzo.com>
 <20170807155717.GI6578@localhost.localdomain>
 <692a163e-acce-e594-896d-da96b7a099e9@virtuozzo.com>
 <20170808085352.GF4850@dhcp-200-186.str.redhat.com>
 <896f8482-6e3a-13e9-4cce-ca115a6c8881@virtuozzo.com>
 <645f5e9d-6a4b-1d7b-6907-6ab27e1ffa7e@virtuozzo.com>
 <51899b88-6b4b-88ce-f820-f62bc944c034@redhat.com>
 <2983bfe2-0646-2a50-0025-0211c4725f63@virtuozzo.com>
 <20170808151600.GN4850@dhcp-200-186.str.redhat.com>
In-Reply-To: <20170808151600.GN4850@dhcp-200-186.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/08/2017 10:16 AM, Kevin Wolf wrote:

>>>> is sleep for ms portable?
>>> Sadly, sub-second sleep is a GNU coreutils feature; I suspect the BSD=

>>> machines may fail to parse it.  (Of course, we could do some sort of
>>> 'sleep $SMALL', where $SMALL is 0.5 if sleep supports it, and 1 other=
wise).
>>>
>> sleep for 1 second may lead to more then one request done before qemu =
quite.
>=20
> _supported_os Linux
>=20
> So do we really care about portability? And are all the other test case=
s
> working on the BSDs?

You've got valid points there - I suspect that a run of qemu-iotests on
BSD would turn up quite a few failures, some of which would be easy to
address; but it's not on my personal priority list.  I'm fine with an
approach of committing something that works where it was first tested,
then adding followup patches to improve portability, especially as long
as we are not currently getting anyone complaining about qemu-iotests
failures on BSD.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--QFgKBc8KasD3LbbuAnodtEoE1o4a2D836
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmJ9H0ACgkQp6FrSiUn
Q2pmbwf/RWG/oGNL0XXs3lkMI2zdJUt4pTXoOnX3M3iVEoPOVpo/w6M54CfOf+OC
UPpKfp65r+T0cbwZCn6gRZlzp1VajnJjYnT+1XA/6aai8ESGl3oxm7OAz468HRK3
KqN9HbIz29novdqhNY4IsNh2KvAz/2mO6oMPiTmj2mOWDd4DaB0SvbEMBkPpoZyj
niM8iC2eFdOYlIHrZwKGF1XB4kj++tigOIuaBRkVdo0UVQPpoXY1hsRHcgPVb9K1
Da/q2bkpZbLRxo3SUP1kQNPdYBJ9wS2+Z86B+5MdiXjJ2Fnkgxj0x4IiVB/Nvj4W
N6VBvo7SLVw0aDG623b0Ildt3+OxCQ==
=rU3t
-----END PGP SIGNATURE-----

--QFgKBc8KasD3LbbuAnodtEoE1o4a2D836--

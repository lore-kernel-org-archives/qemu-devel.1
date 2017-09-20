Received: from eggs.gnu.org ([2001:4830:134:3::10]:50877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duihi-0004Gd-Sz
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:22:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duihh-00059W-Vs
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:22:30 -0400
References: <20170920124507.18841-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cb6364bf-2a67-6eea-b69e-2c267a4de4fa@redhat.com>
Date: Wed, 20 Sep 2017 12:22:24 -0500
MIME-Version: 1.0
In-Reply-To: <20170920124507.18841-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="L0vGvkWgjCOBW0mRuNvb1TqwXN2jbsC2E"
Subject: Re: [Qemu-devel] [PATCH v3 0/3] nbd client refactoring and fixing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--L0vGvkWgjCOBW0mRuNvb1TqwXN2jbsC2E
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <cb6364bf-2a67-6eea-b69e-2c267a4de4fa@redhat.com>
Subject: Re: [PATCH v3 0/3] nbd client refactoring and fixing
References: <20170920124507.18841-1-vsementsov@virtuozzo.com>
In-Reply-To: <20170920124507.18841-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/20/2017 07:45 AM, Vladimir Sementsov-Ogievskiy wrote:
> v3: dropped all controversial things. I'll try to implement minimal
> structured reply and block status over this small residue.
>=20
> Vladimir Sementsov-Ogievskiy (3):
>   block/nbd-client: refactor nbd_co_receive_reply
>   block/nbd-client: simplify check in nbd_co_receive_reply
>   block/nbd-client: nbd_co_send_request: fix return code

Thanks; queued on my NBD tree, will send pull request after a bit more
time to see if it collects further reviews:
git://repo.or.cz/qemu/ericb.git nbd

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--L0vGvkWgjCOBW0mRuNvb1TqwXN2jbsC2E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnCo9AACgkQp6FrSiUn
Q2p/Vgf/cgD2BPvIlU71UJOOUisPtBQmOTuBmKioEiqr5D6pH405XTrEmlbMk/U8
5oux1/VCfFyEbuYiCqqlK6JPYA/QhDEw9OBY3Lb0gzHCJqI9gCL9sLddH3zvC4Zg
vMxE7p4JaPOtA4UDnYqWjnMNQxuVK0E4o7c5yqqv2Yl+1NqoVjZl5ZWmzQVtteX3
pm4NilESqpcFhMFbbBs4qap7YcDyRtO2It2cduvnD01NFJiGM6mxQWzPCKJS43nl
Uvcc7asbEGFMxNSZy11VmxnH+m0vN5cgNrWPctHf4AJiuPOY/zz0sUZzjrnj/ZOX
TluQWLOwLXVCEFU0h7PGwn6EiG4ijA==
=z+2P
-----END PGP SIGNATURE-----

--L0vGvkWgjCOBW0mRuNvb1TqwXN2jbsC2E--

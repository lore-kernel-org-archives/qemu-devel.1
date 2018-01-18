Received: from eggs.gnu.org ([2001:4830:134:3::10]:51139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ecIw2-0004lP-Oc
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 17:45:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ecIw1-0004Oa-I5
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 17:45:26 -0500
References: <20180118181123.37056-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <55e70fea-ac84-7c95-c195-63796ce4905d@redhat.com>
Date: Thu, 18 Jan 2018 16:45:17 -0600
MIME-Version: 1.0
In-Reply-To: <20180118181123.37056-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fvgPXQdrK84o8HD8Uqm923wWFojP8eban"
Subject: Re: [Qemu-devel] [PATCH v2 0/6] nbd export qmp interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fvgPXQdrK84o8HD8Uqm923wWFojP8eban
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <55e70fea-ac84-7c95-c195-63796ce4905d@redhat.com>
Subject: Re: [PATCH v2 0/6] nbd export qmp interface
References: <20180118181123.37056-1-vsementsov@virtuozzo.com>
In-Reply-To: <20180118181123.37056-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/18/2018 12:11 PM, Vladimir Sementsov-Ogievskiy wrote:
> v2:
> 01: tweak comment
>     add Eric's r-b
> 02: new patch
> 03: rewritten, to move form 'bool force' flag to 'enum mode' parameter
> 04: add Eric's r-b
> 05: improve commit message
>     tweak comment
> 06: rebase on 03 changes
>     make PEP8 happy
>     some other tweaks
>     I've left nbd_port variable hard-set to 10900. I think all such thi=
ngs
>     should be fixed together, and it is simple to change in future
>     nbd_port =3D '10900'
>     to
>     nbd_port =3D iotests.get_free_port()
>     if needed.
>=20
> [Unfortunately, qmp query-nbd-server is not finished yet, coming soon,
>  but may be after my vocation on the next week]

Enjoy your time off. I think the series is nearly ready to go; I had
some tweaks that I suggested, and will probably replace your 2/6 with my
counterproposal, but I don't mind doing that cleanup if you don't have
time to respin.  I'll give it a few more days in case anyone else has
comments, then add it to my NBD queue.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--fvgPXQdrK84o8HD8Uqm923wWFojP8eban
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlphI30ACgkQp6FrSiUn
Q2qBwAf/ZMF3ppswpEfBvD28KT5JZznV656jtqeZspc+mcC+9BscfOUBM1iqYs2l
+Dnb74i5ZJHmfJRTbq9uPqaAGsO9c1FpmUKtFhaJxUTz4DIyGi2sPRijFSp45GcA
0SdTIVlWH8rb1A/9SNBCES1nREJurrKF35Yw5RNHzG1F9N9Ma100bcNouxv9i682
nRwbXE7dJtm95Fdsie8bnKFlcPA4ff5nx2QbQZ2MQ50HDvZOejk16QG5gmqfhBVS
xaqxGHz2VUbFGGE0TPy8+EAQPpNo2Pk9xV/AtmV3DbUrQlTH8WX7IniQ140u0ebq
amO/UJkJMNKaWzsO6koLAMtN0HldLQ==
=WMCS
-----END PGP SIGNATURE-----

--fvgPXQdrK84o8HD8Uqm923wWFojP8eban--

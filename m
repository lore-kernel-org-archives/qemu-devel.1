Received: from eggs.gnu.org ([2001:4830:134:3::10]:53320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fC5Ai-00075h-Oh
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 11:20:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fC5Ac-00046R-O0
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 11:20:28 -0400
References: <20180427142002.21930-1-vsementsov@virtuozzo.com>
	<20180427142002.21930-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fda2fb9a-e627-4627-b659-fc3854a8cbc6@redhat.com>
Date: Fri, 27 Apr 2018 10:20:11 -0500
MIME-Version: 1.0
In-Reply-To: <20180427142002.21930-2-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2byHPasWFUOkA9rstKZqfVXZ6bfkz3EPY"
Subject: Re: [Qemu-devel] [PATCH 1/2] nbd/client: fix
 nbd_negotiate_simple_meta_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org
Cc: pbonzini@redhat.com, dgilbert@redhat.com, quintela@redhat.com, famz@redhat.com, stefanha@redhat.com, den@openvz.org, peter.maydell@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2byHPasWFUOkA9rstKZqfVXZ6bfkz3EPY
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org
Cc: pbonzini@redhat.com, dgilbert@redhat.com, quintela@redhat.com,
 famz@redhat.com, stefanha@redhat.com, den@openvz.org,
 peter.maydell@linaro.org
Message-ID: <fda2fb9a-e627-4627-b659-fc3854a8cbc6@redhat.com>
Subject: Re: [PATCH 1/2] nbd/client: fix nbd_negotiate_simple_meta_context
References: <20180427142002.21930-1-vsementsov@virtuozzo.com>
 <20180427142002.21930-2-vsementsov@virtuozzo.com>
In-Reply-To: <20180427142002.21930-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/27/2018 09:20 AM, Vladimir Sementsov-Ogievskiy wrote:
> Initialize received variable. Otherwise, is is possible for server to
> answer without any contexts, but we will set context_id to something
> random (received_id is not initialized too) and return 1, which is
> wrong.
>=20
> To solve it, just initialize received to false. Initialize received_id
> too, just to make all possible checkers happy.
>=20
> But was introduced in 78a33ab58782efdb206de14 "nbd: BLOCK_STATUS for

s/But/Bug/

> standard get_block_status function: client part" with the whole
> function.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/client.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2byHPasWFUOkA9rstKZqfVXZ6bfkz3EPY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrjP6sACgkQp6FrSiUn
Q2oPSwgAg6kvTeuij6nExT5KSKQTbbqHHWqXRv8XnUpDiXwu7s3mIrImTnam5qFm
+EbIe3d6oEpimboxwF3rlqJbN1MMKWQF4x7uhM3YNKPmKPjxWsfMfM5AJoGJvyMr
XSIMWTXS44LWnS6Ucii0ZhxPiTV/68alRWKdtxwA3ICBzYqfWuuuF7R6x6E8m9HQ
uuByx6qurYjoo9a+Vd9etreW5ys7eFmasEg3LhT+yTa4FfGB4S3bUjaxCWm5bDzS
niKT4vYa2LlQX5AWIjuZXDsekkjyjAve6d9I1fpP3WJ6A1nKSD/5qaLfgvJbOuN2
JYBs8QrtOHjIheEX5MndfABC1r9EvQ==
=9IT1
-----END PGP SIGNATURE-----

--2byHPasWFUOkA9rstKZqfVXZ6bfkz3EPY--

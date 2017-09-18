Received: from eggs.gnu.org ([2001:4830:134:3::10]:53095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dty7m-0003E1-K9
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 11:38:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dty7g-0002gX-Uh
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 11:38:18 -0400
References: <20170918135935.255591-1-vsementsov@virtuozzo.com>
	<20170918135935.255591-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7830d9e4-d95b-c58b-94d7-1daa8b2c4a2f@redhat.com>
Date: Mon, 18 Sep 2017 10:38:02 -0500
MIME-Version: 1.0
In-Reply-To: <20170918135935.255591-2-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cS56X1FXGtSALX0jdB8GogIQBwsXnuauA"
Subject: Re: [Qemu-devel] [PATCH v2 1/7] block/nbd-client: refactor
 nbd_co_receive_reply
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
--cS56X1FXGtSALX0jdB8GogIQBwsXnuauA
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <7830d9e4-d95b-c58b-94d7-1daa8b2c4a2f@redhat.com>
Subject: Re: [PATCH v2 1/7] block/nbd-client: refactor nbd_co_receive_reply
References: <20170918135935.255591-1-vsementsov@virtuozzo.com>
 <20170918135935.255591-2-vsementsov@virtuozzo.com>
In-Reply-To: <20170918135935.255591-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/18/2017 08:59 AM, Vladimir Sementsov-Ogievskiy wrote:
> "NBDReply *reply" parameter of nbd_co_receive_reply is used only
> to pass return value for nbd_co_request (reply.error). Remove it
> and use function return value instead.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/nbd-client.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--cS56X1FXGtSALX0jdB8GogIQBwsXnuauA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm/6FoACgkQp6FrSiUn
Q2qiogf/eHnBPx4TlVW44RKj64Ge1lr8Wi+89gYQP+tccOk6J4ooPpRyPq6gVEFG
bU8au6P3dv/7DtobkqvARqH2DqpX+i2n3v8RR7X8rTEKWcmcQsPaMCj9pqomQiaC
ogXVf73hjrZSlGQorXZa50TwZ4JWYCHk3GCP4+7sgkKBBFlpz7uzP6MGNSUck67M
L9OfFFstN/6T5XkLHKQ25AySff+MVVasfFoBgaioy5L7oN0cTyG+eBfb0BFLVgcV
l2zZeTv2pMgF73on1p8g0B4whzWvweR+zBNrVTqSLQ/MtIMHN7xrS9FPswQyhA8K
qeNpMDnvth3YB0ABtvG4stc6HcrixQ==
=LWbH
-----END PGP SIGNATURE-----

--cS56X1FXGtSALX0jdB8GogIQBwsXnuauA--

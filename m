Received: from eggs.gnu.org ([2001:4830:134:3::10]:51851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dtx2Q-00088W-8z
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:28:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dtx2M-0000cd-Az
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:28:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dtx2M-0000cD-59
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:28:38 -0400
References: <20170918101709.30421-1-aik@ozlabs.ru>
	<20170918101709.30421-4-aik@ozlabs.ru>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f4fc948a-63d4-b150-2a6f-2cf73f167d6a@redhat.com>
Date: Mon, 18 Sep 2017 09:28:36 -0500
MIME-Version: 1.0
In-Reply-To: <20170918101709.30421-4-aik@ozlabs.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wdaW3TrEQBbwHuPRk0D9bHGX1rl7d3iUd"
Subject: Re: [Qemu-devel] [PATCH qemu v3 03/13] memory: Open code FlatView
 rendering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wdaW3TrEQBbwHuPRk0D9bHGX1rl7d3iUd
From: Eric Blake <eblake@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f4fc948a-63d4-b150-2a6f-2cf73f167d6a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH qemu v3 03/13] memory: Open code FlatView
 rendering
References: <20170918101709.30421-1-aik@ozlabs.ru>
 <20170918101709.30421-4-aik@ozlabs.ru>
In-Reply-To: <20170918101709.30421-4-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/18/2017 05:16 AM, Alexey Kardashevskiy wrote:
> We are going to share FlatView's between AddressSpace's and per-AS
> memory listeners won't suite the purpose anymore so open code

s/suite/suit/

> the dispatch tree rendering.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--wdaW3TrEQBbwHuPRk0D9bHGX1rl7d3iUd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm/2BQACgkQp6FrSiUn
Q2ry8Af+Oe56ir4urixJPCwotsatcNGW3zEm73Zz8RkDEzDJwyscTIFxFJuonfhi
JB1M6DhNWbTq+fEpV2psQNErY0VVUPASJ+KvWE+nLgdqceYrrZ9QQUx0eyfCghv2
9CDRJh7UVxf1QFZWzjNlOnjAgoeoRLmRWxI6jw6/QCwDIYSKd3Nic/EVz0OfmoT6
6cV2NP74Xl4qdno8D8GpKWoAp+W/rbrDsVGIVDWp6MxJFmqCEL5QDmpuPzcxMrlV
u8dCbIltERnvwHRdu449jq9P7VbitQpumQydLGZhAe6EubLhqdw/eJwoDQhoZNbs
uy3xTrdkv+AIqrCbzYbdCHPMq3mI6w==
=hSKH
-----END PGP SIGNATURE-----

--wdaW3TrEQBbwHuPRk0D9bHGX1rl7d3iUd--

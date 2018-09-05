Received: from eggs.gnu.org ([2001:4830:134:3::10]:58283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fxXGR-00043X-V1
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 08:50:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fxXGR-0004Os-5u
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 08:50:31 -0400
References: <cover.1535983918.git.berto@igalia.com>
	<b4bf05291f304b35658af1a12c97cdcf8d390fa2.1535983918.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a0fc140a-e99f-66f8-5b91-663f2ba9b65b@redhat.com>
Date: Wed, 5 Sep 2018 14:50:22 +0200
MIME-Version: 1.0
In-Reply-To: <b4bf05291f304b35658af1a12c97cdcf8d390fa2.1535983918.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="575Z28Pu0SGeS6iLpPmvue7Nr9wLbtjsO"
Subject: Re: [Qemu-devel] [PATCH v2 08/10] block: Allow changing 'discard'
 on reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--575Z28Pu0SGeS6iLpPmvue7Nr9wLbtjsO
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <a0fc140a-e99f-66f8-5b91-663f2ba9b65b@redhat.com>
Subject: Re: [PATCH v2 08/10] block: Allow changing 'discard' on reopen
References: <cover.1535983918.git.berto@igalia.com>
 <b4bf05291f304b35658af1a12c97cdcf8d390fa2.1535983918.git.berto@igalia.com>
In-Reply-To: <b4bf05291f304b35658af1a12c97cdcf8d390fa2.1535983918.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-09-03 16:34, Alberto Garcia wrote:
> 'discard' is one of the basic BlockdevOptions available for all
> drivers, but it's not handled by bdrv_reopen_prepare() so any attempt
> to change it results in an error:
>=20
>    (qemu) qemu-io virtio0 "reopen -o discard=3Don"
>    Cannot change the option 'discard'
>=20
> Since there's no reason why we shouldn't allow changing it and the
> implementation is simple let's just do it.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Cc: Max Reitz <mreitz@redhat.com>
> ---
>  block.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--575Z28Pu0SGeS6iLpPmvue7Nr9wLbtjsO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluP0Q4ACgkQ9AfbAGHV
z0Bjtwf9EBuvabrs6/oMXSDO/wGnTfDtnlgukEAIiOqVQnkPbmuFONN+wTIeCu+r
wowgqngrAQfcFAtJgk6yydCQQjGlAe15InCTdMODcSHIdJUdk1qUSF5vRfNIJfRQ
n1+mB3eWsJB58fRnaPefJdR5VKl2UGqXTU1HQeBjUDJqToSkBg7NgV5ZB/LbX9Hd
4R1b/UK3bqarOctHchE+JpiDeAHGW6htpB7eH/VNEscilwUDh8ETpRNbDcE9cPdJ
mI0a4rkhffqTTYFQIJSa9VwnPMbGcb87BaXoKizd4HqR5TC683E3wNUtXIqHD7dN
OGWEFXZtnZyJe9YUGZ4RQYtoyvaezA==
=UITQ
-----END PGP SIGNATURE-----

--575Z28Pu0SGeS6iLpPmvue7Nr9wLbtjsO--

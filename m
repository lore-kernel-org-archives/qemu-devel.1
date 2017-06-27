Received: from eggs.gnu.org ([2001:4830:134:3::10]:53099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPoqq-0004uG-DB
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:40:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPoqn-0000PP-3Q
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:40:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dPoqm-0000OX-RG
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:40:09 -0400
References: <20170615163813.7255-1-stefanha@redhat.com>
	<20170615163813.7255-4-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b1a33e94-b32b-c6ca-c526-6dbb201a25b1@redhat.com>
Date: Tue, 27 Jun 2017 06:40:04 -0500
MIME-Version: 1.0
In-Reply-To: <20170615163813.7255-4-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PDmCVUKomw2o8gpRjuIRmdiaC6FlsWWUg"
Subject: Re: [Qemu-devel] [PATCH 3/5] qemu-iotests: 068: extract _qemu()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Pavel Butsykin <pbutsykin@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PDmCVUKomw2o8gpRjuIRmdiaC6FlsWWUg
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Pavel Butsykin <pbutsykin@virtuozzo.com>
Message-ID: <b1a33e94-b32b-c6ca-c526-6dbb201a25b1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/5] qemu-iotests: 068: extract _qemu()
 function
References: <20170615163813.7255-1-stefanha@redhat.com>
 <20170615163813.7255-4-stefanha@redhat.com>
In-Reply-To: <20170615163813.7255-4-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/15/2017 11:38 AM, Stefan Hajnoczi wrote:
> Avoid duplicating the QEMU command-line.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/qemu-iotests/068 | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>=20

> +# Give qemu some time to boot before saving the VM state
> +bash -c 'sleep 1; echo -e "savevm 0\nquit"' | _qemu

Are we sure that 'bash' on PATH is the same as the /bin/bash running the
script?

Also, while bash has more deterministic behavior for 'echo -e' (it is
non-portable if you are porting a script to other shells), it is still
possible to set bash to a mode where it does not work (see xhopt
xpg_echo).  I'd much prefer you use 'printf' instead of 'set -e'.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--PDmCVUKomw2o8gpRjuIRmdiaC6FlsWWUg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZUkQUAAoJEKeha0olJ0NqcaEIAK90QqSKRGfe5SLFmZSVGmg1
76HCH8OQrRapEtVkG38HHGoSATqy7Pqpz4uOnZX1/nBknGqPI6WwZhXkDFzVytdr
HNmmRZbmgodPUlD9F410W9MFctE2nyIv+VTxw8aRAhnCb9GO7hCPgNnL/6Xqd+S+
XOZAsXPLgbJUYx4M3ZbxzJCBZ0/QpJMDpS1Qh6ASFv9cb5+IBbKlxkJKakirKNv3
TRpeaQpj0O7DbGHtVEoNiDnv104KBWOUKEro1QoFYQIGm90+y9i24pd7yBtCsZex
cIeroSnTsEg67H2pLcC6JOFP4FC9Kz/8rwxwyCEGgoBCBswBcpuBHl6OkuzjuOU=
=J8mc
-----END PGP SIGNATURE-----

--PDmCVUKomw2o8gpRjuIRmdiaC6FlsWWUg--

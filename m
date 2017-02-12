Received: from eggs.gnu.org ([2001:4830:134:3::10]:54321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cck5A-0000g2-Rb
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 21:40:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cck59-0003ZS-SE
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 21:40:08 -0500
References: <20170210170910.8867-1-berrange@redhat.com>
	<20170210170910.8867-19-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d9b7aefd-890c-afb8-d3b4-02d22eebdf6e@redhat.com>
Date: Sun, 12 Feb 2017 03:39:58 +0100
MIME-Version: 1.0
In-Reply-To: <20170210170910.8867-19-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Nfa9QnmjJ40GBv1Dg1mIqpIVK1hCtAhHt"
Subject: Re: [Qemu-devel] [PATCH v4 18/18] block: pass option prefix down to
 crypto layer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Nfa9QnmjJ40GBv1Dg1mIqpIVK1hCtAhHt
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>
Message-ID: <d9b7aefd-890c-afb8-d3b4-02d22eebdf6e@redhat.com>
Subject: Re: [PATCH v4 18/18] block: pass option prefix down to crypto layer
References: <20170210170910.8867-1-berrange@redhat.com>
 <20170210170910.8867-19-berrange@redhat.com>
In-Reply-To: <20170210170910.8867-19-berrange@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 10.02.2017 18:09, Daniel P. Berrange wrote:
> While the crypto layer uses a fixed option name "key-secret",
> the upper block layer may have a prefix on the options. e.g.
> "luks-key-secret", "aes-key-secret", in order to avoid clashes
> between crypto option names & other block option names. To
> ensure the crypto layer can report accurate error messages,
> we must tell it what option name prefix was used.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/crypto.c            |  4 ++--
>  block/qcow.c              |  7 ++++---
>  block/qcow2.c             | 15 +++++++++------
>  crypto/block-luks.c       |  8 ++++++--
>  crypto/block-qcow.c       |  8 ++++++--
>  crypto/block.c            |  6 ++++--
>  crypto/blockpriv.h        |  2 ++
>  include/crypto/block.h    |  6 +++++-
>  tests/test-crypto-block.c |  8 ++++----
>  9 files changed, 42 insertions(+), 22 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--Nfa9QnmjJ40GBv1Dg1mIqpIVK1hCtAhHt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlifyv8SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AftUH+gP+379x/cgJAUHWJ63fCjkd6RrdzSWR
yksnKf9/HgZXw0wYM5oa/MrgIdWw0njGb5uSuAYh65icX+5iyWlltRasGL4pZVXF
380DMV5z0MDeIYDX3fV5yJUUi6W6JmtqVGb0Iz21bqHY7NI9nwEVZRh/OtfR1Sck
lMRwIk2ilIU56AqZ+Ym+MXmr2OLdpxbztMtAiswDd7NfLsOIxHMph5MXwriikDxe
iXDtEDuU/kPFyyl2CWVCEdEOuYupJsS7+j7Bkxsl+VGG1f9mHtvTuvVdwmiTkxdv
3HsKfEABR6lwOe8uSKTYHVpR70XrnTXsluHdH9KMAR7CpWRgrME5mXs=
=MrQI
-----END PGP SIGNATURE-----

--Nfa9QnmjJ40GBv1Dg1mIqpIVK1hCtAhHt--

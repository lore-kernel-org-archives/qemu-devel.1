Received: from eggs.gnu.org ([2001:4830:134:3::10]:40247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cYE1M-0006q5-SC
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:37:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cYE1J-0005t7-Ps
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:37:32 -0500
Received: from mail-wj0-x241.google.com ([2a00:1450:400c:c01::241]:35416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cYE1J-0005sA-IC
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:37:29 -0500
Received: by mail-wj0-x241.google.com with SMTP id i7so8274213wjf.2
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:37:29 -0800 (PST)
Date: Mon, 30 Jan 2017 15:37:26 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170130153726.GO2118@stefanha-x1.localdomain>
References: <20170120164322.21851-1-pbonzini@redhat.com>
	<20170120164322.21851-7-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L5nTHegdhbHhzmSD"
Content-Disposition: inline
In-Reply-To: <20170120164322.21851-7-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 06/17] io: make qio_channel_yield aware of
 AioContexts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, stefanha@redhat.com


--L5nTHegdhbHhzmSD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 20, 2017 at 05:43:11PM +0100, Paolo Bonzini wrote:
> Support separate coroutines for reading and writing, and place the
> read/write handlers on the AioContext that the QIOChannel is registered
> with.
>=20
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>         v1->v2:
>         improved qio_channel_set_aio_context docs, renamed to
>                 qio_channel_attach_aio_context [Daniel, Stefan]
>         fixed pasto in "io: make qio_channel_yield aware of AioContexts"
>=20
>  include/io/channel.h | 47 ++++++++++++++++++++++++++--
>  io/channel.c         | 86 +++++++++++++++++++++++++++++++++++++++-------=
------
>  2 files changed, 109 insertions(+), 24 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--L5nTHegdhbHhzmSD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYj122AAoJEJykq7OBq3PIPLQH/3g8docohjWnUP+1G4LaZPuT
42B/BdMIHRi3Oh9Xx/M/rZtmTKcRKoiTx+tAMKbjtKf9WGvOUOqIscOX2LZdT2ug
/d/1LP3r3iorsymSBaEq31nTjGidgNiI6e4ImUIIWtz/SeLeNYOFfXjtNPGS1kH4
PIJM9YyCSTe1UC2HetHDk26usVuDwKMX2q/o4e85U+a3CfDv71MAA9jN71T1DHeX
GB2WjZBe+9qRH6DNG/gEz1uQbTJD4pWah3wcDgCkv/UF7Let6khpIRVKr0EBJ0Z+
Gw/rZJRqroQYkmsByKPuPEO0+kZTQa1R7ha6c1NlT0nWmsKSpYp1xbyrPOPffNU=
=tuYZ
-----END PGP SIGNATURE-----

--L5nTHegdhbHhzmSD--

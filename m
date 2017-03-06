Received: from eggs.gnu.org ([2001:4830:134:3::10]:54031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ckznx-00030w-1o
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 16:04:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ckznt-0006sf-Oh
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 16:04:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ckznt-0006sG-Gv
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 16:04:25 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 852173B71E
	for <qemu-devel@nongnu.org>; Mon,  6 Mar 2017 21:04:25 +0000 (UTC)
References: <20170221115644.28264-1-stefanha@redhat.com>
	<20170221115644.28264-8-stefanha@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c27b009c-bdd9-706c-74b3-bc13453c97a5@redhat.com>
Date: Mon, 6 Mar 2017 22:04:21 +0100
MIME-Version: 1.0
In-Reply-To: <20170221115644.28264-8-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FAcBxTakboCV6u6ahskBp3Bv5Ovfcqv98"
Subject: Re: [Qemu-devel] [PULL v2 07/24] nbd: convert to use
 qio_channel_yield
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FAcBxTakboCV6u6ahskBp3Bv5Ovfcqv98
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <c27b009c-bdd9-706c-74b3-bc13453c97a5@redhat.com>
Subject: Re: [Qemu-devel] [PULL v2 07/24] nbd: convert to use
 qio_channel_yield
References: <20170221115644.28264-1-stefanha@redhat.com>
 <20170221115644.28264-8-stefanha@redhat.com>
In-Reply-To: <20170221115644.28264-8-stefanha@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 12:56, Stefan Hajnoczi wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
>=20
> In the client, read the reply headers from a coroutine, switching the
> read side between the "read header" coroutine and the I/O coroutine tha=
t
> reads the body of the reply.
>=20
> In the server, if the server can read more requests it will create a ne=
w
> "read request" coroutine as soon as a request has been read.  Otherwise=
,
> the new coroutine is created in nbd_request_put.
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
> Message-id: 20170213135235.12274-8-pbonzini@redhat.com
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/nbd-client.h |   2 +-
>  block/nbd-client.c | 117 ++++++++++++++++++++++++---------------------=
--------
>  nbd/client.c       |   2 +-
>  nbd/common.c       |   9 +----
>  nbd/server.c       |  94 +++++++++++++-----------------------------
>  5 files changed, 83 insertions(+), 141 deletions(-)

git-bisect tells me this broke qemu-iotest 083 (which hangs now).

Maybe someone who is more involved with this patch can look into that...?=


(Although I don't know how urgent it is, probably not too much.)

Max


--FAcBxTakboCV6u6ahskBp3Bv5Ovfcqv98
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAli9ztUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ALaYIAIRhvCy5zL0pQp8iPYDT3e77mQXUchC3
rjskH6aPTjoyUfXWr2B8q7emmIaSlt8aMd76owJJDdEEq7l6zgbBDTW5L17NEYYR
mDiyiTOKmYv+TSG6vYieKIG17sVYe92I2oCBNHQTfILrdYQS7DPkAqQAyxtI7K0B
E+APTsk6L8zuiyYVoFMqYYKCzNYggytbV8lUoZcUWeM6gnLyJYW4d4jsAntQewNR
Yfv4MUn9Qxr5HSWB46uMa88eO7LSTXElKWFfmJ/ZWNZLlOYpJonn9NpT6AItXzCq
7tpnEyuEP2IZz04IOtk6eesLhC/O+UKGeciKx1NM8nJRiI0GCQUpKZg=
=xf8I
-----END PGP SIGNATURE-----

--FAcBxTakboCV6u6ahskBp3Bv5Ovfcqv98--

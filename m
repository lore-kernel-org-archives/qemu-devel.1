Received: from eggs.gnu.org ([2001:4830:134:3::10]:43549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cTrL1-0001NF-4v
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 09:35:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cTrKw-0000BM-8F
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 09:35:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cTrKv-0000Ay-RQ
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 09:35:42 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 038F9C058DA2
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 14:35:42 +0000 (UTC)
Date: Wed, 18 Jan 2017 14:35:39 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170118143539.GB30347@stefanha-x1.localdomain>
References: <20170113131731.1246-1-pbonzini@redhat.com>
	<20170113131731.1246-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Content-Disposition: inline
In-Reply-To: <20170113131731.1246-3-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/16] block-backend: allow blk_prw from
 coroutine context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2017 at 02:17:17PM +0100, Paolo Bonzini wrote:
> qcow2_create2 calls this.  Do not run a nested event loop, as that
> breaks when aio_co_wake tries to queue the coroutine on the co_queue_wake=
up
> list of the currently running one.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/block-backend.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYf307AAoJEJykq7OBq3PIuz4IAIcD/E0BQVKX0lUmPsdhKoDP
nsuqjOD6pwxHXMXx3S9s/Iq1wNlfYAZEkXBaYfh6BCNBaEwF932otZ0y1U73/vyz
L0k9yUYxAiyJJUl8QnlTfJs+ABQUfl1zFDe7f9IGHZfEQbuwQqWowoutDBuLDiRM
VnK1H4nxyJ3C8ryC0vPEJ4tSlHaHE4xJllfNObUpomFxcVYAAr9/2ppenKdChcMe
iw6ocUBwvM+J/TIonPZHuu1BpIDeGfE0EC6BlKA7QMqvspwK3twixW5FJ+CZJNq7
GPDLQhM4AsNYBKEcoXNhtk317AhCB/Lk/WGfmvVLn8aGJjElPnPqdOtWTndQPQ8=
=cdMQ
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--

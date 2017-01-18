Received: from eggs.gnu.org ([2001:4830:134:3::10]:54652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cTs96-0007AI-Cn
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:27:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cTs93-0007Gq-96
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:27:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cTs93-0007GL-2r
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:27:29 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 40C68C07CADE
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 15:27:29 +0000 (UTC)
Date: Wed, 18 Jan 2017 15:27:26 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170118152726.GI30347@stefanha-x1.localdomain>
References: <20170113131731.1246-1-pbonzini@redhat.com>
	<20170113131731.1246-9-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="N8NGGaQn1mzfvaPg"
Content-Disposition: inline
In-Reply-To: <20170113131731.1246-9-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 08/16] qed: introduce qed_aio_start_io and
 qed_aio_next_io_cb
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


--N8NGGaQn1mzfvaPg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2017 at 02:17:23PM +0100, Paolo Bonzini wrote:
> qed_aio_start_io and qed_aio_next_io will not have to acquire/release
> the AioContext, while qed_aio_next_io_cb will.  Split the functionality
> and gain a little type-safety in the process.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/qed.c | 39 +++++++++++++++++++++++++--------------
>  1 file changed, 25 insertions(+), 14 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--N8NGGaQn1mzfvaPg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYf4leAAoJEJykq7OBq3PI794H/1D56IkP8esJRJf1/nlwBqrE
gIylZIMYSBY9P0JonK2SEKehy9YJDU3IMZ+p7nqS0DlmzT7ZNMVfW6DKM3bS5BSi
opUyONeNaY6xJY7OOl+VqpmnEqm4M/3FYQI44z2uQclZsef1J+qJLf3ssdnkS6YV
70fmOccnimiPkGYTo0+Tcjcfupm7SCSHxhVI2OSYM3Ja0VJnN3/AnWd3+qz7LZ0d
jdUS5jVe/iTkyD2zkHzt7Yd2HKYlo8GSAnnqtUad5Wqa5Iv8NQjV6UozuZKuCst4
9eZ7+XgcGyLd9JSKE37hD9z2CUk6EIUVTr/3THrYi9G40iT8/afUiUlN/zq4CgE=
=uSBM
-----END PGP SIGNATURE-----

--N8NGGaQn1mzfvaPg--

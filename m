Received: from eggs.gnu.org ([2001:4830:134:3::10]:34833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6EU9-00014q-Mv
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:59:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6EU4-0004JA-Rq
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:59:49 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d6EU4-0004Ii-KW
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:59:44 -0400
Received: by mail-wm0-x241.google.com with SMTP id y10so2499040wmh.0
	for <qemu-devel@nongnu.org>; Thu, 04 May 2017 03:59:44 -0700 (PDT)
Date: Thu, 4 May 2017 11:59:41 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170504105941.GD32376@stefanha-x1.localdomain>
References: <20170419144219.20371-1-pbonzini@redhat.com>
	<20170419144219.20371-11-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="76DTJ5CE0DCVQemd"
Content-Disposition: inline
In-Reply-To: <20170419144219.20371-11-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 10/11] blockjob: reorganize
 block_job_completed_txn_abort
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org


--76DTJ5CE0DCVQemd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 19, 2017 at 04:42:18PM +0200, Paolo Bonzini wrote:
> This splits the part that touches job states from the part that invokes
> callbacks.  It will make the code simpler to understand once job states w=
ill
> be protected by a different mutex than the AioContext lock.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  blockjob.c | 35 ++++++++++++++++++++++-------------
>  1 file changed, 22 insertions(+), 13 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--76DTJ5CE0DCVQemd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZCwmdAAoJEJykq7OBq3PIMHQH/0c66Aqm3pPsqcjBKHesbQmP
5VLAict6SFgPzTrnr5YDumQ+VTqN/fu3f3JrrVZAGtNdvmKF1U2KY0XN2uxOBsia
7IrgWPzjbPLmy0P/yGKBRzTOCV2I1YooBDAMktWvvEpkJjnXWRXhHsqFgfZHtX7G
zjAebNnfPur6QxL6k7BBpbqWCILTpH0MgLv+2zWQlsP3Sd+l9xTNjkej2+Oyopn/
B7UkqTa7xWPEsntNJ+QZjiJ1yWh3LTXNYmEcdqv6j4qSG2/LN5Uw2M0+WILxpVTA
A1CSYi0fwKKgr3v0lhYORvj1Ckt8bdEA9ZxG/tiEoJtE6pVi3kDc0wHga3Je79A=
=rS0T
-----END PGP SIGNATURE-----

--76DTJ5CE0DCVQemd--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:33145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cxVXL-0005PH-IW
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:23:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cxVXH-0004QS-KX
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:23:03 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:35050)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cxVXH-0004Q0-Co
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:22:59 -0400
Received: by mail-wm0-x232.google.com with SMTP id w64so33721395wma.0
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 02:22:59 -0700 (PDT)
Date: Mon, 10 Apr 2017 10:22:55 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170410092255.GD2567@stefanha-x1.localdomain>
References: <20170323173928.14439-1-pbonzini@redhat.com>
	<20170323173928.14439-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MAH+hnPXVZWQ5cD/"
Content-Disposition: inline
In-Reply-To: <20170323173928.14439-4-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 03/10] blockjob: introduce block_job_fail
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, jcody@redhat.com, jsnow@redhat.com


--MAH+hnPXVZWQ5cD/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 23, 2017 at 06:39:21PM +0100, Paolo Bonzini wrote:
> Outside blockjob.c, block_job_unref is only used when a block job fails
> to start, and block_job_ref is not used at all.  The reference counting
> thus is pretty well hidden.  Introduce a separate function to be used
> by block jobs; because block_job_ref and block_job_unref now become
> static, move them earlier in blockjob.c.
>=20
> Later on, block_job_fail will also have different locking than
> block_job_unref.

block_job_fail() sounds like it's *the* job failure API.
How about block_job_fail_early()?

It indicates the API is only for the beginning of the job's lifecycle.

Stefan

--MAH+hnPXVZWQ5cD/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY607vAAoJEJykq7OBq3PIPzgH/3EMJpGUcqmabuxjCeYCpEHO
tjFC018zqtMP7NPMy44ePwk1nNccPvB1vRBGFCzRbdkwbmKsHC4T/OGjvHvbfOEm
guQ7Am9aSL5fovbhkWlcskUMM+iAHTpc0cJrl3jbcWfH1IMGx9Sp5KkR/PUG/3PA
jwyocVILJt2LzSUwTjPXI/UHnycdZXvduHCvyt3OjrjG0K+PElNVimMVmMh/EeJj
HhAtvMXrshLAFTxB3l5kFGHOHInX08hgu732/xzuk+iuFkVlNgec0lCXWtboovLS
FFGbSkrDc77SFCCSNb2zDKYUxGkiij5bXuyWzg1yWdC86EriQknp0xFgm2/nx2o=
=q4gN
-----END PGP SIGNATURE-----

--MAH+hnPXVZWQ5cD/--

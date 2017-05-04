Received: from eggs.gnu.org ([2001:4830:134:3::10]:36529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6EbI-0004tg-Uw
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:07:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6EbH-0007eJ-M1
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:07:12 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:36239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d6EbH-0007df-F9
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:07:11 -0400
Received: by mail-wm0-x243.google.com with SMTP id u65so2522069wmu.3
	for <qemu-devel@nongnu.org>; Thu, 04 May 2017 04:07:11 -0700 (PDT)
Date: Thu, 4 May 2017 12:07:08 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170504110708.GF32376@stefanha-x1.localdomain>
References: <20170419144219.20371-1-pbonzini@redhat.com>
	<20170419144219.20371-12-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="udcq9yAoWb9A4FsZ"
Content-Disposition: inline
In-Reply-To: <20170419144219.20371-12-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 11/11] blockjob: use deferred_to_main_loop
 to indicate the coroutine has ended
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


--udcq9yAoWb9A4FsZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 19, 2017 at 04:42:19PM +0200, Paolo Bonzini wrote:
> All block jobs are using block_job_defer_to_main_loop as the final
> step just before the coroutine terminates.  At this point,
> block_job_enter should do nothing, but currently it restarts
> the freed coroutine.
>=20
> Now, the job->co states should probably be changed to an enum
> (e.g. BEFORE_START, STARTED, YIELDED, COMPLETED) subsuming
> block_job_started, job->deferred_to_main_loop and job->busy.
> For now, this patch eliminates the problematic reenter by
> removing the reset of job->deferred_to_main_loop (which served
> no purpose, as far as I could see) and checking the flag in
> block_job_enter.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  blockjob.c                   | 10 ++++++++--
>  include/block/blockjob_int.h |  3 ++-
>  2 files changed, 10 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--udcq9yAoWb9A4FsZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZCwtcAAoJEJykq7OBq3PIgRIH/iNcTltB/hfUH3Kgn7gjINUT
IMAqTFqVzO6h9s7HY89ikq83sTGpGapHIoWvoQvtt0tDvDIUz5RBT21lQ87mZ8xI
43hQ3EA2p4CDfOqEM+wKwu4wJeRWp+M4s7tsh8LJkWbys+O+kGEx3cKEN4kSlOQF
pim6v3a9rcX2CZT+Ejf6WSaMJrmI1VUGjiQ6fE+tiTeRHtQ5JMZarQfQv+1IdXVW
LRmqCtr8AxhkZqNaoPT/EjZvpgAvFLzAPFtBOPNUCEE4QoBHCw9N9/uqndQS0ONi
iHsfhoun1CM4LUm6jwiQ1BmNrqy/6P5p35zO21QxMOm1qKEtdklX5So/Mmz75no=
=WCxz
-----END PGP SIGNATURE-----

--udcq9yAoWb9A4FsZ--

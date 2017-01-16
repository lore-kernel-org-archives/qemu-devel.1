Received: from eggs.gnu.org ([2001:4830:134:3::10]:36186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cT4ey-0000Qs-Bt
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 05:37:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cT4ev-0006AF-6L
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 05:37:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cT4eu-0006A7-TO
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 05:37:05 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1391685376
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 10:37:04 +0000 (UTC)
Date: Mon, 16 Jan 2017 10:37:00 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170116103700.GA12351@stefanha-x1.localdomain>
References: <148278447806.8988.12706825771606357198.stgit@fimbulvetr.bsc.es>
	<148278451049.8988.5349519787388002909.stgit@fimbulvetr.bsc.es>
	<20170109161702.GH30228@stefanha-x1.localdomain>
	<878tqdysxm.fsf@ac.upc.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <878tqdysxm.fsf@ac.upc.edu>
Subject: Re: [Qemu-devel] [PATCH v4 6/6] hypertrace: Add guest-side Linux
 module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Luiz Capitulino <lcapitulino@redhat.com>


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 15, 2017 at 03:10:13AM +0100, Llu=EDs Vilanova wrote:
> Stefan Hajnoczi writes:
> > On Mon, Dec 26, 2016 at 09:35:10PM +0100, Llu=EDs Vilanova wrote:
> >> Provides guest Linux kernel module "qemu-hypertrace.ko" to abstract
> >> access to the hypertrace channel.
> >>=20
> >> Signed-off-by: Llu=EDs Vilanova <vilanova@ac.upc.edu>
> >> ---
> >> Makefile                                           |    4 -
> >> configure                                          |    4 +
> >> hypertrace/guest/linux-module/Kbuild.in            |    7 +
> >> hypertrace/guest/linux-module/Makefile             |   23 +++
> >> .../include/linux/qemu-hypertrace-internal.h       |   46 ++++++
> >> .../linux-module/include/linux/qemu-hypertrace.h   |   73 ++++++++++
> >> hypertrace/guest/linux-module/qemu-hypertrace.c    |  149 ++++++++++++=
++++++++
> >> 7 files changed, 305 insertions(+), 1 deletion(-)
> >> create mode 100644 hypertrace/guest/linux-module/Kbuild.in
> >> create mode 100644 hypertrace/guest/linux-module/Makefile
> >> create mode 100644 hypertrace/guest/linux-module/include/linux/qemu-hy=
pertrace-internal.h
> >> create mode 100644 hypertrace/guest/linux-module/include/linux/qemu-hy=
pertrace.h
> >> create mode 100644 hypertrace/guest/linux-module/qemu-hypertrace.c
>=20
> > This should be submitted to Linux, the module cannot live in the QEMU
> > tree (we don't carry out-of-tree kernel modules).
>=20
> I thought it made sense to have it here, the same way we have the user-mo=
de
> guest library. If not, I will split it into a separate repo and point at =
it from
> the documentation file. Once the rest is merged into QEMU, I can post the=
 kernel
> module repo to the linux list.

Linux doesn't have a stable kernel module API.  Out-of-tree modules
bitrot if they are not actively rebased.  Getting the module into
linux.git avoids these problems.

The Linux maintainers may give you feedback that requires changes to the
current design, so please send the patch to them now instead of waiting.

Stefan

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYfKJMAAoJEJykq7OBq3PIoa8IAMguZquERWA8ZgqlpbI1fJ5l
ttXfiO6zRtRmr6iRMI8kK7CM+4ESnSpc4vxioR5DKJWYoiPel9Ym3VmDwU40oSvj
VOoFd2APRh+DNysZPdN0C8YuGZsjVJ1oZ4RqDtrNk75qbv/J6mCjtPOul9twBLm7
rNyza/3GZLITeq1aiLoYUJc/Qt/MvMPJFGgQ1wo7uhBMb+w11IdqSGB3Lxt1WcQy
VcgWyJIMwTY6mgd8F1lEfV5ZnHFvNdr4ZNvrTe3WH0Su5pmq1oqgUUiFNIOK7pgt
t741W42fXCG/J4jfZpdtU10JS5OsiRVehUS4BfV7WJqnwmRsK78NnmBiSr8kcpg=
=KbNG
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--

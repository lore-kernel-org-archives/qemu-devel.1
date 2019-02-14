Received: from eggs.gnu.org ([209.51.188.92]:35327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1guCBf-0006vb-J6
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 03:16:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1guCBe-0007kB-G1
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 03:16:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1guCBe-0007iJ-9n
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 03:16:02 -0500
Date: Thu, 14 Feb 2019 16:15:58 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190214081558.GA7652@stefanha-x1.localdomain>
References: <20190214031004.32522-1-stefanha@redhat.com>
	<20190214031004.32522-3-stefanha@redhat.com>
	<20190214041915.GA10412@richard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <20190214041915.GA10412@richard>
Subject: Re: [Qemu-devel] [PATCH v3 2/2] hostmem-file: reject invalid pmem
 file sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Zhang Yi <yi.z.zhang@linux.intel.com>


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 14, 2019 at 12:19:15PM +0800, Wei Yang wrote:
> On Thu, Feb 14, 2019 at 11:10:04AM +0800, Stefan Hajnoczi wrote:
> >diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> >index b4c17f5dfa..bd633afab6 100644
> >--- a/util/oslib-win32.c
> >+++ b/util/oslib-win32.c
> >@@ -560,6 +560,11 @@ void os_mem_prealloc(int fd, char *area, size_t mem=
ory, int smp_cpus,
> >     }
> > }
> >=20
> >+uint64_t qemu_get_pmem_size(const char *filename, Error **errp)
> >+{
> >+    error_setg(errp, "pmem support not available");
> >+    return 0;
> >+}
>=20
> After the cleanup from Igor, qemu_get_pmem_size() would be invoked only on
> POSIX system.
>=20
> Is it still necessary to define this on win32?

Either way is possible.  I'd like to leave it like this unless there are
strong feelings against this.

Stefan

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcZSO+AAoJEJykq7OBq3PItioH/2EKrrjRBFat7utR9HuVNgpH
1nRAQjr0EqNQp0IgaHDAHiNKj2OlUaw4EmIvPVrpHoj0hU0NUPGzQ9SurOfPKf5m
wlWbVflJG6pv8vB/aPP5L9Q17FIqGxwJnPMd2Iwoa3nJwwguWAyydwEmny4HiYjV
nXmATn3xssmHbS24MG9bb5sKuj4jBPoZbbrcBxvhiU0UVZj7sxBDZ57khjkLwDbi
kMB4Trz8fiawTvE6Y7qcPswM3BFX/WEOEUY5fVgpI+7xhsW7JtelAI1KxKSHkbxZ
ihUDH1nIRvA3zoozBnQaf/5ZMFwrk3Tf9pC8a9vZFy/ADE/cq8lsLBC3NnVbrlI=
=Mi+F
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--

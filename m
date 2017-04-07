Received: from eggs.gnu.org ([2001:4830:134:3::10]:60693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cwUvI-0005rL-Qr
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:31:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cwUvB-0002nX-So
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:31:32 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cwUvB-0002nB-Lz
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:31:29 -0400
Received: by mail-wm0-x241.google.com with SMTP id x75so1747137wma.1
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 07:31:26 -0700 (PDT)
Date: Fri, 7 Apr 2017 15:31:23 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170407143123.GI16146@stefanha-x1.localdomain>
References: <20170331084147.32716-1-haozhong.zhang@intel.com>
	<20170406094359.GB21261@stefanha-x1.localdomain>
	<CAPcyv4jYHN7gaofVUFDqubf-ZyrQttw7aPO=f2iGbXpMeJGXbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tctmm6wHVGT/P6vA"
Content-Disposition: inline
In-Reply-To: <CAPcyv4jYHN7gaofVUFDqubf-ZyrQttw7aPO=f2iGbXpMeJGXbA@mail.gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/4] nvdimm: enable flush hint address
 structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Haozhong Zhang <haozhong.zhang@intel.com>, qemu-devel@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>


--tctmm6wHVGT/P6vA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 06, 2017 at 07:32:01AM -0700, Dan Williams wrote:
> On Thu, Apr 6, 2017 at 2:43 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > On Fri, Mar 31, 2017 at 04:41:43PM +0800, Haozhong Zhang wrote:
> * I don't think we can just skip implementing support for this flush.
> Yes it's virtualization unfriendly, but it completely defeats the
> persistence of persistent memory if the host filesystem is free to
> throw away writes that the guest expects to find after a surprise
> power loss.

Right, if we don't implement Address Flush Hints then the only safe
option for configurations that require them would be to print an error
and refuse to start.

This synchronous fsync(2) business is like taking a host page fault or
being scheduled out by the host scheduler.  It means the vcpu is stuck
for a little bit.  Hopefully not long enough to upset the guest kernel
or the application.

One of the things that guest software can do to help minimize the
performance impact is to avoid holding locks across the address flush
mmio write instruction.

Stefan

--tctmm6wHVGT/P6vA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY56K7AAoJEJykq7OBq3PIcz0IAI2XNEesPGLdWDMV1nmvwiAs
YVj/vr2LD53pSpMuRup9m87nt/DJ7X+pSg/Q0Luax2+oCGRC4odDvbZskIqdG5nv
zkNpHEd1FY9ZOaVIqxk6PmspziYeu1DiNcx3cumPqb1+7u/h0sK7t2icwa543tSM
BNjX4Ay28Oe1DeaKGZd0w+xUQaPvRCr4SE3g7Qaw2EQt89VqT1qNzGGZmrV/KQMg
OQNP01C582OxBap+SKcYqinE1BVeXmTXf6vuIQZeyERJtfBApq/1/UvS1Azxd+3m
nPz0rPCU5e/vvCGFIG1M46DY8aWSwLibb07onDUTUoQ3Qh4igNiNCTvz7qPj6QM=
=0QEt
-----END PGP SIGNATURE-----

--tctmm6wHVGT/P6vA--

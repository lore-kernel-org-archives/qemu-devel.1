Received: from eggs.gnu.org ([2001:4830:134:3::10]:49719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fiHWK-0006S1-Fa
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 06:59:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fiHWH-00081C-IC
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 06:59:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36582 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fiHWH-00080a-DC
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 06:59:49 -0400
Date: Wed, 25 Jul 2018 11:59:45 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180725105944.GC2366@work-vm>
References: <0c215752-5cd2-3b7c-bc3c-f435f1dbbfed@bluestop.org>
	<d6acc012-fb6c-9f9d-9cbe-8dd92727c64b@redhat.com>
	<8bf07395-4872-ce74-c201-9fca232edd01@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <8bf07395-4872-ce74-c201-9fca232edd01@gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] RDMA wrongly detected as being supported on FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>, Rebecca Cran <rebecca@bluestop.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Yuval Shaia <yuval.shaia@oracle.com>

* Marcel Apfelbaum (marcel.apfelbaum@gmail.com) wrote:
> Hi,
>=20
> On 07/25/2018 10:32 AM, Thomas Huth wrote:
> > On 25.07.2018 06:47, Rebecca Cran wrote:
> > > In commit 18a398f6a39df4b08ff86ac0d38384193ca5f4cc, ./configure on
> > > FreeBSD incorrectly detects RDMA support,
>=20
> configure is looking for the rdma related libraries,=A0 if they are the=
re,
> the rdma code will be compiled into QEMU.
>=20
> You can try and run configure with --disable-rdma flag until we find
> a solution.

Note that this flag is tied to both the RMDA migration and the RDMA
device emulation; RDMA migration may well be working for the reporter.

Dave

> > >   with the build subsequently
> > > failing with:
> > >=20
> > > /home/bcran/workspace/qemu/hw/rdma/vmw/pvrdma_cmd.c:19:10: fatal er=
ror:
> > > 'linux/types.h' file not found
> > > #include <linux/types.h>
> > >  =A0=A0=A0=A0=A0=A0=A0=A0 ^~~~~~~~~~~~~~~
> Do you have the kernel-headers package installed?
>=20
> > > 1 error generated.
> > > gmake[1]: *** [/home/bcran/workspace/qemu/rules.mak:69:
> > > hw/rdma/vmw/pvrdma_cmd.o] Error 1
> > > gmake[1]: *** Waiting for unfinished jobs....
> > > gmake: *** [Makefile:481: subdir-x86_64-softmmu] Error 2
> > When was it still working for you the last time? Was it still working
> > with v3.0-rc1 ? Or just with v2.12 ? Any chance that you could bisect
> > the problem to determine when it has been introduced?
>=20
> Good idea.
>=20
> Thanks,
> Marcel
>=20
> >   Thomas
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

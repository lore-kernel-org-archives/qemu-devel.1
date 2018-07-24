Received: from eggs.gnu.org ([2001:4830:134:3::10]:39969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1fi2o4-0005LO-VU
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 15:17:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1fi2o1-0004Xe-IJ
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 15:17:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44692
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1fi2o1-0004TS-0L
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 15:17:09 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6OJEV6C116395
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 15:17:06 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ke79r0226-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 15:17:06 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 24 Jul 2018 15:17:05 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180724130743.4c7decdb.cohuck@redhat.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
	<20180723201748.25573-6-mdroth@linux.vnet.ibm.com>
	<153238409419.10934.1652388192245648682@sif>
	<20180724114004.67bc1281.cohuck@redhat.com>
	<20180724130743.4c7decdb.cohuck@redhat.com>
Date: Tue, 24 Jul 2018 14:16:55 -0500
Message-Id: <153245981571.10934.10102828599639224476@sif>
Subject: Re: [Qemu-devel] [PATCH 05/99] s390-ccw: force diag 308 subcode to
 unsigned long
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>

Quoting Cornelia Huck (2018-07-24 06:07:43)
> On Tue, 24 Jul 2018 11:40:04 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> =

> > On Mon, 23 Jul 2018 17:14:54 -0500
> > Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> > =

> > > Quoting Michael Roth (2018-07-23 15:16:14)  =

> > > > From: Cornelia Huck <cohuck@redhat.com>
> > > > =

> > > > We currently pass an integer as the subcode parameter. However,
> > > > the upper bits of the register containing the subcode need to
> > > > be 0, which is not guaranteed unless we explicitly specify the
> > > > subcode to be an unsigned long value.
> > > > =

> > > > Fixes: d046c51dad3 ("pc-bios/s390-ccw: Get device address via diag =
308/6")
> > > > Cc: qemu-stable@nongnu.org
> > > > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > > > Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > > > Tested-by: Thomas Huth <thuth@redhat.com>
> > > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > > (cherry picked from commit 63d8b5ace31c1e1f3996fe4cd551d6d377594d5a)
> > > > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>    =

> > > =

> > > Hi Cornelia,
> > > =

> > > Would you be able to do an s390 BIOS build for this one as well?  =

> > =

> > Sure, will do a build for 2.12-stable.
> =

> Here we go:
> =

> The following changes since commit e8488edcb3768f08cda7c3cc00def6b1b2f6c6=
15:
> =

>   tcg/i386: Mark xmm registers call-clobbered (2018-07-23 14:24:17 -0500)
> =

> are available in the Git repository at:
> =

>   git://github.com/cohuck/qemu tags/s390x-20180724-212-stable
> =

> for you to fetch changes up to c16427177a67bc86aa7560331143bfc9c885b27d:
> =

>   pc-bios/s390-ccw.img: update image for stable (2018-07-24 06:08:42 -040=
0)
> =

> ----------------------------------------------------------------
> update s390-ccw.img for stable
> =

> ----------------------------------------------------------------
> Cornelia Huck (1):
>       pc-bios/s390-ccw.img: update image for stable
> =

>  pc-bios/s390-ccw.img | Bin 30520 -> 30520 bytes
>  1 file changed, 0 insertions(+), 0 deletions(-)
> =

> (for-2.12-stable branch)

Applied, thanks!

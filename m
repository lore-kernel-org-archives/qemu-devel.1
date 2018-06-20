Received: from eggs.gnu.org ([2001:4830:134:3::10]:56837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1fVl4R-00053n-22
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 17:55:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1fVl4N-0008LO-2j
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 17:55:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37796
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1fVl4M-0008KU-Qc
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 17:55:15 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5KLrcoa042223
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 17:55:13 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2jqy51g741-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 17:55:13 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 20 Jun 2018 17:55:12 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <152952728499.8870.3711510048351515296@sif>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
	<20180619094248.08d5fed5.cohuck@redhat.com>
	<152952728499.8870.3711510048351515296@sif>
Date: Wed, 20 Jun 2018 16:55:05 -0500
Message-Id: <152953170557.8870.15609104033222049328@sif>
Subject: Re: [Qemu-devel] [PATCH 00/113] Patch Round-up for stable 2.11.2,
 freeze on 2018-06-22
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>

Quoting Michael Roth (2018-06-20 15:41:24)
> Quoting Cornelia Huck (2018-06-19 02:42:48)
> > On Mon, 18 Jun 2018 20:41:26 -0500
> > Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> > =

> > > Hi everyone,
> > > =

> > > The following new patches are queued for QEMU stable v2.11.2:
> > > =

> > >   https://github.com/mdroth/qemu/commits/stable-2.11-staging
> > > =

> > > The release is planned for 2018-06-22:
> > > =

> > >   https://wiki.qemu.org/Planning/2.11
> > > =

> > > Please respond here or CC qemu-stable@nongnu.org on any patches you
> > > think should be included in the release.
> > > =

> > > Thanks!
> > > =

> > > ----------------------------------------------------------------
> > > =

> > > The following changes since commit 7c1beb52ed86191d9e965444d934adaa25=
31710f:
> > > =

> > >   Update version for 2.11.1 release (2018-02-14 14:41:05 -0600)
> > > =

> > > are available in the git repository at:
> > > =

> > >   git://github.com/mdroth/qemu.git =

> > > =

> > > for you to fetch changes up to acb3571f90885a2e206044b3bdc8d1dd2a0389=
c0:
> > > =

> > >   arm_gicv3_kvm: kvm_dist_get/put_priority: skip the registers banked=
 by GICR_IPRIORITYR (2018-06-16 07:47:00 -0500)
> > > =

> > > ----------------------------------------------------------------
> > =

> > Hi Michael,
> > =

> > as this series includes some s390-ccw bios patches, it needs a rebuild
> > of the s390-ccw bios as well, probably on top of your stable branch.
> > (IIRC we have extra patches on master, so you probably don't want to
> > cherry-pick the latest rebuild from there.). Let me know if one of us
> > should provide a rebuild.
> > =

> =

> Thanks Cornelia, I hadn't realized that. I think rebuild from one of the
> maintainers would definitely be preferable. We'd also want the correspond=
ing
> patches for pc-bios/s390-ccw reflected in the 2.11.x tree.

Er, sorry was a bit confused. I suppose that part is covered already if
there's no additional patches needed in the rebuild other than what's in
2.11.x already.


> another maintainer could put together a branch with those I can merge
> those in directly.

Received: from eggs.gnu.org ([2001:4830:134:3::10]:35816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cnKE2-0008D9-Si
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 03:17:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cnKDz-0004g9-PP
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 03:17:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56514
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1cnKDz-0004fw-JG
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 03:16:59 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2D7ANdv130197
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 03:16:58 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 294e02409g-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 03:16:58 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Mon, 13 Mar 2017 03:16:58 -0400
Date: Mon, 13 Mar 2017 15:16:52 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170217082939.33208-1-bjsdjshi@linux.vnet.ibm.com>
	<20170309092525.GA10189@bjsdjshi@linux.vnet.ibm.com>
	<20170310114605.1353e810.cornelia.huck@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170310114605.1353e810.cornelia.huck@de.ibm.com>
Message-Id: <20170313071652.GD6756@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC v3 00/15] basic vfio-ccw infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, wkywang@linux.vnet.ibm.com

* Cornelia Huck <cornelia.huck@de.ibm.com> [2017-03-10 11:46:05 +0100]:

> On Thu, 9 Mar 2017 17:25:25 +0800
> Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> 
> > * Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> [2017-02-17 09:29:24 +0100]:
> > 
> > > vfio-ccw: the basic infrastructure
> > > ==================================
> > > 
> > > Introduction
> > > ------------
> > > 
> > > Here we describe the vfio support for I/O subchannel devices for
> > > Linux/s390. Motivation for vfio-ccw is to passthrough subchannels to a
> > > virtual machine, while vfio is the means.
> > > 
> > 
> > Ping.
> > 
> > Any more comment for this version?
> > 
> > Thanks.
> > 
> > [...]
> > 
Hey Conny,

> 
> I just walked through the patch set again and did not notice anything
> else. There's still the area of channel path handling, but I don't see
> why it shouldn't be able to fit into the infrastructure you introduce
> here. (I'd expect most of the interesting stuff there to be handled in
> user space anyway.)
Thanks! I have the same expectation for the channel path handling part.

> 
> You should update MAINTAINERS, though. I'm not sure the s390 cio folks
> are prepared to handle vfio-ccw :) (although I think you should cc:
> them on the patches exporting cio interfaces.) It's probably best to
> take vfio-ccw through the kvm-s390 tree.

Beside the fixes for former comments form you and Alex, I will also do
the following stuff in the next version:
1. Remove the "RFC" tag from the mail subject.
2. Cc the s390 CIO layer maintainers for patch 1 and 2:
    Sebastian Ott <sebott@linux.vnet.ibm.com>
    Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
3. For the new created files, update MAINTAINERS by adding:
S390 VFIO-CCW DRIVER
M:	Cornelia Huck <cornelia.huck@de.ibm.com>
L:	linux-s390@vger.kernel.org
L:	kvm@vger.kernel.org
S:	Supported
F:	drivers/s390/cio/vfio_ccw*
F:	Documentation/s390/vfio-ccw.txt
F:	include/uapi/linux/vfio_ccw.h

-- 
Dong Jia

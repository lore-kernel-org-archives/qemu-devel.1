Received: from eggs.gnu.org ([2001:4830:134:3::10]:42171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1d7bGY-0006IR-JR
	for qemu-devel@nongnu.org; Mon, 08 May 2017 01:31:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1d7bGV-0006bV-Cc
	for qemu-devel@nongnu.org; Mon, 08 May 2017 01:31:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44885
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1d7bGV-0006bR-7J
	for qemu-devel@nongnu.org; Mon, 08 May 2017 01:31:23 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v485NkUp043079
	for <qemu-devel@nongnu.org>; Mon, 8 May 2017 01:31:22 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2aadne38au-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 01:31:22 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Mon, 8 May 2017 01:31:21 -0400
Date: Mon, 8 May 2017 13:31:17 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170505020352.8984-1-bjsdjshi@linux.vnet.ibm.com>
	<20170505142234.487dfda9.cornelia.huck@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170505142234.487dfda9.cornelia.huck@de.ibm.com>
Message-Id: <20170508053117.GE15974@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v7 00/13] basic channel IO passthrough
 infrastructure based on vfio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, eric.auger@redhat.com

* Cornelia Huck <cornelia.huck@de.ibm.com> [2017-05-05 14:22:34 +0200]:

> On Fri,  5 May 2017 04:03:39 +0200
> Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> 
> > The patch series introduce a basic channel I/O passthrough
> > infrastructure based on vfio.
> > - Focus on supporting dasd-eckd(cu_type/dev_type = 0x3990/0x3390) as
> >   the target device. 
> > - Support new qemu parameters in the style of:
> >     -machine s390-ccw-virtio(,s390-squash-mcss=on|off) \
> >     -device vfio-ccw,sysfsdev=$MDEV_PATH
> >   We want to support real (i.e. not virtual) channel devices even for
> >   guests that do not support MCSS-E (where guests may see devices from
> >   any channel subsystem image at once). As all virtio-ccw devices are in
> >   css 0xfe (and show up in the default css 0 for guests not activating
> >   MCSS-E), we need an option to squash e.g. passed-through channel devices
> >   from their real css (0-3, or 0 for hosts not activating MCSS-E) into
> >   the default css, that is what the new machine option s390-squash-css is
> >   added.
> 
> Basically looks good, some small nitpicking and the virtual vs. virtio
> issue I noticed.
Thanks for the review! I replied in the coressponding threads.

> 
> Let's wait if others have more comments. Hopefully, the 3270 changes
> will by then be in master and you can rebase on top of them :)
Roger!

-- 
Dong Jia Shi

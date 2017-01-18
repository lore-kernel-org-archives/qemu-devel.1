Received: from eggs.gnu.org ([2001:4830:134:3::10]:45196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cTgpX-0004sQ-LF
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 22:22:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cTgpU-0006mg-Gl
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 22:22:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38694
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1cTgpU-0006lb-BI
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 22:22:32 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0I3IfEV015573
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 22:22:31 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0b-001b2d01.pphosted.com with ESMTP id 281yknhd29-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 22:22:31 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Tue, 17 Jan 2017 20:22:30 -0700
Date: Wed, 18 Jan 2017 11:22:23 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170112072513.98411-1-bjsdjshi@linux.vnet.ibm.com>
	<20170112072513.98411-8-bjsdjshi@linux.vnet.ibm.com>
	<20170117154928.6b7886fb@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170117154928.6b7886fb@t450s.home>
Message-Id: <20170118032223.GO30301@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC v2 07/12] vfio/ccw: vfio based
 subchannel passthrough driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, wkywang@linux.vnet.ibm.com

* Alex Williamson <alex.williamson@redhat.com> [2017-01-17 15:49:28 -0700]:

> On Thu, 12 Jan 2017 08:25:08 +0100
> Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> 
> > From: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
> > 
> > We use the IOMMU_TYPE1 of VFIO to realize the subchannels
> > passthrough, implement a vfio based subchannels passthrough
> > driver called "vfio-ccw".
> > 
> > Support qemu parameters in the style of:
> > "-device vfio-ccw,id=xx,hostid=xx(,guestid=xx),mdevid=xx"
> 
> Why not adopt the same syntax as vfio-pci with mdev devices,
> sysfsdev=%s where %s is a path to the mdev device in sysfs, which can
> be /sys/bus/mdev/devices/$UUID or as you create from the hostid
> below /sys/bus/css/devices/%x.%x.%04x/$UUID.
Ok. This is a good point.

I will change the cmdline interface to:
-device vfio-ccw,id=xx,sysfsdev=xx(,devno=xx)

Since "hostid" is removed, I will also rename "guestid" to "devno" to
make it looking consistent with the virtio-ccw devices.

> It seems if we know where
> to find the mdev device then we can determine the parent information on
> our own through sysfs.
> 
This is true.

> > Signed-off-by: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
[...]

-- 
Dong Jia

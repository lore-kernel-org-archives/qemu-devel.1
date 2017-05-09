Received: from eggs.gnu.org ([2001:4830:134:3::10]:51124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1d80cd-0000wo-38
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:35:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1d80cZ-0007n0-2D
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:35:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55939
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1d80cY-0007mW-Sx
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:35:50 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v498SxPZ027446
	for <qemu-devel@nongnu.org>; Tue, 9 May 2017 04:35:49 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ab91ev0ha-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 04:35:49 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Tue, 9 May 2017 04:35:49 -0400
Date: Tue, 9 May 2017 16:35:42 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170505020352.8984-1-bjsdjshi@linux.vnet.ibm.com>
	<20170505020352.8984-10-bjsdjshi@linux.vnet.ibm.com>
	<1c84ffc3-70fa-f6b7-fd10-def952d02a84@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c84ffc3-70fa-f6b7-fd10-def952d02a84@redhat.com>
Message-Id: <20170509083542.GA5827@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v7 09/13] vfio/ccw: get irqs info and set
 the eventfd fd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com

* Auger Eric <eric.auger@redhat.com> [2017-05-09 10:21:15 +0200]:

Hi Eric,

> Hi,
> 
> On 05/05/2017 04:03, Dong Jia Shi wrote:
> > vfio-ccw resorts to the eventfd mechanism to communicate with userspace.
> > We fetch the irqs info via the ioctl VFIO_DEVICE_GET_IRQ_INFO,
> > register a event notifier to get the eventfd fd which is sent
> > to kernel via the ioctl VFIO_DEVICE_SET_IRQS, then we can implement
> > read operation once kernel sends the signal.
> > 
> > Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks for all of your R-Bs! I will add them in next version. :>

> 
> Thanks
> 
> Eric
> 

[...]

-- 
Dong Jia Shi

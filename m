Received: from eggs.gnu.org ([2001:4830:134:3::10]:36356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cqVgN-0000fo-SL
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 22:07:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cqVgI-000259-Ub
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 22:07:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49119
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1cqVgI-00020x-OB
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 22:07:22 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2M23bUa082895
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 22:07:19 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29b9vp747m-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 22:07:19 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Tue, 21 Mar 2017 22:07:18 -0400
Date: Wed, 22 Mar 2017 10:07:11 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170317031743.40128-1-bjsdjshi@linux.vnet.ibm.com>
	<20170317031743.40128-12-bjsdjshi@linux.vnet.ibm.com>
	<20170321124724.3277f097@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170321124724.3277f097@t450s.home>
Message-Id: <20170322020711.GO10704@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 11/16] vfio: ccw: realize
 VFIO_DEVICE_G(S)ET_IRQ_INFO ioctls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

* Alex Williamson <alex.williamson@redhat.com> [2017-03-21 12:47:24 -0600]:

[...]
> > @@ -458,6 +459,11 @@ enum {
> >  	VFIO_CCW_NUM_REGIONS
> >  };
> >  
> > +enum {
> > +	VFIO_CCW_IO_IRQ_INDEX,
> > +	VFIO_CCW_NUM_IRQS
> > +};
> > +
> >  /**
> >   * VFIO_DEVICE_GET_PCI_HOT_RESET_INFO - _IORW(VFIO_TYPE, VFIO_BASE + 12,
> >   *					      struct vfio_pci_hot_reset_info)
> 
> 
> Acked-by: Alex Williamson <alex.williamson@redhat.com>
> 
Hi Alex,

Thanks for all the Acked-bys. :>

-- 
Dong Jia

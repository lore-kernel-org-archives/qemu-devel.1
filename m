Received: from eggs.gnu.org ([2001:4830:134:3::10]:46024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1crJaW-0006tv-Eo
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 03:24:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1crJaR-0004uu-HN
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 03:24:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53149)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1crJaR-0004uU-7i
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 03:24:39 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2O7OUv5103014
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 03:24:37 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29cm3tus1n-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 03:24:36 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Fri, 24 Mar 2017 03:24:21 -0400
Date: Fri, 24 Mar 2017 15:24:15 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170317031743.40128-1-bjsdjshi@linux.vnet.ibm.com>
	<20170317031743.40128-2-bjsdjshi@linux.vnet.ibm.com>
	<alpine.LFD.2.20.1703231249220.3020@schleppi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.20.1703231249220.3020@schleppi>
Message-Id: <20170324072415.GY10704@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 01/16] s390: cio: introduce
 cio_cancel_halt_clear
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, Cornelia Huck <cornelia.huck@de.ibm.com>, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>

* Sebastian Ott <sebott@linux.vnet.ibm.com> [2017-03-23 12:51:40 +0100]:

> On Fri, 17 Mar 2017, Dong Jia Shi wrote:
> > For future code reuse purpose, this decouples the cio code with
> > the ccw device specific parts from ccw_device_cancel_halt_clear,
> > and makes a new common I/O interface named cio_cancel_halt_clear.
> > 
> > Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> > Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>
> > Cc: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
> [...]
> > +/**
> > + * cio_cancel_halt_clear - Cancel running I/O by performing cancel, halt
> > + * and clear ordinally if subchannel is valid.
> > + * @sch: subchannel on which to perform the cancel_halt_clear operation
> > + * @iretry: the number of the times remained to retry the next operation
> > + *
> > + * This should be called repeatedly since halt/clear are asynchronous
> > + * operations. We do one try with cio_cancel, two tries with cio_halt,
>                                                  ^
>                                                  three
Ok. Nice catch!

> 
> Acked-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
Thanks.

-- 
Dong Jia Shi

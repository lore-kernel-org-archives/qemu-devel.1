Received: from eggs.gnu.org ([2001:4830:134:3::10]:35240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cg56R-0003sy-3E
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 02:43:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cg56N-0005q3-Rx
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 02:43:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38527
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1cg56N-0005pf-Ld
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 02:43:11 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1L7ciWM078416
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 02:43:10 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28r8s8h2ys-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 02:43:09 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Tue, 21 Feb 2017 00:43:09 -0700
Date: Tue, 21 Feb 2017 15:43:02 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170217082939.33208-1-bjsdjshi@linux.vnet.ibm.com>
	<20170217082939.33208-5-bjsdjshi@linux.vnet.ibm.com>
	<20170220193113.3ba5af2c.cornelia.huck@de.ibm.com>
	<20170221073623.GJ562@bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170221073623.GJ562@bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170221074302.GK562@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC v3 04/15] vfio: ccw: basic
 implementation for vfio_ccw driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, wkywang@linux.vnet.ibm.com

* Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> [2017-02-21 15:36:23 +0800]:

[...]
> > > +static int vfio_ccw_sch_probe(struct subchannel *sch)
> > > +{
> > > +	struct pmcw *pmcw = &sch->schib.pmcw;
> > > +	struct vfio_ccw_private *private;
> > > +	int ret;
> > > +
> > > +	if (pmcw->qf) {
> > > +		dev_warn(&sch->dev, "vfio: ccw: do not support QDIO: %s\n",
> > 
> > s/do/does/
> > 
> Ok.
> 
> > > +			 dev_name(&sch->dev));
> > > +		return -ENOTTY;
> > 
> > Is -ENOTTY the right return code here? -EINVAL?
> > 
> Ok. Think it again. -EINVAL makes more sense. It's like:
> "hey, I know it's an I/O subchannel, but not the kind we support".
> 
Or -ENOTSUPP ?
> > > +	}
> > > +
[...]

-- 
Dong Jia

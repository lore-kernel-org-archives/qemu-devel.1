Received: from eggs.gnu.org ([2001:4830:134:3::10]:41828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1d7bEn-0005bx-S7
	for qemu-devel@nongnu.org; Mon, 08 May 2017 01:29:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1d7bEk-0006Du-M0
	for qemu-devel@nongnu.org; Mon, 08 May 2017 01:29:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59786
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1d7bEk-0006Dn-FN
	for qemu-devel@nongnu.org; Mon, 08 May 2017 01:29:34 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v485Nkaf055725
	for <qemu-devel@nongnu.org>; Mon, 8 May 2017 01:29:33 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2aaj25s54h-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 01:29:33 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Mon, 8 May 2017 01:29:32 -0400
Date: Mon, 8 May 2017 13:29:27 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170505020352.8984-1-bjsdjshi@linux.vnet.ibm.com>
	<20170505020352.8984-14-bjsdjshi@linux.vnet.ibm.com>
	<20170505142014.28c849b8.cornelia.huck@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170505142014.28c849b8.cornelia.huck@de.ibm.com>
Message-Id: <20170508052927.GD15974@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v7 13/13] MAINTAINERS: Add vfio-ccw
 maintainer
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

* Cornelia Huck <cornelia.huck@de.ibm.com> [2017-05-05 14:20:14 +0200]:

> On Fri,  5 May 2017 04:03:52 +0200
> Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> 
> > Add Cornelia Huck as the vfio-ccw maintainer.
> > 
> > Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > ---
> >  MAINTAINERS | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index cae3b09..c1f9917 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -999,6 +999,11 @@ S: Supported
> >  F: hw/vfio/*
> >  F: include/hw/vfio/
> > 
> > +vfio-ccw
> > +M: Cornelia Huck <cornelia.huck@de.ibm.com>
> > +S: Supported
> > +F: hw/vfio/ccw.c
> 
> The other code related to vfio-ccw is entangled with the other virtual
> css code, so this is probably really the only file that needs to be
> listed separately.
"hw/s390x/" and "include/hw/s390x/" are listed under the "S390 Machines"
part.

Maybe you would like to list the following files separately here:
hw/s390x/s390-ccw.c
hw/s390x/s390-ccw.h

> 
> I will likely take any vfio-ccw changes together with the other code I
> take through s390-next. I'll add the respective line when I apply.
Ok. Leave this to you. :>

> 
> > +
> >  vhost
> >  M: Michael S. Tsirkin <mst@redhat.com>
> >  S: Supported
> 

-- 
Dong Jia Shi

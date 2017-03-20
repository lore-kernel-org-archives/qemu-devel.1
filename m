Received: from eggs.gnu.org ([2001:4830:134:3::10]:41798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cplwd-00074G-62
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 21:17:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cplwa-0005Bo-17
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 21:17:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32931
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1cplwZ-0005BX-Rd
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 21:17:07 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2K13cq6044513
	for <qemu-devel@nongnu.org>; Sun, 19 Mar 2017 21:17:04 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2990scgxby-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 19 Mar 2017 21:17:04 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Sun, 19 Mar 2017 21:17:04 -0400
Date: Mon, 20 Mar 2017 09:16:57 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170317031743.40128-1-bjsdjshi@linux.vnet.ibm.com>
	<20170317031743.40128-2-bjsdjshi@linux.vnet.ibm.com>
	<alpine.LFD.2.20.1703171023360.3003@schleppi>
	<20170317093953.GP6839@bjsdjshi@linux.vnet.ibm.com>
	<alpine.LFD.2.20.1703171047330.3003@schleppi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.20.1703171047330.3003@schleppi>
Message-Id: <20170320011657.GT6839@bjsdjshi@linux.vnet.ibm.com>
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

* Sebastian Ott <sebott@linux.vnet.ibm.com> [2017-03-17 10:51:20 +0100]:

> On Fri, 17 Mar 2017, Dong Jia Shi wrote:
> > * Sebastian Ott <sebott@linux.vnet.ibm.com> [2017-03-17 10:26:51 +0100]:
> > 
> > > On Fri, 17 Mar 2017, Dong Jia Shi wrote:
> > > > For future code reuse purpose, this decouples the cio code with
> > > > the ccw device specific parts from ccw_device_cancel_halt_clear,
> > > > and makes a new common I/O interface named cio_cancel_halt_clear.
> > > 
> > > What would the user of cio_cancel_halt_clear be?
> > Hi Sebastian,
> > 
> > We are trying to introduce a new I/O subchannel driver to enable usage
> > of I/O subchannels via VFIO-CCW, so we can passthru a subchannel to a
> > KVM guest. And that new vfio-ccw subchannel driver is the user. :>
> 
> OK, thanks for the explanation. May I suggest that you put these patches
> in the series that actually introduces the new subchannel driver.
> 
Hi Sebastian,

For your reference, information of the current patch series could be
found by searching/accessing:
Subject: [PATCH v4 00/16] basic vfio-ccw infrastructure
Message-Id: <20170317031743.40128-1-bjsdjshi@linux.vnet.ibm.com>
https://www.mail-archive.com/qemu-devel@nongnu.org/msg438029.html

I could put you on Cc, if you would like to recieve updates of the whole
patch series.

> Sebastian
-- 
Dong Jia

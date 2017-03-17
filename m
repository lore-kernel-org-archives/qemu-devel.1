Received: from eggs.gnu.org ([2001:4830:134:3::10]:51318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sebott@linux.vnet.ibm.com>) id 1cooXm-0001Lz-51
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 05:51:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sebott@linux.vnet.ibm.com>) id 1cooXi-00052S-7y
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 05:51:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59289)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sebott@linux.vnet.ibm.com>)
	id 1cooXh-00052F-VC
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 05:51:30 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2H9o4p7028511
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 05:51:28 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 297yywntu4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 05:51:27 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sebott@linux.vnet.ibm.com>;
	Fri, 17 Mar 2017 09:51:25 -0000
Date: Fri, 17 Mar 2017 10:51:20 +0100 (CET)
From: Sebastian Ott <sebott@linux.vnet.ibm.com>
In-Reply-To: <20170317093953.GP6839@bjsdjshi@linux.vnet.ibm.com>
References: <20170317031743.40128-1-bjsdjshi@linux.vnet.ibm.com>
	<20170317031743.40128-2-bjsdjshi@linux.vnet.ibm.com>
	<alpine.LFD.2.20.1703171023360.3003@schleppi>
	<20170317093953.GP6839@bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <alpine.LFD.2.20.1703171047330.3003@schleppi>
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
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, Cornelia Huck <cornelia.huck@de.ibm.com>, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>

On Fri, 17 Mar 2017, Dong Jia Shi wrote:
> * Sebastian Ott <sebott@linux.vnet.ibm.com> [2017-03-17 10:26:51 +0100]:
> 
> > On Fri, 17 Mar 2017, Dong Jia Shi wrote:
> > > For future code reuse purpose, this decouples the cio code with
> > > the ccw device specific parts from ccw_device_cancel_halt_clear,
> > > and makes a new common I/O interface named cio_cancel_halt_clear.
> > 
> > What would the user of cio_cancel_halt_clear be?
> Hi Sebastian,
> 
> We are trying to introduce a new I/O subchannel driver to enable usage
> of I/O subchannels via VFIO-CCW, so we can passthru a subchannel to a
> KVM guest. And that new vfio-ccw subchannel driver is the user. :>

OK, thanks for the explanation. May I suggest that you put these patches
in the series that actually introduces the new subchannel driver.

Sebastian

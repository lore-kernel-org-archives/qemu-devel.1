Received: from eggs.gnu.org ([2001:4830:134:3::10]:49779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cooPV-0007bA-EG
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 05:43:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cooPQ-00026c-Ip
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 05:43:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1cooPQ-00026J-9L
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 05:42:56 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2H9d4tU128304
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 05:42:54 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 297yvbnqa5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 05:42:54 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Fri, 17 Mar 2017 03:42:53 -0600
Date: Fri, 17 Mar 2017 17:42:48 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170317031743.40128-1-bjsdjshi@linux.vnet.ibm.com>
	<20170317031743.40128-3-bjsdjshi@linux.vnet.ibm.com>
	<alpine.LFD.2.20.1703171027130.3003@schleppi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.20.1703171027130.3003@schleppi>
Message-Id: <20170317094248.GQ6839@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 02/16] s390: cio: export more interfaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>

* Sebastian Ott <sebott@linux.vnet.ibm.com> [2017-03-17 10:29:31 +0100]:

> On Fri, 17 Mar 2017, Dong Jia Shi wrote:
> > Export the common I/O interfaces those are needed by an I/O
> > subchannel driver to actually talk to the subchannel.
> 
> Which I/O subchannel driver are you talking about? I know of just one
> and it can't be build as a module.
As I replied to you in another email, there will be a new I/O subchannel
driver which is named as vfio-ccw subchannel driver. That driver could
be built as a module, thus it needs these interfaces be exported.

> 
> Sebastian

-- 
Dong Jia

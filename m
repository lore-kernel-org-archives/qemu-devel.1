Received: from eggs.gnu.org ([2001:4830:134:3::10]:45219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dGHOn-0004hb-JT
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 00:07:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dGHOk-0001cT-TO
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 00:07:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42839)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1dGHOk-0001aD-IO
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 00:07:46 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5143g3E026812
	for <qemu-devel@nongnu.org>; Thu, 1 Jun 2017 00:07:44 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2at9k8vjuu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 00:07:43 -0400
Received: from localhost
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Thu, 1 Jun 2017 14:07:41 +1000
Date: Thu, 1 Jun 2017 09:36:46 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <20170601015218.9299-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170601015218.9299-1-david@gibson.dropbear.id.au>
Message-Id: <20170601040646.GB27525@in.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] spapr:DRC cleanups (part I)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: mdroth@linux.vnet.ibm.com, lvivier@redhat.com, nikunj@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, sursingh@redhat.com

On Thu, Jun 01, 2017 at 11:52:14AM +1000, David Gibson wrote:
> The code managing DRCs[0] has quite a few things that are more
> complicated than they need to be.  In particular the object
> representing a DRC has a bunch of method pointers, despite the fact
> that there are currently no subclasses, and even if there were the
> method implementations would be unlikely to differ.

So you are getting rid of a few methods. How about other methods ?
Specially attach and detach which have incorporated all the logic needed
to handle logical and physical DRs into their implementations ?

Guess these will be follow in subequent parts ? 

Regards,
Bharata.

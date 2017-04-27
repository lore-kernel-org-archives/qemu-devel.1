Received: from eggs.gnu.org ([2001:4830:134:3::10]:39620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1d3cyy-0006cl-B0
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 02:32:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1d3cyv-0003kt-8S
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 02:32:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56890)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam.bobroff@au1.ibm.com>)
	id 1d3cyu-0003jJ-Vc
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 02:32:49 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3R6TBP1081969
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 02:32:46 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a39dnc2t9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 02:32:45 -0400
Received: from localhost
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sam.bobroff@au1.ibm.com>;
	Thu, 27 Apr 2017 16:32:43 +1000
Date: Thu, 27 Apr 2017 16:31:43 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-Id: <20170427063143.GA11487@tungsten.ozlabs.ibm.com>
Subject: [Qemu-devel] [PATCH 0/2] ppc/xics: preserve P and Q bits for KVM
 IRQs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au

Hi QEMU,

As explained in the notes for the second patch, this is a change to hook up
some new bits that have been added to KVM's XICS IRQs along with a small fix
for a problem I noticed along the way.

I tested by instrumenting the code directly, better ideas are welcome!

Cheers,
Sam.


Sam Bobroff (2):
  ppc/xics: Fix stale irq->status bits after get
  ppc/xics: preserve P and Q bits for KVM IRQs

 hw/intc/xics_kvm.c    | 13 +++++++++++++
 include/hw/ppc/xics.h |  2 ++
 2 files changed, 15 insertions(+)

-- 
2.12.1.382.gc0f9c7058

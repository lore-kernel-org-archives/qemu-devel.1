Received: from eggs.gnu.org ([2001:4830:134:3::10]:38781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dk8EB-00076j-PB
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 08:24:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dk8E7-0006he-Ml
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 08:24:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37526
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dk8E7-0006hJ-FU
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 08:24:11 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7MCO9qi131945
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 08:24:11 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cgk0qy98b-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 08:24:10 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Tue, 22 Aug 2017 08:23:50 -0400
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Tue, 22 Aug 2017 09:23:26 -0300
Message-Id: <20170822122327.9567-1-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2] target/ppc: 'PVR != host PVR' in
 KVM_SET_SREGS workaround
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, mdroth@linux.vnet.ibm.com, lvivier@redhat.com

v2:
- added Laurent's fix in 'kvmppc_pvr_workaround_required' to avoid
returning true when running with TCG.


Daniel Henrique Barboza (1):
  target/ppc: 'PVR != host PVR' in KVM_SET_SREGS workaround

 target/ppc/kvm.c     | 34 ++++++++++++++++++++++++++++++++++
 target/ppc/kvm_ppc.h |  1 +
 target/ppc/machine.c | 22 ++++++++++++++++++++++
 3 files changed, 57 insertions(+)

-- 
2.9.4

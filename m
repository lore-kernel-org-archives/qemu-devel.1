Received: from eggs.gnu.org ([2001:4830:134:3::10]:48507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1dd9d6-0005Ra-Ss
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 02:29:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1dd9d3-0007Rd-Oq
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 02:29:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51166
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam.bobroff@au1.ibm.com>)
	id 1dd9d3-0007Ql-Id
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 02:29:05 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v736Sfxs093941
	for <qemu-devel@nongnu.org>; Thu, 3 Aug 2017 02:29:05 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2c3v7xyfnt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 02:29:04 -0400
Received: from localhost
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sam.bobroff@au1.ibm.com>;
	Thu, 3 Aug 2017 16:29:02 +1000
Date: Thu, 3 Aug 2017 16:28:02 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-Id: <cover.1501740002.git.sam.bobroff@au1.ibm.com>
Subject: [Qemu-devel] [PATCH 0/4] Cleanup cpu_dt_id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: david@gibson.dropbear.id.au, agraf@suse.de


In preparation for some other work in this area, here is a patch set that
cleans up some of the code around the cpu_dt_id field of struct PowerPCCPU.

It includes a bugfix for h_signal_sys_reset() because the code there uses the
cpu_dt_id field and it would need to be changed by this set anyway.

(Alexander Graf: I've CC'd you because you're the maintainer of the e500 code.)

Thanks to David Gibson for assistance with the design.


Sam Bobroff (4):
  spapr: Fix bug in h_signal_sys_reset()
  e500: Use cpu_index instead of vcpu_dt_id
  ppc: spapr: Rename cpu_dt_id to vcpu_id
  ppc: spapr: Make VCPU ID handling private to SPAPR

 hw/ppc/e500.c               |  8 ++------
 hw/ppc/ppc.c                | 21 ---------------------
 hw/ppc/spapr.c              | 36 ++++++++++++++++++++++++++++--------
 hw/ppc/spapr_hcall.c        | 11 +++++------
 hw/ppc/spapr_rtas.c         |  4 ++--
 include/hw/ppc/spapr.h      |  3 +++
 target/ppc/cpu.h            | 20 +-------------------
 target/ppc/kvm.c            |  2 +-
 target/ppc/translate_init.c |  8 ++++----
 9 files changed, 46 insertions(+), 67 deletions(-)

-- 
2.12.1.382.gc0f9c7058

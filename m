Received: from eggs.gnu.org ([2001:4830:134:3::10]:33606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dBfCf-0000IL-WD
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:32:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dBfCc-0007hl-Oe
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:32:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41339)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dBfCc-0007fy-FY
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:32:10 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4JAUAVo091829
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 06:32:02 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ahrwmysxf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 06:32:02 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 19 May 2017 04:32:01 -0600
From: Greg Kurz <groug@kaod.org>
Date: Fri, 19 May 2017 12:31:55 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <149518991537.24289.6673616934370284758.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH v2 0/4] spapr/xics: fix migration of older
 machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Cedric Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

v2: - some patches from v1 are already merged in ppc-for-2.10
    - added a new fix to a potential memory leak (patch 1)
    - consolidate dt_id computation (patch 3)
    - see individual changelogs for patch 2 and 4

This series is based on:

https://github.com/dgibson/qemu.git ppc-for-2.10

I could successfully migrate from QEMU 2.9 and back, including when the guest
has different threads per core than the host and hotplugging cores between
each migration attempt.

--
Greg

---

Greg Kurz (4):
      spapr_cpu_core: drop reference on ICP object during CPU realization
      spapr: fix error reporting in xics_system_init()
      target/ppc: consolidate CPU device-tree id computation in helper
      spapr: fix migration of ICP objects from/to older QEMU


 hw/ppc/spapr.c              |   57 +++++++++++++++++++++++++++++++++++--------
 hw/ppc/spapr_cpu_core.c     |   28 +++++++++++++++------
 include/hw/ppc/spapr.h      |    2 ++
 target/ppc/cpu.h            |   17 +++++++++++++
 target/ppc/translate_init.c |    3 +-
 5 files changed, 86 insertions(+), 21 deletions(-)

Received: from eggs.gnu.org ([2001:4830:134:3::10]:46302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dDArL-0002TN-Ha
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:32:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dDArH-00081S-Hw
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:32:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39945)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dDArH-000814-9P
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:32:23 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4NEVUl0098679
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 10:32:21 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2am8pdm8u4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 10:32:21 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 23 May 2017 08:32:20 -0600
From: Greg Kurz <groug@kaod.org>
Date: Tue, 23 May 2017 16:32:15 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <149554993519.23396.2947622015408783770.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: [Qemu-devel] [PATCH v2 0/4] 9pfs: local: fix metadata of
 mapped-file security mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Leo Gaspard <leo@gaspard.io>, Eric Blake <eblake@redhat.com>, Greg Kurz <groug@kaod.org>

v2: - posted patch for CVE-2017-7493 separately
    - other changes available in each patch changelog

Leo,

If you find time to test this series, I'll gladly add your Tested-by: to
it before merging.

Cheers,

--
Greg

---

Greg Kurz (4):
      9pfs: check return value of v9fs_co_name_to_path()
      9pfs: local: resolve special directories in paths
      9pfs: local: simplify file opening
      9pfs: local: metadata file for the VirtFS root


 hw/9pfs/9p-local.c |  147 ++++++++++++++++++++++++++++++++++++++--------------
 hw/9pfs/9p-util.c  |   43 ---------------
 hw/9pfs/9p-util.h  |    2 -
 hw/9pfs/9p.c       |   36 +++++++++----
 4 files changed, 133 insertions(+), 95 deletions(-)

Received: from eggs.gnu.org ([2001:4830:134:3::10]:48326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dBjEq-0004K0-Lk
	for qemu-devel@nongnu.org; Fri, 19 May 2017 10:50:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dBjEn-0004Jx-JH
	for qemu-devel@nongnu.org; Fri, 19 May 2017 10:50:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40392)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dBjEn-0004IJ-A1
	for qemu-devel@nongnu.org; Fri, 19 May 2017 10:50:41 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4JEc6f7078356
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 10:50:37 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ahw460hnp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 10:50:37 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 19 May 2017 10:50:36 -0400
From: Greg Kurz <groug@kaod.org>
Date: Fri, 19 May 2017 16:50:31 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <149520531371.9327.383828886525307842.stgit@bahia>
Subject: [Qemu-devel] [PATCH 0/2] get rid of qemu_utimens()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Greg Kurz <groug@kaod.org>

It is currently only used by 9pfs and virtfs-proxy-helper. This series convert
them to utimensat() and futimens().

--
Greg

---

Greg Kurz (2):
      9pfs: assume utimensat() and futimens() are present
      util: drop old utimensat() compat code


 configure                   |   22 --------------------
 fsdev/virtfs-proxy-helper.c |    3 ++-
 hw/9pfs/9p-handle.c         |    5 -----
 include/sysemu/os-posix.h   |   11 ----------
 util/oslib-posix.c          |   47 -------------------------------------------
 5 files changed, 2 insertions(+), 86 deletions(-)

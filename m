Received: from eggs.gnu.org ([2001:4830:134:3::10]:42967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cFHTP-0000P2-LH
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 04:28:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cFHTL-00006X-Lu
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 04:28:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35217)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cFHTL-000060-BT
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 04:28:07 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB99PJXl091220
	for <qemu-devel@nongnu.org>; Fri, 9 Dec 2016 04:28:06 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 277rtm32eg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 09 Dec 2016 04:28:06 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 9 Dec 2016 02:28:05 -0700
From: Greg Kurz <groug@kaod.org>
Date: Fri, 09 Dec 2016 10:28:00 +0100
In-Reply-To: <148127558476.2633.13433882390740185948.stgit@bahia>
References: <148127558476.2633.13433882390740185948.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148127568042.2633.5084932697061472826.stgit@bahia>
Subject: [Qemu-devel] [PATCH 3/8] 9pfs: fix P9_NOTAG and P9_NOFID macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

The u16 and u32 types don't exist in QEMU common headers. It never broke
build because these two macros aren't use by the current code, but this
is about to change with the future addition of functional tests for 9P.

This patch convert the types to uintXX_t.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index 3976b7fe3dcd..89c904bdb7e7 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -99,8 +99,8 @@ enum p9_proto_version {
     V9FS_PROTO_2000L = 0x02,
 };
 
-#define P9_NOTAG    (u16)(~0)
-#define P9_NOFID    (u32)(~0)
+#define P9_NOTAG    (uint16_t)(~0)
+#define P9_NOFID    (uint32_t)(~0)
 #define P9_MAXWELEM 16
 
 #define FID_REFERENCED          0x1

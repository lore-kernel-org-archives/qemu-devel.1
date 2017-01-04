Received: from eggs.gnu.org ([2001:4830:134:3::10]:57771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cOgq4-000754-P6
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 03:22:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cOgq1-0000Cm-Lo
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 03:22:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43265
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cOgq1-0000Cd-Fw
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 03:22:25 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v048J4bY143850
	for <qemu-devel@nongnu.org>; Wed, 4 Jan 2017 03:22:24 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27ruqcus1y-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 03:22:24 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Wed, 4 Jan 2017 08:22:23 -0000
From: Greg Kurz <groug@kaod.org>
Date: Wed,  4 Jan 2017 09:21:42 +0100
In-Reply-To: <1483518107-13218-1-git-send-email-groug@kaod.org>
References: <1483518107-13218-1-git-send-email-groug@kaod.org>
Message-Id: <1483518107-13218-9-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 08/13] 9pfs: fix P9_NOTAG and P9_NOFID macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>

The u16 and u32 types don't exist in QEMU common headers. It never broke
build because these two macros aren't use by the current code, but this
is about to change with the future addition of functional tests for 9P.

Also, these should have enclosing parenthesis to be usable in any
syntactical situation.

As suggested by Eric Blake, let's use UINT16_MAX and UINT32_MAX to address
both issues.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index 4c4feafa2e97..b7e836251e13 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -99,8 +99,8 @@ enum p9_proto_version {
     V9FS_PROTO_2000L = 0x02,
 };
 
-#define P9_NOTAG    (u16)(~0)
-#define P9_NOFID    (u32)(~0)
+#define P9_NOTAG    UINT16_MAX
+#define P9_NOFID    UINT32_MAX
 #define P9_MAXWELEM 16
 
 #define FID_REFERENCED          0x1
-- 
2.7.4

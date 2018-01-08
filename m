Received: from eggs.gnu.org ([2001:4830:134:3::10]:34454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eYYRn-0004TZ-6a
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:30:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eYYRk-0007Ig-F5
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:30:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42708)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eYYRk-0007I3-7L
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:30:40 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.21) with SMTP id
	w08EUQ1f015394
	for <qemu-devel@nongnu.org>; Mon, 8 Jan 2018 09:30:36 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fc8yd4784-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 09:30:34 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 8 Jan 2018 14:28:54 -0000
From: Greg Kurz <groug@kaod.org>
Date: Mon,  8 Jan 2018 15:28:31 +0100
In-Reply-To: <20180108142831.6638-1-groug@kaod.org>
References: <20180108142831.6638-1-groug@kaod.org>
Message-Id: <20180108142831.6638-15-groug@kaod.org>
Subject: [Qemu-devel] [PULL 14/14] MAINTAINERS: Drop Aneesh as 9pfs
 maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>

Aneesh has been working on other topics for some time now. Let's reflect
that in the MAINTAINERS file, so that people stop Cc'ing him.

Signed-off-by: Greg Kurz <groug@kaod.org>
Acked-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 73a555573520..bc2d3a4ef149 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1083,13 +1083,11 @@ F: include/hw/virtio/
 F: tests/virtio-balloon-test.c
 
 virtio-9p
-M: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
 M: Greg Kurz <groug@kaod.org>
 S: Supported
 F: hw/9pfs/
 F: fsdev/
 F: tests/virtio-9p-test.c
-T: git git://github.com/kvaneesh/QEMU.git
 T: git git://github.com/gkurz/qemu.git 9p-next
 
 virtio-blk
-- 
2.13.6

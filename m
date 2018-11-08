Received: from eggs.gnu.org ([2001:4830:134:3::10]:53562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gKrDC-0001Bm-Ov
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 15:47:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gKr7c-0001eb-3X
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 15:41:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gKr7b-0001MA-IS
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 15:41:47 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wA8KcxDX056932
	for <qemu-devel@nongnu.org>; Thu, 8 Nov 2018 15:41:25 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2nmtxtutja-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 15:41:25 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Thu, 8 Nov 2018 20:41:22 -0000
From: Greg Kurz <groug@kaod.org>
Date: Thu,  8 Nov 2018 21:41:09 +0100
Message-Id: <20181108204111.786455-1-groug@kaod.org>
Subject: [Qemu-devel] [PULL 0/1] 9p fixes for v3.1.0-rc1
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

The following changes since commit a7ce790a029bd94eb320d8c69f38900f5233997e:

  tcg/tcg-op.h: Add multiple include guard (2018-11-08 15:15:32 +0000)

are available in the Git repository at:

  https://github.com/gkurz/qemu.git tags/for-upstream

for you to fetch changes up to 5b76ef50f62079a2389ba28cacaf6cce68b1a0ed:

  9p: write lock path in v9fs_co_open2() (2018-11-08 21:19:05 +0100)

----------------------------------------------------------------
Fixes a potential use-after-free issue that could be triggered by a
misbehaving guest.

----------------------------------------------------------------
Greg Kurz (1):
      9p: write lock path in v9fs_co_open2()

 hw/9pfs/cofile.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
-- 
2.17.2

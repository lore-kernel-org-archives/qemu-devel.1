Received: from eggs.gnu.org ([2001:4830:134:3::10]:49960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cxaCW-0000jk-6n
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 10:21:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cxaCS-0003Wo-9P
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 10:21:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41896
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cxaCS-0003We-3F
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 10:21:48 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3AEDvB9109808
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 10:21:46 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29r9qveegx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 10:21:46 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 10 Apr 2017 15:21:44 +0100
From: Greg Kurz <groug@kaod.org>
Date: Mon, 10 Apr 2017 16:21:34 +0200
Message-Id: <1491834095-6476-1-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL] 9pfs fix for 2.9 2017-04-10
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

The following changes since commit 5daf9b3025baef10ee7b77daa003d5696b58d5dc:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2017-04-07 15:23:48 +0100)

are available in the git repository at:

  https://github.com/gkurz/qemu.git tags/for-upstream

for you to fetch changes up to 4ffcdef4277a91af15a3c09f7d16af072c29f3f2:

  9pfs: xattr: fix memory leak in v9fs_list_xattr (2017-04-10 09:38:05 +0200)

----------------------------------------------------------------
Fixes a memory leak.

----------------------------------------------------------------
Li Qiang (1):
      9pfs: xattr: fix memory leak in v9fs_list_xattr

 hw/9pfs/9p-xattr.c | 1 +
 1 file changed, 1 insertion(+)
-- 
2.7.4

Received: from eggs.gnu.org ([2001:4830:134:3::10]:57649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cqKXP-00084J-2R
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 10:13:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cqKXL-0002rV-38
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 10:13:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37691)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cqKXK-0002rI-QM
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 10:13:23 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2LE979E145616
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 10:13:20 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29ambp5u9w-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 10:13:20 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 21 Mar 2017 14:13:17 -0000
From: Greg Kurz <groug@kaod.org>
Date: Tue, 21 Mar 2017 15:12:58 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <1490105580-5008-1-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 0/2] 9pfs fixes 2017-03-21 for 2.9
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

The following changes since commit 940a8ce075e3408742a4edcabfd6c2a15e2539eb:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-03-20 16:34:26 +0000)

are available in the git repository at:

  https://github.com/gkurz/qemu.git tags/for-upstream

for you to fetch changes up to 262169abe74b4c2d8b299b7499904cfc3c1902ea:

  9pfs: proxy: assert if unmarshal fails (2017-03-21 09:12:47 +0100)

----------------------------------------------------------------
This pull request fixes a potential QEMU hang in 9pfs and two issues
reported by Coverity.

----------------------------------------------------------------
Greg Kurz (2):
      9pfs: don't try to flush self and avoid QEMU hang on reset
      9pfs: proxy: assert if unmarshal fails

 hw/9pfs/9p-proxy.c | 22 +++++++++++-----------
 hw/9pfs/9p.c       | 12 ++++++++----
 2 files changed, 19 insertions(+), 15 deletions(-)
-- 
2.7.4

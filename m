Received: from eggs.gnu.org ([2001:4830:134:3::10]:37371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1csmmN-00054p-LB
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:47:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1csmmK-00056D-Ie
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:47:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47245)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1csmmK-00054H-9J
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:47:00 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2S8hiAS057081
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 04:46:57 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29fm1jtbhu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 04:46:57 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 28 Mar 2017 09:46:54 +0100
From: Greg Kurz <groug@kaod.org>
Date: Tue, 28 Mar 2017 10:46:32 +0200
Message-Id: <1490690794-19023-1-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 0/2] 9pfs fixes for 2.9 2017-03-28
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

The following changes since commit eb06c9e2d3c8f026a206e8402b0ffa201060ec8e:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-03-27 17:34:50 +0100)

are available in the git repository at:

  https://github.com/gkurz/qemu.git tags/for-upstream

for you to fetch changes up to 34ef723ce34aaa14f94530c06a0ab3170a19bb59:

  tests/virtio-9p-test: Don't call le*_to_cpus on fields of packed struct (2017-03-27 21:15:31 +0200)

----------------------------------------------------------------
This series fixes potential memory/fd leaks in 9pfs and a crash when
running tests/virtio-9p-test on SPARC hosts.

----------------------------------------------------------------
Li Qiang (1):
      9pfs: fix file descriptor leak

Peter Maydell (1):
      tests/virtio-9p-test: Don't call le*_to_cpus on fields of packed struct

 hw/9pfs/9p.c           | 8 ++++++++
 tests/virtio-9p-test.c | 4 ++--
 2 files changed, 10 insertions(+), 2 deletions(-)
-- 
2.7.4

Received: from eggs.gnu.org ([2001:4830:134:3::10]:57591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cOgpn-0006tx-Vp
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 03:22:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cOgpk-0008Vx-SQ
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 03:22:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41417)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cOgpk-0008VN-IY
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 03:22:08 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v048J4eW109096
	for <qemu-devel@nongnu.org>; Wed, 4 Jan 2017 03:22:06 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27rpavpws4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 03:22:05 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Wed, 4 Jan 2017 08:22:03 -0000
From: Greg Kurz <groug@kaod.org>
Date: Wed,  4 Jan 2017 09:21:34 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <1483518107-13218-1-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 00/13] 9p patches 20170104
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

The following changes since commit dbe2b65566e76d3c3a0c3358285c0336ac61e757:

  Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.9-pull-request' into staging (2016-12-28 17:11:11 +0000)

are available in the git repository at:

  https://github.com/gkurz/qemu.git tags/for-upstream

for you to fetch changes up to a37c07022b44e4fc29238deca7588406d081e6c2:

  tests: virtio-9p: ".." cannot be used to walk out of the shared directory (2017-01-03 17:28:44 +0100)

----------------------------------------------------------------
- transport specific callbacks (for Xen)
- fix crash (2.8 regression)
- 9p functional tests

----------------------------------------------------------------
Greg Kurz (9):
      9pfs: fix crash when fsdev is missing
      tests: virtio-9p: rename PCI configuration test
      tests: virtio-9p: code refactoring
      9pfs: fix P9_NOTAG and P9_NOFID macros
      tests: virtio-9p: add version operation test
      tests: virtio-9p: add attach operation test
      tests: virtio-9p: add walk operation test
      tests: virtio-9p: no slash in path elements during walk
      tests: virtio-9p: ".." cannot be used to walk out of the shared directory

Stefano Stabellini (4):
      9pfs: move pdus to V9fsState
      9pfs: introduce transport specific callbacks
      9pfs: call v9fs_init_qiov_from_pdu before v9fs_pack
      9pfs: introduce init_out/in_iov_from_pdu

 hw/9pfs/9p.c               |  78 ++++----
 hw/9pfs/9p.h               |  26 ++-
 hw/9pfs/virtio-9p-device.c |  46 +++--
 hw/9pfs/virtio-9p.h        |  10 -
 tests/virtio-9p-test.c     | 478 ++++++++++++++++++++++++++++++++++++++++-----
 5 files changed, 524 insertions(+), 114 deletions(-)
-- 
2.7.4

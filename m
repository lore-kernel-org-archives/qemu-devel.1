Received: from eggs.gnu.org ([2001:4830:134:3::10]:36107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dFGcq-0001fJ-IN
	for qemu-devel@nongnu.org; Mon, 29 May 2017 05:06:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dFGcm-0006Bh-Lu
	for qemu-devel@nongnu.org; Mon, 29 May 2017 05:06:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54477
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dFGcm-00069i-Fw
	for qemu-devel@nongnu.org; Mon, 29 May 2017 05:06:04 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4T94ECR047964
	for <qemu-devel@nongnu.org>; Mon, 29 May 2017 05:05:57 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2aqm8pxqb3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 29 May 2017 05:05:56 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 29 May 2017 10:05:55 +0100
From: Greg Kurz <groug@kaod.org>
Date: Mon, 29 May 2017 11:05:29 +0200
Message-Id: <1496048740-26578-1-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 00/11] 9pfs patches for 2.10 20170525
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Greg Kurz <groug@kaod.org>

The following changes since commit 9964e96dc9999cf7f7c936ee854a795415d19b60:

  Merge remote-tracking branch 'jasowang/tags/net-pull-request' into staging (2017-05-23 15:01:31 +0100)

are available in the git repository at:

  https://github.com/gkurz/qemu.git tags/for-upstream

for you to fetch changes up to f0a4da86cff2e600255324793daddd7ce59b9862:

  9pfs: local: metadata file for the VirtFS root (2017-05-25 10:30:14 +0200)

----------------------------------------------------------------
Various bugfixes and code cleanups. Most notably, it fixes metadata handling in
mapped-file security mode (especially for the virtfs root).

----------------------------------------------------------------
Greg Kurz (11):
      virtio-9p/xen-9p: move 9p specific bits to core 9p code
      fsdev: don't allow unknown format in marshal/unmarshal
      9pfs: drop pdu_push_and_notify()
      9pfs: local: fix unlink of alien files in mapped-file mode
      fsdev: fix virtfs-proxy-helper cwd
      9pfs: assume utimensat() and futimens() are present
      util: drop old utimensat() compat code
      9pfs: check return value of v9fs_co_name_to_path()
      9pfs: local: resolve special directories in paths
      9pfs: local: simplify file opening
      9pfs: local: metadata file for the VirtFS root

 configure                   |  22 ------
 fsdev/9p-iov-marshal.c      |   4 +-
 fsdev/virtfs-proxy-helper.c |  11 +--
 hw/9pfs/9p-handle.c         |   5 --
 hw/9pfs/9p-local.c          | 181 ++++++++++++++++++++++++++++++--------------
 hw/9pfs/9p-util.c           |  43 -----------
 hw/9pfs/9p-util.h           |   2 -
 hw/9pfs/9p.c                |  51 ++++++++-----
 hw/9pfs/9p.h                |   2 +-
 hw/9pfs/virtio-9p-device.c  |   8 +-
 hw/9pfs/xen-9p-backend.c    |   6 +-
 include/sysemu/os-posix.h   |  11 ---
 util/oslib-posix.c          |  47 ------------
 13 files changed, 167 insertions(+), 226 deletions(-)
-- 
2.7.4

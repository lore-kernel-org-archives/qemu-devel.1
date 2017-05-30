Received: from eggs.gnu.org ([2001:4830:134:3::10]:40330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dFhOb-0007Dz-SN
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:41:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dFhOX-00020W-Vm
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:41:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dFhOX-0001zw-M2
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:41:09 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4UDctE5028140
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 09:41:08 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2as8xdapdj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 09:41:07 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 30 May 2017 14:41:04 +0100
From: Greg Kurz <groug@kaod.org>
Date: Tue, 30 May 2017 15:40:29 +0200
Message-Id: <1496151640-29919-1-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL v2 00/11] 9pfs patches for 2.10 20170530
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

for you to fetch changes up to 81ffbf5ab1458e357a761f1272105a55829b351e:

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
 hw/9pfs/9p-local.c          | 186 ++++++++++++++++++++++++++++++--------------
 hw/9pfs/9p-util.c           |  43 ----------
 hw/9pfs/9p-util.h           |   2 -
 hw/9pfs/9p.c                |  51 +++++++-----
 hw/9pfs/9p.h                |   2 +-
 hw/9pfs/virtio-9p-device.c  |   8 +-
 hw/9pfs/xen-9p-backend.c    |   6 +-
 include/sysemu/os-posix.h   |  11 ---
 util/oslib-posix.c          |  47 -----------
 13 files changed, 172 insertions(+), 226 deletions(-)
-- 
2.7.5

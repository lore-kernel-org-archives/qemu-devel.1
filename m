Received: from eggs.gnu.org ([2001:4830:134:3::10]:56607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eXcy1-0007Ae-9m
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 20:08:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eXcxy-0006DZ-1y
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 20:08:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45350
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eXcxx-00061e-Oq
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 20:08:05 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	w0614ZZG097331
	for <qemu-devel@nongnu.org>; Fri, 5 Jan 2018 20:07:57 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fafb8jxqd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 20:07:56 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Sat, 6 Jan 2018 01:07:55 -0000
From: Greg Kurz <groug@kaod.org>
Date: Sat,  6 Jan 2018 02:07:27 +0100
Message-Id: <20180106010739.18201-1-groug@kaod.org>
Subject: [Qemu-devel] [PULL 00/12] 9p patches for 2.12 20170106
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

The following changes since commit 281f327487c9c9b1599f93c589a408bbf4a651b8:

  Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.12-pull-request' into staging (2017-12-22 00:11:36 +0000)

are available in the git repository at:

  https://github.com/gkurz/qemu.git tags/for-upstream

for you to fetch changes up to 8213fcb3f7b31f0cf1aaf1503bf7b85133f40198:

  fsdev: improve error handling of backend init (2018-01-04 20:04:44 +0100)

----------------------------------------------------------------
This batch of 9pfs/fsdev patches brings:
- improved error reporting, especially when the local backend fails to
  open the VirtFS root,
- virtio-9p-test to behave more like a real virtio guest driver: set
  DRIVER_OK when ready to use the device and process the used ring
  for completed requests,
- cosmetic fixes (mostly coding style related).

----------------------------------------------------------------
Greg Kurz (12):
      virtio-9p: move unrealize/realize after virtio_9p_transport definition
      9pfs: fix XattrOperations typedef
      fsdev: fix some type definitions
      9pfs: fix some type definitions
      9pfs: handle: fix type definition
      9pfs: fix type in *_parse_opts declarations
      9pfs: fix error path in pdu_submit()
      9pfs: make pdu_marshal() and pdu_unmarshal() static functions
      tests: virtio-9p: fix ISR dependence
      tests: virtio-9p: set DRIVER_OK before using the device
      fsdev: improve error handling of backend opts parsing
      fsdev: improve error handling of backend init

 fsdev/file-op-9p.h         | 32 +++++++++++-------------
 fsdev/qemu-fsdev.c         |  4 ++-
 hw/9pfs/9p-handle.c        | 52 +++++++++++++++++++-------------------
 hw/9pfs/9p-local.c         | 36 ++++++++++++++++-----------
 hw/9pfs/9p-proxy.c         | 30 ++++++++++++++--------
 hw/9pfs/9p-synth.c         |  2 +-
 hw/9pfs/9p-xattr.h         |  5 ++--
 hw/9pfs/9p.c               | 22 ++++++++--------
 hw/9pfs/9p.h               | 14 +++++------
 hw/9pfs/virtio-9p-device.c | 62 ++++++++++++++++++++++------------------------
 hw/9pfs/xen-9p-backend.c   |  2 +-
 tests/virtio-9p-test.c     | 33 +++++++++++-------------
 12 files changed, 149 insertions(+), 145 deletions(-)
-- 
2.13.6

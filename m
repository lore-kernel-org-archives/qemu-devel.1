Received: from eggs.gnu.org ([2001:4830:134:3::10]:33379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eYYQ3-0002qW-6m
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:28:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eYYQ0-00065I-GU
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:28:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50512)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eYYQ0-00064e-78
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:28:52 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.21) with SMTP id
	w08ESlWO040961
	for <qemu-devel@nongnu.org>; Mon, 8 Jan 2018 09:28:50 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fc6w3ja1u-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 09:28:50 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 8 Jan 2018 14:28:48 -0000
From: Greg Kurz <groug@kaod.org>
Date: Mon,  8 Jan 2018 15:28:17 +0100
Message-Id: <20180108142831.6638-1-groug@kaod.org>
Subject: [Qemu-devel] [PULL 00/14] 9p patches for 2.12 20180108
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

The following changes since commit 8671016261cd5dfba1042aef0a632a77b0d387a2:

  Merge remote-tracking branch 'remotes/jasowang/tags/net-pull-request' into staging (2018-01-08 09:15:42 +0000)

are available in the git repository at:

  https://github.com/gkurz/qemu.git tags/for-upstream

for you to fetch changes up to ffcfb446db1776198a3fe02b75bfecfa1d0b7ab3:

  MAINTAINERS: Drop Aneesh as 9pfs maintainer (2018-01-08 11:18:23 +0100)

----------------------------------------------------------------
- Aneesh no longer listed in MAINTAINERS,
- deprecation of the handle backend,
- improved error reporting, especially when the local backend fails to
  open the VirtFS root,
- virtio-9p-test to behave more like a real virtio guest driver: set
  DRIVER_OK when ready to use the device and process the used ring
  for completed requests,
- cosmetic fixes (mostly coding style related).

----------------------------------------------------------------
Greg Kurz (14):
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
      9pfs: deprecate handle backend
      MAINTAINERS: Drop Aneesh as 9pfs maintainer

 MAINTAINERS                |  2 --
 fsdev/file-op-9p.h         | 36 +++++++++++++--------------
 fsdev/qemu-fsdev.c         |  4 ++-
 hw/9pfs/9p-handle.c        | 54 +++++++++++++++++++++-------------------
 hw/9pfs/9p-local.c         | 36 ++++++++++++++++-----------
 hw/9pfs/9p-proxy.c         | 30 ++++++++++++++--------
 hw/9pfs/9p-synth.c         |  2 +-
 hw/9pfs/9p-xattr.h         |  5 ++--
 hw/9pfs/9p.c               | 22 ++++++++--------
 hw/9pfs/9p.h               | 14 +++++------
 hw/9pfs/virtio-9p-device.c | 62 ++++++++++++++++++++++------------------------
 hw/9pfs/xen-9p-backend.c   |  2 +-
 qemu-doc.texi              |  8 ++++++
 tests/virtio-9p-test.c     | 33 +++++++++++-------------
 14 files changed, 161 insertions(+), 149 deletions(-)
-- 
2.13.6

Received: from eggs.gnu.org ([2001:4830:134:3::10]:42911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gDNDC-0003il-LS
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 01:20:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gDND6-00004u-R9
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 01:20:37 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43325)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gDND2-0008PQ-MW
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 01:20:31 -0400
Received: by mail-pl1-x642.google.com with SMTP id 30-v6so15335066plb.10
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 22:20:25 -0700 (PDT)
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 18 Oct 2018 22:20:05 -0700
Message-Id: <1539926412-21831-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH 0/7] vfio: some trivial fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.williamson@redhat.com
Cc: qemu-devel@nongnu.org, philmd@redhat.com, Li Qiang <liq3ea@gmail.com>

This patch set contains some trivial issue such as
QOMConvetion, typo and resources leak in vfio.

Li Qiang (7):
  vfio-pci: make "vfio-pci-nohotplug" as MACRO
  vfio: ap-device: make it more QOMConventional
  vfio: drop TYPE_FOO MACRO in VMStateDescription
  vfio: paltform: fix a typo
  vfio: platform: cleanup the notifier in error path
  vfio: platform: free timer in error path
  vfio: platform: destory mutex in error path

 hw/s390x/ap-device.c         |  2 +-
 hw/vfio/amd-xgbe.c           |  2 +-
 hw/vfio/ap.c                 | 12 ++++++------
 hw/vfio/calxeda-xgmac.c      |  2 +-
 hw/vfio/ccw.c                |  2 +-
 hw/vfio/pci.c                |  6 ++++--
 hw/vfio/platform.c           | 12 ++++++++----
 include/hw/s390x/ap-device.h |  4 ++--
 8 files changed, 24 insertions(+), 18 deletions(-)

-- 
1.8.3.1

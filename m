Received: from eggs.gnu.org ([2001:4830:134:3::10]:48300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d1RIr-0005F4-FT
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 01:40:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d1RIm-0004RT-L8
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 01:40:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d1RIm-0004R3-F2
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 01:40:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 38D93C04BD38
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 05:40:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-149.ams2.redhat.com
	[10.36.116.149])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0505071D43
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 05:40:15 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 21 Apr 2017 07:40:09 +0200
Message-Id: <1492753213-26516-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 0/4] qdev patches for 2017-04-21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 359c41abe32638adad503e386969fa428cecff52:

  Update version for v2.9.0 release (2017-04-20 15:31:34 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qdev-2017-04-21

for you to fetch changes up to 08f00df4f4b8b4e38ad620477cc90cf5f73832d9:

  qdev: remove cannot_destroy_with_object_finalize_yet (2017-04-21 07:18:34 +0200)

----------------------------------------------------------------
qdev patches for 2017-04-21

----------------------------------------------------------------
Laurent Vivier (4):
      arm: remove remaining cannot_destroy_with_object_finalize_yet
      ppc: remove cannot_destroy_with_object_finalize_yet
      versatile: remove cannot_destroy_with_object_finalize_yet
      qdev: remove cannot_destroy_with_object_finalize_yet

 hw/arm/allwinner-a10.c  |  6 ------
 hw/arm/bcm2836.c        |  6 ------
 hw/arm/digic.c          |  6 ------
 hw/arm/fsl-imx25.c      |  5 -----
 hw/arm/fsl-imx31.c      |  5 -----
 hw/arm/fsl-imx6.c       |  5 -----
 hw/arm/xlnx-zynqmp.c    |  6 ------
 hw/pci-host/versatile.c | 35 ++++++++++++-----------------------
 include/hw/qdev-core.h  | 13 -------------
 qmp.c                   |  5 -----
 target/ppc/kvm.c        | 10 ----------
 11 files changed, 12 insertions(+), 90 deletions(-)

-- 
2.7.4

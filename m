Received: from eggs.gnu.org ([2001:4830:134:3::10]:59170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fa0yC-0004aI-4B
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:42:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fa0yA-0006FW-Nn
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:42:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fa0yA-0006FB-IJ
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:42:26 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B9F56C049D7F
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 15:42:25 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  2 Jul 2018 17:42:16 +0200
Message-Id: <20180702154222.3130-2-kraxel@redhat.com>
In-Reply-To: <20180702154222.3130-1-kraxel@redhat.com>
References: <20180702154222.3130-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/7] seabios: update submodule to release 1.11.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

git shortlog rel-1.11.1..rel-1.11.2
-----------------------------------

Gerd Hoffmann (11):
      optionrom: enable non-vga display devices
      cbvga: factor out cbvga_setup_modes()
      qemu: add bochs-display support
      cbvga_setup_modes: use real mode number instead of 0x140
      cbvga_list_modes: don't list current mode twice
      cbvga_set_mode: disable clearmem in windows x86 emulator.
      bochs_display_setup: return error on failure
      pmm: use tmp zone on oom
      vgasrc: add allocate_pmm()
      qemu: add qemu ramfb support
      cbvga_set_mode: refine clear display logic

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 roms/seabios | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/roms/seabios b/roms/seabios
index 0551a4be2c..f9626ccb91 160000
--- a/roms/seabios
+++ b/roms/seabios
@@ -1 +1 @@
-Subproject commit 0551a4be2ce599fb60e478b4c15e06ab6587822c
+Subproject commit f9626ccb91e771f990fbb2da92e427a399d7d918
-- 
2.9.3

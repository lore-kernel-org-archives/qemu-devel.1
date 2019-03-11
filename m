Received: from eggs.gnu.org ([209.51.188.92]:35946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3T6b-0000MH-Ps
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:09:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3T6Z-0004lM-Ri
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:09:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h3T6X-0004gO-OV
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:09:07 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6423F3086268
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 22:09:00 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 11 Mar 2019 23:08:39 +0100
Message-Id: <20190311220843.4026-24-armbru@redhat.com>
In-Reply-To: <20190311220843.4026-1-armbru@redhat.com>
References: <20190311220843.4026-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 23/27] pflash_cfi01: Add pflash_cfi01_get_blk()
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Add an helper to access the opaque struct PFlashCFI01.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Message-Id: <20190308131445.17502-9-armbru@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/block/pflash_cfi01.c  | 5 +++++
 include/hw/block/flash.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 9d1c356eb6..125f70b8e4 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -967,6 +967,11 @@ PFlashCFI01 *pflash_cfi01_register(hwaddr base,
     return PFLASH_CFI01(dev);
 }
=20
+BlockBackend *pflash_cfi01_get_blk(PFlashCFI01 *fl)
+{
+    return fl->blk;
+}
+
 MemoryRegion *pflash_cfi01_get_memory(PFlashCFI01 *fl)
 {
     return &fl->mem;
diff --git a/include/hw/block/flash.h b/include/hw/block/flash.h
index 914932eaec..a0f488732a 100644
--- a/include/hw/block/flash.h
+++ b/include/hw/block/flash.h
@@ -22,6 +22,7 @@ PFlashCFI01 *pflash_cfi01_register(hwaddr base,
                                    uint16_t id0, uint16_t id1,
                                    uint16_t id2, uint16_t id3,
                                    int be);
+BlockBackend *pflash_cfi01_get_blk(PFlashCFI01 *fl);
 MemoryRegion *pflash_cfi01_get_memory(PFlashCFI01 *fl);
=20
 /* pflash_cfi02.c */
--=20
2.17.2

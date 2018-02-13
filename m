Received: from eggs.gnu.org ([2001:4830:134:3::10]:41939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZHg-0004Nn-AW
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:02:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZHf-0007kg-Fr
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:02:04 -0500
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:37167)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1elZHf-0007kQ-A3
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:02:03 -0500
Received: by mail-wr0-x22a.google.com with SMTP id k32so11871982wrk.4
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 04:02:03 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Feb 2018 13:00:31 +0100
Message-Id: <1518523252-49106-28-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
References: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 27/48] hw/arm/exynos4210: access the 64-bit
 capareg with qdev_prop_set_uint64()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

We only set a 32-bit value, but this is a good practice in case this
code is used as reference.

(missed in 5efc9016e52)

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Message-Id: <20180208164818.7961-15-f4bug@amsat.org>
---
 hw/arm/exynos4210.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index e8e1d81..d89322c 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -378,7 +378,7 @@ Exynos4210State *exynos4210_init(MemoryRegion *system_mem)
         DriveInfo *di;
 
         dev = qdev_create(NULL, TYPE_SYSBUS_SDHCI);
-        qdev_prop_set_uint32(dev, "capareg", EXYNOS4210_SDHCI_CAPABILITIES);
+        qdev_prop_set_uint64(dev, "capareg", EXYNOS4210_SDHCI_CAPABILITIES);
         qdev_init_nofail(dev);
 
         busdev = SYS_BUS_DEVICE(dev);
-- 
1.8.3.1

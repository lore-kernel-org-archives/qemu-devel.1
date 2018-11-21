Received: from eggs.gnu.org ([2001:4830:134:3::10]:43751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gPKml-00043b-EI
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 00:10:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gPKmi-00031M-Bt
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 00:10:47 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:34989)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gPKmi-0002zh-60
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 00:10:44 -0500
Received: by mail-pl1-x641.google.com with SMTP id v1-v6so3697975plo.2
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 21:10:44 -0800 (PST)
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 20 Nov 2018 21:10:26 -0800
Message-Id: <1542777026-2788-4-git-send-email-liq3ea@gmail.com>
In-Reply-To: <1542777026-2788-1-git-send-email-liq3ea@gmail.com>
References: <1542777026-2788-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH v2 3/3] fw_cfg: make qemu_extra_params_fw
 locally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: armbru@redhat.com, pbonzini@redhat.com, kraxel@redhat.com, lersek@redhat.com, philmd@redhat.com
Cc: qemu-devel@nongnu.org, liq3ea@gmail.com

qemu_extra_params_fw[] has external linkage, but is used
only in fw_cfg_bootsplash(), it makes sense to make it
locally.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 hw/nvram/fw_cfg.c       | 1 +
 include/sysemu/sysemu.h | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index aafa96721f..a71f043b5d 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -120,6 +120,7 @@ static void fw_cfg_bootsplash(FWCfgState *s)
 {
     const char *boot_splash_filename = NULL;
     const char *boot_splash_time = NULL;
+    uint8_t qemu_extra_params_fw[2];
     char *filename, *file_data;
     gsize file_size;
     int file_type;
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 8d6095d98b..f8608d24d9 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -133,7 +133,6 @@ extern uint8_t *boot_splash_filedata;
 extern size_t boot_splash_filedata_size;
 extern bool enable_mlock;
 extern bool enable_cpu_pm;
-extern uint8_t qemu_extra_params_fw[2];
 extern QEMUClockType rtc_clock;
 extern const char *mem_path;
 extern int mem_prealloc;
-- 
2.11.0

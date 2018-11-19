Received: from eggs.gnu.org ([2001:4830:134:3::10]:41498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gOlmZ-0003cy-Il
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:48:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gOlmX-00018U-Se
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:48:15 -0500
Received: from m12-16.163.com ([220.181.12.16]:52575)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gOlmX-00017h-8l
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:48:13 -0500
From: Li Qiang <liq3ea@163.com>
Date: Mon, 19 Nov 2018 07:47:37 -0800
Message-Id: <20181119154737.9840-4-liq3ea@163.com>
In-Reply-To: <20181119154737.9840-1-liq3ea@163.com>
References: <20181119154737.9840-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH 3/3] fw_cfg: make qemu_extra_params_fw locally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, kraxel@redhat.com, lersek@redhat.com, philmd@redhat.com, armbru@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@163.com>

qemu_extra_params_fw[] has external linkage, but is used
only in fw_cfg_bootsplash(), it makes sense to make it
locally.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/nvram/fw_cfg.c       | 1 +
 include/sysemu/sysemu.h | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 0489d63a1b..4eddd6a885 100644
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
2.17.1

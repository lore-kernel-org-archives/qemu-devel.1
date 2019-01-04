Received: from eggs.gnu.org ([208.118.235.92]:54243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gfSJ6-0006Bz-3q
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:26:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gfSJ5-0003Ap-AC
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:26:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gfSJ5-0003Ah-50
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:26:47 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri,  4 Jan 2019 17:25:59 +0100
Message-Id: <20190104162559.20760-5-philmd@redhat.com>
In-Reply-To: <20190104162559.20760-1-philmd@redhat.com>
References: <20190104162559.20760-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/4] fw_cfg: Make qemu_extra_params_fw locally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=83=C2=A9?= <philmd@redhat.com>, Li Qiang <liq3ea@gmail.com>

From: Li Qiang <liq3ea@gmail.com>

qemu_extra_params_fw[] has external linkage, but is used
only in fw_cfg_bootsplash(), it makes sense to make it
locally.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <1542777026-2788-4-git-send-email-liq3ea@gmail.com>
[PMD: Removed qemu_extra_params_fw declaration in vl.c]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/nvram/fw_cfg.c       | 1 +
 include/sysemu/sysemu.h | 1 -
 vl.c                    | 1 -
 3 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index cba58344f5..de58c7be46 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -119,6 +119,7 @@ static void fw_cfg_bootsplash(FWCfgState *s)
 {
     const char *boot_splash_filename =3D NULL;
     const char *boot_splash_time =3D NULL;
+    uint8_t qemu_extra_params_fw[2];
     char *filename, *file_data;
     gsize file_size;
     int file_type;
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index e0d15da937..85877b7e43 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -116,7 +116,6 @@ extern uint8_t *boot_splash_filedata;
 extern size_t boot_splash_filedata_size;
 extern bool enable_mlock;
 extern bool enable_cpu_pm;
-extern uint8_t qemu_extra_params_fw[2];
 extern QEMUClockType rtc_clock;
 extern const char *mem_path;
 extern int mem_prealloc;
diff --git a/vl.c b/vl.c
index efa4ff9da5..0db5ad0246 100644
--- a/vl.c
+++ b/vl.c
@@ -191,7 +191,6 @@ int boot_menu;
 bool boot_strict;
 uint8_t *boot_splash_filedata;
 size_t boot_splash_filedata_size;
-uint8_t qemu_extra_params_fw[2];
 bool wakeup_suspend_enabled;
=20
 int icount_align_option;
--=20
2.17.2

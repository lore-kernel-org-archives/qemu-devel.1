Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68991C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 13:57:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3262620656
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 13:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YZUw61qa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3262620656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyyCt-0001Sb-EM
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 09:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1jyuMq-0004zW-7e
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 05:51:52 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:51042)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1jyuMm-0002q3-QT
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 05:51:51 -0400
Received: by mail-pj1-x1042.google.com with SMTP id k71so4944949pje.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 02:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=FJWgZR9dxkHebEXa3CI+aE3coVvsa0sr7XhGjd0lqG8=;
 b=YZUw61qayAokcJsE3AMM/hMWoavlVPaGmeLIuqjSJSPunhVV6NioyDI+1kv4Q+zRgn
 rBgxl5bs05wJgcJxNaPRvbFKXm3Fn9Z+zW2oPNqFIorLyodPkfIkn4uaN0r6QsYiZ4d/
 AgfPBdh6nIWzix6e+Bzvx8uDqdJEynHkqZgZO+esWMagS7GcqEHVDKj5JcxttO5mgdJq
 nKKVlFz2z7BswYqeGPw+d2m+t6V9cIgfc1bgEqtQtZAF9JPMpC4YpalQ4V5DEOEg12kn
 6YhkiuGkXRtdkR/xW/kHntEzSkNlBsRkD1/Xv+cjd/zmtSKMH94LNLA90mAr46fxrK6t
 KShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=FJWgZR9dxkHebEXa3CI+aE3coVvsa0sr7XhGjd0lqG8=;
 b=A8A1BedKTXPvydqYsuGztqsfRK7A4zUJGqJnrRdXlK17gHhr2krvMZ30tSek43sWz3
 wiSBTd3SkBPh81Ub4lblqjry/ScdVC+rettFPOSpPrvU+V26uadRcT/sztLsrWlrhHTv
 GSC15GXFLWyXUiaydscYI1KG9+eyawirdVoPBxLaCUTR2ZAo9qN7hqrgh5dE65dtL3tm
 xRzC0ugdwsQ62k3CtEZFIAsP65eAukAWq4+G/8ec5US5R3nuYt23noO+GvUpVDu9wniA
 hD9N0LcWf6kYHce57H4Xv8yFbmXQzuXXi+QUJa/AdQZ/LHvgpg4W98QgwDjNr7BYiMR4
 hRkA==
X-Gm-Message-State: AOAM531O8MsITsG8lc0psfioSNWnq8tD5DsIrg4GS5hQokmlPFdjqE1v
 nl/9Hu1zJhuG5Jh5joUV4c7WgQ==
X-Google-Smtp-Source: ABdhPJz7z4Sw8Kr4ukujIIaIJVnom86cl9IgivN6BqVNHcSmnTcvr4FN03OsHxVYE7rDVWYacZnRbQ==
X-Received: by 2002:a17:90a:14a5:: with SMTP id
 k34mr4821300pja.37.1595584307320; 
 Fri, 24 Jul 2020 02:51:47 -0700 (PDT)
Received: from localhost.localdomain (111-243-186-54.dynamic-ip.hinet.net.
 [111.243.186.54])
 by smtp.gmail.com with ESMTPSA id x23sm5581636pfn.4.2020.07.24.02.51.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2020 02:51:46 -0700 (PDT)
From: Green Wan <green.wan@sifive.com>
To: 
Subject: [RFC PATCH 1/2] hw/riscv: sifive_u: Add file-backed OTP. softmmu/vl:
 add otp-file to boot option
Date: Fri, 24 Jul 2020 17:51:11 +0800
Message-Id: <20200724095112.2615-2-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200724095112.2615-1-green.wan@sifive.com>
References: <20200724095112.2615-1-green.wan@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=green.wan@sifive.com; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 24 Jul 2020 09:54:21 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-riscv@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org,
 Green Wan <green.wan@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 bmeng.cn@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a file-backed implementation for OTP of sifive_u machine. Use
'-boot otp-file=xxx' to enable it. Do file open, mmap and close
for every OTP read/write in case keep the update-to-date snapshot
of OTP.

Signed-off-by: Green Wan <green.wan@sifive.com>
---
 hw/riscv/sifive_u_otp.c         | 88 ++++++++++++++++++++++++++++++++-
 include/hw/riscv/sifive_u_otp.h |  2 +
 qemu-options.hx                 |  3 +-
 softmmu/vl.c                    |  6 ++-
 4 files changed, 96 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/sifive_u_otp.c b/hw/riscv/sifive_u_otp.c
index f6ecbaa2ca..26e1965821 100644
--- a/hw/riscv/sifive_u_otp.c
+++ b/hw/riscv/sifive_u_otp.c
@@ -24,6 +24,72 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/riscv/sifive_u_otp.h"
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <sys/mman.h>
+#include <string.h>
+
+#define TRACE_PREFIX            "FU540_OTP: "
+#define SIFIVE_FU540_OTP_SIZE   (SIFIVE_U_OTP_NUM_FUSES * 4)
+
+static int otp_backed_fd;
+static unsigned int *otp_mmap;
+
+static void sifive_u_otp_backed_load(const char *filename);
+static uint64_t sifive_u_otp_backed_read(uint32_t fuseidx);
+static void sifive_u_otp_backed_write(uint32_t fuseidx,
+                                      uint32_t paio,
+                                      uint32_t pdin);
+static void sifive_u_otp_backed_unload(void);
+
+void sifive_u_otp_backed_load(const char *filename)
+{
+    if (otp_backed_fd < 0) {
+
+        otp_backed_fd = open(filename, O_RDWR);
+
+        if (otp_backed_fd < 0)
+            qemu_log_mask(LOG_TRACE,
+                          TRACE_PREFIX "Warning: can't open otp file\n");
+        else {
+
+            otp_mmap = (unsigned int *)mmap(0,
+                                            SIFIVE_FU540_OTP_SIZE,
+                                            PROT_READ | PROT_WRITE | PROT_EXEC,
+                                            MAP_FILE | MAP_SHARED,
+                                            otp_backed_fd,
+                                            0);
+
+            if (otp_mmap == MAP_FAILED)
+                qemu_log_mask(LOG_TRACE,
+                              TRACE_PREFIX "Warning: can't mmap otp file\n");
+        }
+    }
+
+}
+
+uint64_t sifive_u_otp_backed_read(uint32_t fuseidx)
+{
+    return (uint64_t)(otp_mmap[fuseidx]);
+}
+
+void sifive_u_otp_backed_write(uint32_t fuseidx, uint32_t paio, uint32_t pdin)
+{
+    otp_mmap[fuseidx] &= ~(pdin << paio);
+    otp_mmap[fuseidx] |= (pdin << paio);
+}
+
+
+void sifive_u_otp_backed_unload(void)
+{
+    munmap(otp_mmap, SIFIVE_FU540_OTP_SIZE);
+    close(otp_backed_fd);
+    otp_backed_fd = -1;
+}
 
 static uint64_t sifive_u_otp_read(void *opaque, hwaddr addr, unsigned int size)
 {
@@ -46,7 +112,17 @@ static uint64_t sifive_u_otp_read(void *opaque, hwaddr addr, unsigned int size)
         if ((s->pce & SIFIVE_U_OTP_PCE_EN) &&
             (s->pdstb & SIFIVE_U_OTP_PDSTB_EN) &&
             (s->ptrim & SIFIVE_U_OTP_PTRIM_EN)) {
-            return s->fuse[s->pa & SIFIVE_U_OTP_PA_MASK];
+
+            if (otp_file) {
+                uint64_t val;
+
+                sifive_u_otp_backed_load(otp_file);
+                val = sifive_u_otp_backed_read(s->pa);
+                sifive_u_otp_backed_unload();
+
+                return val;
+            } else
+                return s->fuse[s->pa & SIFIVE_U_OTP_PA_MASK];
         } else {
             return 0xff;
         }
@@ -123,6 +199,12 @@ static void sifive_u_otp_write(void *opaque, hwaddr addr,
         s->ptrim = val32;
         break;
     case SIFIVE_U_OTP_PWE:
+        if (otp_file) {
+            sifive_u_otp_backed_load(otp_file);
+            sifive_u_otp_backed_write(s->pa, s->paio, s->pdin);
+            sifive_u_otp_backed_unload();
+        }
+
         s->pwe = val32;
         break;
     default:
@@ -165,6 +247,10 @@ static void sifive_u_otp_reset(DeviceState *dev)
     /* Make a valid content of serial number */
     s->fuse[SIFIVE_U_OTP_SERIAL_ADDR] = s->serial;
     s->fuse[SIFIVE_U_OTP_SERIAL_ADDR + 1] = ~(s->serial);
+
+    /* Initialize file mmap and descriptor. */
+    otp_mmap = NULL;
+    otp_backed_fd = -1;
 }
 
 static void sifive_u_otp_class_init(ObjectClass *klass, void *data)
diff --git a/include/hw/riscv/sifive_u_otp.h b/include/hw/riscv/sifive_u_otp.h
index 639297564a..1342bd7342 100644
--- a/include/hw/riscv/sifive_u_otp.h
+++ b/include/hw/riscv/sifive_u_otp.h
@@ -52,6 +52,8 @@
 #define SIFIVE_U_OTP(obj) \
     OBJECT_CHECK(SiFiveUOTPState, (obj), TYPE_SIFIVE_U_OTP)
 
+extern const char *otp_file;
+
 typedef struct SiFiveUOTPState {
     /*< private >*/
     SysBusDevice parent_obj;
diff --git a/qemu-options.hx b/qemu-options.hx
index 708583b4ce..eb9a54f4ed 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -415,10 +415,11 @@ ERST
 
 DEF("boot", HAS_ARG, QEMU_OPTION_boot,
     "-boot [order=drives][,once=drives][,menu=on|off]\n"
-    "      [,splash=sp_name][,splash-time=sp_time][,reboot-timeout=rb_time][,strict=on|off]\n"
+    "      [,splash=sp_name][,splash-time=sp_time][,reboot-timeout=rb_time][,strict=on|off][,otp-file=otp_file]\n"
     "                'drives': floppy (a), hard disk (c), CD-ROM (d), network (n)\n"
     "                'sp_name': the file's name that would be passed to bios as logo picture, if menu=on\n"
     "                'sp_time': the period that splash picture last if menu=on, unit is ms\n"
+    "                'otp_file': the file name backed OTP\n"
     "                'rb_timeout': the timeout before guest reboot when boot failed, unit is ms\n",
     QEMU_ARCH_ALL)
 SRST
diff --git a/softmmu/vl.c b/softmmu/vl.c
index f476ef89ed..58e0b2fc0a 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -21,7 +21,6 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
-
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qemu/units.h"
@@ -161,6 +160,7 @@ unsigned int nb_prom_envs = 0;
 const char *prom_envs[MAX_PROM_ENVS];
 int boot_menu;
 bool boot_strict;
+const char *otp_file;
 uint8_t *boot_splash_filedata;
 int only_migratable; /* turn it off unless user states otherwise */
 bool wakeup_suspend_enabled;
@@ -308,6 +308,9 @@ static QemuOptsList qemu_boot_opts = {
         }, {
             .name = "strict",
             .type = QEMU_OPT_BOOL,
+        }, {
+            .name = "otp-file",
+            .type = QEMU_OPT_STRING,
         },
         { /*End of list */ }
     },
@@ -4215,6 +4218,7 @@ void qemu_init(int argc, char **argv, char **envp)
 
         boot_menu = qemu_opt_get_bool(opts, "menu", boot_menu);
         boot_strict = qemu_opt_get_bool(opts, "strict", false);
+        otp_file = qemu_opt_get(opts, "otp-file");
     }
 
     if (!boot_order) {
-- 
2.17.1



Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A95C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 02:49:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DCAC2083E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 02:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="K30rKbgi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DCAC2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1L7C-0003nQ-HI
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 22:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1k1L5R-0001L3-1S
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 22:47:57 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:44327)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1k1L5N-0003pw-L3
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 22:47:56 -0400
Received: by mail-pl1-x633.google.com with SMTP id w17so16025965ply.11
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 19:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ljC0k9nyCux4/IOLjqVvH/F3twmU2EHIoC2bl6uN10c=;
 b=K30rKbgiOW4mRczP6unsUGoMcDSnBWmH4vLHuG/mjARGNNCFTQdjWDKavyZYOuhZuJ
 POUEKwi/kNr7nktvYRSespgBbv+ylZZLG5zEiw8Bn7y0d3b0QT79Mz3S2dn3VKPAr+qr
 zWNscDE8qdAdJL9UhnHyKgaWymCHZlidAGgKgQgyt0zYA/YrxD536xvwWZX+2aUSVbSK
 pp8nSHjTT2L+T0MxqAOYVmKhNU2kwa30i2CZhkOjxG0zTU7UPrlhtzv0SOoQBDpH+xZp
 VIHOvP1S+DHkfGQ2Zm/Y34h6auGPornjwCgnXqKqr+1N7Ubbj5n7I0iOWcl7kWPohIz9
 Bq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ljC0k9nyCux4/IOLjqVvH/F3twmU2EHIoC2bl6uN10c=;
 b=VQS0T6NEKQqiLj/lz1dNiZj2zdzv6nBxJJbQrm9FfhylfZ3GHHDvVRK+wGiCkJ4A7m
 jtNALtoli52I2PvFHJqFwFWBUaMDbQWFhxti6blxIznpcmRsgrHvuOyGeNGV1wmTdusz
 boQZDRCkCxA3UfxinZ0OyF+JEVFDBBlL+A/HorAFfkBN0ci0Pz0vXI+l8awTJ9U6t+T1
 hovnTli7J5+xqhJgg7nrLn5rCMr3DQp9iSxYokjyCoZq0CMnJOC0SO3ZNm1jgMMz+2Iv
 pr1rgKm28jeiOiAf2+8VJirJ10arnkaJRsz0YHN9F2Rpy/dZVKledvaxkQOsh6K/tlZ9
 /2CA==
X-Gm-Message-State: AOAM5326zO0pzt5TDzBlXC5LmWTQuP6v0a1+R+jsKG7FTPgMo7Qpm9Sx
 ecbp1EfJCTR6NFihzWsutMb+ew==
X-Google-Smtp-Source: ABdhPJy+HMAzlqgOzJnITveWYAzyRFUwB8EdEGxJNoIDm+jnlJNVRJnb9S7PWKH8CvjBM4uFlPDoKQ==
X-Received: by 2002:a17:90a:a68:: with SMTP id
 o95mr2003471pjo.148.1596163672131; 
 Thu, 30 Jul 2020 19:47:52 -0700 (PDT)
Received: from localhost.localdomain (111-243-189-249.dynamic-ip.hinet.net.
 [111.243.189.249])
 by smtp.gmail.com with ESMTPSA id c27sm7578483pfj.163.2020.07.30.19.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2020 19:47:51 -0700 (PDT)
From: Green Wan <green.wan@sifive.com>
To: 
Subject: [RFC PATCH v2 1/2] hw/riscv: sifive_u: Add file-backed OTP.
Date: Fri, 31 Jul 2020 10:47:07 +0800
Message-Id: <20200731024708.32725-2-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731024708.32725-1-green.wan@sifive.com>
References: <20200731024708.32725-1-green.wan@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=green.wan@sifive.com; helo=mail-pl1-x633.google.com
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
 Palmer Dabbelt <palmer@dabbelt.com>, bmeng.cn@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a file-backed implementation for OTP of sifive_u machine. The
machine property for file-backed is disabled in default. Do file
open, mmap and close for every OTP read/write in case keep the
update-to-date snapshot of OTP.

Signed-off-by: Green Wan <green.wan@sifive.com>
---
 hw/riscv/sifive_u.c             | 26 +++++++++++
 hw/riscv/sifive_u_otp.c         | 83 +++++++++++++++++++++++++++++++++
 include/hw/riscv/sifive_u.h     |  2 +
 include/hw/riscv/sifive_u_otp.h |  1 +
 4 files changed, 112 insertions(+)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index e5682c38a9..c818496918 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -87,6 +87,7 @@ static const struct MemmapEntry {
 };
 
 #define OTP_SERIAL          1
+#define OTP_FILE            "NULL"
 #define GEM_REVISION        0x10070109
 
 static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
@@ -387,6 +388,8 @@ static void sifive_u_machine_init(MachineState *machine)
     object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_RISCV_U_SOC);
     object_property_set_uint(OBJECT(&s->soc), "serial", s->serial,
                              &error_abort);
+    object_property_set_str(OBJECT(&s->soc), "otp-file", s->otp_file,
+                             &error_abort);
     qdev_realize(DEVICE(&s->soc), NULL, &error_abort);
 
     /* register RAM */
@@ -526,6 +529,21 @@ static void sifive_u_machine_set_uint32_prop(Object *obj, Visitor *v,
     visit_type_uint32(v, name, (uint32_t *)opaque, errp);
 }
 
+static void sifive_u_machine_get_str_prop(Object *obj, Visitor *v,
+                                             const char *name, void *opaque,
+                                             Error **errp)
+{
+    visit_type_str(v, name, (char **)opaque, errp);
+}
+
+static void sifive_u_machine_set_str_prop(Object *obj, Visitor *v,
+                                             const char *name, void *opaque,
+                                             Error **errp)
+{
+    visit_type_str(v, name, (char **)opaque, errp);
+}
+
+
 static void sifive_u_machine_instance_init(Object *obj)
 {
     SiFiveUState *s = RISCV_U_MACHINE(obj);
@@ -551,6 +569,12 @@ static void sifive_u_machine_instance_init(Object *obj)
                         sifive_u_machine_get_uint32_prop,
                         sifive_u_machine_set_uint32_prop, NULL, &s->serial);
     object_property_set_description(obj, "serial", "Board serial number");
+
+    s->otp_file = (char *)OTP_FILE;
+    object_property_add(obj, "otp-file", "string",
+                        sifive_u_machine_get_str_prop,
+                        sifive_u_machine_set_str_prop, NULL, &s->otp_file);
+    object_property_set_description(obj, "otp-file", "file-backed otp file");
 }
 
 static void sifive_u_machine_class_init(ObjectClass *oc, void *data)
@@ -709,6 +733,7 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
     }
 
     qdev_prop_set_uint32(DEVICE(&s->otp), "serial", s->serial);
+    qdev_prop_set_string(DEVICE(&s->otp), "otp-file", s->otp_file);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->otp), errp)) {
         return;
     }
@@ -737,6 +762,7 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
 
 static Property sifive_u_soc_props[] = {
     DEFINE_PROP_UINT32("serial", SiFiveUSoCState, serial, OTP_SERIAL),
+    DEFINE_PROP_STRING("otp-file", SiFiveUSoCState, otp_file),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/hw/riscv/sifive_u_otp.c b/hw/riscv/sifive_u_otp.c
index f6ecbaa2ca..e359f30fdb 100644
--- a/hw/riscv/sifive_u_otp.c
+++ b/hw/riscv/sifive_u_otp.c
@@ -24,6 +24,62 @@
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
+static int32_t sifive_u_otp_backed_open(const char *filename, int32_t *fd,
+                                        uint32_t **map)
+{
+    /* open and mmap OTP image file */
+    if (filename && strcmp(filename, "NULL") != 0) {
+        *fd = open(filename, O_RDWR);
+
+        if (*fd < 0) {
+            qemu_log_mask(LOG_TRACE,
+                          TRACE_PREFIX "Warning: can't open otp file<%s>\n",
+                          filename);
+            return -1;
+        } else {
+
+            *map = (unsigned int *)mmap(0,
+                                         SIFIVE_FU540_OTP_SIZE,
+                                         PROT_READ | PROT_WRITE | PROT_EXEC,
+                                         MAP_FILE | MAP_SHARED,
+                                         *fd,
+                                         0);
+
+            if (*map == MAP_FAILED) {
+                qemu_log_mask(LOG_TRACE,
+                              TRACE_PREFIX "Warning: can't mmap otp file<%s>\n",
+                              filename);
+                close(*fd);
+                return -2;
+            }
+        }
+    } else {
+        /* filename is 'NULL' */
+        return -3;
+    }
+
+    return 0;
+}
+
+static int32_t sifive_u_otp_backed_close(int fd, unsigned int *map)
+{
+    munmap(map, SIFIVE_FU540_OTP_SIZE);
+    close(fd);
+
+    return 0;
+}
 
 static uint64_t sifive_u_otp_read(void *opaque, hwaddr addr, unsigned int size)
 {
@@ -46,6 +102,20 @@ static uint64_t sifive_u_otp_read(void *opaque, hwaddr addr, unsigned int size)
         if ((s->pce & SIFIVE_U_OTP_PCE_EN) &&
             (s->pdstb & SIFIVE_U_OTP_PDSTB_EN) &&
             (s->ptrim & SIFIVE_U_OTP_PTRIM_EN)) {
+
+            int32_t fd;
+            uint32_t *map;
+            uint64_t val;
+
+            /* open and mmap OTP image file */
+            if (0 == sifive_u_otp_backed_open(s->otp_file, &fd, &map)) {
+                val = (uint64_t)(map[s->pa]);
+
+                /* close and unmmap */
+                sifive_u_otp_backed_close(fd, map);
+                return val;
+            }
+
             return s->fuse[s->pa & SIFIVE_U_OTP_PA_MASK];
         } else {
             return 0xff;
@@ -78,6 +148,8 @@ static void sifive_u_otp_write(void *opaque, hwaddr addr,
 {
     SiFiveUOTPState *s = opaque;
     uint32_t val32 = (uint32_t)val64;
+    int32_t fd;
+    uint32_t *map;
 
     switch (addr) {
     case SIFIVE_U_OTP_PA:
@@ -123,6 +195,16 @@ static void sifive_u_otp_write(void *opaque, hwaddr addr,
         s->ptrim = val32;
         break;
     case SIFIVE_U_OTP_PWE:
+        /* open and mmap OTP image file */
+        if (0 == sifive_u_otp_backed_open(s->otp_file, &fd, &map)) {
+            /* store value */
+            map[s->pa] &= ~(s->pdin << s->paio);
+            map[s->pa] |= (s->pdin << s->paio);
+
+            /* close and unmmap */
+            sifive_u_otp_backed_close(fd, map);
+        }
+
         s->pwe = val32;
         break;
     default:
@@ -143,6 +225,7 @@ static const MemoryRegionOps sifive_u_otp_ops = {
 
 static Property sifive_u_otp_properties[] = {
     DEFINE_PROP_UINT32("serial", SiFiveUOTPState, serial, 0),
+    DEFINE_PROP_STRING("otp-file", SiFiveUOTPState, otp_file),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index aba4d0181f..966723da1d 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -46,6 +46,7 @@ typedef struct SiFiveUSoCState {
     CadenceGEMState gem;
 
     uint32_t serial;
+    char *otp_file;
 } SiFiveUSoCState;
 
 #define TYPE_RISCV_U_MACHINE MACHINE_TYPE_NAME("sifive_u")
@@ -65,6 +66,7 @@ typedef struct SiFiveUState {
     bool start_in_flash;
     uint32_t msel;
     uint32_t serial;
+    char *otp_file;
 } SiFiveUState;
 
 enum {
diff --git a/include/hw/riscv/sifive_u_otp.h b/include/hw/riscv/sifive_u_otp.h
index 639297564a..f3d71ce82d 100644
--- a/include/hw/riscv/sifive_u_otp.h
+++ b/include/hw/riscv/sifive_u_otp.h
@@ -75,6 +75,7 @@ typedef struct SiFiveUOTPState {
     uint32_t fuse[SIFIVE_U_OTP_NUM_FUSES];
     /* config */
     uint32_t serial;
+    char *otp_file;
 } SiFiveUOTPState;
 
 #endif /* HW_SIFIVE_U_OTP_H */
-- 
2.17.1



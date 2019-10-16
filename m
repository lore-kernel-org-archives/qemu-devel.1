Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22957FA372A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 16:57:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF74721835
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 16:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jVqA+54P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF74721835
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKmcD-0008DC-20
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 12:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36354)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <3eEinXQYKCpkL3F7B69HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--sameid.bounces.google.com>)
 id 1iKmNh-0004dD-4y
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:42:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <3eEinXQYKCpkL3F7B69HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--sameid.bounces.google.com>)
 id 1iKmNe-0006OJ-Ix
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:42:37 -0400
Received: from mail-ua1-x949.google.com ([2607:f8b0:4864:20::949]:50525)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <3eEinXQYKCpkL3F7B69HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--sameid.bounces.google.com>)
 id 1iKmNe-0006NV-EU
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:42:34 -0400
Received: by mail-ua1-x949.google.com with SMTP id y4so5474159uaa.17
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 09:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=qE39xvt9M+c9HTM4QJYhh3xUrhI6EHqKxOejq8oTETM=;
 b=jVqA+54POi4MJ+y5G5bFtF4SgBhDfQvLn6NBhMVLM6FotoH/edeOewb+vDAZHBrrxu
 ZuX8SGes3FfUyvnLg6D/dk2xNdK7BK7FhHjl1k8qabfRHRjrsh6ofcZS6zrYIkycyc2c
 TAhwDNSANGAUSJ+DheGVeT6knrZwELxHEBecz96/iiOdPNZv+dgNDEZoCsQHeAaKz7SZ
 RbJPaR6snCxR9JyFvTEqe1iBQo975Ugh2EeFAFFd0UKr3YubgvYS1KRMi7BopC/D5re/
 xAoGKBP/w8YgRN77pPwt/pyjh1cQzXgqhg/QntLrcbeRniY6suzpiSBX2MusIY97T8Qj
 uIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=qE39xvt9M+c9HTM4QJYhh3xUrhI6EHqKxOejq8oTETM=;
 b=nI9Lo62PmsWuMRFoR4VzvtInnfuv7iZR2BvV1SG/Hi5CYZru/vIwFHX4OgsS+oQtDb
 +PADy+zubxrB9UBu3vdeX4GTX1On8qVjnD1mrckEt4cY0JEjPfhT4JH9H6ChsESLZvt7
 nSAmATtT7UfKfM/rBoLNhcKQeKZ9w27R5NsHk2V9//yWxoyg3e9CJu1xY5dGVwIxS6z0
 jI0UqtvWT1ZfR8b02gxXIgKBwR5M6/W0+4AcgX6YglImTvtm6+7iWTBFi0OqzGtxtrSA
 5LfcDt91WMb/r3xEui3ngBneeXWVuewSACvfXXELptEBwVAaiuzptMLi+R2rvoeLrtJ1
 UeDg==
X-Gm-Message-State: APjAAAWEP1Y3JOOMS+SfJvD8fF+lFbbnhdpsSzCX8DtSQKg8q7bkztwb
 c8IE8IBYJclEjfV4ix/SA4xjXbidJq/swFk53zkWsl/D/WGNtD+M6UXlJ788hpZgKVRPLj68vSD
 3/Pdc1jmBsSLOfL4FQvGfB16RNTgYd6YpSBIjU66srG66wo12tO+9oTLDb6mG
X-Google-Smtp-Source: APXvYqz1IRUcu5bsMjufbC+5VO1oi0Z6VB1mbU/t7zl0J5ODQSiVVpxAPd2BFCX+tO9Snrtr/Jqnw3lp6w0=
X-Received: by 2002:ab0:4a48:: with SMTP id r8mr19610506uae.62.1571244152649; 
 Wed, 16 Oct 2019 09:42:32 -0700 (PDT)
Date: Wed, 16 Oct 2019 19:41:45 +0300
In-Reply-To: <20191016164145.115898-1-sameid@google.com>
Message-Id: <20191016164145.115898-10-sameid@google.com>
Mime-Version: 1.0
References: <20191016164145.115898-1-sameid@google.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH v8 8/8] hd-geo-test: Add tests for lchs override
From: Sam Eiderman <sameid@google.com>
To: qemu-devel@nongnu.org
Cc: arbel.moshe@oracle.com, karl.heubaum@oracle.com, kevin@koconnor.net, 
 kraxel@redhat.com, kwolf@redhat.com, liran.alon@oracle.com, 
 qemu-block@nongnu.org, sameid@google.com, seabios@seabios.org, 
 lersek@redhat.com, philmd@redhat.com, jsnow@redhat.com, 
 Sam Eiderman <shmuel.eiderman@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::949
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sam Eiderman <shmuel.eiderman@oracle.com>

Add QTest tests to check the logical geometry override option.

The tests in hd-geo-test are out of date - they only test IDE and do not
test interesting MBRs.

Creating qcow2 disks with specific size and MBR layout is currently
unused - we only use a default empty MBR.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
Signed-off-by: Sam Eiderman <sameid@google.com>
---
 tests/Makefile.include |   2 +-
 tests/hd-geo-test.c    | 551 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 552 insertions(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3543451ed3..6941ae7c77 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -780,7 +780,7 @@ tests/ide-test$(EXESUF): tests/ide-test.o $(libqos-pc-obj-y)
 tests/ahci-test$(EXESUF): tests/ahci-test.o $(libqos-pc-obj-y) qemu-img$(EXESUF)
 tests/ipmi-kcs-test$(EXESUF): tests/ipmi-kcs-test.o
 tests/ipmi-bt-test$(EXESUF): tests/ipmi-bt-test.o
-tests/hd-geo-test$(EXESUF): tests/hd-geo-test.o
+tests/hd-geo-test$(EXESUF): tests/hd-geo-test.o $(libqos-obj-y)
 tests/boot-order-test$(EXESUF): tests/boot-order-test.o $(libqos-obj-y)
 tests/boot-serial-test$(EXESUF): tests/boot-serial-test.o $(libqos-obj-y)
 tests/bios-tables-test$(EXESUF): tests/bios-tables-test.o \
diff --git a/tests/hd-geo-test.c b/tests/hd-geo-test.c
index 62eb624726..7e86c5416c 100644
--- a/tests/hd-geo-test.c
+++ b/tests/hd-geo-test.c
@@ -17,7 +17,12 @@
 
 #include "qemu/osdep.h"
 #include "qemu-common.h"
+#include "qemu/bswap.h"
+#include "qapi/qmp/qlist.h"
 #include "libqtest.h"
+#include "libqos/fw_cfg.h"
+#include "libqos/libqos.h"
+#include "standard-headers/linux/qemu_fw_cfg.h"
 
 #define ARGV_SIZE 256
 
@@ -388,6 +393,537 @@ static void test_ide_drive_cd_0(void)
     qtest_quit(qts);
 }
 
+typedef struct {
+    bool active;
+    uint32_t head;
+    uint32_t sector;
+    uint32_t cyl;
+    uint32_t end_head;
+    uint32_t end_sector;
+    uint32_t end_cyl;
+    uint32_t start_sect;
+    uint32_t nr_sects;
+} MBRpartitions[4];
+
+static MBRpartitions empty_mbr = { {false, 0, 0, 0, 0, 0, 0, 0, 0},
+                                   {false, 0, 0, 0, 0, 0, 0, 0, 0},
+                                   {false, 0, 0, 0, 0, 0, 0, 0, 0},
+                                   {false, 0, 0, 0, 0, 0, 0, 0, 0} };
+
+static char *create_qcow2_with_mbr(MBRpartitions mbr, uint64_t sectors)
+{
+    const char *template = "/tmp/qtest.XXXXXX";
+    char *raw_path = strdup(template);
+    char *qcow2_path = strdup(template);
+    char cmd[100 + 2 * PATH_MAX];
+    uint8_t buf[512];
+    int i, ret, fd, offset;
+    uint64_t qcow2_size = sectors * 512;
+    uint8_t status, parttype, head, sector, cyl;
+    char *qemu_img_path;
+    char *qemu_img_abs_path;
+
+    offset = 0xbe;
+
+    for (i = 0; i < 4; i++) {
+        status = mbr[i].active ? 0x80 : 0x00;
+        g_assert(mbr[i].head < 256);
+        g_assert(mbr[i].sector < 64);
+        g_assert(mbr[i].cyl < 1024);
+        head = mbr[i].head;
+        sector = mbr[i].sector + ((mbr[i].cyl & 0x300) >> 2);
+        cyl = mbr[i].cyl & 0xff;
+
+        buf[offset + 0x0] = status;
+        buf[offset + 0x1] = head;
+        buf[offset + 0x2] = sector;
+        buf[offset + 0x3] = cyl;
+
+        parttype = 0;
+        g_assert(mbr[i].end_head < 256);
+        g_assert(mbr[i].end_sector < 64);
+        g_assert(mbr[i].end_cyl < 1024);
+        head = mbr[i].end_head;
+        sector = mbr[i].end_sector + ((mbr[i].end_cyl & 0x300) >> 2);
+        cyl = mbr[i].end_cyl & 0xff;
+
+        buf[offset + 0x4] = parttype;
+        buf[offset + 0x5] = head;
+        buf[offset + 0x6] = sector;
+        buf[offset + 0x7] = cyl;
+
+        (*(uint32_t *)&buf[offset + 0x8]) = cpu_to_le32(mbr[i].start_sect);
+        (*(uint32_t *)&buf[offset + 0xc]) = cpu_to_le32(mbr[i].nr_sects);
+
+        offset += 0x10;
+    }
+
+    fd = mkstemp(raw_path);
+    g_assert(fd);
+    close(fd);
+
+    fd = open(raw_path, O_WRONLY);
+    g_assert(fd >= 0);
+    ret = write(fd, buf, sizeof(buf));
+    g_assert(ret == sizeof(buf));
+    close(fd);
+
+    fd = mkstemp(qcow2_path);
+    g_assert(fd);
+    close(fd);
+
+    qemu_img_path = getenv("QTEST_QEMU_IMG");
+    g_assert(qemu_img_path);
+    qemu_img_abs_path = realpath(qemu_img_path, NULL);
+    g_assert(qemu_img_abs_path);
+
+    ret = snprintf(cmd, sizeof(cmd),
+                   "%s convert -f raw -O qcow2 %s %s > /dev/null",
+                   qemu_img_abs_path,
+                   raw_path, qcow2_path);
+    g_assert((0 < ret) && (ret <= sizeof(cmd)));
+    ret = system(cmd);
+    g_assert(ret == 0);
+
+    ret = snprintf(cmd, sizeof(cmd),
+                   "%s resize %s %" PRIu64 " > /dev/null",
+                   qemu_img_abs_path,
+                   qcow2_path, qcow2_size);
+    g_assert((0 < ret) && (ret <= sizeof(cmd)));
+    ret = system(cmd);
+    g_assert(ret == 0);
+
+    free(qemu_img_abs_path);
+
+    unlink(raw_path);
+    free(raw_path);
+
+    return qcow2_path;
+}
+
+#define BIOS_GEOMETRY_MAX_SIZE 10000
+
+typedef struct {
+    uint32_t c;
+    uint32_t h;
+    uint32_t s;
+} CHS;
+
+typedef struct {
+    const char *dev_path;
+    CHS chs;
+} CHSResult;
+
+static void read_bootdevices(QFWCFG *fw_cfg, CHSResult expected[])
+{
+    char *buf = g_malloc0(BIOS_GEOMETRY_MAX_SIZE);
+    char *cur;
+    GList *results = NULL, *cur_result;
+    CHSResult *r;
+    int i;
+    int res;
+    bool found;
+
+    qfw_cfg_get_file(fw_cfg, "bios-geometry", buf, BIOS_GEOMETRY_MAX_SIZE);
+
+    for (cur = buf; *cur; cur++) {
+        if (*cur == '\n') {
+            *cur = '\0';
+        }
+    }
+    cur = buf;
+
+    while (strlen(cur)) {
+
+        r = g_malloc0(sizeof(*r));
+        r->dev_path = g_malloc0(strlen(cur) + 1);
+        res = sscanf(cur, "%s %" PRIu32 " %" PRIu32 " %" PRIu32,
+                     (char *)r->dev_path,
+                     &(r->chs.c), &(r->chs.h), &(r->chs.s));
+
+        g_assert(res == 4);
+
+        results = g_list_prepend(results, r);
+
+        cur += strlen(cur) + 1;
+    }
+
+    i = 0;
+
+    while (expected[i].dev_path) {
+        found = false;
+        cur_result = results;
+        while (cur_result) {
+            r = cur_result->data;
+            if (!strcmp(r->dev_path, expected[i].dev_path) &&
+                !memcmp(&(r->chs), &(expected[i].chs), sizeof(r->chs))) {
+                found = true;
+                break;
+            }
+            cur_result = g_list_next(cur_result);
+        }
+        g_assert(found);
+        g_free((char *)((CHSResult *)cur_result->data)->dev_path);
+        g_free(cur_result->data);
+        results = g_list_delete_link(results, cur_result);
+        i++;
+    }
+
+    g_assert(results == NULL);
+
+    g_free(buf);
+}
+
+#define MAX_DRIVES 30
+
+typedef struct {
+    char **argv;
+    int argc;
+    char **drives;
+    int n_drives;
+    int n_scsi_disks;
+    int n_scsi_controllers;
+    int n_virtio_disks;
+} TestArgs;
+
+static TestArgs *create_args(void)
+{
+    TestArgs *args = g_malloc0(sizeof(*args));
+    args->argv = g_new0(char *, ARGV_SIZE);
+    args->argc = append_arg(args->argc, args->argv,
+                            ARGV_SIZE, g_strdup("-nodefaults"));
+    args->drives = g_new0(char *, MAX_DRIVES);
+    return args;
+}
+
+static void add_drive_with_mbr(TestArgs *args,
+                               MBRpartitions mbr, uint64_t sectors)
+{
+    char *img_file_name;
+    char part[300];
+    int ret;
+
+    g_assert(args->n_drives < MAX_DRIVES);
+
+    img_file_name = create_qcow2_with_mbr(mbr, sectors);
+
+    args->drives[args->n_drives] = img_file_name;
+    ret = snprintf(part, sizeof(part),
+                   "-drive file=%s,if=none,format=qcow2,id=disk%d",
+                   img_file_name, args->n_drives);
+    g_assert((0 < ret) && (ret <= sizeof(part)));
+    args->argc = append_arg(args->argc, args->argv, ARGV_SIZE, g_strdup(part));
+    args->n_drives++;
+}
+
+static void add_ide_disk(TestArgs *args,
+                         int drive_idx, int bus, int unit, int c, int h, int s)
+{
+    char part[300];
+    int ret;
+
+    ret = snprintf(part, sizeof(part),
+                   "-device ide-hd,drive=disk%d,bus=ide.%d,unit=%d,"
+                   "lcyls=%d,lheads=%d,lsecs=%d",
+                   drive_idx, bus, unit, c, h, s);
+    g_assert((0 < ret) && (ret <= sizeof(part)));
+    args->argc = append_arg(args->argc, args->argv, ARGV_SIZE, g_strdup(part));
+}
+
+static void add_scsi_controller(TestArgs *args,
+                                const char *type,
+                                const char *bus,
+                                int addr)
+{
+    char part[300];
+    int ret;
+
+    ret = snprintf(part, sizeof(part),
+                   "-device %s,id=scsi%d,bus=%s,addr=%d",
+                   type, args->n_scsi_controllers, bus, addr);
+    g_assert((0 < ret) && (ret <= sizeof(part)));
+    args->argc = append_arg(args->argc, args->argv, ARGV_SIZE, g_strdup(part));
+    args->n_scsi_controllers++;
+}
+
+static void add_scsi_disk(TestArgs *args,
+                          int drive_idx, int bus,
+                          int channel, int scsi_id, int lun,
+                          int c, int h, int s)
+{
+    char part[300];
+    int ret;
+
+    ret = snprintf(part, sizeof(part),
+                   "-device scsi-hd,id=scsi-disk%d,drive=disk%d,"
+                   "bus=scsi%d.0,"
+                   "channel=%d,scsi-id=%d,lun=%d,"
+                   "lcyls=%d,lheads=%d,lsecs=%d",
+                   args->n_scsi_disks, drive_idx, bus, channel, scsi_id, lun,
+                   c, h, s);
+    g_assert((0 < ret) && (ret <= sizeof(part)));
+    args->argc = append_arg(args->argc, args->argv, ARGV_SIZE, g_strdup(part));
+    args->n_scsi_disks++;
+}
+
+static void add_virtio_disk(TestArgs *args,
+                            int drive_idx, const char *bus, int addr,
+                            int c, int h, int s)
+{
+    char part[300];
+    int ret;
+
+    ret = snprintf(part, sizeof(part),
+                   "-device virtio-blk-pci,id=virtio-disk%d,"
+                   "drive=disk%d,bus=%s,addr=%d,"
+                   "lcyls=%d,lheads=%d,lsecs=%d",
+                   args->n_virtio_disks, drive_idx, bus, addr, c, h, s);
+    g_assert((0 < ret) && (ret <= sizeof(part)));
+    args->argc = append_arg(args->argc, args->argv, ARGV_SIZE, g_strdup(part));
+    args->n_virtio_disks++;
+}
+
+static void test_override(TestArgs *args, CHSResult expected[])
+{
+    QTestState *qts;
+    char *joined_args;
+    QFWCFG *fw_cfg;
+    int i;
+
+    joined_args = g_strjoinv(" ", args->argv);
+
+    qts = qtest_init(joined_args);
+    fw_cfg = pc_fw_cfg_init(qts);
+
+    read_bootdevices(fw_cfg, expected);
+
+    g_free(joined_args);
+    qtest_quit(qts);
+
+    g_free(fw_cfg);
+
+    for (i = 0; i < args->n_drives; i++) {
+        unlink(args->drives[i]);
+        free(args->drives[i]);
+    }
+    g_free(args->drives);
+    g_strfreev(args->argv);
+    g_free(args);
+}
+
+static void test_override_ide(void)
+{
+    TestArgs *args = create_args();
+    CHSResult expected[] = {
+        {"/pci@i0cf8/ide@1,1/drive@0/disk@0", {10000, 120, 30} },
+        {"/pci@i0cf8/ide@1,1/drive@0/disk@1", {9000, 120, 30} },
+        {"/pci@i0cf8/ide@1,1/drive@1/disk@0", {0, 1, 1} },
+        {"/pci@i0cf8/ide@1,1/drive@1/disk@1", {1, 0, 0} },
+        {NULL, {0, 0, 0} }
+    };
+    add_drive_with_mbr(args, empty_mbr, 1);
+    add_drive_with_mbr(args, empty_mbr, 1);
+    add_drive_with_mbr(args, empty_mbr, 1);
+    add_drive_with_mbr(args, empty_mbr, 1);
+    add_ide_disk(args, 0, 0, 0, 10000, 120, 30);
+    add_ide_disk(args, 1, 0, 1, 9000, 120, 30);
+    add_ide_disk(args, 2, 1, 0, 0, 1, 1);
+    add_ide_disk(args, 3, 1, 1, 1, 0, 0);
+    test_override(args, expected);
+}
+
+static void test_override_scsi(void)
+{
+    TestArgs *args = create_args();
+    CHSResult expected[] = {
+        {"/pci@i0cf8/scsi@3/channel@0/disk@0,0", {10000, 120, 30} },
+        {"/pci@i0cf8/scsi@3/channel@0/disk@1,0", {9000, 120, 30} },
+        {"/pci@i0cf8/scsi@3/channel@0/disk@2,0", {1, 0, 0} },
+        {"/pci@i0cf8/scsi@3/channel@0/disk@3,0", {0, 1, 0} },
+        {NULL, {0, 0, 0} }
+    };
+    add_drive_with_mbr(args, empty_mbr, 1);
+    add_drive_with_mbr(args, empty_mbr, 1);
+    add_drive_with_mbr(args, empty_mbr, 1);
+    add_drive_with_mbr(args, empty_mbr, 1);
+    add_scsi_controller(args, "lsi53c895a", "pci.0", 3);
+    add_scsi_disk(args, 0, 0, 0, 0, 0, 10000, 120, 30);
+    add_scsi_disk(args, 1, 0, 0, 1, 0, 9000, 120, 30);
+    add_scsi_disk(args, 2, 0, 0, 2, 0, 1, 0, 0);
+    add_scsi_disk(args, 3, 0, 0, 3, 0, 0, 1, 0);
+    test_override(args, expected);
+}
+
+static void test_override_scsi_2_controllers(void)
+{
+    TestArgs *args = create_args();
+    CHSResult expected[] = {
+        {"/pci@i0cf8/scsi@3/channel@0/disk@0,0", {10000, 120, 30} },
+        {"/pci@i0cf8/scsi@3/channel@0/disk@1,0", {9000, 120, 30} },
+        {"/pci@i0cf8/scsi@4/channel@0/disk@0,1", {1, 0, 0} },
+        {"/pci@i0cf8/scsi@4/channel@0/disk@1,2", {0, 1, 0} },
+        {NULL, {0, 0, 0} }
+    };
+    add_drive_with_mbr(args, empty_mbr, 1);
+    add_drive_with_mbr(args, empty_mbr, 1);
+    add_drive_with_mbr(args, empty_mbr, 1);
+    add_drive_with_mbr(args, empty_mbr, 1);
+    add_scsi_controller(args, "lsi53c895a", "pci.0", 3);
+    add_scsi_controller(args, "virtio-scsi-pci", "pci.0", 4);
+    add_scsi_disk(args, 0, 0, 0, 0, 0, 10000, 120, 30);
+    add_scsi_disk(args, 1, 0, 0, 1, 0, 9000, 120, 30);
+    add_scsi_disk(args, 2, 1, 0, 0, 1, 1, 0, 0);
+    add_scsi_disk(args, 3, 1, 0, 1, 2, 0, 1, 0);
+    test_override(args, expected);
+}
+
+static void test_override_virtio_blk(void)
+{
+    TestArgs *args = create_args();
+    CHSResult expected[] = {
+        {"/pci@i0cf8/scsi@3/disk@0,0", {10000, 120, 30} },
+        {"/pci@i0cf8/scsi@4/disk@0,0", {9000, 120, 30} },
+        {NULL, {0, 0, 0} }
+    };
+    add_drive_with_mbr(args, empty_mbr, 1);
+    add_drive_with_mbr(args, empty_mbr, 1);
+    add_virtio_disk(args, 0, "pci.0", 3, 10000, 120, 30);
+    add_virtio_disk(args, 1, "pci.0", 4, 9000, 120, 30);
+    test_override(args, expected);
+}
+
+static void test_override_zero_chs(void)
+{
+    TestArgs *args = create_args();
+    CHSResult expected[] = {
+        {NULL, {0, 0, 0} }
+    };
+    add_drive_with_mbr(args, empty_mbr, 1);
+    add_ide_disk(args, 0, 1, 1, 0, 0, 0);
+    test_override(args, expected);
+}
+
+static void test_override_scsi_hot_unplug(void)
+{
+    QTestState *qts;
+    char *joined_args;
+    QFWCFG *fw_cfg;
+    QDict *response;
+    int i;
+    TestArgs *args = create_args();
+    CHSResult expected[] = {
+        {"/pci@i0cf8/scsi@2/channel@0/disk@0,0", {10000, 120, 30} },
+        {"/pci@i0cf8/scsi@2/channel@0/disk@1,0", {20, 20, 20} },
+        {NULL, {0, 0, 0} }
+    };
+    CHSResult expected2[] = {
+        {"/pci@i0cf8/scsi@2/channel@0/disk@1,0", {20, 20, 20} },
+        {NULL, {0, 0, 0} }
+    };
+    add_drive_with_mbr(args, empty_mbr, 1);
+    add_drive_with_mbr(args, empty_mbr, 1);
+    add_scsi_controller(args, "virtio-scsi-pci", "pci.0", 2);
+    add_scsi_disk(args, 0, 0, 0, 0, 0, 10000, 120, 30);
+    add_scsi_disk(args, 1, 0, 0, 1, 0, 20, 20, 20);
+
+    joined_args = g_strjoinv(" ", args->argv);
+
+    qts = qtest_init(joined_args);
+    fw_cfg = pc_fw_cfg_init(qts);
+
+    read_bootdevices(fw_cfg, expected);
+
+    /* unplug device an restart */
+    response = qtest_qmp(qts,
+                         "{ 'execute': 'device_del',"
+                         "  'arguments': {'id': 'scsi-disk0' }}");
+    g_assert(response);
+    g_assert(!qdict_haskey(response, "error"));
+    qobject_unref(response);
+    response = qtest_qmp(qts,
+                         "{ 'execute': 'system_reset', 'arguments': { }}");
+    g_assert(response);
+    g_assert(!qdict_haskey(response, "error"));
+    qobject_unref(response);
+
+    qtest_qmp_eventwait(qts, "RESET");
+
+    read_bootdevices(fw_cfg, expected2);
+
+    g_free(joined_args);
+    qtest_quit(qts);
+
+    g_free(fw_cfg);
+
+    for (i = 0; i < args->n_drives; i++) {
+        unlink(args->drives[i]);
+        free(args->drives[i]);
+    }
+    g_free(args->drives);
+    g_strfreev(args->argv);
+    g_free(args);
+}
+
+static void test_override_virtio_hot_unplug(void)
+{
+    QTestState *qts;
+    char *joined_args;
+    QFWCFG *fw_cfg;
+    QDict *response;
+    int i;
+    TestArgs *args = create_args();
+    CHSResult expected[] = {
+        {"/pci@i0cf8/scsi@2/disk@0,0", {10000, 120, 30} },
+        {"/pci@i0cf8/scsi@3/disk@0,0", {20, 20, 20} },
+        {NULL, {0, 0, 0} }
+    };
+    CHSResult expected2[] = {
+        {"/pci@i0cf8/scsi@3/disk@0,0", {20, 20, 20} },
+        {NULL, {0, 0, 0} }
+    };
+    add_drive_with_mbr(args, empty_mbr, 1);
+    add_drive_with_mbr(args, empty_mbr, 1);
+    add_virtio_disk(args, 0, "pci.0", 2, 10000, 120, 30);
+    add_virtio_disk(args, 1, "pci.0", 3, 20, 20, 20);
+
+    joined_args = g_strjoinv(" ", args->argv);
+
+    qts = qtest_init(joined_args);
+    fw_cfg = pc_fw_cfg_init(qts);
+
+    read_bootdevices(fw_cfg, expected);
+
+    /* unplug device an restart */
+    response = qtest_qmp(qts,
+                         "{ 'execute': 'device_del',"
+                         "  'arguments': {'id': 'virtio-disk0' }}");
+    g_assert(response);
+    g_assert(!qdict_haskey(response, "error"));
+    qobject_unref(response);
+    response = qtest_qmp(qts,
+                         "{ 'execute': 'system_reset', 'arguments': { }}");
+    g_assert(response);
+    g_assert(!qdict_haskey(response, "error"));
+    qobject_unref(response);
+
+    qtest_qmp_eventwait(qts, "RESET");
+
+    read_bootdevices(fw_cfg, expected2);
+
+    g_free(joined_args);
+    qtest_quit(qts);
+
+    g_free(fw_cfg);
+
+    for (i = 0; i < args->n_drives; i++) {
+        unlink(args->drives[i]);
+        free(args->drives[i]);
+    }
+    g_free(args->drives);
+    g_strfreev(args->argv);
+    g_free(args);
+}
+
 int main(int argc, char **argv)
 {
     Backend i;
@@ -413,6 +949,21 @@ int main(int argc, char **argv)
     qtest_add_func("hd-geo/ide/device/mbr/chs", test_ide_device_mbr_chs);
     qtest_add_func("hd-geo/ide/device/user/chs", test_ide_device_user_chs);
     qtest_add_func("hd-geo/ide/device/user/chst", test_ide_device_user_chst);
+    if (have_qemu_img()) {
+        qtest_add_func("hd-geo/override/ide", test_override_ide);
+        qtest_add_func("hd-geo/override/scsi", test_override_scsi);
+        qtest_add_func("hd-geo/override/scsi_2_controllers",
+                       test_override_scsi_2_controllers);
+        qtest_add_func("hd-geo/override/virtio_blk", test_override_virtio_blk);
+        qtest_add_func("hd-geo/override/zero_chs", test_override_zero_chs);
+        qtest_add_func("hd-geo/override/scsi_hot_unplug",
+                       test_override_scsi_hot_unplug);
+        qtest_add_func("hd-geo/override/virtio_hot_unplug",
+                       test_override_virtio_hot_unplug);
+    } else {
+        g_test_message("QTEST_QEMU_IMG not set or qemu-img missing; "
+                       "skipping hd-geo/override/* tests");
+    }
 
     ret = g_test_run();
 
-- 
2.23.0.700.g56cf767bdb-goog



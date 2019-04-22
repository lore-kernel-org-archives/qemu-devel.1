Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0904DC282CE
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 19:53:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEDD1204EC
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 19:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEDD1204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43494 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIezt-0005qN-2Y
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 15:53:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIexk-0004Kl-IS
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 15:50:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIexi-000856-C4
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 15:50:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>)
	id 1hIexe-000825-T9; Mon, 22 Apr 2019 15:50:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 847DF4628A;
	Mon, 22 Apr 2019 19:50:41 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-61.brq.redhat.com [10.40.204.61])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 787535D71E;
	Mon, 22 Apr 2019 19:50:36 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 22 Apr 2019 21:50:14 +0200
Message-Id: <20190422195020.1494-2-philmd@redhat.com>
In-Reply-To: <20190422195020.1494-1-philmd@redhat.com>
References: <20190422195020.1494-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Mon, 22 Apr 2019 19:50:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 1/7] hw/nvram/fw_cfg: Add trace events
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Eduardo Habkost <ehabkost@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
	Laszlo Ersek <lersek@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190422195014.9ihYdBLRUyu-IdhDEB1b93VTRGSDw70YpI6DCNrpb-M@z>

Add trace events to dump the key content.

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v1 -> v3:
- moved static fw_cfg_wellknown_keys[] in key_name()
- split trace_key_name() (can return "unknown")
  from key_name() (can return NULL)

Since changes from v1 are trivial, keep S-o-b tags.
---
 hw/nvram/fw_cfg.c     | 63 ++++++++++++++++++++++++++++++++++++++++++-
 hw/nvram/trace-events |  7 ++++-
 2 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 5c3a46ce6f2..d374a970fea 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -60,6 +60,62 @@ struct FWCfgEntry {
     FWCfgWriteCallback write_cb;
 };
=20
+/**
+ * key_name:
+ *
+ * @key: The uint16 selector key.
+ *
+ * Returns: The stringified name if the selector refers to a well-known
+ *          numerically defined item, or NULL on key lookup failure.
+ */
+static const char *key_name(uint16_t key)
+{
+    static const char *fw_cfg_wellknown_keys[FW_CFG_FILE_FIRST] =3D {
+        [FW_CFG_SIGNATURE] =3D "signature",
+        [FW_CFG_ID] =3D "id",
+        [FW_CFG_UUID] =3D "uuid",
+        [FW_CFG_RAM_SIZE] =3D "ram_size",
+        [FW_CFG_NOGRAPHIC] =3D "nographic",
+        [FW_CFG_NB_CPUS] =3D "nb_cpus",
+        [FW_CFG_MACHINE_ID] =3D "machine_id",
+        [FW_CFG_KERNEL_ADDR] =3D "kernel_addr",
+        [FW_CFG_KERNEL_SIZE] =3D "kernel_size",
+        [FW_CFG_KERNEL_CMDLINE] =3D "kernel_cmdline",
+        [FW_CFG_INITRD_ADDR] =3D "initrd_addr",
+        [FW_CFG_INITRD_SIZE] =3D "initdr_size",
+        [FW_CFG_BOOT_DEVICE] =3D "boot_device",
+        [FW_CFG_NUMA] =3D "numa",
+        [FW_CFG_BOOT_MENU] =3D "boot_menu",
+        [FW_CFG_MAX_CPUS] =3D "max_cpus",
+        [FW_CFG_KERNEL_ENTRY] =3D "kernel_entry",
+        [FW_CFG_KERNEL_DATA] =3D "kernel_data",
+        [FW_CFG_INITRD_DATA] =3D "initrd_data",
+        [FW_CFG_CMDLINE_ADDR] =3D "cmdline_addr",
+        [FW_CFG_CMDLINE_SIZE] =3D "cmdline_size",
+        [FW_CFG_CMDLINE_DATA] =3D "cmdline_data",
+        [FW_CFG_SETUP_ADDR] =3D "setup_addr",
+        [FW_CFG_SETUP_SIZE] =3D "setup_size",
+        [FW_CFG_SETUP_DATA] =3D "setup_data",
+        [FW_CFG_FILE_DIR] =3D "file_dir",
+    };
+
+    if (key & FW_CFG_ARCH_LOCAL) {
+        return NULL;
+    }
+    if (key < FW_CFG_FILE_FIRST) {
+        return fw_cfg_wellknown_keys[key];
+    }
+
+    return NULL;
+}
+
+static inline const char *trace_key_name(uint16_t key)
+{
+    const char *name =3D key_name(key);
+
+    return name ? name : "unknown";
+}
+
 #define JPG_FILE 0
 #define BMP_FILE 1
=20
@@ -233,7 +289,7 @@ static int fw_cfg_select(FWCfgState *s, uint16_t key)
         }
     }
=20
-    trace_fw_cfg_select(s, key, ret);
+    trace_fw_cfg_select(s, key, trace_key_name(key), ret);
     return ret;
 }
=20
@@ -616,6 +672,7 @@ static void *fw_cfg_modify_bytes_read(FWCfgState *s, =
uint16_t key,
=20
 void fw_cfg_add_bytes(FWCfgState *s, uint16_t key, void *data, size_t le=
n)
 {
+    trace_fw_cfg_add_bytes(key, trace_key_name(key), len);
     fw_cfg_add_bytes_callback(s, key, NULL, NULL, NULL, data, len, true)=
;
 }
=20
@@ -623,6 +680,7 @@ void fw_cfg_add_string(FWCfgState *s, uint16_t key, c=
onst char *value)
 {
     size_t sz =3D strlen(value) + 1;
=20
+    trace_fw_cfg_add_string(key, trace_key_name(key), value);
     fw_cfg_add_bytes(s, key, g_memdup(value, sz), sz);
 }
=20
@@ -632,6 +690,7 @@ void fw_cfg_add_i16(FWCfgState *s, uint16_t key, uint=
16_t value)
=20
     copy =3D g_malloc(sizeof(value));
     *copy =3D cpu_to_le16(value);
+    trace_fw_cfg_add_i16(key, trace_key_name(key), value);
     fw_cfg_add_bytes(s, key, copy, sizeof(value));
 }
=20
@@ -651,6 +710,7 @@ void fw_cfg_add_i32(FWCfgState *s, uint16_t key, uint=
32_t value)
=20
     copy =3D g_malloc(sizeof(value));
     *copy =3D cpu_to_le32(value);
+    trace_fw_cfg_add_i32(key, trace_key_name(key), value);
     fw_cfg_add_bytes(s, key, copy, sizeof(value));
 }
=20
@@ -660,6 +720,7 @@ void fw_cfg_add_i64(FWCfgState *s, uint16_t key, uint=
64_t value)
=20
     copy =3D g_malloc(sizeof(value));
     *copy =3D cpu_to_le64(value);
+    trace_fw_cfg_add_i64(key, trace_key_name(key), value);
     fw_cfg_add_bytes(s, key, copy, sizeof(value));
 }
=20
diff --git a/hw/nvram/trace-events b/hw/nvram/trace-events
index e191991e2a8..0dea9260ce1 100644
--- a/hw/nvram/trace-events
+++ b/hw/nvram/trace-events
@@ -5,6 +5,11 @@ nvram_read(uint32_t addr, uint32_t ret) "read addr %d: 0=
x%02x"
 nvram_write(uint32_t addr, uint32_t old, uint32_t val) "write addr %d: 0=
x%02x -> 0x%02x"
=20
 # fw_cfg.c
-fw_cfg_select(void *s, uint16_t key, int ret) "%p key %d =3D %d"
+fw_cfg_select(void *s, uint16_t key_value, const char *key_name, int ret=
) "%p key 0x%04" PRIx16 " '%s', ret: %d"
 fw_cfg_read(void *s, uint64_t ret) "%p =3D 0x%"PRIx64
+fw_cfg_add_bytes(uint16_t key_value, const char *key_name, size_t len) "=
key 0x%04" PRIx16 " '%s', %zu bytes"
 fw_cfg_add_file(void *s, int index, char *name, size_t len) "%p #%d: %s =
(%zd bytes)"
+fw_cfg_add_string(uint16_t key_value, const char *key_name, const char *=
value) "key 0x%04" PRIx16 " '%s', value '%s'"
+fw_cfg_add_i16(uint16_t key_value, const char *key_name, uint16_t value)=
 "key 0x%04" PRIx16 " '%s', value 0x%" PRIx16
+fw_cfg_add_i32(uint16_t key_value, const char *key_name, uint32_t value)=
 "key 0x%04" PRIx16 " '%s', value 0x%" PRIx32
+fw_cfg_add_i64(uint16_t key_value, const char *key_name, uint64_t value)=
 "key 0x%04" PRIx16 " '%s', value 0x%" PRIx64
--=20
2.20.1



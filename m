Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8438C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 23:18:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 756E9206A4
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 23:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="o+J38nKI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 756E9206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW6py-000325-AJ
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 19:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=387c5e0cc=alistair.francis@wdc.com>)
 id 1jW6pD-0001td-87
 for qemu-devel@nongnu.org; Tue, 05 May 2020 19:18:07 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:50938)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=387c5e0cc=alistair.francis@wdc.com>)
 id 1jW6pC-0007G7-1q
 for qemu-devel@nongnu.org; Tue, 05 May 2020 19:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1588720687; x=1620256687;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hCXi4JrMuFCwKzE8foG1p8GTrmqDZrBdid/5XT1A6Qo=;
 b=o+J38nKIl/38kLpcXfDBoVlnl0iK24b0Ho1AB9T7R+F8JmvqGBiNujQL
 Z2Z6GeJkPa81Vo0geydySqoZ47HKRKNYSTR6Ypq2CajnHydwlBhDC8qOz
 KzXRZ7OtibbCC7Pf7nklpmVy46gSgUmlC9Ilp2X0NW7HS37V9BEGtcS0J
 kiDwbJCa6CfQ8dXdaL939eKOaLgh5aCbGtmpMhTxDsV8pPZfd6LYX9G7B
 S4YAnXdfqm5UROIuAmKGak2Y3nA+nhI0zTcfAFvhAQl4JInreSuIQkZI4
 K6ukjHoUriy0pAl8J5/NOPZ+rZYM/nknr42Qd9FQ6qWQmcC8Ct6kKQRh/ g==;
IronPort-SDR: Y/ZeesKoR4KMX7cD9awh9cFYDdEdN6rWDeizPBOXUedj3N8VJIMtjQxHzjw817W6jn1Ie3DxZ0
 Ht/R3RU21KbLKJf/Uila/XMVoMf9uid/8UusVGII65gvCBaiTZvJ2DEMyWu4qMnlOB0D6aQrr6
 y/BJQziJA+I/LGz6pA9nw3Gbj4mjfs8cV0WwR+J5er7e0vtpltDIDepS19H6pbRTsmxQBQ+yxR
 iFtej/i/OJheT6O8qk7sy/P1rzo9OzgAwLlaKYf8Qh0aDcI0B4oSD4vmuFmuGyXTcoLKElngEe
 DXE=
X-IronPort-AV: E=Sophos;i="5.73,357,1583164800"; d="scan'208";a="137331071"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 06 May 2020 07:18:00 +0800
IronPort-SDR: m86hkfuw2y8agm3Q7MCnDLMP01T5ZlNOsyprgWmC0ZHZ7euK5tsSxqYDwh3/VrQZdmfzz09uYj
 Xfq+z/mfEq+WZM+zO0BrBbiyTiYJMOF9U=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2020 16:07:53 -0700
IronPort-SDR: 9ymhMnGEnbj9c/raTHtSgbHhyvEBs6HQGwQO9229wvNPc+U+yrmVWmcZFXacvb/t3gjjXZ3M0Z
 OptDgSttjmmA==
WDCIronportException: Internal
Received: from use204286.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.56.224])
 by uls-op-cesaip01.wdc.com with ESMTP; 05 May 2020 16:17:59 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org
Subject: [PULL 1/1] hw/core/register: Add register_init_block8 helper.
Date: Tue,  5 May 2020 16:09:41 -0700
Message-Id: <20200505230941.3984108-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200505230941.3984108-1-alistair.francis@wdc.com>
References: <20200505230941.3984108-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=387c5e0cc=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 19:17:59
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Joaquin de Andres <me@xcancerberox.com.ar>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Joaquin de Andres <me@xcancerberox.com.ar>

There was no support for 8 bits block registers. Changed
register_init_block32 to be generic and static, adding register
size in bits as parameter. Created one helper for each size.

Signed-off-by: Joaquin de Andres <me@xcancerberox.com.ar>
Message-Id: <20200402162839.76636-1-me@xcancerberox.com.ar>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/core/register.c    | 46 +++++++++++++++++++++++++++++++++----------
 include/hw/register.h |  8 ++++++++
 2 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/hw/core/register.c b/hw/core/register.c
index 3c77396587..ddf91eb445 100644
--- a/hw/core/register.c
+++ b/hw/core/register.c
@@ -246,16 +246,18 @@ uint64_t register_read_memory(void *opaque, hwaddr addr,
     return extract64(read_val, 0, size * 8);
 }
 
-RegisterInfoArray *register_init_block32(DeviceState *owner,
-                                         const RegisterAccessInfo *rae,
-                                         int num, RegisterInfo *ri,
-                                         uint32_t *data,
-                                         const MemoryRegionOps *ops,
-                                         bool debug_enabled,
-                                         uint64_t memory_size)
+static RegisterInfoArray *register_init_block(DeviceState *owner,
+                                              const RegisterAccessInfo *rae,
+                                              int num, RegisterInfo *ri,
+                                              void *data,
+                                              const MemoryRegionOps *ops,
+                                              bool debug_enabled,
+                                              uint64_t memory_size,
+                                              size_t data_size_bits)
 {
     const char *device_prefix = object_get_typename(OBJECT(owner));
     RegisterInfoArray *r_array = g_new0(RegisterInfoArray, 1);
+    int data_size = data_size_bits >> 3;
     int i;
 
     r_array->r = g_new0(RegisterInfo *, num);
@@ -264,12 +266,12 @@ RegisterInfoArray *register_init_block32(DeviceState *owner,
     r_array->prefix = device_prefix;
 
     for (i = 0; i < num; i++) {
-        int index = rae[i].addr / 4;
+        int index = rae[i].addr / data_size;
         RegisterInfo *r = &ri[index];
 
         *r = (RegisterInfo) {
-            .data = &data[index],
-            .data_size = sizeof(uint32_t),
+            .data = data + data_size * index,
+            .data_size = data_size,
             .access = &rae[i],
             .opaque = owner,
         };
@@ -284,6 +286,30 @@ RegisterInfoArray *register_init_block32(DeviceState *owner,
     return r_array;
 }
 
+RegisterInfoArray *register_init_block8(DeviceState *owner,
+                                        const RegisterAccessInfo *rae,
+                                        int num, RegisterInfo *ri,
+                                        uint8_t *data,
+                                        const MemoryRegionOps *ops,
+                                        bool debug_enabled,
+                                        uint64_t memory_size)
+{
+    return register_init_block(owner, rae, num, ri, (void *)
+                               data, ops, debug_enabled, memory_size, 8);
+}
+
+RegisterInfoArray *register_init_block32(DeviceState *owner,
+                                         const RegisterAccessInfo *rae,
+                                         int num, RegisterInfo *ri,
+                                         uint32_t *data,
+                                         const MemoryRegionOps *ops,
+                                         bool debug_enabled,
+                                         uint64_t memory_size)
+{
+    return register_init_block(owner, rae, num, ri, (void *)
+                               data, ops, debug_enabled, memory_size, 32);
+}
+
 void register_finalize_block(RegisterInfoArray *r_array)
 {
     object_unparent(OBJECT(&r_array->mem));
diff --git a/include/hw/register.h b/include/hw/register.h
index 5796584588..5d2c565ae0 100644
--- a/include/hw/register.h
+++ b/include/hw/register.h
@@ -185,6 +185,14 @@ uint64_t register_read_memory(void *opaque, hwaddr addr, unsigned size);
  *          memory region (r_array->mem) the caller should add to a container.
  */
 
+RegisterInfoArray *register_init_block8(DeviceState *owner,
+                                        const RegisterAccessInfo *rae,
+                                        int num, RegisterInfo *ri,
+                                        uint8_t *data,
+                                        const MemoryRegionOps *ops,
+                                        bool debug_enabled,
+                                        uint64_t memory_size);
+
 RegisterInfoArray *register_init_block32(DeviceState *owner,
                                          const RegisterAccessInfo *rae,
                                          int num, RegisterInfo *ri,
-- 
2.26.2



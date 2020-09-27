Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67383C4346E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 13:59:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8AC2221EC
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 13:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="l3AiGlac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8AC2221EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMXDK-0001V1-2Y
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 09:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5325bd5c7=alistair.francis@wdc.com>)
 id 1kMXAw-0006xK-Ol
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 09:57:14 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:35119)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5325bd5c7=alistair.francis@wdc.com>)
 id 1kMXAv-0000N8-3E
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 09:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601215032; x=1632751032;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OeMxlU99iPdNNbIiRbMZWU89GNi9nzVJwZpprmXgZF8=;
 b=l3AiGlacw++82BUO7ctn4tamiRz7KZUCz84ECocCZBz/7bOb4Wrhy2Hc
 fc1mlk9wMksULjiYbFDDel/eGWA8vGwB9KwEQXfQpLROume4g2wcOolqD
 SNGC6lo/a6Icjae2PYZ065Z+OQey4ssgGDbBQqYuT6c8sga0rQAtuevsJ
 xaDMbGuNlaZIXIe4Hm0QieAXmtfYKa6zmQJxCd7HSl8b6KTFOj2+kKn1M
 e0V3oICh9QC9KzMid2n9AnfLrh2s9RnbzsbIl1EQB3bO/2JX2pAA+eFSa
 2+IwGMvjcvrvn++A92Hze7iSyAezvEPVyXVg706mkhaXVucN3HbkVZo7u g==;
IronPort-SDR: t6TyMuF/5NMBm57vJJ0QbyU3d/kOKV6NapmTGiHskd+rudLYu0XvjSzY7c+XW98cafc3d7chmf
 Fr4k4Ddjr1Z9cvQR3Be0YlgnxWFck00FXMXHKbR7WbrOe1RscYzFRc185IpptnSIHaP8bAKV1N
 bY4xo74kO7r2xA66p5OdbL1sS6apL1qwk0jM06FHiWGGgJ70xUF9UZZGdOX0HI1HiRN7r7jHpp
 j9yopOF8yoHlG+sdfhpRtMZIWikuq+TSmiQbXQpDAzatbXzpx08AP8RZQFPDF6edw5Gtq2/m42
 rog=
X-IronPort-AV: E=Sophos;i="5.77,310,1596470400"; d="scan'208";a="148291512"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2020 21:57:07 +0800
IronPort-SDR: GoIx6DazgXGkq515AH5XgF4/Ab2ToKOm2dHOq511GE0cSvRbAYVbiowxT6vzZ9hUFiiNdAFOY0
 txSrI4i5DW9g==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2020 06:44:03 -0700
IronPort-SDR: FM8VWuOZnNk1mp3BdJJXYmuWJubIo05cdIcNQSsNzu7e6P18ovBQ5xee3bCfjxoXlBCihtdBQg
 t/aKlS38todw==
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.38])
 by uls-op-cesaip01.wdc.com with ESMTP; 27 Sep 2020 06:57:06 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/2] core/register: Specify instance_size in the TypeInfo
Date: Sun, 27 Sep 2020 06:46:09 -0700
Message-Id: <20200927134609.2358960-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200927134609.2358960-1-alistair.francis@wdc.com>
References: <20200927134609.2358960-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=5325bd5c7=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/27 09:57:06
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reported-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <4cf1beb7dafb9143c261d266557d3173bf160524.1598376594.git.alistair.francis@wdc.com>
---
 hw/core/register.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/hw/core/register.c b/hw/core/register.c
index ddf91eb445..31038bd7cc 100644
--- a/hw/core/register.c
+++ b/hw/core/register.c
@@ -176,17 +176,6 @@ void register_reset(RegisterInfo *reg)
     }
 }
 
-void register_init(RegisterInfo *reg)
-{
-    assert(reg);
-
-    if (!reg->data || !reg->access) {
-        return;
-    }
-
-    object_initialize((void *)reg, sizeof(*reg), TYPE_REGISTER);
-}
-
 void register_write_memory(void *opaque, hwaddr addr,
                            uint64_t value, unsigned size)
 {
@@ -269,13 +258,18 @@ static RegisterInfoArray *register_init_block(DeviceState *owner,
         int index = rae[i].addr / data_size;
         RegisterInfo *r = &ri[index];
 
-        *r = (RegisterInfo) {
-            .data = data + data_size * index,
-            .data_size = data_size,
-            .access = &rae[i],
-            .opaque = owner,
-        };
-        register_init(r);
+        if (data + data_size * index == 0 || !&rae[i]) {
+            continue;
+        }
+
+        /* Init the register, this will zero it. */
+        object_initialize((void *)r, sizeof(*r), TYPE_REGISTER);
+
+        /* Set the properties of the register */
+        r->data = data + data_size * index;
+        r->data_size = data_size;
+        r->access = &rae[i];
+        r->opaque = owner;
 
         r_array->r[i] = r;
     }
@@ -329,6 +323,7 @@ static const TypeInfo register_info = {
     .name  = TYPE_REGISTER,
     .parent = TYPE_DEVICE,
     .class_init = register_class_init,
+    .instance_size = sizeof(RegisterInfo),
 };
 
 static void register_register_types(void)
-- 
2.28.0



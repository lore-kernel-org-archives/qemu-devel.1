Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F5FC35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:20:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 280F32082E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p7WH3EBP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 280F32082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izVqF-0002cK-CT
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 20:20:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVo3-00008O-Hr
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:18:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVo2-0001od-HD
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:18:11 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38845)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVo2-0001jh-A4; Wed, 05 Feb 2020 20:18:10 -0500
Received: by mail-wm1-x341.google.com with SMTP id a9so5038948wmj.3;
 Wed, 05 Feb 2020 17:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4WczbDSImLLtijqx5Y5H1xU/l5A4G3al/zgyXMX6VZo=;
 b=p7WH3EBPk/tvwrL3whPX3zmHC6R8L6Y0IO6etrq5XYvmr7idx/4k0aGodwU5X+sIDk
 GuUDO2aUnoHf+tOlgr3/M9V7qAZxL/7kr0fzfLX/kOPu4je7hk3mWCwOB837aa06j82l
 cp5GM01EEHeC9/xiyb5IDW7ORNEMzTY0W+V/MyzyWb79Wv93NWhOKi6du2OUw4jTkCrU
 /JgBe30P5vF5tlPmPsttKlz6zL3806mqQFY1meSm+JUsLfTIv8st6u8onNVqwS9FUjRC
 8TYIVkYCkeG5hdC4cP4N+tj6B66J8gboI8VW+oYALF9ncRyocB4fBeiz2QBtEg9fni6P
 ldtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=4WczbDSImLLtijqx5Y5H1xU/l5A4G3al/zgyXMX6VZo=;
 b=ZwuKpFJnyCE46fspWF45hcPeHfpJqX8wq9fASlSCL3PlvuX+IXEBpKwxKvZ+EipU0w
 y92hdUewLV3wLyRrpuI9obBtFj/U0QFmeh51lSf6YORwPaZtiTevcYJyAWcz0fR/FPf9
 EOWl68lzm7Kh6s4T+gOm7vFv0lxUhwidOKCV9EnWu7Prr/AkFcDyIKyWy6mneQDTqGr8
 A4nVxAafXd5TXfwFxZML2nxl8MhPOM8nMI9cz4k+DW0foY6ra3DWu7ebR8q4t1c8prrq
 LWJOXKzc8L5SzTyBjTvNNuwROeQQ9ajxQ1VeJ0vbWJNN0cyGvXKJyL/8kpsGI3qeqMvb
 2H6w==
X-Gm-Message-State: APjAAAUGevUkTK8gJaZMBM2IeRNxdKD/2VKz3i01R6K9+oJ6+w7MKnwj
 5qsSm8MgY05VdUYhMR8lD+KEL+lG
X-Google-Smtp-Source: APXvYqxxF8zlF/lj0u674oQnF2w5+w4rrvm55coSb9lMBCtdMzfiYk800ZjDdgqvsJszh1pczOExNg==
X-Received: by 2002:a7b:c318:: with SMTP id k24mr685004wmj.54.1580951889166;
 Wed, 05 Feb 2020 17:18:09 -0800 (PST)
Received: from localhost.localdomain (2.red-95-127-156.staticip.rima-tde.net.
 [95.127.156.2])
 by smtp.gmail.com with ESMTPSA id w13sm2053526wru.38.2020.02.05.17.18.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 17:18:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/30] hw/arm/raspi: Extract the RAM size from the board
 revision
Date: Thu,  6 Feb 2020 02:17:30 +0100
Message-Id: <20200206011756.2413-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200206011756.2413-1-f4bug@amsat.org>
References: <20200206011756.2413-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The board revision encode the amount of RAM. Add a helper
to extract the RAM size, and use it.
Since the amount of RAM is fixed (it is impossible to physically
modify to have more or less RAM), do not allow sizes different
than the one anounced by the manufacturer.

Acked-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Cc: Alistair Francis <alistair@alistair23.me>

 hw/arm/raspi.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 13d41dfce6..2f5cd32c5e 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "cpu.h"
 #include "hw/arm/bcm2836.h"
@@ -48,6 +49,12 @@ FIELD(REV_CODE, MANUFACTURER,      16, 4);
 FIELD(REV_CODE, MEMORY_SIZE,       20, 3);
 FIELD(REV_CODE, STYLE,             23, 1);
 
+static uint64_t board_ram_size(uint32_t board_rev)
+{
+    assert(FIELD_EX32(board_rev, REV_CODE, STYLE)); /* Only new style */
+    return 256 * MiB << FIELD_EX32(board_rev, REV_CODE, MEMORY_SIZE);
+}
+
 static int board_processor_id(uint32_t board_rev)
 {
     assert(FIELD_EX32(board_rev, REV_CODE, STYLE)); /* Only new style */
@@ -190,15 +197,17 @@ static void raspi_init(MachineState *machine, uint32_t board_rev)
 {
     RasPiState *s = g_new0(RasPiState, 1);
     int version = board_version(board_rev);
+    uint64_t ram_size = board_ram_size(board_rev);
     uint32_t vcram_size;
     DriveInfo *di;
     BlockBackend *blk;
     BusState *bus;
     DeviceState *carddev;
 
-    if (machine->ram_size > 1 * GiB) {
-        error_report("Requested ram size is too large for this machine: "
-                     "maximum is 1GB");
+    if (machine->ram_size != ram_size) {
+        char *size_str = size_to_str(ram_size);
+        error_report("This machine can only be used with %s", size_str);
+        g_free(size_str);
         exit(1);
     }
 
-- 
2.21.1



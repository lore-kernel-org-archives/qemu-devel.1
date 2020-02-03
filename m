Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA1EC3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 08:28:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFD3620658
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 08:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eV1gR+dJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFD3620658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyX5u-0005Ob-TX
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 03:28:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iyX41-0002F7-Em
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 03:26:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iyX3u-00012C-Pp
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 03:26:32 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39476)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iyX3t-00011Z-3J; Mon, 03 Feb 2020 03:26:30 -0500
Received: by mail-wm1-x342.google.com with SMTP id c84so15801329wme.4;
 Mon, 03 Feb 2020 00:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XbrBImsz44K8Xswh3EJyXdM5NyfxQNqxR88yL7gBw4I=;
 b=eV1gR+dJUN4GCsDBV7J3bxGaEGXZetqOEKg6/n3K+6OJxd15KkmosGax+6f9u+Na0a
 j82/3wP43NDosSrB7RYBHIy0ncN7Hlt08QuuL51E8W2jKsQTNUGCAQHMX6Ke8frmLB6B
 qklFQw3GIeSNi3Pk3FYPknKc2QCFuv7bD6xgW6RQiNwZbDXhM+OO1VIf8pxjVabM5GVj
 ietp0Z0jlVv6AEqCzhKiJYG1+Fvrw0w8pWXG3RybYTPblA6mLNHNJmJWI5mXmWpMWi+W
 aG9TnFppm54SEWsJJPBBQn+gm9O8v5n/XIFGgUedroDI819/niBufp0P7TCD0iGblTEV
 di+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=XbrBImsz44K8Xswh3EJyXdM5NyfxQNqxR88yL7gBw4I=;
 b=A4SP4Zjri/tXxeDDmL+ofJ+Goot7Yrq9cATw/zzMCPJeKALAwnsRhxHtU6qk/IQqBt
 QCgnK6lU4BiGVW+Hc3w1JxFM97h3+BLZxrOEndabYjsgnAQTrK3dUVd/78YPzmeNKIif
 qfNqbVpLskIBN7yjEwjP4fHB/xeSoI+K62g/kkMdVVeVl/D4QHfBPNrU308qcrO57R+P
 VMa04UC1n2kThHVel1OKroPUMq6rvFbyKOKvq/V/H8EPkhAByCZAl2zaFtab6yh3gJh4
 eWklQiYRd3U6M+7ITKdP4ctNbtTGk36wMCX32RIOsIIHfljuFSD2Xi++dDWP+bBhxmuq
 JXXQ==
X-Gm-Message-State: APjAAAWjpnGfFMoSku3wJG9DjZ/trpzl3wjrq+qtt8Dqr3+Bq8N7DBPZ
 UJp1qaOYGmbo6zAzWv4iiJi3NLN+
X-Google-Smtp-Source: APXvYqzAeylC/Aa3zxzliGKQOvFiWGVoaxqJwM7KLUkLdbIN5rwhWtke/jl675bZ4AFzMYTb8cS9ng==
X-Received: by 2002:a1c:6246:: with SMTP id w67mr26959693wmb.141.1580718387957; 
 Mon, 03 Feb 2020 00:26:27 -0800 (PST)
Received: from localhost.localdomain (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id w20sm22396778wmk.34.2020.02.03.00.26.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 00:26:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/6] hw/arm/raspi: Get board RAM size from board revision code
Date: Mon,  3 Feb 2020 09:26:17 +0100
Message-Id: <20200203082619.7426-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200203082619.7426-1-f4bug@amsat.org>
References: <20200203082619.7426-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The amount of RAM is encoded in the board revision.
Add the board_ram_size() helper, it will allow us to quickly
support new boards.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/raspi.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index f5e54fe876..656d834e07 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "cpu.h"
 #include "hw/arm/bcm2836.h"
@@ -71,6 +72,11 @@ static const RaspiBoardInfo raspi_boards[] = {
 #endif
 };
 
+static uint64_t board_ram_size(const RaspiBoardInfo *config)
+{
+    return 1 * MiB << extract32(config->board_rev, 20, 4);
+}
+
 static int board_chip_id(const RaspiBoardInfo *config)
 {
     return extract32(config->board_rev, 12, 4);
@@ -222,10 +228,13 @@ static void raspi_init(MachineState *machine, const RaspiBoardInfo *config)
     BlockBackend *blk;
     BusState *bus;
     DeviceState *carddev;
+    uint64_t ram_size;
 
-    if (machine->ram_size > 1 * GiB) {
-        error_report("Requested ram size is too large for this machine: "
-                     "maximum is 1GB");
+    ram_size = board_ram_size(config);
+    if (machine->ram_size != ram_size) {
+        char *size_str = size_to_str(ram_size);
+        error_report("This machine can only be used with %s", size_str);
+        g_free(size_str);
         exit(1);
     }
 
-- 
2.21.1



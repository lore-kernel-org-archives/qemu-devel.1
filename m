Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4208C3F2C0
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 22:05:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C989246A1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 22:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hyd6ONjy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C989246A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7RI3-0005bj-Mk
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 17:05:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44972)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j7REL-00019K-Ad
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 17:02:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j7REK-0003lu-CD
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 17:02:05 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52848)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1j7REI-0003l0-Q7; Thu, 27 Feb 2020 17:02:02 -0500
Received: by mail-wm1-x341.google.com with SMTP id p9so1147073wmc.2;
 Thu, 27 Feb 2020 14:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ct19YN8D477GfCKm2ge3aSrXHQgydJt2ZJDeu9sZUbE=;
 b=Hyd6ONjyl4QfpbJ65iDBNOqBwvbPE8A0YWtVVDBsD8MiHmHGeDY46lN9xn33I/Ix+j
 ST6ly4uqoMEtdlELPgotCGoz42Uidlg79pNHD5s6yJDx6DG4GcC8QIbQhQfpk4T+uxb/
 eA57+0DgvgHDCKt7GCtoYONjtiJq7AMKzyQStfQd6UI3uK+hEnEcULAn0e3rIB2U2Ko4
 gJGUjdmMk4ySHe/f0rMMpPHmxJtT4LBaZ3VGLZoIzQYnR1C9kCTw0bhteNUnvudmg9d9
 vYlVxGAlgyb0YZz+6YaLeojPfNwQG4zxwV/t/Elz0TARc+xw3dk/qNlVWmdL4a0u8Xm0
 FYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ct19YN8D477GfCKm2ge3aSrXHQgydJt2ZJDeu9sZUbE=;
 b=a1HBAwO8Kjb6HJgpNZ0k6hKBwDV9RgbE+k3RPE1TGtdC7mezMai46FYMveeaxiXqBS
 GH4W4edbSxXMD6DOan08IYc6FdZ9xJXC5BQES5OM2WlbLhy1KHJo9B26lcnm0VMa3BC7
 I8/FSYT4JdbcIG1FnNV3Bocf4WTm+mzpz1JkXV3h+W0jiZqxRfL3iUe8Ec0csgTe8GH+
 1R5DfILsxwU3F83oKeJBQ2mKn7+TPknNZjuW/ozxWjMhyKkMHctTKePXqk8Kwcd7zgFx
 il+60Ar3LISL4qloZhOAwdxSe/pSB0SDZe9GDFq6/q8olnt71jA5QrOBtaxZFBLabMo7
 xHMA==
X-Gm-Message-State: APjAAAWSEcpWsIKO/FU5GWSv/SFwnwYMK56/2l4UsyxPMu/7NG1DoIOZ
 XnOCHNkv6JMc36fiMIQqt0Qregz+
X-Google-Smtp-Source: APXvYqyZ2KIub6aOqVgPdQlXKHH5KQdCqjAlkwYMwCTeLlcMXI6g6aw+pt0bA16koXjV3TWJBkMVLQ==
X-Received: by 2002:a7b:cc69:: with SMTP id n9mr856189wmj.163.1582840919861;
 Thu, 27 Feb 2020 14:01:59 -0800 (PST)
Received: from pavilion.home ([2a02:a456:6be8:1:8edc:d4ff:fe8b:18b7])
 by smtp.gmail.com with ESMTPSA id z14sm6447040wrg.76.2020.02.27.14.01.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2020 14:01:59 -0800 (PST)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 4/4] hw/arm/cubieboard: report error when using unsupported
 -bios argument
Date: Thu, 27 Feb 2020 23:01:49 +0100
Message-Id: <20200227220149.6845-5-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200227220149.6845-1-nieklinnenbank@gmail.com>
References: <20200227220149.6845-1-nieklinnenbank@gmail.com>
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
Cc: b.galvani@gmail.com, peter.maydell@linaro.org,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Cubieboard machine does not support the -bios argument.
Report an error when -bios is used and exit immediately.

Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
---
 hw/arm/cubieboard.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index 6c55d9056f..871b1beef4 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -19,6 +19,7 @@
 #include "exec/address-spaces.h"
 #include "qapi/error.h"
 #include "cpu.h"
+#include "sysemu/sysemu.h"
 #include "hw/sysbus.h"
 #include "hw/boards.h"
 #include "hw/arm/allwinner-a10.h"
@@ -33,6 +34,12 @@ static void cubieboard_init(MachineState *machine)
     AwA10State *a10;
     Error *err = NULL;
 
+    /* BIOS is not supported by this board */
+    if (bios_name) {
+        error_report("BIOS not supported for this machine");
+        exit(1);
+    }
+
     /* This board has fixed size RAM (512MiB or 1GiB) */
     if (machine->ram_size != 512 * MiB &&
         machine->ram_size != 1 * GiB) {
-- 
2.17.1



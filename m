Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF1CC7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 23:29:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4A532173E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 23:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4A532173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr9eM-0002Ra-2t
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 19:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45162)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hr9eC-000222-IY
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 19:29:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hr9e1-0006nK-6W
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 19:29:04 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:43115)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hr9dv-0006OQ-9J
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 19:28:55 -0400
Received: by mail-pl1-f172.google.com with SMTP id 4so18295814pld.10
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 16:27:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=Bj2QPnrhDA3XafxqIn5N019+xRgqy1t8vZrKKYPqIyI=;
 b=G7AS6WJ20I4rqDPBVbcdp2EGWayVotetO6sDcweb6a4a/py3lFdFtg16pAv50Wf85u
 KvRMJ+or/ptOlRSZ9wxu9k7wrBm/cvobkCAxHvAyJFF7ZHgZyHoYWj1dHXY9SlmmsDzd
 BXv6O0CGl6gy1VjHRy7rvH3E1npT061cZSgh7exBXSU37T4gNjPzHW+gWDcD2MTpTHbI
 3iIvMevlsGxanCsmZtY4kUw63SFzjnluRSxwl1Z4Bz7kYeolhF3zm/y9SpF7Cr9P3gm4
 PeeprZZ0HP/rO0sHjPtSCaSQkx+II7QJ3+v+zzoatCJWaC0K43Td55LPbKMY3DeoVZo8
 8wvA==
X-Gm-Message-State: APjAAAUjG9o5q6LRIRQG+BMEndoW+dTfh6ytzsXGwbctorPyDB9d3zuy
 QXipSD2wJmGBLsATq0SBPDQjhJUg
X-Google-Smtp-Source: APXvYqxIf8DGhXVzt/0mIIZj9L42Ax12usiAMz+/tFFxgJd4OH5WrBQn4RaiNHASXfzben4bBlBRiw==
X-Received: by 2002:a17:902:2f84:: with SMTP id
 t4mr94764328plb.57.1564183672426; 
 Fri, 26 Jul 2019 16:27:52 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id w4sm72048848pfn.144.2019.07.26.16.27.51
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 16:27:51 -0700 (PDT)
Date: Fri, 26 Jul 2019 16:27:31 -0700
Message-Id: <20190726232731.28572-2-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190726232731.28572-1-palmer@sifive.com>
References: <20190726232731.28572-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.172
Subject: [Qemu-devel] [PULL] riscv/boot: Fixup the RISC-V firmware warning
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, ilippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair.francis@wdc.com>

Fix a typo in the warning message displayed to users, don't print the
message when running inside qtest and don't mention a specific QEMU
version for the deprecation.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/boot.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 5dee63011b43..6b7d322e857c 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -26,6 +26,7 @@
 #include "hw/riscv/boot.h"
 #include "hw/boards.h"
 #include "elf.h"
+#include "sysemu/qtest.h"
 
 #if defined(TARGET_RISCV32)
 # define KERNEL_BOOT_ADDRESS 0x80400000
@@ -46,10 +47,13 @@ void riscv_find_and_load_firmware(MachineState *machine,
          * In the future this defaul will change to loading the prebuilt
          * OpenSBI firmware. Let's warn the user and then continue.
         */
-        warn_report("No -bios option specified. Not loading a firmware.");
-        warn_report("This default will change in QEMU 4.3. Please use the " \
-                    "-bios option to aviod breakages when this happens.");
-        warn_report("See QEMU's deprecation documentation for details");
+        if (!qtest_enabled()) {
+            warn_report("No -bios option specified. Not loading a firmware.");
+            warn_report("This default will change in a future QEMU release. " \
+                        "Please use the -bios option to avoid breakages when "\
+                        "this happens.");
+            warn_report("See QEMU's deprecation documentation for details.");
+        }
         return;
     }
 
-- 
2.21.0



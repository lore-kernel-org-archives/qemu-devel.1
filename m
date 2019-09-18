Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9866FC4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 15:50:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68F44206C2
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 15:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68F44206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAcDs-0001PX-Pn
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 11:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49221)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iAbsC-0006g1-9T
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iAbsB-0006dq-6w
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:04 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:43878)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iAbsB-0006df-1X
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:03 -0400
Received: by mail-pl1-f172.google.com with SMTP id 4so102514pld.10
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 08:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=3hJQGoN/dkKnxfz2wZzkBe8IK9Gek4+jV7PzGIOzZB8=;
 b=H0Fi5WRUNFqfqxS3DzhwcH9lo+GJSyliC/X+2jY1sjeBgPDwHQsB+fxo7Yjwefr6bf
 OiiB3iLY9tuwLLLEtqMU25ZyfWNmf0yZb6g9ivmZWsVBSt6/Nt0KRrXfPKyaOF4Ddrjg
 TLHsWXQSgF4Jn6ChNCBBZdek1uEcLQOhwhkELkFBqWamF+SGW6NpuX6U0PpHHmhVKtbF
 iH67kE++wFA34DUlfH12hyAtVS0qUkcd0dFgqx7uy+5xAPeU+nXFD5hfbWc49b8bnPlO
 oGJN4Lt1mYGILmWMx32s9JX+4hiUNqZOEJINcds9PpWyX1pOpUhfWfgAzRb+YiHObXUi
 VE+Q==
X-Gm-Message-State: APjAAAVsDZJSPRRsmlRpls2XX3hSe5Uh2hToWNRBB1z1wkMq0CmGPwCm
 qDFXoVXxnG+tJjDAKA0tvwBKUA==
X-Google-Smtp-Source: APXvYqz6ITgl5VqJA2CcgEIysUKJiZgDsSs4WCCweE2oi8JRfSi0qMTrdBFMoKmoNNjEary89q2x2w==
X-Received: by 2002:a17:902:b08f:: with SMTP id
 p15mr4919925plr.158.1568820481795; 
 Wed, 18 Sep 2019 08:28:01 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id f128sm18465998pfg.143.2019.09.18.08.28.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 08:28:00 -0700 (PDT)
Date: Wed, 18 Sep 2019 07:56:05 -0700
Message-Id: <20190918145640.17349-14-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190918145640.17349-1-palmer@sifive.com>
References: <20190918145640.17349-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.172
Subject: [Qemu-devel] [PULL 13/48] riscv: sifive_test: Add reset
 functionality
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
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bmeng.cn@gmail.com>

This adds a reset opcode for sifive_test device to trigger a system
reset for testing purpose.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_test.c         | 4 ++++
 include/hw/riscv/sifive_test.h | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_test.c b/hw/riscv/sifive_test.c
index afbb3aaf34..3557e16701 100644
--- a/hw/riscv/sifive_test.c
+++ b/hw/riscv/sifive_test.c
@@ -22,6 +22,7 @@
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
+#include "sysemu/runstate.h"
 #include "target/riscv/cpu.h"
 #include "hw/hw.h"
 #include "hw/riscv/sifive_test.h"
@@ -42,6 +43,9 @@ static void sifive_test_write(void *opaque, hwaddr addr,
             exit(code);
         case FINISHER_PASS:
             exit(0);
+        case FINISHER_RESET:
+            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+            return;
         default:
             break;
         }
diff --git a/include/hw/riscv/sifive_test.h b/include/hw/riscv/sifive_test.h
index 3a603a6ead..1ec416ac1b 100644
--- a/include/hw/riscv/sifive_test.h
+++ b/include/hw/riscv/sifive_test.h
@@ -36,7 +36,8 @@ typedef struct SiFiveTestState {
 
 enum {
     FINISHER_FAIL = 0x3333,
-    FINISHER_PASS = 0x5555
+    FINISHER_PASS = 0x5555,
+    FINISHER_RESET = 0x7777
 };
 
 DeviceState *sifive_test_create(hwaddr addr);
-- 
2.21.0



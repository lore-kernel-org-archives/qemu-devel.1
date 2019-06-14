Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4561BC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 15:33:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15F212175B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 15:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWA2ZblT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15F212175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52718 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hboCk-0007Yb-A0
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 11:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50804)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hbnw4-00057u-RO
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 11:16:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hbnw2-0008Gh-S6
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 11:16:12 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:35411)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hbnvz-00087H-1e; Fri, 14 Jun 2019 11:16:07 -0400
Received: by mail-pl1-x644.google.com with SMTP id p1so1155838plo.2;
 Fri, 14 Jun 2019 08:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id;
 bh=Xt3ybDoCdp/nYixs2Nc2BRUQ4UN50C5Cqd9Txfd5wow=;
 b=UWA2ZblTg4wc7FyO1ElmLoNENseRjkKgZABawrBSMsvYlj3DgWuSendjMJyG+pQUem
 f7bnpM8f9h3nrHKoqXwFM6aU8R8P4Xsbd1UHOIyXEUKM7GV6F9qrAnJW/vF3M+V+aKOM
 JaXwdQVUkFghMEiYweBmCAPvLwSpBhN00mi8KHq+Z03SQDvvgGo+09S1o9eBJFQeTK68
 CLjI7Yywkh0YxGxm+Ab3y47TEZVe4hChbvRKieBExFIjEJ+35o55dTPC2XgtFPqixU2L
 AxZtF6rMlm58S1WAbzgKEphbw7GVBfQoeFtAKyTKMSo7QfiqM7uDzf9J3xRZ5Gm4ZMdi
 Wtrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id;
 bh=Xt3ybDoCdp/nYixs2Nc2BRUQ4UN50C5Cqd9Txfd5wow=;
 b=QMvinmnmpaJXeXpmcR3HjSgvfnVU7SCieBbqtB8fgoVxuaVH9d/sLCxReOd4aO7/9G
 gFMyFSYpr5KQlYshJlxDUu5TSOH+1sKc+5WirrdDHOfRnEA5Bj7oATJD2ukTVnC7CH9m
 0qbu34lyA1S1CUxIXZ6dnQwuEdFiRERp9rv7J9gEod6/DUDfMZ+bnNOAjCbfvSAw4AOv
 8EO9NYTzB5/gxB1vUpCOEVz9pIYzjabnhz4djY4vWSbdFD9eIu2NXCYChAzAEN3XYi+Y
 ztD7125kSKP5RVM+fdclwHRj7rMDNVLxffKfLi9+ByR6NXMKNOOYOSvcB8gxKFZw51fc
 M77w==
X-Gm-Message-State: APjAAAXeRnvW2BsLZRr7SlAQujEaz0+DSgGcZp7b7rYrRZ3G6i6mxWYe
 Pr3s/Uwa5NfhOHgJG0+rjrXl2HzW
X-Google-Smtp-Source: APXvYqxyy9zKQUeUyrirBMkcRhnnD7sjT5eavoAlcQsd/9hIpBtAYc/prM9LqYdx0+j7ElouXdEJzg==
X-Received: by 2002:a17:902:8b88:: with SMTP id
 ay8mr28160061plb.139.1560525357063; 
 Fri, 14 Jun 2019 08:15:57 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id x14sm5009999pfq.158.2019.06.14.08.15.56
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Fri, 14 Jun 2019 08:15:56 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>
Date: Fri, 14 Jun 2019 08:15:51 -0700
Message-Id: <1560525351-590-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH] riscv: sifive_test: Add reset functionality
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

This adds a reset opcode for sifive_test device to trigger a system
reset for testing purpose.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

 hw/riscv/sifive_test.c         | 4 ++++
 include/hw/riscv/sifive_test.h | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_test.c b/hw/riscv/sifive_test.c
index 24a04d7..cd86831 100644
--- a/hw/riscv/sifive_test.c
+++ b/hw/riscv/sifive_test.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
+#include "sysemu/sysemu.h"
 #include "target/riscv/cpu.h"
 #include "hw/riscv/sifive_test.h"
 
@@ -40,6 +41,9 @@ static void sifive_test_write(void *opaque, hwaddr addr,
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
index 71d4c9f..c186a31 100644
--- a/include/hw/riscv/sifive_test.h
+++ b/include/hw/riscv/sifive_test.h
@@ -34,7 +34,8 @@ typedef struct SiFiveTestState {
 
 enum {
     FINISHER_FAIL = 0x3333,
-    FINISHER_PASS = 0x5555
+    FINISHER_PASS = 0x5555,
+    FINISHER_RESET = 0x7777
 };
 
 DeviceState *sifive_test_create(hwaddr addr);
-- 
2.7.4



Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE6AC4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 15:40:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1065921848
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 15:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1065921848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAc4I-00014o-Ct
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 11:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49172)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iAbs9-0006bb-D0
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iAbs8-0006bo-9G
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:01 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41544)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iAbs8-0006bW-3Z
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id x15so36380pgg.8
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 08:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=JhWZs3kYQOWNeKlb2pNkOyfw/b4rNeIZqwng3Q4zhcI=;
 b=ramZ30ObRgnbJjh3MASXwFXm6rf1/8fFsqNQ7gluyer+a+uHx+WuiCEqt2NqxWFxdE
 ay+oivGpnUUxGcIGxeJCv2ilLcw6ck3QTIUQK40ermfmxIUMlC2ShUd0ZY6rF/vM92nD
 6f0XwNSfhGfE3nAeZb8s2S42p49ATWFheOdbBmn6SwNBZg/4Ce4L6s4nYV9Qis6jCBn/
 W9JHUoyE92LdgTIOF5H7NKzNGiTVJn00etzhvRBmsC5F4K0ekQtK1h3JWMGp5V0JLigK
 KECqCIQUBcnfBgh0rNqYbIe/WJiSfcstwLqGnBE6R9cuhl9i52XvMamgaSDFz/T1UM/B
 rp+A==
X-Gm-Message-State: APjAAAVFbKMzK2pa8iho4OT0ebok57ZgvTn7+w3V7KZgmcYWUykuGrZp
 VH3y6EHMAh3nfxmFHGvCerct/5zsAh4=
X-Google-Smtp-Source: APXvYqzqHelCSqlljqByqBbSQ64IyZY/gtKz4+pYFTcK/H7Xc57YaL3meCdOUH47gbb4MRqn7TuopA==
X-Received: by 2002:aa7:9a48:: with SMTP id x8mr4645432pfj.201.1568820479005; 
 Wed, 18 Sep 2019 08:27:59 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id a4sm6595516pfn.110.2019.09.18.08.27.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 08:27:58 -0700 (PDT)
Date: Wed, 18 Sep 2019 07:56:03 -0700
Message-Id: <20190918145640.17349-12-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190918145640.17349-1-palmer@sifive.com>
References: <20190918145640.17349-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.194
Subject: [Qemu-devel] [PULL 11/48] riscv: Resolve full path of the given
 bios image
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
Cc: Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bmeng.cn@gmail.com>

At present when "-bios image" is supplied, we just use the straight
path without searching for the configured data directories. Like
"-bios default", we add the same logic so that "-L" actually works.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/boot.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 10f7991490..2e92fb0680 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -72,14 +72,14 @@ void riscv_find_and_load_firmware(MachineState *machine,
         firmware_filename = riscv_find_firmware(default_machine_firmware);
     } else {
         firmware_filename = machine->firmware;
+        if (strcmp(firmware_filename, "none")) {
+            firmware_filename = riscv_find_firmware(firmware_filename);
+        }
     }
 
     if (strcmp(firmware_filename, "none")) {
         /* If not "none" load the firmware */
         riscv_load_firmware(firmware_filename, firmware_load_addr);
-    }
-
-    if (!strcmp(machine->firmware, "default")) {
         g_free(firmware_filename);
     }
 }
-- 
2.21.0



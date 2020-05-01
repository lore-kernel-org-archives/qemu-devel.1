Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB239C4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 12:32:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75861208D6
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 12:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQ+qLLd/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75861208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUUpk-0004vQ-LA
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 08:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1jUUoK-0003Fa-CB
 for qemu-devel@nongnu.org; Fri, 01 May 2020 08:30:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1jUUoI-0000m5-NM
 for qemu-devel@nongnu.org; Fri, 01 May 2020 08:30:32 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:46639)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jUUoC-0000az-3e; Fri, 01 May 2020 08:30:29 -0400
Received: by mail-pg1-x541.google.com with SMTP id q124so4492564pgq.13;
 Fri, 01 May 2020 05:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=iLKl3KT7MDl3fnVw3ohtwNf0oFLP4D9YRtokC8si/fU=;
 b=aQ+qLLd/wYIjMGi8AQWYuJeuf4fGBZw8b4WDwy9E+2MqJiN+3NhsF27s6H3gRiwZY3
 EczhfKC0TuYW/dNkuZz/K6w53tD7D5Y4WaIgLFXNjx/nIQJJtLC564RH9DddafOfJrYO
 hKQtzgLcqyOCPe2fSusRM5pBA4x1JoQugz69PWo+LSGpbKTtx2snDFPJeCANvMpLTc6N
 04V9fVAaB9EaQIQp7IPi3UmUqQwDXavh+XTZQhGNL1RbAxbKDoFHHa91j5yeik07bnlY
 eRlaZnnjmCB62RzCXjcJ40uzd5Lk+iAKNwJJRgi1NEWLQPWzaRv+dX4cCCEx+uZdtwXD
 E6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=iLKl3KT7MDl3fnVw3ohtwNf0oFLP4D9YRtokC8si/fU=;
 b=BnIBLKjXj9WZQZ1KZ4IUpaJjLw4JgfgGlFlyhSlMkH4kDO3i89p/IY/EjCA4acCANc
 WOms9bHPtRNLjsKLB0+sjE3Sf4TeBDbeeiHU8zqhnM+vxCro0Vm7wMPp75ybu6EHHkBW
 BOUOS1bAttv7wOoxySNVQS9/6QvRu67NcDiyHaKgePp83UpJ+8jgkfUlmw7rM4QL5cHb
 jug7KyzqTr8OTwfJy3RmArlPFZU4Lju3gLs1K+26ZcY22nAilJXcrlK3p9Efrg86l4Ii
 6lNqq3UZkH/DdL4AcJiFvlsNmkwoxz0MH8reC0CTIWie8cELgXkjxEfNKON4YTe8L2sf
 jiDQ==
X-Gm-Message-State: AGi0PuYaMCSnbQl8jRo8dwKUvQ9PMJsQw2Jx7JZlUJjox1C/WBAGmxYs
 xqhQZkZmaEocMBXE9ayHfyg=
X-Google-Smtp-Source: APiQypIQgVPUN/QaoRnZEP3Kg4m0irHhJIwazYAKRFFVQBqR/ePCr++nJNr6HgLxwiRDysNMrPzsoA==
X-Received: by 2002:a63:f50a:: with SMTP id w10mr3776382pgh.181.1588336222177; 
 Fri, 01 May 2020 05:30:22 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id f10sm2012099pju.34.2020.05.01.05.30.21
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Fri, 01 May 2020 05:30:21 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH] riscv/spike: Change the default bios to use plain binary image
Date: Fri,  1 May 2020 05:29:45 -0700
Message-Id: <1588336185-1051-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: Bin Meng <bin.meng@windriver.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

To keep sync with other RISC-V machines, change the default bios
to use .bin instead of the .elf images.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 hw/riscv/spike.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index d0c4843..611a741 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -46,9 +46,9 @@
 #include <libfdt.h>
 
 #if defined(TARGET_RISCV32)
-# define BIOS_FILENAME "opensbi-riscv32-spike-fw_jump.elf"
+# define BIOS_FILENAME "opensbi-riscv32-spike-fw_jump.bin"
 #else
-# define BIOS_FILENAME "opensbi-riscv64-spike-fw_jump.elf"
+# define BIOS_FILENAME "opensbi-riscv64-spike-fw_jump.bin"
 #endif
 
 static const struct MemmapEntry {
-- 
2.7.4



Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C371AC07542
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:42:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C34920815
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C34920815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49332 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUiAk-0007IC-LB
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 21:42:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhxM-0003Hg-9L
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:28:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhg9-0006At-Hq
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:26 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:34826)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hUhg5-0005vr-Uo
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:23 -0400
Received: by mail-pg1-f176.google.com with SMTP id t1so7095639pgc.2
	for <qemu-devel@nongnu.org>; Sat, 25 May 2019 18:10:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:cc:from:to;
	bh=rQikxxt+UmlrWVINybj5QUluVzDygdebQ0Xpvz/1e7k=;
	b=qaBmX9UZF2UaUxDQGlQ2roxxzhY/NjxVzr9wG+SO8WaLlwmzIJgtoSjJLf8bDKrLGv
	KUcsiuLfkU7bz0lTv4UYPpZkoqUcwHd16JYoKsXZzCAeQ6hs+m0uVSL5fHXWR64njYqF
	Zy7ikiVR0X9pfGdijaXQ4WWUJUtLwXzbV6Lfeh8L5Bjg8KkK8ibenP45x25kUlYw5ybL
	2QZ7yCAKoanTxvO19yl61lz0W8pxlTfdMuulZvrnEED/0yICTQVPExk2O2iyyIDqM1Wh
	wSCY/XwnykqZIJfGJLJlVZzZXif5wp438g9SWSIohdqj6/VVPjx7NwUkAVdqPbIKEqSl
	hHxA==
X-Gm-Message-State: APjAAAX8XQXrLSmPKr1JdKZ5qCkbHYSOLlI81wkAVbMG4vws/Z0fIra7
	OFfikDkZC4aKY/jMbPiozkR0pQ==
X-Google-Smtp-Source: APXvYqzeNkNqpZeOsUJoHcsQ8ErWv3RvsPgDMQm9i9j+yVlV8Ql51YaqiPnTVnhaG1KPLQqc4OKsFA==
X-Received: by 2002:a62:b517:: with SMTP id y23mr40368751pfe.182.1558833018332;
	Sat, 25 May 2019 18:10:18 -0700 (PDT)
Received: from localhost ([12.206.222.5]) by smtp.gmail.com with ESMTPSA id
	p13sm9322808pfq.69.2019.05.25.18.10.17
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 25 May 2019 18:10:17 -0700 (PDT)
Date: Sat, 25 May 2019 18:09:31 -0700
Message-Id: <20190526010948.3923-13-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190526010948.3923-1-palmer@sifive.com>
References: <20190526010948.3923-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.215.176
Subject: [Qemu-devel] [PULL 12/29] target/riscv: Remove unused include of
 riscv_htif.h for virt board riscv
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Alistair Francis <alistair.francis@wdc.com>,
	Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org, Jonathan Behrens <fintelia@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jonathan Behrens <fintelia@gmail.com>

Signed-off-by: Jonathan Behrens <fintelia@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/virt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index fc4c6b306e13..352646303420 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -29,7 +29,6 @@
 #include "hw/sysbus.h"
 #include "hw/char/serial.h"
 #include "target/riscv/cpu.h"
-#include "hw/riscv/riscv_htif.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/sifive_plic.h"
 #include "hw/riscv/sifive_clint.h"
-- 
2.21.0



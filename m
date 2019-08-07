Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D6FC32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 07:50:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D268522CD5
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 07:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0iEAelg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D268522CD5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvGhr-0001Fa-62
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 03:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36522)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvGdo-0000xl-Lv
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:45:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvGdm-00083f-6Q
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:45:48 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:37592)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hvGdh-000810-K5; Wed, 07 Aug 2019 03:45:44 -0400
Received: by mail-pl1-x644.google.com with SMTP id b3so39516904plr.4;
 Wed, 07 Aug 2019 00:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=cG6I8erel++wAP2MikuwJespmoehSIDTEb7AfduoiHo=;
 b=W0iEAelgPtLvE+1e+xm1vXYD0S2mx4In7xWnT2ZV+Q+ae63GVMWgLo8lTzIA5vfWEG
 ANUUxiet8nfJHcBBJ23bXgx1Osvs3wDFuE6V2uAb3rgAzUTdcAwF1dlztZhqextMFeUx
 zdfG32I8wBLbjTvaM3z2088rW4hnAtANUjLUHXzh2G93bEOzXFp5yW7if1W6HQQ63DzY
 EMAxfmtmUeCML083UYMlqKswaItq7hx5cBQoDj093FwuN20zvgZnKvWqCkdR4i/UqaoC
 6l19UIHhoM4tPYy+pekfLlxPjQYrMKVvFGwLdLcMAd7Bcj3OaMWmA1dc3oB2FJk8cFCp
 6KVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=cG6I8erel++wAP2MikuwJespmoehSIDTEb7AfduoiHo=;
 b=tfsOcVng9bwh5osakulE0PPHeBXd3v/UHiz6eOlEe7uzisJqArvMp8bgaviRsaLW2d
 7Y4759muZ9Ig21lX+pB41Vz1LioY3ukZLLTKYfO8JtQRP26xu/omTQssIdUhfF+ScX0h
 +WuLk24D44QrxFYyCbLtGRNYnn9qzDV3qk2Hwo46ISbQ1dCqWSvlhM3tvzlgICMP9Utu
 E/rkhlNmM3U9svOE3s4dnIGyoFTItsx/sxGN2Pth7x/6FPZczdbcoD1BMfbAbMmScsw4
 uRFp/ZjPGg/I4tVqEq9hl+/fIRTs8aeb4iFrjN9uedq4fLlwfO2bTqfDLpaCmDJ/4FKR
 vSgw==
X-Gm-Message-State: APjAAAXul2mtD1QGgQxMmounVLLBsyNXG8KNxl+BpaKUYTzi2JtGLRH9
 TIOtEM2W+fbysLbLa1iLX+c=
X-Google-Smtp-Source: APXvYqzAoEpwLOWps4JiF+uxJZ6czs+3dl8TQ1usqseWmTpOZRcJ3WzKtx1KbC3WNnLeiddBioKTaQ==
X-Received: by 2002:a17:90a:3651:: with SMTP id
 s75mr6936754pjb.13.1565163938079; 
 Wed, 07 Aug 2019 00:45:38 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id l44sm20154449pje.29.2019.08.07.00.45.37
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Wed, 07 Aug 2019 00:45:37 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Wed,  7 Aug 2019 00:45:03 -0700
Message-Id: <1565163924-18621-8-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565163924-18621-1-git-send-email-bmeng.cn@gmail.com>
References: <1565163924-18621-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v2 07/28] riscv: sifive_u: Set the minimum
 number of cpus to 2
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

It is not useful if we only have one management CPU.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

---

Changes in v2:
- update the file header to indicate at least 2 harts are created

 hw/riscv/sifive_u.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 821f1d5..91f3c76 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -10,8 +10,8 @@
  * 1) CLINT (Core Level Interruptor)
  * 2) PLIC (Platform Level Interrupt Controller)
  *
- * This board currently generates devicetree dynamically that indicates at most
- * five harts.
+ * This board currently generates devicetree dynamically that indicates at least
+ * two harts and up to five harts.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -429,6 +429,8 @@ static void riscv_sifive_u_machine_init(MachineClass *mc)
      * management CPU.
      */
     mc->max_cpus = 5;
+    /* It is not useful if we only have one management CPU */
+    mc->min_cpus = 2;
 }
 
 DEFINE_MACHINE("sifive_u", riscv_sifive_u_machine_init)
-- 
2.7.4



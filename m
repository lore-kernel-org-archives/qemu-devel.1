Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0ADC4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 16:12:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86A8F218AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 16:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86A8F218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAcZJ-0000Dv-BU
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 12:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50034)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iAbsw-0007tL-Ae
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iAbsv-0007Cs-0r
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:50 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:42959)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iAbsu-0007CK-Qq
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:48 -0400
Received: by mail-pl1-f169.google.com with SMTP id e5so107167pls.9
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 08:28:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=9GK2Bf5OnfdKtfsKMa0SLxJhchcsTnh1ghEkn9cP/2k=;
 b=ZFFqzfrPeTWDwNk0vq/j4QPwxMjTRqERwwVG6M4Mji7TJUSq60x5dokL3mdBwccHRb
 gNmK2no/X0+88vJctUmTFqQ/WGb/9QrHuYmyK8rpgVS6COu1yjg0G1YVKX4KLB6BQ7od
 GUNNhBM79quDT9zU/vhn5J29/q4DGRdGpYTsTK4ygLgd1RIIJZ7RcgELFAKEQdTbn5WE
 xUD3PZp9t1YiR9dXE1CqbY+FW7GeBH3hT9vVRT72MdwB9mgytUWML5SI7RAXK8Hsr5kH
 872IfbIJqHBL3WN5PkX3SPs9koq4gDBrE/lo9mCtaq3pcdiXrDUuHU3KdFlt9j4AjTzw
 OIvw==
X-Gm-Message-State: APjAAAWXDBQ9PBIuPsuhU3GCjnhjptROskIY2KRITknb8WF+ZnPmj4A2
 GJrTfTKGPnJQhb9lfUU6ShMWpQ==
X-Google-Smtp-Source: APXvYqyiKwA35t3fOAUJzRR8AbMlggMF5egaBiXgqGMq+ISNVpS8hKvuNv4tAaDkm5FPDau0dJOBPA==
X-Received: by 2002:a17:902:9001:: with SMTP id
 a1mr4896053plp.148.1568820527754; 
 Wed, 18 Sep 2019 08:28:47 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id y14sm5706798pge.7.2019.09.18.08.28.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 08:28:47 -0700 (PDT)
Date: Wed, 18 Sep 2019 07:56:37 -0700
Message-Id: <20190918145640.17349-46-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190918145640.17349-1-palmer@sifive.com>
References: <20190918145640.17349-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.169
Subject: [Qemu-devel] [PULL 45/48] target/riscv: Use both register name and
 ABI name
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
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@sifive.com>,
 qemu-devel@nongnu.org, Atish Patra <atish.patra@wdc.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Atish Patra <atish.patra@wdc.com>

Use both the generic register name and ABI name for the general purpose
registers and floating point registers.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 6d52f97d7c..f13e298a36 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -34,17 +34,20 @@
 static const char riscv_exts[26] = "IEMAFDQCLBJTPVNSUHKORWXYZG";
 
 const char * const riscv_int_regnames[] = {
-  "zero", "ra", "sp",  "gp",  "tp", "t0", "t1", "t2",
-  "s0",   "s1", "a0",  "a1",  "a2", "a3", "a4", "a5",
-  "a6",   "a7", "s2",  "s3",  "s4", "s5", "s6", "s7",
-  "s8",   "s9", "s10", "s11", "t3", "t4", "t5", "t6"
+  "x0/zero", "x1/ra",  "x2/sp",  "x3/gp",  "x4/tp",  "x5/t0",   "x6/t1",
+  "x7/t2",   "x8/s0",  "x9/s1",  "x10/a0", "x11/a1", "x12/a2",  "x13/a3",
+  "x14/a4",  "x15/a5", "x16/a6", "x17/a7", "x18/s2", "x19/s3",  "x20/s4",
+  "x21/s5",  "x22/s6", "x23/s7", "x24/s8", "x25/s9", "x26/s10", "x27/s11",
+  "x28/t3",  "x29/t4", "x30/t5", "x31/t6"
 };
 
 const char * const riscv_fpr_regnames[] = {
-  "ft0", "ft1", "ft2",  "ft3",  "ft4", "ft5", "ft6",  "ft7",
-  "fs0", "fs1", "fa0",  "fa1",  "fa2", "fa3", "fa4",  "fa5",
-  "fa6", "fa7", "fs2",  "fs3",  "fs4", "fs5", "fs6",  "fs7",
-  "fs8", "fs9", "fs10", "fs11", "ft8", "ft9", "ft10", "ft11"
+  "f0/ft0",   "f1/ft1",  "f2/ft2",   "f3/ft3",   "f4/ft4",  "f5/ft5",
+  "f6/ft6",   "f7/ft7",  "f8/fs0",   "f9/fs1",   "f10/fa0", "f11/fa1",
+  "f12/fa2",  "f13/fa3", "f14/fa4",  "f15/fa5",  "f16/fa6", "f17/fa7",
+  "f18/fs2",  "f19/fs3", "f20/fs4",  "f21/fs5",  "f22/fs6", "f23/fs7",
+  "f24/fs8",  "f25/fs9", "f26/fs10", "f27/fs11", "f28/ft8", "f29/ft9",
+  "f30/ft10", "f31/ft11"
 };
 
 const char * const riscv_excp_names[] = {
-- 
2.21.0



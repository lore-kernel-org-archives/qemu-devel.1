Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EC4C3A59B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 05:32:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C5282087E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 05:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n6FQ/P9P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5282087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzaHc-0004Rd-Gc
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 01:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1hzZy7-0005Hc-4n
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 01:12:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hzZy6-0008OD-24
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 01:12:35 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:46064)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hzZy4-00089W-3M; Mon, 19 Aug 2019 01:12:32 -0400
Received: by mail-pl1-x641.google.com with SMTP id y8so373665plr.12;
 Sun, 18 Aug 2019 22:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=Yj2uF95i7NNiZE8ed5H3sWI+cVGDXAtbETHOJ51vtZE=;
 b=n6FQ/P9PKbLn/iEL6qd+ngu493oi3mdAfw1AAxOqYigwI6q7Qw+7qbgNX1st7zxdJC
 OQj1oS3HtWJaK7CQ/eaTZn3dL5152e3e7m0ZwhdW4JKCJ/X7t7WaHA2uQDhcv0jDCq6+
 WdxD+BfnBP0L4LAHlqgNsLxFu8rbFbMRRPwKrj4ehaSt4hFumW5lpn79RJP460w5oz4l
 x+uYtQ5kZOA1tWNgIIFQug5OGUTxWzB9UUCaykb+JQ4TmISSowMoECwsMtD/tIy2Nhus
 fJJAfVYPmyCNmCV9cC47mDTfK3VCVMjCOXxrBTb4aMzsbii7vuSKpTcdNW3VVEkYK8oN
 YACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=Yj2uF95i7NNiZE8ed5H3sWI+cVGDXAtbETHOJ51vtZE=;
 b=B5A1Uhewwj+DOjggF29Tp2FybfB+b8g5iU+EapitS8SV9Vcsf89AtbKpzEee5aH8GI
 s4binjWRtrT50hxWoi7E3VS/GuMcBYI5nvELSUs5ULreLG0g4HfoyYVBbXJy9xtKCXUT
 ud/xay+Z0WgOAktEEV3HStXVAsj1x4ojuXWx9O/OeNMukou9p4Mb28JpJrVOA2vfaX6A
 R21nnK85S89BLw9pa4+BF+fNhaqTOzUTPMshoZOQ+hbdczjN8Lk23P2GtGzojIp5hUHg
 a+2nQyquN8sYk5XPjjSMEJfaz6XTEJ2hI1ucboBurHwObQyit4Hj9VsIuyvrTCpKfi7J
 eZcA==
X-Gm-Message-State: APjAAAUDSqtUgIZ6nMcuokvShD+gD/d2iCUgP66cyXeFlhpi8DH/28UB
 3oewWTOsubsrx7dBa5fiCuM=
X-Google-Smtp-Source: APXvYqxHAldxPBDMW6VYVuR4I/nHARGAel+cnwc21xBwfoovUVpDNaqQO/rYwTWKRjG4hZbax93tDw==
X-Received: by 2002:a17:902:be15:: with SMTP id
 r21mr20070175pls.293.1566191549660; 
 Sun, 18 Aug 2019 22:12:29 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id q13sm15464986pfl.124.2019.08.18.22.12.28
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sun, 18 Aug 2019 22:12:29 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sun, 18 Aug 2019 22:11:54 -0700
Message-Id: <1566191521-7820-22-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1566191521-7820-1-git-send-email-bmeng.cn@gmail.com>
References: <1566191521-7820-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v4 21/28] riscv: sifive_u: Update UART base
 addresses and IRQs
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

This updates the UART base address and IRQs to match the hardware.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Jonathan Behrens <fintelia@gmail.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com>

---

Changes in v4: None
Changes in v3:
- update IRQ numbers of both UARTs to match hardware as well

Changes in v2: None

 hw/riscv/sifive_u.c         | 4 ++--
 include/hw/riscv/sifive_u.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 8818fd6..a85db77 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -64,8 +64,8 @@ static const struct MemmapEntry {
     [SIFIVE_U_CLINT] =    {  0x2000000,    0x10000 },
     [SIFIVE_U_PLIC] =     {  0xc000000,  0x4000000 },
     [SIFIVE_U_PRCI] =     { 0x10000000,     0x1000 },
-    [SIFIVE_U_UART0] =    { 0x10013000,     0x1000 },
-    [SIFIVE_U_UART1] =    { 0x10023000,     0x1000 },
+    [SIFIVE_U_UART0] =    { 0x10010000,     0x1000 },
+    [SIFIVE_U_UART1] =    { 0x10011000,     0x1000 },
     [SIFIVE_U_DRAM] =     { 0x80000000,        0x0 },
     [SIFIVE_U_GEM] =      { 0x100900FC,     0x2000 },
 };
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 0ec04df..9acb69e 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -62,8 +62,8 @@ enum {
 };
 
 enum {
-    SIFIVE_U_UART0_IRQ = 3,
-    SIFIVE_U_UART1_IRQ = 4,
+    SIFIVE_U_UART0_IRQ = 4,
+    SIFIVE_U_UART1_IRQ = 5,
     SIFIVE_U_GEM_IRQ = 0x35
 };
 
-- 
2.7.4



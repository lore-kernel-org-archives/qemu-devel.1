Return-Path: <SRS0=Jh9c=W4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392B1C3A5A6
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 03:10:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0273521852
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 03:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XV/SLgyF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0273521852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4GGG-0007px-Oh
	for qemu-devel@archiver.kernel.org; Sat, 31 Aug 2019 23:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47968)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i4Fzu-0007lF-9C
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 22:53:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i4Fzs-0006oU-U2
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 22:53:45 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:43064)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i4Fzs-0006mo-Ln; Sat, 31 Aug 2019 22:53:44 -0400
Received: by mail-pg1-x542.google.com with SMTP id u72so1305093pgb.10;
 Sat, 31 Aug 2019 19:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=IshGuK0zG82jB/Tkkvia5OvvqGN+xGCtzZEixWay3tY=;
 b=XV/SLgyF6gajM2CKQb1Uac/ZiTK0JxCJz4+jOoIQnEMFl5zxh1FpZ342DRH4Y9o3a4
 AVsJR5+dZRREPb75lbIndiSLaDnwHM1I0emAH+Tx7IfaY/0O6c0w9jymjRFvQfmmDNsV
 CIZ9HiETsahARH/R9EpDhBTkO+WiCpfbeNLVi1SeoZH5xm1r02fDIXC9LZAUwp4Vvw4I
 FiPoz+b1jCIVG+fWX7FNZOHkqq9Hbn7WIPID0nU7HizIcpBXbvBI36KrGjYOgp7oQfWl
 F3n6or+NA59Nj2Ji/4XLR/LBzOx53MiPP6v60z83+gLjbtXpGWW/4FQ3eIVBc4bsGdXh
 pmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=IshGuK0zG82jB/Tkkvia5OvvqGN+xGCtzZEixWay3tY=;
 b=U+dNwb8muHvJzBLi3lrXNt0OHyMzfdc1kO21tkugsXmjBqg0d+OOS/pZBMzD7pZGcN
 4Zf3SIHQg2l5scbjqpIzkBBEE4iyFt42IVCdr+MAkY4qfwlVGb4Mn/kIV2K6AWv/UeGA
 jn32YNsdm6aa2MK/LyqjQ+9yDneWixYLLXVG8YGhRbztYuCRSq1w4k3tvN0ThoVfV3RS
 zY/gNLsWiK8/bp6CYMWIykFofBZ/i+LEnzf247z74DqyuNWA8MIy4W2xHkqtxp0W7c2/
 1b7Gmu50j+Dho4oq+zJlhY51p7fDGFz8UoE7C7p5WhabCcmqzv5k5CNAPvBOJPF681Sq
 p1xg==
X-Gm-Message-State: APjAAAU5+pzzB5jNafyAbFU/qT9qjc8KQt72a7o/Y8/7s/Qx6fz0In3s
 Gs5hsLRR6bmSmxSH917NVGg=
X-Google-Smtp-Source: APXvYqzPTMxfV5ajwTtX9Njcl8giLCwo97Quk56Shp3HMR9xddEp3ufhlreFCB4Bdt3CYPoqq7Tjig==
X-Received: by 2002:a17:90a:9907:: with SMTP id b7mr75295pjp.101.1567306423864; 
 Sat, 31 Aug 2019 19:53:43 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id p10sm11453307pff.132.2019.08.31.19.53.42
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sat, 31 Aug 2019 19:53:43 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sat, 31 Aug 2019 19:53:04 -0700
Message-Id: <1567306391-2682-24-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1567306391-2682-1-git-send-email-bmeng.cn@gmail.com>
References: <1567306391-2682-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v7 23/30] riscv: sifive_u: Update UART base
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

Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3:
- update IRQ numbers of both UARTs to match hardware as well

Changes in v2: None

 hw/riscv/sifive_u.c         | 4 ++--
 include/hw/riscv/sifive_u.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 3b1fe46..c7b9f96 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -62,8 +62,8 @@ static const struct MemmapEntry {
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
index 2a023be..b41e730 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -64,8 +64,8 @@ enum {
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



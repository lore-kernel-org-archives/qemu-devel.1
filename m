Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3831ECDE27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 09:02:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86D1C20CC7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 09:02:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86D1C20CC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7yW6-0006sh-H5
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 05:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57786)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1i7xwO-0008Qj-Hw
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:25:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1i7xwN-0006s9-8u
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:25:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36165)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1i7xwN-0006rZ-1M
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:25:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id y19so23455639wrd.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 01:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=hvq3cQzVhqnjD5sToLYOJWwVWK77baMHrPI+LlHeGgQ=;
 b=hO3/CnZHvoeysYnl/UFaLo1Oo92Jj7b8DyGPq2vYqWFP8Ls5J2tuy3q7YD4db+nOUs
 3844NgMw9RucwBoCf1/JcKgs+rKKMCt8SjxgE8q6kR+FBrBATY2XfDs3eMMJ4Wx3Tcbr
 NkTF3ruwVYEGCelbvpxbl27rp9aF91UgEKPi0yFPewvTHddw5lb2bIm7xVbyo4zeUw7E
 RCCrudCrOxzQ9WOVtfM5tpIH5caBdPs7xWEL5KgsNQKdL2QXO91tqnlqO+NcQ/npmsWw
 EFfHiPMk5peAXhB+08/EWxSBhYPDj+kSWk9Fpnd0OCKIQeEFW5uaRuTDNCcSpCFZJSW3
 TE6A==
X-Gm-Message-State: APjAAAVrqw2dJ597YmE/KUlizLo2Ybs3wODNFgIt44fYeWWweZMf4XBF
 SlYNcmnnIrMJZyMc0efQszNsVw==
X-Google-Smtp-Source: APXvYqwU7MFwul3i6OMrNI4nd4cze/bUITUKrYtiPBgHlTB0LZ/GJa6gCzj+2KcAJhG4mEVmeETzBg==
X-Received: by 2002:a5d:46c4:: with SMTP id g4mr27590437wrs.189.1568190325830; 
 Wed, 11 Sep 2019 01:25:25 -0700 (PDT)
Received: from localhost ([148.69.85.38])
 by smtp.gmail.com with ESMTPSA id s19sm30988286wrb.14.2019.09.11.01.25.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2019 01:25:25 -0700 (PDT)
Date: Tue, 10 Sep 2019 12:05:03 -0700
Message-Id: <20190910190513.21160-38-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190910190513.21160-1-palmer@sifive.com>
References: <20190910190513.21160-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: [Qemu-devel] [PULL 37/47] riscv: sifive_u: Update UART base
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
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@sifive.com>,
 qemu-devel@nongnu.org, Jonathan Behrens <fintelia@gmail.com>,
 Chih-Min Chao <chihmin.chao@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bmeng.cn@gmail.com>

This updates the UART base address and IRQs to match the hardware.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Jonathan Behrens <fintelia@gmail.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_u.c         | 4 ++--
 include/hw/riscv/sifive_u.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index ea21095513..a3ee1ec0a9 100644
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
index bb46745356..7dfd1cb22e 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -65,8 +65,8 @@ enum {
 };
 
 enum {
-    SIFIVE_U_UART0_IRQ = 3,
-    SIFIVE_U_UART1_IRQ = 4,
+    SIFIVE_U_UART0_IRQ = 4,
+    SIFIVE_U_UART1_IRQ = 5,
     SIFIVE_U_GEM_IRQ = 0x35
 };
 
-- 
2.21.0



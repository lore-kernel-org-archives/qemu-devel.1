Return-Path: <SRS0=60Ee=WH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6DBC0650F
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 08:10:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE6F4208C2
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 08:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t43IaUi6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE6F4208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwiwC-0006D3-8M
	for qemu-devel@archiver.kernel.org; Sun, 11 Aug 2019 04:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60176)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hwisp-0005oI-T0
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 04:07:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hwisn-0003uY-US
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 04:07:19 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:45185)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hwisn-0003u7-PC; Sun, 11 Aug 2019 04:07:17 -0400
Received: by mail-pg1-x544.google.com with SMTP id o13so47963480pgp.12;
 Sun, 11 Aug 2019 01:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=U9isx4ZQndviX/FYcs9hIP4RNuR9Pm9yi9EGL82v3Ns=;
 b=t43IaUi6MBjZkSvlVbg+psVclfi4b5z4xnRBmw7PZCEBW/N8v077YEoJdJgdMb0C39
 EyYRG2BXfvV5S2nJ6mp+J5A7pS3DbUGSY6yBmhfjzN34r36P/bF/x77PeU8356fxcjc9
 Pu/y4RhonAWSyIRNzrEHQueR7/JLrZ6sP6IkamJezGsKV7q6lEsdFfTGHFh8a5RL45nk
 Sk1jm0D0uGTE+JA8XbjlIklT0bizrIuih9IbeXU/8RNi/S2RO9Z9GRGI+UTZJoAR3fqC
 yQyxPkaiH5FZ4mDIX2+yp9VEXWsXRULKkFaorFv5bpqhwmS383Ml1sKUS3ntV9FAvLNn
 46kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=U9isx4ZQndviX/FYcs9hIP4RNuR9Pm9yi9EGL82v3Ns=;
 b=Hi6nUv4OPGR37TYMlgyIjEYOhWnToQ3fQBmx/Sra7TG9HI9owMconoJ5x8RVjXosHO
 8iUnfaaIXKs2cYy5nOPmaWIFGAbL1BSvRhn3+fdC6crqfHEW9cQoM5c9cA3E4rFYohgB
 yeCqRdawq2fRWlOSEPOXe+4xTcI+NGx4ILPn+dwt878MBGWwwdx/m03NwArtee7NUoga
 11Cv/2qkMl3yvq1AZRlpljw7RjhBUSb4wkYr2lH4yUzo8MeNExb+aL+04QQkpxIiiwfm
 1J2EtBttW4ud+adkhzMZoP1n5Af2oqExBVzWrjmWSuln7b48CBU1BG75wO18flYqW8jq
 kqhw==
X-Gm-Message-State: APjAAAV3z0Ag92CGPdYenphKaiLTKWTWbMUmYNt+x1zmM2BGzQAqquaz
 nfhKzQ6Y4BaZx0LuCZy9IH7FfMQ8
X-Google-Smtp-Source: APXvYqy94mWnK94lwQsWWvQcKIa4pt7oMzkq8xwghn01oVHDfHAU+pNoiDMawdJncy/AxfKkSGUMPQ==
X-Received: by 2002:a63:e62:: with SMTP id 34mr24874664pgo.331.1565510837006; 
 Sun, 11 Aug 2019 01:07:17 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id v8sm87339107pgs.82.2019.08.11.01.07.16
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sun, 11 Aug 2019 01:07:16 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sun, 11 Aug 2019 01:06:42 -0700
Message-Id: <1565510821-3927-10-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565510821-3927-1-git-send-email-bmeng.cn@gmail.com>
References: <1565510821-3927-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v3 09/28] riscv: sifive_u: Update UART base
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

Changes in v3:
- update IRQ numbers of both UARTs to match hardware as well

Changes in v2: None

 hw/riscv/sifive_u.c         | 4 ++--
 include/hw/riscv/sifive_u.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 16ab95c..f24ec2e 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -61,8 +61,8 @@ static const struct MemmapEntry {
     [SIFIVE_U_MROM] =     {     0x1000,    0x11000 },
     [SIFIVE_U_CLINT] =    {  0x2000000,    0x10000 },
     [SIFIVE_U_PLIC] =     {  0xc000000,  0x4000000 },
-    [SIFIVE_U_UART0] =    { 0x10013000,     0x1000 },
-    [SIFIVE_U_UART1] =    { 0x10023000,     0x1000 },
+    [SIFIVE_U_UART0] =    { 0x10010000,     0x1000 },
+    [SIFIVE_U_UART1] =    { 0x10011000,     0x1000 },
     [SIFIVE_U_DRAM] =     { 0x80000000,        0x0 },
     [SIFIVE_U_GEM] =      { 0x100900FC,     0x2000 },
 };
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 650bc4c..d0d8528 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -58,8 +58,8 @@ enum {
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



Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15DDC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 00:53:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69F8E2074D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 00:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnATSJax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69F8E2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkzqq-0002Gy-Lw
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 20:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jkzoX-00076z-F9; Mon, 15 Jun 2020 20:50:57 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:36190)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jkzoV-0006Kd-Sm; Mon, 15 Jun 2020 20:50:57 -0400
Received: by mail-pg1-x542.google.com with SMTP id t7so8428659pgt.3;
 Mon, 15 Jun 2020 17:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=QY9pGdBoodyuLWvgAtPYSQUKGC728WHZnKf/IZEpuTo=;
 b=dnATSJaxAOjAG4IrUAiAXRRRrIELq610DGPctm7kU1hIlr0BfYI8rjL05bKP7Kgpkp
 2ogu3Jk3trbxebfjfoL8wUVL1mrPdsLSp7BMdF0Gm+K5w9uOtIWWLfbHpR3Obi5CP8rv
 RbXPk7aRCn/lI8pXb3LU90lkADbAfI0aXPU62R+Hpo16+POeRQ3af5XpMTUhCKpjPC75
 SrG8+bLBbXTcb8fpEVWkVemU25E7gHOrvO8eD38hWW/Xxc6i7G9uDKZJq2JjEkDh2M1F
 p7Di3zRjP2GvN09rvXLpmvG1J1CyI5IwC2V+AfJAgMH7cllyUU/BD4+AS2f7sCDtZGlr
 m0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=QY9pGdBoodyuLWvgAtPYSQUKGC728WHZnKf/IZEpuTo=;
 b=gouXRwxgn4V0SXrcmBpb6hH/+DnRo/tDVZ83//aEwDw8EnM4qJmrJSvsP6WRtc9rUY
 5AllTDlo1B4kN3On+xWXg+/LUzPUTNCAlJO2Bu7Xt6GSgoLjgLqk6oB4ysLZBTiwUIpi
 +7fIiMYDEHZhGvGxiRy38DsbEw4lW9Wa01XK5Z0QctCingcepa3s+6V2HTq2Z+EWuHJ7
 em/wnsnZ/bcoIq9LddNADjhzVN2HGlijuGisuGjrLtZVhADnK49hVEkCiYjkMAN3/s5e
 qvmOS3NSnx+oUneKdIZ/J/SMXqrOjLe62/qU6bW9azqg/276jLTADHKRCgHrv8ACmglM
 qQ0Q==
X-Gm-Message-State: AOAM531F9fdls8cHiqoIlh5JXWhtYTHvq3DyPi0JU/QF81xuu04lzG0c
 YWzpsWqE5+h1ZfVBFTzG0Ag=
X-Google-Smtp-Source: ABdhPJzS+RgCryDBd6ZjIW0ETfs6wsnPT5erLQwhYSm300Db8soIKyOH+EDuW6+8B2JAVcRvgeGwaQ==
X-Received: by 2002:aa7:8681:: with SMTP id d1mr271973pfo.230.1592268654148;
 Mon, 15 Jun 2020 17:50:54 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id i20sm15210539pfd.81.2020.06.15.17.50.53
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 15 Jun 2020 17:50:53 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 4/5] hw/riscv: sifive_u: Sort the SoC memmap table entries
Date: Mon, 15 Jun 2020 17:50:40 -0700
Message-Id: <1592268641-7478-5-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592268641-7478-1-git-send-email-bmeng.cn@gmail.com>
References: <1592268641-7478-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

Move the flash and DRAM to the end of the SoC memmap table.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---

(no changes since v1)

 hw/riscv/sifive_u.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index f64aa52..c94ff6f 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -80,10 +80,10 @@ static const struct MemmapEntry {
     [SIFIVE_U_UART1] =    { 0x10011000,     0x1000 },
     [SIFIVE_U_GPIO] =     { 0x10060000,     0x1000 },
     [SIFIVE_U_OTP] =      { 0x10070000,     0x1000 },
-    [SIFIVE_U_FLASH0] =   { 0x20000000, 0x10000000 },
-    [SIFIVE_U_DRAM] =     { 0x80000000,        0x0 },
     [SIFIVE_U_GEM] =      { 0x10090000,     0x2000 },
     [SIFIVE_U_GEM_MGMT] = { 0x100a0000,     0x1000 },
+    [SIFIVE_U_FLASH0] =   { 0x20000000, 0x10000000 },
+    [SIFIVE_U_DRAM] =     { 0x80000000,        0x0 },
 };
 
 #define OTP_SERIAL          1
-- 
2.7.4



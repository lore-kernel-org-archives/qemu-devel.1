Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E83C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 06:36:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C26325293
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 06:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbrscSCh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C26325293
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnG4g-0001wA-Dp
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 02:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jnG1j-0006ZM-Il; Mon, 22 Jun 2020 02:33:55 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36160)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jnG1h-0007vo-Ng; Mon, 22 Jun 2020 02:33:55 -0400
Received: by mail-wr1-x441.google.com with SMTP id k6so2917404wrn.3;
 Sun, 21 Jun 2020 23:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=DBMvo4MSmxnrTos0RHTFQ1uipETn7yULsn5/57j1g2I=;
 b=CbrscSCh7wy90RoaEA729exYVrmnCp9th0HqJvUlVF+sfMwIbv1WeXHfXvIppc9dUj
 DWOY8RRF8Wp28YCaPEamVzx38SmaRhB/PyYqdSP5JYcot6dNZrKl7JmQaUe/uV3CNU51
 rTpPdOWoiLOL6thpkq/ci6rTQ3o2evXvaDpPS4bDWe28CrvVHn5Ymv3UiT0Fh4dHt2Oj
 ffIl2aLsFYxS/pNmStD7y71suDDQA/s2outz+TkOgRipE16oth7Ipxf/pcX80PaEtVAu
 JkxyKKg+A5nRVxJ64qoX1OdWv8Fqp+a5rV3jgPIS9uzhW4xv5pQBQP/HZr3P9kcX8Avj
 IyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=DBMvo4MSmxnrTos0RHTFQ1uipETn7yULsn5/57j1g2I=;
 b=rLtEDEMeXVZb9ZxEtK+kt3Ppq8er2dDpP5+pMVQ1UJPcvpb/dyh9RO22x8YyQhhnUU
 40qMgPY71sYMYJdCS2D2HTkGc3itPDWggr7F0F8oA7eBRiS2TarhJiLeEIekKk1CgKes
 DckNDImWFumvUcBCEJwse/ti9VDrPn3ECpj8C/WhEs802W1WgqEOPCE3451//1IUGEBm
 sYko4stMvV9WW7jOKLXSGhYhLI1CZQILcszKohsYp5rSA2lz5GwEJ1asnjDmL4MY7vgy
 z64Uf5y82sk3L4Ph0//Mf2OBs4XvNpIKzXD0Z7T2vElLhuyM71XE9jkMAa0/XLPmEvcN
 reaA==
X-Gm-Message-State: AOAM532ZjpVgX6pY6jC0iTkUpdcW+gvoaVyPWzo51/Tdijzi7TgKqKag
 HphbkPrR9b41jJOL1Z2Prfk=
X-Google-Smtp-Source: ABdhPJzIymSFXUZgF545ZWfQjZDiLIvp8afF3GhTBnreqwrhqjB4b9GrX856vGYhtwnypV0/Kf5eXA==
X-Received: by 2002:a5d:62d1:: with SMTP id o17mr16997999wrv.162.1592807630175; 
 Sun, 21 Jun 2020 23:33:50 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id a10sm16684240wrm.21.2020.06.21.23.33.48
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sun, 21 Jun 2020 23:33:49 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 7/7] Makefile: Ship the generic platform bios images for
 RISC-V
Date: Sun, 21 Jun 2020 23:33:24 -0700
Message-Id: <1592807604-20805-8-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592807604-20805-1-git-send-email-bmeng.cn@gmail.com>
References: <1592807604-20805-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=bmeng.cn@gmail.com; helo=mail-wr1-x441.google.com
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
Cc: Anup Patel <anup@brainfault.org>, Bin Meng <bin.meng@windriver.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

Signed-off-by: Bin Meng <bin.meng@windriver.com>

---

Changes in v2:
- new patch: Makefile: Ship the generic platform bios images for RISC-V

 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 48f23aa..ddd7c43 100644
--- a/Makefile
+++ b/Makefile
@@ -841,8 +841,8 @@ u-boot.e500 u-boot-sam460-20100605.bin \
 qemu_vga.ndrv \
 edk2-licenses.txt \
 hppa-firmware.img \
-opensbi-riscv32-sifive_u-fw_jump.bin opensbi-riscv32-virt-fw_jump.bin \
-opensbi-riscv64-sifive_u-fw_jump.bin opensbi-riscv64-virt-fw_jump.bin
+opensbi-riscv32-generic-fw_jump.bin opensbi-riscv32-generic-fw_jump.elf \
+opensbi-riscv64-generic-fw_jump.bin opensbi-riscv64-generic-fw_jump.elf
 
 
 DESCS=50-edk2-i386-secure.json 50-edk2-x86_64-secure.json \
-- 
2.7.4



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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C89C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 07:56:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB25B22BED
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 07:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4OaPej8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB25B22BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37943 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvGni-0006eB-5G
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 03:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36849)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvGdx-0001G5-IV
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:45:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvGdw-0008Du-ET
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:45:57 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:44513)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hvGdw-0008DW-8A; Wed, 07 Aug 2019 03:45:56 -0400
Received: by mail-pl1-x642.google.com with SMTP id t14so39457220plr.11;
 Wed, 07 Aug 2019 00:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=4sBZOy54i7FwospnAgzS66UMgmogyqri0jjg65m7Jmg=;
 b=T4OaPej8EYBlFG523BLm+sYaxJ4oum25P23a0E55r5tYoWCmaly3cZw209efW4znID
 uQ5oeTfJ18uaxEWQvsT3cm18Qw+qkRP/QAcumnCbRY79GTucUemXgPIgsLdBoaQ0rMO6
 Pzl9XribMMPFM4PtgvIaIf4WMb+kkoqdh9jaK56oisDu4X4klDMyqVnM3Cg0vSyyPDtX
 X7m2r3Pf86Sw2U+QxiKWEe4av3BuapNKh/LR/nyYmW36spul1bXYlfiJzSNACld+RvTd
 2bAQoPs5N/YPvvN5ZgD1PE/6QsVTG60UtglK8B1S2Nsqxdq3Fzf7cWI1S9c1fiqfmFJE
 vc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=4sBZOy54i7FwospnAgzS66UMgmogyqri0jjg65m7Jmg=;
 b=mt9Wsa6+I0GuWoVk8JuwPz8deTUSWM4/l6Q3YfzPFrgsU7aBszaR6SKu4bWRQqknA0
 TGgbEXXoYfiPv/4EJlobvheQNIcVjvkUCT/kXTpkXNlEVLe7P3zBXxUEj0uCwDLpzJt3
 5A8EmKjxLAebbMIuoa8uIXM59d6EKs5XAJzf3wej67NRJ7lnEZa+dsQVEPhdktxejjJM
 Y0Ob0Rs0Dm38ntzq9uHQwAKsAt077gtdVYZjhVZJxl1aUcBLYBRVxohVao7JDqsZfVts
 UihHONZH7/MPEhR12xgwZblv/4TX3lSS9An/jcwOBxUwMLIgB3JdKDb4UafOXj5LzLgM
 sQ6w==
X-Gm-Message-State: APjAAAUcUS2N6FzwstjT4QycD0tK0J8CPoJZ37wG1Yg+0SVoMh0NKs95
 uKfPyGjPtPS/lhNQYjPgw/E=
X-Google-Smtp-Source: APXvYqy2autF5vGFvA9bkoasbcY5aluqTVz8cLI2on4ol/oOHm7U6DImL8alIMgNemSBYvBpvXPWTQ==
X-Received: by 2002:a17:902:7283:: with SMTP id
 d3mr6800715pll.93.1565163955394; 
 Wed, 07 Aug 2019 00:45:55 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id l44sm20154449pje.29.2019.08.07.00.45.54
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Wed, 07 Aug 2019 00:45:54 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Wed,  7 Aug 2019 00:45:18 -0700
Message-Id: <1565163924-18621-23-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565163924-18621-1-git-send-email-bmeng.cn@gmail.com>
References: <1565163924-18621-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v2 22/28] riscv: sifive_u: Generate an aliases
 node in the device tree
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

The Linux kernel SiFive UART driver expects an aliases node to be
present in the device tree, from which the driver extracts the port
number from "serial#" in the aliases node.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

Changes in v2: None

 hw/riscv/sifive_u.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index fb4845c..8218cdd 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -284,6 +284,8 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     if (cmdline) {
         qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
     }
+    qemu_fdt_add_subnode(fdt, "/aliases");
+    qemu_fdt_setprop_string(fdt, "/aliases", "serial0", nodename);
     g_free(nodename);
 }
 
-- 
2.7.4



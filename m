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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274FDC3A59B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 05:14:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA0F22070B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 05:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZjuTmLg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA0F22070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hza07-0007Ro-Pb
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 01:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1hzZxr-000504-3X
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 01:12:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hzZxq-0007Te-4v
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 01:12:19 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:37282)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hzZxp-0007Q8-Uq; Mon, 19 Aug 2019 01:12:18 -0400
Received: by mail-pf1-x441.google.com with SMTP id 129so456335pfa.4;
 Sun, 18 Aug 2019 22:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=ADbrDNOHtnmDej9eClFWWb6D3hQH7ua5FDpfJg6FqBU=;
 b=TZjuTmLg9whWBu41INonrovWOqf5MCjDeUOh2gW/uSbUeUx+8OXK0i8CrGXUFiAd38
 E0jYlG4ZvGjVed1YhF8nCI8XSro0Gia1z/Q9P6HgWwlpY3FERB9wUOnaaEm+jWeu/cMQ
 lDhbLMSEyogeWjqn8Pc6oWtmftV/ErwIquz1K3zUft09/ZmuNeSFRDEyh6xcoZ8EvH7H
 chtuPjqM4wK7NitGE/EVD/S60hCLdE2vRpbNe47C91+Nbz6urckvtXRsPut0rRCH3t2A
 Fx6rXJ89Ox5EZ8Gska9JXdCBnpjlfcU+zSsaO78pENeJxcs3Oiv1Et+MbwnlbAT4dwW/
 FsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=ADbrDNOHtnmDej9eClFWWb6D3hQH7ua5FDpfJg6FqBU=;
 b=DxaD9DDOhV97yw4MrRsqssR4uxvfmFNhWTCwAXmxBUZq4D3rhgBdZV8F04e+TF3NlC
 gPQ7fjK62JFnmuKxv6nD2QSKHATuxVIry6OYXJJP17EUXq3S1bjIhPp6JUwAccuFB+U/
 AHj3RtpyarxY4rln0E09lhaLFrIZMHsOodi7ZU98z6NRcFd9L0KDif5+qfslarbLaVCN
 ZrnZA4DjR9iK+vYB9Ew2bRgYGNNtBTPmWZ9FomX0K1FGaIeGGp49rhMnuo5YS0VSrqUE
 h/6Gm20BFW11OPSzeH6dePCmkoBOm2PZFtoJoz6srAZrBv9a4/wHsZZWcg7/yrpCz2lE
 1vFA==
X-Gm-Message-State: APjAAAV/7DDymnAq1BYSKIYeQEdh5B85S8eFhokVSXeq2ZwfgOe4qPaC
 WYWM5DCpvf05iEDTl73L+i0=
X-Google-Smtp-Source: APXvYqyJDnErPIP/cRBw1eWAzrrRYmfw0qvq16nfWF3wFhar2LLF9DxYFpi1+NHBMBa+8yeU1hQfAw==
X-Received: by 2002:a65:56c1:: with SMTP id w1mr18006662pgs.395.1566191537024; 
 Sun, 18 Aug 2019 22:12:17 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id q13sm15464986pfl.124.2019.08.18.22.12.16
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sun, 18 Aug 2019 22:12:16 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sun, 18 Aug 2019 22:11:42 -0700
Message-Id: <1566191521-7820-10-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1566191521-7820-1-git-send-email-bmeng.cn@gmail.com>
References: <1566191521-7820-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v4 09/28] riscv: sifive_e: prci: Update the
 PRCI register block size
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

Currently the PRCI register block size is set to 0x8000, but in fact
0x1000 is enough, which is also what the manual says.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 hw/riscv/sifive_e_prci.c         | 2 +-
 include/hw/riscv/sifive_e_prci.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_e_prci.c b/hw/riscv/sifive_e_prci.c
index 603a54b..3afcb84 100644
--- a/hw/riscv/sifive_e_prci.c
+++ b/hw/riscv/sifive_e_prci.c
@@ -85,7 +85,7 @@ static void sifive_e_prci_init(Object *obj)
     SiFiveEPRCIState *s = SIFIVE_E_PRCI(obj);
 
     memory_region_init_io(&s->mmio, obj, &sifive_e_prci_ops, s,
-                          TYPE_SIFIVE_E_PRCI, 0x8000);
+                          TYPE_SIFIVE_E_PRCI, SIFIVE_E_PRCI_REG_SIZE);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
 
     s->hfrosccfg = (SIFIVE_E_PRCI_HFROSCCFG_RDY | SIFIVE_E_PRCI_HFROSCCFG_EN);
diff --git a/include/hw/riscv/sifive_e_prci.h b/include/hw/riscv/sifive_e_prci.h
index c4b76aa..698b0b4 100644
--- a/include/hw/riscv/sifive_e_prci.h
+++ b/include/hw/riscv/sifive_e_prci.h
@@ -47,6 +47,8 @@ enum {
     SIFIVE_E_PRCI_PLLOUTDIV_DIV1 = (1 << 8)
 };
 
+#define SIFIVE_E_PRCI_REG_SIZE  0x1000
+
 #define TYPE_SIFIVE_E_PRCI      "riscv.sifive.e.prci"
 
 #define SIFIVE_E_PRCI(obj) \
-- 
2.7.4



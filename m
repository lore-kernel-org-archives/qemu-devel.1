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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486BDC3A5A6
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 03:07:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1264022D37
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 03:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaOFOdGr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1264022D37
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4GD3-0003kJ-BG
	for qemu-devel@archiver.kernel.org; Sat, 31 Aug 2019 23:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47720)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i4Fzi-0007fq-Fg
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 22:53:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i4Fzg-0006SS-6F
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 22:53:34 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:46886)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i4Fzf-0006Qe-Uu; Sat, 31 Aug 2019 22:53:32 -0400
Received: by mail-pf1-x441.google.com with SMTP id q139so6906534pfc.13;
 Sat, 31 Aug 2019 19:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=9AaPW9KHgO45I20BSwtPdHnCnwAaSJjqcEM+IRY/Uk0=;
 b=QaOFOdGr8RFK6HCW5TnuKW1F0aLBXF0vCyet7KCJWocUr2NDtcyPLhK3DLZdVRAVro
 QINYWeWmmUg1M+6+nNIBApxyLKqXYfcwZL9fyUxtntkuHSiJ1iIEK09cdD/Qy0HOtv7W
 tMqBox3KrJhlm/6EABD6wzLwtUqTHRFjZ3svyMVuI9jDGlN7WaoyU4A34n9gN46AyECH
 15IqXToXgxjDslqjRiWaSa6H5D5KkK0SHdmRDYEtTuMYUcEK2N0S99ipViw15DNXNtXE
 1FFOO6LIAMkH+jeas56c1BLaP/aBcCHY1Q/cPpU4aJBbb9/d5pQOpV4tR+O0eJfHcUWq
 TXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=9AaPW9KHgO45I20BSwtPdHnCnwAaSJjqcEM+IRY/Uk0=;
 b=BAaS9pDH3FVHxgdgBBpEMm8G88dCPVsbpy/cZrP3Xzi76v1sLV+5okDrsp6XxN6+vV
 a53Px49jOtRdXgPGHFveaMul0KB6BJOejKg9cobvyWcj/EALO14T1cIbnFIxcavYzyuw
 Dn4An5WFm1cPFi4J2HV/Rie3Iyrv6NbeihvHJt6GmdXp44X94AWRChyC3KJDNUFPyTSa
 I3Wjb1cLu1GGuoUR/knDd/FUQAxkRIIFSsNZ3VTgbL3UvA1KBq4fWyccCfJw8iy0jc6b
 eCq/aW3Lzk2Yk9LKCPAmU17pVaCVNKeiXY4P+A3flcK9v60bSIIEdTm/uKkAc1mxacsc
 Xa5Q==
X-Gm-Message-State: APjAAAXsUxmiO6FwMf6i7XIG8p/YKF0FWTU4CpbF6NS0ZJ69pBXkv8FM
 KAE1VhQkL/iuXOPZuF4g/cjm2Y91
X-Google-Smtp-Source: APXvYqycrdFg6Xl4SK+HnhgDvb8xJAgCcYPPm6/iLx/9eHMLgE1ZNVhYVI1sJdANmTjDz6eCylzBCA==
X-Received: by 2002:a63:2f44:: with SMTP id v65mr1899708pgv.380.1567306410696; 
 Sat, 31 Aug 2019 19:53:30 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id p10sm11453307pff.132.2019.08.31.19.53.29
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sat, 31 Aug 2019 19:53:30 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sat, 31 Aug 2019 19:52:52 -0700
Message-Id: <1567306391-2682-12-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1567306391-2682-1-git-send-email-bmeng.cn@gmail.com>
References: <1567306391-2682-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v7 11/30] riscv: sifive_e: prci: Update the
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

Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 hw/riscv/sifive_e_prci.c         | 2 +-
 include/hw/riscv/sifive_e_prci.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_e_prci.c b/hw/riscv/sifive_e_prci.c
index 71de089..ad6c624 100644
--- a/hw/riscv/sifive_e_prci.c
+++ b/hw/riscv/sifive_e_prci.c
@@ -86,7 +86,7 @@ static void sifive_e_prci_init(Object *obj)
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



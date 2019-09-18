Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476EEC4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 15:53:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D29A207FC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 15:53:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D29A207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAcGI-0004nT-GB
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 11:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49531)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iAbsW-0007E4-0P
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iAbsU-0006t3-Gt
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:23 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:44378)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iAbsU-0006sK-52
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:22 -0400
Received: by mail-pf1-f177.google.com with SMTP id q21so181492pfn.11
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 08:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=tDJG1p1Bp8CpFD/Bq7K8CLsWHyHj5vOvpUlOoU/iQGc=;
 b=qP6BVdYvGFGgcMkyHxawitzDrCHkxAsbM5jbt0ItVUzls5GgRL+0n9M1Xt0McgsTvE
 8CYL20KaNX8g1DXm+Jc8CqAkgCqG32c4a/lRMtW6qEzhbmDWqpNTmrkO8KQqgextjUBK
 OPwG/VJ3C/GLxY5ZcM+ngj45QgR5NhgnbVUN1NZ1kbV1UR3EEfyIc7hZmCPQEJc8WLkv
 BMphVVetdVAbBq3IgdbgR7izXW6/WBPjhw+K1bHl8N5dnUpUo0eiuHVELGHGNxsQM1co
 6v5w5uecs76vRmEOra6KArWnT/vJwczA7Hw1Uhjm0bIs/Vq3fxqEKha/s8iXwmX+R0cG
 Pczw==
X-Gm-Message-State: APjAAAWi66HNrG8Df4TirBtH0mjINnRVD1Cf50XYKD3A4nWtl/Q9L0kp
 YQ2eqcBPZdA7linvnBBfuELtnA==
X-Google-Smtp-Source: APXvYqy+cRT/+fOnG5BSUB9VolPu2Dcg/rkpD2wAniy3O29vmboPhteFLknO2COjItiyYBPB5syO6w==
X-Received: by 2002:a17:90a:bd8a:: with SMTP id
 z10mr4425137pjr.52.1568820500957; 
 Wed, 18 Sep 2019 08:28:20 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id q20sm8662833pfl.79.2019.09.18.08.28.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 08:28:20 -0700 (PDT)
Date: Wed, 18 Sep 2019 07:56:17 -0700
Message-Id: <20190918145640.17349-26-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190918145640.17349-1-palmer@sifive.com>
References: <20190918145640.17349-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.177
Subject: [Qemu-devel] [PULL 25/48] riscv: sifive_e: prci: Update the PRCI
 register block size
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
 qemu-devel@nongnu.org, Chih-Min Chao <chihmin.chao@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bmeng.cn@gmail.com>

Currently the PRCI register block size is set to 0x8000, but in fact
0x1000 is enough, which is also what the manual says.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_e_prci.c         | 2 +-
 include/hw/riscv/sifive_e_prci.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_e_prci.c b/hw/riscv/sifive_e_prci.c
index bfe9b13a67..a1c0d44f18 100644
--- a/hw/riscv/sifive_e_prci.c
+++ b/hw/riscv/sifive_e_prci.c
@@ -87,7 +87,7 @@ static void sifive_e_prci_init(Object *obj)
     SiFiveEPRCIState *s = SIFIVE_E_PRCI(obj);
 
     memory_region_init_io(&s->mmio, obj, &sifive_e_prci_ops, s,
-                          TYPE_SIFIVE_E_PRCI, 0x8000);
+                          TYPE_SIFIVE_E_PRCI, SIFIVE_E_PRCI_REG_SIZE);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
 
     s->hfrosccfg = (SIFIVE_E_PRCI_HFROSCCFG_RDY | SIFIVE_E_PRCI_HFROSCCFG_EN);
diff --git a/include/hw/riscv/sifive_e_prci.h b/include/hw/riscv/sifive_e_prci.h
index c4b76aa17a..698b0b451c 100644
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
2.21.0



Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FB6C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:41:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 779ED20578
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q9oI06eo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 779ED20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6HJ0-0003uI-4s
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 12:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56799)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i6Gyt-0004t5-VC
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:21:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i6Gyq-0004bw-7M
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:21:03 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:35648)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i6Gyp-0004ac-Op; Fri, 06 Sep 2019 12:21:00 -0400
Received: by mail-pl1-x641.google.com with SMTP id gn20so3382670plb.2;
 Fri, 06 Sep 2019 09:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=jfFTdv5B4sGuBqEYzNJzYgO1q5f33aGSCik/yWhYEl8=;
 b=q9oI06eofCw2xsOu5mmPX/5r4LxKHuihbNdcRxzOA+9BGpZ02WMcyxowFjRb1DXVJj
 b5L7Zr9z7k5DkhsXyAFcqrGD2GqeCK1fK+Jr7dOItcNQKQn4dIX7dRSfiWueBXsrgNpR
 jsCkG4XBNkal5GDZRW0C8WFM/ZAvrCpUynDEZw4RRPXq4WcarAlIJYbDp3shmpWgfk6N
 fNNMW1QDP+B+JsAhVvpp9EsuRY0RbWkXS3aRtxXK8AopVdTou/QbPL8iH8H4te72PlV4
 00GEcU0Fmfk3rv5ezKT2BSrRiLa3TBzW1epG7KZndPA9d7kLQb1mW8eOQsVhftEy7Egg
 ZgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=jfFTdv5B4sGuBqEYzNJzYgO1q5f33aGSCik/yWhYEl8=;
 b=UhemRJfIp+UiPgKFlHF/3IKlFF5kfGY5d1LC3uuZTM89lO2RofUtAH3LMC8r7tmn47
 9LEkZ6omAvnsZIDGav8QKlA+OO2k9MqwI+/GD3KcntmFvlL30APTvNGy5myqL2d5U8CE
 FmRTq6OlRtzEU8S1pi7fCLSg+CGdUIGG70Sby+ycdbXsAf63w6Ler3BLsSn+wbJKPGd5
 bf/N0Nqo0xB2N/bt5bBqGzIVh5Xq7BydME9xtyz3k8DpBNiQvB/camwFxcKPvwhroFlb
 BwxME34ruksO2ymDMjL2R1rhwA53lZqYyxZsqX3t9gkEcICiRUHLCXhqcHMmv8F/YHWT
 6IMQ==
X-Gm-Message-State: APjAAAVnpTbPxFv2xFaNlb/wif75qJ/4SQDViAxflyzDSb2mhSVvTrXW
 6feoNcwy28E3oF+yEgxDAtvs8axK
X-Google-Smtp-Source: APXvYqxSU5VIdW1Jd3o1ABZ6rDkYW+biJfzdz4UpT3D6iMn9U4DnUMkYzScF4npGhUt9cZrJvQl2RQ==
X-Received: by 2002:a17:902:465:: with SMTP id 92mr9930063ple.65.1567786858077; 
 Fri, 06 Sep 2019 09:20:58 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id f89sm11146228pje.20.2019.09.06.09.20.57
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Fri, 06 Sep 2019 09:20:57 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Fri,  6 Sep 2019 09:20:19 -0700
Message-Id: <1567786819-22142-33-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1567786819-22142-1-git-send-email-bmeng.cn@gmail.com>
References: <1567786819-22142-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v8 32/32] riscv: sifive_u: Update model and
 compatible strings in device tree
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

This updates model and compatible strings to use the same strings
as used in the Linux kernel device tree (hifive-unleashed-a00.dts).

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

---

Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 hw/riscv/sifive_u.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 507a6e2..ca9f7fe 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -96,8 +96,9 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
         exit(1);
     }
 
-    qemu_fdt_setprop_string(fdt, "/", "model", "ucbbar,spike-bare,qemu");
-    qemu_fdt_setprop_string(fdt, "/", "compatible", "ucbbar,spike-bare-dev");
+    qemu_fdt_setprop_string(fdt, "/", "model", "SiFive HiFive Unleashed A00");
+    qemu_fdt_setprop_string(fdt, "/", "compatible",
+                            "sifive,hifive-unleashed-a00");
     qemu_fdt_setprop_cell(fdt, "/", "#size-cells", 0x2);
     qemu_fdt_setprop_cell(fdt, "/", "#address-cells", 0x2);
 
-- 
2.7.4



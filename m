Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDF4C19759
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 07:51:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 707E5217F4
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 07:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qfY40xdX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 707E5217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvGjS-00052F-Kh
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 03:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36713)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvGdt-00014t-UJ
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:45:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvGds-00089L-RW
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:45:53 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:33390)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hvGdq-00086v-Li; Wed, 07 Aug 2019 03:45:50 -0400
Received: by mail-pl1-x644.google.com with SMTP id c14so39397632plo.0;
 Wed, 07 Aug 2019 00:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=dRLa2JND76bWv7IUc9c8GfiO26glVkTf37D7H11ZvmA=;
 b=qfY40xdXSoOS4FUL8R+HezgB6H7ak+WahZB00+ir3O6stHU0YYmuKJvVQ3u9svihIm
 Km4j1V9qDnswoVD2PSwZWorEhI6RMtpojIqd8vCKZYeyRrqdUys6Mds47yU0TcwNYmW1
 3IW39/07LzzCBETatcg6sVViZwfq9npjmRpKQJXRuAqUtsBe+1GL/slhpopXDwS1emKT
 7v2XKpCnLa9ANfRKbrjiC6Fe4c2BAY4UpH/oPn+xoUhjLzWAv506ljkaF5/HDeq5GYLC
 GKu7HLc82J/OWfHuTLOhYXtEnzBp5Ibvo7tAWiDFeO3ssIBMvWZ6DVreyTS8d+W+7SPo
 MNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=dRLa2JND76bWv7IUc9c8GfiO26glVkTf37D7H11ZvmA=;
 b=Q2QY5eVQQ46VkodqRsL69Fmsf+Ve02FBC2vE90RclxZnqR5TUzXbytQNa1riAV6O7Z
 9pl3o6PiZKWkM/9hIJ1orGbKOhaZNKOSBVUX/xWh/IPWF6TvdbWERVN9rk2OE+vO3fI/
 nxDFzOFJJrBt/Lfe7lT+i2orO+1eH8iTNqeSKF1lRi1IYQknjZHU6EhXHuWV5RdWfFLH
 B+sDxGf5F4df+N3xotQSE3AF4R2TzLzzpy1UauOoBv/McAUqA1mRty9S1I5RQ8MRtjqM
 fLfbX7zrusRU70/cfZS+6u9ovq7o3czqMUN8OYWV1iGGJFgHUCVXZpI5q0lMTnFs9Jew
 ng1Q==
X-Gm-Message-State: APjAAAWgX1TdJcghBMoadDpzL7forH5S3bhJgevUYPBlVMpIoI3LR+73
 J+HLoPaTHjMLt2+d348J8IE=
X-Google-Smtp-Source: APXvYqzGuliqC2/LoRoKY5oDsIxqLKcRpnGzCepLb1H8PEj1rw9H0+d4koOD84n0dk6d4wj3GS3U7g==
X-Received: by 2002:a17:902:b789:: with SMTP id
 e9mr6839650pls.294.1565163949636; 
 Wed, 07 Aug 2019 00:45:49 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id l44sm20154449pje.29.2019.08.07.00.45.48
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Wed, 07 Aug 2019 00:45:49 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Wed,  7 Aug 2019 00:45:13 -0700
Message-Id: <1565163924-18621-18-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565163924-18621-1-git-send-email-bmeng.cn@gmail.com>
References: <1565163924-18621-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v2 17/28] riscv: sifive_u: Change UART node
 name in device tree
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

OpenSBI for fu540 does DT fix up (see fu540_modify_dt()) by updating
chosen "stdout-path" to point to "/soc/serial@...", and U-Boot will
use this information to locate the serial node and probe its driver.
However currently we generate the UART node name as "/soc/uart@...",
causing U-Boot fail to find the serial node in DT.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---

Changes in v2: None

 hw/riscv/sifive_u.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index cab329a..bddf892 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -274,7 +274,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_cell(fdt, nodename, "reg", 0x0);
     g_free(nodename);
 
-    nodename = g_strdup_printf("/soc/uart@%lx",
+    nodename = g_strdup_printf("/soc/serial@%lx",
         (long)memmap[SIFIVE_U_UART0].base);
     qemu_fdt_add_subnode(fdt, nodename);
     qemu_fdt_setprop_string(fdt, nodename, "compatible", "sifive,uart0");
-- 
2.7.4



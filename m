Return-Path: <SRS0=60Ee=WH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9DFC0650F
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 08:17:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F33AB208C2
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 08:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQloIMvA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F33AB208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwj2k-0004TN-4m
	for qemu-devel@archiver.kernel.org; Sun, 11 Aug 2019 04:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60511)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hwit5-0006i5-Uy
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 04:07:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hwit4-00047j-Se
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 04:07:35 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:46547)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hwit4-000473-Mu; Sun, 11 Aug 2019 04:07:34 -0400
Received: by mail-pl1-x641.google.com with SMTP id c2so46684673plz.13;
 Sun, 11 Aug 2019 01:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=pf6iyW4D6ylluzsEL2WnqoH6nuzAdNyXzAQ0//xR7/Q=;
 b=iQloIMvA9uLT6mCyszeBlmjjMYlbUmJTWIEuU9RZEhDi1IYJvl17WFTKmSGdZ6xxlX
 E8g2ujanNOr+w+Nviwc4/IYD78jTEIDgxdiTS0KzlmRPazMqM6C8gU34Y62Htd/dNvb7
 epStjxFEYOSCdgBqtY0opovVZbwTOS47Esbiw26D8KNIOhVYhZhOtBBdVaI3G4b6VVOx
 CupRgIQbujtP8ahBUA95bEcRa4mnaiqg/pGR1obZkvxW9eCxxCmei8GELKi3WJnIUQsE
 ApzjdmWfYhQyiGRnX1zopmMoixNBXNy+xmqwpeATVWRT2wBBsGowquQpfssFBdHYiqrY
 edhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=pf6iyW4D6ylluzsEL2WnqoH6nuzAdNyXzAQ0//xR7/Q=;
 b=GnF84tctg0Zrxo/JjiMuu45D/VDiZ9ruEdbLHyfjymKYI4G8tf0+FuFzGmcZLqPxec
 C1Yi60QO516JWAF4JlHNwzav0DMrtPKUXMyPHx5Gi25zeRg221mw9VTOEwquyd/Zy0WN
 G6cs4/zh5Dj+eDWNyOkne283pNi5CJpKGM5kzyiFqAV7ShY84tv/TfdR64CBKCcbuZrn
 rYylVRSAip5pTFaWTENoac6/5rBRpCzPL2LidJTfoC756gNE+mDKHkthAbLo9N0wysoW
 mGk+6jL29SKCTE+58sia0sTOSsC29oOjgLArr2G8F7lbfBb63n6oDOZq7vcLFi+KGdE2
 ppcA==
X-Gm-Message-State: APjAAAXtsdCXtcDi4I4qH135vXPB0x3l77CpNn97+Au41QyKdIFKj7sg
 tArNLUtt2CLkcjjnkanS4sE=
X-Google-Smtp-Source: APXvYqybGKEdfGqAyCvITaL7Hp1Xw+DjX8pZXr1Mzm8R495Wu9E48h3XvlL80CQ2A/pTW/5X0NjhIQ==
X-Received: by 2002:a17:902:4222:: with SMTP id
 g31mr28519934pld.41.1565510854044; 
 Sun, 11 Aug 2019 01:07:34 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id v8sm87339107pgs.82.2019.08.11.01.07.33
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sun, 11 Aug 2019 01:07:33 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sun, 11 Aug 2019 01:06:57 -0700
Message-Id: <1565510821-3927-25-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565510821-3927-1-git-send-email-bmeng.cn@gmail.com>
References: <1565510821-3927-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v3 24/28] riscv: sifive_u: Support loading
 initramfs
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

The loading of initramfs is currently not supported on 'sifive_u'.
Add the support to make '-initrd' command line parameter useful.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com>
---

Changes in v3: None
Changes in v2: None

 hw/riscv/sifive_u.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index e8bef44..b0026aa 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -328,7 +328,18 @@ static void riscv_sifive_u_init(MachineState *machine)
                                  memmap[SIFIVE_U_DRAM].base);
 
     if (machine->kernel_filename) {
-        riscv_load_kernel(machine->kernel_filename);
+        uint64_t kernel_entry = riscv_load_kernel(machine->kernel_filename);
+
+        if (machine->initrd_filename) {
+            hwaddr start;
+            hwaddr end = riscv_load_initrd(machine->initrd_filename,
+                                           machine->ram_size, kernel_entry,
+                                           &start);
+            qemu_fdt_setprop_cell(s->fdt, "/chosen",
+                                  "linux,initrd-start", start);
+            qemu_fdt_setprop_cell(s->fdt, "/chosen", "linux,initrd-end",
+                                  end);
+        }
     }
 
     /* reset vector */
-- 
2.7.4



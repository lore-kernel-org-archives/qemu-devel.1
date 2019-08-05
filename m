Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5783AC433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:04:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 251942064A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAG6hGCD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 251942064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hufTY-0006Zh-AR
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 12:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58352)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hufPb-0000HI-1q
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:00:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hufPZ-0002qX-Vq
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:00:38 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:34067)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hufPZ-0002pl-Nw; Mon, 05 Aug 2019 12:00:37 -0400
Received: by mail-pg1-x544.google.com with SMTP id n9so33750183pgc.1;
 Mon, 05 Aug 2019 09:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=HmEOrQlPGOd0Y81l931aXbkGZtqwGBdfoUEd2ZirFRk=;
 b=fAG6hGCDvp2ioiFiIdPyhLs4odrCu2Mi2EaultibP5/mzhilRx7U/DzeeYYshpm/F1
 Wr2lFsHZSevZ36xGMJObEhM41jYxM6uVrHOp6mvH5WoUE8dk6etDdjY7hhi0RmqVJ+Vg
 1cEB1rYHvGJDdJfU7PouLCwrI8XQmERQ/w/el3aohxL9yQcxCwRVrHqkueMeTxZgvszV
 jLXO1rHYKNCkRUe7Ws9eCsYw2n4WgGe8RMdw9guunlJUb0fdKS3+uEjXpDkhblIM4eUJ
 ZGh8+UL31VLym6+gAHPXW85OLr0I2OhCe1x1SdGMvfB/UrZ61YpgLNGwTc1xucy4w4nr
 SBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=HmEOrQlPGOd0Y81l931aXbkGZtqwGBdfoUEd2ZirFRk=;
 b=euLhq9F9QLwa/O2FvsjCgg5TMtezzBfyz2fsWLh450XJxqZQqJpUJNO45mxOb12bdJ
 rMoBp7o9VtIikx1FArS6Qp8gy9WEtZbQDVVVsnzuYML081qBe2EbeNhi2yV+mZEUVQOn
 BYavK88CRjBK8g4R5aaNMFb0WfX9DgPQrg1vPlhFI9wRZFOLtMwGACO0tYKUf4ARZbll
 lARJY+dgic99ZchZFZRMZDbG13HdLL2DrQwKaPJdgdgIJSNUi51DEk3IXA4U8C3U5tgi
 GlIZsfEC9anAX9N+wMyhiudkxu3ZuctfQl/tUJ424QcSmAnwRvxRBHWPnnrv+OiHNE/S
 Rvyg==
X-Gm-Message-State: APjAAAUUtlt47ef77y14bGVtGXUKMFXt+0OeWQ9agcHyVpYUUeertXw+
 ZW0Il6aucy5aFuIp+Zols68=
X-Google-Smtp-Source: APXvYqznoOYCYswgx1X853oPmpSslnBBUugTuEj9/BjbAHgLRFlkUEXCcSEZ/zxCB+TllwWx3QAo0Q==
X-Received: by 2002:aa7:9afc:: with SMTP id y28mr72451044pfp.252.1565020836907; 
 Mon, 05 Aug 2019 09:00:36 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id d18sm47728793pgi.40.2019.08.05.09.00.35
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 05 Aug 2019 09:00:36 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Mon,  5 Aug 2019 09:00:03 -0700
Message-Id: <1565020823-24223-9-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565020823-24223-1-git-send-email-bmeng.cn@gmail.com>
References: <1565020823-24223-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH 08/28] riscv: sifive_u: Update PLIC hart
 topology configuration string
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

With heterogeneous harts config, the PLIC hart topology configuration
string are "M,MS,.." because of the monitor hart #0.

Suggested-by: Fabien Chouteau <chouteau@adacore.com>
Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

 hw/riscv/sifive_u.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 206eccc..b235f29 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -372,10 +372,11 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
     plic_hart_config = g_malloc0(plic_hart_config_len);
     for (i = 0; i < ms->smp.cpus; i++) {
         if (i != 0) {
-            strncat(plic_hart_config, ",", plic_hart_config_len);
+            strncat(plic_hart_config, "," SIFIVE_U_PLIC_HART_CONFIG,
+                    plic_hart_config_len);
+        } else {
+            strncat(plic_hart_config, "M", plic_hart_config_len);
         }
-        strncat(plic_hart_config, SIFIVE_U_PLIC_HART_CONFIG,
-                plic_hart_config_len);
         plic_hart_config_len -= (strlen(SIFIVE_U_PLIC_HART_CONFIG) + 1);
     }
 
-- 
2.7.4



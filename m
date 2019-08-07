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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE57C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 07:47:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF3AC22BEB
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 07:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMH7W6qw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF3AC22BEB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvGfB-0002s0-0u
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 03:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36468)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvGdm-0000vs-7G
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:45:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvGdh-000824-KT
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:45:44 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43738)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hvGdg-000801-Kc; Wed, 07 Aug 2019 03:45:41 -0400
Received: by mail-pl1-x642.google.com with SMTP id 4so32482411pld.10;
 Wed, 07 Aug 2019 00:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=wTN0AJDzcERVkn+yvVdNI7HBH2sovcZsKQNHe872tF4=;
 b=XMH7W6qwjpSSKOl150eRcDqd4aHYQw+VdTaQhelobpvqSoBc76DzJ57nS+xY29n7bv
 pwFAmg6uGVT6WGkLBHCmYoWVUjiNOOVE8Fe6tnodjmdJToUzeTqB7oAMJez1Ia0Nx2Su
 G5kvoSqcNeXyTWXNNlGNoyGTijHxcy4LZI5EHzyUgcQEG3HlHpphoFKIFchvcg0cujqn
 yfRldpZ1iV/mc0BLgxsq7Kcb+kMjS46KTBB/TuwQp9zeb7YhdGwNtEVit0rJUv0Tktst
 q3MTyyoS0/r3mQGIY+OWD2vOPOhnj6+5W4ktzgX5mewNYFN045RW5xY3WkRZXIdr4mR8
 eVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=wTN0AJDzcERVkn+yvVdNI7HBH2sovcZsKQNHe872tF4=;
 b=oEhfzJvJa0bT+p9NfAJhJZvrYRXafnJFcC3RfpG/94YCDGks8CXVWa/8CJqnP4/pQO
 tZLjWyOt6lEP9KwQpP7PeaT2uOuYgFAchU0MRcF0l0nsRxKn0ZIYQHXx9cwVYJeCPF6b
 lePmOo7Z5k2Ya98cyaQ2vJnoNdw+N7XNi3kZLaGpsyXnoFYF10FbsnnwZ8oTKBFn5KOe
 CWw9wk5BCSJyBjr5cq4htFy713Z8RR3uGqQ+yYm3vDAFrD17slGxpHy3ReuKjHPySHTU
 SbPwNRj3nsrVUYE/g1xz7GAldgy4BeM482UaJdg8gQhhM3lQWWhKt9GNLrZt1dBhHPTR
 MQMA==
X-Gm-Message-State: APjAAAVhlPcDTxVvTB6iD6Ot/DytLeNPqsZ5OJMOZz1Z0lf1MqLaNDfh
 FBBHribNqTCuFOQPt6VgOOI=
X-Google-Smtp-Source: APXvYqxxt2NFe5K+T0zQPxKtv3EyjhEN8m5SdIDCdU0hwNCX15mXWinwA8Umm3MBuizWCHlQtxCcjw==
X-Received: by 2002:a65:49cc:: with SMTP id t12mr6113507pgs.83.1565163934781; 
 Wed, 07 Aug 2019 00:45:34 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id l44sm20154449pje.29.2019.08.07.00.45.33
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Wed, 07 Aug 2019 00:45:34 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Wed,  7 Aug 2019 00:45:00 -0700
Message-Id: <1565163924-18621-5-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565163924-18621-1-git-send-email-bmeng.cn@gmail.com>
References: <1565163924-18621-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v2 04/28] riscv: hart: Extract hart realize to
 a separate routine
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

Currently riscv_harts_realize() creates all harts based on the
same cpu type given in the hart array property. With current
implementation it can only create symmetric harts. Exact the
hart realize to a separate routine in preparation for supporting
heterogeneous hart arrays.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

Changes in v2: None

 hw/riscv/riscv_hart.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index ca69a1b..3dd1c6a 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -37,26 +37,33 @@ static void riscv_harts_cpu_reset(void *opaque)
     cpu_reset(CPU(cpu));
 }
 
+static void riscv_hart_realize(RISCVHartArrayState *s, int hart,
+                               char *cpu_type, Error **errp)
+{
+    Error *err = NULL;
+
+    object_initialize_child(OBJECT(s), "harts[*]", &s->harts[hart],
+                            sizeof(RISCVCPU), cpu_type,
+                            &error_abort, NULL);
+    s->harts[hart].env.mhartid = hart;
+    qemu_register_reset(riscv_harts_cpu_reset, &s->harts[hart]);
+    object_property_set_bool(OBJECT(&s->harts[hart]), true,
+                             "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+}
+
 static void riscv_harts_realize(DeviceState *dev, Error **errp)
 {
     RISCVHartArrayState *s = RISCV_HART_ARRAY(dev);
-    Error *err = NULL;
     int n;
 
     s->harts = g_new0(RISCVCPU, s->num_harts);
 
     for (n = 0; n < s->num_harts; n++) {
-        object_initialize_child(OBJECT(s), "harts[*]", &s->harts[n],
-                                sizeof(RISCVCPU), s->cpu_type,
-                                &error_abort, NULL);
-        s->harts[n].env.mhartid = n;
-        qemu_register_reset(riscv_harts_cpu_reset, &s->harts[n]);
-        object_property_set_bool(OBJECT(&s->harts[n]), true,
-                                 "realized", &err);
-        if (err) {
-            error_propagate(errp, err);
-            return;
-        }
+        riscv_hart_realize(s, n, s->cpu_type, errp);
     }
 }
 
-- 
2.7.4



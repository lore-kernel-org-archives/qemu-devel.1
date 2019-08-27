Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B3AC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:14:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53C522070B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uq+EV8N1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C522070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52509 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2dB5-0002Nr-14
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 11:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46941)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i2cwS-0003On-1g
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:59:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i2cwO-0003ow-9E
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:59:26 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:38206)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i2cwL-0003bU-CK; Tue, 27 Aug 2019 10:59:21 -0400
Received: by mail-pf1-x443.google.com with SMTP id o70so14292415pfg.5;
 Tue, 27 Aug 2019 07:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=d7us2fu3ANyV0m5Az+EJmBw0pv/vpKhnOtU+MafJ4Gw=;
 b=uq+EV8N1IlJV9bRL7iLPiVLeUBJGzU4ZDSAZrtKNNVt4nD6Wh5w/CZ5/KOtzVRfsnQ
 qwYnxLuYyxaHhCrYDOq9zOqHhqH7Slmr3K1rBxtbK/9WugxZcyMqDs0vxMRkzEDhNrZY
 kHaER/02xdsoMg6GMFtSa/CWHZCZwm8HcFP4hvcMv6adkiYJrkLex2BKFd3MdygB0WUu
 uvIVavGFTKdrn5OOYvYpbJ71TwENKDYbq0YYf2TviOLHvpAbWELvmfvxTOQhIU4A1dn/
 i28HVnrczu85nstJ/iOvKyzm6jiCWmfJ6faHZqvHhS1cPmy2bXJD04AC/1TaDR9T0CVE
 YcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=d7us2fu3ANyV0m5Az+EJmBw0pv/vpKhnOtU+MafJ4Gw=;
 b=HwkJrBkrb9xGtt6AbG8xnxKv8QlFBM53ORxWUv9EoXMpN6Cy8Vydy6jfsHAqFiMmp/
 KWYEBU/YDwo3rlZBWYLyWrzu9AzJeXM/f72FKsprxZNikOw6jLfh3QXi5sSF8Xcrc23H
 LU3Bq4szXRTTTkupAc8UB6GKATssueqfadn1WizVJ0z9rl310MbUP0HtIxXjgBL/DAkj
 JjNGoezxQkYSZle1PfVVFvNBqqFv4Yghdad4H2U2g3rGRd1EfalfplpsuHv8xTCNqh3X
 qxHSZjmf26yiw0kYhWyfG9+MbDJ0NgM8RSA+DcdppKFRQe+BaYV9HpQMQ2gaxIPfOHwJ
 FTmA==
X-Gm-Message-State: APjAAAWFUlVKqKrwF73ntxIkdTrLKQOHn2XlsRLCBzty1wTM0oGH9EQ5
 Wt/qzDtwJsaxGr7pNzDx1Oc=
X-Google-Smtp-Source: APXvYqwOylZlWtK6LxsNDbmSpUoQhUeW0iJgmOuiN1XMnDQgc3DjafD11YlT9v0LikmGxM9trpmmEQ==
X-Received: by 2002:a62:ee0e:: with SMTP id e14mr10365737pfi.31.1566917941905; 
 Tue, 27 Aug 2019 07:59:01 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id j15sm14839344pfr.146.2019.08.27.07.59.00
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Tue, 27 Aug 2019 07:59:01 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Tue, 27 Aug 2019 07:58:24 -0700
Message-Id: <1566917919-25381-16-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1566917919-25381-1-git-send-email-bmeng.cn@gmail.com>
References: <1566917919-25381-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v6 15/30] riscv: hart: Add a "hartid-base"
 property to RISC-V hart array
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

At present each hart's hartid in a RISC-V hart array is assigned
the same value of its index in the hart array. But for a system
that has multiple hart arrays, this is not the case any more.

Add a new "hartid-base" property so that hartid number can be
assigned based on the property value.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

---

Changes in v6:
- use s->hartid_base directly, instead of an extra variable

Changes in v5: None
Changes in v4:
- new patch to add a "hartid-base" property to RISC-V hart array

Changes in v3: None
Changes in v2: None

 hw/riscv/riscv_hart.c         | 7 ++++---
 include/hw/riscv/riscv_hart.h | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index 9deef869..7cfc835 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -27,6 +27,7 @@
 
 static Property riscv_harts_props[] = {
     DEFINE_PROP_UINT32("num-harts", RISCVHartArrayState, num_harts, 1),
+    DEFINE_PROP_UINT32("hartid-base", RISCVHartArrayState, hartid_base, 0),
     DEFINE_PROP_STRING("cpu-type", RISCVHartArrayState, cpu_type),
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -37,7 +38,7 @@ static void riscv_harts_cpu_reset(void *opaque)
     cpu_reset(CPU(cpu));
 }
 
-static void riscv_hart_realize(RISCVHartArrayState *s, int idx,
+static void riscv_hart_realize(RISCVHartArrayState *s, int idx, uint32_t hartid,
                                char *cpu_type, Error **errp)
 {
     Error *err = NULL;
@@ -45,7 +46,7 @@ static void riscv_hart_realize(RISCVHartArrayState *s, int idx,
     object_initialize_child(OBJECT(s), "harts[*]", &s->harts[idx],
                             sizeof(RISCVCPU), cpu_type,
                             &error_abort, NULL);
-    s->harts[idx].env.mhartid = idx;
+    s->harts[idx].env.mhartid = hartid;
     qemu_register_reset(riscv_harts_cpu_reset, &s->harts[idx]);
     object_property_set_bool(OBJECT(&s->harts[idx]), true,
                              "realized", &err);
@@ -63,7 +64,7 @@ static void riscv_harts_realize(DeviceState *dev, Error **errp)
     s->harts = g_new0(RISCVCPU, s->num_harts);
 
     for (n = 0; n < s->num_harts; n++) {
-        riscv_hart_realize(s, n, s->cpu_type, errp);
+        riscv_hart_realize(s, n, s->hartid_base + n, s->cpu_type, errp);
     }
 }
 
diff --git a/include/hw/riscv/riscv_hart.h b/include/hw/riscv/riscv_hart.h
index 0671d88..1984e30 100644
--- a/include/hw/riscv/riscv_hart.h
+++ b/include/hw/riscv/riscv_hart.h
@@ -32,6 +32,7 @@ typedef struct RISCVHartArrayState {
 
     /*< public >*/
     uint32_t num_harts;
+    uint32_t hartid_base;
     char *cpu_type;
     RISCVCPU *harts;
 } RISCVHartArrayState;
-- 
2.7.4



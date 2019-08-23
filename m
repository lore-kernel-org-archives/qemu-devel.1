Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AB0C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 05:32:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 948442166E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 05:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6T3h/o6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 948442166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i12BV-0008Rk-6Q
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 01:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i11rL-0004BK-Fn
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 01:11:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i11rK-0002cs-3l
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 01:11:35 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:34258)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i11rJ-0002cE-SD; Fri, 23 Aug 2019 01:11:34 -0400
Received: by mail-pf1-x443.google.com with SMTP id b24so5670181pfp.1;
 Thu, 22 Aug 2019 22:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=rK6bQ2zniUIO/z/SkibqxB2eBEsSw1r14Ty3qHlu68A=;
 b=Q6T3h/o6JqqholhBicwIdytBs4/icEqyy8+OADGdIwcI70RVmfHFcthWBxY7wsC5MB
 WnPNBVpzUXNcXdXWIcb9rqVXgpjYrCFtGVni1HTEo363J/IUYcOq7gHwSmZ7krddBL9K
 GryIR2co9afZUO8AgXMsm4MEQdmTpEoNh6o5pD0LKHrG2Rs/bPhOwFNTTTxKZD5ifglU
 nWZRVJNf9uQlsLdcWMtc5F43u6YhN9nvuCXXqiDxWFwiKrLvwhVBd6NdUszX15NV/aVw
 pJxbvIoLioahth1uH5uQ5iRosx3zhcV9dBZ/73Oq0h6cyfxSVPBr2fY5yp6fzptqiDYD
 mZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=rK6bQ2zniUIO/z/SkibqxB2eBEsSw1r14Ty3qHlu68A=;
 b=G3zVn8IJ8iWuyCWDhxaUj70ir9x/dCCAmEkX6KDE7QoV2B/zkMi0xyzHEp+mFbTq2L
 ekCnya4BXMR/ZSqrb8vR79i3JLvl24S+9cJ7s7p00uNtQ2jDRaPKCBbYdVQlp+GQTStx
 DJf2nPeYOgayuedm7pru1qfcOlt2WJlpmL5IXafEc0BtoB7hbkZwlZUU6cbG9wwwOmaD
 F+dQQG4TIWicL7pibMOVEQMfHXNGzGXvgF6NRfGsMsjFf6PNw6EETVfg8IQcPr81LyQ3
 37/RV2ckLhY5adAUGiJMndSof0+c1nGAunaudEva0ydxD5z0ZtXGqKmyAAlGgjm7BmV2
 Ac+A==
X-Gm-Message-State: APjAAAXEMzLEixrrA1M5TP541gzipqjfIav0XuOBXD3N/gqp/B7CPCHY
 0IXNCTULATXN3OBpbKIt6XQ=
X-Google-Smtp-Source: APXvYqzDnqEYakEQNaRge7K9WVN3k6nOYPB08t/A0GpuKdXsxApDdCsf52iTDd31Y//2o1+rdoygeg==
X-Received: by 2002:a63:9249:: with SMTP id s9mr2280498pgn.356.1566537092974; 
 Thu, 22 Aug 2019 22:11:32 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id v189sm1122527pfv.176.2019.08.22.22.11.31
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Thu, 22 Aug 2019 22:11:32 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Thu, 22 Aug 2019 22:10:54 -0700
Message-Id: <1566537069-22741-16-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1566537069-22741-1-git-send-email-bmeng.cn@gmail.com>
References: <1566537069-22741-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v5 15/30] riscv: hart: Add a "hartid-base"
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

Changes in v5: None
Changes in v4:
- new patch to add a "hartid-base" property to RISC-V hart array

Changes in v3: None
Changes in v2: None

 hw/riscv/riscv_hart.c         | 8 +++++---
 include/hw/riscv/riscv_hart.h | 1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index 9deef869..52ab86a 100644
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
@@ -58,12 +59,13 @@ static void riscv_hart_realize(RISCVHartArrayState *s, int idx,
 static void riscv_harts_realize(DeviceState *dev, Error **errp)
 {
     RISCVHartArrayState *s = RISCV_HART_ARRAY(dev);
+    uint32_t hartid = s->hartid_base;
     int n;
 
     s->harts = g_new0(RISCVCPU, s->num_harts);
 
     for (n = 0; n < s->num_harts; n++) {
-        riscv_hart_realize(s, n, s->cpu_type, errp);
+        riscv_hart_realize(s, n, hartid + n, s->cpu_type, errp);
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



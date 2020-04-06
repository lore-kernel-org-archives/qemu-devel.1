Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9F2C2BA1B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:13:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8250C206B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZB6nQBo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8250C206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLWFN-0005m9-N3
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 14:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36475)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrM-0002Ne-4N
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrK-0003JE-2n
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:31 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:33621)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrJ-0003IJ-Sj; Mon, 06 Apr 2020 13:48:30 -0400
Received: by mail-wr1-x42a.google.com with SMTP id a25so549654wrd.0;
 Mon, 06 Apr 2020 10:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7dngg6q086SdAwClXoi/Rsl8HHPolX2hkbDutRMMkyU=;
 b=mZB6nQBoF7efgVNMW6coPxbXImIagNrUHXbQwGp6/FNiQ/5CCYxuTz7c1XxGDfCj6/
 XMQbOknKGcCIOajrDdG+ZxqKSaTuVh1G3AD/ZObLEjzvgENtFr1iRHC4jrF7WSEePrJE
 xo7z0NgUfmpQz8dwZSBqmJlysc1SwbG42r3Z4zVcHDX0IeCBQbbreWJ8MMbOGjPJXS10
 kKc/C0LFp7yEc6sXT6oH+PTSrMsXWTuWgd26vu4sv+357XGStB/zWXIMmRVXWRLlPULF
 UbCLA2Zh/3gKXbBjbnptQCoK94i5LZG3u4KjQUQ0O/ymZimoPkpBOhb/wDeFA8YFS2Em
 tFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=7dngg6q086SdAwClXoi/Rsl8HHPolX2hkbDutRMMkyU=;
 b=g1ocV0JjM9kUKU9N9eSbh1a1AhJW61UYBbR/PTiHyrlM+QK09PtxWDXYapNAWuUntx
 j+Xtdh3xrmrsjtaRKF9j8zW5cNYdx2r13XHpwa/WSP2c7tgrLFkDTPNr0R4zXDAt+l+J
 JWSvzNHyRoxwgl51AWBiWRl8aYMgOPhGyfZhESw822ipvb9GbRcqiU1cFP3RFnqA29Nz
 pFAYkeHO+hqwHWVqQGFoe+j773/XaIDwTeyMHsDetn6sVVDDD8cJ6y12wysKg2G+i/xN
 ZmTT3N1erZ7G8U/TnhgsCbGpqO6kULJ8SKiEeb7JLxWFL2Qcw96wRpJ31hZ0BTvSDWy/
 5TrA==
X-Gm-Message-State: AGi0PuZ4LmbprZpj5G6qAws+hX4megCwdcBRuFT/aW3gp1Z2/iNGaCmQ
 ne+kB4SoMxjn01DWjBSAMaLvHt0SZNE=
X-Google-Smtp-Source: APiQypJwsJIZF70J5HlNv9xStNPqs1HsJ77tItLhRzphIRk3ZiqGHhG9BEtBK79ChMVy4lUndTQMQA==
X-Received: by 2002:adf:fb0a:: with SMTP id c10mr364586wrr.272.1586195308694; 
 Mon, 06 Apr 2020 10:48:28 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm364880wmc.30.2020.04.06.10.48.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:48:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-5.1 v2 31/54] hw/riscv/sifive: Add missing
 error-propagation code
Date: Mon,  6 Apr 2020 19:47:20 +0200
Message-Id: <20200406174743.16956-32-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200406174743.16956-1-f4bug@amsat.org>
References: <20200406174743.16956-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Patch created mechanically by running:

  $ spatch \
    --macro-file scripts/cocci-macro-file.h --include-headers \
    --sp-file scripts/coccinelle/use-error_propagate-in-realize.cocci \
    --keep-comments --smpl-spacing --in-place --dir hw

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/riscv/sifive_e.c |  6 +++++-
 hw/riscv/sifive_u.c | 24 ++++++++++++++++++++----
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 0be8b52147..6d4e141ff7 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -156,7 +156,11 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
     MemoryRegion *sys_mem = get_system_memory();
 
     object_property_set_bool(OBJECT(&s->cpus), true, "realized",
-                            &error_abort);
+                            &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
 
     /* MMIO */
     s->plic = sifive_plic_create(memmap[SIFIVE_E_PLIC].base,
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index e13ab34de4..b07526aba1 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -508,9 +508,17 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
     NICInfo *nd = &nd_table[0];
 
     object_property_set_bool(OBJECT(&s->e_cpus), true, "realized",
-                             &error_abort);
+                             &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     object_property_set_bool(OBJECT(&s->u_cpus), true, "realized",
-                             &error_abort);
+                             &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     /*
      * The cluster must be realized after the RISC-V hart array container,
      * as the container's CPU object is only created on realize, and the
@@ -518,9 +526,17 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
      * cluster is realized.
      */
     object_property_set_bool(OBJECT(&s->e_cluster), true, "realized",
-                             &error_abort);
+                             &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     object_property_set_bool(OBJECT(&s->u_cluster), true, "realized",
-                             &error_abort);
+                             &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
 
     /* create PLIC hart topology configuration string */
     plic_hart_config_len = (strlen(SIFIVE_U_PLIC_HART_CONFIG) + 1) *
-- 
2.21.1



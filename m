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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2FEC19759
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 07:48:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84E1F22BED
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 07:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qp6ocBe+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84E1F22BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvGgp-0006Et-Ra
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 03:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36467)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvGdm-0000vp-70
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:45:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvGdh-00082G-Lt
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:45:44 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:45768)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hvGdg-00080J-Kk; Wed, 07 Aug 2019 03:45:41 -0400
Received: by mail-pl1-x642.google.com with SMTP id y8so39496546plr.12;
 Wed, 07 Aug 2019 00:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=w8z+Z4JIG+PWumqx562TA113JQMp/d8qY1uXo2FuR58=;
 b=Qp6ocBe+A0yFSeaPRyk8LBxHpK8z53/LlVBWJlWy3hNSHNDKoaVIPqwF4XH+tZV8wW
 OPv3wqCgD8QOHddsQuhFkB4LAf20XRogfWQBW8OW/CrTiOKd6whax4M2wMZw6phNVLQL
 LzQqu9XwWZWoVvv5HKGqa1RdMk5Yl9BTvVkPErTzKNU638BtovYeEnpD9nmw3rAL9+Qf
 MJGkqTUJWQGe5SEZ674Fj50Q9F3XvdG0FIqW1Rua3nBQlVreBOEvtbBIm2N3oIIiUTuB
 7Tawy1ospEW1GgIGg8Yks/WQY5bMmrA5ry+nbJLWOl0nTVWXv+wqIOdunmy4UGofokpY
 pwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=w8z+Z4JIG+PWumqx562TA113JQMp/d8qY1uXo2FuR58=;
 b=lWquDoj9T7NFYkQq9C3bu3Vxk/bhmAP0qTJUxheLybt6iVIcwofaEiP7zdAvjKS8ZV
 72gSK/d0l30usWOSCTwgpYV8/QGkw0OjCjyuwc6U8A3GQyy/wIFNBN/dFp3b0KKwemqC
 OZyKCLxpIHRSoi4d3jfx/u8ZdfQLSwckw2DXeS/uZ36qR8zlJ1usndRf1zCHhoghuLSE
 38y/4FcNIElZ0WmzpvM+GjYKJH9ngb3jvOMd9NK0oo2vXfgXOuOIhh0NB4Jo2C7uv5Dy
 MNlD9f0BnZ8zz5pLAToUd598wyXwPhmYpkL0Ndxs+/Y1puhbjRV2NPDHCNXfJprMPbKu
 RyBQ==
X-Gm-Message-State: APjAAAXa2ovA1ZFcxuD2A0ug4Z2b5DpRuk6+sc1zNgFq+1BVyoV0F2DO
 2swaO/vgn9ltgppopG64UVk=
X-Google-Smtp-Source: APXvYqyI7/yTkpFbY00iRzjYj7OM5NbhxAL2qed5+OVOQA4LT2SCRmsJ0iSqvVINH00Uxx8Okg7cbQ==
X-Received: by 2002:a17:902:8649:: with SMTP id
 y9mr6869661plt.289.1565163935911; 
 Wed, 07 Aug 2019 00:45:35 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id l44sm20154449pje.29.2019.08.07.00.45.34
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Wed, 07 Aug 2019 00:45:35 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Wed,  7 Aug 2019 00:45:01 -0700
Message-Id: <1565163924-18621-6-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565163924-18621-1-git-send-email-bmeng.cn@gmail.com>
References: <1565163924-18621-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v2 05/28] riscv: hart: Support heterogeneous
 harts population
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

At present we only allow symmetric harts to be created. In order to
support heterogeneous harts like SiFive FU540, update hart array's
"cpu-type" property to allow cpu type to be set per hart, separated
by delimiter ",". The frist cpu type before the delimiter is assigned
to hart 0, and the second cpu type before delimiter is assigned to
hart 1, and so on.

If the total number of cpu types supplied in "cpu-type" property is
less than number of maximum harts, the last cpu type in the property
will be used to populate remaining harts.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

Changes in v2: None

 hw/riscv/riscv_hart.c | 48 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index 3dd1c6a..27093e0 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -58,13 +58,55 @@ static void riscv_hart_realize(RISCVHartArrayState *s, int hart,
 static void riscv_harts_realize(DeviceState *dev, Error **errp)
 {
     RISCVHartArrayState *s = RISCV_HART_ARRAY(dev);
-    int n;
+    char *cpu_types;
+    char *first_type, *last_type, *tmp_type;
+    int n = 0;
 
     s->harts = g_new0(RISCVCPU, s->num_harts);
 
-    for (n = 0; n < s->num_harts; n++) {
-        riscv_hart_realize(s, n, s->cpu_type, errp);
+    /* we should not touch the original s->cpu_type */
+    cpu_types = g_strdup(s->cpu_type);
+
+    /*
+     * Expect s->cpu_type property was initialized this way:
+     *
+     * "cpu-type-a": symmetric harts
+     * "cpu-type-a,cpu-type-b,cpu-type-c": heterogeneous harts
+     *
+     * For heterogeneous harts, hart cpu types are separated by delimiter ",".
+     * The frist cpu type before the delimiter is assigned to hart 0, and the
+     * second cpu type before delimiter is assigned to hart 1, and so on.
+     *
+     * If the total number of cpu types is less than s->num_harts, the last
+     * cpu type in s->cpu_type will be used to populate remaining harts.
+     */
+
+    first_type = strtok(cpu_types, ",");
+    riscv_hart_realize(s, n++, first_type, errp);
+    tmp_type = strtok(NULL, ",");
+    if (!tmp_type) {
+        /* symmetric harts */
+        for (; n < s->num_harts; n++) {
+            riscv_hart_realize(s, n, first_type, errp);
+       }
+    } else {
+        /* heterogeneous harts */
+        while (tmp_type) {
+            if (n >= s->num_harts) {
+                break;
+            }
+            riscv_hart_realize(s, n++, tmp_type, errp);
+            last_type = tmp_type;
+            tmp_type = strtok(NULL, ",");
+        }
+
+        /* populate remaining harts using the last cpu type in s->cpu_type */
+        for (; n < s->num_harts; n++) {
+            riscv_hart_realize(s, n, last_type, errp);
+        }
     }
+
+    g_free(cpu_types);
 }
 
 static void riscv_harts_class_init(ObjectClass *klass, void *data)
-- 
2.7.4



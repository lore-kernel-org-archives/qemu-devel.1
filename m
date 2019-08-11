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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7124C433FF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 08:09:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFCA3208C2
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 08:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0O2qMBw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFCA3208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwiuy-0002ZC-1j
	for qemu-devel@archiver.kernel.org; Sun, 11 Aug 2019 04:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60069)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hwisk-0005Ww-RA
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 04:07:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hwisj-0003rb-N6
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 04:07:14 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:38672)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hwisj-0003qs-Ho; Sun, 11 Aug 2019 04:07:13 -0400
Received: by mail-pf1-x441.google.com with SMTP id o70so2898769pfg.5;
 Sun, 11 Aug 2019 01:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=kXQ9PXHrDRgGhMpr4k9BgBl1iRn6bwnVpBb0I6FgVfY=;
 b=H0O2qMBwfIGgcUtyM2Yw0yXzQAwNgMGxXWxN1JcX4vNbWeM+r77CKHFOG+x0DSn6Ja
 JhK+dPxg3FU+Wx0aKYjysdTM5zIu10KxoXbFyl36qw9I6WQklhtjDvzv2b0GwZ/jfRMb
 tnkthZMuYQKUW0/UP688B/XRKwXFr393dNq/hriY7DUGan99Ir+689V3QjQhsZcO3Icm
 RLWcqh/4+bCitJIZyMaKxEJP8XHLT7vYkHIdN71Fh80VYEJP7sj8Ux4XTUOL2QI0Ayqu
 7PRg2114MX1shD9zUKal2/reWQorhutAGpi8KWrzgOtdQhQiat8HWGzGhL9jO0m+Pj/+
 NMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=kXQ9PXHrDRgGhMpr4k9BgBl1iRn6bwnVpBb0I6FgVfY=;
 b=o6FdY2FCUPH91GSa1kO9UfvQQPAS9xPO62XMWvkuknPf76OdS0pLesMJrK4CO1F+On
 rtMp8+ix8lwCwCAKcoVkJ4qyJAOHVuwQvuxIFPQO5+iPaeVtXMPZkmZf0ZOdoyZi8Tqd
 LhwJipC6dswOvfPnzzEMQLaaw5MROlY72M0be+2EK9BEc4TSYlXkIUEKnfRWny/HdM7y
 AuWMH7JrHOElvR41o4zEqjsiwofgd2/mCyqMHd+h/xWjrtsEJMffv7heovZkCsYxSoYW
 gnQbHKM0MKMIDe/V4dtWMrC3tqq1Gp3cia18gOBPKOTqmlMmJpL5R1yqTxC/1+pogikl
 SZ7g==
X-Gm-Message-State: APjAAAUCkwhqgX4Ipr6fDT5k+Kciuwuj3TZ/9pCBacjLeyQjp+1jPK35
 /u1+NQdMcOo//7tdR1rXKmg=
X-Google-Smtp-Source: APXvYqzg3C5MAgZxX0tvMQZYbL2m9J+NyeGB2/CQ28svf2O2B7yJ0ROCTmT55PPYnKIX/wX02g64BQ==
X-Received: by 2002:a17:90a:981:: with SMTP id 1mr5530323pjo.37.1565510832727; 
 Sun, 11 Aug 2019 01:07:12 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id v8sm87339107pgs.82.2019.08.11.01.07.11
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sun, 11 Aug 2019 01:07:12 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sun, 11 Aug 2019 01:06:38 -0700
Message-Id: <1565510821-3927-6-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565510821-3927-1-git-send-email-bmeng.cn@gmail.com>
References: <1565510821-3927-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v3 05/28] riscv: hart: Support heterogeneous
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

Changes in v3: None
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



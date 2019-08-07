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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F98C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 07:57:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBA8C21BE3
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 07:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvOU2b5G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA8C21BE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvGog-0000nt-0S
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 03:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36892)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvGdz-0001LE-Fh
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:46:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvGdy-0008FS-FZ
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:45:59 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:34043)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hvGdy-0008Ex-7r; Wed, 07 Aug 2019 03:45:58 -0400
Received: by mail-pl1-x642.google.com with SMTP id i2so39505839plt.1;
 Wed, 07 Aug 2019 00:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=++PxAHxQgFZf8IyF1BGk/O95LoL/ngMnCoTtc4g0wvo=;
 b=fvOU2b5G7Fn4yreeUSmOZWhPFpAb80Ab8ytG8FEdMh38P80XKIcE/OV2rt6jo4Fga6
 r5jMzKb2b3UtQGqK4FdPEgsupLJI4idFnF1hJaWBP7m+b/ilLm4v7bIRkQcaXEJ1KzMM
 dnin1pjQ5e/SiqgAoJRIs9gBKh2WfqfWzzfqi82+jcw33tuhpwTPh1hQTX+/Cu9ITH9A
 BZMOgwKzUYqIUHKqEnam1l7aY/cdQnpWgM/bOI/Lmr1vDlsx1tTGX0PjY8TzrTZ96duu
 05Z/mv71QBuD95D7/GSAEQLdnqU1zuLRGyTdl/E15U4nm64GKrQS9sP013Pa2t6zXr6D
 CqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=++PxAHxQgFZf8IyF1BGk/O95LoL/ngMnCoTtc4g0wvo=;
 b=q7wbSlK6fVZhPxFNbi/wzOHrFoMzUDoXt6GceIEdlGhGf6JpKOeZdFY6K+82Dmb4DB
 6Xrgc00ZxIOeRCr4EPbl1bYb+7HpxQ/K71acxJ8a3ZIIm/EivVzRiDTfIy31GbfRd0sA
 KtyhOxeD/bErSlFFKwWPgfrkAmuiXqUGVEyHlL+Krm7wK/2QgJDVJ0/gF+XyFYJoKdXN
 bNkh39v18LtJYM3A+3IjIh8E6D6b0YgEpRuIl1RjbG2eSbcA9X0xLmPtMj5+tIClyHFJ
 4aVCr/pxmNVb9c6SZp4LG5bnzumFUYVH6heGwEY0MbXgCnhtNVxOeuKkMGm+iM5Ae+xF
 0RDg==
X-Gm-Message-State: APjAAAXC/YfycallARaUBmku5Ifw3jH1CxdCmyhVHnj6l/9+qcKlqmSs
 I7KlRJuq325oTk+E1Esj1fM=
X-Google-Smtp-Source: APXvYqyr1PduyJmCzUkySTrPTWD9ZFg9tqHu8eYkwq7q7kA4lOfth/MNZvtCfba5wM6AEnuyRO2RZQ==
X-Received: by 2002:a17:902:7791:: with SMTP id
 o17mr7040085pll.27.1565163957541; 
 Wed, 07 Aug 2019 00:45:57 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id l44sm20154449pje.29.2019.08.07.00.45.56
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Wed, 07 Aug 2019 00:45:56 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Wed,  7 Aug 2019 00:45:20 -0700
Message-Id: <1565163924-18621-25-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565163924-18621-1-git-send-email-bmeng.cn@gmail.com>
References: <1565163924-18621-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v2 24/28] riscv: sifive_u: Support loading
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
---

Changes in v2: None

 hw/riscv/sifive_u.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index ce6eba5..30e6c43 100644
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



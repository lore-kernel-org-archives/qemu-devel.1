Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD7AC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 05:47:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75C7522CF7
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 05:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFckUj9b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75C7522CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i12Pp-0007zo-Do
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 01:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45306)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i11rb-0004Xk-U6
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 01:11:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i11ra-0002qY-Cw
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 01:11:51 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:45734)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i11ra-0002q0-6j; Fri, 23 Aug 2019 01:11:50 -0400
Received: by mail-pf1-x442.google.com with SMTP id w26so5629154pfq.12;
 Thu, 22 Aug 2019 22:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=4/fBrUSZM2vbDjvLLKFAmPyvCRfr5pCZu6f1f6oCKKg=;
 b=UFckUj9btkM0rqXR2PcUt44WVYMZGbnICfNBAtu5ZYKXuKngL/PAo7la3IIK5n0COc
 lfmD/G1bQtpOPqg1RhAhLU9nJSuv8v5OaKZKx/ftLgbGQiZRiU/RB00DXSbeAcjsTSpW
 Xf69DGv7+RvFoawZ4prfx62xBML66LBzkdBhWW8V0WUBVUCrkxndlQ3LJwSh44tfD4hQ
 V61aW0D4GaWOyNfMWwwxNXS+CS+YW8200YLC2W7MsEhn2DMcWK1rZCiOUAevjzexLVyG
 z1KWL//hej2MsOQPs+AoowsJ/vGBS+O/d/PmFtJqCmrnzyrC56WD0dMVfbfMX97B16S2
 aRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=4/fBrUSZM2vbDjvLLKFAmPyvCRfr5pCZu6f1f6oCKKg=;
 b=GR5Kcj/fG11v39LvxfOzofHgUIbvRaNSEtNlvxRMO6spCWufpINc2xTvueUBCja6t3
 Rk4163y20jNAv5XvuHf8tan/pdSgzdILS6k0hirqoJ8faPb1ZG59GyR83ksPNsfRi1z7
 vri+ai8XWhohzwQ254IWyeras9Jr6iqWxuM41FJ9hNKhxWE4fogscYcD9vX8WaaL3NkM
 uODdy648ibN5DOSyZldfKFGbF0wjZGNU+C43o/2KHi1mz0PfgacR8ZXZphhEPHGaz9/z
 TfQ/0Fbx9uIK6VuDTJT0VoOqgWdIKkRMN6n3pilLQWdFCKWHc9zm7fXcjWSdtZUh1xyl
 hrEg==
X-Gm-Message-State: APjAAAU/c2JqStvgLkR8XGrMGiFq7ylUxLqDlRviEkriD9SSkabrzwK/
 YGfU3oLKjYorj6k6cpyXV64=
X-Google-Smtp-Source: APXvYqxHmuXhoMyIKBVTADJoFNU93+MVlgM0m8WfqFtMqrhiyKMYbZl0DbGOFOHGMZHOdozHrKJiGQ==
X-Received: by 2002:a65:50c5:: with SMTP id s5mr2361462pgp.368.1566537109438; 
 Thu, 22 Aug 2019 22:11:49 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id v189sm1122527pfv.176.2019.08.22.22.11.48
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Thu, 22 Aug 2019 22:11:48 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Thu, 22 Aug 2019 22:11:09 -0700
Message-Id: <1566537069-22741-31-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1566537069-22741-1-git-send-email-bmeng.cn@gmail.com>
References: <1566537069-22741-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v5 30/30] riscv: sifive_u: Update model and
 compatible strings in device tree
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

This updates model and compatible strings to use the same strings
as used in the Linux kernel device tree (hifive-unleashed-a00.dts).

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 hw/riscv/sifive_u.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 1140c38..fae19fe 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -97,8 +97,9 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
         exit(1);
     }
 
-    qemu_fdt_setprop_string(fdt, "/", "model", "ucbbar,spike-bare,qemu");
-    qemu_fdt_setprop_string(fdt, "/", "compatible", "ucbbar,spike-bare-dev");
+    qemu_fdt_setprop_string(fdt, "/", "model", "SiFive HiFive Unleashed A00");
+    qemu_fdt_setprop_string(fdt, "/", "compatible",
+                            "sifive,hifive-unleashed-a00");
     qemu_fdt_setprop_cell(fdt, "/", "#size-cells", 0x2);
     qemu_fdt_setprop_cell(fdt, "/", "#address-cells", 0x2);
 
-- 
2.7.4



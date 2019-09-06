Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F228EC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:22:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC63D206CD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KluVQm3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC63D206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6H0G-00068r-Eb
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 12:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56109)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i6GyL-00048F-Jo
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:20:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i6GyK-00044n-Ai
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:20:29 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:40442)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i6GyK-00044N-45; Fri, 06 Sep 2019 12:20:28 -0400
Received: by mail-pl1-x633.google.com with SMTP id y10so3370316pll.7;
 Fri, 06 Sep 2019 09:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=7GIiyE3SAOS6fYnD3fLSNVNt0c9LXuzQpRbP8Ek/5eg=;
 b=KluVQm3yZ+xXIzLSRruDXtjJul459RQenHpz7iI4ufpkR5/6/oly35nqaUo/WWMwVI
 8LHe6a2GMMbD5D55UZUL3JqZqFvkJtgMN3B4rntgCElkDFU3n2ZIMcPkKKVXa3UW3TNo
 Nut4wuF1NqMAynfQO2Lg1JtJF6F2NNdU1qtFlDmCBi0WGuO6ex4++MsU7dDEXMBdYzZV
 eWqDTYcZmdfl0/h7iyEBM7qn2rjZ1WcG4Qg4dLi1yvPcOnpzXNkUPFGO1cd5FrjXGOYY
 kFpmH0mNf5qwoYr4h6NLVoqsvSz1m7jVhzqlJtxy3JfVEaVMdvJUIytK0eGUh6+W2BSG
 huiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=7GIiyE3SAOS6fYnD3fLSNVNt0c9LXuzQpRbP8Ek/5eg=;
 b=V3KIUcLnZIAnLmniDuHFE5vo6qeLxkX7ycRqUH1yG6aElPfVsDd9i5Xf4odFzZflTv
 6gutPY0rRFr7Yr0IiaEomb8UmfeAyAbAnFn2QFHUgV6qvWxN7RSLLaaY5+EKPPUzh8zS
 nEANP9OiJQUsn5a3JHuIJtKGS+REA/fHGtErWX4jQP0ANjXnNAxY1qQZkKXjW7L2DOZk
 DBIXwvcHwAPLRNkKPsko5cra16KzkRNhF0LpfJaGJgkle9uIvZzp1/qaRpG9XL3aimKC
 sd/PDWkFCO/JGTls4WmezaLYD67Tpy0gpBYV+gkSew30vxG0vSZMxGjq3s5NZR4xcXWM
 QaTA==
X-Gm-Message-State: APjAAAXFyhDIiFxzU5EcO02NEz4dqrkh9wHnpTz53f8+z8QzO2iusa8I
 EZjsG8P9tMZhYAag4NyiHVouFQdd
X-Google-Smtp-Source: APXvYqxEuqh/eckaPyknylRhjcwB5HGIC6/TtPagEdpELGghnlkfz0gerYjB1umUJEPNfkCQUUC3zA==
X-Received: by 2002:a17:902:930b:: with SMTP id
 bc11mr869118plb.166.1567786827323; 
 Fri, 06 Sep 2019 09:20:27 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id f89sm11146228pje.20.2019.09.06.09.20.26
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Fri, 06 Sep 2019 09:20:26 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Fri,  6 Sep 2019 09:19:48 -0700
Message-Id: <1567786819-22142-2-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1567786819-22142-1-git-send-email-bmeng.cn@gmail.com>
References: <1567786819-22142-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::633
Subject: [Qemu-devel] [PATCH v8 01/32] riscv: hw: Remove duplicated
 "hw/hw.h" inclusion
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

Commit a27bd6c779ba ("Include hw/qdev-properties.h less") wrongly
added "hw/hw.h" to sifive_prci.c and sifive_test.c.

Another inclusion of "hw/hw.h" was later added via
commit 650d103d3ea9 ("Include hw/hw.h exactly where needed"), that
resulted in duplicated inclusion of "hw/hw.h".

Fixes: a27bd6c779ba ("Include hw/qdev-properties.h less")
Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

---

Changes in v8:
- newly included in v8 to ease patch inter dependencies

 hw/riscv/sifive_prci.c | 1 -
 hw/riscv/sifive_test.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/hw/riscv/sifive_prci.c b/hw/riscv/sifive_prci.c
index 9837b61..562bc3d 100644
--- a/hw/riscv/sifive_prci.c
+++ b/hw/riscv/sifive_prci.c
@@ -19,7 +19,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
 #include "target/riscv/cpu.h"
diff --git a/hw/riscv/sifive_test.c b/hw/riscv/sifive_test.c
index afbb3aa..3a14f9f 100644
--- a/hw/riscv/sifive_test.c
+++ b/hw/riscv/sifive_test.c
@@ -19,7 +19,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
 #include "target/riscv/cpu.h"
-- 
2.7.4



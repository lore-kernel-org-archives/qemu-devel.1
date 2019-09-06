Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB67DC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:28:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6D84206CD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEm0p+Dd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6D84206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6H61-00052I-8z
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 12:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56303)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i6GyU-0004J1-L6
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:20:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i6GyT-0004GH-3z
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:20:38 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:44756)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i6GyS-0004Fm-Tl; Fri, 06 Sep 2019 12:20:37 -0400
Received: by mail-pl1-x644.google.com with SMTP id k1so3367824pls.11;
 Fri, 06 Sep 2019 09:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=8U6uJk2YYEIbUrnqIfm1YeIlqiz3yqhekiDNmTgLrkQ=;
 b=bEm0p+DdMERDG6ktN6TdJbsOQP+N5MK5OKF72Ga4gdAHrHnFGbBESz8decOKGkAQiJ
 HWrMwxj+/CRKYFLpmbUuIblhIrM4m6i81oVXqpMwcJDFuHxGBCJ3N/hzvQ0Zf9qrG2G5
 Izo/whguNWHuIIArUjXH+N9gtwav5U/hlBD5xrdsowFcHaUQu9l11XxZadjATBbE9p3u
 0YIRcnVmx+tIFAHxQNjquwsUc61G9+bqVBFk1dMHLkGT87j9p2FyQY6lEoC/y9rQsczL
 s2eaOcjrGRb41M5vX+5oR6s91B8eyv6RRGzYL4y8WUyam2KGO+fIMEM6EhHshx922G+d
 hCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=8U6uJk2YYEIbUrnqIfm1YeIlqiz3yqhekiDNmTgLrkQ=;
 b=TEVR1xDZ/MhRPvZlyP93cM4icDmFDWOqq7OJRade9LlVU+M0uSDHhJSILbtQggAk5Q
 OHJS4enzHM9C5wXTeUFNcr5Q6t1Rygd2Xx1cEkx/p8g6pMDnr0ij3W+vgv1+7qhaabxN
 jUhBpjKmPgupsILFWj9/UcVp4nNp/HwvIJ9Bkp99cqQaCKDVAoiEnSQisCFBlhzUhSpX
 CAQ+bdW+jDPpUu5S2oroNDC8z3wwv2kmkpu+AplwmrQTn8mxH9OZk48KwViH/KrhXEbn
 PjPwqP/vo69xeMsv6VLaYoY3rwF0uwykL7g4mYDVPOHnlUjYtAyWF8cIIwBpM1PwOdcv
 6AhQ==
X-Gm-Message-State: APjAAAU8HrLARealisRnkDEjIHDFGJCtIdtysLDjlPdL8AbKPxDVxIbc
 pw2N43F4g6ixcVbKzJiu9zQ=
X-Google-Smtp-Source: APXvYqzY+ihosG5caGfVQqWe2/tnhZE2oWab3zkLvGmx/BCA2pL7i1GmxhE4+imlZ7o1HQQnTI5Z8Q==
X-Received: by 2002:a17:902:bc47:: with SMTP id
 t7mr9933485plz.329.1567786836087; 
 Fri, 06 Sep 2019 09:20:36 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id f89sm11146228pje.20.2019.09.06.09.20.35
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Fri, 06 Sep 2019 09:20:35 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Fri,  6 Sep 2019 09:19:57 -0700
Message-Id: <1567786819-22142-11-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1567786819-22142-1-git-send-email-bmeng.cn@gmail.com>
References: <1567786819-22142-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v8 10/32] riscv: sifive_u: Remove the
 unnecessary include of prci header
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

sifive_u machine does not use PRCI as of today. Remove the prci
header inclusion.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---

Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 hw/riscv/sifive_u.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 32d8cee..2947e06 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -38,7 +38,6 @@
 #include "hw/riscv/sifive_plic.h"
 #include "hw/riscv/sifive_clint.h"
 #include "hw/riscv/sifive_uart.h"
-#include "hw/riscv/sifive_prci.h"
 #include "hw/riscv/sifive_u.h"
 #include "hw/riscv/boot.h"
 #include "chardev/char.h"
-- 
2.7.4



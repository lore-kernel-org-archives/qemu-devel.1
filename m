Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA37C2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 21:26:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDD8A21835
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 21:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ybzpN1QY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDD8A21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inUSb-0006ql-QS
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 16:26:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45430)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1inURT-0005Wj-Os
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 16:25:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1inURS-0004Aq-MU
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 16:25:11 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:37727)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1inURS-00046R-GT
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 16:25:10 -0500
Received: by mail-pj1-x1043.google.com with SMTP id m13so5177976pjb.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2020 13:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=33+25pCQpg6Hcw5lhcs23DCIrdwQ3CmnW+6SiuGtsrE=;
 b=ybzpN1QYXJMeROyv/UGiQnjnk4FIQN8xg4ffeqoW7V3XbLRhuhqc70Y8tXSs86uCmZ
 JGQBZrgvTcusQhDqnpDM5IIFUMnngg1mxcO7jiu7AndMF58opEyQl6iLB9F7+XLTO6SD
 AhfSUzvbjIeTO2N3QQW1M133tlTNU6+QE+i+3iH6Ky7V8fDSIqnvBm8sZCGrob6Gwt6L
 WgYgq00s5qndYlfPpXpa6se1cz9dzbsGK4sIroPJC59OAqMDZ24ysTwEHkN8Aqn/nZag
 Ce7mk+uzASmeRh8BNqhlifjolMdqyRYZp9LCGeaMx3RxO1nVoUGWq4MR1RIvnqlKx3r+
 tu+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=33+25pCQpg6Hcw5lhcs23DCIrdwQ3CmnW+6SiuGtsrE=;
 b=n8B+aj6JmYzVGQHJq2h/vhVt6tVNds/QdU6/fQt5P9Rm3WPaSYibdxTxGz7fhTOmHp
 N9RhWtdXAjNjk8SQkBNofw3CrHs0h2PjKe4nDYkrmFRaqRTNg4SJd9RIIsKFF9mk5j2F
 SKPdMlNCSiRAn8cZWxZqPi3WezfbOt+Thbbiwvv0mdBRMqB9ahwA6dx69sEQ4Splqitq
 QXqdBWYhvvRnY1aeznqlBr4RQ47SLRMnD7haAKN+c42fNynK83afYhdaHnBlmVG0RapK
 qRfFN6WP7vACtHvg2WzpYFO/DrWvugP/t3oJZpi1pcWHP+nv8hrwpjE90/K09abs8L7R
 byuA==
X-Gm-Message-State: APjAAAXnx0tUj8PRHswYCiZTbAsqA51uvyw53hZCZIun5ZL2B2h+nvj9
 gs+2veOX5rK9W6cE/Ze3Tn18L14DYUc58A==
X-Google-Smtp-Source: APXvYqxG4SpIPUFlQrVusJZ7d6yctWHwsAP+yk0cOQjK7TX4ushFijMCkRGU5of0bHYKNsNXviiq0w==
X-Received: by 2002:a17:902:b097:: with SMTP id
 p23mr94184094plr.45.1578086708991; 
 Fri, 03 Jan 2020 13:25:08 -0800 (PST)
Received: from localhost.localdomain
 (59-100-211-22.bri.static-ipl.aapt.com.au. [59.100.211.22])
 by smtp.gmail.com with ESMTPSA id c15sm16668907pja.30.2020.01.03.13.25.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jan 2020 13:25:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] capstone: Update to next
Date: Sat,  4 Jan 2020 07:24:58 +1000
Message-Id: <20200103212500.14384-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200103212500.14384-1-richard.henderson@linaro.org>
References: <20200103212500.14384-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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

Update to aaffb38c44fa.  Choose this over the "current" 4.0.1 tag
because next now includes the s390x z13 vector opcodes, and also
the insn tables are now read-only.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 Makefile  | 1 +
 capstone  | 2 +-
 configure | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 6b5ad1121b..12e129ac9d 100644
--- a/Makefile
+++ b/Makefile
@@ -499,6 +499,7 @@ dtc/%: .git-submodule-status
 # Remove all the extra -Warning flags that QEMU uses that Capstone doesn't;
 # no need to annoy QEMU developers with such things.
 CAP_CFLAGS = $(patsubst -W%,,$(CFLAGS) $(QEMU_CFLAGS))
+CAP_CFLAGS += -I$(SRC_PATH)/capstone/include
 CAP_CFLAGS += -DCAPSTONE_USE_SYS_DYN_MEM
 CAP_CFLAGS += -DCAPSTONE_HAS_ARM
 CAP_CFLAGS += -DCAPSTONE_HAS_ARM64
diff --git a/capstone b/capstone
index 22ead3e0bf..aaffb38c44 160000
--- a/capstone
+++ b/capstone
@@ -1 +1 @@
-Subproject commit 22ead3e0bfdb87516656453336160e0a37b066bf
+Subproject commit aaffb38c44fa58f510ba9b6264f7079bfbba4c8e
diff --git a/configure b/configure
index 940bf9e87a..de96bfe017 100755
--- a/configure
+++ b/configure
@@ -5062,7 +5062,7 @@ case "$capstone" in
       git_submodules="${git_submodules} capstone"
     fi
     mkdir -p capstone
-    QEMU_CFLAGS="$QEMU_CFLAGS -I\$(SRC_PATH)/capstone/include"
+    QEMU_CFLAGS="$QEMU_CFLAGS -I\$(SRC_PATH)/capstone/include/capstone"
     if test "$mingw32" = "yes"; then
       LIBCAPSTONE=capstone.lib
     else
-- 
2.20.1



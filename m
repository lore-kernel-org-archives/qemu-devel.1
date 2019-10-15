Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A327C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 17:55:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07C692086A
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 17:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gj+Y+3dA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C692086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKR2X-00083e-1l
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 13:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54596)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iKQyy-0004wl-JM
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 13:51:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iKQyw-0003PV-Gj
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 13:51:40 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:35828)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iKQyw-0003PH-AH
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 13:51:38 -0400
Received: by mail-pg1-x544.google.com with SMTP id p30so12592805pgl.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 10:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=1C7c6L0AKcXy94kRypeBSB6XHbsCm+dRfwVNJ4dwo8Q=;
 b=Gj+Y+3dAOGc9dHpOy9mhXsLqGcNMj5MIDrIoxzeR1GgxkfrjmeMlA0X897dskiv2ee
 xrLxCmYtK2YwsYESQjAre+jDnLqp8k9nJ9N0t1qLZ7ak6StWqaXcGlyfGZoeNRtt7U2m
 7gJqa9ScHJxsD4KNYTobWED2saHsYVwogmfgEDKZiean4+RfEK1h6Y8ulDC2o9SZfskQ
 FJJRHMP2lNlcH+jT1vkdCpTSE++ZQU+BCvGztqyJAR5NrtPZUunXgFEv2oTXQZDj3JP0
 GlSLSFNk1pSq1vVQ/C6enhK8e2o1HzjbL0wu4KCgzAHttRhONvy1de0NhlI0JyzBrx19
 pqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1C7c6L0AKcXy94kRypeBSB6XHbsCm+dRfwVNJ4dwo8Q=;
 b=DFUgDkqZBcW1wPjadyMvc70ai6yHDTRMDUGIZClSmIU3yTHacTzyxefxBKtgCsJhSi
 fcRmfT3/04SRUXBP8Lb+fUsMXN8naVF89lNizYaNBGscINx5QCj52GbYKKfQpGtjJPXk
 WVJVvLI/GBgKeaOepOXhesKRCQ6fLKmCgai1xWS7d1ZPOZqgoniD0WQnA4+/E3ptMABu
 3NAgatttBDEB6Q//Nv5shvRRecl7Z4caasOuunMhxAs5mEWzYhgoTkCZfhMLrlBGoZ+F
 CJYz+3qDPmvgdrdW11ntuvfRpS5jy1e3IzJ8TArH0Pl6+PWQ1LDiecXfguSiHqxghGuy
 cD/Q==
X-Gm-Message-State: APjAAAWRiVixb/fRhjoawhQzrDoXUPJR2Xmirao1PIR2qFo16tvEeBGJ
 1dRP1TQvxmbVIUZ7gwABhcWEpYxjChA=
X-Google-Smtp-Source: APXvYqyB5BcjRmEAYh3iTjSbd2gDoDSUPazl7j1nWIqB6FKk719+Nm2N3+cm6jegnpbHhfkJJ9VEww==
X-Received: by 2002:a17:90a:1b45:: with SMTP id
 q63mr43578475pjq.106.1571161896902; 
 Tue, 15 Oct 2019 10:51:36 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id t68sm20867845pgt.61.2019.10.15.10.51.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2019 10:51:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/3] capstone: Update to master
Date: Tue, 15 Oct 2019 10:51:31 -0700
Message-Id: <20191015175133.16598-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191015175133.16598-1-richard.henderson@linaro.org>
References: <20191015175133.16598-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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

Update to 418d36d695e0.  Choose this over the 4.0.1 tag because
master now includes the s390x z13 vector opcodes.

Acked-by: David Hildenbrand <david@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 Makefile  | 1 +
 capstone  | 2 +-
 configure | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 30f0abfb42..8ce48e0342 100644
--- a/Makefile
+++ b/Makefile
@@ -498,6 +498,7 @@ dtc/%: .git-submodule-status
 # Remove all the extra -Warning flags that QEMU uses that Capstone doesn't;
 # no need to annoy QEMU developers with such things.
 CAP_CFLAGS = $(patsubst -W%,,$(CFLAGS) $(QEMU_CFLAGS))
+CAP_CFLAGS += -I$(SRC_PATH)/capstone/include
 CAP_CFLAGS += -DCAPSTONE_USE_SYS_DYN_MEM
 CAP_CFLAGS += -DCAPSTONE_HAS_ARM
 CAP_CFLAGS += -DCAPSTONE_HAS_ARM64
diff --git a/capstone b/capstone
index 22ead3e0bf..418d36d695 160000
--- a/capstone
+++ b/capstone
@@ -1 +1 @@
-Subproject commit 22ead3e0bfdb87516656453336160e0a37b066bf
+Subproject commit 418d36d695e075955674ace5a1191b495da50f84
diff --git a/configure b/configure
index 08ca4bcb46..f4f1860065 100755
--- a/configure
+++ b/configure
@@ -5008,7 +5008,7 @@ case "$capstone" in
       git_submodules="${git_submodules} capstone"
     fi
     mkdir -p capstone
-    QEMU_CFLAGS="$QEMU_CFLAGS -I\$(SRC_PATH)/capstone/include"
+    QEMU_CFLAGS="$QEMU_CFLAGS -I\$(SRC_PATH)/capstone/include/capstone"
     if test "$mingw32" = "yes"; then
       LIBCAPSTONE=capstone.lib
     else
-- 
2.17.1



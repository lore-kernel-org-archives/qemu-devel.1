Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA89C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 16:41:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEC3320833
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 16:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q+TOHrkT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEC3320833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60929 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRJRi-0005v5-3x
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 12:41:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRJPP-0004NS-41
	for qemu-devel@nongnu.org; Thu, 16 May 2019 12:39:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRJPN-0002lX-HD
	for qemu-devel@nongnu.org; Thu, 16 May 2019 12:39:07 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39799)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hRJPM-0002kh-Hj
	for qemu-devel@nongnu.org; Thu, 16 May 2019 12:39:04 -0400
Received: by mail-wm1-x344.google.com with SMTP id n25so3770697wmk.4
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 09:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=EHWFkbuw1ciTuYhMY21VSgxzzXPrQYdg2HxcH0sKDA8=;
	b=q+TOHrkT0BeTNHQYLV/vZj9BA4rrv7GtykA/Z1BxO55nCHUviQneVDAOS+RMzyjFl/
	OUwm0u+x3TmWRzCJ5oEXMmy2M0i5GmgTaZOi7jj2E7BThxXLrFGHwmnlDiNCa9EIYZaz
	BSiXcEadsXcgIb5GGXDLlJECSefAmr+INQDqQ2dJo0ENK3ezbnQCK8s2LqRQS49BzcmS
	CCI3RxwQXjAZvZBu6l04nJCCRJiTNxDjJc9w4o9syBevrd978rZDNw+Y/kF5rRgPV1yl
	docNZ1WzLTnOdAui8IX6pxf0kOo+lYXPjSyZ4A7cJpQwMfRGkupaNJ8aMa7jsp25QWw5
	nktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=EHWFkbuw1ciTuYhMY21VSgxzzXPrQYdg2HxcH0sKDA8=;
	b=OWtxXDZ84sBKDuUgJSxeLEwUG2xbMYrmt+B3FeDM6F6LRiEuD6JqlHvwCqhl3xSYV3
	kXfgCVTxTplUje3JJ9z3f+IkALujDcVeEAQahppCAOCMrqbvIUndf3Gt4ATMI5g/f3xk
	dJYHhS9zF3tyt9mprFYIavylKFvoxyyGvhk15/q+6V4uEZ4ZOZMA9Tff5IDpgjfNxTVd
	MwKul6rmqO4MqWteh1/f76LYTlva7w22x6EN+jgix1Lrzy/5bhImtHOHn8+5CVzEaPUY
	tCLmS+MFVjfN3GZe9fKqETtOQPK9oShb++1wRraLpVBCf7ctHab/8PNOZYq152niPfRA
	riiQ==
X-Gm-Message-State: APjAAAXIavrhxE22fjIfOrrbCRcO7dHUFfx5eNo7zdXEO76/nogaDgRb
	hmgw6rzuO2aYs/Qdg6ibLmH7+P6+oYs=
X-Google-Smtp-Source: APXvYqyk4kBYaR/hFGdVQVTwlZf2Yxw4I61H00eZ/0vrW5XQTg0KJmTcA5IEQ3+AmutIUF2nnnoKUA==
X-Received: by 2002:a1c:eb07:: with SMTP id j7mr27300676wmh.138.1558024743333; 
	Thu, 16 May 2019 09:39:03 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	y130sm6702844wmc.44.2019.05.16.09.39.02
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 09:39:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu, 16 May 2019 17:38:56 +0100
Message-Id: <20190516163857.6430-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190516163857.6430-1-peter.maydell@linaro.org>
References: <20190516163857.6430-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH 2/3] arm: Remove unnecessary includes of
 hw/arm/arm.h
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The hw/arm/arm.h header now only includes declarations relating
to boot.c code, so it is only needed by Arm board or SoC code.
Remove some unnecessary inclusions of it from target/arm files
and from hw/intc/armv7m_nvic.c.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/armv7m_nvic.c | 1 -
 target/arm/arm-semi.c | 1 -
 target/arm/cpu.c      | 1 -
 target/arm/cpu64.c    | 1 -
 target/arm/kvm.c      | 1 -
 target/arm/kvm32.c    | 1 -
 target/arm/kvm64.c    | 1 -
 7 files changed, 7 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 3a346a682a3..815e720cfab 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -16,7 +16,6 @@
 #include "cpu.h"
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
-#include "hw/arm/arm.h"
 #include "hw/intc/armv7m_nvic.h"
 #include "target/arm/cpu.h"
 #include "exec/exec-all.h"
diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index 8b5fd7bc6e3..ddb94e0aba0 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -29,7 +29,6 @@
 #else
 #include "qemu-common.h"
 #include "exec/gdbstub.h"
-#include "hw/arm/arm.h"
 #include "qemu/cutils.h"
 #endif
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index a181fa8dc1a..6e421271580 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -30,7 +30,6 @@
 #if !defined(CONFIG_USER_ONLY)
 #include "hw/loader.h"
 #endif
-#include "hw/arm/arm.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/hw_accel.h"
 #include "kvm_arm.h"
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 228906f2678..37a57c4f60b 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -25,7 +25,6 @@
 #if !defined(CONFIG_USER_ONLY)
 #include "hw/loader.h"
 #endif
-#include "hw/arm/arm.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
 #include "kvm_arm.h"
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 59956346126..fe4f461d4ef 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -23,7 +23,6 @@
 #include "cpu.h"
 #include "trace.h"
 #include "internals.h"
-#include "hw/arm/arm.h"
 #include "hw/pci/pci.h"
 #include "exec/memattrs.h"
 #include "exec/address-spaces.h"
diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index 327375f6252..4e54e372a66 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -20,7 +20,6 @@
 #include "sysemu/kvm.h"
 #include "kvm_arm.h"
 #include "internals.h"
-#include "hw/arm/arm.h"
 #include "qemu/log.h"
 
 static inline void set_feature(uint64_t *features, int feature)
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index e3ba1492482..998d21f399f 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -26,7 +26,6 @@
 #include "sysemu/kvm.h"
 #include "kvm_arm.h"
 #include "internals.h"
-#include "hw/arm/arm.h"
 
 static bool have_guest_debug;
 
-- 
2.20.1



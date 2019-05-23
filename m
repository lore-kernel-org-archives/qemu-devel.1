Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29306C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:28:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E988020851
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vACYtOFu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E988020851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37491 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hToi4-0006P4-49
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 10:28:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTodp-0002pM-25
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:24:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTodi-0006z4-TQ
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:24:18 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39747)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hTodc-0006tG-PR
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:24:10 -0400
Received: by mail-wm1-x342.google.com with SMTP id z23so1934123wma.4
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 07:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=aPHvP77EG+2v9a9J5aEUYg8t8lA/BUnM+q643Wx7cho=;
	b=vACYtOFu+YN36bySNz9ms0pEkK6d6eDfX3c5jUe7tgA5W+ignwgagrPWLl1ig8hQr7
	yt1dKqCcyouVmTaclH2DKnQIwZj5ODOnJfbHwmgJLTCfJJ4ejCDdDWVxEoX5jbx3iko8
	GKXx3CQwMAm+hiVCSacPThNMqe9XaNsZSdym9DbIGy2TP6/rGRMVhYR2PloYtENl0OdA
	ov/j0gxpL3XGyOVxzX7NBCrmdFcEiYfxSg5i8EBnmqa6D+S9wvRDLW1QH7RA8OeQV8AN
	awAtXP022vH0hRd+pLYv/vHC/WDKMu57UnNPGYEQ8Thx45lgnlWPxFVPklrbKe13EXvI
	Ms5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=aPHvP77EG+2v9a9J5aEUYg8t8lA/BUnM+q643Wx7cho=;
	b=hOXK2do+ZFijMFIJE/zTlcF2oAP+prMAaYFePeq7He+8PAmdmq4viB6OeqKXyxImwK
	nLRxI0UhdPDUNIZrQHtQN4cZITh1bO9O+uubOxiA51XNe+IdXV9ZMSpGkeNE17WrifMx
	KVeeEd+OHVfaexNpC+j3vkUumvYK5Igmw4Jmq7egr+3F3s8wdYje5jOtVqsjn92rR2o1
	TwwVKMXmAHvJaqPG1S4kPe4tPpcpF35e/1bJKZOiVCkhBSJbfa8evEBF6DaCafeZDgKk
	YwIFl57YGX8Pf32k5s1wmux46JxNnK8k7QMCSE8zJ0TI2fckAVxu0n1Onx/ShqAKvSC4
	mJ0g==
X-Gm-Message-State: APjAAAVT9aUj49A65rwM1wzHj0voMPDErOC9Giyi08hKMnZnr6BGXsdj
	EBKLcgpeiMvgtKLF5USj4mex87Woc6NW1A==
X-Google-Smtp-Source: APXvYqxHvKcopLIoFU8g3HyTAYlmbAimCHKtoYVqeM0XJ0WQ7DeRKP/2OEz3CUh8tsgOWuAm/ZZ2pQ==
X-Received: by 2002:a7b:cb48:: with SMTP id v8mr12682098wmj.108.1558621445341; 
	Thu, 23 May 2019 07:24:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id z5sm9700617wmi.34.2019.05.23.07.24.04
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 07:24:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 15:23:50 +0100
Message-Id: <20190523142357.5175-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523142357.5175-1-peter.maydell@linaro.org>
References: <20190523142357.5175-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PULL 05/12] arm: Remove unnecessary includes of
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190516163857.6430-3-peter.maydell@linaro.org
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
index 8eee1d8c59a..9b23ac2c935 100644
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
index 835f73cceb5..0ec8cd41f19 100644
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



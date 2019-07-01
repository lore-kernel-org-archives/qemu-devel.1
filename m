Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F35C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:28:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45A6D2064A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rksDEHIW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45A6D2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi3r1-0004FX-EH
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 17:28:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44952)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3Dn-0001bX-Md
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:48:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3Dj-0001Op-2h
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:48:17 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:36982)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi3Di-0001LX-QP
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:48:14 -0400
Received: by mail-wm1-f54.google.com with SMTP id f17so936146wme.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 13:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=XIpbYiZf2SRJuij2NyCsmVITR8aYraN06NwGun1+UKo=;
 b=rksDEHIWsnZsCPPLqt8XHpd3gmarGdae5onUU9ETDy4RPkd8vUqTPXbdxP5wW/rMbJ
 uiUWQP4iCitqIiJLcgy/D4T6EbnGlM1px38NJbfgcCPiWCAjRJRkxII6vdR0StREMKx1
 /9XO5rW6eGLvBAsqpnwgeTx7C1mYiXzTqnQkS2U9fBFsbkyA6TSxUz/WAhXpCzt1w2Pb
 WrNmf1ko7DL/Vi/q7mlIm4cMyKpfQKx0FaE2C8lYVzC6QBv0u9QTLnwYC+i7FitsDJQk
 FhYubxNZ/pasL4Zkd0uMp5iWglfDU6TtU2QoepXJf1gr1ciJv9WhPK5mi2HBMqe+zBST
 WApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XIpbYiZf2SRJuij2NyCsmVITR8aYraN06NwGun1+UKo=;
 b=Cp45jhGtfopzaO8O43aNyXSiumAyQ62iMxAZtwfNj/t1J5mgPLNXqMwaFx8B+792E8
 z/1k0M+iyr1wAlcElSPaTgVm5rzH8/HbEEt2tE5MkWBj/+QWBXp8q4zV0oE+zPfevShb
 qjJoHSTCgifWTmkux6VqCgSHNNRi1AXSOAsyDxjTVwbfkQudcE+z4dUoc99B4I6CW765
 1L37/2DmTIe6pQJ1bW9xd3sUiYXODI7/4u/4C8qaWjsXFwD8NxQcIiLiCma/dRb+LZ+L
 FqxWSJVMxwqyL7I9KQHIc0ezzBQLc3rr5FVstHQ/2Jw8cWNGR+sg+6oGcho2p0nHOadi
 ZcgQ==
X-Gm-Message-State: APjAAAUacXOTOZcrnV59HUiXSOwS130BEebmCH822p8mAc1GauRn1RcE
 XjIyxghO1PEbNzAE+bH0E4XXZj+TyGgK/Q==
X-Google-Smtp-Source: APXvYqyrPYsbaLDj5jp+xvGqUuKn1fZoQ+ZFL3Qpt3+SbIFwFb8xkrHW65jaFZdzMGBeNv3N5F29LQ==
X-Received: by 2002:a1c:6555:: with SMTP id z82mr97753wmb.129.1561999217998;
 Mon, 01 Jul 2019 09:40:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o6sm26573508wra.27.2019.07.01.09.40.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 09:40:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 17:39:27 +0100
Message-Id: <20190701163943.22313-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701163943.22313-1-peter.maydell@linaro.org>
References: <20190701163943.22313-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.54
Subject: [Qemu-devel] [PULL 30/46] target/arm: Makefile cleanup (KVM)
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Group KVM rules together.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190701132516.26392-4-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/Makefile.objs | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
index 1cbe7cfdb47..7a933eebc75 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -1,14 +1,15 @@
 obj-y += arm-semi.o
 obj-$(CONFIG_SOFTMMU) += machine.o psci.o arch_dump.o monitor.o
-obj-$(CONFIG_KVM) += kvm.o
-obj-$(call land,$(CONFIG_KVM),$(call lnot,$(TARGET_AARCH64))) += kvm32.o
-obj-$(call land,$(CONFIG_KVM),$(TARGET_AARCH64)) += kvm64.o
-obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
 obj-y += helper.o vfp_helper.o
 obj-y += cpu.o gdbstub.o
 obj-$(TARGET_AARCH64) += cpu64.o gdbstub64.o
 obj-$(CONFIG_SOFTMMU) += arm-powerctl.o
 
+obj-$(CONFIG_KVM) += kvm.o
+obj-$(call land,$(CONFIG_KVM),$(call lnot,$(TARGET_AARCH64))) += kvm32.o
+obj-$(call land,$(CONFIG_KVM),$(TARGET_AARCH64)) += kvm64.o
+obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
+
 DECODETREE = $(SRC_PATH)/scripts/decodetree.py
 
 target/arm/decode-sve.inc.c: $(SRC_PATH)/target/arm/sve.decode $(DECODETREE)
-- 
2.20.1



Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A11C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:19:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5AF620692
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3M0NOBp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5AF620692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVeJj-0003iP-Nz
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 11:19:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50310)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iVeFP-00085p-Uy
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:15:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iVeFP-0003JV-2L
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:14:59 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51935)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iVeFO-0003J7-Sq
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:14:59 -0500
Received: by mail-wm1-x344.google.com with SMTP id q70so10204465wme.1
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 08:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gNXtn/mvqE8uO4RJgi1dejcMTDf5RkTo+nX3CTX7x3s=;
 b=k3M0NOBp5w2XyCWNejLBZeOsT+pDRTwApIa/K9aC5+ZJAB9AoPITEQTvnu+AznpZAx
 yJ5kwZ7cXbV72OGJQqZPv7HqBZ5Y3BnlgE+CLCQH5ZvM/ADWgWM8fPEo4sLMFRLOjpBf
 uIQ6TedR9KWKzwRQLBAUtNlYagszfZsXZAsvn38KgzEF/gJx0OJMOmDgEqRei7/etb+T
 QN8YKim3p/Gm88wRkYncud3aoqEzsFwk7zas/Xpz4TYKMJXxc9cv3tJCdcNfJVBZgPhi
 4i+tdC80iTgNvphFKpGxV3/yanL41oAZD4kh10ub52vKRnKHmwx3oDCej28ns7dsOmKx
 JEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=gNXtn/mvqE8uO4RJgi1dejcMTDf5RkTo+nX3CTX7x3s=;
 b=MpZO5lqZ08epq349NXnyk6xQHVfqdhenrIwDxhzYuuu76L5qHg04EUFXQaMKhuL9BU
 NtnQzu0hVnButYPxGKf/n7q5sxylU87JMSJRVcKeapemFUyniQHf288ira9PWOszuk50
 UDJN9XmgsqrTQ2u1ENl8RGcPKNr934aJJ/q23ZIrErFrkvmj4EEiGA0P7n/8g6Qo0/lN
 De1Zrti3mGQQ4jvhkbbKsHBPRu2uVDxn+JCap1GpVWsYRS5m2LF3nvqIlyFktkrKQDdM
 WK1t0U9zRKt5F3kGfm8ZBV0ztv6LL48a6iOimLPbXj8ke0PP+HEivkHM4ja23SXTfNMc
 5Xxg==
X-Gm-Message-State: APjAAAWWiKxjiQmWrM89gkrz/Y2xDhnhMqLw3mcPkp0Y/p+D6SeuHpCf
 LNo4+XyZnPgqiGvtJQAQAQSvkXjx
X-Google-Smtp-Source: APXvYqyZztQkWKLLwYjt0318PdvoBP+xplQG7SxJ5qDCRPDH2Ow25QhcivcBr3QZwJTOekIHYxDiFQ==
X-Received: by 2002:a05:600c:c5:: with SMTP id
 u5mr14919805wmm.35.1573834497241; 
 Fri, 15 Nov 2019 08:14:57 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:6468:f312:a15b:f753:1ac4:56dc])
 by smtp.gmail.com with ESMTPSA id p25sm9776515wma.20.2019.11.15.08.14.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 08:14:56 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] vfio: vfio-pci requires EDID
Date: Fri, 15 Nov 2019 17:14:55 +0100
Message-Id: <20191115161455.27862-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

hw/vfio/display.c needs the EDID subsystem, select it.

Cc: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/vfio/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/vfio/Kconfig b/hw/vfio/Kconfig
index 34da2a3cfd..f0eaa75ce7 100644
--- a/hw/vfio/Kconfig
+++ b/hw/vfio/Kconfig
@@ -6,6 +6,7 @@ config VFIO_PCI
     bool
     default y
     select VFIO
+    select EDID
     depends on LINUX && PCI
 
 config VFIO_CCW
-- 
2.21.0



Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66406CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:44:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F84A2070B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YdvW9nh0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F84A2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNy1V-0006LW-6n
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 07:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iNxwP-0006gO-1c
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:39:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iNxwI-0006c6-E5
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:39:36 -0400
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729]:38449)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iNxwG-0006aV-GD
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:39:29 -0400
Received: by mail-qk1-x729.google.com with SMTP id p4so1403429qkf.5
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 04:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=MfrPU6dfjKdIPv9pRU2qfeqITCMfZWCuzZQmM0QxYQ0=;
 b=YdvW9nh04/K98nOhMMeTA9x6+a26eY7B3qAAmfBLYDRcVNVtC14+Ff5ulygjtXvQCK
 ZC3zYiRiOjrqlaf331uOhMPK1Gze4ttLD/iO83dPhyrVoVnNaXG5mx7RY4WWOXf8XFtb
 0EhGUNL7ICG88dMdRka7PkA+IVtGA9yH2Dtf6KlPPU8jpexZPlkmS97Y8TGkpZcOdYbd
 VPqqhtnZ6urHQyx8tmQGUE+8guZOKxVXt0nRA3vj+8K9JVtLBmx6033cmsx34mODd7is
 MsjuvvIi9R8DcavW64tfC+Ir29ExzPCMABmLGXqpdmEcLBiSW/1vzX7mo6GRnQiPoEcl
 Lw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=MfrPU6dfjKdIPv9pRU2qfeqITCMfZWCuzZQmM0QxYQ0=;
 b=scHJBHaU8PIv9gz78g+Fk2HfrNpxeZhvfhhBW65/SIwxNUEJKbPCKdsxy7G//9Ap0J
 gXhY2TEmBum3a5vq7NBaSJd7FfOtXZEHBcGD7nuFYxS5bANO7MFrdoV4oUAYqfbbo5pP
 u6N+ZCxc20iPxlKFUOtCGPC3nB8zYijPSD04CRtgyw586aY5ACwpHQP1q6bWoY+FXNwR
 C9QPDmYRc08+bNpigLq6gSFdU3rXH4wFBsiQOEZLka6MRrgFCNx3K2Iz4CM1jkANgHLI
 paJo08UZ7TIPCjBE+4/D3SARHvm7jL6MmucIywBgWums1IdzZQ5pxWntsMikxEBuP249
 aKiw==
X-Gm-Message-State: APjAAAWitZ5oir0fpgH+RftjgBfbYlnq6JlK8/jOm1CtOvpX7daQCUB6
 Iq/k26YizfMoD18WmxsiuJIyp+JHBQc=
X-Google-Smtp-Source: APXvYqxq6Aqt5lb8YL8eOGjV2BycRh1h2F/7dT4ZU0wSlZIFZFIYZIY29a9g7KxGI9pHe+nWzD3nzA==
X-Received: by 2002:a37:6305:: with SMTP id x5mr2367044qkb.498.1572003566025; 
 Fri, 25 Oct 2019 04:39:26 -0700 (PDT)
Received: from localhost.localdomain (rrcs-172-254-253-50.nyc.biz.rr.com.
 [172.254.253.50])
 by smtp.gmail.com with ESMTPSA id x38sm1473335qtc.64.2019.10.25.04.39.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 04:39:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/12] target/sparc: Define an enumeration for accessing
 env->regwptr
Date: Fri, 25 Oct 2019 07:39:12 -0400
Message-Id: <20191025113921.9412-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025113921.9412-1-richard.henderson@linaro.org>
References: <20191025113921.9412-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::729
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
Cc: alex.bennee@linaro.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 778aa8e073..ae97c7d9f7 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -13,6 +13,39 @@
 
 /*#define EXCP_INTERRUPT 0x100*/
 
+/* Windowed register indexes.  */
+enum {
+    WREG_O0,
+    WREG_O1,
+    WREG_O2,
+    WREG_O3,
+    WREG_O4,
+    WREG_O5,
+    WREG_O6,
+    WREG_O7,
+
+    WREG_L0,
+    WREG_L1,
+    WREG_L2,
+    WREG_L3,
+    WREG_L4,
+    WREG_L5,
+    WREG_L6,
+    WREG_L7,
+
+    WREG_I0,
+    WREG_I1,
+    WREG_I2,
+    WREG_I3,
+    WREG_I4,
+    WREG_I5,
+    WREG_I6,
+    WREG_I7,
+
+    WREG_SP = WREG_O6,
+    WREG_FP = WREG_I6,
+};
+
 /* trap definitions */
 #ifndef TARGET_SPARC64
 #define TT_TFAULT   0x01
-- 
2.17.1



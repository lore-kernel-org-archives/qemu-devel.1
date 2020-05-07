Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF222C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 15:25:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7226D207DD
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 15:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zhBviDxg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7226D207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWiP2-0000ux-GV
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 11:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jWiIA-0006ra-E4
 for qemu-devel@nongnu.org; Thu, 07 May 2020 11:18:30 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40164)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jWiI9-0002aU-Gw
 for qemu-devel@nongnu.org; Thu, 07 May 2020 11:18:30 -0400
Received: by mail-wm1-x343.google.com with SMTP id u16so7245597wmc.5
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 08:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=wJXx4XuJhkbJc2HXg+9RF+qHl2xqcHAuj4vHJSwCoWY=;
 b=zhBviDxgU36vT90TpDmXQXr93jve2X5K2f/hLycM63XskyH5pympxGLL94aM5jFfTP
 3JkcdkzYcfsInQinAlUiyCU9Ya3lLck1h89J2XSG5+gIjgBy+vPryMaamiwJBRUjLqQf
 Y5qU+5oaG+Fvd0e2QnVHjgg0NLmzciIrhC1Eonzy78I4SnjD3iYMQooqlBidDjum23Ht
 nYUUmZ0NBYIIgrJJoghQDTDFUnna0y+ZNR0SRFEl1hUC6Vd/Er36JEuoSGqnyx4EEx2b
 vFAFSO+v0THnPnqnoVJ7vxVTjMKal2W1IKfJ7FSA7ZVjac1f2n/d9d9libLQjKxNK1BK
 W1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wJXx4XuJhkbJc2HXg+9RF+qHl2xqcHAuj4vHJSwCoWY=;
 b=ioZ2g9/P+58gUUORveo7enwRa8rT1mQocYI2fXseLDfj/Nrm6thKI9rofH7eYwsmX9
 38DtZwRbCxRAP+vLLPwxI3pywKKIRKPDC+lpqr317dLrOX4/tKT4YCDBLtz+scE6N4yN
 7mLOU+C1WNg3WZfnsrgqLCHY2UrSZnFkKOswHd/ZvvQhosvBxYq5OwvBdsG7ZFVNOhl4
 FbDdVQKMsFm7wiIsrsk9OzFZ6nXnIPIKj+KHZyBfS0eufXnLL7LR9/c5CctyAAXDyOi9
 /vHBoXZWUKGnw3GLDaWrGUA5vqzst5dUt+00QwqFTW4u8x4Ph0oa+w08YOmhTsFtlxx6
 ph+A==
X-Gm-Message-State: AGi0PuakzM9W0YBx4vykOUdTskkUZwwkeRtKIajD2IWp/upL2EMrbiWp
 k11VYM5o76lS5AUzBqZTNxsZgGvzZC7G8w==
X-Google-Smtp-Source: APiQypKSW60XZGn/lSSeJnGfwA3XqnX6aMS1azHLyE93aPudJdDK/523aSNObj7OjL2bCGNxyMI+Sw==
X-Received: by 2002:a1c:5683:: with SMTP id k125mr10548133wmb.17.1588864707481; 
 Thu, 07 May 2020 08:18:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q74sm961246wme.14.2020.05.07.08.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 08:18:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 4/5] docs/system: Document the various MPS2 models
Date: Thu,  7 May 2020 16:18:18 +0100
Message-Id: <20200507151819.28444-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200507151819.28444-1-peter.maydell@linaro.org>
References: <20200507151819.28444-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

Add basic documentation of the MPS2 board models.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/mps2.rst   | 29 +++++++++++++++++++++++++++++
 docs/system/target-arm.rst |  1 +
 MAINTAINERS                |  1 +
 3 files changed, 31 insertions(+)
 create mode 100644 docs/system/arm/mps2.rst

diff --git a/docs/system/arm/mps2.rst b/docs/system/arm/mps2.rst
new file mode 100644
index 00000000000..3a98cb59b0d
--- /dev/null
+++ b/docs/system/arm/mps2.rst
@@ -0,0 +1,29 @@
+Arm MPS2 boards (``mps2-an385``, ``mps2-an505``, ``mps2-an511``, ``mps2-an521``)
+================================================================================
+
+These board models all use Arm M-profile CPUs.
+
+The Arm MPS2 and MPS2+ dev boards are FPGA based (the 2+ has a bigger
+FPGA but is otherwise the same as the 2). Since the CPU itself
+and most of the devices are in the FPGA, the details of the board
+as seen by the guest depend significantly on the FPGA image.
+
+QEMU models the following FPGA images:
+
+``mps2-an385``
+  Cortex-M3 as documented in ARM Application Note AN385
+``mps2-an511``
+  Cortex-M3 'DesignStart' as documented in AN511
+``mps2-an505``
+  Cortex-M33 as documented in ARM Application Note AN505
+``mps2-an521``
+  Dual Cortex-M33 as documented in Application Note AN521
+
+Differences between QEMU and real hardware:
+
+- AN385 remapping of low 16K of memory to either ZBT SSRAM1 or to
+  block RAM is unimplemented (QEMU always maps this to ZBT SSRAM1, as
+  if zbt_boot_ctrl is always zero)
+- QEMU provides a LAN9118 ethernet rather than LAN9220; the only guest
+  visible difference is that the LAN9118 doesn't support checksum
+  offloading
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index 4779293d731..15bcf9f81f0 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -71,6 +71,7 @@ undocumented; you can get a complete list by running
    :maxdepth: 1
 
    arm/integratorcp
+   arm/mps2
    arm/realview
    arm/versatile
    arm/vexpress
diff --git a/MAINTAINERS b/MAINTAINERS
index 74cff1c3818..ea7bdd359e0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -699,6 +699,7 @@ F: hw/misc/armsse-cpuid.c
 F: include/hw/misc/armsse-cpuid.h
 F: hw/misc/armsse-mhu.c
 F: include/hw/misc/armsse-mhu.h
+F: docs/system/arm/mps2.rst
 
 Musca
 M: Peter Maydell <peter.maydell@linaro.org>
-- 
2.20.1



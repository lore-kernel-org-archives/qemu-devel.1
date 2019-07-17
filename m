Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66921C76195
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:51:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37937208C0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h0TMBYau"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37937208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnkL3-0005lb-Qc
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 09:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57773)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hnkKe-0004X4-2t
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:50:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hnkKd-00010l-3c
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:50:56 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:32997)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hnkKc-000101-S6
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:50:55 -0400
Received: by mail-wm1-x344.google.com with SMTP id h19so19232466wme.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 06:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=m27wikNUV2ioSIIaNiDI3xIBu0qKgf8kwe98LNTGUc4=;
 b=h0TMBYauQel7RhclqI/KijPgCYbscH7rFEJNoFAhX9/PlG1Ud4STUrLFwWppXuyzkj
 L66e3Mag2hYO3Q7X5gjdlgz3HEFISkzFTsgn7OYodtN0+01IlMZ28LKU2cl6R0jfzCxU
 Pn1n+qYaVxf4NAbvjsyslzcYuRuE3ZgIggWgzy2EJSBkmxlUw15RyNnSG3p1QEKHoRKy
 iVyEOCloon0wMQN+78IBYQrbQIDYcwbMeD/iudED8t1u/AvhASwrigh+bWgL2rCLOdJo
 7bLJD2YpaAGVwI3HrrZSFHu0zEiusCJwjE7CeLfYdX1mXVQi/m+QkDdzRgDS3vliYiG8
 vCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=m27wikNUV2ioSIIaNiDI3xIBu0qKgf8kwe98LNTGUc4=;
 b=N/L3j6cDpO4HyuR8j7d/fMORPUuEpafobISEk4BWVJLiOv47n7QwzQ2wILA842NMiA
 v7Q4ENrNZc1MzrPmhwIvReBMM9I0bGznHaVwZTPp8G9dnS8BYd/As7JU3SrVtK1wl5UB
 w1tt27jv65kfRhp6si8tCyrAwPGbdXJOaWTaE1taxSpQOxchUI633uwpM2dO3WcoZ8R0
 LfRZ7ED5WfbkoGGu3tnqOc5aSPDWxwU5FksYnK8UkdLr35uYy6EX4dSuC6XOWUrfDj2Y
 1ixyUtPAHR/WDPbDUuGPBLkOxhkRJ9iOYI9YqaSD9mIJ/QOiPQHF7IOKTDSrWl4lJNFP
 21fw==
X-Gm-Message-State: APjAAAXix53p1hexljezGrgRYxa51eGtlmbeDlLfwa28dt2pUvnIQtL/
 0Gln0zdNxgSqBeX8eubTGNA8lg==
X-Google-Smtp-Source: APXvYqy0LzzCO8j5dEiC3LzhIE3CwWGr1/D/7GVh/ZzX5epVZqVYaMM49ffmncKhNiduOXTvF3xSbw==
X-Received: by 2002:a05:600c:23d2:: with SMTP id
 p18mr34702879wmb.160.1563371453405; 
 Wed, 17 Jul 2019 06:50:53 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id v18sm24932786wrs.80.2019.07.17.06.50.52
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 17 Jul 2019 06:50:52 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5ADBD1FF87;
 Wed, 17 Jul 2019 14:43:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 17 Jul 2019 14:43:29 +0100
Message-Id: <20190717134335.15351-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190717134335.15351-1-alex.bennee@linaro.org>
References: <20190717134335.15351-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v2 17/23] hw/i386: also turn off VMMOUSE is
 VMPORT is disabled
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 97fd1ea8c1 broke the build for --without-default-devices as
VMMOUSE depends on VMPORT.

Fixes: 97fd1ea8c1
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/i386/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index b9c96ac361e..6350438036f 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -52,6 +52,7 @@ config I440FX
     bool
     imply E1000_PCI
     imply VMPORT
+    imply VMMOUSE
     select PC_PCI
     select PC_ACPI
     select ACPI_SMBUS
@@ -59,7 +60,6 @@ config I440FX
     select IDE_PIIX
     select DIMM
     select SMBIOS
-    select VMMOUSE
     select FW_CFG_DMA
 
 config ISAPC
@@ -78,6 +78,7 @@ config Q35
     imply AMD_IOMMU
     imply E1000E_PCI_EXPRESS
     imply VMPORT
+    imply VMMOUSE
     select PC_PCI
     select PC_ACPI
     select PCI_EXPRESS_Q35
@@ -85,7 +86,6 @@ config Q35
     select AHCI_ICH9
     select DIMM
     select SMBIOS
-    select VMMOUSE
     select FW_CFG_DMA
 
 config VTD
-- 
2.20.1



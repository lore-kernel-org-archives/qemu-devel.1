Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5D1C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:43:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77FE62081B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AJd0PXY3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77FE62081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpsGO-0007zD-G1
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 06:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39768)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hpsFA-0002rr-60
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:42:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hpsF8-0004NG-3T
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:42:04 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:33350)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hpsF5-0004A4-UJ
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:42:00 -0400
Received: by mail-wm1-x331.google.com with SMTP id h19so30817641wme.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 03:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/n1rEaje2BoVXSJBN759/udEouiZ9f4YQb0qSuBt+/w=;
 b=AJd0PXY3+S6kHTbr38KSv9v8VAhnYMViYI3ig4eOV0zwu8+J4FdY950E5BCLX+pWNN
 WQ/EqJLh2Wk7A0aGoMEE/ne54degGOwRD3Nq1FOarCbHxd2eVhFvVCFHt1xUNqZ7pCN5
 gcJ7UnuHVqjSPt2KLBf8G2rNygFjg4N8OI/aHhAkkIh+DzOtwa27JT1UQsGD3vQwIIxW
 DyalNHd/TVt6zZ2YmTaif33r91HrGp/TklSRtDvZpGa7oHZGxmTYVrhKuMQESCT606Co
 9V2mmamO4n1lAtqDL4CrWpi0FsXRcofAjw9Wki6usuHY9J2vDCdJD79Hb7ZEOQhAOdav
 z1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/n1rEaje2BoVXSJBN759/udEouiZ9f4YQb0qSuBt+/w=;
 b=OaKwpmF/qSJKcAWtZuH33RTYV3Nw2hWph4UAkvSgVRK7RVrmz9TJH3G30PeZZzIXZA
 HbNyZO8CEhkhZYn6evooPeySqR1GdCdPqt0oO1wrgEuoSFsiwNoDMPzCLzOXA6kcAigJ
 BoNbm1d+Lkp11Eu1d2PXo6nxqqnZaH6URNEQtWHZAFNiHHP5EK2r4OGjTlcoxV7t6zRe
 O+J1JSlKWczrw1hYrguwHv445Js+ek86xkBUuoDFkerIVoc9qTIVBahSteL54hx4TqAl
 cluK2gpQs+qSMKk1E6UlcwqOebMIGbzBbmBEMmlT4B99RSnbSYrnB1KOgb9eSBDV8FNn
 KO9w==
X-Gm-Message-State: APjAAAX8QMjxA5PGuJ0UO039vM82frP7GncojJnDc41J01FofjqDdOgD
 YmOyVZ5RnR3Z4nNtzUuhw3uKYw==
X-Google-Smtp-Source: APXvYqycltb2RWRfewZF3PAuBWMdIROGTV+iFMcOSHtsf0HtHU+sFsKgTlucelu8hnZlp4usQ+65HA==
X-Received: by 2002:a05:600c:225a:: with SMTP id
 a26mr72127529wmm.81.1563878512827; 
 Tue, 23 Jul 2019 03:41:52 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id 2sm54886497wrn.29.2019.07.23.03.41.49
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 23 Jul 2019 03:41:52 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C61BD1FF9F;
 Tue, 23 Jul 2019 11:36:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 23 Jul 2019 11:36:05 +0100
Message-Id: <20190723103612.5600-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190723103612.5600-1-alex.bennee@linaro.org>
References: <20190723103612.5600-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
Subject: [Qemu-devel] [PULL 16/23] NSIS: Add missing firmware blobs
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Various firmwares has been added in the pc-bios/ directory:

- CCW     (since commit 0c1fecdd523)
- skiboot (since commit bcad45de6a0)
- EDK2    (since commit f7fa38b74c3)

Since we install qemu-system able to run the architectures
targetted by these firmware, include them in the NSIS exe.

Reviewed-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190723070218.3606-1-philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/qemu.nsi b/qemu.nsi
index 75f1608b9e0..d0df0f4e3a1 100644
--- a/qemu.nsi
+++ b/qemu.nsi
@@ -106,6 +106,9 @@ RequestExecutionLevel admin
 ;--------------------------------
 
 ; The stuff to install.
+;
+; Remember to keep the "Uninstall" section in sync.
+
 Section "${PRODUCT} (required)"
 
     SectionIn RO
@@ -122,6 +125,10 @@ Section "${PRODUCT} (required)"
     File "${BINDIR}\*.bmp"
     File "${BINDIR}\*.bin"
     File "${BINDIR}\*.dtb"
+    File "${BINDIR}\*.fd"
+    File "${BINDIR}\*.img"
+    File "${BINDIR}\*.lid"
+    File "${BINDIR}\*.ndrv"
     File "${BINDIR}\*.rom"
     File "${BINDIR}\openbios-*"
 
@@ -210,6 +217,10 @@ Section "Uninstall"
     Delete "$INSTDIR\*.bin"
     Delete "$INSTDIR\*.dll"
     Delete "$INSTDIR\*.dtb"
+    Delete "$INSTDIR\*.fd"
+    Delete "$INSTDIR\*.img"
+    Delete "$INSTDIR\*.lid"
+    Delete "$INSTDIR\*.ndrv"
     Delete "$INSTDIR\*.rom"
     Delete "$INSTDIR\openbios-*"
     Delete "$INSTDIR\qemu-img.exe"
-- 
2.20.1



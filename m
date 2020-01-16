Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AE8C33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 17:43:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E002424743
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 17:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nuviainc-com.20150623.gappssmtp.com header.i=@nuviainc-com.20150623.gappssmtp.com header.b="U63FYOnI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E002424743
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuviainc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is9BS-0004MV-Jq
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 12:43:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <leif@nuviainc.com>) id 1is9AS-0003az-2R
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 12:42:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <leif@nuviainc.com>) id 1is9AR-0005gR-1v
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 12:42:51 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42096)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <leif@nuviainc.com>) id 1is9AQ-0005fL-M1
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 12:42:51 -0500
Received: by mail-wr1-x441.google.com with SMTP id q6so19964352wro.9
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 09:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rotpn64p7f0JzbmAl5UYYA83qOj/egKaEQ0Cnoo5p4U=;
 b=U63FYOnIwARwZjUm+R3MDuycOhA+tqE998VEqgSaErxVtnsIb2/sFo5ezWM5SACX1k
 EhrdZWadmOv/uZzhT1FRsN5aD5CHOfGLscCPsRxCq/8H1JTgqED1eJInUfXwK7PXf+Yh
 88X6xFrO8wMCD8PlnG9LhXZxrMRtTFA+HfhWOGBwRZJ4nmKGg6jmQCJSGVFlJA0mXvHe
 8QUy1PvW1Z2cwgnGb1L02m9RhO06ei6ScWz+dxUE5gclA/zkg6D/iNQYy/9KHDlLsAxE
 OK3qaY7P0bM3tXlmGezYZwa127umpFIAQypr1rfiSQGIiJ7c/gE2wfDPUrRbe4TMChJW
 HF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rotpn64p7f0JzbmAl5UYYA83qOj/egKaEQ0Cnoo5p4U=;
 b=qPqRLn/K66EhMVC8Xb0IH2Fze0Bp6BX1LAzFgcQjBEWMMgZuuhVtcHk6mmvbAoK6XR
 jUbkUiWGjXCAPLMCi+oaD4sw5nNKbJJ4EgXATHq1ydkav1j9wnvTOBgRhJrmFy+gZOn1
 1EJNtuLaiRgi6uZ0a4iVuLbhFXl7c7BgTTVSKWVisLjsCC5GCLicLBIxxbsU3lZWzb83
 b2R6lwiPEl6GWlBVVJ36zIpsnqQDdkQMdC57R9425glnDacvu2HrLPcIi5h48uYdMzlO
 QoeybII6ZvBjbSJMDE58wfnaCz0DuVcocBj1IelDbEvtyQbMH0OoeU8kTZbMGVl7Fxz6
 3fLA==
X-Gm-Message-State: APjAAAV6znis6hf/7+dgF4rDR4IeBF8MKTEGL06qMka0yIgQ7FrFj+Vj
 GVNMWBXz79ovscISLNW+w3Sx/HRatqyddlfZC/3Zc/xYFSQlI75v9yG9FAwmQoMoQsqLF//Oc5/
 9fk7k+PsOniYytj6Msp5yNydiI9APdb41jBimDEOz9lalQ+C6re2rhijk8V8zYfrY
X-Google-Smtp-Source: APXvYqy4VKZzxbWwdlFrvqMa9KNhPKox/vKf6vrHL4JUlZrqOmPXpHR6v76xhPhTVLhiMGqkib2LfA==
X-Received: by 2002:a5d:5091:: with SMTP id a17mr4467664wrt.362.1579196568415; 
 Thu, 16 Jan 2020 09:42:48 -0800 (PST)
Received: from urvogel.hemma.eciton.net
 (cpc92302-cmbg19-2-0-cust304.5-4.cable.virginm.net. [82.1.209.49])
 by smtp.gmail.com with ESMTPSA id r68sm124384wmr.43.2020.01.16.09.42.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2020 09:42:47 -0800 (PST)
From: Leif Lindholm <leif@nuviainc.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] MAINTAINERS: update Leif Lindholm's address
Date: Thu, 16 Jan 2020 17:42:26 +0000
Message-Id: <20200116174226.4780-1-leif@nuviainc.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Leif Lindholm <leif.lindholm@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update address to reflect new employer.

Signed-off-by: Leif Lindholm <leif@nuviainc.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 483edfbc0b..3c8653f26f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -735,7 +735,7 @@ F: include/hw/ssi/imx_spi.h
 SBSA-REF
 M: Radoslaw Biernacki <radoslaw.biernacki@linaro.org>
 M: Peter Maydell <peter.maydell@linaro.org>
-R: Leif Lindholm <leif.lindholm@linaro.org>
+R: Leif Lindholm <leif@nuviainc.com>
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/sbsa-ref.c
-- 
2.20.1



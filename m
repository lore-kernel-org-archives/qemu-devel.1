Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB8CCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 06:40:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 013EB2070B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 06:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GXF77aQ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 013EB2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNtGT-0007vk-IL
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 02:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35346)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtDr-0002tR-0h
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtDq-0008Ln-1w
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:18 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:33587)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtDp-0008LR-SE
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:17 -0400
Received: by mail-wr1-x42a.google.com with SMTP id s1so950077wro.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RnAEdxIMsOBRs/5T7Ts8em7DhClh/2QoH7on8QJvikk=;
 b=GXF77aQ6K7GUQI/DBeGy/kss9IBhyssgrJldSSwFr2v9jQTeLec6jgrWu4A1pB3KCV
 PcIY1sGkS7rPi2meeAh2yjAEmD8+RbVtJgtrOFl8x8HFKmjTJNPDbl3Cguv/BmmLutqr
 LHp0Nl3XScG89lEZm6aqjuu9X4y4SrSHfDRscW0IZwJtH2hQfLGkC2q8waMif0qlGQ70
 ahUGIA5RLDNpdO1m6tBsfsCWft+h6PqwdFfjBf0oiP9Y+wLKKdT22CvfOMG9YIhOwVAe
 waB0fnMB9kHkQQiLCZsYVCsijRUtPSqxLM9XbmS0scji1JXQ3ojoBEtCbf/k8I/kar06
 eeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RnAEdxIMsOBRs/5T7Ts8em7DhClh/2QoH7on8QJvikk=;
 b=NrE/kNVG35jsPL8PKRdtBDvtIx4KYuIzX9a0gzemPAUHK8BzyhxSm4ZJqtdoMXZYwd
 PSV2F/JYUEgrfEmOPLK4h1j/palM4aknbH9QLWa06htNvK9rnv3Kyq8FGK5rYzIqrEZw
 nOuXONdcP+m1kRwYO++mw//F3YpvcdSkkIkt+m3MWce5e8wqYq1QE9fWiM+InXo9QBnU
 yngb9PTTyR7BwegCPsjQIcFhqj9HgbOPW6lIxP3rFIbfu/SnQTL8j2mRr23J5W0aQ0gp
 w9qYFuANLyt4S2AJ7DLqzoWrhpRGA7UjsNdTmTwqYVIysukilW02laUQfb+hK9zRcSXm
 a7LQ==
X-Gm-Message-State: APjAAAV5O8W7oG3/0bxIWnVnFfiUr49c3Dhr9SxtnPXfuG3UWQ2z0bMV
 jRa+z3PtaArXs9noQOS1j0+45A==
X-Google-Smtp-Source: APXvYqwyhoswGM5+Oj8pmzE3+OYg3/PTQOrOIJ2byQ1IcGbCSN0/RXjMHwENGF4tnyy6nqzl6llOUg==
X-Received: by 2002:a5d:60ce:: with SMTP id x14mr1187808wrt.294.1571985436529; 
 Thu, 24 Oct 2019 23:37:16 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o18sm1555923wrm.11.2019.10.24.23.37.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:37:14 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E0B931FF8F;
 Fri, 25 Oct 2019 07:37:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 02/73] travis.yml: Add libvdeplug-dev to compile-test
 net/vde.c
Date: Fri, 25 Oct 2019 07:36:02 +0100
Message-Id: <20191025063713.23374-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

This library is needed to compile the VDE network backend.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20191009170701.14756-2-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/.travis.yml b/.travis.yml
index 7d90b87540f..7be2a9949f5 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -46,6 +46,7 @@ addons:
       - libssh-dev
       - liburcu-dev
       - libusb-1.0-0-dev
+      - libvdeplug-dev
       - libvte-2.91-dev
       - sparse
       - uuid-dev
-- 
2.20.1



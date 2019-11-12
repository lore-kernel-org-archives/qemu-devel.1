Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E66C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 14:52:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 066AE2067B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 14:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JVc+NfAo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 066AE2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUXWt-0005Fx-Ox
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 09:52:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iUXVC-0003W9-2R
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 09:50:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iUXVA-00036S-VB
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 09:50:41 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:39956)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iUXVA-00035g-PB
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 09:50:40 -0500
Received: by mail-wr1-x42e.google.com with SMTP id i10so18835998wrs.7
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 06:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=C/T551LsoJCqT8PPcigQnHg90m+bDpmj3ecZkZBc7lc=;
 b=JVc+NfAoiQaF4ZZB6o3dl19lcJOqKkMe6chwTm/qJUAkjE0sQ4vaAZluE+6gMI5aZu
 1a36F2vgnbh52FSKCaxhf6smlbrhIyUm2z1EWtgEXPAnjJi1oYOet96rnQdK3sU/o+UB
 +hhmqMpcpF48TvY4eOsj3FDINXUubbghAc31nVcfmGS1a4T1DWcIvKmO4gHSj6TBiqH+
 SyYKBo9Kaqx+5MSjUMD3CNollxutZhoQdHV8E4iXE/qZ8yiLQcBleDQi3iyOkLYCHSoX
 /4Vj656E+dKsK0eQnFKR3Fr1KhrZ+XWVLoFCqbPupPcz6/ehl24hvFQjRsO3pvP47Wzm
 Efgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=C/T551LsoJCqT8PPcigQnHg90m+bDpmj3ecZkZBc7lc=;
 b=Yzmkc7+euedFU4D8OnGH4kSU1LM9JvxE3P6LJbjST8kgPrgAilB0lYW5RZrHcBZfjJ
 btxQ2HCkOmP9XtiD52MKgvgtG/tJgV3uRSdGttR2Re1ok9zfIoJMXuiqbZ/bMKEXTm9/
 H6H5m29BvIuQFjYkZWT9k5d7bPhTtydepr1ovj+loMtSGtvNjajHp2rVjopiRtK6OEYr
 FydKJymyS+Q0NaaseBnp+ttY0AFxiMX7s2LaSluLeIfK06v9dKbeXPb9RBFH+Jg0Hptu
 P+KnOGvFhMaqQfAWUy9RumZ6ARi7i0CtfDxUXdKK1bVLbo5VsRZ4Uckdb+FIrw4ByzUr
 0nAQ==
X-Gm-Message-State: APjAAAXtYjLzF6D+y36rZv/JSGZpWYNi3cN9ioG8xZfb9ma3WRc4W9Ir
 Pv1T47DBzgwsmX9ei0LScCqg7Q==
X-Google-Smtp-Source: APXvYqziFASSCUOJrRi36d8uxnjuHJQuXM+8nhbN5TCuBuK0b1sYv/Ha57+m+kRwoPCCtfmdQ/yQAg==
X-Received: by 2002:adf:f5cf:: with SMTP id k15mr7830943wrp.265.1573570237684; 
 Tue, 12 Nov 2019 06:50:37 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z11sm24615674wrg.0.2019.11.12.06.50.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2019 06:50:35 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 76BD41FF92;
 Tue, 12 Nov 2019 14:50:29 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 5/8] tests: only run ipmi-bt-test if CONFIG_LINUX
Date: Tue, 12 Nov 2019 14:50:25 +0000
Message-Id: <20191112145028.26386-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191112145028.26386-1-alex.bennee@linaro.org>
References: <20191112145028.26386-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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
Cc: Corey Minyard <cminyard@mvista.com>, Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This test has been unstable on NetBSD for awhile. It seems the
mechanism used to listen to a random port is a Linux-ism (although a
received wisdom Linux-ism rather than a well documented one). As
working around would add more hard to test complexity to the test I've
gone for the easier option of making it CONFIG_LINUX only.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Corey Minyard <cminyard@mvista.com>
Cc: Kamil Rytarowski <kamil@netbsd.org>

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 534ee487436..8566f5f119d 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -177,7 +177,9 @@ check-qtest-i386-$(CONFIG_SGA) += tests/boot-serial-test$(EXESUF)
 check-qtest-i386-$(CONFIG_SLIRP) += tests/pxe-test$(EXESUF)
 check-qtest-i386-y += tests/rtc-test$(EXESUF)
 check-qtest-i386-$(CONFIG_ISA_IPMI_KCS) += tests/ipmi-kcs-test$(EXESUF)
+ifdef CONFIG_LINUX
 check-qtest-i386-$(CONFIG_ISA_IPMI_BT) += tests/ipmi-bt-test$(EXESUF)
+endif
 check-qtest-i386-y += tests/i440fx-test$(EXESUF)
 check-qtest-i386-y += tests/fw_cfg-test$(EXESUF)
 check-qtest-i386-y += tests/device-plug-test$(EXESUF)
-- 
2.20.1



Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626D5C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 07:30:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21F5F20663
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 07:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKjVsO9b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F5F20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVs2S-0006sK-Vt
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 03:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jVs1Y-0006CO-Im
 for qemu-devel@nongnu.org; Tue, 05 May 2020 03:29:52 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:40757)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jVs1X-0003n8-99
 for qemu-devel@nongnu.org; Tue, 05 May 2020 03:29:52 -0400
Received: by mail-pj1-x1041.google.com with SMTP id fu13so638697pjb.5
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 00:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=FnYgEdxyt2ay4TM8GpAh68Hcw+cvRUkpk34QPJDAYbk=;
 b=EKjVsO9btkkSNwp8/MFKsQ5WQcjm4MqDrr82D8UCUb34wqSo4KaedMmcEiCxT7LOLT
 c57Nybg4tE8BE5o830MrlRd5LrRTgJXMDrNKt0CXAEL6d+UQfGBOQadDaHsHOsS4BwZo
 tX4OVAKEK1jQ8EmCekQevgIkaHBWhLLByV35sD2+p4fPLmDwZHTw+ytQdeVFeX+qNEnr
 lX6aU/u6vM59mv+u0YveHcxv/Q/xBn/jhgh3+q7D1soh/wtXvuGL744J2ESV4pwvFkGB
 NKbtV739csFV9P0lx7UwwqeaDDdZhzbpc7//0mlwFmiCMb46fTPLN/eRHK7bn0nJc+ep
 Yqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=FnYgEdxyt2ay4TM8GpAh68Hcw+cvRUkpk34QPJDAYbk=;
 b=No9O50/jvP3GVnslnhWbYNj6rUzLEEkZuSPZJuhJku3mjkfmW5U6l3P3YtlppKba2m
 LMKZs4egzD+r7AU8YYN7QoQq11Nt6UigYO2lK67y8XBIpxKgAveaGq5vwQeHbaaaOofQ
 91m5fMPsEeebQU2coJUMjMKaaGD3XsxE75JOjxeLyOrTvcY/dHVpRBvItHoKVk7YsEdF
 kOt9Zx5I1h9FeYFnOYK2u4gi9chKlLPymrEWn/Jjutxu/V9wNmx+w7fYGFqa019Nb6Y4
 amhxf98Umb2RR0A5H0MuQ5gpLpjc8VXuG0rXRZWDEq5cgoEaLe0KQl/+mGtxX6vn2W8P
 BSFQ==
X-Gm-Message-State: AGi0PubdG55Xo6zD6uEPmypawEC5Z/addJmZaZ5PJUHNzDc9ksDPXmEN
 4kn/mJ2sshKsgUzMiuxI8MA=
X-Google-Smtp-Source: APiQypIc7SXe3/DTeldlTC/SYd3ExsqxEE43lqNq/J0M3vfEVbcgzhWqld5tOQH7jsjInG/xRciNRQ==
X-Received: by 2002:a17:90a:2365:: with SMTP id
 f92mr1280815pje.117.1588663788562; 
 Tue, 05 May 2020 00:29:48 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com.
 [34.92.144.28])
 by smtp.gmail.com with ESMTPSA id z6sm1163152pfb.87.2020.05.05.00.29.45
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 May 2020 00:29:47 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH] tests/Makefile: Fix description of "make check"
Date: Tue,  5 May 2020 15:29:31 +0800
Message-Id: <1588663771-5534-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Huacai Chen <chenhuacai@gmail.com>, Huacai Chen <chenhc@lemote.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The description of "make check" is out-of-date, so fix it by adding
block and softfloat.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 tests/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 03a74b6..5d32239 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -4,7 +4,7 @@
 check-help:
 	@echo "Regression testing targets:"
 	@echo
-	@echo " $(MAKE) check                Run unit, qapi-schema, qtest and decodetree"
+	@echo " $(MAKE) check                Run block, qapi-schema, unit, softfloat, qtest and decodetree"
 	@echo
 	@echo " $(MAKE) check-qtest-TARGET   Run qtest tests for given target"
 	@echo " $(MAKE) check-qtest          Run qtest tests"
-- 
2.7.0



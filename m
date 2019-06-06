Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE86C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:04:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14F1520868
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N/5VKgXJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F1520868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36164 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYwkq-0004mR-3y
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 14:04:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwUB-0004as-Nr
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwU8-0004EO-5H
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:35 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hYwU7-0002oc-Nr
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:31 -0400
Received: by mail-wr1-x443.google.com with SMTP id x17so3322039wrl.9
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 10:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=pYfiMlZ410Gu/yfJlg4smSlx90e446JdIiRcC7Wt8I8=;
	b=N/5VKgXJeJgKaBkyidWHeRwTXUGH+kCReU1OdaXezEzQylde7mvNxNYq9ewGJqWN/b
	Qssd6wWbuEd/kOq9FrEeCUqNl5MlItnGRo5OgfLREYpOqyxKX39sc4gBDue6kIzDmWQi
	ddKHw2lo3jQekv8aE4+bOXpihzXtfAOSKlZ22xFVOjYznI8cid0O1FqVIhzCAdqcf+sO
	GhDZyudLN2KiwzNMmoVS0J4aRZ2YtckDmqMlAzcItHfCt+9HqM4jPy81Mdg7tbRZ+4Ml
	Tvg32iEPjWLmJV8s/xSNeGYGd+zJYDs/jgBQrH5NjzBZLv97zsGGMhbRqXO72AL7MgGD
	TpqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=pYfiMlZ410Gu/yfJlg4smSlx90e446JdIiRcC7Wt8I8=;
	b=HCB+/ptL4A7bs/LHJ4LLIPBveXYB4YGL7qPN8IGw+oQTZFCua+OJV0GCxIk2rqUcoZ
	SqeB48TZJ6qI6Vp/O8AK/95+si6xUjQIlyTA5di5BHDaIDT3EcmQIX0qAO54ld/ZgPez
	C5jm8ZuG1Eq7ME4sVkF/C+vTury9iTcGZGEUh17umus28G7l5C2bqikALloYe564TBKt
	/Sf6OGh9sDCQaBtPfADkQPrr8HKuNp2XJHjt6CcNplJtpjibZyIcuZT3uZDirxbqGR6A
	IWhXRvxMoYOal45EuQJaTIQ3xywo8EmpKU/90a6PybbQy/q37gFt9pZeKMfYBKD01YO+
	AEYg==
X-Gm-Message-State: APjAAAXslTuT9GCOhZFQRQV1KAlK6NIneOJcJGHdtkRggzG36Ra92r7Q
	L/p8ynrh+YowEY52y4xFo/n84Q==
X-Google-Smtp-Source: APXvYqyC86SQAX8n8+Ua7px2+ong1PVIu8wgAMIYuaDsmtLEbN2Mvgcpl2x/Vr7I0FSudq9bj6g4PA==
X-Received: by 2002:a5d:4603:: with SMTP id t3mr7682237wrq.315.1559843175592; 
	Thu, 06 Jun 2019 10:46:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	z135sm2596784wmc.45.2019.06.06.10.46.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 06 Jun 2019 10:46:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 18:45:31 +0100
Message-Id: <20190606174609.20487-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606174609.20487-1-peter.maydell@linaro.org>
References: <20190606174609.20487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH 04/42] target/arm: Fix Cortex-R5F MVFR values
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Cortex-R5F initfn was not correctly setting up the MVFR
ID register values. Fill these in, since some subsequent patches
will use ID register checks rather than CPU feature bit checks.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 9b23ac2c935..044c4dd738b 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1608,6 +1608,8 @@ static void cortex_r5f_initfn(Object *obj)
 
     cortex_r5_initfn(obj);
     set_feature(&cpu->env, ARM_FEATURE_VFP3);
+    cpu->isar.mvfr0 = 0x10110221;
+    cpu->isar.mvfr1 = 0x00000011;
 }
 
 static const ARMCPRegInfo cortexa8_cp_reginfo[] = {
-- 
2.20.1



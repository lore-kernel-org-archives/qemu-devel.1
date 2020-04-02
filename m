Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A70C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 14:40:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 613D92073B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 14:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GejGCJsR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 613D92073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK10r-0005wp-JP
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 10:40:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35239)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jK105-0005Pf-Ei
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:39:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jK104-0005eJ-7z
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:39:21 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50723)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jK103-0005bG-Ru
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:39:20 -0400
Received: by mail-wm1-x342.google.com with SMTP id t128so3673790wma.0
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2020 07:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=83ZRYjP7Cso8kfe2/ahqnYSn4mXDEL4qszyd16y6VQc=;
 b=GejGCJsRn2IjQc6ueAWhqhiy0pPpIU/ggReu3leNCjgcO2xcku0wQbEkN8B8lyziN+
 SqvAWIO9J0HL77V7j1QkM2w9Fag8O2S/rmvddlZL+IKuqbXagemdDFdCsPTXjxQx8zVb
 LLydpQ7eTNmSNAy5gG8TzwP+NKE3/sskb4XY6hclOg6pfM1WFTwoIFssuJxPsTg3ymZP
 gAG4Fz81f2o+ajkb6fv4CvygP1NwHMFSbNGZpMnkBock1FoiTeXs+BHZ4TpJqO2xsaim
 u48xSXfvgmd6ppHI8E8DjfYrA2+x0brG3mK3PEtHnn+JCsJnJKzn0ac9hE+voLq/MjuL
 x4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=83ZRYjP7Cso8kfe2/ahqnYSn4mXDEL4qszyd16y6VQc=;
 b=fdY2OQrAq7A4yjZ1Zs4+Zh9eaWznxv+pmvioY1FjOygnR30blwqCD6ynJZgW95HGIp
 oyVt3i9S0FIXVvcA2zon3uP3qYsUViXYxeUbBXLpCIQg9E1SVTVyIvHJ2ppUt7lwU4L4
 wO5GikCoV6J7mgQBobZiiIg0qhll4RmGu/hhdINv0GiFwNc9gY13SXTbyCji1JihwoBG
 DQFKCY5knocVUpITjW5CWCw0y4JpwuVyoJeeukfnLqhbvh35YMMkS4IFeptfuUhpuJdz
 VofG4xdiRZmXcXBmZpiFIkOniEiQvbt3/Z4hYU8a9BrGncYRvmGII32NCWrL7BEu3g5o
 X6GQ==
X-Gm-Message-State: AGi0PubJeevS5gPK7xMQd1tdsSkINx9YKgrYrtOMiUNOG9Dw5J26Edti
 4P7eGPpmNyOJN9ow6wV+mYb96w==
X-Google-Smtp-Source: APiQypJQl2vNfKmHxXEeZmT4kL6PlGmIPpmUNq+tpj/4vsqf51y0C0pRFQ6tDh1figv9lnvNMMP7sA==
X-Received: by 2002:a1c:99d3:: with SMTP id b202mr3904122wme.170.1585838358264; 
 Thu, 02 Apr 2020 07:39:18 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u22sm7540146wmu.43.2020.04.02.07.39.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2020 07:39:17 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 70C6F1FF7E;
 Thu,  2 Apr 2020 15:39:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Subject: [PATCH] target/arm: don't expose "ieee_half" via gdbstub
Date: Thu,  2 Apr 2020 15:39:13 +0100
Message-Id: <20200402143913.24005-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While support for parsing ieee_half in the XML description was added
to gdb in 2019 (a6d0f249) there is no easy way for the gdbstub to know
if the gdb end will understand it. Disable it for now and allow older
gdbs to successfully connect to the default -cpu max SVE enabled
QEMUs.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/gdbstub.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index d9ef7d2187c..8efc535f2a0 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -192,7 +192,12 @@ static const struct TypeSize vec_lanes[] = {
     /* 16 bit */
     { "uint16", 16, 'h', 'u' },
     { "int16", 16, 'h', 's' },
-    { "ieee_half", 16, 'h', 'f' },
+    /*
+     * TODO: currently there is no reliable way of telling
+     * if the remote gdb actually understands ieee_half so
+     * we don't expose it in the target description for now.
+     * { "ieee_half", 16, 'h', 'f' },
+     */
     /* bytes */
     { "uint8", 8, 'b', 'u' },
     { "int8", 8, 'b', 's' },
-- 
2.20.1



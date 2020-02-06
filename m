Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B055C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:13:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A2A9206CC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PIqbvlLh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A2A9206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izf6E-00048F-62
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 06:13:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50261)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoh-0003Un-RX
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoe-00008E-8M
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:26 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40930)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izeoc-0008QR-Mm
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:24 -0500
Received: by mail-wm1-x344.google.com with SMTP id t14so6454163wmi.5
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 02:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uQeRQPEKMOcWPvlRDHHWa6BNcZ4eAtEnkfQGNcpZ9xw=;
 b=PIqbvlLhvmLVeCk3FxaxKAaCjYiuTO4y8ocVQBO3iVP4pjrMO+OzsPJ9IpMZPGKQSg
 gUrzTkQMnToWozjibdbAqoUzDRQvoa+32ayhv+SoUlvykU35kY83krXhEvj1Upz48jlZ
 2O04NEzE4yhwi1IqStujIWmj0DtoztjkM1PYzyjxiJfX7icAXafpjCvQ/QlBKFqkXKPu
 6end1jljtJ/UpqEKu/leGzpasqLn6FDcF6aWwH6pB/eCrWoqg+OyDPYRol/JglXQ8WTS
 a4lqviM82pi1z9lY00AJBIARXbhBHiwlkwrZXYPsIhRuI0Q/FFuh68c6IVnGvEnggdeI
 10Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uQeRQPEKMOcWPvlRDHHWa6BNcZ4eAtEnkfQGNcpZ9xw=;
 b=FMCf8GwNNDDcwMAoiSzgpYvJq1U9RiaVHmJVcWSS27cIDp8g9o4VD/aAu+7YsgJZW5
 eKdn4EanyJFcufq9vUUGT1QyPvTsWHWLkXEoQGBqCtZMsCa4ZJbNuAN0v0IJ3jcqWRIX
 L8rP0JAexZuImFNIGOxj6+QwGdwewluPu5eBFbT5NUiN/dJMBZx0w/5WSorJOlgs7N+y
 fXsjnJMm+kzi/0RE89TKdZLwoFAkmTHM3JZeGFsBYxoSts2R2bHGHKKXg01KuFjx8yqH
 XVsuwazz2fBB/68hjQtYd9XCBwGxnUvlFZ5abupFOFVt8uUM/9dMAqac9v17oLu8BBFY
 ikxw==
X-Gm-Message-State: APjAAAVY8r77z8pMJ/mji3OUY9P0HI4sy/TfIEwgz2XkWOEtP2ekVEX6
 e4jYl+Gk1kaUEQH3rVxOSeWgKgsVtLqYXQ==
X-Google-Smtp-Source: APXvYqxSGB/HvCq++BwjOm1CcEKT6V+QNQUmMBU1g793ULTwV92GF2FEe1XhRgMM92rQVsfXGZ2APA==
X-Received: by 2002:a1c:6308:: with SMTP id x8mr3969593wmb.80.1580986521286;
 Thu, 06 Feb 2020 02:55:21 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id m21sm3364995wmi.27.2020.02.06.02.55.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 02:55:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 37/41] target/arm: Enable ARMv8.1-VHE in -cpu max
Date: Thu,  6 Feb 2020 10:54:44 +0000
Message-Id: <20200206105448.4726-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206105448.4726-1-richard.henderson@linaro.org>
References: <20200206105448.4726-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 2d97bf45e1..c80fb5fd43 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -672,6 +672,7 @@ static void aarch64_max_initfn(Object *obj)
         t = cpu->isar.id_aa64mmfr1;
         t = FIELD_DP64(t, ID_AA64MMFR1, HPDS, 1); /* HPD */
         t = FIELD_DP64(t, ID_AA64MMFR1, LO, 1);
+        t = FIELD_DP64(t, ID_AA64MMFR1, VH, 1);
         cpu->isar.id_aa64mmfr1 = t;
 
         /* Replicate the same data to the 32-bit id registers.  */
-- 
2.20.1



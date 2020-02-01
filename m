Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE4BC33CB3
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:46:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07D66205F4
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xMOVYkso"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07D66205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixyiV-0000Np-5r
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 14:46:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58967)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ixySy-0007yh-5e
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:30:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ixySx-00079i-7v
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:30:04 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:36988)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ixySx-00076n-1V
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:30:03 -0500
Received: by mail-pl1-x643.google.com with SMTP id c23so4182155plz.4
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 11:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=j8oEYEGJE/U9npgyXl/EoNuorLqJKdNjKvRjstMsLjY=;
 b=xMOVYksoAtkKs8TNkXMKO9UrZJIDEmUnydwZm8+q06TDK+7Cv5q1AjOlr94vaC/YnG
 5UUAGhMTLuFmcWtM7EvyAfIWD1JCDuuwU10Fw6dlEzDLwr75S7udoKD9ruSXqm9ANXKp
 8raoHUkK1jAFI6GbJWRT8UDdAYQD1HUYwOF2riA53/KpXiFDt0n7tCtQ1Ir7/d+1YwbJ
 Nz7O4n2JJLal7TnPmTJLbcXR6QD1kzWLkU5fmyzuX8miYAlYUwwOMLwsq93B2bFQ1dRN
 xT1HE78e9cUFXpCznEIfjaNdn3QAOPbS7eKS4fOB9N7gghDQWkNFvVxt9zO1xDP7pq2Y
 oaGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=j8oEYEGJE/U9npgyXl/EoNuorLqJKdNjKvRjstMsLjY=;
 b=TedDaicyshz2x8sHvkBUssJex2ri4fwRUlxXQud9noLmIPgAFcg2oTL/22YOOMXY6N
 yPNon90O8hPr98Y3o8+zZ9TB/kGZIN6pgNlkg6Dgg1OMLD2207jQkC1C+gNB24bkHjiL
 DAi/nkNyY4pan+jNPzrT5ynJyuBsGagwrVN9HkWQF978/edWaW97HQgw/sw6SyVRayBu
 CNooPgG0gIixWBsxM+Ce8DvfqkraLaVyYSlGUOyLn+dCVLBD7a6+5iJhqk1tn2wqH324
 UN/Hi54T6TAHZI7Ic4L/Gbpmla5jh1yZ2Cml8miur+4hwLZWKzcod/xmcFF73xL0iB7m
 V3og==
X-Gm-Message-State: APjAAAUEbJoudyBTJ1fX7WVtLRyCwnoxIm1aE/N6QBKbqJgFSQbP2iE3
 e32d6RY4uqMJoXhRjlbI0VRu8M/grh0=
X-Google-Smtp-Source: APXvYqzXu2+9x0AB09hItrPSx+76diIz6etxxO9hvlGehjrkvVhnoiXyHJsjJN7aP+Sj0/g5Ofvs+Q==
X-Received: by 2002:a17:902:6809:: with SMTP id
 h9mr1780098plk.32.1580585401808; 
 Sat, 01 Feb 2020 11:30:01 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id l7sm3668509pga.27.2020.02.01.11.30.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2020 11:30:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 37/41] target/arm: Enable ARMv8.1-VHE in -cpu max
Date: Sat,  1 Feb 2020 11:29:12 -0800
Message-Id: <20200201192916.31796-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200201192916.31796-1-richard.henderson@linaro.org>
References: <20200201192916.31796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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



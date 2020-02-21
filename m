Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E74AC35656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:22:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E22F8206D7
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UpwcwZ5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E22F8206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58G0-0004ie-16
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:22:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56679)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j582L-00074h-LL
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j582K-0002s8-D2
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:09 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39767)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j582K-0002qx-75
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:08 -0500
Received: by mail-wr1-x444.google.com with SMTP id y11so1995803wrt.6
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=fKZcomZs0VaBPiSTJ1VeQVN6QYLYuVLclLOmNVPEHRo=;
 b=UpwcwZ5oKzwuT5HkeJYNWfxQrNjf/7ouqqjBLbV6obmHPLx1PkG+hJSi3+GU0GFtIL
 4wvD6+IY99QtlkErBuzl/5JGvt5fcvRdPg9ELqPUdXGOfg/7JJFvieMvB1664A4EZ8j0
 J13tTSTk1AcMNal51ax30iu14VX5zNhbzSpfT7WMZYfEHKw2d9XJ00r5cTe+WSSfNdOf
 AmgH3E7oeDNofFgwymrNOz8LL0as3GVlxGS8zMedRBl48kywclsF30nTaJqy0CfU5D2o
 CoDZ5XTXO9QU2eejtSPV9VPLNoAVvJutd2avPR49fgj5UTLOD1eiSkb8w0xwO0m5Zunc
 /Evg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fKZcomZs0VaBPiSTJ1VeQVN6QYLYuVLclLOmNVPEHRo=;
 b=CVtvD46uokVt/5VsyXxPAaIO27AzUhLnwZ+01h3ycF6wX8jHnMkwYblUWF3rfSZwGE
 NPCYvZXO8GrBeMB8cV0XxxehGMXd3Fv/KHdhsxiqxQOVGpSqZfGCYPAIGr2ZUWHHORd7
 0eQ/6lfTUABv3gy58S8QNVRjVf6KSP0HRzU2nqdDy96TqPDVyP7DEYkzhOmAer8jdxBP
 h6wpECpyO/PDEr14e6K/StbsVwBoM/j2sLoHo/E63mf4neEZfZaHTWJdCZH/GlqWolg9
 Zwq2GTdZp4DUrdXoXCjEvMBJaPVqzNdgh8JFRFSrefHC53nIUPHxI/BP1rC3OzsXAVVl
 4KLg==
X-Gm-Message-State: APjAAAVEZVtt9fas9SccZ6iyoeNNVm6keBXCG6n0lO0fQxwTOzwFm1HJ
 ktERJx/EL4THVvp3+KeSJe8KB9K3GN098g==
X-Google-Smtp-Source: APXvYqwjpscEU5D7ns72kwjIMNMLfsgb7mpj6jeOYEYTnwJeLMAsHXOUD+xURLO0OQSd5+/B07diXw==
X-Received: by 2002:a5d:6a52:: with SMTP id t18mr46749984wrw.335.1582290486982; 
 Fri, 21 Feb 2020 05:08:06 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p15sm3598892wma.40.2020.02.21.05.08.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:08:06 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/52] target/arm: Use FIELD macros for clearing ID_DFR0
 PERFMON field
Date: Fri, 21 Feb 2020 13:07:08 +0000
Message-Id: <20200221130740.7583-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221130740.7583-1-peter.maydell@linaro.org>
References: <20200221130740.7583-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We already define FIELD macros for ID_DFR0, so use them in the
one place where we're doing direct bit value manipulation.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200214175116.9164-8-peter.maydell@linaro.org
---
 target/arm/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 12bf9688007..1024f506c51 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1719,7 +1719,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 #endif
     } else {
         cpu->id_aa64dfr0 = FIELD_DP64(cpu->id_aa64dfr0, ID_AA64DFR0, PMUVER, 0);
-        cpu->id_dfr0 &= ~(0xf << 24);
+        cpu->id_dfr0 = FIELD_DP32(cpu->id_dfr0, ID_DFR0, PERFMON, 0);
         cpu->pmceid0 = 0;
         cpu->pmceid1 = 0;
     }
-- 
2.20.1



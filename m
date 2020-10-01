Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB627C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:10:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3984920706
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tdkSmxE/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3984920706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO1AB-0000sw-B5
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 12:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kO11I-0008Jr-Pt
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:01:24 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54078)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kO11F-00073w-4u
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:01:24 -0400
Received: by mail-wm1-x343.google.com with SMTP id x23so3472242wmi.3
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 09:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KAzkYKKavvSQCbtYv8JWrT8eSXOG4QFZI4u6wSWQ8vA=;
 b=tdkSmxE/9EiRElzDrY2wQBZnB3pVSNUXe5ynTRBOkvAJj+0svkXHH2m3GkUCd3Ho7Z
 tpNXxCcSZu0MOxFdGC891pkbz/48CSjrdeYBvi5ZouQBc7LB37kF/OuKryoKfkjj05bs
 Vd8o17yYjijMoXfKwwTGboB58GJj9v8bLSYUh5P8SuP8uJCS+r4+7RHYNuK4JJFty6s+
 OrhKTMnis42frzYtG4IRImmUs8VzSCpT+0ELbrxr2MxmqyxWZKJCsxBBwZe6sdkrqlHF
 u9UfjzkCNaeQridLKDJdEMxqdbVM2mLCoN5G3JizhSbCy6RpgeQIK9xNbdJ9cz17H7Sc
 DJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KAzkYKKavvSQCbtYv8JWrT8eSXOG4QFZI4u6wSWQ8vA=;
 b=o417lXAEorMwxbPfXTj1/vnBLrD1pfnER5m3O81L8yjgGmjc9tD5wqlfWAHoDpGqdi
 nFhaRULLUx24v1snUy24nDd3ng4DySkOIfibmMHpd42xpJWRQF5t2vo5R0YwbAEjz+uO
 6bf+GwoE7G0pvLOqFxNcZLsvx56sRxDeCZBDDTrXHO8O/S7Zu1DrLc7E5gYm0z0+cokY
 T35mywmxO0CvztJ6lwQjlVbhwKqt+uZE9KnLgo/f0XYOyQgHIsXrzw8La7lVcMW21Z+O
 sEbedVNQzvRHANJhrmcQsUGPgqQjfLoW5sPCxMHGEyJYSfMHAkE6TFrTzkDzvfEgfaB8
 MX4w==
X-Gm-Message-State: AOAM531elP4Zc6fNlHiMctFQs3/QNIZMhEJOgJ/rM0qg+1TIo5Exl3+U
 tV9GvwYynTuAeVXWMCrQI6fXXQ==
X-Google-Smtp-Source: ABdhPJy1MSPrl3CUXTtT61ibV/mY04MftSuHWAxNVyk4/H4X+s9gZgvHfn5gZFTr1+LP4x07IhqW2w==
X-Received: by 2002:a7b:cb07:: with SMTP id u7mr673347wmj.57.1601568079212;
 Thu, 01 Oct 2020 09:01:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y207sm587123wmc.17.2020.10.01.09.01.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 09:01:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] target/arm: Make '-cpu max' have a 48-bit PA
Date: Thu,  1 Oct 2020 17:01:16 +0100
Message-Id: <20201001160116.18095-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU supports a 48-bit physical address range, but we don't currently
expose it in the '-cpu max' ID registers (you get the same range as
Cortex-A57, which is 44 bits).

Set the ID_AA64MMFR0.PARange field to indicate 48 bits.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I forget why I wanted this patch originally, it's been so long
since I wrote it, but it seems like a useful thing to allow -cpu max
to have a big PA range...
---
 target/arm/cpu64.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 3c2b3d95993..3ba7f1675cc 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -653,6 +653,10 @@ static void aarch64_max_initfn(Object *obj)
         t = FIELD_DP64(t, ID_AA64PFR1, MTE, 2);
         cpu->isar.id_aa64pfr1 = t;
 
+        t = cpu->isar.id_aa64mmfr0;
+        t = FIELD_DP64(t, ID_AA64MMFR0, PARANGE, 5); /* PARange: 48 bits */
+        cpu->isar.id_aa64mmfr0 = t;
+
         t = cpu->isar.id_aa64mmfr1;
         t = FIELD_DP64(t, ID_AA64MMFR1, HPDS, 1); /* HPD */
         t = FIELD_DP64(t, ID_AA64MMFR1, LO, 1);
-- 
2.20.1



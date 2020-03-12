Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448E7C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:45:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 095A220637
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GnCf108v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 095A220637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCTlo-0003zq-5r
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 15:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45032)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTiu-0004gI-Jz
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTit-0001ix-N7
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:28 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:41397)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCTit-0001i5-ID
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:27 -0400
Received: by mail-pg1-x543.google.com with SMTP id b1so3560891pgm.8
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 12:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TuDXY8WtYwDto50sdZbxkvATe/WJ3RvHtYzcjTWxYkY=;
 b=GnCf108vR5bX8LMMRe1xZP8IiaNC8+YrInhj2riL7OZFyjXFPfrfryeFWlC0GsQc1P
 5JAY/4xxvd9L4+u5JnLzwCbSVlgaerxGns9CPOccrHpgKCOQocBGhLJGB6oMrq08SkgE
 Hq46ASe9vFeYP05uo3U6MRSGSA/MIxKNAKMOpuP7zC+GAQcWTkTXW8PrU2f1LR0Xvm13
 g2MOxIoQiXt6M0aYECg6h/3iyFGNuDlwaqrIe0WB/qlGkTRRH7b1vrZ/rM0bs9z8wjUp
 gzyKX8Aj2NVGwweA/86iDBiooG/N6hG0s6kV1RGpfARoFlAwLTs65OYJTa4YXsnLqBOZ
 De9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TuDXY8WtYwDto50sdZbxkvATe/WJ3RvHtYzcjTWxYkY=;
 b=ejykjtp210OsSdpbvjG3CAhjyvDwb1Q60I1L1Ug/EwHh4/qDOMrMbZc9SluwuoHCJQ
 JNnx9bupbrnD5QyZdsgmDal5iDuqyq4+UktY/liaVIx6BADoRDvHrzX+Lw1AMx7P40SO
 1AmXIYJdI3omC3aozK1uPIIq9uijOeKjG/pKes49WQvHXmJmaV5RqcjNf4utSsWYpNmc
 KIndARGYHLJYq+/cRvu2ASl7WGeFiXYCbXMXfRIZ7gXf24wvTVIFpSkk/ftAOoyFIJOh
 EP2D32KIO5RXAdRWYqXZtlPNS12ffa05Aestr/b9WMX7VktitrrWQFL5NLEgmUCbfQzu
 GTcw==
X-Gm-Message-State: ANhLgQ2A3bC7UzjtAExAEVik0JkoW1w2l2XS+53iMAUWoKQtW+wZqTNV
 InE92Lt12/TTPhw5wAQOKqY8Tkg9J6w=
X-Google-Smtp-Source: ADFU+vuyfDBSYoUSBeivLQs/b/kvfaEicA7KvhH4xr0pFuTl5AhHpT0OFxnWyPjrQrUV7Ll1/oCcBQ==
X-Received: by 2002:a62:750c:: with SMTP id q12mr7435234pfc.304.1584042146229; 
 Thu, 12 Mar 2020 12:42:26 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id g69sm6824842pje.34.2020.03.12.12.42.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 12:42:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 04/42] target/arm: Add support for MTE to HCR_EL2 and
 SCR_EL3
Date: Thu, 12 Mar 2020 12:41:41 -0700
Message-Id: <20200312194219.24406-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312194219.24406-1-richard.henderson@linaro.org>
References: <20200312194219.24406-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 97272502ce..b9267ddbc2 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1976,6 +1976,9 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         if (cpu_isar_feature(aa64_pauth, cpu)) {
             valid_mask |= SCR_API | SCR_APK;
         }
+        if (cpu_isar_feature(aa64_mte, cpu)) {
+            valid_mask |= SCR_ATA;
+        }
     } else {
         valid_mask &= ~(SCR_RW | SCR_ST);
     }
@@ -5238,6 +5241,9 @@ static void do_hcr_write(CPUARMState *env, uint64_t value, uint64_t valid_mask)
         if (cpu_isar_feature(aa64_pauth, cpu)) {
             valid_mask |= HCR_API | HCR_APK;
         }
+        if (cpu_isar_feature(aa64_mte, cpu)) {
+            valid_mask |= HCR_ATA | HCR_TID5;
+        }
     }
 
     /* Clear RES0 bits.  */
-- 
2.20.1



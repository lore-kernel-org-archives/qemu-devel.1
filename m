Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C64C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:55:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10B8820639
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bqIFDoLY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10B8820639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA9CR-0002sQ-7F
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 05:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95Y-0004rN-SN
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:28 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:37880)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95X-0004nG-4q
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:28 -0400
Received: by mail-wr1-x42a.google.com with SMTP id y3so7988249wrl.4
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 02:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=pJN8+LcfVLeFiNPeCoxtXt7wzipaKiTYfFygqw+Wy9M=;
 b=bqIFDoLY6ff7Tn9hEEB5b03CIQOA+hdM5kmN5qt083tFZRWOhHFpiTF/Z+xxbPkLl9
 Eioq0wzsBawH+hF5DyXp6n/uOLEAoFWefZCXC81nCS6MeNZx7dFvs+uo9z7w5RaEredW
 CcawJoUNXwRQclpAQUE18oGY0VDcID1kHJ9NxLBuOUCtbem1NY+nB5uL5l84EMja3piy
 Z57FbO05SR7kC09IblrOPJTthJrn9Z21lE1moHNd9DHRfrP7AkmQfJbKmIof5j9WPTAI
 cjNkFaW8BehckhfK+IN8datMBZazuwDgnRjAJOyYSJ8JDOR4b/nUt8BKz2DhOrImKlOF
 Z3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pJN8+LcfVLeFiNPeCoxtXt7wzipaKiTYfFygqw+Wy9M=;
 b=PoTuSK/TtzOqY49VSILgXtVq5AiI4kGv7JqQNNRQISFcO2taBptChZs4J3irxRCmKM
 7mFvalL/rg67tguFDd+lhgFXcCqrb/MTu/CAeByUOYgBhzKMuqcIyZpFgmPjE/ndCvQp
 sNkTrtRUpBlOjVwjSk2DIsErzMP1UVuUvzfvUH76uARAZyQ5tSeC88wfF7iPKyMgiU7S
 m9xVAe7xadRuBRiVDD53B4fcksMPJAUJHYOzTng7H66sUtSgfK4zDd6dqdP+HLSn73x0
 IuexYUE2SlPTq5wjJ75k5AuEScy0Lf1eHGu5mcH+ehMUH/aU10H5zIp5JarFHFFdtqb2
 q4xA==
X-Gm-Message-State: AOAM533gG+Nu/k5Yuvfo2LyunLCkAqFZJnCTsXgy9CHRSRWcpWtGYmMd
 SPvDBMPkc7PrBr+qnvaXzMKTyzohYoY1CezY
X-Google-Smtp-Source: ABdhPJyByLPjwubt6ZfXK9r5DOUUjTFiHvB1LijTzr7kqm3v/rIvbC91g9eGqScUvHFm5ytgZL5fGw==
X-Received: by 2002:adf:ec10:: with SMTP id x16mr4848405wrn.74.1598262505544; 
 Mon, 24 Aug 2020 02:48:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q6sm24877057wma.22.2020.08.24.02.48.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 02:48:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/27] hw/arm/smmuv3: Let AIDR advertise SMMUv3.0 support
Date: Mon, 24 Aug 2020 10:47:54 +0100
Message-Id: <20200824094811.15439-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200824094811.15439-1-peter.maydell@linaro.org>
References: <20200824094811.15439-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Eric Auger <eric.auger@redhat.com>

Add the support for AIDR register. It currently advertises
SMMU V3.0 spec.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200728150815.11446-10-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-internal.h | 1 +
 include/hw/arm/smmuv3.h  | 1 +
 hw/arm/smmuv3.c          | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index ef093eaff50..bd34a4f3300 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -64,6 +64,7 @@ REG32(IDR5,                0x14)
 #define SMMU_IDR5_OAS 4
 
 REG32(IIDR,                0x18)
+REG32(AIDR,                0x1c)
 REG32(CR0,                 0x20)
     FIELD(CR0, SMMU_ENABLE,   0, 1)
     FIELD(CR0, EVENTQEN,      2, 1)
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 36b2f452539..68d7a963e0f 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -41,6 +41,7 @@ typedef struct SMMUv3State {
 
     uint32_t idr[6];
     uint32_t iidr;
+    uint32_t aidr;
     uint32_t cr[3];
     uint32_t cr0ack;
     uint32_t statusr;
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 89ab11fc36a..718f28462ea 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1251,6 +1251,9 @@ static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
     case A_IIDR:
         *data = s->iidr;
         return MEMTX_OK;
+    case A_AIDR:
+        *data = s->aidr;
+        return MEMTX_OK;
     case A_CR0:
         *data = s->cr[0];
         return MEMTX_OK;
-- 
2.20.1



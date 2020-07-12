Return-Path: <SRS0=QItv=AX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47F3C433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 23:48:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E85020674
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 23:48:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E85020674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1julhe-0003e6-Ph
	for qemu-devel@archiver.kernel.org; Sun, 12 Jul 2020 19:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1julfB-00071x-HV
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 19:45:41 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:60905)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1julf6-0007FS-T1
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 19:45:41 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.2329539|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0445976-0.00064884-0.954754;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03294; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=6; RT=6; SR=0; TI=SMTPD_---.I0oni3i_1594597526; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.I0oni3i_1594597526) by smtp.aliyun-inc.com(10.147.40.7);
 Mon, 13 Jul 2020 07:45:28 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 5/8] fpu/softfloat: define brain floating-point types
Date: Mon, 13 Jul 2020 07:45:18 +0800
Message-Id: <20200712234521.3972-6-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200712234521.3972-1-zhiwei_liu@c-sky.com>
References: <20200712234521.3972-1-zhiwei_liu@c-sky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/12 19:45:28
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Cc: alex.bennee@linaro.org, wenmeng_zhang@c-sky.com,
 richard.henderson@linaro.org, LIU Zhiwei <zhiwei_liu@c-sky.com>,
 wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
---
 include/fpu/softfloat-types.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index 7680193ebc..8f8fdfeecf 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -112,6 +112,14 @@ typedef struct {
 #define make_float128(high_, low_) ((float128) { .high = high_, .low = low_ })
 #define make_float128_init(high_, low_) { .high = high_, .low = low_ }
 
+/*
+ * Software brain floating-point types
+ */
+typedef uint16_t bfloat16;
+#define bfloat16_val(x) (x)
+#define make_bfloat16(x) (x)
+#define const_bfloat16(x) (x)
+
 /*
  * Software IEC/IEEE floating-point underflow tininess-detection mode.
  */
-- 
2.23.0



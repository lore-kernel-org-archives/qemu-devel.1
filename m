Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD46C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 04:20:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 998BE206E6
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 04:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c5IIcB5F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 998BE206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh3qG-0001wT-QO
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 00:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jh3ne-0004Qf-06
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 00:17:46 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:35584)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jh3nd-0000kQ-9w
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 00:17:45 -0400
Received: by mail-pj1-x1043.google.com with SMTP id 5so2179509pjd.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 21:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IX3UPP0As7IJLtjhajwCoyh2nTlTRQqiCGAXcYWkMx4=;
 b=c5IIcB5FKwiU5Shz5dBmNSFf2/+yMQYk3+n1aXADbGuu7tvM0D77n1PiYwK/aL77Aq
 tGwy5FJ2AH5OBcRGodiau7ZzLu70Uama4OjM/xxjE0BPRDEaycvEVmariATtEPoOX9ol
 UQdn4dzFFmQ7lylVEznpWAUtAuqmKUJqeoXZqYxke3m+ZV3IiV7uVpb32qRgBXJEP99T
 SFmJBcsTgPqOYi2cXcuX0hiNVkTBoe3MG2ym/RSi9+vxeCRmHEoVTKwDG1FUEN65h5Le
 i2RHeiDs7atAu/zCFZh4rPK/YZfhQfeFLrQMZODy7xeEuSYnlGxyePMvUjVOsxHuqqtS
 3P6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IX3UPP0As7IJLtjhajwCoyh2nTlTRQqiCGAXcYWkMx4=;
 b=ZfXoRp86VutsEgn3yPBUIXKB7uzvFfs/HNjS9DnQwiZQ/7Z4+n8kYELOnn6poe+s4D
 iBf9jxph8h5P362DrNa84/wo9tWnso7M58MS/ti1s2Jm8bHr4WnfonvYbTm5haL2AKGm
 c/GaOl800LWdYVup2XfljuKJTfMnXZjYGynN9I4hgCdIxrRskgmglSoNNROTolkBsRfL
 yPHVmiXgemdmGKbrYDexXHE3z3IkByD6JpOCTVn3DYMzM9C+T+gX0dejVUcCVM7rj68G
 Iw9oO8rnruqz6wjAqcJlYGl0yO0akFpqhMNCj7QqENzi7kUa90fV86F5XSJ8d7j+Wzmo
 xY4w==
X-Gm-Message-State: AOAM530Qjs2S1otysk0ODbmWyqrLkFjozi/3v/jjG88SGUcVdNyqZXgG
 wHtaxi34fGcwW10kBgYfZN3wjoITneE=
X-Google-Smtp-Source: ABdhPJwIxlO7xYTHArB3jOysYqxblDCQBahjSZfQDMvEQONmORNB9pMs8oHlwndW3bKDgubS4PvHgg==
X-Received: by 2002:a17:90b:283:: with SMTP id
 az3mr777657pjb.232.1591330663718; 
 Thu, 04 Jun 2020 21:17:43 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id h15sm5440902pgl.12.2020.06.04.21.17.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 21:17:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/17] linux-user: Fix guest_addr_valid vs reserved_va
Date: Thu,  4 Jun 2020 21:17:23 -0700
Message-Id: <20200605041733.415188-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200605041733.415188-1-richard.henderson@linaro.org>
References: <20200605041733.415188-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We must always use GUEST_ADDR_MAX, because even 32-bit hosts can
use -R <reserved_va> to restrict the memory address of the guest.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 3930362e20..066cf33f70 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -72,11 +72,10 @@ typedef uint64_t abi_ptr;
 /* All direct uses of g2h and h2g need to go away for usermode softmmu.  */
 #define g2h(x) ((void *)((unsigned long)(abi_ptr)(x) + guest_base))
 
-#if HOST_LONG_BITS <= TARGET_VIRT_ADDR_SPACE_BITS
-#define guest_addr_valid(x) (1)
-#else
-#define guest_addr_valid(x) ((x) <= GUEST_ADDR_MAX)
-#endif
+static inline bool guest_addr_valid(abi_ptr x)
+{
+    return x <= GUEST_ADDR_MAX;
+}
 
 static inline int guest_range_valid(unsigned long start, unsigned long len)
 {
-- 
2.25.1



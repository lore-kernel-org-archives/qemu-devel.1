Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27553C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:18:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E69B82071C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WX3dDYzd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E69B82071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR42F-0002Xy-0y
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 21:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR413-00013a-Lk
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR412-00014A-MN
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:29 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:40331)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jR412-0000xH-8B
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:28 -0400
Received: by mail-pl1-x643.google.com with SMTP id t16so240427plo.7
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 18:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BLcD9N9MlInNi6OgkZr1QrgaUSOVwaTdYcH5SM4Yl98=;
 b=WX3dDYzdo+CTgu0rZU24tkXT5Gz4i+Jt1iOdRL/oyCI8Kw1ykTJxx+ArydS5wyzLc7
 yp79SyPeiVThwhDrPBNvmPT/dCG+2382NVSrhLloRiT/tkNyMe3w3s3UpYDEY/j20AgD
 010XEwSRpCLE2VNtG63dK1HNa6D8F43IX0aMXT6XvSntcKqKiq1GXMUa3tdF0wEQlmDX
 JBsnktthXnpTlgOI1a9ZmyyA7forEframJW5d+pWJy+OLPjcK+QdkM/bQfd/YVeie2Fp
 ovFzTIH7K4CQcTQFkyjXzVJmwkqkF0G4c2yQl+WWetzIjdrPsGw5ePc3AQT8sPyKurkt
 L9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BLcD9N9MlInNi6OgkZr1QrgaUSOVwaTdYcH5SM4Yl98=;
 b=Rw9fCJ11QeUkWhbktDvUwP9p4kqAlfHz7evwKv02+JFvf0OqJj3om3FiYzfqHe1BlW
 42vLnPb8BOFwJNhIyFnqQJXMGJxUyew5ICCmp3omuIEtRifChijpE4rNy17lcS1oSdXZ
 3Rsq+u9qKz+Phs5XDNF6aj9QImfoReJ2ojfIBo2tZVvhsXes4ldIYL55t8F+Adu+cClj
 CgRaW/SZtczXwaQCQa4sHJNPGtCyYC1yfc/yXU8WwGh9bhcrNG+KyTFMDT8JGpM4IYqk
 7NLiOvxjd6fcensrGPUX9Qeb01NH60/xSYm2sb5PLty2Aw7Gap733La1Xi1vagW5CcMZ
 KRqw==
X-Gm-Message-State: AGi0PuZNjG3HPBPvprW78XenvsMKVgUYHs7ypDvr18PM154+MNs49OFm
 7InFA+R03qwhjPsd27ijHIa+WkZwIG4=
X-Google-Smtp-Source: APiQypLlLjFghpT53NGuxXcqCOB5DuUSIfjR6HWiBw19wVaE3kir7s9667CEiB2jxdO/Vk29hMJxaA==
X-Received: by 2002:a17:902:a50d:: with SMTP id
 s13mr24780278plq.5.1587518246044; 
 Tue, 21 Apr 2020 18:17:26 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id m4sm3673561pfm.26.2020.04.21.18.17.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 18:17:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/36] tcg: Add tcg_gen_gvec_dup_imm
Date: Tue, 21 Apr 2020 18:16:47 -0700
Message-Id: <20200422011722.13287-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422011722.13287-1-richard.henderson@linaro.org>
References: <20200422011722.13287-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: alex.bennee@linaro.org, LIU Zhiwei <zhiwei_liu@c-sky.com>,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a version of tcg_gen_dup_* that takes both immediate and
a vector element size operand.  This will replace the set of
tcg_gen_gvec_dup{8,16,32,64}i functions that encode the element
size within the function name.

Reviewed-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-gvec.h | 2 ++
 tcg/tcg-op-gvec.c         | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/include/tcg/tcg-op-gvec.h b/include/tcg/tcg-op-gvec.h
index 74534e2480..eb0d47a42b 100644
--- a/include/tcg/tcg-op-gvec.h
+++ b/include/tcg/tcg-op-gvec.h
@@ -313,6 +313,8 @@ void tcg_gen_gvec_ors(unsigned vece, uint32_t dofs, uint32_t aofs,
 
 void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
                           uint32_t s, uint32_t m);
+void tcg_gen_gvec_dup_imm(unsigned vece, uint32_t dofs, uint32_t s,
+                          uint32_t m, uint64_t imm);
 void tcg_gen_gvec_dup_i32(unsigned vece, uint32_t dofs, uint32_t s,
                           uint32_t m, TCGv_i32);
 void tcg_gen_gvec_dup_i64(unsigned vece, uint32_t dofs, uint32_t s,
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 327d9588e0..593bb4542e 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -1569,6 +1569,13 @@ void tcg_gen_gvec_dup8i(uint32_t dofs, uint32_t oprsz,
     do_dup(MO_8, dofs, oprsz, maxsz, NULL, NULL, x);
 }
 
+void tcg_gen_gvec_dup_imm(unsigned vece, uint32_t dofs, uint32_t oprsz,
+                          uint32_t maxsz, uint64_t x)
+{
+    check_size_align(oprsz, maxsz, dofs);
+    do_dup(vece, dofs, oprsz, maxsz, NULL, NULL, x);
+}
+
 void tcg_gen_gvec_not(unsigned vece, uint32_t dofs, uint32_t aofs,
                       uint32_t oprsz, uint32_t maxsz)
 {
-- 
2.20.1



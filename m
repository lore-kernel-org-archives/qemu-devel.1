Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6917DC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 18:36:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3819C20736
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 18:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QdkekIIT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3819C20736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWOuY-00044P-Ce
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 14:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jWOo4-0004MQ-7y
 for qemu-devel@nongnu.org; Wed, 06 May 2020 14:30:08 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:46346)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jWOo2-0002my-W5
 for qemu-devel@nongnu.org; Wed, 06 May 2020 14:30:07 -0400
Received: by mail-pg1-x52b.google.com with SMTP id q124so1163096pgq.13
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 11:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BLcD9N9MlInNi6OgkZr1QrgaUSOVwaTdYcH5SM4Yl98=;
 b=QdkekIITCGsJJcE+GYs0/vyd5osLMdYMd9NVK0DA6FTzwdxoU3nvx9LMkhOfsD6ADj
 50akld1Cq4Avv3AOQFQm7mZTga5MTpPLd/Bp5HW6vO8YqoyKBOoG4aLMerXUxA6zxgok
 9WIhPwVAmrrUdeeY/4w8dJipFhmJho3Yjpudrk007Vdi9Tp4F9HqYuoiJq0RcF5HnOsL
 twREaol40FlWDrDTReTDgpWCRG358LxyvvhuHLETcF2hq6lXbJhcsrnGDUu1QDH4lix5
 8r+HpwNIZq8zmJwchIb6D3RdkWBotXMPqMA8HrJO6lipKF/pNUOYbCuKENAW5KF435N5
 mDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BLcD9N9MlInNi6OgkZr1QrgaUSOVwaTdYcH5SM4Yl98=;
 b=BcGMCF40Cl4ikB5MyQGx04FNWg1oFxVuBJKOqWabhHtlExre2YIGo9LiPUNTiHjBN8
 YdwiphqwfGqVs4wbv9maoE1t9eFLw/3ebIXPbFr0wdlSMowx3FJX3kHK2VvE3+z0eTK8
 wuf0Or9U9SHZeCjH8bbHgO2iu8ne5eWuhYYW2Rr4+dT/516kZHjtRHaD7RBB+WOfdjVI
 D5cBi6bBDyx+7poWF4zyFK0hRcE4yG1RgsIiw1wk931CVmdiDuFpnKwjaXhJtdWAXLzO
 eIHQyW58S6oh/P04GpGbg2xiiqBAiZ+m03mcF/FmItuUSrNW50SvmnWU91Qr4CYLThtk
 FoOw==
X-Gm-Message-State: AGi0Pubf6QU8qhv9xjYPtI+axya/E/Vs/9U71yshc+MX85tHG83tQ6gF
 ginbOX9ISS/Sqerl25NNTnyhhjJw0Z4=
X-Google-Smtp-Source: APiQypKXpDE0HQQ1E5qhl8kDuuL8xbwaSXblQwQ07VGPLno8IYVT6eRQGtstaDxw7ppYZQ0lhZvk/w==
X-Received: by 2002:a62:1657:: with SMTP id 84mr9374082pfw.51.1588789805064;
 Wed, 06 May 2020 11:30:05 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id w11sm2572589pfq.100.2020.05.06.11.30.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 11:30:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/10] tcg: Add tcg_gen_gvec_dup_imm
Date: Wed,  6 May 2020 11:29:53 -0700
Message-Id: <20200506183002.3192-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200506183002.3192-1-richard.henderson@linaro.org>
References: <20200506183002.3192-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 LIU Zhiwei <zhiwei_liu@c-sky.com>, David Hildenbrand <david@redhat.com>
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



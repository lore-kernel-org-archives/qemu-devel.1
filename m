Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51225C388F2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:15:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE9B920657
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HiTOm/aF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE9B920657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZdQP-0007JQ-Qu
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 12:15:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdLt-0000vz-9D
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:41 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:45750)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdLn-0006a3-Ie
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:40 -0500
Received: by mail-wr1-x42f.google.com with SMTP id a9so15467444wrg.12
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 09:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=bF6PwLy/yI0XHBna/A/NHJlJMEtI1ZSu2nypD5iZDi0=;
 b=HiTOm/aFhzuzQQnOnN3GhDnA5j3OcmgWkBlKj8w14AWt8I8f2rkdDo1xnVUmDXRYbn
 fE9eS0aYJzhWgdCtv5mWc6BMVlCKxWXDCfmZnfWajSdFqUne+sF2C+xAJl8LvrdDxRhK
 L+s3Q90CFYHCuamwmv6TxDf6MOs0tKIjt7/2PoyfSfvbCeNrIwV2AVj9fgIhNUlCXTk8
 yshy2hG47HG3qT9MQVTeIc45k7Y3rds8rn/MySMtUQhIY70WB1MYAUdJF+U96q1sKOTV
 CSlnghGRawddats5p8jxwPg6Q5zs6fVXkU12OheZx+ZXeprrKJyxZs0yz0Zq+C1ZJ8to
 I/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bF6PwLy/yI0XHBna/A/NHJlJMEtI1ZSu2nypD5iZDi0=;
 b=A5DJcgq4qUSZ3BlLc61gxCUsibHRQ9muHYP96Rrn6ndi1DNrbem/hr6SYlKMqhaQdA
 aDLyZZU2EJgxshg7SkRMxCm3Bq3Z3IJ5hKHjyuzjAjjO1ABJloJFZ3wl9falhcaAPcjV
 JDgo8f5l2uVYKMBbTbJrYcfpk3ajgl4QSp6POv9LTg0jNxtkLjazgxzyLmbpElalLAJ5
 ioLWmvvYQ1Hp8ovpNOEerVwFRfzyDFdAKHheHnXpZGK5snV5S2iid9F19fSedH4Xsr0Y
 g7TcWBWZQ2CSUypZyIPBS2F28VnwjFMsaeh9ghB8D+iumQ6ONi3IKYG7uuTqa9cHUQ90
 jyTw==
X-Gm-Message-State: AOAM530CGjjo2isZSifu/3wJTPFML+mUfiU/bbgzzDMiHd0Z5EJnvCbN
 ukVD4NU+92lC4BMlIXT5ToZYYLpAGnU2aQ==
X-Google-Smtp-Source: ABdhPJzPj8E5bykgwlMBxWB9FprtsHpXDuUKZqrn3TG0di0WNRFy8fa28qGIqIw2VLJ9outunfoNhg==
X-Received: by 2002:adf:f74e:: with SMTP id z14mr21204569wrp.312.1604337033116; 
 Mon, 02 Nov 2020 09:10:33 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c18sm22396540wrt.10.2020.11.02.09.10.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 09:10:32 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/26] target/arm: Fix VUDOT/VSDOT (scalar) on big-endian hosts
Date: Mon,  2 Nov 2020 17:09:52 +0000
Message-Id: <20201102171005.30690-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201102171005.30690-1-peter.maydell@linaro.org>
References: <20201102171005.30690-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

The helper functions for performing the udot/sdot operations against
a scalar were not using an address-swizzling macro when converting
the index of the scalar element into a pointer into the vm array.
This had no effect on little-endian hosts but meant we generated
incorrect results on big-endian hosts.

For these insns, the index is indexing over group of 4 8-bit values,
so 32 bits per indexed entity, and H4() is therefore what we want.
(For Neon the only possible input indexes are 0 and 1.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20201028191712.4910-3-peter.maydell@linaro.org
---
 target/arm/vec_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 30d76d05beb..0f33127c4c4 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -293,7 +293,7 @@ void HELPER(gvec_sdot_idx_b)(void *vd, void *vn, void *vm, uint32_t desc)
     intptr_t index = simd_data(desc);
     uint32_t *d = vd;
     int8_t *n = vn;
-    int8_t *m_indexed = (int8_t *)vm + index * 4;
+    int8_t *m_indexed = (int8_t *)vm + H4(index) * 4;
 
     /* Notice the special case of opr_sz == 8, from aa64/aa32 advsimd.
      * Otherwise opr_sz is a multiple of 16.
@@ -324,7 +324,7 @@ void HELPER(gvec_udot_idx_b)(void *vd, void *vn, void *vm, uint32_t desc)
     intptr_t index = simd_data(desc);
     uint32_t *d = vd;
     uint8_t *n = vn;
-    uint8_t *m_indexed = (uint8_t *)vm + index * 4;
+    uint8_t *m_indexed = (uint8_t *)vm + H4(index) * 4;
 
     /* Notice the special case of opr_sz == 8, from aa64/aa32 advsimd.
      * Otherwise opr_sz is a multiple of 16.
-- 
2.20.1



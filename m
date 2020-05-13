Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DDAC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 16:38:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B7492065D
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 16:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fUtoNy5w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B7492065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYuOp-0002Mp-5d
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 12:38:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYuJh-0003my-UK
 for qemu-devel@nongnu.org; Wed, 13 May 2020 12:33:11 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:36449)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYuJf-00023Z-OS
 for qemu-devel@nongnu.org; Wed, 13 May 2020 12:33:09 -0400
Received: by mail-pj1-x1044.google.com with SMTP id q24so11219843pjd.1
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 09:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zUV0ojLtw3LPZ1kr/+clAulYjRQCrH9O1wPeh4lYV08=;
 b=fUtoNy5wCQjWdkWWSLSHHPB8aJ5tVXP5PTWRvBowJoIsQ/1vb6a34/SYrwoujjuA5d
 +IMnBJLmJLatuIDiWYPGZdSGHghDATgrSsgr17VeRQxl+S2NApqx8GpuMsdzpc5G2kXu
 1n1g7f4LKzvIMkNaWYfi/N2qibIjUXeW4x/4xzmolM6oAq147UUD49pgKQ8QUz+40wBd
 hjZwxEGryw0Nj6u5hJeX3ZoixztdjVEUOfBH1fGMWWsVDFq9SrLXKqoAEZdgseKhO8lg
 4jezj+myFVla8Ck2Z1O+YWjIe8nSDcys13q5NcT+mZrWxYSAvkOuQq+bRi6Y7DK/xRey
 jC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zUV0ojLtw3LPZ1kr/+clAulYjRQCrH9O1wPeh4lYV08=;
 b=VUMyNcyA2lYgI75lW5onhPWf0I7GRqXM6soRs5qwLfl7GT19Ba7vaoTenFzOS33RtY
 /mP9E4ZfzsQc+fNnzGRwy2jR1wsef0Kdyj0Srg2S2FqE/SxfeuN5mINagxU3UlmMutTB
 VrGv+dNqBQfoh1aJQuupab5JG+qQ/6qpaWH+6TuobhNcaOLf0ZF4srnkvJoc2SthA3e8
 3biaNbM8G4SELviR3JKcXRJWfW1H2Z8Bv7V934OLZs31AlrXN91YJuvxNjAp0ee1Heu8
 R7ApOym3e9DCVi4v0VIE88Vft3hFGzfK0ZOqO+5cS8OS6FZj0QgdGeykw4JpdUY3Mh67
 D6+A==
X-Gm-Message-State: AGi0PubLXuPwVUTEVFGoCeeYGm8OIFaZkRQHw3A9oNEEbRucT2dUMxLJ
 c0w77TX3/7ECG+nmBekZCDfS/HguViM=
X-Google-Smtp-Source: APiQypIrqxN7OI7uq1DqcfXw4hpX0pAyIDb6UCh5c8MBuAoxNhje9iJXt5pFuR7pqRHJECpXbI8Mhg==
X-Received: by 2002:a17:90b:3115:: with SMTP id
 gc21mr33829486pjb.183.1589387585798; 
 Wed, 13 May 2020 09:33:05 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id b11sm158025pgq.50.2020.05.13.09.33.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 09:33:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 14/16] target/arm: Clear tail in gvec_fmul_idx_*,
 gvec_fmla_idx_*
Date: Wed, 13 May 2020 09:32:43 -0700
Message-Id: <20200513163245.17915-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200513163245.17915-1-richard.henderson@linaro.org>
References: <20200513163245.17915-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
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
Cc: peter.maydell@linaro.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Must clear the tail for AdvSIMD when SVE is enabled.

Fixes: ca40a6e6e39
Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/vec_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 6aa2ca0827..a483841add 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -747,6 +747,7 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, void *stat, uint32_t desc) \
             d[i + j] = TYPE##_mul(n[i + j], mm, stat);                     \
         }                                                                  \
     }                                                                      \
+    clear_tail(d, oprsz, simd_maxsz(desc));                                \
 }
 
 DO_MUL_IDX(gvec_fmul_idx_h, float16, H2)
@@ -771,6 +772,7 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, void *va,                  \
                                      mm, a[i + j], 0, stat);               \
         }                                                                  \
     }                                                                      \
+    clear_tail(d, oprsz, simd_maxsz(desc));                                \
 }
 
 DO_FMLA_IDX(gvec_fmla_idx_h, float16, H2)
-- 
2.20.1



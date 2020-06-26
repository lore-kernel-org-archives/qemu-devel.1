Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C567C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:41:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1FF120709
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H36lrNaY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1FF120709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jofFV-0000jF-23
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 23:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof5y-0008Ds-Im
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:06 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:44935)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof5w-0001p2-67
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:06 -0400
Received: by mail-pl1-x644.google.com with SMTP id bh7so3744076plb.11
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 20:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6v/qRXRyfIYhGyb3e1JHgjhX613ps7MlxvVRRfe3ZMk=;
 b=H36lrNaYx9Q+qHL+r01PBHtgMG8XDrT7cZiQE5+ue2u9YhOoMMA+2MurqoMMB2EPWf
 OdHxMs5WzX3u7M0lfj4XImqNWdfPZE+ZXLfwZWa5/ScdqB8Qk36Iw6cxuOgzeexwVoQ+
 +uGqKRKNe/4rPoj/LAaQz+qdgGsdXW3arcV5ZJTcJMVVo9cRdHoPhg31Dvxon/q/CvH8
 WkZiCTLCjlW23EGreV2ihia2XCtxkiRdsFfB7oasFKywlSZvPPU0jhIwpbqCYdZDvJku
 A1K4Qv8nrutMjh6+iiyKvgJ+JKHwvqTqei6a9oAX/4it2w7QkITGknz5yrP+22leVxQ9
 BrdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6v/qRXRyfIYhGyb3e1JHgjhX613ps7MlxvVRRfe3ZMk=;
 b=MJv2agWv4E4UtqK1q5zpthXbbpwA4zcWt22zE2TRp6JHzPL7BsVofvPLoVGUbRV2x/
 EaFriKZuKgGGGXnTzR9CiB9XHb0EYFJDn0SyNCz53Q6Q60bPRIXnmGQyIHHTvd7OOjiZ
 qtfcwPG30Dw6KXLG33FvHKalIy2jnOkLwcA930AqluvRsgDiXAk84xq9wpfZEu7w8Tnt
 XVDflZaZGrb3lK0KYGhca02PdwmtCv0B0xbPll3opCmwSYZuD0CcxJ0Tmo7xW/SkKJFK
 w7WrgixOF1RdBqDqA2aU1liH6Y2OGyAcMaPsipuMOauQKb4EZtaBuLcKVjPnDQ0kqklz
 vTUA==
X-Gm-Message-State: AOAM533Jw4iWVdpnm7/OtWWQO6CLqKfb6wwl+qMzmF4wGfjOrzF/ZQqA
 IjJtjBsW+PKOTcZrqmpzd+3PAZE5BYg=
X-Google-Smtp-Source: ABdhPJzqNJsrWKESSQ490HyA1w0EBIGkhBdm5dNA0zddOPOKgaF2UfGsNjqHckyi3Y/a6x4hAB/aRA==
X-Received: by 2002:a17:90b:358e:: with SMTP id
 mm14mr1273118pjb.54.1593142322584; 
 Thu, 25 Jun 2020 20:32:02 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id y27sm1605256pgc.56.2020.06.25.20.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 20:32:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 12/46] target/arm: Implement the GMI instruction
Date: Thu, 25 Jun 2020 20:31:10 -0700
Message-Id: <20200626033144.790098-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626033144.790098-1-richard.henderson@linaro.org>
References: <20200626033144.790098-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, david.spickett@linaro.org,
 steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v6: Inline the operation.
---
 target/arm/translate-a64.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 2ec02c8a5f..ee9dfa8e43 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -5346,6 +5346,21 @@ static void disas_data_proc_2src(DisasContext *s, uint32_t insn)
                                              cpu_reg_sp(s, rn));
         }
         break;
+    case 5: /* GMI */
+        if (sf == 0 || !dc_isar_feature(aa64_mte_insn_reg, s)) {
+            goto do_unallocated;
+        } else {
+            TCGv_i64 t1 = tcg_const_i64(1);
+            TCGv_i64 t2 = tcg_temp_new_i64();
+
+            tcg_gen_extract_i64(t2, cpu_reg_sp(s, rn), 56, 4);
+            tcg_gen_shl_i64(t1, t1, t2);
+            tcg_gen_or_i64(cpu_reg(s, rd), cpu_reg(s, rm), t1);
+
+            tcg_temp_free_i64(t1);
+            tcg_temp_free_i64(t2);
+        }
+        break;
     case 8: /* LSLV */
         handle_shift_reg(s, A64_SHIFT_TYPE_LSL, sf, rm, rn, rd);
         break;
-- 
2.25.1



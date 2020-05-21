Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33817C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:50:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1AFF2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oNiKM60+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1AFF2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jboOd-0007ZD-1d
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 12:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboI6-0001wQ-5g
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:30 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:39750)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboI4-0006VN-Bm
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:29 -0400
Received: by mail-qt1-x843.google.com with SMTP id l1so5985322qtp.6
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UogW0SUaOY/ZfHuTV6t0YjkQtLB6wEDTJTvQMb1HiHQ=;
 b=oNiKM60+Anmbj1FdJ6ZU33dx7FSduqFtCvLR+oRYGW9s98jF0IX8Iclc9xgRh5sxGA
 5QhhCDUB4nUkesjcq4e+zo1ITQvK30NfWUIWki1S8yWLvYtRgv1APWPey+4l/Wm9JiA6
 1q7IXD7l/jjvtFUxY9Js22kXQBleP6KPtmHqDHVML4y5I1Eh+67VzVZqGFJnr96I6XGP
 lS8mLNjfqPkn593bpChb//oOOYTs5BNvaKopoRb2yLMRmagSQv+hOk0dstMtET7FT11H
 1/43LwyDavULUs1X0whA52ZOZ/o/faA1v0G+nKgNXuDfvC0JxGIUDQdzBrqIBXlCvzJ1
 m6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UogW0SUaOY/ZfHuTV6t0YjkQtLB6wEDTJTvQMb1HiHQ=;
 b=ZchdqxtlIV7NPY/QzcPu+j3moI7GwwVF2ZIrd7X2osh4VH3hzezwKqVd+9wm7mfSEV
 Guc4xHDR2Oai88siKs8RVEr+7Nr3Fd+iYbfIrZDWcJb3MerMiHloVB9xQgC+K3msHnDe
 8V/J+h7pB5qwp5fDNatvdHihQPm8g6s2lnHrQ7GlURf4k6LMnVrBmJTCD5i0nKcge9Wi
 w8LLRQF9ku6+tDXk2x7zuQnfsMiAfXK6eok4mR6V7FcLdOJqXwTKS4mqOhjJhkE8C8I6
 e6Fz1FSvDQi+bXFNACMuK/U295YTlBAxbZC/JjIhOXvzImtpRZn0H9tGseLgp/K5nAvb
 5SQQ==
X-Gm-Message-State: AOAM533g/PhscqkhoMWFKkgwv9pe7lhunmOc0s9/EHPTFJe0r/CN7wje
 oXyIcsnEJGpUbhVuHU+46ANQAFaNL2eARQ==
X-Google-Smtp-Source: ABdhPJxCVs9XAvKBB/qdJQqz8KPPCJJWfr7v/5tUbGXKM54HyqUxbYDwh7NpcGY1zgk6T9EKLZh5iA==
X-Received: by 2002:ac8:7941:: with SMTP id r1mr11640643qtt.290.1590079407270; 
 Thu, 21 May 2020 09:43:27 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:43:26 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 09/74] ppc: convert to helper_cpu_halted_set
Date: Thu, 21 May 2020 12:39:06 -0400
Message-Id: <20200521164011.638-10-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::843;
 envelope-from=robert.foley@linaro.org; helo=mail-qt1-x843.google.com
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
Cc: robert.foley@linaro.org, richard.henderson@linaro.org, cota@braap.org,
 qemu-ppc@nongnu.org, peter.puhov@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: qemu-ppc@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/ppc/translate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 338529879f..c801bf915d 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1595,8 +1595,7 @@ GEN_LOGICAL2(nor, tcg_gen_nor_tl, 0x03, PPC_INTEGER);
 static void gen_pause(DisasContext *ctx)
 {
     TCGv_i32 t0 = tcg_const_i32(0);
-    tcg_gen_st_i32(t0, cpu_env,
-                   -offsetof(PowerPCCPU, env) + offsetof(CPUState, halted));
+    gen_helper_cpu_halted_set(cpu_env, t0);
     tcg_temp_free_i32(t0);
 
     /* Stop translation, this gives other CPUs a chance to run */
@@ -3620,8 +3619,7 @@ static void gen_sync(DisasContext *ctx)
 static void gen_wait(DisasContext *ctx)
 {
     TCGv_i32 t0 = tcg_const_i32(1);
-    tcg_gen_st_i32(t0, cpu_env,
-                   -offsetof(PowerPCCPU, env) + offsetof(CPUState, halted));
+    gen_helper_cpu_halted_set(cpu_env, t0);
     tcg_temp_free_i32(t0);
     /* Stop translation, as the CPU is supposed to sleep from now */
     gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);
-- 
2.17.1



Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1AAC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:48:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E55F2072C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DWDpQm8P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E55F2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jboMw-0003ho-SA
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 12:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboI6-0001yk-TY
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:30 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:41112)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboI5-0006Vh-TV
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:30 -0400
Received: by mail-qk1-x741.google.com with SMTP id n11so2376895qkn.8
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pu4aLcXEpuJ4ytDOMXC0XbbDo51phtIicVpeJSCDXFU=;
 b=DWDpQm8PSA5NEf/7AnwZEAKyU/pEgvd9hw5c4hyVd14yhfhx3oc5Eap2P06jV0j7RY
 43uxoKGirTg1Sy94QGDtwfFHUQKQm2M25FA6PQQIKtvlGIdzbgRGqyL22+6DB2ocjnn2
 GJZHE+HD+LExIHNXy//q0IxedEy6YznJ+Fb1PRH0srrobWnDiCu/y0kAGjH6vyHBiGg0
 IkRO/u4OFIDs9/hbiMD52C5Or72nU68I+7/e7M43XAv7lFm+2PKMjC7LK/wS4DgZlW92
 QQqBhO4KGTBFT/cnPbTKsIHQkfN8UWp69z3sSDBI+Lb51HlF7ImZsl+Lzwcu8N6z51sH
 JxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pu4aLcXEpuJ4ytDOMXC0XbbDo51phtIicVpeJSCDXFU=;
 b=gy/TLo4ygHWn3DLh1zIwAmTHMDaMTGTY9dozrUarWHvraDo85XhA9RQV6NHJP3iJDU
 ISBSYscQf4mfdx6zu5wdA8iBzFbVdZiXM3xJ9638SA4RxAWAu45gOAvNaBWRrKIkf4uG
 bt8+zRbQQgf0HOuE30lWv5jK0WV6to7VQHtl39YF7wX/kHeOAmVX6gNoR4HmkI7CYGxH
 woXUQyNNAFhd3b7RDXiAcU48erwclVJyUHSrLPfpHvfBamGSFvN5z8sDSfZVuiOtw9/3
 KlJLkLE8c6Z489dGZbsxjeuNHkhrcfnL3n9AnqbwzWi19zde6Rvo5M+QuvxebuIQucTe
 itLw==
X-Gm-Message-State: AOAM5306W6NUF1zvCj8tBGm42CALOuHsMIPj/DGFDNSzAg41mq00+OcU
 LKwLTk/rHo/TvnSYdhAfNmOFakBxTBN0lg==
X-Google-Smtp-Source: ABdhPJzkMOq4Q6Y41+ex4wxb/83nn9jFstUZvqN1GeSZHAZWTm5OqSUiJ0uoKZlD+n1IPCtFFTuV7Q==
X-Received: by 2002:a05:620a:634:: with SMTP id
 20mr10167516qkv.15.1590079408631; 
 Thu, 21 May 2020 09:43:28 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.43.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:43:27 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 10/74] cris: convert to helper_cpu_halted_set
Date: Thu, 21 May 2020 12:39:07 -0400
Message-Id: <20200521164011.638-11-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::741;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x741.google.com
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
 peter.puhov@linaro.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

And fix the temp leak along the way.

Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/cris/translate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/cris/translate.c b/target/cris/translate.c
index aaa46b5bca..6c4f091b7a 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -2823,8 +2823,9 @@ static int dec_rfe_etc(CPUCRISState *env, DisasContext *dc)
     cris_cc_mask(dc, 0);
 
     if (dc->op2 == 15) {
-        tcg_gen_st_i32(tcg_const_i32(1), cpu_env,
-                       -offsetof(CRISCPU, env) + offsetof(CPUState, halted));
+        TCGv_i32 tmp = tcg_const_i32(1);
+        gen_helper_cpu_halted_set(cpu_env, tmp);
+        tcg_temp_free_i32(tmp);
         tcg_gen_movi_tl(env_pc, dc->pc + 2);
         t_gen_raise_exception(EXCP_HLT);
         return 2;
-- 
2.17.1



Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1BFC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:57:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B437C2083E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CpxQeAGx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B437C2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jboVp-00059H-R0
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 12:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIS-0002w8-6F
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:52 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:34316)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIP-0006YT-Ib
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:51 -0400
Received: by mail-qk1-x742.google.com with SMTP id 190so7915052qki.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=bf2M7IKMoOMF6Sjf+JSOoIalG8faUHKpuzaEeGoqpyk=;
 b=CpxQeAGx8TZeGeXCndTivoFVEPvVHSGlAHKM5Z3h72tFh8Q7dbUmzVtrWIwZGXOuDF
 H7QeoRrBEdnBPtnHglGne7Zj7GIvtaNs5mTEkCQPvK+YGehvF61Go84gnUiDk0ZkTEJh
 d/JS6OAOQvuqsAPSAa+S2qI6Ur+wL2E1w7sd7qjKoUUjrlqiYLiIVrVJkaLBYrkpfjWD
 j3p5TN6bQI/IQo9lPk2zisrB10SEJPvW5b+OEI+OebCqpLgDkA3tO+DcK/QFCB32hdqQ
 2MQVzLoenOyiIf2zDNs00ls0VZJ/gvhPiNv16yzK05ikbFPDfwrluxNiYJgaKjvQlmXi
 PZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=bf2M7IKMoOMF6Sjf+JSOoIalG8faUHKpuzaEeGoqpyk=;
 b=md27t9Ywitrji/i89v0Rl9Ll9Gdgo2KzKVr79oYm4Oy6pAjZQ/aPRcYmziE4YDts+e
 gzfuL/Hd5aePReD8WXEqa2tO3nmFhYngaoLDyCVklffIVJUMp7d6vRC17PRzZOcH1p2H
 9eaAKYIDD0zTLhhjUO6ECtnfqIqRrMvsk347/Mc7k16PdTuyX1c+AJNFUhIQVnUvb2oZ
 9Mm8MCFS8lbF4jcetU4zTCIG3DzoJGXmihG5wn8r1pQix80pIEsoInIDomBjIZVA1FIT
 oGrmrChxfb0uxjPdmw8RY3YYX8Pi1VCyINP4ZR+a7g3LpNU697bgnhISqO49KfZWgl+B
 aatQ==
X-Gm-Message-State: AOAM532D2dtoHxjZR+1p20v6M+NKjUlpwlZ4zAPt+42BJTd8igOSU4v+
 ApNT1H8K0/J3Zu14F4o5/X1HkoxSwGvExw==
X-Google-Smtp-Source: ABdhPJz4vA4l4XHRsC/4uwQgyE6lSBXU2jDNFciiYN+8QzeLKfXXraXCSMSE+T92qWXGXwkSamUMmA==
X-Received: by 2002:a37:4917:: with SMTP id w23mr5295799qka.161.1590079428361; 
 Thu, 21 May 2020 09:43:48 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:43:47 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 25/74] riscv: convert to cpu_halted
Date: Thu, 21 May 2020 12:39:22 -0400
Message-Id: <20200521164011.638-26-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::742;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x742.google.com
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
Cc: robert.foley@linaro.org, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 richard.henderson@linaro.org, cota@braap.org, peter.puhov@linaro.org,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Reviewed-by: Palmer Dabbelt <palmer@dabbelt.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/riscv/op_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index c6412f680c..91f8833c2e 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -182,7 +182,7 @@ void helper_wfi(CPURISCVState *env)
         riscv_cpu_virt_enabled(env)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     } else {
-        cs->halted = 1;
+        cpu_halted_set(cs, 1);
         cs->exception_index = EXCP_HLT;
         cpu_loop_exit(cs);
     }
-- 
2.17.1



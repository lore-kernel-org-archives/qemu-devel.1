Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E40C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:33:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F276720639
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PUA5pzzC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F276720639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfRA-0008Ip-6g
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfEY-0000NV-Sj
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:02 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:32950)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfEX-00056i-2Z
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:02 -0400
Received: by mail-pg1-x52a.google.com with SMTP id o13so538088pgf.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=45kd/bFobWQBgRWzCCV4KKe4PH1pZqfnSM8e41v0zaE=;
 b=PUA5pzzC4rVHiHPTzcUaSflV8P7FoiJ5+Sx+/s8FkuaGm1xDtgU1kw7unUur7R698C
 w5prYrcdbLBnIu+4inEzuc17TE3HdIkJjG+uMgrBU+/6IcNXySj6Ij06AIYZgOQ92FdQ
 WdRrgpwqqKdBVDoBagZf2x+cwt6OKE1XnRK+9ZY89/n5j2XXYiadQAgGPmW3/tdSsC6p
 HDxLyy22AaUhPjABTOFWRaefUMP4pw9SyLqPCnqd2LVxV2nik5TT0f5kS7xsk9sy0h/y
 Pw/T7wx0BlWjrmABUgOg+74kds8uj1aduBeG5CofVfNiZOtAxq2j36z9A5VBZwD6yXqt
 198A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=45kd/bFobWQBgRWzCCV4KKe4PH1pZqfnSM8e41v0zaE=;
 b=ThE2bV8MU2e+rpltzmue0ukGy9sxEbTer5OXRB7uBSeFTaWMOJ/7bPy4ilNqZqC7wg
 5bw1SVsm0iuJ3ieLAnSNb032X0PFWebs2VDjZnZwz+Wg3WBIYMD7Q30XFtHSC7a1I9jc
 kaItuEiw375ouX7X2fKfr2oCw3s9HQ2xTwyIgmqPc5tEPYM4ftyaXOYbdACAyN8dK7WQ
 pkgu2tnU2tNoslkg8vYyCe4PDuODARxH6E5t0IettfX/ppVo77EosB2iENDRosyXeDUn
 sGLEcmPExuUv9ORuNYwCnYE9eqI6HoQP5blZyfairrTi0J9HtAfQSuwBZB0W9T7cGku3
 Eweg==
X-Gm-Message-State: AOAM533+i0wqJ7cbMvq5A2sg7GMJD6kan2g6wgRr4Z5uhmwpKenw5zx/
 1ClKUKunI89O6Q2xg1AjRJvm3RiRFIB77A==
X-Google-Smtp-Source: ABdhPJx+kgXd5oEJi/Y3IHIiR1wMEffVKUY7Er+CxML2QLtDX1vCs8nuPBrGJuWHO2GUPpk82v0Sww==
X-Received: by 2002:a63:1d66:: with SMTP id d38mr1403668pgm.50.1598624399323; 
 Fri, 28 Aug 2020 07:19:59 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:19:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 21/76] target/microblaze: Mark raise_exception as noreturn
Date: Fri, 28 Aug 2020 07:18:34 -0700
Message-Id: <20200828141929.77854-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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
Cc: edgar.iglesias@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will allow tcg to remove any dead code that might
follow an exception.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/helper.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/microblaze/helper.h b/target/microblaze/helper.h
index 2f8bdea22b..820711366d 100644
--- a/target/microblaze/helper.h
+++ b/target/microblaze/helper.h
@@ -1,4 +1,4 @@
-DEF_HELPER_2(raise_exception, void, env, i32)
+DEF_HELPER_FLAGS_2(raise_exception, TCG_CALL_NO_WG, noreturn, env, i32)
 DEF_HELPER_1(debug, void, env)
 DEF_HELPER_FLAGS_3(carry, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 DEF_HELPER_2(cmp, i32, i32, i32)
-- 
2.25.1



Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178E2C2BB55
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 15:52:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D97E820730
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 15:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E7cVgqrm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D97E820730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLqWk-0004zG-1N
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 11:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43607)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jLqVX-0003NF-MX
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:51:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jLqVW-0004Fp-KY
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:51:23 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43722)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jLqVW-0004FD-Ep
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:51:22 -0400
Received: by mail-wr1-x441.google.com with SMTP id w15so4446745wrv.10
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 08:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VJ6+jJuK9aM49AP9y9RG5kZxMwVILHzFOXjQWpNENXw=;
 b=E7cVgqrmx8m42zTAkUJ3leJxd5Zh9dPKamAXLo1ffqZ6Slnpe2RS+diupvVwo4VcDj
 Lm1YuGw2ImaGRPIrf+INC5+7o0WIQCdYdiuk1mjOubKpoLqpnjzzCYyOxm6NWco1WfsG
 haVz/7irjlwr8VXVZQqWmivLQqL3TscBXMdrTHPexT5rceZWhhk2/8JjoYx5zxuyrXlG
 +rt9sSNjsv+5EPDsuFyuVl/rY6emTU4DbQrov9YMcxP8TI6qJ4gBaHblF1FsreZRT2p3
 pUaH5FZ0zJI+BwdkvljGYQRiK2dyYtqgfV571LCFpwbFq0hNLH/5u754Epxn2xkIL85X
 zTZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VJ6+jJuK9aM49AP9y9RG5kZxMwVILHzFOXjQWpNENXw=;
 b=RVRy9RYyzt19iIjbkqoi1Yv872NpMKpgCXwbHECzNcVTRaWF3DbBzJhDR5sPB81TaW
 nMSw5TR2j2oXkOIWkSsFL7I8SfzCiQ1x/SW8BCxE0UuPWsCLdz4gOWlwgn2TzFgvJNA3
 l8B/C772LqgeOZTlbrqnHl43PbO1wzk7lrVRNO4oaOUHUNseUMQ77200ww3pTdC0ZuOl
 P4+CRILPcB2R52t8nfI6PlR0+g0ktK9zztBSkSkDldlSdcuIsHDmIbC98IUTdXgflrQW
 n8YnqOR7Ws2TTK5c5xgSJpu4ByjFnmB1qbosLG7b7Kpiwza8V7SFrcC8yQuF3LdUJlR9
 HnIw==
X-Gm-Message-State: AGi0Pua/vf0Hu7HkWkrjVLiB+eWkd/C/EtaptnWcmtEliO85jDw40Z8u
 aEpXcTFIY8Rd0RCnu/w6sQatmQ==
X-Google-Smtp-Source: APiQypIj+YUA9HsryvVOCSbNoY3pvZb25vDpN+nLm4jVHAZx3MduCBA17p5iSQhUsmj7k2//EtvHxg==
X-Received: by 2002:a5d:6452:: with SMTP id d18mr3336077wrw.405.1586274681427; 
 Tue, 07 Apr 2020 08:51:21 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i1sm2871571wmb.33.2020.04.07.08.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2020 08:51:19 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 854881FF8F;
 Tue,  7 Apr 2020 16:51:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 03/13] linux-user: protect fcntl64 with an #ifdef
Date: Tue,  7 Apr 2020 16:51:08 +0100
Message-Id: <20200407155118.20139-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200407155118.20139-1-alex.bennee@linaro.org>
References: <20200407155118.20139-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Checking TARGET_ABI_BITS is sketchy - we should check for the presence
of the define to be sure. Also clean up the white space while we are
there.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200403191150.863-3-alex.bennee@linaro.org>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5af55fca781..b679bc6b136 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11331,11 +11331,11 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
            This is a hint, so ignoring and returning success is ok.  */
         return 0;
 #endif
-#if TARGET_ABI_BITS == 32
+#ifdef TARGET_NR_fcntl64
     case TARGET_NR_fcntl64:
     {
-	int cmd;
-	struct flock64 fl;
+        int cmd;
+        struct flock64 fl;
         from_flock64_fn *copyfrom = copy_from_user_flock64;
         to_flock64_fn *copyto = copy_to_user_flock64;
 
@@ -11346,7 +11346,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         }
 #endif
 
-	cmd = target_to_host_fcntl_cmd(arg2);
+        cmd = target_to_host_fcntl_cmd(arg2);
         if (cmd == -TARGET_EINVAL) {
             return cmd;
         }
-- 
2.20.1



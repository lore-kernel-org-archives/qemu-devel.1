Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D15C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 16:38:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A46B2177B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 16:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FIgszzBs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A46B2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVH7n-0005dp-7m
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 12:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVH1o-0006SN-Qy
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 12:31:56 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:33855)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVH1j-0005Zy-Kh
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 12:31:56 -0400
Received: by mail-wr1-x42e.google.com with SMTP id i1so3892807wro.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 09:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rjHA1bvgfaciFTBKDTodT9RWGhISPHoyUdUPx/my+qo=;
 b=FIgszzBs2xMdrOCVwomhtBdlfXqCkm7nr2wIDluTz0r/3bPx/wVxz/yX7TWSG58c8U
 0gPCDaVP/6Fnir5fPUciOjmp2O5ZPoFGbzEBIsVKQrSLQcH13SWlqlKBSphmP7OuQ4AH
 Gr4DnudMfZzzEXRu176GPbLtcJYAUogiMATAtMAKYiwTLMkNx5Kdrp538CY+rf2Nhnsj
 fk9HrxDbTm8BpP6Kwez+xNvHCnZsyTZYqKGYqcUk18Yl2ocbFTIzsW3DsKKrB5INna2q
 9VC38Wai0EpZkrTaySMt/tIWE+5GNP2Cu6q/6whNCDuaO1kMfUjkga+FNIMJSJ2z/nvk
 VDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rjHA1bvgfaciFTBKDTodT9RWGhISPHoyUdUPx/my+qo=;
 b=RYE1jhd3jmRV/u7xrI8pao7xWRe0/Ky2QaSdhlJZX+JEjb8vup+lCRoLal4FLK1qW3
 l1gNu814evBcbZp0d0M4f10u3fOXmT5ZMtpulc1Fk5O+kCL0xul9n6q5s05JyQd1Kle7
 kLg65rvpP0jlSlo8pwYoaLhZSzIWZg3XrSNKZ81kywIXIqtRAJP2xqEXfw+/bXSTx3Ub
 i92m8PqwogYanIlVtJsgissxEYtOfYW5tMd6w5ICLSlXX1rzCxm1BRa3fuixr7TPZA8I
 qd3OfHrWiQfZeapSWJs/VTbcz8qXv9u7krX3SqPn3fgHfKGNjGDjYPHtAKZXZZfazWOA
 0hnQ==
X-Gm-Message-State: AOAM533KSZeGuWdWMktLrFU7wBlMqPU2Wy/QGmE3PC4m5FOG0JRDZZw0
 OCwTOilhrow5ENW5exCZr4Lg3A==
X-Google-Smtp-Source: ABdhPJxM5TEM+nsgwwqv2m/sF4nV5N1gXlpoayUr6YPfZXOQlEJ93cMzxddxAnycdeXoQfNPM7Yoqg==
X-Received: by 2002:adf:9043:: with SMTP id h61mr5810468wrh.237.1603297908890; 
 Wed, 21 Oct 2020 09:31:48 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i126sm4646371wmi.0.2020.10.21.09.31.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 09:31:41 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 488EE1FF91;
 Wed, 21 Oct 2020 17:31:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 5/6] scripts: fix error from checkpatch.pl when no commits
 are found
Date: Wed, 21 Oct 2020 17:31:35 +0100
Message-Id: <20201021163136.27324-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201021163136.27324-1-alex.bennee@linaro.org>
References: <20201021163136.27324-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel P. Berrangé <berrange@redhat.com>

The error message was supposed to mention the input revision list start
point, not the branch flag.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20201019143537.283094-3-berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 6ed34970f9..88c858f67c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -392,7 +392,7 @@ if ($chk_branch) {
 
 	close $HASH;
 
-	die "$P: no revisions returned for revlist '$chk_branch'\n"
+	die "$P: no revisions returned for revlist '$ARGV[0]'\n"
 	    unless @patches;
 
 	my $i = 1;
-- 
2.20.1



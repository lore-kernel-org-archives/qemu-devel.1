Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09403C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:36:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC03F20732
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DnrJMFhs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC03F20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnNYp-0003uH-0P
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 10:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnNUr-00076I-2y
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 10:32:29 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39469)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnNUn-0005gr-E0
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 10:32:28 -0400
Received: by mail-wm1-x343.google.com with SMTP id t194so15955641wmt.4
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 07:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Teb5CYlwDix3ktwKyP7XUM4qHJXbLvwhht+HlFFEsmI=;
 b=DnrJMFhspYGXqHtI5Oie2h43khYDeSShJ/ASj99kqUXnXBX/cETlxetXcgj17nod5w
 is1QW8XeORvhV7Gnm1RFLLxqZmCOKOjmkjvo8SesnixHQ7YDGLaQPcFsb0i+/2ksIyxF
 9Rd6/q2HV3GoKtFhMB51vHWUm6US0MWXIwE8eSmvXedED4YNzNoIs2micQ96zEgDYnKz
 f75DpgBryD4TRqBJYgRO58b78QG0IoEZxIluiLRCcKdEr0FU4AjPOAGQIkFXYshPB762
 OThE1n2uRBFKYmewvkxbRIABrXpFJiOUjaHt2mbqpfY4tcpGbj6Y9AVrdbcHKn6EULU1
 oFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Teb5CYlwDix3ktwKyP7XUM4qHJXbLvwhht+HlFFEsmI=;
 b=IE/7X07olQT2grONZu8kVwBl/LSrZSP1GKMxBst3vwTeJc1DjauSSZaIWVCSa4Maci
 ZoVaVmlrzkgKW1fbZ8Sy4zoxtABbXZvdIA16uSAGySpKszfaio3pUImL0n4uWu7XluLI
 G/cLHa9gRLhEEf6knN7edNOLFzqx8Mi4R/r0ZVEfClKX6A8KqFACyEnMiam9VUtz8cbp
 xGmmztI3/CXesnr7m6XdwhAleRwt5LXSGy3Ah3zG29grnV2mlwMaBAGiv9Ps8Mt4KqJ8
 0tXy9lwf9n6dt4jdRrirwnwPuvtcNrveXff6P4j6WewqsdYBWUglVLkejBBV153w2yyF
 dWVQ==
X-Gm-Message-State: AOAM533l5ZVVfdwbILO1rsXujRYt73AdhsRuYsgVI6zbAz62Ssq2cp+g
 P8Zui6Mmje9cETOPCqy1kvPFOg==
X-Google-Smtp-Source: ABdhPJysydiwd6tjoielmDCg1a4a67BVX+PqahCMbJtcL9ALpttJRLjEWEOtHR8mGQ+XmbptiQgfyw==
X-Received: by 2002:a1c:2485:: with SMTP id
 k127mr16136950wmk.138.1592836343981; 
 Mon, 22 Jun 2020 07:32:23 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 104sm18668728wrl.25.2020.06.22.07.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 07:32:20 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 204E31FF9D;
 Mon, 22 Jun 2020 15:32:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 14/18] .gitignore: un-ignore .gitlab-ci.d
Date: Mon, 22 Jun 2020 15:32:00 +0100
Message-Id: <20200622143204.12921-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200622143204.12921-1-alex.bennee@linaro.org>
References: <20200622143204.12921-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The sooner we deprecate in-tree builds the sooner this mess of regexes
can be thrown away.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitignore | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitignore b/.gitignore
index 90acb4347d4..9016ee0a0b4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -92,7 +92,7 @@
 *.toc
 *.tp
 *.vr
-*.d
+!\.*.d
 !/scripts/qemu-guest-agent/fsfreeze-hook.d
 *.o
 .sdk
-- 
2.20.1



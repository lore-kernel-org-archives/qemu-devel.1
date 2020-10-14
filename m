Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC1AC433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 21:37:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44A9121D7F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 21:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYojULWD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A9121D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSoSX-0004eH-Q1
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 17:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSoRP-00039b-Kx; Wed, 14 Oct 2020 17:36:11 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35079)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSoRN-0001vE-IK; Wed, 14 Oct 2020 17:36:11 -0400
Received: by mail-wr1-x444.google.com with SMTP id n15so756613wrq.2;
 Wed, 14 Oct 2020 14:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uEjL+qGbbvV/SEcYco7BpZwU7c2hFnttQxVV9v2plEo=;
 b=IYojULWDPISHv7l8ZAad7PJ5mjEuup6DfIjh+WJHbztOTmqV3yhIXxJSVVT9MRaJkD
 9duSWSRbPFpqGlEJhbfkvphULcyv6qdOKN0Hh7AHQA8sp2GB9SBrA+jmgsADVaFEJmvh
 dEgjOwnYaJZU7u1H0ggM+23iHAEvLjPCEUlvqKNhxSn94gWnnBEEZfIxI4TAxD/Gqo4k
 ewzhexYg+DRMUmdWCOXSqFLO4v1muJXK059S4qCdKxFdHfX54zMUUTyzXQd77j9AdYsz
 0Ygbj0UG8y4kh3FyjBiKZyBVzJtceVGUBBAGnCfvF9kzUFCyoYeKXylG/vMc827W6/3x
 1fDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=uEjL+qGbbvV/SEcYco7BpZwU7c2hFnttQxVV9v2plEo=;
 b=r8JbmE2IpKIRaXuZGlP4V4tQt747bWH1E8X7qIHjLId/ZkB6RlbPOzgoGCwb2+F3ar
 7E1F/MzCe8k/fS0+WzMx/HNvgVP1NQFOXBQgTJaJbeVIrIwodJoVwspRlZkuNmbbEotY
 y3h/0o8XfeXuPN6clX5JNmbOKLW/sg5NJGp4fZvGwm5GcNmm3i8pwY4gid+KQx70rUX+
 uN6jqlQYK7cbStofhR2b3nfQYVgaf2O9qwG2NExhqLq9YMDZazZWWCIStngLaBcTskPV
 9cRMVW56FGUkHO8kLV64SR4yWxGAbyp+TBxzE7YEj8IlOpvfDpZaptdkz2FtYQqALKqT
 TgLg==
X-Gm-Message-State: AOAM530v8FEJUR0OuEIO90ppZ9m72DHsD/b654yegYktIyshKqvKfJ/c
 oQ2zIBA2VmvZhiOuzwaqdahesaC12do=
X-Google-Smtp-Source: ABdhPJzpkjmeJn6s+O5bVa3SgHAdDNmE6FkZGN5dtcEA3XiiS3skQgUFyr20XFH8iWkx/AcU1+ZlPw==
X-Received: by 2002:adf:edcf:: with SMTP id v15mr648941wro.291.1602711363716; 
 Wed, 14 Oct 2020 14:36:03 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id o3sm889204wru.15.2020.10.14.14.36.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 14:36:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/arm/strongarm: Fix 'time to transmit a char' unit comment
Date: Wed, 14 Oct 2020 23:36:01 +0200
Message-Id: <20201014213601.205222-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The time to transmit a char is expressed in nanoseconds, not in ticks.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/strongarm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index d7133eea6f9..ca7c385f313 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -935,7 +935,7 @@ struct StrongARMUARTState {
     uint8_t rx_start;
     uint8_t rx_len;
 
-    uint64_t char_transmit_time; /* time to transmit a char in ticks*/
+    uint64_t char_transmit_time; /* time to transmit a char in nanoseconds */
     bool wait_break_end;
     QEMUTimer *rx_timeout_timer;
     QEMUTimer *tx_timer;
-- 
2.26.2



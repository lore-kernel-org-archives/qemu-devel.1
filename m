Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B799C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 13:48:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC36C249AA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 13:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P1meWXV2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC36C249AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43841 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWhtU-0002n5-Vw
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 09:48:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWhot-0007Y5-DS
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:43:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWhoo-0000Oc-JA
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:43:43 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:36215)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWhoo-0000Ne-Cu
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:43:38 -0400
Received: by mail-ot1-x343.google.com with SMTP id c3so9219057otr.3
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 06:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=3dEx21RG2xJrc6WESswMJA8asVI8Tn0Ptx0Kuiu28fo=;
	b=P1meWXV2MQlOI/4KlS9szLHxEkX6rdOdsMsHmd1x8w4AfPKWDr+H+6nr0isNEIMjdT
	k5M/gH6K4vIUdf8XIdNCgQnN7wGVV9dzFIyZ9wYM2fH5ZttkeMKkQgxI73waEUZnoKE/
	dhMSfAQUKfMCBdupnX32OCtIjHYk/lDuMTb8A6DTZADe5KxubzySCSyekwSAsUzhiwBb
	RGRPEagnDQgfpThez6OJgQncihm+QECwSw/r5V7TcpEvK27AGafnuP8uhUKS/GzgZnQI
	NQTFGiBRhOJWQK3KdqPpArL6Ke5QxJmNTQEt0WDQAAgHEHgcKWbSGsHdDOWbmBl3vM6+
	wSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=3dEx21RG2xJrc6WESswMJA8asVI8Tn0Ptx0Kuiu28fo=;
	b=LpRiuOEaPppfB1WRviGyyKuo5VPQYi4DeeW/yGXACGP9uGKLcJYfI6uqGx3AtTTMpg
	bvjC63wr+pFsDkkDZitQf89kjGizaZATXJIVTCAvLDdx6SuCgvb4EzKo5mxC1/ctHupY
	gDkmaUWYyulemr7Ii2vnfpzcphrAhc0Kp2D1OMSDRnXx4BiW3unMEHhM1cq2rp0pdq2i
	1h8NgR4IPrc9HX9pv/p5QRFpNvayuvvLQTVweyKhbCI7CwiBWiakhTcuumiCX/l7W2QR
	yfTc/RtOCUiLQbiD9bo3AWDcegZoZVeLFZaw41+TilMrj1+2A6VggiPvSSRtP8CD7DjP
	LtMw==
X-Gm-Message-State: APjAAAXSNEJgewuNw3AEZANHt7YhRtaiWr1seDxr9I2yaFTr1hRk0ITL
	xxe24FCPOgID/rFBx8faMGoaMHmr0QycYA==
X-Google-Smtp-Source: APXvYqwoV0hPaZSfpS+SE55qlwD2x9JfBhmP2dFKqWwwngMyJISBGeeYwM7LutavIthSfmCzxDtz4A==
X-Received: by 2002:a9d:67d8:: with SMTP id c24mr1926607otn.190.1559310217419; 
	Fri, 31 May 2019 06:43:37 -0700 (PDT)
Received: from localhost.localdomain (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168]) by smtp.gmail.com with ESMTPSA id
	r23sm2391176otg.49.2019.05.31.06.43.36
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 06:43:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 31 May 2019 08:43:04 -0500
Message-Id: <20190531134315.4109-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190531134315.4109-1-richard.henderson@linaro.org>
References: <20190531134315.4109-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: [Qemu-devel] [PATCH v16 12/23] target/rx: Add RX to SysEmuTarget
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: philmd@redhat.com, Markus Armbruster <armbru@redhat.com>,
	ysato@users.sourceforge.jp
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixes check-qtest-rx: tests/qmp-cmd-test

Cc: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 qapi/common.json | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/qapi/common.json b/qapi/common.json
index 99d313ef3b..d0fc931159 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -183,6 +183,7 @@
 #        is true even for "qemu-system-x86_64".
 #
 # ppcemb: dropped in 3.1
+# rx: added in 4.1
 #
 # Since: 3.0
 ##
@@ -190,6 +191,6 @@
   'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32',
              'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
              'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
-             'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
+             'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
              'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
              'x86_64', 'xtensa', 'xtensaeb' ] }
-- 
2.17.1



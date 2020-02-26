Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B733C4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 07:40:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5626F21D7E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 07:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ndssu5kA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5626F21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6rJD-00026Z-EK
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 02:40:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45871)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j6rI7-0000Ht-6U
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:39:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j6rI6-0002J9-Aw
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:39:35 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:38938)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j6rI6-0002Fn-5J
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:39:34 -0500
Received: by mail-wm1-x32b.google.com with SMTP id c84so1839906wme.4
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 23:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RMi+1In6gKc2w24FR1knTLNeyasOeUhkZWRlN7yyp1c=;
 b=Ndssu5kA9Hn1ME6ZaR1HV3UlE0UmZPW6ra5skiyO1q2YkoiCYvIvgPFLqe9Jj1QMFt
 1tF1+Phl3i1TUHJUvAIgzTVf6mL+qaTCgsmaeyyMduP+3GTt9aAsNWGGSu+EdVWNm164
 UkpsLqVAHzv/O7XutsRWCOsYtfrq26GiaNSoWS8z5pp3Knym85ONqdy7LwbyHxgrIPFJ
 FPzbw8krXKpLhjgPLQEFmUG1jrb2SviFRvJ4fSGKkG8D8v9sBj1wWCcUjzsyTFd65XbR
 KXg34KqPdoDUQtUU41WkKxVEsmnq1ihhJWjjDT8wDH3m95yTzWcbGUNoB/IYgTtW/ez/
 iFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RMi+1In6gKc2w24FR1knTLNeyasOeUhkZWRlN7yyp1c=;
 b=CeUWu7wztti1Gy9c6WlDk9j9kT+16JDyQYjkaEkvO24+0pdTSULR3aaBGW7GxJ3YQv
 EzvqqRiICUxkxL9J9HUtNiUPJLiZ9Wg0tvt2wMp8ijWmgoCh+CUaUDJK5riQoIFC5zsZ
 l7EOoJ2Mp8mzJ3zS3DNOfe5h7vTYi6KuqiTWnZjeNjcimBEn2FeKVyi+cuRb7wFZHjvQ
 /goSB9MGimfNddsUY978NBTUyf7r/fHlNYI7AjqTLiJmTAWrsXIIRgcXrGolh62eSm7U
 BetdFl2D3pB/EqbeOvikMCNiTrOo56HWQ+gOLpdmFvVjlCbHMw0GLE5sZEBl6p4GiDmF
 kG+Q==
X-Gm-Message-State: APjAAAXeYKijGBSVXGLnnvCMeg2KdmZ10oVJpGm9pzEglUtE+CoWyfqX
 KQCHDmQuUdYkPS/Lb1R/eyD+EPlOeRU=
X-Google-Smtp-Source: APXvYqwZutVZtTsiL9UgY8bjuLoCo8I8nbdYk3MikgQFTTYxXC0L/r08+ybnmdHJ6n5JQpLUgh9u6Q==
X-Received: by 2002:a1c:e0d6:: with SMTP id x205mr2559469wmg.29.1582702773004; 
 Tue, 25 Feb 2020 23:39:33 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 133sm1832715wme.32.2020.02.25.23.39.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 23:39:30 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6CE091FF8F;
 Wed, 26 Feb 2020 07:39:29 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 02/19] tests/rcutorture: update usage hint
Date: Wed, 26 Feb 2020 07:39:12 +0000
Message-Id: <20200226073929.28237-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200226073929.28237-1-alex.bennee@linaro.org>
References: <20200226073929.28237-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Although documented in the comments we don't display all the various
invocations we can in the usage.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200225124710.14152-3-alex.bennee@linaro.org>

diff --git a/tests/rcutorture.c b/tests/rcutorture.c
index 49311c82ea4..e8b2169e7dd 100644
--- a/tests/rcutorture.c
+++ b/tests/rcutorture.c
@@ -413,7 +413,8 @@ static void gtest_stress_10_5(void)
 
 static void usage(int argc, char *argv[])
 {
-    fprintf(stderr, "Usage: %s [nreaders [ perf | stress ] ]\n", argv[0]);
+    fprintf(stderr, "Usage: %s [nreaders [ [r|u]perf | stress [duration]]\n",
+            argv[0]);
     exit(-1);
 }
 
-- 
2.20.1



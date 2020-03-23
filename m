Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A25C54EEB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:19:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B03922051A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ovsw7vOH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B03922051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGPnK-0006RE-Sp
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 12:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35368)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jGPjb-0000wa-Bm
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:15:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jGPja-0002Sm-43
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:15:27 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38651)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jGPjZ-0002Sb-UZ
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:15:26 -0400
Received: by mail-wm1-x342.google.com with SMTP id l20so119861wmi.3
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 09:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8P3sGDqi30dQIBWbHsRxQdWnqMEvDzwadX4cKsMTRfY=;
 b=ovsw7vOHGD5shxJ0DRvENojIpEzGgZBYCTE1rxOd2eRPgq3mSZ7QhuJPmYghFHBjVn
 1+YXOP9w0NnZaXHmDviOj3rz37h3VPC8rEVCC8VuqhRXX9rLQMsD+eJQirWSbHRW1fgn
 hOr1FLoCtMbjplKnyrKLbLvyxSNBJULGylYFnsq4Vr9j8Col46UcWNGnqocKKAVJmSet
 6YxRgRDqgahYX9sWAUvmqt2CmSALpcHaSN/5UfPUliwoUBscE/mHN4XVJ0VO94IOHIVh
 BYTNBY0p3z20iGu4z5521mg79jCBhNwAfayokkpOFn8cSGlm4nXzeY1weP5PCnHVq5Ck
 GNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8P3sGDqi30dQIBWbHsRxQdWnqMEvDzwadX4cKsMTRfY=;
 b=tfuCnbKW/4wTRTqm9bDURTaL6CR8Pw8yShNOt01bzn1iEviKWi01eeZlzvYRCiw8Zy
 tKs7/6Fx9NLhuWOqL0+E5Cw7CC+4AN6SvbB/8VSIvsxujTe2f7DyA6l3masEAtA6AW9J
 KopELP6toOGYPOP94v2hncstKJ8vQ5AVqor7uNub406HyulHSxgJM+JTCsCr/AbMtJEe
 70f1yE2/+1BEbS0nbmm3tRNQzPaF7oIMqG/+oMd7QwEJjKWA9aIhnCKaeBNOC3fC+Uir
 mefbgazskcWEiTNFl6ngbB/c4QJ+uKd0B6BhL+jm7v63Ye4HluI23BlpZPy7D3IoU7yO
 6TVA==
X-Gm-Message-State: ANhLgQ23RkUEtCECI0oNWpBmaRFivPucegkGks2Umj9l5qVJ2C8Fl49U
 6t1gj4rG1EYR9rgapJ1PaWKPLw==
X-Google-Smtp-Source: ADFU+vsQHgpKM1jaKhc/J8UomdFBd0g4fTNMI8xSUSs4byCOwFCderP7fmxwsE5rhOomr2Ul7Gj9Ag==
X-Received: by 2002:a05:600c:2193:: with SMTP id
 e19mr17151wme.142.1584980124816; 
 Mon, 23 Mar 2020 09:15:24 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s15sm25633956wrr.45.2020.03.23.09.15.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 09:15:17 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CEFF11FF92;
 Mon, 23 Mar 2020 16:15:15 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 06/11] configure: disable MTTCG for MIPS guests
Date: Mon, 23 Mar 2020 16:15:09 +0000
Message-Id: <20200323161514.23952-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200323161514.23952-1-alex.bennee@linaro.org>
References: <20200323161514.23952-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While debugging check-acceptance failures I found an instability in
the mips64el test case. Briefly the test case:

  retry.py -n 100 -c -- ./mips64el-softmmu/qemu-system-mips64el \
    -display none -vga none -serial mon:stdio \
    -machine malta -kernel ./vmlinux-4.7.0-rc1.I6400 \
    -cpu I6400 -smp 8 -vga std \
    -append "printk.time=0 clocksource=GIC console=tty0 console=ttyS0 panic=-1" \
    --no-reboot

Reports about a 9% failure rate:

  Results summary:
  0: 91 times (91.00%), avg time 5.547 (0.45 varience/0.67 deviation)
  -6: 9 times (9.00%), avg time 3.394 (0.02 varience/0.13 deviation)
  Ran command 100 times, 91 passes

When re-run with "--accel tcg,thread=single" the instability goes
away.

  Results summary:
  0: 100 times (100.00%), avg time 17.318 (249.76 varience/15.80 deviation)
  Ran command 100 times, 100 passes

Which seems to indicate there is some aspect of the MIPS MTTCG fixes
that has been missed. Ideally we would fix that but I'm afraid I don't
have time to investigate and am not super familiar with the
architecture anyway. In lieu of someone tracking down the failure lets
disable it for now.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>

---
v2
  - only drop mip64le
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 4f12cd01777..a83c6450840 100755
--- a/configure
+++ b/configure
@@ -7885,7 +7885,7 @@ case "$target_name" in
     TARGET_SYSTBL_ABI=n32
   ;;
   mips64|mips64el)
-    mttcg="yes"
+    mttcg="no"
     TARGET_ARCH=mips64
     TARGET_BASE_ARCH=mips
     echo "TARGET_ABI_MIPSN64=y" >> $config_target_mak
-- 
2.20.1



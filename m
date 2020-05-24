Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A46C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 21:58:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6F5320878
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 21:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aS/bUMlP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6F5320878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcydR-0006t8-4y
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 17:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jcyc8-00062y-7z; Sun, 24 May 2020 17:57:00 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40828)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jcyc7-00076X-AI; Sun, 24 May 2020 17:56:59 -0400
Received: by mail-wm1-x344.google.com with SMTP id y5so1810505wmi.5;
 Sun, 24 May 2020 14:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4guKOBYUaC4RD94kzeLD7DKKy9KDIS0J6f/pzDhfBdw=;
 b=aS/bUMlPFciBlbRBklfwvEYEjywl5vhVHOv70c2U4d4gLCptLBfmQBQW42iu/aOGcM
 iaYk5XfHMjDQgzDhgMedc06+2u4uVr+3e9nVw9A7K++UZKc6R5QJAX7nijTXMiaefuBe
 P/9QoyOQRMTljgWZ0OiplsdYNpRgf+hvkd3G2YXzcmSNapN2n7FlJd293oOIp1JQRBCo
 7j855raomoUNTvg+s0gZAE1rjXhyhyzTrmMtjaciJ09zKiToPnVz94xSAUn0Bb/RBz7Z
 gocgtwTpsfjUMEcodzsb0Iyy1QGsBzwTSAZ0pEmYM6phuhYJs3faci8Tl5tQ30b5UBRL
 AQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=4guKOBYUaC4RD94kzeLD7DKKy9KDIS0J6f/pzDhfBdw=;
 b=Y79l6spirf0p+oOyDAztyl3ghKk3BbR8+jFImnmSvOclhaUNSdVteS76ZqVBqEMiez
 dEh/HNrj5nxRiuQSi9x1eSofWyiyDa9EAEcxrpWY9nk5EwQ73e76bE2ZcQDuyEuEH5H3
 84Ac+MdQB3x/vElxJvZ2h0lNvSFZfbEb6G+s1DdZqqglj+qwQU+NB08aQOj+QjGTmLkN
 a0ZujRhi4hQVheahb3S9t66uG61SMM7Hls+X+Ysu4ia1WaXn/CvjA/rSPDrsbFYBMrJo
 PgCmsxwhh+jVQOgKporlyDkHLs4sBWF0ehu2Hfb7COqmh2+kd7G0K5itpaC6TjhAkA6Z
 Yh4Q==
X-Gm-Message-State: AOAM53100/PxqC0hRp46XwYxwr3h+ovZ1GYBAiKVPIAjzNA5uhDbtz8m
 HrP/6UJnvNmxRtfoZtYtUK0nPyFEfak=
X-Google-Smtp-Source: ABdhPJzURmPnbuefAyljBaQeatfisdvsO4o/obArnWLEnkpHyBoXOJ1Xx1lwkDyWdVlRaWYgP9fogQ==
X-Received: by 2002:a05:600c:2dd7:: with SMTP id
 e23mr21868342wmh.96.1590357417085; 
 Sun, 24 May 2020 14:56:57 -0700 (PDT)
Received: from localhost.localdomain (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id u3sm7215228wrw.89.2020.05.24.14.56.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 14:56:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] scripts/clean-includes: Mark 'qemu/qemu-plugin.h' as special
 header
Date: Sun, 24 May 2020 23:56:54 +0200
Message-Id: <20200524215654.13256-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: qemu-trivial@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 "Emilio G . Cota" <cota@braap.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"qemu/qemu-plugin.h" isn't meant to be include by QEMU codebase,
but by 3rd party plugins that QEMU can use. These plugins can be
built out of QEMU and don't include "qemu/osdep.h".
Mark "qemu/qemu-plugin.h" as a special header that doesn't need
to be cleaned for "qemu/osdep.h".

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 scripts/clean-includes | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/clean-includes b/scripts/clean-includes
index dd938daa3e..795b3bea31 100755
--- a/scripts/clean-includes
+++ b/scripts/clean-includes
@@ -123,6 +123,7 @@ for f in "$@"; do
       ;;
     *include/qemu/osdep.h | \
     *include/qemu/compiler.h | \
+    *include/qemu/qemu-plugin.h | \
     *include/glib-compat.h | \
     *include/sysemu/os-posix.h | \
     *include/sysemu/os-win32.h | \
-- 
2.21.3



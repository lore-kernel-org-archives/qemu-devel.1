Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B87C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:49:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E916C206ED
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfFJ0JNb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E916C206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc3nJ-0006bI-Qu
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 04:49:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kc3kM-0004M1-57
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:45:58 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33610)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kc3kK-00036A-Gn
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:45:57 -0500
Received: by mail-wr1-x444.google.com with SMTP id b8so7955209wrn.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 01:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1o8lO3koG16AlBbmrKd/snSNhrR/M4yhMjnc+WbIftA=;
 b=lfFJ0JNb2rBiiklBvMRWfCR2xuij+pgMCgqsLCy81HP4dnZsGa9ab/tral6KSdVN/S
 b4DSOQga0Gi+UYhfqO328qbmbgMW+VMAqCGR4HrGkoy2LrW1g6x80sYavGnSv1s98F5v
 XumyaGK5Or9PB2BeK7vAxuNBbdg1E3V2cPYRJ40N7a7NeO4KY70hCSOoP1Uy4dCvDKWA
 RqBJfzxMsqqYdwpfdzrM+vVZk8hugomSvGJeExtnJemU135/1Bsnwnhi1ipEEk0qTuVT
 rRrW9PLQOu7nPQq052VIQSaJT5fJF4/YsBg78TsY0MfddTYxudPiqIVcZgwELwdU5ejr
 4nwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=1o8lO3koG16AlBbmrKd/snSNhrR/M4yhMjnc+WbIftA=;
 b=nHScBAdADOV6JyrIbvIg38TiMpfIH0kwhUSYV2gJ4YPm3K1FdDQNcZLxw0d+dIXTb1
 Tj4HZ4JeChpVsNCc5dZ2ANjGl3nOm2GjkGszNO1cx/GAioNyxbE5YIDHx6S6O9axOEm0
 3D+isdCtyH+smjj5n0H4LJyaHmcH3HrP3yDAPSMNaTb0N4v8CGbOSFbSWcPjFCtJxSik
 7VHXgVybVp/yCwIfOSbpfRO4/pLQjWl+k+HpAWjjHHPFOs+GSopadSvTzvDgBiWkvfaS
 YNGOAUEbWONZGpNkMXV+AsVFl8XPOLvhzDYRvL5i4UiFFEzRUbJyTr+RIJGUeevFfiDb
 tm5w==
X-Gm-Message-State: AOAM531arVbRGGhNl8P9OhMXT+12qF9l6fOojUimqnnSqRRd/g/NsAw0
 m/uFEqfmlYf7bDq8y8xnsXng5fOB6vw=
X-Google-Smtp-Source: ABdhPJxc4TZdtgyhqebFbBYMGgeJ98UQ+2SDOy/fHp3mL6Ipg+mK+zm9sk7kmSq1DbuRl+juTBkF8g==
X-Received: by 2002:adf:e64e:: with SMTP id b14mr16979874wrn.68.1604915154540; 
 Mon, 09 Nov 2020 01:45:54 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id z191sm12223304wme.30.2020.11.09.01.45.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 01:45:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] accel: Only include TCG stubs in user-mode only builds
Date: Mon,  9 Nov 2020 10:45:45 +0100
Message-Id: <20201109094547.2456385-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201109094547.2456385-1-f4bug@amsat.org>
References: <20201109094547.2456385-1-f4bug@amsat.org>
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
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We only require TCG stubs in user-mode emulation.
Do not build stubs restricted to system-mode emulation
in a user-mode only build.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 accel/meson.build | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/accel/meson.build b/accel/meson.build
index b26cca227a4..609772f129b 100644
--- a/accel/meson.build
+++ b/accel/meson.build
@@ -1,10 +1,12 @@
 softmmu_ss.add(files('accel.c'))
 
-subdir('qtest')
-subdir('kvm')
 subdir('tcg')
-subdir('xen')
-subdir('stubs')
+if have_system
+  subdir('qtest')
+  subdir('kvm')
+  subdir('xen')
+  subdir('stubs')
+endif
 
 dummy_ss = ss.source_set()
 dummy_ss.add(files(
-- 
2.26.2



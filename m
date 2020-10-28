Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064D7C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 17:45:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E038247E4
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 17:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zeafB7Z4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E038247E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXpVj-0005gI-Hc
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 13:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kXpUf-0005Cs-7X
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 13:44:17 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43101)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kXpUc-0001UE-OZ
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 13:44:16 -0400
Received: by mail-wr1-x442.google.com with SMTP id g12so6608259wrp.10
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 10:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YAl0tecVsURCuewdLjQ48RaCrF96ohlsENSIUfpsU+w=;
 b=zeafB7Z4qJnIB81bJuKqrWyMO9ds5lDP45CKMEw/pVonwKm9jJoDyipd2H3Vc+mIDd
 2TKaS8P/pMN1ta1Letyd3LaSmJzn9UmePXvDdcM9gP7wyfaCO0OoNAqNi7MhEYY2hvlE
 wn2dugs4oD/TNrUzhgBHo79XxSxR+3Fme57x5yWtFr3WksdfLEeu3SK5r6xrVaUnA+Ij
 rXw2stqIYJj813rwwTXgDnkGdUyC2/vQFSSecLN2D6JQwTuhLJDvU7/T0PwbBnDpaz5x
 FdHjmjsQkKB3lBqpPZJz4p3gQXTawl7x3qiYhlwGLR031uQS5i3qtFFCh8LpzPDPpwoy
 JPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YAl0tecVsURCuewdLjQ48RaCrF96ohlsENSIUfpsU+w=;
 b=MwwUwjR0SC9J7+RgAn3sy2WyMK2S1XE/KzASAiPom09i63anoSumoueWJmlfgLrQKE
 alUBIc7/l1TIxXR2/sSpB36DI8z5d0eNRVjfQ3eqfIbcyAmXS4HHoBpwgllaQYYq+I7K
 UxMSYXqw1BNtybZTKgb9thZQlQHawfKPjD0FKLeJpfxnMcts/md2+GdF1yNgjX4E0hq2
 Dx0T+wGDVhlimkLOWXo/Ts1ZesadpmiBvA9XlF8AnBZ6FtMexm2UUlXTsrTBmQfagiuR
 JKw3rZJ0pmC4Uv5bZJyFUum9HznJ3JK6TPjX8e9HBnu0WeLSU1gK2rAgRRQB3HhuUCv/
 AGvA==
X-Gm-Message-State: AOAM532v4n3QRTDlKoq8kOHV3zGlwfK2z4wCQPrhk/dk4hnAC8pp7N6U
 hYQcMOeLGnv0XzWpyFQv90F4uQ==
X-Google-Smtp-Source: ABdhPJxtamYIDVXm4aGyKgQ9cjhesv/FKnN4U2mpSB4roy/h9H0baZIpnVLxCyBEEchu2j6Kvww+UA==
X-Received: by 2002:a5d:4051:: with SMTP id w17mr531965wrp.24.1603907050586;
 Wed, 28 Oct 2020 10:44:10 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f13sm438798wrp.12.2020.10.28.10.44.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2020 10:44:09 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5827D1FF7E;
 Wed, 28 Oct 2020 17:44:08 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] meson.build: fix building of Xen support for aarch64
Date: Wed, 28 Oct 2020 17:44:06 +0000
Message-Id: <20201028174406.23424-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>, Paul Durrant <paul@xen.org>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Xen is supported on aarch64 although weirdly using the i386-softmmu
model. Checking based on the host CPU meant we never enabled Xen
support. It would be nice to enable CONFIG_XEN for aarch64-softmmu to
make it not seem weird but that will require further build surgery.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Paul Durrant <paul@xen.org>
Fixes: 8a19980e3f ("configure: move accelerator logic to meson")
---
 meson.build | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/meson.build b/meson.build
index 835424999d..f1fcbfed4c 100644
--- a/meson.build
+++ b/meson.build
@@ -81,6 +81,8 @@ if cpu in ['x86', 'x86_64']
     'CONFIG_HVF': ['x86_64-softmmu'],
     'CONFIG_WHPX': ['i386-softmmu', 'x86_64-softmmu'],
   }
+elif cpu in [ 'arm', 'aarch64' ]
+  accelerator_targets += { 'CONFIG_XEN': ['i386-softmmu'] }
 endif
 
 ##################
-- 
2.20.1



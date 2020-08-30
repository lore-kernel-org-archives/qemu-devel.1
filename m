Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AB3C433E6
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 16:17:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 569A920714
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 16:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tUYoW//U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 569A920714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCQ1k-0004zm-IE
	for qemu-devel@archiver.kernel.org; Sun, 30 Aug 2020 12:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kCQ1D-0004b6-63
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 12:17:23 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38549)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kCQ1B-00034K-Jn
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 12:17:22 -0400
Received: by mail-wr1-x444.google.com with SMTP id w13so3625923wrk.5
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2020 09:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zOEAP4haPoJVvLvsoqXAIDs2I1Rpi1pR9VdVMCLt5ms=;
 b=tUYoW//UQUigXfp7IAlyzh2vYxaGQokMZdzU4OCFHQ+SeW1Vpl63mOw/LrUZjqsn92
 6CMiQcKpcJE5rwGEfn/hLwC3MyY/1QiS8nN4IQGU91UDwP4mt7oVBZKp83x/mdjfsyTk
 YFG5LtVA67/SsCp5LXRnPpYah31+LX/5ldeGCt6Bl1r3Sv2IYbBP9XUtxW64W9MIwA/l
 RexkJZbk6Tp39eLw/65nBRI8S2zA0Wu054pVb8YfXsiIOdA2nOzJmkqML6eyMaASFpiA
 YqczR9yBQ6H01NTbaLuSSUCNM/u2fvqX36AFwhXkXkHb6vu6McPTYxPQ2Strn0Asrrs2
 mTWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=zOEAP4haPoJVvLvsoqXAIDs2I1Rpi1pR9VdVMCLt5ms=;
 b=Wx+dfpuv+3If0NtAky13rIfUEAue/oQLLJthP0+CFzLkTw6PijMfpizEt3dX99TUt7
 FpdG6J8E0v3h4aJswnirAwoHIfoo4bMnIV6n7hPqw+vjr5+SuzVew2FjzypK0M0zaXyh
 3TWpLEnyprZSF7y71QMmc2RfQf5hOpo7sohNXAJ5DuPbQbmKvf1lyg2GMn94/qdxRimz
 3JFyg04TjJiEN0ImOLDQY0fvraA6yL9JS0DMh5U9GhKFJIJZiCZb64c8HuaDko796jFy
 oEn9N40ai+xigYs6sGNKft2AvGM+JfL/X67E4Op8aweVB4hzndQXEaV7xScIo+3zKldx
 y+Qg==
X-Gm-Message-State: AOAM532Whfn/JvcfIeqwSTNC5Ehbrt1RYiphNQxoChafvLys4Z2zFUgy
 ESPWzzPxcS25ybgqUy5yJ/I0sdTcmAk=
X-Google-Smtp-Source: ABdhPJxOOOi1Y5ZDMevjdDHPL4bT0AfB/JtGJZqKFVAH04HPsnfNaipCP2iEb6ZNCqhFrslaDNHUAA==
X-Received: by 2002:a5d:5150:: with SMTP id u16mr7644829wrt.197.1598804239637; 
 Sun, 30 Aug 2020 09:17:19 -0700 (PDT)
Received: from donizetti.lan ([2001:b07:6468:f312:5983:fbc9:7f6f:b2b6])
 by smtp.gmail.com with ESMTPSA id u16sm7436730wmc.7.2020.08.30.09.17.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2020 09:17:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] meson: bump submodule to 0.55.1
Date: Sun, 30 Aug 2020 18:17:29 +0200
Message-Id: <20200830161729.255253-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This version includes an important bugfix to avoid including unnecessary
-Wl,-rpath flags.  It also avoids the warnings on custom_targets with
more than one output.

Reported-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 2 +-
 meson     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 6ecaff429b..783fe03119 100755
--- a/configure
+++ b/configure
@@ -2017,7 +2017,7 @@ python_version=$($python -c 'import sys; print("%d.%d.%d" % (sys.version_info[0]
 python="$python -B"
 
 if test -z "$meson"; then
-    if test "$explicit_python" = no && has meson && version_ge "$(meson --version)" 0.55.0; then
+    if test "$explicit_python" = no && has meson && version_ge "$(meson --version)" 0.55.1; then
         meson=meson
     elif test -e "${source_path}/.git" && test $git_update = 'yes' ; then
         meson=git
diff --git a/meson b/meson
index d0c68dc115..68ed748f84 160000
--- a/meson
+++ b/meson
@@ -1 +1 @@
-Subproject commit d0c68dc11507a47b9b85de508e023d9590d60565
+Subproject commit 68ed748f84f14c2d4e62dcbd123816e5898eb04c
-- 
2.26.2



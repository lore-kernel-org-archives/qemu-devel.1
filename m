Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5812CC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 21:47:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F68220758
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 21:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLHNaPqV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F68220758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDabE-0004vV-AL
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 17:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDaWt-0006WG-C9
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 17:42:55 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435]:33269)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDaWr-0001SQ-PO
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 17:42:55 -0400
Received: by mail-pf1-x435.google.com with SMTP id u20so472812pfn.0
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 14:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Gc5Ac+SIhTGBbDN48ShDt50S5XEQuese4No18vImHG0=;
 b=kLHNaPqVC4VDpLVoX+sYDv7RwU+3RPgfnajFdYjiN/cjG0yFuhfh3xpOXBfRALdrNr
 PeiHSs7Pxmpx1RUTjjQSOh6JvgYsjV0oKZ+M7A29BAZUO0L8LgynMBUALpdchmUVxepJ
 3UoyADOKVLjQ+UjFms87GX1OOGMiVNo7j+9rGjmrhhRSSzwER2NVwC+K2Am3UgKbMkUa
 YLREMon2dzdI0etLz4IhLA+62x+Sl3QAePxSewMnI6gOqVKMaAGZdiUHC3z8s5gS9J4Q
 3SKLUFNuhiT8cpMl9b39305+LBimNo2O0Op02S64zdLfgk+FkO691yH06IdmnB7qN12j
 KSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Gc5Ac+SIhTGBbDN48ShDt50S5XEQuese4No18vImHG0=;
 b=ZInBVnOOTkOITmC7TpKIvHlWfspILOokRnPQ022Blh5A2FyViizXRBR7baojkZUX42
 FsE9LwsAHFYQYAYGE24QHtMNnE0sVK7W12L0V4MhGeVPgn/vNSMv054pAfAfbPBco5L0
 f+bUTqsoN8FLaG9YDMEbboxGs0hWBWjiZcGR/V4nUmAtFBnICA4YQbZuXyuFhukYFo+g
 Syl2prkgtusDASAJuxuuQqk3pCSjBL8J8upa8bJjSCtdqRbOjqCsUMOwKGy66WRBW6R2
 p+tyOSsp6QrJ8/ebce8AQVdEKB84V0OuNP3L1cirkRCNXkrgIZJ3Ep96bSJ8UYtyqiLy
 DULQ==
X-Gm-Message-State: AOAM531PpJsXEgvFqsEkVsFIOpmcjYVGDZkCz/U8qAWdYyN4UZLyM16u
 UQDLOeiEAQkJUKR0viWOKbEEHdIwS0hHLw==
X-Google-Smtp-Source: ABdhPJyh403W32VjNpM7W+gLHYyf+2WzzoO3E/KJP/QGUKqhzITxi6CmQPfxvDBrYgzHmNeBxRP69A==
X-Received: by 2002:a63:5c1a:: with SMTP id q26mr3481252pgb.223.1599082971266; 
 Wed, 02 Sep 2020 14:42:51 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id x12sm328863pjq.43.2020.09.02.14.42.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2020 14:42:50 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 8/9] ci: fixes msys2 build by upgrading capstone to 4.0.2
Date: Thu,  3 Sep 2020 05:42:10 +0800
Message-Id: <20200902214211.337-9-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20200902214211.337-1-luoyonggang@gmail.com>
References: <20200902214211.337-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x435.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 capstone  | 2 +-
 configure | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/capstone b/capstone
index 22ead3e0bf..1d23053284 160000
--- a/capstone
+++ b/capstone
@@ -1 +1 @@
-Subproject commit 22ead3e0bfdb87516656453336160e0a37b066bf
+Subproject commit 1d230532840a37ac032c6ab80128238fc930c6c1
diff --git a/configure b/configure
index 5f2bcc4b57..e42d210e5f 100755
--- a/configure
+++ b/configure
@@ -5248,14 +5248,14 @@ case "$capstone" in
       git_submodules="${git_submodules} capstone"
     fi
     mkdir -p capstone
-    QEMU_CFLAGS="$QEMU_CFLAGS -I${source_path}/capstone/include"
+    QEMU_CFLAGS="$QEMU_CFLAGS -I${source_path}/capstone/include -I${source_path}/capstone/include/capstone"
     if test "$mingw32" = "yes"; then
       LIBCAPSTONE=capstone.lib
     else
       LIBCAPSTONE=libcapstone.a
     fi
     capstone_libs="-L${build_path}/capstone -lcapstone"
-    capstone_cflags="-I${source_path}/capstone/include"
+    capstone_cflags="-I${source_path}/capstone/include -I${source_path}/capstone/include/capstone"
     ;;
 
   system)
-- 
2.27.0.windows.1



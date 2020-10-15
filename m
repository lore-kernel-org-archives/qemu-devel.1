Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B86BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 22:08:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C442076A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 22:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9fza9BE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C442076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTBQH-0001O1-Jc
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 18:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kTBOb-0008U2-9c
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 18:06:49 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029]:52469)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kTBOZ-00071u-M5
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 18:06:49 -0400
Received: by mail-pj1-x1029.google.com with SMTP id gm14so221800pjb.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 15:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gD6WMWYQ9CIQ4TmbgB/h0Tt9F/nzYRkxmSRyeiKZIXA=;
 b=b9fza9BE/U6+owvUqHYymJTbslqBwZRA+u7Qf2e4thvAe6DV2QBbLutr8mTVnxqCPj
 GagF3Hfwp44dWGk2XAK4x4PPKY4b9H5Lvce4PurHHyS9GbClogBGQjQNhWK19fY3VIOG
 smREFx2qKaK7HmFvG6G8lNFF46cqXbKDIV41tNDaD1SF26T1HQh3kFsd0MYeiLdTH5ZF
 EBxPeCtkgvO7hnHaQ8IFhuPBnOi8jOUcGBlmFQOoMNzZW9vXd8mPeSn/mJ06s1y2polX
 L+WY40WyvN5tCjtJwzoCXz5tTYb+GRCfgbVj0Fz8KD9Ja+aaxLFsoYUddNTiVV7GqXjB
 IXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gD6WMWYQ9CIQ4TmbgB/h0Tt9F/nzYRkxmSRyeiKZIXA=;
 b=TiKqt6jDxn5r51lSddb6DDBkS1iYbjExHMi4Oh69GRiFquIFbBq7GVNk+W4+soSLEG
 IzIvzYw+Z+lDMXEhqqtSvXj+VVi2j/6uNa3bkcdvYb1zoSCNn2LM9KW39JaquP12wmOn
 86IJ2SoY2GVgResto97XMmzbHNmBPBk4/+SJ999Uk5U5by7BXZPR1MhJOk5ZntUz2uTo
 No1z2pWTZ7qUmLIa+S50HlnJowia+IR2bwOXaCg7Q+kjLNlWggVv/qScbYbEThzPJk2Y
 AhPpnAUESDUPVjO0939/FZt71P1hRFKI8JkeDpz0dlCXPjWFwQxtd/CefICNbC79wUyD
 R5JA==
X-Gm-Message-State: AOAM53282uviw2+BDE8Rg4oaj+7KzGpYy+iF1mXqgSoLB6AiIg0s2YCt
 n/ZOEQF+FE8XR+0O8DGDbIHNIMsqZ6zdjTOT
X-Google-Smtp-Source: ABdhPJzbylEiQ3UUFHrRNhJaUa7JpXTER8Gv3U2Fcz+f3awphN03qp017ZAkFTnN8wwUeKZcPDEX+Q==
X-Received: by 2002:a17:90a:8002:: with SMTP id b2mr799915pjn.47.1602799604756; 
 Thu, 15 Oct 2020 15:06:44 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id x10sm261468pfc.88.2020.10.15.15.06.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2020 15:06:44 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 1/4] docs: Fixes build docs on msys2/mingw
Date: Fri, 16 Oct 2020 06:06:23 +0800
Message-Id: <20201015220626.418-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201015220626.418-1-luoyonggang@gmail.com>
References: <20201015220626.418-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1029.google.com
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

meson didn't support running ../scripts/kernel-do directly

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 docs/conf.py             | 2 +-
 docs/sphinx/kerneldoc.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/conf.py b/docs/conf.py
index 00e1b750e2..e584f68393 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -241,7 +241,7 @@ texinfo_documents = [
 # We use paths starting from qemu_docdir here so that you can run
 # sphinx-build from anywhere and the kerneldoc extension can still
 # find everything.
-kerneldoc_bin = os.path.join(qemu_docdir, '../scripts/kernel-doc')
+kerneldoc_bin = ['perl', os.path.join(qemu_docdir, '../scripts/kernel-doc')]
 kerneldoc_srctree = os.path.join(qemu_docdir, '..')
 hxtool_srctree = os.path.join(qemu_docdir, '..')
 qapidoc_srctree = os.path.join(qemu_docdir, '..')
diff --git a/docs/sphinx/kerneldoc.py b/docs/sphinx/kerneldoc.py
index 3e87940206..3ac277d162 100644
--- a/docs/sphinx/kerneldoc.py
+++ b/docs/sphinx/kerneldoc.py
@@ -67,7 +67,7 @@ class KernelDocDirective(Directive):
 
     def run(self):
         env = self.state.document.settings.env
-        cmd = [env.config.kerneldoc_bin, '-rst', '-enable-lineno']
+        cmd = env.config.kerneldoc_bin + ['-rst', '-enable-lineno']
 
         filename = env.config.kerneldoc_srctree + '/' + self.arguments[0]
         export_file_patterns = []
-- 
2.28.0.windows.1



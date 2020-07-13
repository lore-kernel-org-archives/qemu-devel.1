Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED08C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:26:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AA90205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qiimElh+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA90205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzPR-0006zm-Ao
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzB2-0005WQ-8K
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:28 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:53219)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzB0-0006ef-G8
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:27 -0400
Received: by mail-wm1-x333.google.com with SMTP id q15so13462070wmj.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 07:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=OhiRntG58GDC0YrDMGX+/f9xZGwt8SVRtnGNjupJDac=;
 b=qiimElh+YcKrUf7jd3hE09/IvdvkMZDia3108rcbqcg7A3sAW00m1sBlAruyAe9FEa
 pf96JwnrO0CZZ3R2nX7WswX/UScZd89Y+pvwdKdo7YuGiXZTZ89dS5+xLzl5TKiW6fJX
 Dpcs72bAyxyevwyinbdi5GqlkgdD1vI5TZa/i2FqU6UasfbhWudKUlcKpmKQ/2Q3Sk7X
 BsMJn3DK09/aRZtic12GI9J0B5UIgzcd0gcnN2fmrZu/617UZWTZbDoCL88CvLmoF87N
 ZOlMypit4XMTjE28VvpJTJyN0a1a6DX4h+a4YSh3ztHAhFNjbrs8lxCmpV70moU+kA4R
 2xzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OhiRntG58GDC0YrDMGX+/f9xZGwt8SVRtnGNjupJDac=;
 b=m+s5jVa22YVr6q/ltQxMGki2d8m3CCpYsuwESugF7PW+oTda8SyRMuaX8Oe6/yYJGm
 jnQMpqhvGlOPftrhiwK80wxKtOU5i1Q8Qmm6eiA9v8oIli48HCFC1amGk0MQLA5aGxkM
 qX+wVPy4uTJtjyWUxYkNAPAbwu5A62TPav6GMg4NcbR14prf8Dew6lxJi4qXi3WGb0T+
 mqvKBtTWE+7PTHOl8IR1+crUPuvGL7/aKExnIa7Q5CVZTiElEO6x6I/Sj+/Wu2mHgCqg
 EhJREHvMKpbwHduuK7TRy7tYaFjjUfrZNwJyvTj41Cumqfe6SiZ/Bjx9emI+I9cdeYCG
 Hvrw==
X-Gm-Message-State: AOAM531K+EFuU8IFzx0f0psVAVJ4ZwGu9dFedl8Dvbd6WQL+4pn36ldK
 tYc6ZTnzTF4pgf0tSipxVT2B5cgX98yYLw==
X-Google-Smtp-Source: ABdhPJzZqAS0Fic/ezG1ZSOHXff7DVvm/gtBsHlJgwZtXAg+7SkX98J81e00hwRsKTgPavkR024lMA==
X-Received: by 2002:a1c:dd09:: with SMTP id u9mr175003wmg.70.1594649484792;
 Mon, 13 Jul 2020 07:11:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c136sm24031297wmd.10.2020.07.13.07.11.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 07:11:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/25] util/drm: make portable by avoiding struct dirent d_type
Date: Mon, 13 Jul 2020 15:10:55 +0100
Message-Id: <20200713141104.5139-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200713141104.5139-1-peter.maydell@linaro.org>
References: <20200713141104.5139-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Given this isn't perforance critical at all lets avoid the non-portable
d_type and use fstat instead to check whenever the file is a chardev.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reported-by: David Carlier <devnexen@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200703145614.16684-10-peter.maydell@linaro.org
Message-id: 20200701180302.14821-1-kraxel@redhat.com
[PMM: fixed comment style; tweaked subject line]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 util/drm.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/util/drm.c b/util/drm.c
index a23ff245382..dae8ffebc81 100644
--- a/util/drm.c
+++ b/util/drm.c
@@ -24,7 +24,8 @@ int qemu_drm_rendernode_open(const char *rendernode)
 {
     DIR *dir;
     struct dirent *e;
-    int r, fd;
+    struct stat st;
+    int r, fd, ret;
     char *p;
 
     if (rendernode) {
@@ -38,10 +39,6 @@ int qemu_drm_rendernode_open(const char *rendernode)
 
     fd = -1;
     while ((e = readdir(dir))) {
-        if (e->d_type != DT_CHR) {
-            continue;
-        }
-
         if (strncmp(e->d_name, "renderD", 7)) {
             continue;
         }
@@ -53,6 +50,18 @@ int qemu_drm_rendernode_open(const char *rendernode)
             g_free(p);
             continue;
         }
+
+        /*
+         * prefer fstat() over checking e->d_type == DT_CHR for
+         * portability reasons
+         */
+        ret = fstat(r, &st);
+        if (ret < 0 || (st.st_mode & S_IFMT) != S_IFCHR) {
+            close(r);
+            g_free(p);
+            continue;
+        }
+
         fd = r;
         g_free(p);
         break;
-- 
2.20.1



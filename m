Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42A6C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:33:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E93F205F4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u2tlUM6K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E93F205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDkgr-0001fw-Io
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 04:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDkf8-0007d1-CT
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:32:06 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:54911)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDkf6-0001Vj-Oe
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:32:06 -0400
Received: by mail-pj1-x1042.google.com with SMTP id mm21so1161640pjb.4
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 01:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=W6KPp+bY7QhvrPjQuzc5G0s+mWhPDfMNCdKRNThSh6I=;
 b=u2tlUM6KWeJMwrsPAvNqvjEZWiWZShEhzgvWsgfnqkFfI0YEhQsrnNhH/LA0fn1wAV
 Cfr4mGZJisBtV38LCA1Bq7ZK3VZ+uCcLBkhTaniPgNbOdxdaKkGFFuddAkKtyyanxli9
 720Vod65rvHylQNGiPtsn5aW2WUTtpEejtSb4vRNVjPw1O6e32OCfWZKpB0nl7zyEnY9
 H2YyztR3bAZMSRM83i0DzVHkdpocgYmmqcjnbqgfg2x3yKhbLB0L1lBpbCs4SagvOuH/
 YXWxsMu18DiI/UzpleJuff7lSUGEB35iYt4vdN1/L69Ye2SkKWgGa9JMa3FGroNNYt36
 4bhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=W6KPp+bY7QhvrPjQuzc5G0s+mWhPDfMNCdKRNThSh6I=;
 b=o3Nk1eXVGCOGeKvQcQSCxv9LiUOQN3cwNeaZAZCLJYppz0Mx3+6qDx+WK8komNbp+k
 ZUlKlDz2W+8HQY7ZvWkt20uDw5pRapx/6UUGc036G5j8L8pH96fbpuuD6Lvxh8WaJCby
 0U0h42ZCSZ1ocDbsKRZtHcnfbA0vvsVoOuJKrxwmjeyTtmtkA8tvmo36zi+KpirpX5tv
 akYniN+SQRUj6T0ZBeKkEo/B4pAz9zy5BEyX7pt5QyJ9gu6QE9Fw13+zCok07JdThS9S
 6DK/4n1BEY1vG3z2B0eCGshuwzAwqSTM/yPNi2+Je98OXWzeN/A8H3JmhuQg8tVMMtrn
 orvg==
X-Gm-Message-State: AOAM532vPPdcxjlO0gDLDqBweVmM6osMo0RLqT9a6jTDhX0vP7A2L/JE
 pIbbmpTPs6tCIea474cOZXIHaMP+LXM0Stvz
X-Google-Smtp-Source: ABdhPJzpwc/AgVeQVea2//zxbar2sYfkfhycQpG2yYXv17W5dR1tTc+yti73t4f/bjiyMK+8qzLirg==
X-Received: by 2002:a17:90a:880e:: with SMTP id
 s14mr2235609pjn.140.1599121922742; 
 Thu, 03 Sep 2020 01:32:02 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id e7sm1759201pgn.64.2020.09.03.01.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 01:32:02 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 01/12] configure: fixes dtc not cloned when running msys2 CI
Date: Thu,  3 Sep 2020 16:31:36 +0800
Message-Id: <20200903083147.707-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200903083147.707-1-luoyonggang@gmail.com>
References: <20200903083147.707-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1042.google.com
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

Symlink dtc after git submodule update, because on win32 symlink to non-exist folder are forbidden.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 configure | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/configure b/configure
index 8a3acef89d..30f8c4db29 100755
--- a/configure
+++ b/configure
@@ -2053,9 +2053,6 @@ fi
 if test "$meson" = git; then
     git_submodules="${git_submodules} meson"
 fi
-if test "$git_update" = yes; then
-    (cd "${source_path}" && GIT="$git" "./scripts/git-submodule.sh" update "$git_submodules")
-fi
 
 case "$meson" in
     git | internal)
@@ -4261,9 +4258,6 @@ EOF
       if test -d "${source_path}/dtc/libfdt" || test -e "${source_path}/.git" ; then
           fdt=git
           mkdir -p dtc
-          if [ "$pwd_is_source_path" != "y" ] ; then
-              symlink "$source_path/dtc/Makefile" "dtc/Makefile"
-          fi
           fdt_cflags="-I${source_path}/dtc/libfdt"
           fdt_ldflags="-L$PWD/dtc/libfdt"
           fdt_libs="$fdt_libs"
@@ -6593,6 +6587,16 @@ if test "$cpu" = "s390x" ; then
   fi
 fi
 
+if test $git_update = 'yes' ; then
+    (cd "${source_path}" && GIT="$git" "./scripts/git-submodule.sh" update "$git_submodules")
+
+    if test "$fdt" = "git" ; then
+        if [ "$pwd_is_source_path" != "y" ] ; then
+            symlink "$source_path/dtc/Makefile" "dtc/Makefile"
+        fi
+    fi
+fi
+
 # Check that the C++ compiler exists and works with the C compiler.
 # All the QEMU_CXXFLAGS are based on QEMU_CFLAGS. Keep this at the end to don't miss any other that could be added.
 if has $cxx; then
-- 
2.28.0.windows.1



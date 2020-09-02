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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604BBC2BBD0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:02:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D4542067C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qEZtLshl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D4542067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDW9J-0001ix-Br
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 13:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDW8L-0008WN-NB
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:01:17 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:39299)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDW8J-0000Gt-Pk
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:01:17 -0400
Received: by mail-pl1-x642.google.com with SMTP id x18so40130pll.6
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 10:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=38x0lAOA2AfvsIyHP+ReuB52i8b3LJOhHNpZq8BiwHk=;
 b=qEZtLshlbaYxYZeA2n1+SfYzq5CEui0yQ8Pqer+EZpYeTt/IGUtC3f4+vEbYdZmuvG
 WcqHnFQpPfA+EJKdhl6db062f9PVgx8V0XPGrKeIvNOmGnX99/rjpFd3bybtYNBuBQUL
 pIMAxVgIWpCCnwDls9rKhu0vca7/yimnLhbhpWGvm/+ZAj3o72k5eu8IiAk7pfZ6+18V
 1aXcVFIzB9EKU1YspEKe0T8mYER/XbqEtu42G5CTke+5shlIDbcw6KlNwU7x4xkC4JOz
 YnRclJHjzAIN14OGl4RJN3fqSSWXFeomuwNsn+9RzGz54BUBNJ0IThEo2jSkS7820et0
 siyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=38x0lAOA2AfvsIyHP+ReuB52i8b3LJOhHNpZq8BiwHk=;
 b=sFiPD2FD48gpJJxp88NkTCl89bR9hHSi3uu4DAuPnuAzAFHgOBoWwsME0SXlKaDOvF
 AM9nwDkytM6CbIdwQWK+KChYBUe3xDWJpzyBQNID+FOIphjffV6e8mQM1zICHwPjJgAN
 J1biXapJcJc6AF9xhHOyehEh+pepOee7FdKWZn5THIbXAXckWH5Ku0Mnnlx7KF+zS11O
 qg0tZbcDqrAQiaY6Cpz8d9KDxNBtdUP1qP61wyVtKLXUSOKAeWxsZHzX5bME1odiuI4T
 jRrgzN+8wf7QY/+CKme4evbbauKePX7tWYqqcwE6jPytTlaZVteSKupvnUeV4JGZ0VFA
 xGPA==
X-Gm-Message-State: AOAM532H+7f59zPVFJuk2Nx1rqQabdp42BdIpioGz4SFT5zbMZ8u/uPw
 5PCilrKysN5r5zlw6PU1JrA4LNKsvVI=
X-Google-Smtp-Source: ABdhPJzJdvKDp8fqKbceWE4+l/g2etGf7lxfHWl26+9n7bmdUtuefTnn+iofL4QFdFhPWQ4b+uHyLQ==
X-Received: by 2002:a17:90a:8d85:: with SMTP id
 d5mr2849276pjo.45.1599066073897; 
 Wed, 02 Sep 2020 10:01:13 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id x4sm40527pfm.86.2020.09.02.10.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2020 10:01:13 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/6] configure: fixes dtc not cloned when running msys2 CI
Date: Thu,  3 Sep 2020 01:00:49 +0800
Message-Id: <20200902170054.810-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20200902170054.810-1-luoyonggang@gmail.com>
References: <20200902170054.810-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x642.google.com
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
2.27.0.windows.1



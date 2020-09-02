Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9434DC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 21:43:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54437207EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 21:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JaKsd5Ee"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54437207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDaXr-0007dN-Ha
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 17:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDaWb-000672-Ce
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 17:42:37 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:39761)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDaWZ-0001QE-SE
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 17:42:37 -0400
Received: by mail-pf1-x441.google.com with SMTP id u128so450630pfb.6
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 14:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=38x0lAOA2AfvsIyHP+ReuB52i8b3LJOhHNpZq8BiwHk=;
 b=JaKsd5EeuMSJds4q5R4HR/TtJPk8oi5ylSr2sONOvWmjTdovICnzIIhRKVPqqqk7oa
 3o/qsjVsGb1if9zAV5+Y2+L/Wj1YjzhIFRQdNsNNKTD0f7LE5cV2FTDnl7A2eviAS4Nx
 5YNJkWKm04Y41NpDKFOj025XMK1a0sB7DxZE6Tcw/CPbNo8h5gaCiPBZxmqXve+7kIrR
 qNt4gtMYCOSJkl2iif8/qXb668I2woQbPdr63Ow6PQ1cOCZl5lOrooEijL4NkmuznoBG
 /KwsIxtss/SHElp1lM21bVtt9f6Q9l1llz/izu7f5dvb+pI1kk/pCklav4rVQ5WC5Iqc
 lOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=38x0lAOA2AfvsIyHP+ReuB52i8b3LJOhHNpZq8BiwHk=;
 b=L/Lnzk7CJQXU1Cev+y2kR6HEHguYyTIkEEN1P3zEekJTwL2abCYEQ1iseiO7FyVK5c
 vQ61rRp6tmm2hEm7cVe5OYzrg5WtE9UiJ+pelUZpta+8BQAQAA3+oO9TLwUSplB56/k2
 yMe+CgavvrhXLKT9GiCMNFhUw75JyZGyH/0233y4FPD7TyeMxzAlesDLTp5XxYOhsby2
 e89mnxVW/1y7Q6HP15SsybO3kW1cgjl36+qtKePC4V+pVzTFbdqZ73KgLnvQCUXdgq7w
 9jeAcvg06UHqoOM8d8tZYEAyYl36IE1Xutjv/ZdVj3J+peR7tPr10PrRCLZDpTKs5XUY
 /1Mw==
X-Gm-Message-State: AOAM530Tv5KUT13X5PpekIP/yy367b9JnwDRJGNVukRMHMMqLhsGETtP
 V/VM9HYQBlbIGyGRNNXfX87EPlarjp1wdQ==
X-Google-Smtp-Source: ABdhPJz+vXxWGtQ08j/JrRtpzTSM1BHMGsytuH3wuYTE+uDUNKryz9Mc84t40TV75joqzsgmWGhAkA==
X-Received: by 2002:a17:902:6bca:: with SMTP id
 m10mr399039plt.210.1599082953805; 
 Wed, 02 Sep 2020 14:42:33 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id x12sm328863pjq.43.2020.09.02.14.42.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2020 14:42:32 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/9] configure: fixes dtc not cloned when running msys2 CI
Date: Thu,  3 Sep 2020 05:42:03 +0800
Message-Id: <20200902214211.337-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20200902214211.337-1-luoyonggang@gmail.com>
References: <20200902214211.337-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x441.google.com
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



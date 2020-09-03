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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DF9C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 07:44:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6FDA2071B
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 07:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gN6BnqOL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6FDA2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDjux-0000x2-Tz
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 03:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDjuC-00081V-1S
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 03:43:36 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34238)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDju8-0003qr-Mn
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 03:43:35 -0400
Received: by mail-pg1-x541.google.com with SMTP id u13so1463872pgh.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 00:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=W6KPp+bY7QhvrPjQuzc5G0s+mWhPDfMNCdKRNThSh6I=;
 b=gN6BnqOLjNMktKCnAFxh/EAMph86YRrSlcF0UsHLYhuNKcZ4beZ+uMelbktCIdXEP+
 mbS1fwcH3GjLQjATStmhP+W9+4VHvq1YtoNNU+OF8JWFFko6aCa+aLU8ZK5/vFwu+e0Q
 PWzkbdKKLJ3EOcP2xc0u26DSis629dfYl9x7BBmFPa2yPJ6UERzPIrE3zMDu6x0pYRzJ
 oLzqKa43/ucdS0MQqox701TB0PzVv0eHHjp0cTem/nmQ/sCc9zyYsuRy1zQvli3GEjjI
 8LEeLYLQpeEeW9vSg7aU9uqon+vDjKgiJT9MNGcODJ2yltr+0L5jjWIl8ydNLBJTqMqy
 U4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=W6KPp+bY7QhvrPjQuzc5G0s+mWhPDfMNCdKRNThSh6I=;
 b=tkA6AT/WX0+sYO7p5mqUnyxf2QlMqOhkU261BPwlVnvs+FLKa78EO3ttvODllbICZE
 OFIaedHzhdqAh/40ly0RbY8GGtZMRRsb+GJ+yUNOzHEVhA5SNGY9oFuFp20lomUkMCy9
 MoTHXy8j5NVj2F0y/l7aPcvjjnV6nt3Ht8qAj49Jshw4/e1AQFnBNg3HagH2IW7EaWcd
 mVOQ95jxfNpRXkpXpYW8khGqwhfl3Hwo8V2Rk/ChvAEiRIUqvCCR6TVR+TRXs28XqkpJ
 etXIrr56ARPfCjNqiH/F2Y2ah/E0xMXNpMa6IeQArlMjRQUwXo7z/cOnqOB/JtZQWtyi
 nhoA==
X-Gm-Message-State: AOAM533EWnbUSO7Js6GDWkdHTzPNSSPFWT0i4aRgpN8b27fboWKYQ1ey
 0RVOFggkZ8JvHfFN/CIDWL01SCIIgx6KHA==
X-Google-Smtp-Source: ABdhPJy82Qlz5C0x0RTpK4Cj9duofmHEA5GbzVt9WkTi0UomsnXi9K0lVrWLo6J0GSZfn+81HBoo+Q==
X-Received: by 2002:a62:5fc4:: with SMTP id t187mr2650250pfb.34.1599119010850; 
 Thu, 03 Sep 2020 00:43:30 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id o6sm1512472pju.25.2020.09.03.00.43.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 00:43:30 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 01/12] configure: fixes dtc not cloned when running msys2 CI
Date: Thu,  3 Sep 2020 15:43:02 +0800
Message-Id: <20200903074313.1498-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200903074313.1498-1-luoyonggang@gmail.com>
References: <20200903074313.1498-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x541.google.com
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



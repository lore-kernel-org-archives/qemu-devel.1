Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB650C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:33:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8659C25750
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f0wR+s4P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8659C25750
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50859 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWIN6-00081m-Ne
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 06:33:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWI6f-0002iD-7u
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:16:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWI6e-0006cZ-2r
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:16:21 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39187)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hWI6d-0006bp-Qi
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:16:20 -0400
Received: by mail-wr1-x444.google.com with SMTP id x4so3823233wrt.6
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 03:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=y2B2y1XQyJxhlxlLqIvvLBXxQCmx4xrmH/BIjlRjWcs=;
	b=f0wR+s4PFVjNDk4AMOB+0UFj5XJN5P3DQ+suNvlR1vlOZFnL/ZdlFwTdxwMLARF6Tr
	gpbCJkbLz95o0AgRFTltIfiu1vdPzisBn+wo6PNUqvmmm2IDVlZ6u4plFy3sxSzDDcRz
	Us7bfyFayZm58+kC7y40nKaa9aZ+wvtZe9cn53GsyUpLVMmcq0Dwa4kwI0SViCPy8fNy
	PwDRUw/YygeIiMlUo4GX13xiafwhWPlS6LljgFWIZNgVGArq5naOngOSj/5qyyRabV2X
	HGn3Y/+4XzA91bHjENRe9euUc9hHhVvM44ddQX9Jo8ZWJMkMkJz+CA+Q4UPo2cIB4vhm
	mA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=y2B2y1XQyJxhlxlLqIvvLBXxQCmx4xrmH/BIjlRjWcs=;
	b=sVtUe1WaUcxvxrXyujWC57rj/tfdpyM2J4iR0EJUn8c3gM6WYs3YfJ7pfLfhg6AxXo
	Gg2zU96/j2HBGTbeVdwmXmhz84PHXE8DizuvrjrtRFEmBor4L9JJ4LU5s6fNTYGvhW+a
	uVjeDKNWGecYDsRiCvQk/xY1UQ7cWwnnE86aDxybE8wQgaCcsrdaffiyyNjybT40KBjW
	LFNeTR2W5rL3qXVm+WLIXoZlDwtpFyfyI1PqCBRGSkcS73gKtfADMtAZLk6KuTgPNK+I
	zH5NkGlXaV9SorGQU+l6xAopXAKD3rIzgg95dhvyoG1yADwX3Ofoqn2B6W6kCwr0QF5r
	bIDw==
X-Gm-Message-State: APjAAAXtMJRgb+A51GJUB6R7YLimQdUY3W1qej7nUN5ag+eDA3gXJcZ+
	NYtll63b243Wf7+wlVn+4Cz7y49DxHA=
X-Google-Smtp-Source: APXvYqz1kHYFpJlkWKPIPHy8MV5oBerdGUwyhZy8vFS5nefHZMDqwx7gUHGry4D8qbXDHwbJ7ioe/w==
X-Received: by 2002:a5d:51cf:: with SMTP id n15mr958810wrv.216.1559211378693; 
	Thu, 30 May 2019 03:16:18 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id o4sm2355995wmo.20.2019.05.30.03.16.09
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 30 May 2019 03:16:17 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 20DA71FF9D;
	Thu, 30 May 2019 11:16:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 30 May 2019 11:15:50 +0100
Message-Id: <20190530101603.22254-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190530101603.22254-1-alex.bennee@linaro.org>
References: <20190530101603.22254-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v1 13/26] scripts: use git archive in
 archive-source
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Thomas Huth <thuth@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Use git archive to create tarballs of qemu and submodules instead of
cloning the repository and the submodules.  This is a order of magnitude
faster because it doesn't fetch the submodules from the internet each
time the script runs.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190520124716.30472-2-kraxel@redhat.com>
[AJB: fixed up tabs]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/archive-source.sh | 72 +++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 41 deletions(-)

diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index 8b899482600..ca94e49978f 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -19,16 +19,25 @@ if test $# -lt 1; then
 fi
 
 tar_file=$(realpath "$1")
-list_file="${tar_file}.list"
-vroot_dir="${tar_file}.vroot"
+sub_tdir=$(mktemp -d "${tar_file%.tar}.sub.XXXXXXXX")
+sub_file="${sub_tdir}/submodule.tar"
 
 # We want a predictable list of submodules for builds, that is
 # independent of what the developer currently has initialized
 # in their checkout, because the build environment is completely
 # different to the host OS.
 submodules="dtc slirp ui/keycodemapdb tests/fp/berkeley-softfloat-3 tests/fp/berkeley-testfloat-3"
+sub_deinit=""
 
-trap "status=$?; rm -rf \"$list_file\" \"$vroot_dir\"; exit \$status" 0 1 2 3 15
+function cleanup() {
+    local status=$?
+    rm -rf "$sub_tdir"
+    if test "$sub_deinit" != ""; then
+        git submodule deinit $sub_deinit
+    fi
+    exit $status
+}
+trap "cleanup" 0 1 2 3 15
 
 if git diff-index --quiet HEAD -- &>/dev/null
 then
@@ -36,45 +45,26 @@ then
 else
     HEAD=$(git stash create)
 fi
-git clone --shared . "$vroot_dir"
-test $? -ne 0 && error "failed to clone into '$vroot_dir'"
-for sm in $submodules; do
-    if test -d "$sm/.git"
-    then
-       git clone --shared "$sm" "$vroot_dir/$sm"
-       test $? -ne 0 && error "failed to clone submodule $sm"
-    fi
-done
-
-cd "$vroot_dir"
-test $? -ne 0 && error "failed to change into '$vroot_dir'"
-
-git checkout $HEAD
-test $? -ne 0 && error "failed to checkout $HEAD revision"
 
+git archive --format tar $HEAD > "$tar_file"
+test $? -ne 0 && error "failed to archive qemu"
 for sm in $submodules; do
-    git submodule update --init $sm
-    test $? -ne 0 && error "failed to init submodule $sm"
+    status="$(git submodule status "$sm")"
+    smhash="${status#[ +-]}"
+    smhash="${smhash%% *}"
+    case "$status" in
+        -*)
+            sub_deinit="$sub_deinit $sm"
+            git submodule update --init "$sm"
+            test $? -ne 0 && error "failed to update submodule $sm"
+            ;;
+        +*)
+            echo "WARNING: submodule $sm is out of sync"
+            ;;
+    esac
+    (cd $sm; git archive --format tar --prefix "$sm/" $smhash) > "$sub_file"
+    test $? -ne 0 && error "failed to archive submodule $sm ($smhash)"
+    tar --concatenate --file "$tar_file" "$sub_file"
+    test $? -ne 0 && error "failed append submodule $sm to $tar_file"
 done
-
-if test -n "$submodules"; then
-    {
-        git ls-files || error "git ls-files failed"
-        for sm in $submodules; do
-            (cd $sm; git ls-files) | sed "s:^:$sm/:"
-            if test "${PIPESTATUS[*]}" != "0 0"; then
-                error "git ls-files in submodule $sm failed"
-            fi
-        done
-    } | grep -x -v $(for sm in $submodules; do echo "-e $sm"; done) > "$list_file"
-else
-    git ls-files > "$list_file"
-fi
-
-if test $? -ne 0; then
-    error "failed to generate list file"
-fi
-
-tar -cf "$tar_file" -T "$list_file" || error "failed to create tar file"
-
 exit 0
-- 
2.20.1



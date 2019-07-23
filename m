Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA420C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:36:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A38D1223DD
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B2DSqrpz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A38D1223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hps9u-0006jC-GH
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 06:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37723)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hps9Y-0005e2-Nc
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:36:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hps9X-0007Jv-Ig
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:36:16 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:37955)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hps9X-0007JG-A1
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:36:15 -0400
Received: by mail-wr1-x42a.google.com with SMTP id g17so42618508wrr.5
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 03:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=15XBOc0K5qrNi75fMYOmlumdevbJac2m4Bpn4CypPlo=;
 b=B2DSqrpzzF0HRMUDsahhhPa6Bolw2/eucsbP25fQ2Yia0RuQkfY9+vJNNzH5gb9929
 KlQ5MAEx4kUy/4SlrNBVu+OrLG4JpMQF7XWwMI3dCqf4OcZ13zsfjs+z1Ou8tGZPwpC/
 WBggFNrJNODTmexZCvOXtX416sGnGu5SMEAcp4dYq5xehml8Ezs7nRcKZpO9RKImtGdD
 DbMY5zSky1QUhMML7n+ph/0Vlz2XweuYpJ8l9dw/RCzXRCYw8z0QeEm+PUQ3tHDXzetV
 2Oc1UfEobRRd5aKvBwLsqH9CmR4vmafxARNTsICWo87YLtuPlmfwSdr+Kt0Nclo631ep
 3rQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=15XBOc0K5qrNi75fMYOmlumdevbJac2m4Bpn4CypPlo=;
 b=DhpZ6Oc+jV8Beozl1f1KkaE0prVxop9xOrbWjgVsSVL2+2gEkTN0M5cDr4YYsRbbOm
 iVLuFHhmk7hRrayYg5GEGTay+DoLTLa+Cdwbpo+lckGMAs7FUZnUr/MgcD8Vuumjo0wy
 6yhqr0cXl0oLt2VbQ5Lug/cRPmhiQr4SxluAUI3pu4AWatgEsHykr0lZJjpKN4ent8YR
 XRRfw//1wwrRoLsRXklfoeE7XydnkCWN2buJ7nuLeR4yftTqlV35RcHQjPkdl7jkp2Vs
 j2N0+pg0CiOmmg1qHnhxaEQNxJv5DJlIHU+sxttmqbyr2BMIZ6PYaajnVUIOcvC5bZo+
 HlFQ==
X-Gm-Message-State: APjAAAUhR5HJK+pgCsrI20+KTrv3vXn8uTQqYIpCSRN5tiV1j2P7slyq
 1R/mdqxgHHaIlHm0DES/3w1ADg==
X-Google-Smtp-Source: APXvYqxZbNEIsRPZ1Fo1qfCDus3WEQz9uzH0bOJRagMefAx0i1q7fCZ139Vsv7RS8TZyviRAo31SSQ==
X-Received: by 2002:a05:6000:1203:: with SMTP id
 e3mr4909090wrx.300.1563878173575; 
 Tue, 23 Jul 2019 03:36:13 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id j6sm62376070wrx.46.2019.07.23.03.36.12
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 23 Jul 2019 03:36:12 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7153E1FF8C;
 Tue, 23 Jul 2019 11:36:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 23 Jul 2019 11:35:50 +0100
Message-Id: <20190723103612.5600-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190723103612.5600-1-alex.bennee@linaro.org>
References: <20190723103612.5600-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
Subject: [Qemu-devel] [PULL 01/23] archive-source: also create a stash for
 submodules
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

"git archive" fails when a submodule has a modification, because "git
stash create" doesn't handle submodules. Let's teach our
archive-source.sh to handle modifications in submodules the same way
as qemu tree, by creating a stash.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20190708200250.12017-1-marcandre.lureau@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index ca94e49978f..fb5d6b3918d 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -39,14 +39,16 @@ function cleanup() {
 }
 trap "cleanup" 0 1 2 3 15
 
-if git diff-index --quiet HEAD -- &>/dev/null
-then
-    HEAD=HEAD
-else
-    HEAD=$(git stash create)
-fi
+function tree_ish() {
+    local retval='HEAD'
+    if ! git diff-index --quiet --ignore-submodules=all HEAD -- &>/dev/null
+    then
+        retval=$(git stash create)
+    fi
+    echo "$retval"
+}
 
-git archive --format tar $HEAD > "$tar_file"
+git archive --format tar "$(tree_ish)" > "$tar_file"
 test $? -ne 0 && error "failed to archive qemu"
 for sm in $submodules; do
     status="$(git submodule status "$sm")"
@@ -62,7 +64,7 @@ for sm in $submodules; do
             echo "WARNING: submodule $sm is out of sync"
             ;;
     esac
-    (cd $sm; git archive --format tar --prefix "$sm/" $smhash) > "$sub_file"
+    (cd $sm; git archive --format tar --prefix "$sm/" $(tree_ish)) > "$sub_file"
     test $? -ne 0 && error "failed to archive submodule $sm ($smhash)"
     tar --concatenate --file "$tar_file" "$sub_file"
     test $? -ne 0 && error "failed append submodule $sm to $tar_file"
-- 
2.20.1



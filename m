Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5630EC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:12:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D74A0214DB
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K97TCsFY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D74A0214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSIE6-0007mt-SE
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 07:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kSHyb-0005ck-73
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:56:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39449)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kSHyY-0006GS-G3
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602586572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7cYChnxM8InZVOk7HuBjz+k9VUPsE2H7sLOGxaO9IQc=;
 b=K97TCsFYRmjD5JuN2LIMdB6rf9CkB909Ybp5VWuna9mjfrtC3VpkiHfAT7p/6QC/UsLNqG
 RSMdahtSNJ1R5Zlwue1EiFduigVAtpdysGNS3QAWw/qkpBnFmM5Z4yHYOBlpZwWbxG4GUN
 AOALH/sQ+MyeIOpp/8wqWhvbKjeHTbk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-q7YGiUdnMHG-m7EdxASUZw-1; Tue, 13 Oct 2020 06:56:09 -0400
X-MC-Unique: q7YGiUdnMHG-m7EdxASUZw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67E9D86ABCE;
 Tue, 13 Oct 2020 10:56:08 +0000 (UTC)
Received: from thuth.com (ovpn-112-151.ams2.redhat.com [10.36.112.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B1DED6EF59;
 Tue, 13 Oct 2020 10:56:06 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 15/23] gitlab: add a CI job to validate the DCO sign off
Date: Tue, 13 Oct 2020 12:55:19 +0200
Message-Id: <20201013105527.20088-16-thuth@redhat.com>
In-Reply-To: <20201013105527.20088-1-thuth@redhat.com>
References: <20201013105527.20088-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 03:04:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel P. Berrangé <berrange@redhat.com>

While checkpatch.pl can validate DCO sign off that job must always be
advisory only since it is expected that certain patches will fail some
code style rules.

We require the DCO sign off to be mandatory for all commits though, so
it benefits from being validated in a standalone job.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20200918132903.1848939-3-berrange@redhat.com>
[thuth: Use "stage: build" to let it run earlier]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.d/check-dco.py | 94 +++++++++++++++++++++++++++++++++++++++
 .gitlab-ci.yml            | 10 +++++
 2 files changed, 104 insertions(+)
 create mode 100755 .gitlab-ci.d/check-dco.py

diff --git a/.gitlab-ci.d/check-dco.py b/.gitlab-ci.d/check-dco.py
new file mode 100755
index 0000000000..632c8bcce8
--- /dev/null
+++ b/.gitlab-ci.d/check-dco.py
@@ -0,0 +1,94 @@
+#!/usr/bin/env python3
+#
+# check-dco.py: validate all commits are signed off
+#
+# Copyright (C) 2020 Red Hat, Inc.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+import os.path
+import sys
+import subprocess
+
+namespace = "qemu-project"
+if len(sys.argv) >= 2:
+    namespace = sys.argv[1]
+
+cwd = os.getcwd()
+reponame = os.path.basename(cwd)
+repourl = "https://gitlab.com/%s/%s.git" % (namespace, reponame)
+
+subprocess.check_call(["git", "remote", "add", "check-dco", repourl])
+subprocess.check_call(["git", "fetch", "check-dco", "master"],
+                      stdout=subprocess.DEVNULL,
+                      stderr=subprocess.DEVNULL)
+
+ancestor = subprocess.check_output(["git", "merge-base",
+                                    "check-dco/master", "HEAD"],
+                                   universal_newlines=True)
+
+ancestor = ancestor.strip()
+
+subprocess.check_call(["git", "remote", "rm", "check-dco"])
+
+errors = False
+
+print("\nChecking for 'Signed-off-by: NAME <EMAIL>' " +
+      "on all commits since %s...\n" % ancestor)
+
+log = subprocess.check_output(["git", "log", "--format=%H %s",
+                               ancestor + "..."],
+                              universal_newlines=True)
+
+if log == "":
+    commits = []
+else:
+    commits = [[c[0:40], c[41:]] for c in log.strip().split("\n")]
+
+for sha, subject in commits:
+
+    msg = subprocess.check_output(["git", "show", "-s", sha],
+                                  universal_newlines=True)
+    lines = msg.strip().split("\n")
+
+    print("🔍 %s %s" % (sha, subject))
+    sob = False
+    for line in lines:
+        if "Signed-off-by:" in line:
+            sob = True
+            if "localhost" in line:
+                print("    ❌ FAIL: bad email in %s" % line)
+                errors = True
+
+    if not sob:
+        print("    ❌ FAIL missing Signed-off-by tag")
+        errors = True
+
+if errors:
+    print("""
+
+❌ ERROR: One or more commits are missing a valid Signed-off-By tag.
+
+
+This project requires all contributors to assert that their contributions
+are provided in compliance with the terms of the Developer's Certificate
+of Origin 1.1 (DCO):
+
+  https://developercertificate.org/
+
+To indicate acceptance of the DCO every commit must have a tag
+
+  Signed-off-by: REAL NAME <EMAIL>
+
+This can be achieved by passing the "-s" flag to the "git commit" command.
+
+To bulk update all commits on current branch "git rebase" can be used:
+
+  git rebase -i master -x 'git commit --amend --no-edit -s'
+
+""")
+
+    sys.exit(1)
+
+sys.exit(0)
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index f1e18d3e90..40805740a6 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -411,3 +411,13 @@ check-patch:
   variables:
     GIT_DEPTH: 1000
   allow_failure: true
+
+check-dco:
+  stage: build
+  image: $CI_REGISTRY_IMAGE/qemu/centos8:latest
+  script: .gitlab-ci.d/check-dco.py
+  except:
+    variables:
+      - $CI_PROJECT_NAMESPACE == 'qemu-project' && $CI_COMMIT_BRANCH == 'master'
+  variables:
+    GIT_DEPTH: 1000
-- 
2.18.2



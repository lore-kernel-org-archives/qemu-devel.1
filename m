Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0A8C43462
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 07:43:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A8C22074F
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 07:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXa+V5OJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A8C22074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jysMo-0001eO-ID
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 03:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jysM8-0001EA-S9
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 03:43:00 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:53102)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jysM7-0000Ds-56
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 03:43:00 -0400
Received: by mail-wm1-x32f.google.com with SMTP id x5so6522272wmi.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 00:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dhSPav+vFSqrYg8SXKOokDsi9Ah4tS5B+myMu3lQzko=;
 b=RXa+V5OJaf6cCQmSsQTK2qg8m0wTsSl4bZ04y4ZN3XM0hob8mJI+WkmOuU7qD0OLV0
 x8i34zDWUojznGxY/0Rh6Jmu8ac5MK/mrvM+5PxB/3BS1d2Gxzx2LmFzk9W17evq8eUA
 7wfZSvPUJ6lXWq2u2Lkv7Z/jFqlQBbDiVUwyYqC2zEGeJUnkj42UKA4qCG3LWs0MdN5r
 Dyr69wBQnIxKaddt5h8QZ5ii1wxpTY9RLglQOx74xTzJ+EmnUsSSJHYV0GdfNd6KfaNe
 2aeJMzfM11ZWaFKNch+WCBJloe5bkkELKssQ7Z0z18zK/AdttJ6NLl8t3nVtaiKrLp+D
 Lgng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=dhSPav+vFSqrYg8SXKOokDsi9Ah4tS5B+myMu3lQzko=;
 b=bO2ko5mi02+h9Qum0pMYge/1QtxOsW3Hjh7WQSLbnjECHv+UbbMlEOOLEfrdHbEyaz
 Fushj82lISoRBPaFC6qH17IKwLuU27kgoSGx3oCFaf34e0kM69/+IrmdwrNqfX/l0D0T
 CxqrBHB6j9Xnakf5LyQSzL2sQOIcnTOD3qGreEQdIZZ5Yb+MXh4++o1geS/YHucWhtQ9
 st3fb/BZKTovCev6QWUXOSGQ4H/KC20/xgjjQXGQuyYhvybPs6Uir6B5Abx2u7YAxe5Z
 maCNGFiPUXUFJT6ZzLvLH0iukgAPPfpWidNS8DAhAv9fI83PPaTKIbNXX6bY2AEhW7/B
 ikaQ==
X-Gm-Message-State: AOAM530jV7FqyccmuHxwxiYi2xzaCklqiNlhoc7YHAhYklnaynW7IPcn
 axng2gf7/aeTSMEjEvIa1UGhxhNssMA=
X-Google-Smtp-Source: ABdhPJyxFTkoBl8DwMvk5wqELUbWJnrGYLVaeEuXyhe4//OXvYVFjDMofORyYW/g2WD6omGvMk0eZA==
X-Received: by 2002:a1c:de41:: with SMTP id v62mr8029260wmg.163.1595576573678; 
 Fri, 24 Jul 2020 00:42:53 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id i14sm455033wrc.19.2020.07.24.00.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2020 00:42:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] gitlab-ci: Fix Avocado cache usage
Date: Fri, 24 Jul 2020 09:42:51 +0200
Message-Id: <20200724074251.28782-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <willianr@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In commit 6957fd98dc ("gitlab: add avocado asset caching") we
tried to save the Avocado cache (as in commit c1073e44b4 with
Travis-CI) however it doesn't work as expected. For some reason
Avocado uses /root/avocado_cache/ which we can not select later.

Manually generate a Avocado config to force the use of the
current directory.

We add a new 'build-acceptance-cache' job that runs first,
(during the 'build' stage) to create/update the cache.

The cache content is then pulled (but not updated) during the
'test' stage.

See:
- https://docs.gitlab.com/ee/ci/caching/
- https://avocado-framework.readthedocs.io/en/latest/guides/writer/chapters/writing.html#fetching-asset-files

Reported-by: Thomas Huth <thuth@redhat.com>
Fixes: 6957fd98dc ("gitlab: add avocado asset caching")
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Since v1:
- add a specific 'build-acceptance-cache' job

Thomas prefers to use a different cache for each job.
Since I had this patch ready, I prefer to post it as
v2 and will work on a v3 using Thomas suggestion.

Supersedes: <20200723200318.28214-1-f4bug@amsat.org>
Based-on: <20200724073524.26589-1-f4bug@amsat.org>
          "tests: Add 'fetch-acceptance' rule"
---
 .gitlab-ci.yml | 61 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 52 insertions(+), 9 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 362e5ee755..a8d8a7e849 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -8,11 +8,9 @@ stages:
   - build
   - test
 
-# We assume GitLab has it's own caching set up for RPM/APT repositories so we
-# just take care of avocado assets here.
-cache:
-  paths:
-    - $HOME/avocado/data/cache
+# We assume GitLab has it's own caching set up for RPM/APT repositories
+cache: &global_cache
+  policy: pull
 
 include:
   - local: '/.gitlab-ci.d/edk2.yml'
@@ -47,11 +45,52 @@ include:
     - find . -type f -exec touch {} +
     - make $MAKE_CHECK_ARGS
 
-.post_acceptance_template: &post_acceptance
+.acceptance_template: &acceptance_definition
+  cache:
+    # inherit all global cache settings
+    <<: *global_cache
+    key: acceptance_cache
+    paths:
+      - $CI_PROJECT_DIR/avocado_cache
+    policy: pull
+  before_script:
+    - JOBS=$(expr $(nproc) + 1)
+    - mkdir -p ~/.config/avocado
+    - echo "[datadir.paths]" > ~/.config/avocado/avocado.conf
+    - echo "cache_dirs = ['${CI_PROJECT_DIR}/avocado_cache']" >> ~/.config/avocado/avocado.conf
   after_script:
     - cd build
     - python3 -c 'import json; r = json.load(open("tests/results/latest/results.json")); [print(t["logfile"]) for t in r["tests"] if t["status"] not in ("PASS", "SKIP")]' | xargs cat
-    - du -chs $HOME/avocado/data/cache
+    - du -chs $CI_PROJECT_DIR/avocado_cache
+
+build-acceptance-cache:
+  stage: build
+  cache:
+    # inherit all global cache settings
+    <<: *global_cache
+    key: acceptance_cache
+    paths:
+      - $CI_PROJECT_DIR/avocado_cache
+    policy: pull-push
+  variables:
+    # any image should work
+    IMAGE: ubuntu2004
+    CONFIGURE_ARGS: --disable-user --disable-system
+      --disable-docs --disable-tools
+    MAKE_CHECK_ARGS: fetch-acceptance
+  image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:latest
+  before_script:
+    - mkdir -p ~/.config/avocado
+    - echo "[datadir.paths]" > ~/.config/avocado/avocado.conf
+    - echo "cache_dirs = ['${CI_PROJECT_DIR}/avocado_cache']" >> ~/.config/avocado/avocado.conf
+  script:
+    - mkdir build
+    - cd build
+    - ../configure --disable-user --disable-system --disable-docs --disable-tools
+    # ignore "asset fetched or already on cache" error
+    - make fetch-acceptance || true
+  after_script:
+    - du -chs $CI_PROJECT_DIR/avocado_cache
 
 build-system-ubuntu-main:
   <<: *native_build_job_definition
@@ -76,13 +115,15 @@ check-system-ubuntu-main:
 
 acceptance-system-ubuntu-main:
   <<: *native_test_job_definition
+  <<: *acceptance_definition
   needs:
     - job: build-system-ubuntu-main
       artifacts: true
+    - job: build-acceptance-cache
+      artifacts: false
   variables:
     IMAGE: ubuntu2004
     MAKE_CHECK_ARGS: check-acceptance
-  <<: *post_acceptance
 
 build-system-fedora-alt:
   <<: *native_build_job_definition
@@ -107,13 +148,15 @@ check-system-fedora-alt:
 
 acceptance-system-fedora-alt:
   <<: *native_test_job_definition
+  <<: *acceptance_definition
   needs:
     - job: build-system-fedora-alt
       artifacts: true
+    - job: build-acceptance-cache
+      artifacts: false
   variables:
     IMAGE: fedora
     MAKE_CHECK_ARGS: check-acceptance
-  <<: *post_acceptance
 
 build-disabled:
   <<: *native_build_job_definition
-- 
2.21.3



Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81591C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:24:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BA3A20702
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uSm9Utno"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA3A20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jshxe-0000tD-6c
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 03:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshoC-0006T8-0B
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:14:28 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:53758)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jsho9-0004qA-R6
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:14:27 -0400
Received: by mail-wm1-x335.google.com with SMTP id j18so42125764wmi.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 00:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tcFFr6wqntF8eZqbijSLJ4lRc28E2R4EjbxYXolVTZw=;
 b=uSm9UtnoQG3JZKw3s+8KHJyinyr40UTTxVMWcJgNWCt4y7E3xg10qHv15Xnxxma1d/
 I9fqjaEV3bi/fduP/1yRi/xSnlFuCTtvk256uZbQkMjytV8zA40Hg/00o+KESJ9jv9yX
 oDiWho4r7zEM8JARh9+RJaujHAd9h41WBF+ie78WYbkh2JJYMdlJ1rRnZhRhEb5zwnaE
 MdbVLjWgSmNrp+/vJxTOyDnICAn+gamdbXpq/Ri0EwoosEXzu5Hs2vvTyEhOrw/mSien
 JliEeCGDhrd4pHp3TY3au05NwhjMDcQXJnm0PwaNS/rJnRGgQRRc50MRvitbeF5qn6bE
 Ig2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tcFFr6wqntF8eZqbijSLJ4lRc28E2R4EjbxYXolVTZw=;
 b=lt2yV5H76YnM8QCiQ28klGh8k6ZPCvN6oXBbqO8YdV0ALOzmHUHSpByN0ctYx3Pqg4
 dLZR39YKTvPXHC44aJwwAni/eEqcfxlY6dniNQKN+zuahi4CCbyv2bySkd5TDc13CDzl
 JTWxw91xaK0Xh5+Z+eMLshG0US65mjFhZRDOB7Iul1seJ58I0NuESThdBONqOHTFcXGc
 lwt/QkVOV/XHd3IRBAMIjQrQA7GqoBRyeDLmjscAEoen9wM9X5usSDMXCwY/xXaKXQ3s
 nlnMoooguMQbJqp1LiQhOx3nqV/ancZcY6vJJWhAaLdRCQZzdNZywJ/KTBZu1/+ictLa
 mPFA==
X-Gm-Message-State: AOAM531F7rN0syzXZo817YNQbfVO+mGc835YzrvdcHJOvWTOWYWecsMz
 AAHRfGr1esVZ+yyrFi5IHZ8kRQ==
X-Google-Smtp-Source: ABdhPJxiWYoW0oP2MbPhkL0GKj4vogJ1jjjGsbQ7G04VdcJEp6sWJmd3EDrte1obxll/GP35DLkVLg==
X-Received: by 2002:a7b:c92e:: with SMTP id h14mr2570639wml.36.1594106064198; 
 Tue, 07 Jul 2020 00:14:24 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z6sm2174406wmf.33.2020.07.07.00.14.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 00:14:22 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 58D621FFB4;
 Tue,  7 Jul 2020 08:09:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 28/41] gitlab: add acceptance testing to system builds
Date: Tue,  7 Jul 2020 08:08:45 +0100
Message-Id: <20200707070858.6622-29-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200707070858.6622-1-alex.bennee@linaro.org>
References: <20200707070858.6622-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As part of migrating things from Travis to GitLab add the acceptance
tests. To do this:

  - rename system1 to system-ubuntu-main
  - rename system2 to system-fedora-misc
  - split into build/check/acceptance
  - remove -j from check stages
  - use artifacts to save build stage
  - add post acceptance template and use

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200701135652.1366-31-alex.bennee@linaro.org>

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index a7abc55a5c6a..93baf98232d7 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,8 +1,12 @@
+# Currently we have two build stages after our containers are built:
+#  - build (for traditional build and test or first stage build)
+#  - test (for test stages, using build artefacts from a build stage)
 stages:
   - containers
   - containers-layer2
   - containers-layer3
   - build
+  - test
 
 include:
   - local: '/.gitlab-ci.d/edk2.yml'
@@ -24,26 +28,85 @@ include:
         ../configure --enable-werror $CONFIGURE_ARGS ;
       fi
     - make -j"$JOBS"
-    - make -j"$JOBS" $MAKE_CHECK_ARGS
+    - if test -n "$MAKE_CHECK_ARGS";
+      then
+        make $MAKE_CHECK_ARGS ;
+      fi
+
+.native_test_job_template: &native_test_job_definition
+  stage: test
+  image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:latest
+  script:
+    - cd build
+    - find . -type f -exec touch {} +
+    - make $MAKE_CHECK_ARGS
+
+.post_acceptance_template: &post_acceptance
+  after_script:
+    - cd build
+    - python3 -c 'import json; r = json.load(open("tests/results/latest/results.json")); [print(t["logfile"]) for t in r["tests"] if t["status"] not in ("PASS", "SKIP")]' | xargs cat
+    - du -chs $HOME/avocado/data/cache
 
-build-system1:
+build-system-ubuntu-main:
   <<: *native_build_job_definition
   variables:
     IMAGE: ubuntu2004
     TARGETS: aarch64-softmmu alpha-softmmu cris-softmmu hppa-softmmu lm32-softmmu
       moxie-softmmu microblazeel-softmmu mips64el-softmmu m68k-softmmu ppc-softmmu
       riscv64-softmmu sparc-softmmu
+  artifacts:
+    paths:
+      - build
+
+check-system-ubuntu-main:
+  <<: *native_test_job_definition
+  needs:
+    - job: build-system-ubuntu-main
+      artifacts: true
+  variables:
+    IMAGE: ubuntu2004
     MAKE_CHECK_ARGS: check
 
-build-system2:
+acceptance-system-ubuntu-main:
+  <<: *native_test_job_definition
+  needs:
+    - job: build-system-ubuntu-main
+      artifacts: true
+  variables:
+    IMAGE: ubuntu2004
+    MAKE_CHECK_ARGS: check-acceptance
+  <<: *post_acceptance
+
+build-system-fedora-alt:
   <<: *native_build_job_definition
   variables:
     IMAGE: fedora
     TARGETS: tricore-softmmu unicore32-softmmu microblaze-softmmu mips-softmmu
       riscv32-softmmu s390x-softmmu sh4-softmmu sparc64-softmmu x86_64-softmmu
       xtensa-softmmu nios2-softmmu or1k-softmmu
+  artifacts:
+    paths:
+      - build
+
+check-system-fedora-alt:
+  <<: *native_test_job_definition
+  needs:
+    - job: build-system-fedora-alt
+      artifacts: true
+  variables:
+    IMAGE: fedora
     MAKE_CHECK_ARGS: check
 
+acceptance-system-fedora-alt:
+  <<: *native_test_job_definition
+  needs:
+    - job: build-system-fedora-alt
+      artifacts: true
+  variables:
+    IMAGE: fedora
+    MAKE_CHECK_ARGS: check-acceptance
+  <<: *post_acceptance
+
 build-disabled:
   <<: *native_build_job_definition
   variables:
diff --git a/.travis.yml b/.travis.yml
index 74158f741b18..c24dfbe377f3 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -289,29 +289,6 @@ jobs:
       python: 3.6
 
 
-    # Acceptance (Functional) tests
-    - name: "GCC check-acceptance"
-      dist: bionic
-      env:
-        - CONFIG="--enable-tools --target-list=aarch64-softmmu,alpha-softmmu,arm-softmmu,m68k-softmmu,microblaze-softmmu,mips-softmmu,mips64el-softmmu,nios2-softmmu,or1k-softmmu,ppc-softmmu,ppc64-softmmu,s390x-softmmu,sh4-softmmu,sparc-softmmu,x86_64-softmmu,xtensa-softmmu"
-        - TEST_CMD="make check-acceptance"
-        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-acceptance"
-      after_script:
-        - python3 -c 'import json; r = json.load(open("tests/results/latest/results.json")); [print(t["logfile"]) for t in r["tests"] if t["status"] not in ("PASS", "SKIP")]' | xargs cat
-        - du -chs $HOME/avocado/data/cache
-      addons:
-        apt:
-          packages:
-            - python3-pil
-            - python3-pip
-            - python3-numpy
-            - python3-opencv
-            - python3-venv
-            - rpm2cpio
-            - tesseract-ocr
-            - tesseract-ocr-eng
-
-
     # Using newer GCC with sanitizers
     - name: "GCC9 with sanitizers (softmmu)"
       addons:
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3f4448a20bc7..c316e0d66475 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -944,7 +944,7 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR) get-vm-images
             --show=$(AVOCADO_SHOW) run --job-results-dir=$(TESTS_RESULTS_DIR) \
             --filter-by-tags-include-empty --filter-by-tags-include-empty-key \
             $(AVOCADO_TAGS) \
-            --failfast=on tests/acceptance, \
+            $(if $(GITLAB_CI),,--failfast=on) tests/acceptance, \
             "AVOCADO", "tests/acceptance")
 
 # Consolidated targets
diff --git a/tests/acceptance/replay_kernel.py b/tests/acceptance/replay_kernel.py
index 60621417ddf0..62d2db8c64be 100644
--- a/tests/acceptance/replay_kernel.py
+++ b/tests/acceptance/replay_kernel.py
@@ -73,7 +73,7 @@ class ReplayKernel(LinuxKernelTest):
         logger = logging.getLogger('replay')
         logger.info('replay overhead {:.2%}'.format(t2 / t1 - 1))
 
-    @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI')
+    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
     def test_x86_64_pc(self):
         """
         :avocado: tags=arch:x86_64
-- 
2.20.1



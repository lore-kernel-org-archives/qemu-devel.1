Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CA8C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 20:04:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F6A520714
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 20:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQu5hcty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F6A520714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyhRm-0006cc-LA
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 16:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jyhR7-0006Ax-9Q
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 16:03:25 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:52763)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jyhR5-0005nC-IE
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 16:03:25 -0400
Received: by mail-wm1-x330.google.com with SMTP id x5so5482035wmi.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 13:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QO7K7IrFrQDTvXvSZohqTPo3EHI1ncRlckSPQNbY9Sk=;
 b=LQu5hctyQIMaQXjMM40aAxlCC66pBd5RErFg4numl1soAw7P0UCJFGHq9umXxJEzin
 SeKh8ZYSNEEYawCuhNgXBHXG88fNk9POc/QQjl9JFRHeQkVW+WwQ/hJv7Rh5JSVEiITT
 LXkB1sLTOsmii8JWZ687gQXTrdhnAt5Ht2zojo6JybS2qMK53ugAFi95Ka13aNcTcuHe
 dQTRki4yLmzK75l7AgqirMWJSggScLt+EV0fsKlGtmviFXENSewDTCrgKni+uHATDh5m
 gojXFHYMVmx0XCvKBEJbJFfzsFhW2wrBrYEN0XXikfceeXqsPtDsYr+Zez4p3fQdFkan
 0EAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=QO7K7IrFrQDTvXvSZohqTPo3EHI1ncRlckSPQNbY9Sk=;
 b=aivaIR5M1SVXy2mAelShzlLoJQCAIeJXEHal9hfHjoQUGZ97+dgXnOCmsNCf+t9iHh
 nLFjJ6EFppcwYzU70xPt8xYtBnUwL53P0V6/UYmH9CuQs/MfVvNE8qE1/umAO0IO0WxC
 ukOR5Jc+4GQV13a/px4tyuz0IpkJpLI5y2/i0hC/KQ68f3ml7If6zzjlluLi5/3BLRMX
 W5lHYJOsED+XFzNC+hN+Wb6HKY2Mj1wqm7f6WbrbK0NQ9qZXbfJgyPAUL9PoHePnUnlC
 vik0ZhiEnJDt34YNAx3YvQEIBKdshwbgAaY+9fxjgSKhu/SrUsq2+yhpnlnPp01wg4Sb
 Bo4A==
X-Gm-Message-State: AOAM533kh/0wE44B2mJ1E60m2MdFgKVG7EyggvbQXavEbYmCA0FlfSiT
 QaA60kaqAWhCWQLddEterOKuGIPvUZQ=
X-Google-Smtp-Source: ABdhPJxQbQouYJ1y/JDsRMxM3NrW01MfSOxC4GAq83MipCR/68nl7p0fvf1nK8NH46ZEl4gyg7s7dA==
X-Received: by 2002:a05:600c:204d:: with SMTP id
 p13mr5445838wmg.88.1595534600755; 
 Thu, 23 Jul 2020 13:03:20 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id k62sm3378293wmb.16.2020.07.23.13.03.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 13:03:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1] gitlab-ci: Fix Avocado cache
Date: Thu, 23 Jul 2020 22:03:18 +0200
Message-Id: <20200723200318.28214-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x330.google.com
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

See:
- https://docs.gitlab.com/ee/ci/caching/
- https://avocado-framework.readthedocs.io/en/latest/guides/writer/chapters/writing.html#fetching-asset-files

Reported-by: Thomas Huth <thuth@redhat.com>
Fixes: 6957fd98dc ("gitlab: add avocado asset caching")
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .gitlab-ci.yml | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 362e5ee755..b19db22fbd 100644
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
+  policy: pull-push
 
 include:
   - local: '/.gitlab-ci.d/edk2.yml'
@@ -47,11 +45,23 @@ include:
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
+    policy: pull-push
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
 
 build-system-ubuntu-main:
   <<: *native_build_job_definition
@@ -76,13 +86,13 @@ check-system-ubuntu-main:
 
 acceptance-system-ubuntu-main:
   <<: *native_test_job_definition
+  <<: *acceptance_definition
   needs:
     - job: build-system-ubuntu-main
       artifacts: true
   variables:
     IMAGE: ubuntu2004
     MAKE_CHECK_ARGS: check-acceptance
-  <<: *post_acceptance
 
 build-system-fedora-alt:
   <<: *native_build_job_definition
@@ -107,13 +117,13 @@ check-system-fedora-alt:
 
 acceptance-system-fedora-alt:
   <<: *native_test_job_definition
+  <<: *acceptance_definition
   needs:
     - job: build-system-fedora-alt
       artifacts: true
   variables:
     IMAGE: fedora
     MAKE_CHECK_ARGS: check-acceptance
-  <<: *post_acceptance
 
 build-disabled:
   <<: *native_build_job_definition
-- 
2.21.3



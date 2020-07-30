Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE7EC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 14:15:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A4432070B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 14:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UmZkZQ8f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A4432070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k19Kw-0003wU-Gh
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 10:15:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k19Je-0002H8-F1
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 10:13:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60670
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k19Jc-0004NP-EH
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 10:13:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596118427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=dSiehSpYL1jKiJ+fFZpVFsgMwK93BY7/XXMuUhaG6wQ=;
 b=UmZkZQ8ftDXJeaW/akMSbyVn53aWkurre+62DMnWMWTkGMSzGgK7Yl6A7fNjyQZU4Ykb5i
 TQ93IAM8CV8SY0wHUaN3oGMAkFa7JkY6vpgZ9UzwjdoZ/rXrYhlF5MspUC6ZPBP+akPZ1N
 XIH6LfXSMtor3PnC/zDxWW1T93Gnvko=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-qhwSoh94MoiYXPnxnEr44A-1; Thu, 30 Jul 2020 10:13:42 -0400
X-MC-Unique: qhwSoh94MoiYXPnxnEr44A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C439B1940927;
 Thu, 30 Jul 2020 14:13:41 +0000 (UTC)
Received: from thuth.com (ovpn-112-85.ams2.redhat.com [10.36.112.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B32A48A19E;
 Thu, 30 Jul 2020 14:13:39 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 3/4] gitlab-ci.yml: Add build-system-debian and
 build-system-centos jobs
Date: Thu, 30 Jul 2020 16:13:25 +0200
Message-Id: <20200730141326.8260-4-thuth@redhat.com>
In-Reply-To: <20200730141326.8260-1-thuth@redhat.com>
References: <20200730141326.8260-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 23:51:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We were missing the two new targets avr-softmmu and rx-softmmu in the
gitlab-CI so far, and did not add some of the "other endianess" targets
like sh4eb-softmmu yet.
Since the current build-system-* jobs run already for a very long time,
let's do not add these missing targets there, but introduce two new
additional build jobs, one running with Debian and one running with
CentOS, and add the new targets there. Also move some targets from
the old build-system-* jobs to these new targets, to distribute the
load and reduce the runtime of the CI.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.yml | 88 +++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 73 insertions(+), 15 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 362e5ee755..e96bcd50f8 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -53,68 +53,126 @@ include:
     - python3 -c 'import json; r = json.load(open("tests/results/latest/results.json")); [print(t["logfile"]) for t in r["tests"] if t["status"] not in ("PASS", "SKIP")]' | xargs cat
     - du -chs $HOME/avocado/data/cache
 
-build-system-ubuntu-main:
+build-system-ubuntu:
   <<: *native_build_job_definition
   variables:
     IMAGE: ubuntu2004
-    TARGETS: aarch64-softmmu alpha-softmmu cris-softmmu hppa-softmmu lm32-softmmu
-      moxie-softmmu microblazeel-softmmu mips64el-softmmu m68k-softmmu ppc-softmmu
-      riscv64-softmmu sparc-softmmu
+    TARGETS: aarch64-softmmu alpha-softmmu cris-softmmu hppa-softmmu
+      moxie-softmmu microblazeel-softmmu mips64el-softmmu
     MAKE_CHECK_ARGS: check-build
   artifacts:
     paths:
       - build
 
-check-system-ubuntu-main:
+check-system-ubuntu:
   <<: *native_test_job_definition
   needs:
-    - job: build-system-ubuntu-main
+    - job: build-system-ubuntu
       artifacts: true
   variables:
     IMAGE: ubuntu2004
     MAKE_CHECK_ARGS: check
 
-acceptance-system-ubuntu-main:
+acceptance-system-ubuntu:
   <<: *native_test_job_definition
   needs:
-    - job: build-system-ubuntu-main
+    - job: build-system-ubuntu
       artifacts: true
   variables:
     IMAGE: ubuntu2004
     MAKE_CHECK_ARGS: check-acceptance
   <<: *post_acceptance
 
-build-system-fedora-alt:
+build-system-debian:
+  <<: *native_build_job_definition
+  variables:
+    IMAGE: debian-amd64
+    TARGETS: arm-softmmu avr-softmmu i386-softmmu mipsel-softmmu
+      riscv64-softmmu sh4eb-softmmu sparc-softmmu xtensaeb-softmmu
+    MAKE_CHECK_ARGS: check-build
+  artifacts:
+    paths:
+      - build
+
+check-system-debian:
+  <<: *native_test_job_definition
+  needs:
+    - job: build-system-debian
+      artifacts: true
+  variables:
+    IMAGE: debian-amd64
+    MAKE_CHECK_ARGS: check
+
+acceptance-system-debian:
+  <<: *native_test_job_definition
+  needs:
+    - job: build-system-debian
+      artifacts: true
+  variables:
+    IMAGE: debian-amd64
+    MAKE_CHECK_ARGS: check-acceptance
+  <<: *post_acceptance
+
+build-system-fedora:
   <<: *native_build_job_definition
   variables:
     IMAGE: fedora
     TARGETS: tricore-softmmu unicore32-softmmu microblaze-softmmu mips-softmmu
-      riscv32-softmmu s390x-softmmu sh4-softmmu sparc64-softmmu x86_64-softmmu
-      xtensa-softmmu nios2-softmmu or1k-softmmu
+      xtensa-softmmu m68k-softmmu riscv32-softmmu ppc-softmmu sparc64-softmmu
     MAKE_CHECK_ARGS: check-build
   artifacts:
     paths:
       - build
 
-check-system-fedora-alt:
+check-system-fedora:
   <<: *native_test_job_definition
   needs:
-    - job: build-system-fedora-alt
+    - job: build-system-fedora
       artifacts: true
   variables:
     IMAGE: fedora
     MAKE_CHECK_ARGS: check
 
-acceptance-system-fedora-alt:
+acceptance-system-fedora:
   <<: *native_test_job_definition
   needs:
-    - job: build-system-fedora-alt
+    - job: build-system-fedora
       artifacts: true
   variables:
     IMAGE: fedora
     MAKE_CHECK_ARGS: check-acceptance
   <<: *post_acceptance
 
+build-system-centos:
+  <<: *native_build_job_definition
+  variables:
+    IMAGE: centos8
+    TARGETS: ppc64-softmmu lm32-softmmu or1k-softmmu s390x-softmmu
+      x86_64-softmmu rx-softmmu sh4-softmmu nios2-softmmu
+    MAKE_CHECK_ARGS: check-build
+  artifacts:
+    paths:
+      - build
+
+check-system-centos:
+  <<: *native_test_job_definition
+  needs:
+    - job: build-system-centos
+      artifacts: true
+  variables:
+    IMAGE: centos8
+    MAKE_CHECK_ARGS: check
+
+acceptance-system-centos:
+  <<: *native_test_job_definition
+  needs:
+    - job: build-system-centos
+      artifacts: true
+  variables:
+    IMAGE: centos8
+    MAKE_CHECK_ARGS: check-acceptance
+  <<: *post_acceptance
+
 build-disabled:
   <<: *native_build_job_definition
   variables:
-- 
2.18.1



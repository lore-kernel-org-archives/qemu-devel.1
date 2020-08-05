Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90273C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 09:59:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 557492076E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 09:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KC0ah6v7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 557492076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3GCz-0002uu-FD
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 05:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k3GBZ-0001EV-GG
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 05:58:13 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20306
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k3GBX-0008US-ET
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 05:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596621490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kJlLqWCivISRpkLDM96NoVcrFX5730UMZs7USJS6U4k=;
 b=KC0ah6v7q4rAyKAfeG6O1R86JH3eeGbAhut5ZpSzIOtbaZ6yOLONFLhD6LN3mr8k0MIYiZ
 v4pHEuTtUanOwI4OLSKhTb7U0uFn4PXSFxV546HAhMJAghV35IcHwJEjJrmHp6KQ1oEjQY
 YgZQVEo3p38EgVkuZBaCsdcZu5zSnaU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-mOTLqFLfO_6XkTNC8Yi7_w-1; Wed, 05 Aug 2020 05:58:07 -0400
X-MC-Unique: mOTLqFLfO_6XkTNC8Yi7_w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 511B179ECA;
 Wed,  5 Aug 2020 09:58:06 +0000 (UTC)
Received: from thuth.com (ovpn-112-142.ams2.redhat.com [10.36.112.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4C86C2E024;
 Wed,  5 Aug 2020 09:58:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 3/6] gitlab-ci.yml: Add build-system-debian and
 build-system-centos jobs
Date: Wed,  5 Aug 2020 11:57:52 +0200
Message-Id: <20200805095755.16414-4-thuth@redhat.com>
In-Reply-To: <20200805095755.16414-1-thuth@redhat.com>
References: <20200805095755.16414-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 04:10:11
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
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

Message-Id: <20200730141326.8260-4-thuth@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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



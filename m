Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA50C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:41:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 862A52339D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:41:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 862A52339D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5940-0008SD-Tf
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 09:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51527)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i58qI-0002Pe-QA
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:27:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i58qH-0000on-HS
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:27:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50879)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i58qH-0000oi-8F
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:27:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 92A99308FE8D;
 Tue,  3 Sep 2019 13:27:28 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-102.brq.redhat.com [10.40.204.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 607995C25B;
 Tue,  3 Sep 2019 13:27:26 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 15:26:48 +0200
Message-Id: <20190903132649.20226-10-philmd@redhat.com>
In-Reply-To: <20190903132649.20226-1-philmd@redhat.com>
References: <20190903132649.20226-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Tue, 03 Sep 2019 13:27:28 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 09/10] .travis.yml: Cache Linux/GCC 'non-debug
 profile' jobs together
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These jobs build different components but use the same
host features. Put them in the same cache bucket.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 .travis.yml | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index e362c3fe02..7132cf8fba 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -101,15 +101,18 @@ matrix:
   include:
     - env:
         - CONFIG=3D"--disable-system --static"
+        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
=20
=20
     # we split the system builds as it takes a while to build them all
     - env:
         - CONFIG=3D"--disable-user --target-list=3D${MAIN_SOFTMMU_TARGET=
S}"
+        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
=20
=20
     - env:
         - CONFIG=3D"--disable-user --target-list-exclude=3D${MAIN_SOFTMM=
U_TARGETS}"
+        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
=20
=20
     # Just build tools and run minimal unit and softfloat checks
@@ -117,6 +120,8 @@ matrix:
         - BASE_CONFIG=3D"--enable-tools"
         - CONFIG=3D"--disable-user --disable-system"
         - TEST_CMD=3D"make check-unit check-softfloat -j3"
+        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
+
=20
     - env:
         - CONFIG=3D"--enable-debug --enable-debug-tcg --disable-user"
@@ -136,6 +141,7 @@ matrix:
     # Module builds are mostly of interest to major distros
     - env:
         - CONFIG=3D"--enable-modules --target-list=3D${MAIN_SOFTMMU_TARG=
ETS}"
+        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
=20
=20
     # Alternate coroutines implementations are only really of interest t=
o KVM users
@@ -155,6 +161,7 @@ matrix:
         - BUILD_DIR=3D"out-of-tree/build/dir" SRC_DIR=3D"../../.."
         - BASE_CONFIG=3D"--enable-tools --enable-docs"
         - CONFIG=3D"--target-list=3Dx86_64-softmmu,aarch64-linux-user"
+        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
       addons:
         apt:
           packages:
@@ -196,6 +203,7 @@ matrix:
     # We manually include builds which we disable "make check" for
     - env:
         - CONFIG=3D"--without-default-devices --disable-user"
+        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
         - TEST_CMD=3D""
=20
=20
@@ -239,6 +247,7 @@ matrix:
     # Python builds
     - env:
         - CONFIG=3D"--target-list=3Dx86_64-softmmu"
+        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
       language: python
       python:
         - "3.4"
@@ -246,6 +255,7 @@ matrix:
=20
     - env:
         - CONFIG=3D"--target-list=3Dx86_64-softmmu"
+        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
       language: python
       python:
         - "3.6"
@@ -312,8 +322,11 @@ matrix:
     - env:
         - CONFIG=3D"--disable-system"
         - TEST_CMD=3D"make -j3 check-tcg V=3D1"
+        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
+
=20
     # Run check-tcg against softmmu targets
     - env:
         - CONFIG=3D"--target-list=3Dxtensa-softmmu,arm-softmmu,aarch64-s=
oftmmu,alpha-softmmu"
         - TEST_CMD=3D"make -j3 check-tcg V=3D1"
+        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
--=20
2.20.1



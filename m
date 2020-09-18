Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C08C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 10:36:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5625D21534
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 10:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a/YHi5X1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5625D21534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJDkN-0003bX-Dj
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 06:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kJDjC-00028t-2p
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 06:34:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26511)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kJDjA-0005D9-3X
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 06:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600425291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=owl/ukAiPzP/CsZ0hLxOSFod22bRLRctTSLkllPtypM=;
 b=a/YHi5X1cvoDxgF5SsOWlKOaoi+7ZDIeR+1LpkVfbuYLN58tjQlaNu9RK7SWtBW48penRs
 f+zVWKs5+EXHqT8OZX2oBh1h0ZKNOCOouSc6CFVkk+Pl8g80sklTD40tKf/zfZy/HPIZLK
 gpYChI+25XUx0GNcwK0Dr7Ee1WKGTYw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-nVM-IDgVN2i08frel4FHAg-1; Fri, 18 Sep 2020 06:34:49 -0400
X-MC-Unique: nVM-IDgVN2i08frel4FHAg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9D6C64142;
 Fri, 18 Sep 2020 10:34:48 +0000 (UTC)
Received: from thuth.com (ovpn-112-53.ams2.redhat.com [10.36.112.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9AD5760BEC;
 Fri, 18 Sep 2020 10:34:47 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 5/6] travis.yml: Update Travis to use Bionic and Focal instead
 of Xenial
Date: Fri, 18 Sep 2020 12:34:29 +0200
Message-Id: <20200918103430.297167-6-thuth@redhat.com>
In-Reply-To: <20200918103430.297167-1-thuth@redhat.com>
References: <20200918103430.297167-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

According to our support policy, we do not support Xenial anymore.
Time to switch the bigger parts of the builds to Focal instead.
Some few jobs have to be updated to Bionic instead, since they are
currently still failing on Focal otherwise. Also "--disable-pie" is
causing linker problems with newer versions of Ubuntu ... so remove
that switch from the jobs now (we still test it in a gitlab CI job,
so we don't lose much test coverage here).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .travis.yml | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 1fc49b0746..80da4ebc8e 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -2,7 +2,7 @@
 # Additional builds with specific requirements for a full VM need to
 # be added as additional matrix: entries later on
 os: linux
-dist: xenial
+dist: focal
 language: c
 compiler:
   - gcc
@@ -10,7 +10,7 @@ cache:
   # There is one cache per branch and compiler version.
   # characteristics of each job are used to identify the cache:
   # - OS name (currently only linux)
-  # - OS distribution (for Linux, xenial, trusty, or precise)
+  # - OS distribution (for Linux, bionic or focal)
   # - Names and values of visible environment variables set in .travis.yml or Settings panel
   timeout: 1200
   ccache: true
@@ -27,7 +27,7 @@ addons:
       - libattr1-dev
       - libbrlapi-dev
       - libcap-ng-dev
-      - libgcc-4.8-dev
+      - libgcc-7-dev
       - libgnutls28-dev
       - libgtk-3-dev
       - libiscsi-dev
@@ -211,8 +211,10 @@ jobs:
 
     # gprof/gcov are GCC features
     - name: "GCC gprof/gcov"
+      dist: bionic
       env:
-        - CONFIG="--enable-gprof --enable-gcov --disable-pie --target-list=${MAIN_SOFTMMU_TARGETS}"
+        - CONFIG="--enable-gprof --enable-gcov --disable-libssh
+                  --target-list=${MAIN_SOFTMMU_TARGETS}"
       after_success:
         - ${SRC_DIR}/scripts/travis/coverage-summary.sh
 
@@ -271,6 +273,7 @@ jobs:
 
     # Using newer GCC with sanitizers
     - name: "GCC9 with sanitizers (softmmu)"
+      dist: bionic
       addons:
         apt:
           update: true
@@ -286,7 +289,7 @@ jobs:
             - libattr1-dev
             - libbrlapi-dev
             - libcap-ng-dev
-            - libgnutls-dev
+            - libgnutls28-dev
             - libgtk-3-dev
             - libiscsi-dev
             - liblttng-ust-dev
@@ -294,14 +297,13 @@ jobs:
             - libncurses5-dev
             - libnss3-dev
             - libpixman-1-dev
-            - libpng12-dev
+            - libpng-dev
             - librados-dev
             - libsdl2-dev
             - libsdl2-image-dev
             - libseccomp-dev
             - libspice-protocol-dev
             - libspice-server-dev
-            - libssh-dev
             - liburcu-dev
             - libusb-1.0-0-dev
             - libvte-2.91-dev
@@ -311,11 +313,11 @@ jobs:
       compiler: none
       env:
         - COMPILER_NAME=gcc CXX=g++-9 CC=gcc-9
-        - CONFIG="--cc=gcc-9 --cxx=g++-9 --disable-pie --disable-linux-user"
+        - CONFIG="--cc=gcc-9 --cxx=g++-9 --disable-linux-user"
         - TEST_CMD=""
       before_script:
         - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
-        - ${SRC_DIR}/configure ${CONFIG} --extra-cflags="-g3 -O0 -Wno-error=stringop-truncation -fsanitize=thread" --extra-ldflags="-fuse-ld=gold" || { cat config.log && exit 1; }
+        - ${SRC_DIR}/configure ${CONFIG} --extra-cflags="-g3 -O0 -fsanitize=thread" || { cat config.log && exit 1; }
 
 
     # Run check-tcg against linux-user
@@ -357,7 +359,7 @@ jobs:
 
     - name: "[aarch64] GCC check-tcg"
       arch: arm64
-      dist: xenial
+      dist: focal
       addons:
         apt_packages:
           - libaio-dev
@@ -390,7 +392,7 @@ jobs:
 
     - name: "[ppc64] GCC check-tcg"
       arch: ppc64le
-      dist: xenial
+      dist: focal
       addons:
         apt_packages:
           - libaio-dev
-- 
2.18.2



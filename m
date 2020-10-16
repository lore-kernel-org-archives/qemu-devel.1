Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45917C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 12:06:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FD682083B
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 12:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aJfNnpHq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FD682083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTOUn-0006MX-Ft
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 08:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTODo-0000n4-Vq
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 07:48:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57300)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTODj-0002qD-Uf
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 07:48:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602848907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bygHJxPhLDUciaWD6smH3Pbj70hI4UPf0KTqnbMPlwE=;
 b=aJfNnpHqKu4OmzR4je15OlWh5zKxVcw21El1rYPAfchNPHyFajAG/Miml7tVxTdf+kmqaN
 0N4/NHOTBFCTys9GAkqP9VqCEKy895sF9r7uyrxrbRxhVulwltt96u+pcfbwGHfNC33IaM
 A014sJWBAwHCUWYsObrNCrm/tM4GbiE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-t6FpiutiNTuP05vYVrHfYA-1; Fri, 16 Oct 2020 07:48:25 -0400
X-MC-Unique: t6FpiutiNTuP05vYVrHfYA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BACB18A822B;
 Fri, 16 Oct 2020 11:48:24 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E791E76642;
 Fri, 16 Oct 2020 11:48:23 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 22/22] ci: include configure and meson logs in all jobs if
 configure fails
Date: Fri, 16 Oct 2020 07:48:14 -0400
Message-Id: <20201016114814.1564523-23-pbonzini@redhat.com>
In-Reply-To: <20201016114814.1564523-1-pbonzini@redhat.com>
References: <20201016114814.1564523-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 03:57:19
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .cirrus.yml    | 6 +++---
 .gitlab-ci.yml | 6 +++---
 .travis.yml    | 8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index e099da0fec..81a2960b1a 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -13,7 +13,7 @@ freebsd_12_task:
   script:
     - mkdir build
     - cd build
-    - ../configure --enable-werror || { cat config.log; exit 1; }
+    - ../configure --enable-werror || { cat config.log meson-logs/meson-log.txt; exit 1; }
     - gmake -j$(sysctl -n hw.ncpu)
     - gmake -j$(sysctl -n hw.ncpu) check V=1
 
@@ -27,7 +27,7 @@ macos_task:
     - cd build
     - ../configure --python=/usr/local/bin/python3 --enable-werror
                    --extra-cflags='-Wno-error=deprecated-declarations'
-                   || { cat config.log; exit 1; }
+                   || { cat config.log meson-logs/meson-log.txt; exit 1; }
     - gmake -j$(sysctl -n hw.ncpu)
     - gmake check V=1
 
@@ -41,7 +41,7 @@ macos_xcode_task:
     - mkdir build
     - cd build
     - ../configure --extra-cflags='-Wno-error=deprecated-declarations'
-                   --enable-werror --cc=clang || { cat config.log; exit 1; }
+                   --enable-werror --cc=clang || { cat config.log meson-logs/meson-log.txt; exit 1; }
     - gmake -j$(sysctl -n hw.ncpu)
     - gmake check V=1
 
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 8ffd415ca5..66ad7aa5c2 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -32,7 +32,7 @@ include:
         ../configure --enable-werror $CONFIGURE_ARGS --target-list="$TARGETS" ;
       else
         ../configure --enable-werror $CONFIGURE_ARGS ;
-      fi
+      fi || { cat config.log meson-logs/meson-log.txt && exit 1; }
     - make -j"$JOBS"
     - if test -n "$MAKE_CHECK_ARGS";
       then
@@ -229,7 +229,7 @@ build-tcg-disabled:
   script:
     - mkdir build
     - cd build
-    - ../configure --disable-tcg --audio-drv-list=""
+    - ../configure --disable-tcg --audio-drv-list="" || { cat config.log meson-logs/meson-log.txt && exit 1; }
     - make -j"$JOBS"
     - make check-unit
     - make check-qapi-schema
@@ -322,7 +322,7 @@ build-tci:
     - mkdir build
     - cd build
     - ../configure --enable-tcg-interpreter
-        --target-list="$(for tg in $TARGETS; do echo -n ${tg}'-softmmu '; done)"
+        --target-list="$(for tg in $TARGETS; do echo -n ${tg}'-softmmu '; done)" || { cat config.log meson-logs/meson-log.txt && exit 1; }
     - make -j"$JOBS"
     - make run-tcg-tests-x86_64-softmmu
     - make tests/qtest/boot-serial-test tests/qtest/cdrom-test tests/qtest/pxe-test
diff --git a/.travis.yml b/.travis.yml
index d7bfbb8bfe..a3d78171ca 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -95,7 +95,7 @@ before_install:
 # Configure step - may be overridden
 before_script:
   - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
-  - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config.log && exit 1; }
+  - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config.log meson-logs/meson-log.txt && exit 1; }
 
 # Main build & test - rarely overridden - controlled by TEST_CMD
 script:
@@ -199,7 +199,7 @@ jobs:
       compiler: clang
       before_script:
         - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
-        - ${SRC_DIR}/configure ${CONFIG} --extra-cflags="-fsanitize=undefined -Werror" || { cat config.log && exit 1; }
+        - ${SRC_DIR}/configure ${CONFIG} --extra-cflags="-fsanitize=undefined -Werror" || { cat config.log meson-logs/meson-log.txt && exit 1; }
 
 
     - name: "Clang (other-softmmu)"
@@ -298,7 +298,7 @@ jobs:
         - TEST_CMD=""
       before_script:
         - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
-        - ${SRC_DIR}/configure ${CONFIG} --extra-cflags="-g3 -O0 -fsanitize=thread" || { cat config.log && exit 1; }
+        - ${SRC_DIR}/configure ${CONFIG} --extra-cflags="-g3 -O0 -fsanitize=thread" || { cat config.log meson-logs/meson-log.txt && exit 1; }
 
 
     # Run check-tcg against linux-user
@@ -530,7 +530,7 @@ jobs:
         - ls -l ${SRC_DIR}/qemu-${QEMU_VERSION}.tar.bz2
         - tar -xf ${SRC_DIR}/qemu-${QEMU_VERSION}.tar.bz2 && cd qemu-${QEMU_VERSION}
         - mkdir -p release-build && cd release-build
-        - ../configure ${BASE_CONFIG} ${CONFIG} || { cat config.log && exit 1; }
+        - ../configure ${BASE_CONFIG} ${CONFIG} || { cat config.log meson-logs/meson-log.txt && exit 1; }
         - make install
   allow_failures:
     - env: UNRELIABLE=true
-- 
2.26.2



Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C47C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 17:44:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81400207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 17:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81400207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBMx7-0000R3-J0
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 13:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39568)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iBMvQ-0007ui-5W
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 13:42:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iBMvO-0000hP-EF
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 13:42:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48816)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iBMvO-0000hD-99
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 13:42:30 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4FC901DD1;
 Fri, 20 Sep 2019 17:42:29 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E6D4A19C68;
 Fri, 20 Sep 2019 17:42:22 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] .travis.yml: Test the release tarball
Date: Fri, 20 Sep 2019 19:42:19 +0200
Message-Id: <20190920174219.22005-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Fri, 20 Sep 2019 17:42:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
 Michael Tokarev <mjt@tls.msk.ru>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Bruce Rogers <brogers@suse.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a job to generate the release tarball and build/install few
QEMU targets from it.

Ideally we should build the 'efi' target from the 'roms' directory,
but it is too time consuming.

This job is only triggered when a tag starting with 'v' is pushed,
which is the case with release candidate tags.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
This job is quick enough: Ran for 15 min 32 sec
https://travis-ci.org/philmd/qemu/jobs/587583631

Based-on: <20190912231202.12327-1-mdroth@linux.vnet.ibm.com>
"Fix tarball builds of UEFI/EDK2 firmware"
https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg02734.html
---
 .travis.yml | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index d0b9e099b9..a21f99d22d 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -339,3 +339,25 @@ matrix:
         - CONFIG=3D"--target-list=3Dxtensa-softmmu,arm-softmmu,aarch64-s=
oftmmu,alpha-softmmu"
         - TEST_CMD=3D"make -j3 check-tcg V=3D1"
         - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
+
+
+    # Release builds
+    # The make-release script expect a QEMU version, so our tag must sta=
rt with a 'v'
+    - if: tag IS present AND tag =3D~ ^v
+      env:
+        # We want to build from the release tarball
+        - BUILD_DIR=3D"release/build/dir" SRC_DIR=3D"../../.."
+        - BASE_CONFIG=3D"--prefix=3D$PWD/dist"
+        - CONFIG=3D"--target-list=3Dx86_64-softmmu,aarch64-softmmu,armeb=
-linux-user,ppc-linux-user"
+        - TEST_CMD=3D"make install -j3"
+        - QEMU_VERSION=3D"${TRAVIS_TAG:1}"
+        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
+      before_script:
+        - command -v ccache && ccache --zero-stats
+        - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
+      script:
+        - ${SRC_DIR}/scripts/make-release ${SRC_DIR} ${QEMU_VERSION}
+        - ls -l qemu-${QEMU_VERSION}.tar.bz2
+        - tar -xf qemu-${QEMU_VERSION}.tar.bz2 && cd qemu-${QEMU_VERSION=
}
+        - ./configure ${BASE_CONFIG} ${CONFIG} || { cat config.log && ex=
it 1; }
+        - make install
--=20
2.20.1



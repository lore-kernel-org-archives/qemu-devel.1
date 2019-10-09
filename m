Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34ADC47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 20:16:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FEE5206BB
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 20:16:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FEE5206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIINf-0007Iy-4h
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 16:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59526)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iIFQo-0002OA-3j
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 13:07:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iIFQm-0004KV-T1
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 13:07:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54422)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iIFQm-0004Iw-NX
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 13:07:20 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DCFF1A44AC6;
 Wed,  9 Oct 2019 17:07:19 +0000 (UTC)
Received: from thuth.com (ovpn-116-38.ams2.redhat.com [10.36.116.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E0BA60167;
 Wed,  9 Oct 2019 17:07:18 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 5/5] travis.yml: Compile on arm64, too
Date: Wed,  9 Oct 2019 19:07:01 +0200
Message-Id: <20191009170701.14756-6-thuth@redhat.com>
In-Reply-To: <20191009170701.14756-1-thuth@redhat.com>
References: <20191009170701.14756-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Wed, 09 Oct 2019 17:07:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Travis now features an arm64 build host, so let's check compilation
there, too.

Unfortunately, there are some quirks:
- block/ssh.c does not compile properly in this environment, so we have
  to use --disable-libssh until that problem is fixed.
- test-util-filemonitor fails, so we can not run the unit tests there
- The file system size seems to be very limited, so the iotest tests
  can't be used and the hd-geo-test fails (thus we can't compile
  x86_64-softmmu here and run "check-qtest" afterwards)
- Compiling seems to be quite a bit slower than on the x86 builders,
  so we better limit the target list to some few architectures.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .travis.yml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 0c88e8757b..357ca02890 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -342,3 +342,9 @@ matrix:
         - CONFIG="--target-list=xtensa-softmmu,arm-softmmu,aarch64-softmmu,alpha-softmmu"
         - TEST_CMD="make -j3 check-tcg V=1"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
+
+    # Non-x86 builds:
+    - env:
+        - CONFIG="--disable-libssh --target-list=aarch64-softmmu,ppc64-softmmu,s390x-softmmu,x86_64-linux-user"
+        - TEST_CMD="make check-qtest check-softfloat -j3 V=1"
+      arch: arm64
-- 
2.18.1



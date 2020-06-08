Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDEAC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 11:42:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 891652074B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 11:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HWJ17nel"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 891652074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiGAe-0001sb-QU
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 07:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jiG9C-0000AK-Sv
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 07:40:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30264
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jiG9B-0003jy-7n
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 07:40:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591616455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=DyzvOCPihzQYQjCuD5MQ7+V/b+JSPZS8On1IUN+oCtQ=;
 b=HWJ17nelFff1cAjkgLt2QEhTp630OqgfNGd49z3ey0HwxSgRsfZeCKvHopmD1nKL2qmnt7
 LIY8OyTq9dntA2Avbr3DMEqZx8Hqk3qXfPZrkQqtSQi8Yzqu/Eewov7k3F+R69hensT3Zz
 MPB/QOdt5lNhJsMZevSY+irUbFkNMgQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-6dEjBNi_NEix6U6JezszMQ-1; Mon, 08 Jun 2020 07:40:54 -0400
X-MC-Unique: 6dEjBNi_NEix6U6JezszMQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32583801504;
 Mon,  8 Jun 2020 11:40:53 +0000 (UTC)
Received: from thuth.com (ovpn-112-119.ams2.redhat.com [10.36.112.119])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 88BE610013D4;
 Mon,  8 Jun 2020 11:40:51 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PATCH] travis.yml: Test also the other targets on s390x
Date: Mon,  8 Jun 2020 13:40:49 +0200
Message-Id: <20200608114049.4693-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 01:05:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

s390x is our only big endian host in our CI, so building and testing QEMU
there is quite valuable. Thus let's also test the other targets with
additional jobs (also using different sets of pre-installed libraries to
get a better coverage of the things that we test).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .travis.yml | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 564be50a3c..41e97fb050 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -504,6 +504,45 @@ jobs:
               $(exit $BUILD_RC);
           fi
 
+    - name: "[s390x] GCC (other-softmmu)"
+      arch: s390x
+      dist: bionic
+      addons:
+        apt_packages:
+          - libaio-dev
+          - libattr1-dev
+          - libcap-ng-dev
+          - libgnutls28-dev
+          - libiscsi-dev
+          - liblttng-ust-dev
+          - liblzo2-dev
+          - libncurses-dev
+          - libnfs-dev
+          - libnss3-dev
+          - libpixman-1-dev
+          - libsdl2-dev
+          - libsdl2-image-dev
+          - libseccomp-dev
+          - libsnappy-dev
+          - libzstd-dev
+          - nettle-dev
+          - xfslibs-dev
+          # Tests dependencies
+          - genisoimage
+      env:
+        - CONFIG="--disable-containers --audio-drv-list=sdl --disable-user
+                  --target-list-exclude=${MAIN_SOFTMMU_TARGETS}"
+
+    - name: "[s390x] GCC (user)"
+      arch: s390x
+      dist: bionic
+      addons:
+        apt_packages:
+          - libgcrypt20-dev
+          - libgnutls28-dev
+      env:
+        - CONFIG="--disable-containers --disable-system"
+
     - name: "[s390x] Clang (disable-tcg)"
       arch: s390x
       dist: bionic
-- 
2.18.1



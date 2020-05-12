Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDA1C54E8D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 13:39:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AF5E206D3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 13:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hnk7/5hz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF5E206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYV8G-0003D3-Gx
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 09:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jYV7f-0002iL-83
 for qemu-devel@nongnu.org; Tue, 12 May 2020 09:39:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53382
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jYV7e-0000dm-H8
 for qemu-devel@nongnu.org; Tue, 12 May 2020 09:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589290741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=7Unpn9xL530+XrHii1rnhnat0ns6HXZ1QD+DHRtjFv0=;
 b=Hnk7/5hz0fVweb5TZy1YyW3lbIvqd0zFuaYX403SKhwTqS4fYhoDPZrNSUmr/vCHN71sve
 6yiF2WvnKxbTULGVD7pEdYeGrcebEITPePRLPSXA1lnk6D1K9DyqD1RjlrYzzwe8qYn6GK
 TZPm5sTYdK3g3LOVe2YBkGJLXRrE3tk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-4PO3GgUyMgmB1TM4eRBT5Q-1; Tue, 12 May 2020 09:38:55 -0400
X-MC-Unique: 4PO3GgUyMgmB1TM4eRBT5Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FEC639341;
 Tue, 12 May 2020 13:38:54 +0000 (UTC)
Received: from thuth.com (ovpn-112-112.ams2.redhat.com [10.36.112.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4597E1C9;
 Tue, 12 May 2020 13:38:52 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] travis.yml: Improve the --disable-tcg test on s390x
Date: Tue, 12 May 2020 15:38:49 +0200
Message-Id: <20200512133849.10624-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:20:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since the s390x containers do not allow KVM, we only compile-test
the --disable-tcg build on s390x and do not run the qtests. Thus,
it does not make sense to install genisoimage here, and it also does
not make sense to build the s390-ccw.img here again - it is simply
not used without the qtests.
On the other hand, if we do not build the s390-ccw.img anymore, we
can also compile with Clang - so let's use that compiler here to
get some additional test coverage.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .travis.yml | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index fe708792ca..1ec8a7b465 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -502,9 +502,10 @@ jobs:
               $(exit $BUILD_RC);
           fi
 
-    - name: "[s390x] GCC check (KVM)"
+    - name: "[s390x] Clang (disable-tcg)"
       arch: s390x
       dist: bionic
+      compiler: clang
       addons:
         apt_packages:
           - libaio-dev
@@ -528,21 +529,10 @@ jobs:
           - libusb-1.0-0-dev
           - libvdeplug-dev
           - libvte-2.91-dev
-          # Tests dependencies
-          - genisoimage
       env:
         - TEST_CMD="make check-unit"
-        - CONFIG="--disable-containers --disable-tcg --enable-kvm --disable-tools"
-      script:
-        - ( cd ${SRC_DIR} ; git submodule update --init roms/SLOF )
-        - BUILD_RC=0 && make -j${JOBS} || BUILD_RC=$?
-        - |
-          if [ "$BUILD_RC" -eq 0 ] ; then
-              mv pc-bios/s390-ccw/*.img pc-bios/ ;
-              ${TEST_CMD} ;
-          else
-              $(exit $BUILD_RC);
-          fi
+        - CONFIG="--disable-containers --disable-tcg --enable-kvm
+                  --disable-tools --host-cc=clang --cxx=clang++"
 
     # Release builds
     # The make-release script expect a QEMU version, so our tag must start with a 'v'.
-- 
2.18.1



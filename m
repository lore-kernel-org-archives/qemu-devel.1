Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAEAC4332E
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 15:41:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98D0A2072E
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 15:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IWLayCkq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D0A2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jG2in-0008KH-OF
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 11:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41467)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jG2i9-0007sm-Oo
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 11:40:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jG2i7-0007fp-Vn
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 11:40:25 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:59370)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jG2i7-0007el-Jn
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 11:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584891622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AprzRelsVnK8LG/ddLpIr5SAFM0Yk78HQF1QxA7i7jg=;
 b=IWLayCkqJfEAEUOXBkkwXzBE0t2MhUFJGh+SgTsHQqGycXJBcnBeVrAKwCaxUSrDpIL9ry
 6vnN0asrb12FvghhK/ZrfKnaDMUunILBUsml/XObfIZGbKBEVRsoSToFU8XNsUFlPssZmq
 Ft16XSu0hhTscmm12/UTpaqyY2PH1xM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-4csfvQv9P6mP5wkB1y-PHA-1; Sun, 22 Mar 2020 11:40:19 -0400
X-MC-Unique: 4csfvQv9P6mP5wkB1y-PHA-1
Received: by mail-ed1-f71.google.com with SMTP id dn10so9393457edb.6
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2020 08:40:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+27kCCzaDfbx5r1Qo00ZcewVyjPJ3FCR88ldK5F9xjs=;
 b=iUk9M723WnW91YKsQ+H904ZCDZpHwXjE7EoaxjuZDL2hm/NZ+treHT2QBhJ9iSz2Lv
 Zg4Ncb43xf//FLk78A8SUBMR6kWOJs+fguRZsu0ktl6Tv6u2XBv3Q/3ARJk5NxJ35JaM
 J7ag2F6dyAfCuctKbjVZUkmUC7HsNj6+KMfkBBC97jZUMrQeteuFUNZGJnw30UL74uad
 RuNpLnM0Pvuhu55ix4wzzqntns6vj8fcy46mla4GLktfdRrY/rOctc8Zqu7nn9pzsX+V
 /wgr//OcJmWyE+uu2ZVsBYmZ2uO4nlYn3/LoIcWbBJJZwVOeV1CqGUzDuKTVj/8BvERy
 kaXA==
X-Gm-Message-State: ANhLgQ0c31S4SxJjM9pM6H8eclYEFVPU7e3XWnuDymc23tdYCYl0jyDg
 UdXCQ6olrOF7+3xcm6ppE9meb6cQFb8EkP1ak7dRn0fxezo5dncyKUiXpPy+QYWaM6qYRd5GZNu
 FTw6qAdonzKlntSw=
X-Received: by 2002:aa7:cac3:: with SMTP id l3mr17689181edt.90.1584891618095; 
 Sun, 22 Mar 2020 08:40:18 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtTZQ/5Novv6ht0jKmOeIHftuzi09mg6igFFYKLmHKlA/OViNXGXP7o6txpVZzuolUEa7PDZw==
X-Received: by 2002:aa7:cac3:: with SMTP id l3mr17689151edt.90.1584891617766; 
 Sun, 22 Mar 2020 08:40:17 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id y62sm832778ede.5.2020.03.22.08.40.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2020 08:40:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] .travis.yml: Add a KVM-only s390x job
Date: Sun, 22 Mar 2020 16:40:15 +0100
Message-Id: <20200322154015.25358-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a job to build QEMU on s390x with TCG disabled, so
this configuration won't bitrot over time.

This job is quick, running check-unit: Ran for 5 min 30 sec
https://travis-ci.org/github/philmd/qemu/jobs/665456423

Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 .travis.yml | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 5672d129ec..e0c72210b7 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -525,6 +525,48 @@ jobs:
               $(exit $BUILD_RC);
           fi
=20
+    - name: "[s390x] GCC check (KVM)"
+      arch: s390x
+      dist: bionic
+      addons:
+        apt_packages:
+          - libaio-dev
+          - libattr1-dev
+          - libbrlapi-dev
+          - libcap-ng-dev
+          - libgcrypt20-dev
+          - libgnutls28-dev
+          - libgtk-3-dev
+          - libiscsi-dev
+          - liblttng-ust-dev
+          - libncurses5-dev
+          - libnfs-dev
+          - libnss3-dev
+          - libpixman-1-dev
+          - libpng-dev
+          - librados-dev
+          - libsdl2-dev
+          - libseccomp-dev
+          - liburcu-dev
+          - libusb-1.0-0-dev
+          - libvdeplug-dev
+          - libvte-2.91-dev
+          # Tests dependencies
+          - genisoimage
+      env:
+        - TEST_CMD=3D"make check-unit"
+        - CONFIG=3D"--disable-containers --disable-tcg --enable-kvm --disa=
ble-tools"
+      script:
+        - ( cd ${SRC_DIR} ; git submodule update --init roms/SLOF )
+        - BUILD_RC=3D0 && make -j${JOBS} || BUILD_RC=3D$?
+        - |
+          if [ "$BUILD_RC" -eq 0 ] ; then
+              mv pc-bios/s390-ccw/*.img pc-bios/ ;
+              ${TEST_CMD} ;
+          else
+              $(exit $BUILD_RC);
+          fi
+
     # Release builds
     # The make-release script expect a QEMU version, so our tag must start=
 with a 'v'.
     # This is the case when release candidate tags are created.
--=20
2.21.1



Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5C8C17445
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 17:10:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09262214E0
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 17:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3uun9No"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09262214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUDDJ-00062f-60
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 12:10:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1iUD4d-0006Kp-LS
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 12:01:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1iUD4c-0006BT-5j
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 12:01:55 -0500
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836]:42443)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1iUD4c-0006BN-1e
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 12:01:54 -0500
Received: by mail-qt1-x836.google.com with SMTP id t20so16371567qtn.9
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2019 09:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NQ6sIHX3cogSCquUSvZcCkqs4h3Hgeb5nTsLWfS1/HI=;
 b=N3uun9No6UhzYE46gRpANAyf4dgZSLeaWkQm9SDACID5hg8tWukx9xN+2Jmg4sKOsm
 KyBMxuNU9newBcMFrzI08Nd3QBCKH5kNfXtfkjlJE7GtjNnrbPqqJk0bLii+Xi2dcOsb
 x0OPgsgyPa0wzSPSXxPOFbjGZvZuzB5CApDfJyTB0Cxq29D9k2D9PTdjyXIaSbBt7/Vj
 CwWnDGST9hoVHqp4yHEEaeEh+zNUQjBoXWFqSEUEJQn7R9pNdkFwlDG20AcTss96BQIA
 8pk2tUu7LUHEWF/jdy4y/Rs+TCDwGYgAn+PvSG7QxTpypfWbvFnmOIqs1G77LaCOiIp1
 kPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NQ6sIHX3cogSCquUSvZcCkqs4h3Hgeb5nTsLWfS1/HI=;
 b=FALgIMSFzwIzgcra0niu+h6iOSxa93Q1URpoMmac1Ajqrk6ga4JFGcBIbKRdhN5/OM
 AQyBMwrMHROA1fAHTYS/9SKzmizE/yF2suCqOTY+uULukcs0PHm0NxxX0h/bWyZydtjH
 0GxMD/2WzW4zBrcK32rXYfbFmnBWc9Vo5juBJLaNrxRBsGQ18Sn2UtUQ0Fq7fRsfUFaw
 Xa5bIpMExV6NfR5MhbYm61lsIBPJwdkG+dI75TEyu7q7EXCgM05Rj1wptxxyS1fMsD4l
 z8z6f4XfSEJc4hQf42klNyRyYkzPKTP77ai/KCzvkcUKdVFUmndk2LMYybvKlfa72jUS
 hq5g==
X-Gm-Message-State: APjAAAWvnhHj2ArI3GOH4lS6EvFwPxtmJQADICtiEPEc1BLzQupXioNN
 bwr5GCYTLhIDcYSa1GCHm9zM3k8ljig=
X-Google-Smtp-Source: APXvYqy21TkPLbqlStOtPou7fk1+Ce3FxSHRIwU2fZF/wv9HVV3ZPvGf8Pdt9oV6Yq3JSE+arlQO/A==
X-Received: by 2002:ac8:1e13:: with SMTP id n19mr27180588qtl.384.1573491713352; 
 Mon, 11 Nov 2019 09:01:53 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:980:1591:e29e:17a4:d484])
 by smtp.gmail.com with ESMTPSA id n20sm8572462qkn.118.2019.11.11.09.01.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2019 09:01:52 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 4/4] qemu-iotests: adding LUKS cleanup for non-UTF8 secret
 error
Date: Mon, 11 Nov 2019 14:01:31 -0300
Message-Id: <20191111170131.13742-5-danielhb413@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191111170131.13742-1-danielhb413@gmail.com>
References: <20191111170131.13742-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::836
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
Cc: kwolf@redhat.com, Daniel Henrique Barboza <danielhb413@gmail.com>,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds a new test file to exercise the case where
qemu-img fails to complete for the LUKS format when a non-UTF8
secret is used.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 tests/qemu-iotests/273     | 67 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/273.out | 11 +++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 79 insertions(+)
 create mode 100755 tests/qemu-iotests/273
 create mode 100644 tests/qemu-iotests/273.out

diff --git a/tests/qemu-iotests/273 b/tests/qemu-iotests/273
new file mode 100755
index 0000000000..cb362598b4
--- /dev/null
+++ b/tests/qemu-iotests/273
@@ -0,0 +1,67 @@
+#!/usr/bin/env bash
+#
+# Test qemu-img file cleanup for LUKS when using a non-UTF8 secret
+#
+# Copyright (C) 2019, IBM Corporation.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+TEST_IMAGE_FILE='vol.img'
+
+_cleanup()
+{
+  _cleanup_test_img
+  rm non_utf8_secret
+  rm -f $TEST_IMAGE_FILE
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+_supported_fmt luks
+_supported_proto generic
+_unsupported_proto vxhs
+
+echo "== Create non-UTF8 secret =="
+echo -n -e '\x3a\x3c\x3b\xff' > non_utf8_secret
+SECRET="secret,id=sec0,file=non_utf8_secret"
+
+echo "== Throws an error because of invalid UTF-8 secret =="
+$QEMU_IMG create -f $IMGFMT --object $SECRET -o "key-secret=sec0" $TEST_IMAGE_FILE 4M
+
+echo "== Image file should not exist after the error =="
+if test -f "$TEST_IMAGE_FILE"; then
+    exit 1
+fi
+
+echo "== Create a stub image file and run qemu-img again =="
+touch $TEST_IMAGE_FILE
+$QEMU_IMG create -f $IMGFMT --object $SECRET -o "key-secret=sec0" $TEST_IMAGE_FILE 4M
+
+echo "== Pre-existing image file should also be deleted after the error =="
+if test -f "$TEST_IMAGE_FILE"; then
+    exit 1
+fi
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/273.out b/tests/qemu-iotests/273.out
new file mode 100644
index 0000000000..8c6653cd82
--- /dev/null
+++ b/tests/qemu-iotests/273.out
@@ -0,0 +1,11 @@
+QA output created by 273
+== Create non-UTF8 secret ==
+== Throws an error because of invalid UTF-8 secret ==
+qemu-img: vol.img: Data from secret sec0 is not valid UTF-8
+Formatting 'vol.img', fmt=luks size=4194304 key-secret=sec0
+== Image file should not exist after the error ==
+== Create a stub image file and run qemu-img again ==
+qemu-img: vol.img: Data from secret sec0 is not valid UTF-8
+Formatting 'vol.img', fmt=luks size=4194304 key-secret=sec0
+== Pre-existing image file should also be deleted after the error ==
+ *** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 065040398d..fc5a680739 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -284,3 +284,4 @@
 268 rw auto quick
 270 rw backing quick
 272 rw
+273 rw img quick
\ No newline at end of file
-- 
2.21.0



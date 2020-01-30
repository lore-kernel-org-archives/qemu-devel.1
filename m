Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2328EC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:48:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFF3C2083E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tFU/Jko4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFF3C2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixHg4-00023q-Vj
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 16:48:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59298)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ixHX4-0003Xy-NA
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:39:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ixHX3-0001ZO-AE
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:39:26 -0500
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f]:41260)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ixHX3-0001XJ-66; Thu, 30 Jan 2020 16:39:25 -0500
Received: by mail-qk1-x72f.google.com with SMTP id s187so4510666qke.8;
 Thu, 30 Jan 2020 13:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=r4T6tb7o7Rg9yHUzyw3ObbNCSy+JF9iuvJwNjdgekxA=;
 b=tFU/Jko4NOE4ZNsx1pnEfWMG1+875neVX3l5wsuVfc0IvWPdGQgdJSAaw04WmregAl
 7Dv/aFjNqlhD3aLmCKsGZFc3QOjfCLv79RFrMIJTsvtnv9cvq+BOWn4rsSE2VUhtbQD/
 wJkp4b4uzWr1atS18KuFPzqFMvyRJbaHyF6v0bqPsLQ7ZKIb02okmZlMroqpub2AXBxT
 h34LviDaD6aT6e2cm4n/z36UzMUEB+i2Ot2VGhCGsCvAt2K9oSkLLcrigKZsvA7dAbfX
 6CwS0vmO435bUV2fmTfmZqFITY2AhFkYN/YnANtJjQ4UZ9JUvJfzzqUlf2ZcZ+wdmvwK
 ffBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=r4T6tb7o7Rg9yHUzyw3ObbNCSy+JF9iuvJwNjdgekxA=;
 b=nvX544RR47CaM0mH1SsAYHe3MIZWS6FiUxtTE5Txw0oIl8UnxC/3trsAkqHV1sx4uW
 6hL8VfFkELfKKWjswKO0rPrBkS4uR4pJ/F5WM1e2T7HFhH0ArL5kiWtODBp1NCviYBm6
 /QhA86lM+91JDc7/VsvS1JbZvF5H1zp9QoD26ue6qAzQO3bMPXCF4nZJ6bkESZtkyrdh
 D9fgad7dH5pexBTytLLTpZ9U8Teei9Sy36T2dJFjY2s9FXBiCmMGBlTiJDQaofVxdLXc
 ZjQ1jbiHb3OLpzTpeUj6iKFy9UE2ouNdtGBYsFPn/Z9XnhFEetIa85/dltxRQXH6g1c5
 OOrw==
X-Gm-Message-State: APjAAAXCKk5u46OuaPXxgm7E3+d0lEEn5zcTGbXWPrxjv7IDhVebHCEg
 6K6bQMlYA9UiWFM8c8AOfB1cR0uU
X-Google-Smtp-Source: APXvYqyHDTMcNGSizsiAepjDnye+5V39bwaVkN+tw4nMHOOyfKUfj4EeSOWGiHJBiq5FEsSJlHm7AA==
X-Received: by 2002:a05:620a:ce5:: with SMTP id
 c5mr7335365qkj.49.1580420363506; 
 Thu, 30 Jan 2020 13:39:23 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c7:c177:887c:ce1b:6a44:15ec])
 by smtp.gmail.com with ESMTPSA id f26sm3650597qtv.77.2020.01.30.13.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 13:39:23 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 4/4] qemu-iotests: adding LUKS cleanup for non-UTF8 secret
 error
Date: Thu, 30 Jan 2020 18:39:07 -0300
Message-Id: <20200130213907.2830642-5-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200130213907.2830642-1-danielhb413@gmail.com>
References: <20200130213907.2830642-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::72f
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
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds a new test file to exercise the case where
qemu-img fails to complete for the LUKS format when a non-UTF8
secret is used.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 tests/qemu-iotests/282     | 67 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/282.out | 11 +++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 79 insertions(+)
 create mode 100755 tests/qemu-iotests/282
 create mode 100644 tests/qemu-iotests/282.out

diff --git a/tests/qemu-iotests/282 b/tests/qemu-iotests/282
new file mode 100755
index 0000000000..081eb12080
--- /dev/null
+++ b/tests/qemu-iotests/282
@@ -0,0 +1,67 @@
+#!/usr/bin/env bash
+#
+# Test qemu-img file cleanup for LUKS when using a non-UTF8 secret
+#
+# Copyright (C) 2020, IBM Corporation.
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
diff --git a/tests/qemu-iotests/282.out b/tests/qemu-iotests/282.out
new file mode 100644
index 0000000000..5d079dabce
--- /dev/null
+++ b/tests/qemu-iotests/282.out
@@ -0,0 +1,11 @@
+QA output created by 282
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
index e041cc1ee3..9d8bf8f783 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -289,3 +289,4 @@
 279 rw backing quick
 280 rw migration quick
 281 rw quick
+282 rw img quick
-- 
2.24.1



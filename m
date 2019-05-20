Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65211C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:30:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BC0B20863
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC0B20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43602 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSrji-0006vC-Ck
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 19:30:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrRb-0008DQ-DL
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:11:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrRZ-0008SC-Ty
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:11:47 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]:39731)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hSrRZ-0008R0-Om
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:11:45 -0400
Received: by mail-qt1-f182.google.com with SMTP id y42so18367059qtk.6
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 16:11:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to;
	bh=Z/IfauSZcYb/NvfmZ0aQ9zbqfx97hf0Wl+ffe4WB7Ls=;
	b=ilTyRSVlZpizbUa6lXdTtf1Ifq75mdgmotE7VZplq1eJMgu8TH6wc/05bN1+bQLqLT
	Reo17acSJrLYtc9t5Ot/o4B7O9fdue8WcQ+SLwfyYvtrCfStO4th97AQVUelpA2cOhHp
	sDO2qSFCulx7m61ahEFzrCVKimFDuh1drOLT8RFAshOavgqyd4PgFJ4lbzS9IGSE82lL
	nUHvPd5jWrR7W7kJTHzc7C2T9seLs4oYmWaJw4U7K1ADqiSYskKWwYiQYKqHZfT8It71
	p5AE56quYujXtEqBxWtoOJcQAkSRLcPP7+Sicv5+FPtcuMC3bNp3Z2ZjvjcF06RT40jo
	NXeA==
X-Gm-Message-State: APjAAAXQv/5IxKQd7EaVfNQTnjS9dfkd2O2t1NDoyH/rVIKjoARBxXDV
	QqvlAZNcSJZbsTBHlAbxajZ/1BARo8U=
X-Google-Smtp-Source: APXvYqwQeQjQvth28Lm3run1M1udCFqzECAfd6+yv3NS+diWOkyD9whfVAIkuWSCZVhpmV7SS8725Q==
X-Received: by 2002:aed:3f4d:: with SMTP id q13mr64514424qtf.295.1558393903898;
	Mon, 20 May 2019 16:11:43 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71]) by smtp.gmail.com with ESMTPSA id
	a1sm10007940qth.69.2019.05.20.16.11.42
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 20 May 2019 16:11:43 -0700 (PDT)
Date: Mon, 20 May 2019 19:11:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <1556808723-226478-15-git-send-email-imammedo@redhat.com>
References: <20190520231008.20140-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190520231008.20140-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.182
Subject: [Qemu-devel] [PULL v2 35/36] tests: acpi: refactor
 rebuild-expected-aml.sh to dump ACPI tables for a specified list of targets
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Wei Yang <richardw.yang@linux.intel.com>,
	Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190520231142.njYJqTwnwRTHXrdfQ2APA14sgLvp99jkjk38CEK8tsc@z>

From: Igor Mammedov <imammedo@redhat.com>

Make initial list contain aarch64 and x86_64 targets.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <1556808723-226478-15-git-send-email-imammedo@redhat.com>
Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/data/acpi/rebuild-expected-aml.sh | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/tests/data/acpi/rebuild-expected-aml.sh b/tests/data/acpi/rebuild-expected-aml.sh
index abdff70a0d..07f7e3f501 100755
--- a/tests/data/acpi/rebuild-expected-aml.sh
+++ b/tests/data/acpi/rebuild-expected-aml.sh
@@ -7,21 +7,12 @@
 #
 # Authors:
 #  Marcel Apfelbaum <marcel.a@redhat.com>
+#  Igor Mammedov <imammedo@redhat.com>
 #
 # This work is licensed under the terms of the GNU GPLv2.
 # See the COPYING.LIB file in the top-level directory.
 
-qemu=
-
-if [ -e x86_64-softmmu/qemu-system-x86_64 ]; then
-    qemu="x86_64-softmmu/qemu-system-x86_64"
-elif [ -e i386-softmmu/qemu-system-i386 ]; then
-    qemu="i386-softmmu/qemu-system-i386"
-else
-    echo "Run 'make' to build the qemu exectutable!"
-    echo "Run this script from the build directory."
-    exit 1;
-fi
+qemu_bins="aarch64-softmmu/qemu-system-aarch64 x86_64-softmmu/qemu-system-x86_64"
 
 if [ ! -e "tests/bios-tables-test" ]; then
     echo "Test: bios-tables-test is required! Run make check before this script."
@@ -29,6 +20,14 @@ if [ ! -e "tests/bios-tables-test" ]; then
     exit 1;
 fi
 
-TEST_ACPI_REBUILD_AML=y QTEST_QEMU_BINARY=$qemu tests/bios-tables-test
+for qemu in $qemu_bins; do
+    if [ ! -e $qemu ]; then
+        echo "Run 'make' to build the following QEMU executables: $qemu_bins"
+        echo "Also, run this script from the build directory."
+        exit 1;
+    fi
+    TEST_ACPI_REBUILD_AML=y QTEST_QEMU_BINARY=$qemu tests/bios-tables-test
+done
+
 
 echo "The files were rebuilt and can be added to git."
-- 
MST



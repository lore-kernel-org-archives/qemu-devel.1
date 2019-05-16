Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F9CC04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 13:00:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D43A20833
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 13:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D43A20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54927 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRFzb-0001WT-TQ
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 09:00:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFNw-0002AN-Ez
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:21:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFNs-0003BJ-JN
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:21:20 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44188)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hRFNs-0003AZ-Ex
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:21:16 -0400
Received: by mail-qk1-f196.google.com with SMTP id w25so2040989qkj.11
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 05:21:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to;
	bh=Z/IfauSZcYb/NvfmZ0aQ9zbqfx97hf0Wl+ffe4WB7Ls=;
	b=b2CZP7r6Prg3KbMAaro9ehzFbMK6qWOdUKgNmBeo/0JCBmBAGFWhrFdHpU0nwEc1Cv
	OcXV7sj0Qm5jzjqQs9q+lE4+QpzytXFIBF+p1jaddrsyfF9Jh3NIyYcYVn36RforboEQ
	spX1AlhkzUoMOu6pc7wklmvcO6x5/sVT/o9idFLFqHySKS2jvOSEcfcMmHXTY1GRdjX0
	pylcFk4lrOQF3w5DeXOzsV5YtlA/AmIRbU/6Htbgby8fa8vXwkiTICyTCezQbEYaeFgl
	aUkUzm/+0KD6XgdcLnJFjj5Sd/lERkzrU3mLaNwvWpqiHi7WEvQuFNODG09caErKOi0P
	+I3A==
X-Gm-Message-State: APjAAAW92jVijQJvboXZrzgfJe0MY5AjrK5aim4aVSawAo/6aqC5rz7F
	gSpBLTLBA2AoWXtpejvHANg8bM5jVm8=
X-Google-Smtp-Source: APXvYqwkQOsSmaUu7jktJ4nMofNoLx+2NPtU7kagcmpdFcLtX/ARwRKDIMtVR7ppVvNABUtSliqK4A==
X-Received: by 2002:a05:620a:124f:: with SMTP id
	a15mr30908645qkl.210.1558009274533; 
	Thu, 16 May 2019 05:21:14 -0700 (PDT)
Received: from redhat.com ([185.54.206.10])
	by smtp.gmail.com with ESMTPSA id 17sm2233532qkg.30.2019.05.16.05.21.12
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 16 May 2019 05:21:13 -0700 (PDT)
Date: Thu, 16 May 2019 08:21:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <1556808723-226478-15-git-send-email-imammedo@redhat.com>
References: <20190515121146.7248-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190515121146.7248-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.196
Subject: [Qemu-devel] [PULL 36/37] tests: acpi: refactor
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
Message-ID: <20190516122111.gdpRjseNfOlsGec-g9Ym2gpmqtvE6-ldJlVvWpPGZt8@z>

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



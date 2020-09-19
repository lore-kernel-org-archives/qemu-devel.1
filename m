Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4017CC43464
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 13:37:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 891E120878
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 13:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SnBtwgwq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 891E120878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJd3n-0001dl-F3
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 09:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kJd2l-0001Di-2N
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 09:36:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41090)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kJd2i-000598-Gn
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 09:36:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600522603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=U9ubkd3O7+YWeUZ8RN0ix03ulsPZPWBQJNmS6a7M/ow=;
 b=SnBtwgwqmQ9c74vV58GevE/P1Hhjb2E9JA12imt13vwZlE3tRihbXqDmHwznaSWLJJje+1
 XQAeWCDRFJ73emET4FQR1v30nljfcX3FHsh8XKXhQpD51HQovIlSvWWg72PX7ILO32h9XE
 YfgXDU4VaagMy7f0W2z/AZSWk0BYRPo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-PojkqYCxO6WaFs54D65m2A-1; Sat, 19 Sep 2020 09:36:40 -0400
X-MC-Unique: PojkqYCxO6WaFs54D65m2A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9A5C10A7AE2;
 Sat, 19 Sep 2020 13:36:39 +0000 (UTC)
Received: from thuth.com (ovpn-112-71.ams2.redhat.com [10.36.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1B19A68D62;
 Sat, 19 Sep 2020 13:36:38 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] Remove superfluous .gitignore files
Date: Sat, 19 Sep 2020 15:36:37 +0200
Message-Id: <20200919133637.72744-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 06:41:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since we are now always doing out-of-tree builds, these gitignore
files should not be necessary anymore.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/keymaps/.gitignore       |  1 -
 plugins/.gitignore               |  2 --
 tests/.gitignore                 | 32 --------------------------------
 tests/fp/.gitignore              |  2 --
 tests/migration/.gitignore       |  2 --
 tests/multiboot/.gitignore       |  3 ---
 tests/qemu-iotests/.gitignore    |  9 ---------
 tests/tcg/.gitignore             |  5 -----
 tests/uefi-test-tools/.gitignore |  3 ---
 9 files changed, 59 deletions(-)
 delete mode 100644 pc-bios/keymaps/.gitignore
 delete mode 100644 plugins/.gitignore
 delete mode 100644 tests/.gitignore
 delete mode 100644 tests/fp/.gitignore
 delete mode 100644 tests/migration/.gitignore
 delete mode 100644 tests/multiboot/.gitignore
 delete mode 100644 tests/qemu-iotests/.gitignore
 delete mode 100644 tests/tcg/.gitignore
 delete mode 100644 tests/uefi-test-tools/.gitignore

diff --git a/pc-bios/keymaps/.gitignore b/pc-bios/keymaps/.gitignore
deleted file mode 100644
index f90738f4dc..0000000000
--- a/pc-bios/keymaps/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-/*.stamp
diff --git a/plugins/.gitignore b/plugins/.gitignore
deleted file mode 100644
index 7b8aaa1f10..0000000000
--- a/plugins/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-qemu-plugins-ld.symbols
-qemu-plugins-ld64.symbols
diff --git a/tests/.gitignore b/tests/.gitignore
deleted file mode 100644
index d03c037d77..0000000000
--- a/tests/.gitignore
+++ /dev/null
@@ -1,32 +0,0 @@
-atomic_add-bench
-benchmark-crypto-cipher
-benchmark-crypto-hash
-benchmark-crypto-hmac
-check-*
-!check-*.c
-!check-*.sh
-fp/*.out
-qht-bench
-rcutorture
-test-*
-!test-*.c
-!test-*.py
-!docker/test-*
-test-qapi-commands.[ch]
-test-qapi-init-commands.[ch]
-include/test-qapi-commands-sub-module.[ch]
-test-qapi-commands-sub-sub-module.[ch]
-test-qapi-emit-events.[ch]
-test-qapi-events.[ch]
-include/test-qapi-events-sub-module.[ch]
-test-qapi-events-sub-sub-module.[ch]
-test-qapi-types.[ch]
-include/test-qapi-types-sub-module.[ch]
-test-qapi-types-sub-sub-module.[ch]
-test-qapi-visit.[ch]
-include/test-qapi-visit-sub-module.[ch]
-test-qapi-visit-sub-sub-module.[ch]
-test-qapi-introspect.[ch]
-*-test
-qapi-schema/*.test.*
-vm/*.img
diff --git a/tests/fp/.gitignore b/tests/fp/.gitignore
deleted file mode 100644
index 704fd42992..0000000000
--- a/tests/fp/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-fp-test
-fp-bench
diff --git a/tests/migration/.gitignore b/tests/migration/.gitignore
deleted file mode 100644
index 84f37552e4..0000000000
--- a/tests/migration/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-initrd-stress.img
-stress
diff --git a/tests/multiboot/.gitignore b/tests/multiboot/.gitignore
deleted file mode 100644
index 93ef99800b..0000000000
--- a/tests/multiboot/.gitignore
+++ /dev/null
@@ -1,3 +0,0 @@
-*.bin
-*.elf
-test.out
diff --git a/tests/qemu-iotests/.gitignore b/tests/qemu-iotests/.gitignore
deleted file mode 100644
index da62054000..0000000000
--- a/tests/qemu-iotests/.gitignore
+++ /dev/null
@@ -1,9 +0,0 @@
-check.log
-check.time*
-common.env
-*.out.bad
-*.notrun
-socket_scm_helper
-
-# ignore everything in the scratch directory
-scratch/
diff --git a/tests/tcg/.gitignore b/tests/tcg/.gitignore
deleted file mode 100644
index 84d7541b28..0000000000
--- a/tests/tcg/.gitignore
+++ /dev/null
@@ -1,5 +0,0 @@
-# These are build artefacts which only appear when you are doing
-# builds directly in the source tree.
-config-*.mak
-*-softmmu/
-*-linux-user/
diff --git a/tests/uefi-test-tools/.gitignore b/tests/uefi-test-tools/.gitignore
deleted file mode 100644
index 9f246701de..0000000000
--- a/tests/uefi-test-tools/.gitignore
+++ /dev/null
@@ -1,3 +0,0 @@
-Build
-Conf
-log
-- 
2.18.2



Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF43EC4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:21:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B30720665
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="ESWEi5e+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B30720665
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOOk7-0003aX-JI
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 13:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <1bb273a60bd944539a3db28c0da4ccac8c0126ad@lizzy.crudebyte.com>)
 id 1kOOiR-0002RB-TY
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:19:31 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:54705)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <1bb273a60bd944539a3db28c0da4ccac8c0126ad@lizzy.crudebyte.com>)
 id 1kOOiQ-0001Do-9N
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:19:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=61K9IPek47Lb/jUIgvqHI9x1BIex8Psn2YIHGCS3rpk=; b=ESWEi
 5e+I5WnAEbzmB/i0N9ohLq5NqZkucfv0Zsx4mENYdMf5UhdpXv6hJmFFopXE5hxiJN1qR0eMuCDpC
 8oqlCMSPAXH6DgFF9fW8tk//bVzhKAhxYUxalCM8LsbrIbBw37u5fbcKzOz8gZx2jx2j3bDP+cZ9s
 rA1YxM9Ge28AEaMU39k/5gNjo3B5n4nCHVw/5NycLopPXRW2tx2JRE78nXrFUfaq6ukPWoloV7rE/
 LPuryvnoyiSKPrWOg9BIpwwfhD4MvPDrmHz3uYvQSwKlJmxJJsRB+omCyPtc1veVS8i8mLUJLn64/
 zxiU5xO2MtFHGAYQ/odwQmLXAr3bQ==;
Message-Id: <1bb273a60bd944539a3db28c0da4ccac8c0126ad.1601655308.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1601655308.git.qemu_oss@crudebyte.com>
References: <cover.1601655308.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Fri, 2 Oct 2020 18:15:05 +0200
Subject: [PATCH v3 07/11] tests/9pfs: change qtest name prefix to synth
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>, berrange@redhat.com
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=1bb273a60bd944539a3db28c0da4ccac8c0126ad@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 08:18:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All existing 9pfs test cases are using the 'synth' fs driver so far, which
means they are not accessing real files, but a purely simulated (in RAM
only) file system.

Let's make this clear by changing the prefix of the individual qtest case
names from 'fs/' to 'synth/'. That way they'll be easily distinguishable
from upcoming new 9pfs test cases supposed to be using a different fs
driver.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/virtio-9p-test.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index de30b717b6..3281153b9c 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -897,26 +897,26 @@ static void fs_readdir_split_512(void *obj, void *data,
 
 static void register_virtio_9p_test(void)
 {
-    qos_add_test("config", "virtio-9p", pci_config, NULL);
-    qos_add_test("fs/version/basic", "virtio-9p", fs_version, NULL);
-    qos_add_test("fs/attach/basic", "virtio-9p", fs_attach, NULL);
-    qos_add_test("fs/walk/basic", "virtio-9p", fs_walk, NULL);
-    qos_add_test("fs/walk/no_slash", "virtio-9p", fs_walk_no_slash,
+    qos_add_test("synth/config", "virtio-9p", pci_config, NULL);
+    qos_add_test("synth/version/basic", "virtio-9p", fs_version, NULL);
+    qos_add_test("synth/attach/basic", "virtio-9p", fs_attach, NULL);
+    qos_add_test("synth/walk/basic", "virtio-9p", fs_walk, NULL);
+    qos_add_test("synth/walk/no_slash", "virtio-9p", fs_walk_no_slash,
                  NULL);
-    qos_add_test("fs/walk/dotdot_from_root", "virtio-9p",
+    qos_add_test("synth/walk/dotdot_from_root", "virtio-9p",
                  fs_walk_dotdot, NULL);
-    qos_add_test("fs/lopen/basic", "virtio-9p", fs_lopen, NULL);
-    qos_add_test("fs/write/basic", "virtio-9p", fs_write, NULL);
-    qos_add_test("fs/flush/success", "virtio-9p", fs_flush_success,
+    qos_add_test("synth/lopen/basic", "virtio-9p", fs_lopen, NULL);
+    qos_add_test("synth/write/basic", "virtio-9p", fs_write, NULL);
+    qos_add_test("synth/flush/success", "virtio-9p", fs_flush_success,
                  NULL);
-    qos_add_test("fs/flush/ignored", "virtio-9p", fs_flush_ignored,
+    qos_add_test("synth/flush/ignored", "virtio-9p", fs_flush_ignored,
                  NULL);
-    qos_add_test("fs/readdir/basic", "virtio-9p", fs_readdir, NULL);
-    qos_add_test("fs/readdir/split_512", "virtio-9p",
+    qos_add_test("synth/readdir/basic", "virtio-9p", fs_readdir, NULL);
+    qos_add_test("synth/readdir/split_512", "virtio-9p",
                  fs_readdir_split_512, NULL);
-    qos_add_test("fs/readdir/split_256", "virtio-9p",
+    qos_add_test("synth/readdir/split_256", "virtio-9p",
                  fs_readdir_split_256, NULL);
-    qos_add_test("fs/readdir/split_128", "virtio-9p",
+    qos_add_test("synth/readdir/split_128", "virtio-9p",
                  fs_readdir_split_128, NULL);
 }
 
-- 
2.20.1



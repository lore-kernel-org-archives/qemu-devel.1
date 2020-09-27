Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E7BC4346E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 12:13:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C82F23718
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 12:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="jWSbJUqY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C82F23718
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMVYp-0005hh-K8
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 08:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <e6142a0af2050fa1355b8bc6de6162c4cd675812@lizzy.crudebyte.com>)
 id 1kMVYC-0005IT-VY
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 08:13:09 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:47425)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <e6142a0af2050fa1355b8bc6de6162c4cd675812@lizzy.crudebyte.com>)
 id 1kMVYA-00066K-AU
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 08:13:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=cdYoMuk7yWJGGnSW3M/mg3s/OyEZ1H38EURPSLuhe2s=; b=jWSbJ
 UqYR0fso4+D8rbuSmOzADgIyvZziIdKgnyzdsXWQk59JKAGmELbAElMncpJ9aSrbnaiQKe8rxX6OF
 9mPaF0+Ma8KaDBFuM9+DsgMW3Nqf3G3aH3V/mEPITngDa5MlNm3qvv7TyeBjaytkuQ61Cxzly8qlW
 y4xO93FlSUqwcz4X+rqq0G0bG63545K2KqZvfoyk2g1NkPC+awUuyr9N4kXyWE4sasboU1fzbmXs6
 sw8L7kXDQM3g8mzUaW6RzCQTebgJ9r/rufqouxg79c4wm8BeXaK7qauzrSm0YE7204Imr/pgLbw/t
 oR/mNkqalXfccnh0p7Vxtj3WzO5/g==;
Message-Id: <e6142a0af2050fa1355b8bc6de6162c4cd675812.1601203436.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1601203436.git.qemu_oss@crudebyte.com>
References: <cover.1601203436.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sun, 27 Sep 2020 12:40:21 +0200
Subject: [PATCH 07/12] test/9pfs: change export tag name to qtest-synth
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=e6142a0af2050fa1355b8bc6de6162c4cd675812@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/27 07:42:27
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

Let's start to make this clear with this and the following patch to pave
the way for upcoming new tests going to use the 9pfs 'local' driver
instead.

This patch starts by changing the 9p tag name (which identifies one
particular 9p exported file tree) from 'qtest' to 'qtest-synth' and also
change the preprocessor macro used for this from TAG_NAME to TAG_NAME_SYNTH.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/libqos/virtio-9p.c | 4 ++--
 tests/qtest/libqos/virtio-9p.h | 2 +-
 tests/qtest/virtio-9p-test.c   | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/libqos/virtio-9p.c b/tests/qtest/libqos/virtio-9p.c
index 2e300063e3..9f099737f9 100644
--- a/tests/qtest/libqos/virtio-9p.c
+++ b/tests/qtest/libqos/virtio-9p.c
@@ -148,8 +148,8 @@ static void *virtio_9p_pci_create(void *pci_bus, QGuestAllocator *t_alloc,
 
 static void virtio_9p_register_nodes(void)
 {
-    const char *str_simple = "fsdev=fsdev0,mount_tag=" MOUNT_TAG;
-    const char *str_addr = "fsdev=fsdev0,addr=04.0,mount_tag=" MOUNT_TAG;
+    const char *str_simple = "fsdev=fsdev0,mount_tag=" MOUNT_TAG_SYNTH;
+    const char *str_addr = "fsdev=fsdev0,addr=04.0,mount_tag=" MOUNT_TAG_SYNTH;
 
     QPCIAddress addr = {
         .devfn = QPCI_DEVFN(4, 0),
diff --git a/tests/qtest/libqos/virtio-9p.h b/tests/qtest/libqos/virtio-9p.h
index b1e6badc4a..d9a815083f 100644
--- a/tests/qtest/libqos/virtio-9p.h
+++ b/tests/qtest/libqos/virtio-9p.h
@@ -27,7 +27,7 @@ typedef struct QVirtio9P QVirtio9P;
 typedef struct QVirtio9PPCI QVirtio9PPCI;
 typedef struct QVirtio9PDevice QVirtio9PDevice;
 
-#define MOUNT_TAG "qtest"
+#define MOUNT_TAG_SYNTH "qtest-synth"
 
 struct QVirtio9P {
     QVirtioDevice *vdev;
diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index de30b717b6..f7505396f3 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -26,13 +26,13 @@ static void pci_config(void *obj, void *data, QGuestAllocator *t_alloc)
     char *tag;
     int i;
 
-    g_assert_cmpint(tag_len, ==, strlen(MOUNT_TAG));
+    g_assert_cmpint(tag_len, ==, strlen(MOUNT_TAG_SYNTH));
 
     tag = g_malloc(tag_len);
     for (i = 0; i < tag_len; i++) {
         tag[i] = qvirtio_config_readb(v9p->vdev, i + 2);
     }
-    g_assert_cmpmem(tag, tag_len, MOUNT_TAG, tag_len);
+    g_assert_cmpmem(tag, tag_len, MOUNT_TAG_SYNTH, tag_len);
     g_free(tag);
 }
 
-- 
2.20.1



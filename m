Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EA0C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 11:10:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 423C1207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 11:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IFtxl5NG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 423C1207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBcGx-0006Ok-Ey
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 07:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kBcEv-0002Gq-2v
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 07:08:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22611
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kBcEt-0000Op-Ak
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 07:08:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598612888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o9ep1qptdjRM62QsjC9J4x0WFtrsIQZlAsBsgVFHHH4=;
 b=IFtxl5NGsUeuWj1QjDOou0BCJZQp+DjJawsLUSp5DpF3tPU8Tzj0lAxG0An49qejASBoxP
 KCTsy6hmNME81gTJ5IpIObzrSoaoFovE9InZLuZIX7mzos8IswVSxLOpYZ2Y3Tq36I3GlG
 lNqLVjiUhyurUKT1WLLTlTlObBpdFv4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-7jhYr3_iObiwYuYCcpButg-1; Fri, 28 Aug 2020 07:08:06 -0400
X-MC-Unique: 7jhYr3_iObiwYuYCcpButg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6C2F80EF84
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 11:08:05 +0000 (UTC)
Received: from localhost (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F2BBA5C1C2;
 Fri, 28 Aug 2020 11:08:01 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH 03/16] meson: declare keyutils dependency
Date: Fri, 28 Aug 2020 15:07:21 +0400
Message-Id: <20200828110734.1638685-4-marcandre.lureau@redhat.com>
In-Reply-To: <20200828110734.1638685-1-marcandre.lureau@redhat.com>
References: <20200828110734.1638685-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=marcandre.lureau@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 04:08:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: pbonzini@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Rename the variable to be more explicit. A further clean-up patch will
move the actual to dependency check to meson entirely.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 configure                  |  2 +-
 meson.build                |  4 ++++
 tests/Makefile.include     |  2 +-
 tests/test-crypto-secret.c | 10 +++++-----
 4 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/configure b/configure
index 12636369d1..2471483bec 100755
--- a/configure
+++ b/configure
@@ -7536,7 +7536,7 @@ fi
 if test "$secret_keyring" = "yes" ; then
   echo "CONFIG_SECRET_KEYRING=y" >> $config_host_mak
   if test "$have_keyutils" = "yes" ; then
-    echo "CONFIG_TEST_SECRET_KEYRING=y" >> $config_host_mak
+    echo "CONFIG_KEYUTILS=y" >> $config_host_mak
   fi
 fi
 
diff --git a/meson.build b/meson.build
index 2002728487..d69dd846d1 100644
--- a/meson.build
+++ b/meson.build
@@ -406,6 +406,10 @@ if 'CONFIG_TASN1' in config_host
   tasn1 = declare_dependency(compile_args: config_host['TASN1_CFLAGS'].split(),
                              link_args: config_host['TASN1_LIBS'].split())
 endif
+keyutils = not_found
+if 'CONFIG_KEYUTILS' in config_host
+  keyutils = declare_dependency(link_args: '-lkeyutils')
+endif
 
 # Create config-host.h
 
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 9e72cfefbe..9599990a83 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -248,7 +248,7 @@ tests/benchmark-crypto-cipher$(EXESUF): tests/benchmark-crypto-cipher.o $(test-c
 tests/test-crypto-secret$(EXESUF): tests/test-crypto-secret.o $(test-crypto-obj-y)
 tests/test-crypto-xts$(EXESUF): tests/test-crypto-xts.o $(test-crypto-obj-y)
 
-ifeq ($(CONFIG_TEST_SECRET_KEYRING),y)
+ifeq ($(CONFIG_KEYUTILS),y)
 tests/test-crypto-secret.o-libs := -lkeyutils
 endif
 
diff --git a/tests/test-crypto-secret.c b/tests/test-crypto-secret.c
index 603a093f10..9d06176663 100644
--- a/tests/test-crypto-secret.c
+++ b/tests/test-crypto-secret.c
@@ -24,7 +24,7 @@
 #include "crypto/secret.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
-#ifdef CONFIG_TEST_SECRET_KEYRING
+#ifdef CONFIG_KEYUTILS
 #include "crypto/secret_keyring.h"
 #include <keyutils.h>
 #endif
@@ -128,7 +128,7 @@ static void test_secret_indirect_emptyfile(void)
     g_free(fname);
 }
 
-#ifdef CONFIG_TEST_SECRET_KEYRING
+#ifdef CONFIG_KEYUTILS
 
 #define DESCRIPTION "qemu_test_secret"
 #define PAYLOAD "Test Payload"
@@ -268,7 +268,7 @@ static void test_secret_keyring_bad_key_access_right(void)
     keyctl_unlink(key, KEY_SPEC_PROCESS_KEYRING);
 }
 
-#endif /* CONFIG_TEST_SECRET_KEYRING */
+#endif /* CONFIG_KEYUTILS */
 
 static void test_secret_noconv_base64_good(void)
 {
@@ -571,7 +571,7 @@ int main(int argc, char **argv)
     g_test_add_func("/crypto/secret/indirect/emptyfile",
                     test_secret_indirect_emptyfile);
 
-#ifdef CONFIG_TEST_SECRET_KEYRING
+#ifdef CONFIG_KEYUTILS
     g_test_add_func("/crypto/secret/keyring/good",
                     test_secret_keyring_good);
     g_test_add_func("/crypto/secret/keyring/revoked_key",
@@ -582,7 +582,7 @@ int main(int argc, char **argv)
                     test_secret_keyring_bad_serial_key);
     g_test_add_func("/crypto/secret/keyring/bad_key_access_right",
                     test_secret_keyring_bad_key_access_right);
-#endif /* CONFIG_TEST_SECRET_KEYRING */
+#endif /* CONFIG_KEYUTILS */
 
     g_test_add_func("/crypto/secret/noconv/base64/good",
                     test_secret_noconv_base64_good);
-- 
2.26.2



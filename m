Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1232EC433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:11:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF07020767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F5rpgIRq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF07020767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDSXy-0003cC-W4
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 09:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDSMV-0006C2-Aq
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 08:59:39 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57361
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDSMS-00078k-AS
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 08:59:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599051575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cn9Y0k8ZBU+n39Ura5BFh068S8/Q9sQTbvMa1fTi4rY=;
 b=F5rpgIRqXdwFnFiZXCleocvdxVY+XveIjyGG6xRy5pzCDunABEE0pOFF96nsN6Fq4WMlI0
 UK1/NgBFlZD/uP9BiudB8ZoYk5cfJ/rZ6qOkPa/tyUd1tFJBBl+k0+bpCfHUX7SRQlyy9Y
 +VT1FleGf2CxUs4PhW4frOAP0v0ZBfM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-548-AasspEF-MRiGEj_1RZv-eQ-1; Wed, 02 Sep 2020 08:59:28 -0400
X-MC-Unique: AasspEF-MRiGEj_1RZv-eQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D759E81F00A
 for <qemu-devel@nongnu.org>; Wed,  2 Sep 2020 12:59:24 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 39B5576E01;
 Wed,  2 Sep 2020 12:59:24 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/39] meson: declare keyutils dependency
Date: Wed,  2 Sep 2020 08:58:51 -0400
Message-Id: <20200902125917.26021-14-pbonzini@redhat.com>
In-Reply-To: <20200902125917.26021-1-pbonzini@redhat.com>
References: <20200902125917.26021-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 03:24:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Rename the variable to be more explicit. A further clean-up patch will
move the actual to dependency check to meson entirely.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200828110734.1638685-4-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                  |  2 +-
 meson.build                |  4 ++++
 tests/Makefile.include     |  2 +-
 tests/test-crypto-secret.c | 10 +++++-----
 4 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/configure b/configure
index 2790cf15d7..6a43ef6c2d 100755
--- a/configure
+++ b/configure
@@ -7511,7 +7511,7 @@ fi
 if test "$secret_keyring" = "yes" ; then
   echo "CONFIG_SECRET_KEYRING=y" >> $config_host_mak
   if test "$have_keyutils" = "yes" ; then
-    echo "CONFIG_TEST_SECRET_KEYRING=y" >> $config_host_mak
+    echo "CONFIG_KEYUTILS=y" >> $config_host_mak
   fi
 fi
 
diff --git a/meson.build b/meson.build
index b2d1a909b6..fc46273491 100644
--- a/meson.build
+++ b/meson.build
@@ -410,6 +410,10 @@ if 'CONFIG_TASN1' in config_host
   tasn1 = declare_dependency(compile_args: config_host['TASN1_CFLAGS'].split(),
                              link_args: config_host['TASN1_LIBS'].split())
 endif
+keyutils = not_found
+if 'CONFIG_KEYUTILS' in config_host
+  keyutils = declare_dependency(link_args: '-lkeyutils')
+endif
 
 # Create config-host.h
 
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 1451f64df7..addeafafd4 100644
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




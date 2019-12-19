Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68065C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:32:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33233218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gb0eEH56"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33233218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihuyY-0000FV-3W
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 07:32:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60793)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihurC-0007zx-7U
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:24:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihurA-0008Ck-Na
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:24:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32727
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihurA-00089S-H2
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:24:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fnnXPT/mDA3xX40/wFT9/3Y27tp8pejr/mUmdgIE2Y4=;
 b=gb0eEH56mAdURHFyWx0Ua+6ZlMYdsZPThuwYT0gQn8+bM6K0B2+qlucvKTKDfwE86YaLhm
 +Nwj+ot2orSWefWV4SXSifxSuVHTUeYOo1aYo+mOMpsUpJ1upy1YUVutYg1Hcso2pr3WeP
 V2R08Ly/5OkuWr4/ar40JbwvtRNpbNQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-ksIJyq-vMv2wQxIs1HJ6mw-1; Thu, 19 Dec 2019 07:24:35 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0ED36107AD45
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 12:24:35 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-55.ams2.redhat.com
 [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5DDA860C18;
 Thu, 19 Dec 2019 12:24:31 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 104/132] meson: convert target/s390x/gen-features.h
Date: Thu, 19 Dec 2019 13:23:24 +0100
Message-Id: <1576758232-12439-13-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: ksIJyq-vMv2wQxIs1HJ6mw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Needed already by tracepoints.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 meson.build                 |  1 +
 target/meson.build          |  1 +
 target/s390x/Makefile.objs  | 20 --------------------
 target/s390x/cpu_features.h |  2 +-
 target/s390x/cpu_models.h   |  2 +-
 target/s390x/meson.build    |  8 ++++++++
 6 files changed, 12 insertions(+), 22 deletions(-)
 create mode 100644 target/meson.build
 create mode 100644 target/s390x/meson.build

diff --git a/meson.build b/meson.build
index 58bc25c..378d2c0 100644
--- a/meson.build
+++ b/meson.build
@@ -639,6 +639,7 @@ subdir('monitor')
 subdir('net')
 subdir('replay')
 subdir('hw')
+subdir('target')
=20
 mods =3D []
 block_mods =3D []
diff --git a/target/meson.build b/target/meson.build
new file mode 100644
index 0000000..e29dd3e
--- /dev/null
+++ b/target/meson.build
@@ -0,0 +1 @@
+subdir('s390x')
diff --git a/target/s390x/Makefile.objs b/target/s390x/Makefile.objs
index 3e27455..9b9accc 100644
--- a/target/s390x/Makefile.objs
+++ b/target/s390x/Makefile.objs
@@ -8,23 +8,3 @@ obj-$(CONFIG_SOFTMMU) +=3D sigp.o
 obj-$(CONFIG_KVM) +=3D kvm.o
 obj-$(call lnot,$(CONFIG_KVM)) +=3D kvm-stub.o
 obj-$(call lnot,$(CONFIG_TCG)) +=3D tcg-stub.o
-
-# build and run feature list generator
-feat-src =3D $(SRC_PATH)/target/$(TARGET_BASE_ARCH)/
-feat-dst =3D $(BUILD_DIR)/$(TARGET_DIR)
-ifneq ($(MAKECMDGOALS),clean)
-generated-files-y +=3D $(feat-dst)gen-features.h
-endif
-
-$(feat-dst)gen-features.h: $(feat-dst)gen-features.h-timestamp
-=09@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-$(feat-dst)gen-features.h-timestamp: $(feat-dst)gen-features
-=09$(call quiet-command,$< >$@,"GEN","$(TARGET_DIR)gen-features.h")
-
-$(feat-dst)gen-features: $(feat-src)gen-features.c
-=09$(call quiet-command,$(HOST_CC) $(QEMU_INCLUDES) -o $@ $<,"CC","$(TARGE=
T_DIR)gen-features")
-
-clean-target:
-=09rm -f gen-features.h-timestamp
-=09rm -f gen-features.h
-=09rm -f gen-features
diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
index da695a8..2a29475 100644
--- a/target/s390x/cpu_features.h
+++ b/target/s390x/cpu_features.h
@@ -16,7 +16,7 @@
=20
 #include "qemu/bitmap.h"
 #include "cpu_features_def.h"
-#include "gen-features.h"
+#include "target/s390x/gen-features.h"
=20
 /* CPU features are announced via different ways */
 typedef enum {
diff --git a/target/s390x/cpu_models.h b/target/s390x/cpu_models.h
index 88bd01a6..74d1f87 100644
--- a/target/s390x/cpu_models.h
+++ b/target/s390x/cpu_models.h
@@ -14,7 +14,7 @@
 #define TARGET_S390X_CPU_MODELS_H
=20
 #include "cpu_features.h"
-#include "gen-features.h"
+#include "target/s390x/gen-features.h"
 #include "hw/core/cpu.h"
=20
 /* static CPU definition */
diff --git a/target/s390x/meson.build b/target/s390x/meson.build
new file mode 100644
index 0000000..980f67c
--- /dev/null
+++ b/target/s390x/meson.build
@@ -0,0 +1,8 @@
+gen_features =3D executable('gen-features', 'gen-features.c', native: true=
)
+
+gen_features_h =3D custom_target('gen-features.h',
+                               output: 'gen-features.h',
+                               capture: true,
+                               command: gen_features)
+
+specific_ss.add(gen_features_h)
--=20
1.8.3.1




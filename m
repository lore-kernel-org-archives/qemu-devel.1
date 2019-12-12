Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38C5C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:17:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADC8C21655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ic6HpTyC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC8C21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOLh-0006Mb-HU
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:17:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33085)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyI-0003Pr-MY
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyH-0006by-A3
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:34 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39673)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNyH-0006aE-06
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:33 -0500
Received: by mail-wm1-x341.google.com with SMTP id d5so2375341wmb.4
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MxvLUkJt3psVnzx/R00RwMG5IpoZlvCgNl7VnjVean0=;
 b=Ic6HpTyC1Bk6kr8kQmV4dx+nM0zlipYk0YTp2IsCiqopS1X7wCBNMk71rePq3+KOUX
 huEXCIplAVGgHtVkjKZaq5cI+UU+DWBBNhbStjhNMulZfv73KMHkSxfDzylqdXzdmy3z
 O7LMojzOGZEh8Ahu+ITi4pAxMo9V7P176CJYmzDOi/co5r3WFEkJlBy6lIvhIFBInAeQ
 4fJaQhgFrcIYcH2fcLKTFOQ/YFwsXqRdFvz7EVXtFb+ZdKdFA7fzIOCURig12t0RRRKk
 ojbdU/1cL9UoITunshiAFOCWNoImCVkHvuvdr1jGQ0bfAXnluabrzBxnPtXxcqcN+2k8
 riNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=MxvLUkJt3psVnzx/R00RwMG5IpoZlvCgNl7VnjVean0=;
 b=g3tGYYYWN31oLFiu6/8hGHfaSXTCog70bywpZ/zqCvm1fTxm1pmX81sNkiFVtgi/qX
 imEl9rHs9K+o8YgJH2A7O60jrRG87RHHeJcu9ZYQsOvB75cyS2CgS4idtIVfa+i7hYqr
 apzHjOcfLKL5HoFOnwBb4pgc8NvzHcHWVdCFPkmrTuZmt3g+5D3w8yAKZPYO6n2CFjzi
 XrBUFOfl65/hqw5VrhbWO/x4PPkkey7F5H4cAUhUtauiRr0iyxSgbXTGoMohhIP62F9o
 KtwJBk0yIMGlIV7Vxj8Eqk1Hw0u0ju/7ohJSYYSehgLI7ig+cHy7fAa41twSosbbSOkx
 19Yw==
X-Gm-Message-State: APjAAAXT7tYLU5d0dxNzXIoGSLEI4bytJkGVhT1evy5scXMVkXIBvt85
 OfmPxfLoZDB0PyusTIKJdobJBFRx
X-Google-Smtp-Source: APXvYqw1V5BSuY3riTm1jvtDjLVXpvBxk29SJpLis1bF71S9hO87+22zxXOmMtW2Vm9McRDmimUZAg==
X-Received: by 2002:a05:600c:257:: with SMTP id
 23mr6427935wmj.123.1576155211637; 
 Thu, 12 Dec 2019 04:53:31 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:30 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 034/132] meson: convert qom directory to Meson
Date: Thu, 12 Dec 2019 13:51:18 +0100
Message-Id: <1576155176-2464-35-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile               |  2 +-
 Makefile.objs          |  4 ++--
 Makefile.target        |  3 ++-
 meson.build            |  1 +
 qom/Makefile.objs      |  3 ---
 qom/meson.build        | 15 +++++++++++++++
 tests/Makefile.include |  2 +-
 7 files changed, 22 insertions(+), 8 deletions(-)
 create mode 100644 qom/meson.build

diff --git a/Makefile b/Makefile
index b880265..9e9b2cf 100644
--- a/Makefile
+++ b/Makefile
@@ -202,7 +202,6 @@ dummy := $(call unnest-vars,, \
                 block-obj-y \
                 block-obj-m \
                 crypto-obj-y \
-                qom-obj-y \
                 io-obj-y \
                 common-obj-y \
                 common-obj-m)
@@ -222,6 +221,7 @@ $(SOFTMMU_ALL_RULES): $(block-obj-y)
 $(SOFTMMU_ALL_RULES): $(chardev-obj-y)
 $(SOFTMMU_ALL_RULES): $(crypto-obj-y)
 $(SOFTMMU_ALL_RULES): $(io-obj-y)
+$(SOFTMMU_ALL_RULES): $(qom-obj-y)
 $(SOFTMMU_ALL_RULES): config-all-devices.mak
 
 .PHONY: $(TARGET_DIRS_RULES)
diff --git a/Makefile.objs b/Makefile.objs
index 38e3604..b695319 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -24,9 +24,9 @@ block-obj-m = block/
 crypto-obj-y = crypto/
 
 #######################################################################
-# qom-obj-y is code used by both qemu system emulation and qemu-img
+# libraries built entirely from meson
 
-qom-obj-y = qom/
+qom-obj-y = qom/libqom.fa
 
 #######################################################################
 # io-obj-y is code used by both qemu system emulation and qemu-img
diff --git a/Makefile.target b/Makefile.target
index 1f19d68..df3b14a 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -176,13 +176,14 @@ dummy := $(call unnest-vars,,obj-y)
 all-obj-y := $(obj-y)
 
 include $(SRC_PATH)/Makefile.objs
+dummy := $(call fix-paths,../,, \
+              qom-obj-y)
 dummy := $(call unnest-vars,.., \
                authz-obj-y \
                block-obj-y \
                block-obj-m \
                chardev-obj-y \
                crypto-obj-y \
-               qom-obj-y \
                io-obj-y \
                common-obj-y \
                common-obj-m)
diff --git a/meson.build b/meson.build
index 00c0767..36094fe 100644
--- a/meson.build
+++ b/meson.build
@@ -271,6 +271,7 @@ libqemuutil = static_library('qemuutil',
 qemuutil = declare_dependency(link_with: libqemuutil,
                               sources: version_res)
 
+subdir('qom')
 subdir('fsdev')
 
 # Other build targets
diff --git a/qom/Makefile.objs b/qom/Makefile.objs
index f9d7735..fc1248e 100644
--- a/qom/Makefile.objs
+++ b/qom/Makefile.objs
@@ -1,4 +1 @@
-qom-obj-y = object.o container.o qom-qobject.o
-qom-obj-y += object_interfaces.o
-
 common-obj-$(CONFIG_SOFTMMU) += qom-hmp-cmds.o qom-qmp-cmds.o
diff --git a/qom/meson.build b/qom/meson.build
new file mode 100644
index 0000000..3c41ed3
--- /dev/null
+++ b/qom/meson.build
@@ -0,0 +1,15 @@
+qom_ss = ss.source_set()
+qom_ss.add(files(
+  'container.c',
+  'object.c',
+  'object_interfaces.c',
+  'qom-qobject.c',
+))
+
+qom_ss = qom_ss.apply(config_host, strict: false)
+libqom = static_library('qom', qom_ss.sources(),
+                        dependencies: [qom_ss.dependencies()],
+                        link_with: [libqemuutil],
+                        name_suffix: 'fa')
+
+qom = declare_dependency(link_whole: libqom)
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 9fd6a48..659f087 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -498,7 +498,7 @@ QEMU_CFLAGS += -I$(SRC_PATH)/tests
 
 # Deps that are common to various different sets of tests below
 test-util-obj-y = libqemuutil.a
-test-qom-obj-y = $(qom-obj-y) $(test-util-obj-y)
+test-qom-obj-y = qom/libqom.fa $(test-util-obj-y)
 test-qapi-obj-y = tests/test-qapi-types.o \
 	tests/include/test-qapi-types-sub-module.o \
 	tests/test-qapi-types-sub-sub-module.o \
-- 
1.8.3.1




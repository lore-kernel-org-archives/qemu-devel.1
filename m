Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84C9C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:17:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74242205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyZ/Nyjt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74242205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gtU-00010D-Mv
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHc-0005M0-DS
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:44 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41621)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHa-0006Fn-Lm
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:44 -0400
Received: by mail-wr1-x443.google.com with SMTP id r2so15269262wrs.8
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fLQDRD2mwQArCUub7+cO8guKcXQpbRORxQdypC9xSvQ=;
 b=VyZ/NyjtdT2xpMVT3eoqy3Bmg3wmdFW3tmQhxFbPlj1oWYSWZGcTFUGcrtBGw5AY5M
 rwg2fLA6u8ACLXlJ+Xjdul0w4FfE9Kd6m8GvB7mTFgBMN8R0oORhKE0xZOGXipgKDQoQ
 cZ9b88uUXSwxhOAfOJOBMWktlRV3KMOkW45iExtMoAxzNeXvUKCJnO3Rfzzi34YyCqX2
 QIMN7rS+hHBUsue4rewT/loz+vDDQcrHYXdNcmfDuMH9jw6UX9TXnm0Yl47hx/Rix2VV
 yHqXkcVrEVVwVx8c2CHJ3aVrAGnh4SEiYdH99+42CPjnsJdWn4oG+wifN8n3VeirhX31
 c5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=fLQDRD2mwQArCUub7+cO8guKcXQpbRORxQdypC9xSvQ=;
 b=S/gEhDX6OiKjFE99WdDcWJWrfLklCOJG29IT2KmR6nvGUGXYL5Z6ME6BCsy/2ObTaJ
 LluWjMBti6gv5D1Y9US85Wg52iivt3c1GqoGBVfc931Hu+uE+pvqG4aleapOslIsNvf/
 1F9zdlLsIzNc6yOV2htg/eSZpMiO3874uOj/UwnhSPzAtUbRFLAZB8LJKYsLHoN/Lqjs
 p8wBRiqafsZCbZW4nmUE1zs00ZeLS5paQjZAchJObM8Un8iIU89Oi2Cqqt29EAbxKE3Z
 yTY/Uz78CgshwYVAu6E7KcorHxo8gca0kbn0MaaTf/UXRGMOLi6gUlCZd1pO+jieNAuY
 OnGA==
X-Gm-Message-State: AOAM533XJ/L2iJBYN+X+iVbvQckkM3g6kOy3Y8pQbP1ZYbapanMgqvSA
 yA6gby/9sGIIwOIxCyv7TRbkAhFy06A=
X-Google-Smtp-Source: ABdhPJwQ/CmzJ3BPg7tkhrDp9tHJV50I5i9u/u/j1YZLZ6211kP7HxTKB/9mHvFiua93rQXYahqH3g==
X-Received: by 2002:adf:c401:: with SMTP id v1mr15102930wrf.379.1597675121024; 
 Mon, 17 Aug 2020 07:38:41 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.40 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 076/150] meson: convert qemu-storage-daemon
Date: Mon, 17 Aug 2020 16:36:09 +0200
Message-Id: <20200817143723.343284-77-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                                            |  5 -----
 Makefile.objs                                       | 10 ----------
 meson.build                                         |  2 +-
 storage-daemon/Makefile.objs                        |  3 ---
 storage-daemon/meson.build                          | 13 +++++++++++++
 storage-daemon/qapi/meson.build                     |  5 +----
 .../qemu-storage-daemon.c                           |  0
 7 files changed, 15 insertions(+), 23 deletions(-)
 delete mode 100644 storage-daemon/Makefile.objs
 rename qemu-storage-daemon.c => storage-daemon/qemu-storage-daemon.c (100%)

diff --git a/Makefile b/Makefile
index 135175c5ef..a523898da0 100644
--- a/Makefile
+++ b/Makefile
@@ -168,8 +168,6 @@ include $(SRC_PATH)/Makefile.objs
 endif
 
 dummy := $(call unnest-vars,, \
-                storage-daemon-obj-y \
-                storage-daemon-obj-m \
                 common-obj-y \
                 common-obj-m)
 
@@ -185,7 +183,6 @@ TARGET_DIRS_RULES := $(foreach t, all fuzz clean install, $(addsuffix /$(t), $(T
 SOFTMMU_ALL_RULES=$(filter %-softmmu/all, $(TARGET_DIRS_RULES))
 $(SOFTMMU_ALL_RULES): $(authz-obj-y)
 $(SOFTMMU_ALL_RULES): $(block-obj-y)
-$(SOFTMMU_ALL_RULES): $(storage-daemon-obj-y)
 $(SOFTMMU_ALL_RULES): $(chardev-obj-y)
 $(SOFTMMU_ALL_RULES): $(crypto-obj-y)
 $(SOFTMMU_ALL_RULES): $(io-obj-y)
@@ -276,8 +273,6 @@ Makefile: $(version-obj-y)
 
 COMMON_LDADDS = libqemuutil.a
 
-qemu-storage-daemon$(EXESUF): qemu-storage-daemon.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(chardev-obj-y) $(io-obj-y) $(qom-obj-y) $(storage-daemon-obj-y) $(COMMON_LDADDS)
-
 clean: recurse-clean ninja-clean clean-ctlist
 	-test -f ninjatool && ./ninjatool $(if $(V),-v,) -t clean
 # avoid old build problems by removing potentially incorrect old files
diff --git a/Makefile.objs b/Makefile.objs
index d7826c1e5c..e304d92954 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -33,16 +33,6 @@ io-obj-y = io/libio.fa
 
 endif # CONFIG_SOFTMMU or CONFIG_TOOLS
 
-#######################################################################
-# storage-daemon-obj-y is code used by qemu-storage-daemon (these objects are
-# used for system emulation, too, but specified separately there)
-
-storage-daemon-obj-y = block/ qapi/ qom/ storage-daemon/
-storage-daemon-obj-y += blockdev.o blockdev-nbd.o iothread.o job-qmp.o
-storage-daemon-obj-$(CONFIG_WIN32) += os-win32.o
-storage-daemon-obj-$(CONFIG_POSIX) += os-posix.o
-storage-daemon-obj-y += libqmp.fa
-
 ######################################################################
 # Target independent part of system emulation. The long term path is to
 # suppress *all* target specific code in case of system emulation, i.e. a
diff --git a/meson.build b/meson.build
index d7d10cbbaf..cae4b2dce2 100644
--- a/meson.build
+++ b/meson.build
@@ -586,7 +586,6 @@ subdir('util')
 subdir('qom')
 subdir('authz')
 subdir('crypto')
-subdir('storage-daemon')
 subdir('ui')
 
 
@@ -796,6 +795,7 @@ if have_tools
                dependencies: [block, qemuutil], install: true)
   endif
 
+  subdir('storage-daemon')
   subdir('contrib/rdmacm-mux')
   subdir('contrib/elf2dmp')
 
diff --git a/storage-daemon/Makefile.objs b/storage-daemon/Makefile.objs
deleted file mode 100644
index 41c0d02178..0000000000
--- a/storage-daemon/Makefile.objs
+++ /dev/null
@@ -1,3 +0,0 @@
-storage-daemon-obj-y = qapi/libqsd-qapi.fa
-
-qemu-storage-daemon.o: storage-daemon/qapi/qapi-commands.h storage-daemon/qapi/qapi-init-commands.h
diff --git a/storage-daemon/meson.build b/storage-daemon/meson.build
index 35f8949924..0409acc3f5 100644
--- a/storage-daemon/meson.build
+++ b/storage-daemon/meson.build
@@ -1 +1,14 @@
+qsd_ss = ss.source_set()
+qsd_ss.add(files('qemu-storage-daemon.c'))
+qsd_ss.add(block, chardev, qmp, qom, qemuutil)
+qsd_ss.add_all(blockdev_ss)
+
 subdir('qapi')
+
+if have_tools
+  qsd_ss = qsd_ss.apply(config_host, strict: false)
+  executable('qemu-storage-daemon',
+             qsd_ss.sources(),
+             dependencies: qsd_ss.dependencies(),
+             install: true)
+endif
diff --git a/storage-daemon/qapi/meson.build b/storage-daemon/qapi/meson.build
index 7a2b041247..cea618bec0 100644
--- a/storage-daemon/qapi/meson.build
+++ b/storage-daemon/qapi/meson.build
@@ -4,7 +4,4 @@ qsd_qapi_files = custom_target('QAPI files for qemu-storage-daemon',
                                command: [ qapi_gen, '-o', 'storage-daemon/qapi', '@INPUT@' ],
                                depend_files: [ qapi_inputs, qapi_gen_depends ])
 
-static_library('qsd-qapi',
-               qsd_qapi_files.to_list(),
-               name_suffix: 'fa',
-               build_by_default: false)
+qsd_ss.add(qsd_qapi_files.to_list())
diff --git a/qemu-storage-daemon.c b/storage-daemon/qemu-storage-daemon.c
similarity index 100%
rename from qemu-storage-daemon.c
rename to storage-daemon/qemu-storage-daemon.c
-- 
2.26.2




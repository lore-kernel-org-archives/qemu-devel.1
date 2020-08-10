Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD736C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:23:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97D0520825
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MRhY1Xj3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D0520825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5BWH-0007E4-Pv
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 13:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BJJ-00071K-J0
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:10:09 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38859
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BJH-0002nt-JW
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597079406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tzD9lzUwpK49IwG4izm5KJPzN76WJ403LiQHde+34hE=;
 b=MRhY1Xj3ZMwe61wa9RsHq7PqhUd5qxhmby2QmRUxHQQnVzqYfPCUEw2W0PEBIrAkpaLTqS
 z3SevCMCZjB55+tIMOs5RybgkjfRqntHKG0Y+ZseZzOohIv9aEwx9yBZz9dJ/Pm920RmDr
 jblqiI0A2QRKNFlfkd2zvcrtYC+XKZI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-mMSa29XCONOGI0QwiQXqlA-1; Mon, 10 Aug 2020 13:10:05 -0400
X-MC-Unique: mMSa29XCONOGI0QwiQXqlA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B4AA8015CE
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:10:04 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2900F87D6F;
 Mon, 10 Aug 2020 17:09:58 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 032/147] contrib/vhost-user-input: convert to meson
Date: Mon, 10 Aug 2020 19:07:10 +0200
Message-Id: <1597079345-42801-33-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 04:13:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                               | 11 -----------
 Makefile.objs                          |  1 -
 contrib/vhost-user-input/Makefile.objs |  1 -
 contrib/vhost-user-input/meson.build   |  5 +++++
 meson.build                            |  1 +
 5 files changed, 6 insertions(+), 13 deletions(-)
 delete mode 100644 contrib/vhost-user-input/Makefile.objs
 create mode 100644 contrib/vhost-user-input/meson.build

diff --git a/Makefile b/Makefile
index 404cab7..dd7b99e 100644
--- a/Makefile
+++ b/Makefile
@@ -295,7 +295,6 @@ dummy := $(call unnest-vars,, \
                 elf2dmp-obj-y \
                 ivshmem-client-obj-y \
                 ivshmem-server-obj-y \
-                vhost-user-input-obj-y \
                 vhost-user-gpu-obj-y \
                 qga-vss-dll-obj-y \
                 block-obj-y \
@@ -519,16 +518,6 @@ endif
 vhost-user-gpu$(EXESUF): $(vhost-user-gpu-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
 	$(call LINK, $^)
 
-ifdef CONFIG_VHOST_USER_INPUT
-ifdef CONFIG_LINUX
-vhost-user-input$(EXESUF): $(vhost-user-input-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
-	$(call LINK, $^)
-
-# build by default, do not install
-all: vhost-user-input$(EXESUF)
-endif
-endif
-
 module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-host.mak
 	$(call quiet-command,$(PYTHON) $< $@ \
 	$(addprefix $(SRC_PATH)/,$(patsubst %.mo,%.c,$(block-obj-m))), \
diff --git a/Makefile.objs b/Makefile.objs
index 0f80b63..0922c3ed 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -106,7 +106,6 @@ qga-vss-dll-obj-y = qga/
 elf2dmp-obj-y = contrib/elf2dmp/
 ivshmem-client-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-client/
 ivshmem-server-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-server/
-vhost-user-input-obj-y = contrib/vhost-user-input/
 vhost-user-gpu-obj-y = contrib/vhost-user-gpu/
 
 ######################################################################
diff --git a/contrib/vhost-user-input/Makefile.objs b/contrib/vhost-user-input/Makefile.objs
deleted file mode 100644
index b1fad90..0000000
--- a/contrib/vhost-user-input/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-vhost-user-input-obj-y = main.o
diff --git a/contrib/vhost-user-input/meson.build b/contrib/vhost-user-input/meson.build
new file mode 100644
index 0000000..1eeb132
--- /dev/null
+++ b/contrib/vhost-user-input/meson.build
@@ -0,0 +1,5 @@
+executable('vhost-user-input', files('main.c'),
+           link_with: libvhost_user,
+           dependencies: qemuutil,
+           build_by_default: targetos == 'linux',
+           install: false)
diff --git a/meson.build b/meson.build
index 1d55980..80966cc 100644
--- a/meson.build
+++ b/meson.build
@@ -261,6 +261,7 @@ if have_tools
   if 'CONFIG_VHOST_USER' in config_host
     subdir('contrib/libvhost-user')
     subdir('contrib/vhost-user-blk')
+    subdir('contrib/vhost-user-input')
     subdir('contrib/vhost-user-scsi')
   endif
 endif
-- 
1.8.3.1




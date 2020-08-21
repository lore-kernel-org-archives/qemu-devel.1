Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFA9C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:36:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69FE720738
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SBtvafUl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69FE720738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k94P8-0007i4-Jn
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 06:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94DN-0001K7-46
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:24:05 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54383
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94DH-0001Uu-LQ
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598005439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EkStiprP9QlyiuuzIEPYnmmLwOOWImHQ31IHIoFQU0Q=;
 b=SBtvafUlcexJ0aLx91FHQGO6qnR+YNX7IpIFeKfFUuBE+4WqXWz9KOp/WJ+WeVjiHQwBNN
 ebr6wjHzoCgDV/Zxvhcf6NJQeW9F6/tsjsULjeit+iT1+gZhSnOuBOdKMJ3q8z+cq++JoJ
 OWZRcIZOaPpsTYpWwVFVZHrqGc2WpnI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-olbTF3UROG-LIVepw4uOzg-1; Fri, 21 Aug 2020 06:23:57 -0400
X-MC-Unique: olbTF3UROG-LIVepw4uOzg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E9698797D4
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 10:23:56 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1B8967AECF
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 10:23:56 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v8 029/152] contrib/libvhost-user: convert to Meson
Date: Fri, 21 Aug 2020 06:21:26 -0400
Message-Id: <20200821102329.29777-30-pbonzini@redhat.com>
In-Reply-To: <20200821102329.29777-1-pbonzini@redhat.com>
References: <20200821102329.29777-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 01:00:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

Since libqemuutil.a has been converted to Meson, the conversion is
straightforward.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                            | 16 +++++-----------
 Makefile.objs                       |  1 -
 contrib/libvhost-user/Makefile.objs |  1 -
 contrib/libvhost-user/meson.build   |  3 +++
 meson.build                         |  8 ++++++++
 5 files changed, 16 insertions(+), 13 deletions(-)
 delete mode 100644 contrib/libvhost-user/Makefile.objs
 create mode 100644 contrib/libvhost-user/meson.build

diff --git a/Makefile b/Makefile
index 5731d739f1..78d3a78e97 100644
--- a/Makefile
+++ b/Makefile
@@ -318,7 +318,6 @@ dummy := $(call unnest-vars,, \
                 ivshmem-server-obj-y \
                 virtiofsd-obj-y \
                 rdmacm-mux-obj-y \
-                libvhost-user-obj-y \
                 vhost-user-scsi-obj-y \
                 vhost-user-blk-obj-y \
                 vhost-user-input-obj-y \
@@ -443,11 +442,6 @@ $(BUILD_DIR)/version.o: $(SRC_PATH)/version.rc config-host.h
 
 Makefile: $(version-obj-y)
 
-######################################################################
-# Build libraries
-
-libvhost-user.a: $(libvhost-user-obj-y)
-
 ######################################################################
 
 COMMON_LDADDS = libqemuutil.a
@@ -546,9 +540,9 @@ ivshmem-client$(EXESUF): $(ivshmem-client-obj-y) $(COMMON_LDADDS)
 ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
 	$(call LINK, $^)
 endif
-vhost-user-scsi$(EXESUF): $(vhost-user-scsi-obj-y) libvhost-user.a $(COMMON_LDADDS)
+vhost-user-scsi$(EXESUF): $(vhost-user-scsi-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
 	$(call LINK, $^)
-vhost-user-blk$(EXESUF): $(vhost-user-blk-obj-y) libvhost-user.a $(COMMON_LDADDS)
+vhost-user-blk$(EXESUF): $(vhost-user-blk-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
 	$(call LINK, $^)
 
 rdmacm-mux$(EXESUF): LIBS += "-libumad"
@@ -557,16 +551,16 @@ rdmacm-mux$(EXESUF): $(rdmacm-mux-obj-y) $(COMMON_LDADDS)
 
 # relies on Linux-specific syscalls
 ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyy)
-virtiofsd$(EXESUF): $(virtiofsd-obj-y) libvhost-user.a $(COMMON_LDADDS)
+virtiofsd$(EXESUF): $(virtiofsd-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
 	$(call LINK, $^)
 endif
 
-vhost-user-gpu$(EXESUF): $(vhost-user-gpu-obj-y) libvhost-user.a $(COMMON_LDADDS)
+vhost-user-gpu$(EXESUF): $(vhost-user-gpu-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
 	$(call LINK, $^)
 
 ifdef CONFIG_VHOST_USER_INPUT
 ifdef CONFIG_LINUX
-vhost-user-input$(EXESUF): $(vhost-user-input-obj-y) libvhost-user.a $(COMMON_LDADDS)
+vhost-user-input$(EXESUF): $(vhost-user-input-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
 	$(call LINK, $^)
 
 # build by default, do not install
diff --git a/Makefile.objs b/Makefile.objs
index e5c9077517..9489864967 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -106,7 +106,6 @@ qga-vss-dll-obj-y = qga/
 elf2dmp-obj-y = contrib/elf2dmp/
 ivshmem-client-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-client/
 ivshmem-server-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-server/
-libvhost-user-obj-y = contrib/libvhost-user/
 vhost-user-scsi.o-cflags := $(LIBISCSI_CFLAGS)
 vhost-user-scsi.o-libs := $(LIBISCSI_LIBS)
 vhost-user-scsi-obj-y = contrib/vhost-user-scsi/
diff --git a/contrib/libvhost-user/Makefile.objs b/contrib/libvhost-user/Makefile.objs
deleted file mode 100644
index ef3778edd4..0000000000
--- a/contrib/libvhost-user/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-libvhost-user-obj-y += libvhost-user.o libvhost-user-glib.o
diff --git a/contrib/libvhost-user/meson.build b/contrib/libvhost-user/meson.build
new file mode 100644
index 0000000000..e68dd1a581
--- /dev/null
+++ b/contrib/libvhost-user/meson.build
@@ -0,0 +1,3 @@
+libvhost_user = static_library('vhost-user',
+                               files('libvhost-user.c', 'libvhost-user-glib.c'),
+                               build_by_default: false)
diff --git a/meson.build b/meson.build
index feb3c8a30c..00f17ef36f 100644
--- a/meson.build
+++ b/meson.build
@@ -243,6 +243,14 @@ libqemuutil = static_library('qemuutil',
 qemuutil = declare_dependency(link_with: libqemuutil,
                               sources: genh + version_res)
 
+# Other build targets
+
+if have_tools
+  if 'CONFIG_VHOST_USER' in config_host
+    subdir('contrib/libvhost-user')
+  endif
+endif
+
 summary_info = {}
 summary_info += {'Install prefix':    config_host['prefix']}
 summary_info += {'BIOS directory':    config_host['qemu_datadir']}
-- 
2.26.2




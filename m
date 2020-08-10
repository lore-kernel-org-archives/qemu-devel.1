Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63262C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:30:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A53A2065C
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tpg171Sq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A53A2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5BdJ-0007PH-8f
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 13:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BJW-0007aS-Jq
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:10:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33691
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BJU-0002q5-Gp
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:10:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597079419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a3NoesOoJDQ5dh4y5TMmirCWk9vEI5OB1H6kTrUeO4g=;
 b=Tpg171SqA4mAZHk5TLtJBRSfeZOXkoUE5RXXlRmnWmZWUxFBtQloV0f5AAHHVK0vHPOcGO
 EyUA6RCD5yUZvBCY0Vj7N6j4px3eTipnDDhBJYtHz+IP26Vh5D88vUNXISTzyMcLnKBLkZ
 L3xS2G2GjSUuBTzTNzqoa2g8eWJ9rhI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-g37tO7PJNCOAWmDMNTgwEQ-1; Mon, 10 Aug 2020 13:10:17 -0400
X-MC-Unique: g37tO7PJNCOAWmDMNTgwEQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D002106B25A
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:10:16 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7A55987D6B;
 Mon, 10 Aug 2020 17:10:15 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 041/147] meson: add qemu-keymap
Date: Mon, 10 Aug 2020 19:07:19 +0200
Message-Id: <1597079345-42801-42-git-send-email-pbonzini@redhat.com>
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
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 03:29:25
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile    |  5 -----
 configure   |  4 +---
 meson.build | 10 ++++++++++
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index b4f486b..0a99cb9 100644
--- a/Makefile
+++ b/Makefile
@@ -413,8 +413,6 @@ qemu-nbd$(EXESUF): qemu-nbd.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io
 qemu-io$(EXESUF): qemu-io.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 qemu-storage-daemon$(EXESUF): qemu-storage-daemon.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(chardev-obj-y) $(io-obj-y) $(qom-obj-y) $(storage-daemon-obj-y) $(COMMON_LDADDS)
 
-qemu-keymap$(EXESUF): qemu-keymap.o ui/input-keymap.o $(COMMON_LDADDS)
-
 qemu-edid$(EXESUF): qemu-edid.o hw/display/edid-generate.o $(COMMON_LDADDS)
 
 fsdev/virtfs-proxy-helper$(EXESUF): fsdev/virtfs-proxy-helper.o fsdev/9p-marshal.o fsdev/9p-iov-marshal.o $(COMMON_LDADDS)
@@ -427,9 +425,6 @@ endif
 qemu-img-cmds.h: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxtool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$@")
 
-qemu-keymap$(EXESUF): LIBS += $(XKBCOMMON_LIBS)
-qemu-keymap$(EXESUF): QEMU_CFLAGS += $(XKBCOMMON_CFLAGS)
-
 module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-host.mak
 	$(call quiet-command,$(PYTHON) $< $@ \
 	$(addprefix $(SRC_PATH)/,$(patsubst %.mo,%.c,$(block-obj-m))), \
diff --git a/configure b/configure
index ae6929e..b786483 100755
--- a/configure
+++ b/configure
@@ -6680,9 +6680,6 @@ if test "$softmmu" = yes ; then
     fi
     mpath=no
   fi
-  if test "$xkbcommon" = "yes"; then
-    tools="qemu-keymap\$(EXESUF) $tools"
-  fi
 fi
 
 # Probe for guest agent support/options
@@ -6999,6 +6996,7 @@ if test "$vnc_png" = "yes" ; then
   echo "CONFIG_VNC_PNG=y" >> $config_host_mak
 fi
 if test "$xkbcommon" = "yes" ; then
+  echo "CONFIG_XKBCOMMON=y" >> $config_host_mak
   echo "XKBCOMMON_CFLAGS=$xkbcommon_cflags" >> $config_host_mak
   echo "XKBCOMMON_LIBS=$xkbcommon_libs" >> $config_host_mak
 fi
diff --git a/meson.build b/meson.build
index 7d07aa7..e91ebc3 100644
--- a/meson.build
+++ b/meson.build
@@ -90,6 +90,11 @@ libcap_ng = not_found
 if 'CONFIG_LIBCAP_NG' in config_host
   libcap_ng = declare_dependency(link_args: config_host['LIBCAP_NG_LIBS'].split())
 endif
+xkbcommon = not_found
+if 'CONFIG_XKBCOMMON' in config_host
+  xkbcommon = declare_dependency(compile_args: config_host['XKBCOMMON_CFLAGS'].split(),
+                                 link_args: config_host['XKBCOMMON_LIBS'].split())
+endif
 rt = cc.find_library('rt', required: false)
 libiscsi = not_found
 if 'CONFIG_LIBISCSI' in config_host
@@ -284,6 +289,11 @@ if have_tools
   subdir('contrib/rdmacm-mux')
   subdir('contrib/elf2dmp')
 
+  if 'CONFIG_XKBCOMMON' in config_host
+    executable('qemu-keymap', files('qemu-keymap.c', 'ui/input-keymap.c'),
+               dependencies: [qemuutil, xkbcommon], install: true)
+  endif
+
   if 'CONFIG_VHOST_USER' in config_host
     subdir('contrib/libvhost-user')
     subdir('contrib/vhost-user-blk')
-- 
1.8.3.1




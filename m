Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4C6C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 13:08:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44CB320707
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 13:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OnpI3XXp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44CB320707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAv9u-0005wx-HD
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 09:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kAv8i-0004RS-9N
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 09:06:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32543
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kAv8g-0002Ee-Lk
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 09:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598447213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UxFM8erN8k/+Udtv4n/cFZI1W9WScbQ6ERemaUaVSg8=;
 b=OnpI3XXpNcrColnn5oHIc4Ya0RqUwF71m6RIakMhuZcc3ZQhQaXZT1YTzuDgMjOHA2rLcs
 jY4tGh58DQn1nIpmZ8dMcAMsvI30ctPVdrKA6NZDTF0aLvYkHUvCCZvjq0Nex3G7bh+j/9
 eEN3D5n4kB/q+8nZmmB9LwToZAoFqfg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-tXDK1_1PMB6E1UqS6Hf29g-1; Wed, 26 Aug 2020 09:06:51 -0400
X-MC-Unique: tXDK1_1PMB6E1UqS6Hf29g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBFEF10ABDBC
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 13:06:50 +0000 (UTC)
Received: from localhost (unknown [10.36.110.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7AFF65D9E4;
 Wed, 26 Aug 2020 13:06:46 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH 3/6] meson: install icons
Date: Wed, 26 Aug 2020 17:06:19 +0400
Message-Id: <20200826130622.553318-4-marcandre.lureau@redhat.com>
In-Reply-To: <20200826130622.553318-1-marcandre.lureau@redhat.com>
References: <20200826130622.553318-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=marcandre.lureau@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 03:56:58
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
Cc: pbonzini@redhat.com, berrange@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 Makefile             | 12 ------------
 ui/icons/meson.build | 13 +++++++++++++
 ui/meson.build       |  1 +
 3 files changed, 14 insertions(+), 12 deletions(-)
 create mode 100644 ui/icons/meson.build

diff --git a/Makefile b/Makefile
index 058cf87f54..d1a3cd77a5 100644
--- a/Makefile
+++ b/Makefile
@@ -239,22 +239,10 @@ ifeq ($(CONFIG_GUEST_AGENT),y)
 endif
 endif
 
-ICON_SIZES=16x16 24x24 32x32 48x48 64x64 128x128 256x256 512x512
 
 # Needed by "meson install"
 export DESTDIR
 install: all install-datadir install-localstatedir
-	for s in $(ICON_SIZES); do \
-		mkdir -p "$(DESTDIR)$(qemu_icondir)/hicolor/$${s}/apps"; \
-		$(INSTALL_DATA) $(SRC_PATH)/ui/icons/qemu_$${s}.png \
-			"$(DESTDIR)$(qemu_icondir)/hicolor/$${s}/apps/qemu.png"; \
-	done; \
-	mkdir -p "$(DESTDIR)$(qemu_icondir)/hicolor/32x32/apps"; \
-	$(INSTALL_DATA) $(SRC_PATH)/ui/icons/qemu_32x32.bmp \
-		"$(DESTDIR)$(qemu_icondir)/hicolor/32x32/apps/qemu.bmp"; \
-	mkdir -p "$(DESTDIR)$(qemu_icondir)/hicolor/scalable/apps"; \
-	$(INSTALL_DATA) $(SRC_PATH)/ui/icons/qemu.svg \
-		"$(DESTDIR)$(qemu_icondir)/hicolor/scalable/apps/qemu.svg"
 	mkdir -p "$(DESTDIR)$(qemu_desktopdir)"
 	$(INSTALL_DATA) $(SRC_PATH)/ui/qemu.desktop \
 		"$(DESTDIR)$(qemu_desktopdir)/qemu.desktop"
diff --git a/ui/icons/meson.build b/ui/icons/meson.build
new file mode 100644
index 0000000000..b6e21f6ad7
--- /dev/null
+++ b/ui/icons/meson.build
@@ -0,0 +1,13 @@
+foreach s: [16, 24, 32, 48, 64, 128, 256, 512]
+  s = '@0@x@0@'.format(s.to_string())
+  install_data('qemu_@0@.png'.format(s),
+               rename: 'qemu.png',
+               install_dir: config_host['qemu_icondir'] / 'hicolor' / s / 'apps')
+endforeach
+
+install_data('qemu_32x32.bmp',
+             rename: 'qemu.bmp',
+             install_dir: config_host['qemu_icondir'] / 'hicolor' / '32x32' / 'apps')
+
+install_data('qemu.svg',
+             install_dir: config_host['qemu_icondir'] / 'hicolor' / 'scalable' / 'apps')
diff --git a/ui/meson.build b/ui/meson.build
index 018c5698bf..0b937e4455 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -110,5 +110,6 @@ if have_system or xkbcommon.found()
 endif
 
 subdir('shader')
+subdir('icons')
 
 modules += {'ui': ui_modules}
-- 
2.26.2



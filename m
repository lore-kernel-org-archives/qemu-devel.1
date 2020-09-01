Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9B7C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:14:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB801206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D8vvnGYe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB801206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD2Mr-0008G1-Pp
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 05:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kD2KN-0003G8-4O
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:11:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38899)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kD2KL-0006pS-8Y
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598951500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ZzSRczycqmp9PBXMjkOtQBBLOIhayetEpr+VUncjTU=;
 b=D8vvnGYeGcutPPhOOBAP2SSnkUcrOsnrl9OD27kqzRHLIVU8MhG02jxi4NO+twlP9GPx9N
 BfTnWFkY0qk1fPBNjfU10sAgiFRm0eS6AQLfKVEpz61r8zl3UeoIYSHDUJ2laXYhH5gK9x
 it7V4hQEdlX63v8+iQ+tPkSuwYhdiho=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-cPki1YIXNVmtUo8yV6QQ-w-1; Tue, 01 Sep 2020 05:11:39 -0400
X-MC-Unique: cPki1YIXNVmtUo8yV6QQ-w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A6681074641
 for <qemu-devel@nongnu.org>; Tue,  1 Sep 2020 09:11:38 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DA29A9F54;
 Tue,  1 Sep 2020 09:11:37 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/24] meson: install icons
Date: Tue,  1 Sep 2020 05:11:14 -0400
Message-Id: <20200901091132.29601-7-pbonzini@redhat.com>
In-Reply-To: <20200901091132.29601-1-pbonzini@redhat.com>
References: <20200901091132.29601-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 23:17:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200826130622.553318-4-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
index 962e776569..dddffc9a7a 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -112,5 +112,6 @@ if have_system or xkbcommon.found()
 endif
 
 subdir('shader')
+subdir('icons')
 
 modules += {'ui': ui_modules}
-- 
2.26.2




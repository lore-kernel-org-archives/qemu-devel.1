Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA46C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:24:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8ACF206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e63e8n98"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8ACF206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD2WK-0000Rr-RP
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 05:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kD2KU-0003a8-E3
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:11:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22447)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kD2KS-0006rc-KM
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:11:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598951507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X/Fax2FNyxBxy5u0eoIHCfhXtcAhzrgVnFOsa7MwnFk=;
 b=e63e8n98YGp1Y1TgD5AHFbpqOHGO8P24Q1cuu0xZRd8WzP61PgpSIdKk05qr+eEO0lT3pk
 BEVU2ZfSUqyjnV9WK3LrWdZSVHiGmO6qBjEmqd+BWTeG7WO+wo8bUjANsL+cs2Gn5fl/05
 sIjQJLKhxHSr0mSBqc3gtUJsZbi9Ahk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-FyLfm9tSOYCxLTWUuo9OZw-1; Tue, 01 Sep 2020 05:11:46 -0400
X-MC-Unique: FyLfm9tSOYCxLTWUuo9OZw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74C871074641;
 Tue,  1 Sep 2020 09:11:45 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F2A6B78B40;
 Tue,  1 Sep 2020 09:11:44 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/24] meson: add pixman dependency to UI modules
Date: Tue,  1 Sep 2020 05:11:28 -0400
Message-Id: <20200901091132.29601-21-pbonzini@redhat.com>
In-Reply-To: <20200901091132.29601-1-pbonzini@redhat.com>
References: <20200901091132.29601-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Stefan Weil <sw@weilnetz.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pixman used to be included directly in QEMU_CFLAGS and therefore the
include path was added to every compiler invocation.  Now that (just
like basically everything else) it is a separate dependency, we
need to add it to all build target, especially UI modules that need
it due to their including ui/console.h.

Reported-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 ui/meson.build | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/ui/meson.build b/ui/meson.build
index aa8aa31516..82f60756d9 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -40,7 +40,7 @@ ui_modules = {}
 
 if config_host.has_key('CONFIG_CURSES')
   curses_ss = ss.source_set()
-  curses_ss.add(when: [curses, iconv], if_true: files('curses.c'))
+  curses_ss.add(when: [curses, iconv], if_true: [files('curses.c'), pixman])
   ui_modules += {'curses' : curses_ss}
 endif
 
@@ -48,7 +48,7 @@ if config_host.has_key('CONFIG_GTK')
   softmmu_ss.add(when: 'CONFIG_WIN32', if_true: files('win32-kbd-hook.c'))
 
   gtk_ss = ss.source_set()
-  gtk_ss.add(gtk, vte, files('gtk.c'))
+  gtk_ss.add(gtk, vte, pixman, files('gtk.c'))
   gtk_ss.add(when: [x11, 'CONFIG_X11'], if_true: files('x_keymap.c'))
   gtk_ss.add(when: [opengl, 'CONFIG_OPENGL'], if_true: files('gtk-egl.c'))
   gtk_ss.add(when: [opengl, 'CONFIG_GTK_GL'], if_true: files('gtk-gl-area.c'))
@@ -71,7 +71,7 @@ endif
 
 if config_host.has_key('CONFIG_SPICE') and config_host.has_key('CONFIG_GIO')
   spice_ss = ss.source_set()
-  spice_ss.add(spice, gio, files('spice-app.c'))
+  spice_ss.add(spice, gio, pixman, files('spice-app.c'))
   ui_modules += {'spice-app': spice_ss}
 endif
 
-- 
2.26.2




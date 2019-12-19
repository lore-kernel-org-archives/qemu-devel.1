Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D1BC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:55:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B248B20716
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y2zrBTUl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B248B20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihvLR-0000Dd-3d
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 07:55:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36488)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihus8-0000gn-PA
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihus6-0002vq-RT
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46044
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihus6-0002rY-Iu
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t4jqXLhrAZcU4UANvFHVeNjc+sMakXQe/HeeoQkr3so=;
 b=Y2zrBTUliBqmAGzR4ADNwx1992ixYp5lMlhOYApqXC85nevw/hqSzE8Mz/NFgCiLObhd0J
 Ovqhe/sN2q7oUdfs7qBTP7IJ7tulM4bgw2sDR+8hroF2LdeC+BuXS9/9qTh+zSyITky9wr
 VGLFalIGEw6tfYd7DeCmisDSiTYYnw8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-gRAcQTfxP5Sy4EMyvBCSWw-1; Thu, 19 Dec 2019 07:25:33 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B8DD801E6D
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 12:25:32 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-55.ams2.redhat.com
 [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7530D60C18;
 Thu, 19 Dec 2019 12:25:31 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 126/132] meson: install keymaps
Date: Thu, 19 Dec 2019 13:23:46 +0100
Message-Id: <1576758232-12439-35-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: gRAcQTfxP5Sy4EMyvBCSWw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 Makefile                    |  9 ---------
 pc-bios/keymaps/meson.build | 38 ++++++++++++++++++++++++++++++++++++++
 pc-bios/meson.build         |  1 +
 3 files changed, 39 insertions(+), 9 deletions(-)
 create mode 100644 pc-bios/keymaps/meson.build

diff --git a/Makefile b/Makefile
index 8ebaacf..3faf6a4 100644
--- a/Makefile
+++ b/Makefile
@@ -217,11 +217,6 @@ distclean: clean
 =09rm -Rf .sdk
 =09if test -f dtc/version_gen.h; then $(MAKE) $(DTC_MAKE_ARGS) clean; fi
=20
-KEYMAPS=3Dda     en-gb  et  fr     fr-ch  is  lt  no  pt-br  sv \
-ar      de     en-us  fi  fr-be  hr     it  lv  nl         pl  ru     th \
-de-ch  es     fo  fr-ca  hu     ja  mk  pt  sl     tr \
-bepo    cz
-
 install-datadir:
 =09$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)"
=20
@@ -243,10 +238,6 @@ endif
 ifdef CONFIG_GTK
 =09$(MAKE) -C po $@
 endif
-=09$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/keymaps"
-=09set -e; for x in $(KEYMAPS); do \
-=09=09$(INSTALL_DATA) $(SRC_PATH)/pc-bios/keymaps/$$x "$(DESTDIR)$(qemu_da=
tadir)/keymaps"; \
-=09done
=20
 .PHONY: ctags
 ctags:
diff --git a/pc-bios/keymaps/meson.build b/pc-bios/keymaps/meson.build
new file mode 100644
index 0000000..04c2a17
--- /dev/null
+++ b/pc-bios/keymaps/meson.build
@@ -0,0 +1,38 @@
+keymaps =3D [
+  'ar',
+  'bepo',
+  'cz',
+  'da',
+  'de',
+  'de-ch',
+  'en-gb',
+  'en-us',
+  'es',
+  'et',
+  'fi',
+  'fo',
+  'fr',
+  'fr-be',
+  'fr-ca',
+  'fr-ch',
+  'hr',
+  'hu',
+  'is',
+  'it',
+  'ja',
+  'lt',
+  'lv',
+  'mk',
+  'nl',
+  'no',
+  'pl',
+  'pt',
+  'pt-br',
+  'ru',
+  'sl',
+  'sv',
+  'th',
+  'tr',
+]
+
+install_data(keymaps, install_dir: config_host['qemu_datadir'] / 'keymaps'=
)
diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index 75475a6..9a46a8c 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -25,6 +25,7 @@ foreach f: fds
 endforeach
=20
 subdir('descriptors')
+subdir('keymaps')
=20
 blobs =3D files(
   'QEMU,cgthree.bin',
--=20
1.8.3.1




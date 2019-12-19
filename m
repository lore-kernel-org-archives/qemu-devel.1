Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970B8C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:34:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D7FE218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DOveZFXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D7FE218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihv0p-0003Xt-3v
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 07:34:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34578)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihurb-0008Vh-AE
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihurZ-0001Q4-RL
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30332
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihurZ-0001NB-K0
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9X/QHYeeNuH4098z9sf5qGPqF8ZS5vX+fP9s1JD1Nvc=;
 b=DOveZFXPIE/JamKEfInFO7riEuUWMe+Tl8qENDD4MJRSdzM2SJgeNyWJD9ubFdlPfkPJrF
 7Jnc8w6MUBvzUN5FWgrEwsM6XKXHm0XAodbwHtz+XgqaUmrK0Ui7MS1wD0afo1aaheBaVS
 ufPGsMSOr7Oxo1eZPyoqM7l5C384jUs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-f6eAdgX8Pz2Nwec6AySnhw-1; Thu, 19 Dec 2019 07:25:03 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F07D2477
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 12:25:02 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-55.ams2.redhat.com
 [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD2AA60C18;
 Thu, 19 Dec 2019 12:25:01 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 114/132] build-sys/rules.mak: remove version.o
Date: Thu, 19 Dec 2019 13:23:34 +0100
Message-Id: <1576758232-12439-23-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: f6eAdgX8Pz2Nwec6AySnhw-1
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
 Makefile      | 5 -----
 Makefile.objs | 4 ----
 rules.mak     | 4 +---
 3 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/Makefile b/Makefile
index 71c3352..afb5e26 100644
--- a/Makefile
+++ b/Makefile
@@ -189,11 +189,6 @@ recurse-clean: $(addsuffix /clean, $(TARGET_DIRS) $(RO=
M_DIRS))
 recurse-install: $(addsuffix /install, $(TARGET_DIRS))
 $(addsuffix /install, $(TARGET_DIRS)): all
=20
-$(BUILD_DIR)/version.o: $(SRC_PATH)/version.rc config-host.h
-=09$(call quiet-command,$(WINDRES) -I$(BUILD_DIR) -o $@ $<,"RC","version.o=
")
-
-Makefile: $(version-obj-y)
-
 ######################################################################
=20
 COMMON_LDADDS =3D libqemuutil.a
diff --git a/Makefile.objs b/Makefile.objs
index 76326e9..9fd3932 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -55,7 +55,3 @@ common-obj-$(if $(CONFIG_RBD),m) +=3D block-rbd$(DSOSUF)
 common-obj-$(if $(CONFIG_LZFSE),m) +=3D block-dmg-lzfse$(DSOSUF)
 common-obj-$(if $(and $(CONFIG_BZIP2),$(CONFIG_DMG)),m) +=3D block-dmg-bz2=
$(DSOSUF)
 endif
-
-######################################################################
-# Resource file for Windows executables
-version-obj-$(CONFIG_WIN32) +=3D $(BUILD_DIR)/version.o
diff --git a/rules.mak b/rules.mak
index 162ecb5..6c6b909 100644
--- a/rules.mak
+++ b/rules.mak
@@ -78,8 +78,6 @@ expand-objs =3D $(strip $(sort $(filter %.o,$1)) \
 =09$(call quiet-command,$(CC) $(QEMU_LOCAL_INCLUDES) $(QEMU_INCLUDES) \
 =09       $(QEMU_CFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) $($@-cflags) \
 =09       -c -o $@ $<,"CC","$(TARGET_DIR)$@")
-%.o: %.rc
-=09$(call quiet-command,$(WINDRES) -I. -o $@ $<,"RC","$(TARGET_DIR)$@")
=20
 # If we have a CXX we might have some C++ objects, in which case we
 # must link with the C++ compiler, not the plain C compiler.
@@ -87,7 +85,7 @@ LINKPROG =3D $(or $(CXX),$(CC))
=20
 LINK =3D $(call quiet-command, $(LINKPROG) $(QEMU_LDFLAGS) $(QEMU_CFLAGS) =
$(CFLAGS) $(LDFLAGS) -o $@ \
        $(call process-archive-undefs, $1) \
-       $(version-obj-y) $(call extract-libs,$1) $(LIBS),"LINK","$(TARGET_D=
IR)$@")
+       $(call extract-libs,$1) $(LIBS),"LINK","$(TARGET_DIR)$@")
=20
 %.o: %.S
 =09$(call quiet-command,$(CCAS) $(QEMU_LOCAL_INCLUDES) $(QEMU_INCLUDES) \
--=20
1.8.3.1




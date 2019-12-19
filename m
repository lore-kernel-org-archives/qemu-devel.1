Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51FEC2D0C0
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:56:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF15220716
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ERO+ZmVc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF15220716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihvLV-0000Fs-3e
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 07:56:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35600)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihurr-0000QG-En
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihurp-0002I1-RG
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43094
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihuro-0002Eh-4o
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TOjiAa4p9HnN6M6zxs5kEy2FEQoTDPRdAVjm51scqPM=;
 b=ERO+ZmVct96uCoqzFg7VQrEUor9iezvQaZKzeoiz+0NUX0UMEOQ4lmdhHlR49JeqffAZGS
 8aa512RdBVg3WiwCFq+H/9THVg3hfLEyY/MBf9D8JfYvrfQska2sLysJZW1R5NeiEFgxPT
 26NPU/JMevNTUD9oBDtL43ZhUwo3W4Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-l8REVcC7OYyMyACCuRGuOQ-1; Thu, 19 Dec 2019 07:25:13 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9796C800D48
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 12:25:12 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-55.ams2.redhat.com
 [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 847BF60C81;
 Thu, 19 Dec 2019 12:25:08 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 117/132] meson: generate version.texi
Date: Thu, 19 Dec 2019 13:23:37 +0100
Message-Id: <1576758232-12439-26-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: l8REVcC7OYyMyACCuRGuOQ-1
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
 Makefile             | 6 ------
 docs/meson.build     | 4 ++++
 docs/version.texi.in | 2 ++
 3 files changed, 6 insertions(+), 6 deletions(-)
 create mode 100644 docs/version.texi.in

diff --git a/Makefile b/Makefile
index d60a0c9..c1ea39f 100644
--- a/Makefile
+++ b/Makefile
@@ -404,12 +404,6 @@ MAKEINFOFLAGS=3D--no-split --number-sections $(MAKEINF=
OINCLUDES)
 TEXI2PODFLAGS=3D$(MAKEINFOINCLUDES) -DVERSION=3D"$(VERSION)" -DCONFDIR=3D"=
$(qemu_confdir)"
 TEXI2PDFFLAGS=3D$(if $(V),,--quiet) -I $(SRC_PATH) $(MAKEINFOINCLUDES)
=20
-docs/version.texi: $(SRC_PATH)/VERSION config-host.mak
-=09$(call quiet-command,(\
-=09=09echo "@set VERSION $(VERSION)" && \
-=09=09echo "@set CONFDIR $(qemu_confdir)" \
-=09)> $@,"GEN","$@")
-
 %.html: %.texi docs/version.texi
 =09$(call quiet-command,LC_ALL=3DC $(MAKEINFO) $(MAKEINFOFLAGS) --no-heade=
rs \
 =09--html $< -o $@,"GEN","$@")
diff --git a/docs/meson.build b/docs/meson.build
index 8680aaa..c71fff9 100644
--- a/docs/meson.build
+++ b/docs/meson.build
@@ -1,3 +1,7 @@
+configure_file(output: 'version.texi',
+               input: 'version.texi.in',
+               configuration: config_host)
+
 sphinx =3D find_program('sphinx-build', required: build_docs)
=20
 if sphinx.found()
diff --git a/docs/version.texi.in b/docs/version.texi.in
new file mode 100644
index 0000000..0a723b8
--- /dev/null
+++ b/docs/version.texi.in
@@ -0,0 +1,2 @@
+@set VERSION @VERSION@
+@set CONFDIR @qemu_confdir@
--=20
1.8.3.1




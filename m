Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69C6C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:58:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 826BA218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SU2Q5kkL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 826BA218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihwJx-0006gh-CV
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 08:58:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38293)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ihwI7-0004Kd-4V
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:56:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ihwI3-0006R6-BL
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:56:32 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32560
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ihwI2-0006JA-V8
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:56:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576763789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Xu2SS5d3B9ghiw5I2mwzyuILj2kDLW9L9c3Ai/O7Ass=;
 b=SU2Q5kkL1HGVkxA/ufqGqOj0T3dqvzzpaCwtmYi75sxtO4w37FiKUiGKGoYk6n3fxwba6j
 Bi9ddZEjOnA/M3hDYhpd3+QW7BcHZEf+zengWWA1zhswiSwOZkz/gno0fJCAMcy0Sr7yKY
 vUP6i4hGZE6Ntjz23zSflecAtOg4f7k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-gWy7XR_ANCK0BeoPuIn2RQ-1; Thu, 19 Dec 2019 08:56:25 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A770DB61;
 Thu, 19 Dec 2019 13:56:24 +0000 (UTC)
Received: from localhost (ovpn-117-102.ams2.redhat.com [10.36.117.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B69417C823;
 Thu, 19 Dec 2019 13:56:21 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3] docs: build an index page for the HTML docs
Date: Thu, 19 Dec 2019 13:56:20 +0000
Message-Id: <20191219135620.1626608-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: gWy7XR_ANCK0BeoPuIn2RQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Daniel Berrange <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is no index.html start page for the QEMU HTML documentation.  An
index page is needed so that documentation can be browsed easily on the
web.

This patch adds an index.html.in template file where the QEMU version
number is expanded.  It is written in HTML instead of using the existing
sphinx (rST) and texi documentation generators because they are
heavyweight and would make this harder.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
v3:
 * Add <html lang=3D"en"> attribute to satisfy the W3 Validator [Thomas Hut=
h]
---
 Makefile           |  6 ++++++
 docs/index.html.in | 17 +++++++++++++++++
 2 files changed, 23 insertions(+)
 create mode 100644 docs/index.html.in

diff --git a/Makefile b/Makefile
index 1361def144..9da9cfda73 100644
--- a/Makefile
+++ b/Makefile
@@ -347,6 +347,7 @@ DOCS+=3Ddocs/interop/qemu-qmp-ref.html docs/interop/qem=
u-qmp-ref.txt docs/interop/
 DOCS+=3Ddocs/interop/qemu-ga-ref.html docs/interop/qemu-ga-ref.txt docs/in=
terop/qemu-ga-ref.7
 DOCS+=3Ddocs/qemu-block-drivers.7
 DOCS+=3Ddocs/qemu-cpu-models.7
+DOCS+=3D$(MANUAL_BUILDDIR)/index.html
 ifdef CONFIG_VIRTFS
 DOCS+=3Dfsdev/virtfs-proxy-helper.1
 endif
@@ -819,6 +820,7 @@ install-sphinxdocs: sphinxdocs
=20
 install-doc: $(DOCS) install-sphinxdocs
 =09$(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)"
+=09$(INSTALL_DATA) $(MANUAL_BUILDDIR)/index.html "$(DESTDIR)$(qemu_docdir)=
"
 =09$(INSTALL_DATA) qemu-doc.html "$(DESTDIR)$(qemu_docdir)"
 =09$(INSTALL_DATA) qemu-doc.txt "$(DESTDIR)$(qemu_docdir)"
 =09$(INSTALL_DATA) docs/interop/qemu-qmp-ref.html "$(DESTDIR)$(qemu_docdir=
)"
@@ -1025,6 +1027,10 @@ $(MANUAL_BUILDDIR)/specs/index.html: $(call manual-d=
eps,specs)
 $(MANUAL_BUILDDIR)/interop/qemu-ga.8: $(call manual-deps,interop)
 =09$(call build-manual,interop,man)
=20
+$(MANUAL_BUILDDIR)/index.html: $(SRC_PATH)/docs/index.html.in qemu-version=
.h
+=09$(call quiet-command, sed "s|@@VERSION@@|${VERSION}|g" $< >$@, \
+             "GEN","$@")
+
 qemu-options.texi: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
 =09$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN","=
$@")
=20
diff --git a/docs/index.html.in b/docs/index.html.in
new file mode 100644
index 0000000000..94eb782cf7
--- /dev/null
+++ b/docs/index.html.in
@@ -0,0 +1,17 @@
+<!DOCTYPE html>
+<html lang=3D"en">
+    <head>
+        <meta charset=3D"UTF-8">
+        <title>QEMU @@VERSION@@ Documentation</title>
+    </head>
+    <body>
+        <h1>QEMU @@VERSION@@ Documentation</h1>
+        <ul>
+            <li><a href=3D"qemu-doc.html">User Documentation</a></li>
+            <li><a href=3D"qemu-qmp-ref.html">QMP Reference Manual</a></li=
>
+            <li><a href=3D"qemu-ga-ref.html">Guest Agent Protocol Referenc=
e</a></li>
+            <li><a href=3D"interop/index.html">System Emulation Management=
 and Interoperability Guide</a></li>
+            <li><a href=3D"specs/index.html">System Emulation Guest Hardwa=
re Specifications</a></li>
+        </ul>
+    </body>
+</html>
--=20
2.23.0



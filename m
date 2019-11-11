Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C5BC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 10:22:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CC3F214DB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 10:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M7wROJeZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC3F214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iU6qP-0002BN-8R
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 05:22:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48003)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iU6pi-0001dG-Kd
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 05:22:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iU6ph-0001qF-Ex
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 05:22:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42338
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iU6ph-0001q5-Bi
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 05:22:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573467725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SB0tf4rLUsBeczbTt8drjTxj7QHoJwGbGOrXfntudtg=;
 b=M7wROJeZSj7Dn40JyKbzwGETqCccFNHl9LQLX6MeHH/3egRE8NZc3sQFY3+uGLwjGmucp/
 BI0bMiiW10g2tv72W+ds3PRknTktMR2YWdsRB6OAE20we1ZL74S5sSQXxbkXzct+d+sLeT
 2jYMatq3uez5peUlsubjqh2NC1u3Bmg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-7sHUbpRdNtKfwiwer81zZA-1; Mon, 11 Nov 2019 05:22:03 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F95091220;
 Mon, 11 Nov 2019 10:22:02 +0000 (UTC)
Received: from localhost (ovpn-117-169.ams2.redhat.com [10.36.117.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 17F9B61075;
 Mon, 11 Nov 2019 10:21:58 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] docs: build an index page for the HTML docs
Date: Mon, 11 Nov 2019 10:21:57 +0000
Message-Id: <20191111102157.440664-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 7sHUbpRdNtKfwiwer81zZA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
 Makefile           |  6 ++++++
 docs/index.html.in | 17 +++++++++++++++++
 2 files changed, 23 insertions(+)
 create mode 100644 docs/index.html.in

diff --git a/Makefile b/Makefile
index aa9d1a42aa..581bc68918 100644
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
@@ -818,6 +819,7 @@ install-sphinxdocs: sphinxdocs
=20
 install-doc: $(DOCS) install-sphinxdocs
 =09$(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)"
+=09$(INSTALL_DATA) $(MANUAL_BUILDDIR)/index.html "$(DESTDIR)$(qemu_docdir)=
"
 =09$(INSTALL_DATA) qemu-doc.html "$(DESTDIR)$(qemu_docdir)"
 =09$(INSTALL_DATA) qemu-doc.txt "$(DESTDIR)$(qemu_docdir)"
 =09$(INSTALL_DATA) docs/interop/qemu-qmp-ref.html "$(DESTDIR)$(qemu_docdir=
)"
@@ -1024,6 +1026,10 @@ $(MANUAL_BUILDDIR)/specs/index.html: $(call manual-d=
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
index 0000000000..c2df85a185
--- /dev/null
+++ b/docs/index.html.in
@@ -0,0 +1,17 @@
+<!DOCTYPE html>
+<html>
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



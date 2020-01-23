Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9E6C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:02:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5495D20684
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DGHO7PAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5495D20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iud4L-0005GJ-1z
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 09:02:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40921)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iub9U-0002y1-FS
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:00:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iub9T-0005U8-45
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:00:00 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38704
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iub9T-0005Tn-0U
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579780798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lxR2CPoTBdsqUlKhDMI0yaffCU2qFxmoxCDzO85rOPA=;
 b=DGHO7PAcN+4Fp5tm39R3VW8Ix0m4UqpLTE2BRncMMgH+oQP7dpxR9jCf2lt4kFqvuYewZM
 6AD4eYqwGckFBQjA98ENcdmHD1ZW7R3aQ5f1CKPVr2xkfHGBEWfLRluawMrXeAlhVaYtxl
 LYw28C98mR7lzkD4aUxt5APDO1GM90w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-zo4JF0osN3uJ8StNm7YaOA-1; Thu, 23 Jan 2020 06:59:55 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E438A18A6EC1
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 11:59:54 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C54285782;
 Thu, 23 Jan 2020 11:59:54 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 058/111] docs:  Add docs/tools
Date: Thu, 23 Jan 2020 11:57:48 +0000
Message-Id: <20200123115841.138849-59-dgilbert@redhat.com>
In-Reply-To: <20200123115841.138849-1-dgilbert@redhat.com>
References: <20200123115841.138849-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: zo4JF0osN3uJ8StNm7YaOA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Create docs/tools based on docs/dev based on docs/devel.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 Makefile             |  9 ++++++++-
 docs/index.rst       |  1 +
 docs/tools/conf.py   | 16 ++++++++++++++++
 docs/tools/index.rst | 12 ++++++++++++
 4 files changed, 37 insertions(+), 1 deletion(-)
 create mode 100644 docs/tools/conf.py
 create mode 100644 docs/tools/index.rst

diff --git a/Makefile b/Makefile
index 6b4b075a92..60c35a9dd3 100644
--- a/Makefile
+++ b/Makefile
@@ -823,6 +823,7 @@ endef
 install-sphinxdocs: sphinxdocs
 =09$(call install-manual,interop)
 =09$(call install-manual,specs)
+=09$(call install-manual,tools)
=20
 install-doc: $(DOCS) install-sphinxdocs
 =09$(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)"
@@ -1010,7 +1011,10 @@ docs/version.texi: $(SRC_PATH)/VERSION config-host.m=
ak
 # and handles "don't rebuild things unless necessary" itself.
 # The '.doctrees' files are cached information to speed this up.
 .PHONY: sphinxdocs
-sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html $(MANUAL_BUILDDIR)/interop=
/index.html $(MANUAL_BUILDDIR)/specs/index.html
+sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html \
+            $(MANUAL_BUILDDIR)/interop/index.html \
+            $(MANUAL_BUILDDIR)/specs/index.html \
+            $(MANUAL_BUILDDIR)/tools/index.html
=20
 # Canned command to build a single manual
 # Arguments: $1 =3D manual name, $2 =3D Sphinx builder ('html' or 'man')
@@ -1030,6 +1034,9 @@ $(MANUAL_BUILDDIR)/interop/index.html: $(call manual-=
deps,interop)
 $(MANUAL_BUILDDIR)/specs/index.html: $(call manual-deps,specs)
 =09$(call build-manual,specs,html)
=20
+$(MANUAL_BUILDDIR)/tools/index.html: $(call manual-deps,tools)
+=09$(call build-manual,tools,html)
+
 $(MANUAL_BUILDDIR)/interop/qemu-ga.8: $(call manual-deps,interop)
 =09$(call build-manual,interop,man)
=20
diff --git a/docs/index.rst b/docs/index.rst
index baa5791c17..f15ca17bf4 100644
--- a/docs/index.rst
+++ b/docs/index.rst
@@ -13,4 +13,5 @@ Welcome to QEMU's documentation!
    interop/index
    devel/index
    specs/index
+   tools/index
=20
diff --git a/docs/tools/conf.py b/docs/tools/conf.py
new file mode 100644
index 0000000000..f9f76ff597
--- /dev/null
+++ b/docs/tools/conf.py
@@ -0,0 +1,16 @@
+# -*- coding: utf-8 -*-
+#
+# QEMU documentation build configuration file for the 'tools' manual.
+#
+# This includes the top level conf file and then makes any necessary tweak=
s.
+import sys
+import os
+
+qemu_docdir =3D os.path.abspath("..")
+parent_config =3D os.path.join(qemu_docdir, "conf.py")
+exec(compile(open(parent_config, "rb").read(), parent_config, 'exec'))
+
+# This slightly misuses the 'description', but is the best way to get
+# the manual title to appear in the sidebar.
+html_theme_options['description'] =3D u'Tools'
+
diff --git a/docs/tools/index.rst b/docs/tools/index.rst
new file mode 100644
index 0000000000..adbcd3bc72
--- /dev/null
+++ b/docs/tools/index.rst
@@ -0,0 +1,12 @@
+.. This is the top level page for the 'tools' manual.
+
+
+QEMU tools
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+This manual documents various tools included with QEMU.
+
+Contents:
+
+.. toctree::
+   :maxdepth: 2
--=20
2.24.1



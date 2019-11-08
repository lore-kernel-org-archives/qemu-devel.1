Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523D8FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 10:01:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C9F12075C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 10:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E2YmNqjr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C9F12075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT15P-0004Wr-Mb
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 05:01:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iT13e-00033z-5A
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:59:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iT13c-0002pF-U2
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:59:58 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40265
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iT13c-0002ow-Pd
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:59:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573207196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E1PrCcV2bCrqfwPGW8w+z8cIKLfnFqyKtepYRRx2Ae4=;
 b=E2YmNqjrjkjobBuZKaykDQiI8OHTXoxF6KQICjpmOhZ7ehuv44fG2RSxcxM+kkBaYuZo2N
 5Y4tLq0LdsHYZ/fAiBEzZVRj8lG7BBz9WSLfVQobJOBLmhyYrP1zI9sqhVizyjx9LkShS9
 CGeNs7wRSu9hFDSX/nkS+d1iw/VtyTg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-P9DV5GxuMeWuOOEu_4TnYg-1; Fri, 08 Nov 2019 04:59:54 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E5A32A3;
 Fri,  8 Nov 2019 09:59:54 +0000 (UTC)
Received: from localhost (ovpn-116-74.ams2.redhat.com [10.36.116.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 60D65600CA;
 Fri,  8 Nov 2019 09:59:53 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] docs: build a global index page
Date: Fri,  8 Nov 2019 10:59:41 +0100
Message-Id: <20191108095942.401225-3-stefanha@redhat.com>
In-Reply-To: <20191108095942.401225-1-stefanha@redhat.com>
References: <20191108095942.401225-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: P9DV5GxuMeWuOOEu_4TnYg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel Berrange <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Build docs/ in a single sphinx invocation instead of treating
docs/{devel,interop,specs} separately.  This allows us to build a global
index page that links to documentation across the different manuals.

Some documentation is built outside of sphinx and is not formatted as
reStructuredText.  Link directly to the .html files for the time being.
If they are converted to .rst files in the future they can be included
more elegantly.

Sphinx wants to build all .rst files and complains if they are not
listed in the table of contents.  We have not yet reviewed and
categorized some of our .rst files.  Hide these files so they are always
built (and syntax-checked from now on!) but not visible in the table of
contents.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 Makefile       | 13 ++++---------
 docs/index.rst | 27 ++++++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index aa9d1a42aa..9487a06bed 100644
--- a/Makefile
+++ b/Makefile
@@ -815,6 +815,7 @@ endef
 install-sphinxdocs: sphinxdocs
 =09$(call install-manual,interop)
 =09$(call install-manual,specs)
+=09$(INSTALL_DATA) "$(MANUAL_BUILDDIR)/index.html" "$(DESTDIR)$(qemu_docdi=
r)/index.html"
=20
 install-doc: $(DOCS) install-sphinxdocs
 =09$(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)"
@@ -1001,7 +1002,7 @@ docs/version.texi: $(SRC_PATH)/VERSION config-host.ma=
k
 # and handles "don't rebuild things unless necessary" itself.
 # The '.doctrees' files are cached information to speed this up.
 .PHONY: sphinxdocs
-sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html $(MANUAL_BUILDDIR)/interop=
/index.html $(MANUAL_BUILDDIR)/specs/index.html
+sphinxdocs: $(MANUAL_BUILDDIR)/index.html
=20
 # Canned command to build a single manual
 # Arguments: $1 =3D manual name, $2 =3D Sphinx builder ('html' or 'man')
@@ -1012,14 +1013,8 @@ build-manual =3D $(call quiet-command,CONFDIR=3D"$(q=
emu_confdir)" sphinx-build $(if
 # We assume all RST files in the manual's directory are used in it
 manual-deps =3D $(wildcard $(SRC_PATH)/docs/$1/*.rst) $(SRC_PATH)/docs/$1/=
conf.py $(SRC_PATH)/docs/conf.py
=20
-$(MANUAL_BUILDDIR)/devel/index.html: $(call manual-deps,devel)
-=09$(call build-manual,devel,html)
-
-$(MANUAL_BUILDDIR)/interop/index.html: $(call manual-deps,interop)
-=09$(call build-manual,interop,html)
-
-$(MANUAL_BUILDDIR)/specs/index.html: $(call manual-deps,specs)
-=09$(call build-manual,specs,html)
+$(MANUAL_BUILDDIR)/index.html: $(call manual-deps,)
+=09$(call build-manual,,html)
=20
 $(MANUAL_BUILDDIR)/interop/qemu-ga.8: $(call manual-deps,interop)
 =09$(call build-manual,interop,man)
diff --git a/docs/index.rst b/docs/index.rst
index baa5791c17..9d6d239561 100644
--- a/docs/index.rst
+++ b/docs/index.rst
@@ -6,11 +6,36 @@
 Welcome to QEMU's documentation!
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
=20
+.. Non-rst documentation
+
+`QEMU User Documentation <qemu-doc.html>`_
+
+`QEMU QMP Reference Manual <qemu-doc.html>`_
+
+`QEMU Guest Agent Protocol Reference <qemu-doc.html>`_
+
 .. toctree::
    :maxdepth: 2
    :caption: Contents:
=20
    interop/index
-   devel/index
    specs/index
=20
+.. The QEMU Developer's Guide is not included in the main documentation be=
cause
+   users don't need it.
+.. toctree::
+   :hidden:
+
+   devel/index
+
+.. Hidden documents that still need to be reviewed and moved to the approp=
riate
+   section of the documentation.
+.. toctree::
+   :hidden:
+
+   arm-cpu-features
+   cpu-hotplug
+   microvm
+   pr-manager
+   virtio-net-failover
+   virtio-pmem
--=20
2.23.0



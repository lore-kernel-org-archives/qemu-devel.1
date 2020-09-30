Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8ACC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 04:36:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85D372075A
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 04:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N3xXUQLp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85D372075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNTqY-0005F2-Ix
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 00:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kNTmo-0000AV-Mf
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 00:32:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34643)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kNTmm-0000W6-FY
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 00:32:14 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601440331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b+q7phJ4ukBY3oiULFKlgjV3MxujgZCHt5k+8lqojh4=;
 b=N3xXUQLpZjCvJMW9dZOiD4wx+a6iDBuTxPf5Xk3lN0dzjSIZovb14MnEfMEUYSWWOflIXT
 5cLJI9ACiuzsUR4ya9F1bPG84cQsDXPKxB9jGUF2D451on2xl5/Og89bVpZKuRAyAVnACf
 MngL57dLp5TVMAHiQW8ta8+kyBLXdR4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-xVahg79CMeWx_I0KqwxG1Q-1; Wed, 30 Sep 2020 00:32:05 -0400
X-MC-Unique: xVahg79CMeWx_I0KqwxG1Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB2621DDF3;
 Wed, 30 Sep 2020 04:32:04 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E3A6F73678;
 Wed, 30 Sep 2020 04:32:00 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 05/46] [DO-NOT-MERGE] docs: enable sphinx-autodoc for
 scripts/qapi
Date: Wed, 30 Sep 2020 00:31:09 -0400
Message-Id: <20200930043150.1454766-6-jsnow@redhat.com>
In-Reply-To: <20200930043150.1454766-1-jsnow@redhat.com>
References: <20200930043150.1454766-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/conf.py                          |  3 ++-
 docs/devel/index.rst                  |  1 +
 docs/devel/python/index.rst           |  7 +++++++
 docs/devel/python/qapi.commands.rst   |  7 +++++++
 docs/devel/python/qapi.common.rst     |  7 +++++++
 docs/devel/python/qapi.error.rst      |  7 +++++++
 docs/devel/python/qapi.events.rst     |  7 +++++++
 docs/devel/python/qapi.expr.rst       |  7 +++++++
 docs/devel/python/qapi.gen.rst        |  7 +++++++
 docs/devel/python/qapi.introspect.rst |  7 +++++++
 docs/devel/python/qapi.parser.rst     |  8 ++++++++
 docs/devel/python/qapi.rst            | 25 +++++++++++++++++++++++++
 docs/devel/python/qapi.schema.rst     |  7 +++++++
 docs/devel/python/qapi.source.rst     |  7 +++++++
 docs/devel/python/qapi.types.rst      |  7 +++++++
 docs/devel/python/qapi.visit.rst      |  7 +++++++
 16 files changed, 120 insertions(+), 1 deletion(-)
 create mode 100644 docs/devel/python/index.rst
 create mode 100644 docs/devel/python/qapi.commands.rst
 create mode 100644 docs/devel/python/qapi.common.rst
 create mode 100644 docs/devel/python/qapi.error.rst
 create mode 100644 docs/devel/python/qapi.events.rst
 create mode 100644 docs/devel/python/qapi.expr.rst
 create mode 100644 docs/devel/python/qapi.gen.rst
 create mode 100644 docs/devel/python/qapi.introspect.rst
 create mode 100644 docs/devel/python/qapi.parser.rst
 create mode 100644 docs/devel/python/qapi.rst
 create mode 100644 docs/devel/python/qapi.schema.rst
 create mode 100644 docs/devel/python/qapi.source.rst
 create mode 100644 docs/devel/python/qapi.types.rst
 create mode 100644 docs/devel/python/qapi.visit.rst

diff --git a/docs/conf.py b/docs/conf.py
index 49599e38314..1e428a4bda8 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -70,7 +70,8 @@
 # Add any Sphinx extension module names here, as strings. They can be
 # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
 # ones.
-extensions = ['kerneldoc', 'qmp_lexer', 'hxtool', 'depfile', 'qapidoc']
+extensions = ['kerneldoc', 'qmp_lexer', 'hxtool',
+              'depfile', 'qapidoc', 'sphinx.ext.autodoc']
 
 # Add any paths that contain templates here, relative to this directory.
 templates_path = ['_templates']
diff --git a/docs/devel/index.rst b/docs/devel/index.rst
index 04773ce076b..04726ca7870 100644
--- a/docs/devel/index.rst
+++ b/docs/devel/index.rst
@@ -31,3 +31,4 @@ Contents:
    reset
    s390-dasd-ipl
    clocks
+   python/index
diff --git a/docs/devel/python/index.rst b/docs/devel/python/index.rst
new file mode 100644
index 00000000000..31c470154b3
--- /dev/null
+++ b/docs/devel/python/index.rst
@@ -0,0 +1,7 @@
+qapi
+====
+
+.. toctree::
+   :maxdepth: 4
+
+   qapi
diff --git a/docs/devel/python/qapi.commands.rst b/docs/devel/python/qapi.commands.rst
new file mode 100644
index 00000000000..018f7b08a9c
--- /dev/null
+++ b/docs/devel/python/qapi.commands.rst
@@ -0,0 +1,7 @@
+qapi.commands module
+====================
+
+.. automodule:: qapi.commands
+   :members:
+   :undoc-members:
+   :show-inheritance:
diff --git a/docs/devel/python/qapi.common.rst b/docs/devel/python/qapi.common.rst
new file mode 100644
index 00000000000..128a90d74be
--- /dev/null
+++ b/docs/devel/python/qapi.common.rst
@@ -0,0 +1,7 @@
+qapi.common module
+==================
+
+.. automodule:: qapi.common
+   :members:
+   :undoc-members:
+   :show-inheritance:
diff --git a/docs/devel/python/qapi.error.rst b/docs/devel/python/qapi.error.rst
new file mode 100644
index 00000000000..980e32b63de
--- /dev/null
+++ b/docs/devel/python/qapi.error.rst
@@ -0,0 +1,7 @@
+qapi.error module
+=================
+
+.. automodule:: qapi.error
+   :members:
+   :undoc-members:
+   :show-inheritance:
diff --git a/docs/devel/python/qapi.events.rst b/docs/devel/python/qapi.events.rst
new file mode 100644
index 00000000000..1fce85b044e
--- /dev/null
+++ b/docs/devel/python/qapi.events.rst
@@ -0,0 +1,7 @@
+qapi.events module
+==================
+
+.. automodule:: qapi.events
+   :members:
+   :undoc-members:
+   :show-inheritance:
diff --git a/docs/devel/python/qapi.expr.rst b/docs/devel/python/qapi.expr.rst
new file mode 100644
index 00000000000..0660270629c
--- /dev/null
+++ b/docs/devel/python/qapi.expr.rst
@@ -0,0 +1,7 @@
+qapi.expr module
+================
+
+.. automodule:: qapi.expr
+   :members:
+   :undoc-members:
+   :show-inheritance:
diff --git a/docs/devel/python/qapi.gen.rst b/docs/devel/python/qapi.gen.rst
new file mode 100644
index 00000000000..7b495fd4bf2
--- /dev/null
+++ b/docs/devel/python/qapi.gen.rst
@@ -0,0 +1,7 @@
+qapi.gen module
+===============
+
+.. automodule:: qapi.gen
+   :members:
+   :undoc-members:
+   :show-inheritance:
diff --git a/docs/devel/python/qapi.introspect.rst b/docs/devel/python/qapi.introspect.rst
new file mode 100644
index 00000000000..f65ebfccd1b
--- /dev/null
+++ b/docs/devel/python/qapi.introspect.rst
@@ -0,0 +1,7 @@
+qapi.introspect module
+======================
+
+.. automodule:: qapi.introspect
+   :members:
+   :undoc-members:
+   :show-inheritance:
diff --git a/docs/devel/python/qapi.parser.rst b/docs/devel/python/qapi.parser.rst
new file mode 100644
index 00000000000..1a8f7b347eb
--- /dev/null
+++ b/docs/devel/python/qapi.parser.rst
@@ -0,0 +1,8 @@
+qapi.parser module
+==================
+
+.. automodule:: qapi.parser
+   :members:
+   :undoc-members:
+   :show-inheritance:
+   :private-members:
diff --git a/docs/devel/python/qapi.rst b/docs/devel/python/qapi.rst
new file mode 100644
index 00000000000..cfeb759d763
--- /dev/null
+++ b/docs/devel/python/qapi.rst
@@ -0,0 +1,25 @@
+qapi package
+============
+
+.. automodule:: qapi
+   :members:
+   :undoc-members:
+   :show-inheritance:
+
+Submodules
+----------
+
+.. toctree::
+
+   qapi.commands
+   qapi.common
+   qapi.error
+   qapi.events
+   qapi.expr
+   qapi.gen
+   qapi.introspect
+   qapi.parser
+   qapi.schema
+   qapi.source
+   qapi.types
+   qapi.visit
diff --git a/docs/devel/python/qapi.schema.rst b/docs/devel/python/qapi.schema.rst
new file mode 100644
index 00000000000..a08f75ed720
--- /dev/null
+++ b/docs/devel/python/qapi.schema.rst
@@ -0,0 +1,7 @@
+qapi.schema module
+==================
+
+.. automodule:: qapi.schema
+   :members:
+   :undoc-members:
+   :show-inheritance:
diff --git a/docs/devel/python/qapi.source.rst b/docs/devel/python/qapi.source.rst
new file mode 100644
index 00000000000..e61e9f60212
--- /dev/null
+++ b/docs/devel/python/qapi.source.rst
@@ -0,0 +1,7 @@
+qapi.source module
+==================
+
+.. automodule:: qapi.source
+   :members:
+   :undoc-members:
+   :show-inheritance:
diff --git a/docs/devel/python/qapi.types.rst b/docs/devel/python/qapi.types.rst
new file mode 100644
index 00000000000..6eea827557d
--- /dev/null
+++ b/docs/devel/python/qapi.types.rst
@@ -0,0 +1,7 @@
+qapi.types module
+=================
+
+.. automodule:: qapi.types
+   :members:
+   :undoc-members:
+   :show-inheritance:
diff --git a/docs/devel/python/qapi.visit.rst b/docs/devel/python/qapi.visit.rst
new file mode 100644
index 00000000000..84307cbc236
--- /dev/null
+++ b/docs/devel/python/qapi.visit.rst
@@ -0,0 +1,7 @@
+qapi.visit module
+=================
+
+.. automodule:: qapi.visit
+   :members:
+   :undoc-members:
+   :show-inheritance:
-- 
2.26.2



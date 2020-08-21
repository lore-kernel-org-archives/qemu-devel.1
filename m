Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2E9C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:26:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 269062054F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WrYbpykK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 269062054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k95Bh-0003Pt-9t
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 07:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94F1-000484-38
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:25:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33257)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94Eh-0001z8-6r
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:25:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598005526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lNf6IAPkpNupdQ6XZQ7YWjwyEv/hOuxmO0wFYOnC96Q=;
 b=WrYbpykKYX0X8loh/ybkLsB7mCxW0R2C1Wc9UShx1i3CI1YdXdpq3jHrDk370iFEMpGjdv
 Y8yEEXz9RMqDRkpPqoFviDBQozOdq+F0QeIuAm32hqe7agkkY1uIfoMf8XwV8JIhktGWAN
 q5iS9wK2chhnJTqoG/jY4xGDpPHSY88=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-tUIQ-3ciMkaJEQi3hXHJrw-1; Fri, 21 Aug 2020 06:25:23 -0400
X-MC-Unique: tUIQ-3ciMkaJEQi3hXHJrw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5013F1009441
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 10:25:22 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C6B0101E247
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 10:25:22 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v8 141/152] docs: automatically track manual dependencies
Date: Fri, 21 Aug 2020 06:23:18 -0400
Message-Id: <20200821102329.29777-142-pbonzini@redhat.com>
In-Reply-To: <20200821102329.29777-1-pbonzini@redhat.com>
References: <20200821102329.29777-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 04:26:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/conf.py           |  2 +-
 docs/meson.build       | 21 ++++++++++-------
 docs/sphinx/depfile.py | 51 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 9 deletions(-)
 create mode 100644 docs/sphinx/depfile.py

diff --git a/docs/conf.py b/docs/conf.py
index d6e173ef77..0dbd90dc11 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -67,7 +67,7 @@ needs_sphinx = '1.6'
 # Add any Sphinx extension module names here, as strings. They can be
 # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
 # ones.
-extensions = ['kerneldoc', 'qmp_lexer', 'hxtool']
+extensions = ['kerneldoc', 'qmp_lexer', 'hxtool', 'depfile']
 
 # Add any paths that contain templates here, relative to this directory.
 templates_path = ['_templates']
diff --git a/docs/meson.build b/docs/meson.build
index 20fc92e2fe..8b059a8e39 100644
--- a/docs/meson.build
+++ b/docs/meson.build
@@ -34,16 +34,21 @@ if build_docs
   sphinxmans = []
   foreach manual : manuals
     private_dir = meson.current_build_dir() / (manual + '.p')
+    output_dir = meson.current_build_dir() / manual
     input_dir = meson.current_source_dir() / manual
-    sphinxdocs += custom_target(manual + ' manual',
-                build_always_stale: true,
+
+    this_manual = custom_target(manual + ' manual',
                 build_by_default: build_docs,
-                output: manual,
-                command: [SPHINX_ARGS, '-b', 'html', '-d', private_dir,
-                          input_dir, meson.current_build_dir() / manual])
+                output: [manual + '.stamp'],
+                input: [files('conf.py'), files(manual / 'conf.py')],
+                depfile: manual + '.d',
+                command: [SPHINX_ARGS, '-Ddepfile=@DEPFILE@',
+                          '-Ddepfile_stamp=@OUTPUT0@',
+                          '-b', 'html', '-d', private_dir,
+                          input_dir, output_dir])
+    sphinxdocs += this_manual
     if build_docs and manual != 'devel'
-      install_subdir(meson.current_build_dir() / manual,
-                     install_dir: config_host['qemu_docdir'])
+      install_subdir(output_dir, install_dir: config_host['qemu_docdir'])
     endif
 
     these_man_pages = []
@@ -54,9 +59,9 @@ if build_docs
     endforeach
     if these_man_pages.length() > 0
       sphinxmans += custom_target(manual + ' man pages',
-                         build_always_stale: true,
                          build_by_default: build_docs,
                          output: these_man_pages,
+                         input: this_manual,
                          install: build_docs,
                          install_dir: install_dirs,
                          command: [SPHINX_ARGS, '-b', 'man', '-d', private_dir,
diff --git a/docs/sphinx/depfile.py b/docs/sphinx/depfile.py
new file mode 100644
index 0000000000..277fdf0f56
--- /dev/null
+++ b/docs/sphinx/depfile.py
@@ -0,0 +1,51 @@
+# coding=utf-8
+#
+# QEMU depfile generation extension
+#
+# Copyright (c) 2020 Red Hat, Inc.
+#
+# This work is licensed under the terms of the GNU GPLv2 or later.
+# See the COPYING file in the top-level directory.
+
+"""depfile is a Sphinx extension that writes a dependency file for
+   an external build system"""
+
+import os
+import sphinx
+
+__version__ = '1.0'
+
+def get_infiles(env):
+    for x in env.found_docs:
+        yield env.doc2path(x)
+        yield from ((os.path.join(env.srcdir, dep)
+                    for dep in env.dependencies[x]))
+
+def write_depfile(app, env):
+    if not env.config.depfile:
+        return
+
+    # Using a directory as the output file does not work great because
+    # its timestamp does not necessarily change when the contents change.
+    # So create a timestamp file.
+    if env.config.depfile_stamp:
+        with open(env.config.depfile_stamp, 'w') as f:
+            pass
+
+    with open(env.config.depfile, 'w') as f:
+        print((env.config.depfile_stamp or app.outdir) + ": \\", file=f)
+        print(*get_infiles(env), file=f)
+        for x in get_infiles(env):
+            print(x + ":", file=f)
+
+
+def setup(app):
+    app.add_config_value('depfile', None, 'env')
+    app.add_config_value('depfile_stamp', None, 'env')
+    app.connect('env-updated', write_depfile)
+
+    return dict(
+        version = __version__,
+        parallel_read_safe = True,
+        parallel_write_safe = True
+    )
-- 
2.26.2




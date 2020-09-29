Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60730C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:31:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F8AD20774
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sw1NgBSj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F8AD20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNMHp-0000jo-95
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 16:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNM6I-0001v2-5M
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:19:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39009)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNM68-0003Vi-4g
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:19:49 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601410778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nvxuauxtmIrz8mXp8WmGjf5Zvqj/tWEjYO7gCi8qjIU=;
 b=Sw1NgBSjjxvkj1gw0Rykx7dkcxXx40y7C90SlfPHiWx0lkjzgIDswlDENDawRhAbzXUENQ
 1XSVwEIk6w3ld8CGH4Ho7RvzpvyrI+aVPmjoH80soiKOx9a4omPs4YmGYsWa/UJDLC+Jjv
 yZAsCQC2hvGJG6ZQNWEusCpVove8FKY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-wb-cTkCSPf20JQEtG-0EAg-1; Tue, 29 Sep 2020 16:19:32 -0400
X-MC-Unique: wb-cTkCSPf20JQEtG-0EAg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ABED11040C27;
 Tue, 29 Sep 2020 20:19:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 57F3878807;
 Tue, 29 Sep 2020 20:19:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C9D8F11358CA; Tue, 29 Sep 2020 22:19:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/29] docs/interop: Convert qemu-ga-ref to rST
Date: Tue, 29 Sep 2020 22:19:13 +0200
Message-Id: <20200929201926.2155622-17-armbru@redhat.com>
In-Reply-To: <20200929201926.2155622-1-armbru@redhat.com>
References: <20200929201926.2155622-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
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
Cc: peter.maydell@linaro.org, Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

Convert qemu-ga-ref to rST format. This includes dropping
the plain-text, pdf and info format outputs for this document;
as with all our other Sphinx-based documentation, we provide
HTML and manpage only.

The qemu-ga-ref.rst is somewhat more stripped down than
the .texi was, because we do not (currently) attempt to
generate indexes for the commands, events and data types
being documented.

As the GA ref is now part of the Sphinx 'interop' manual,
we can delete the direct link from index.html.in.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20200925162316.21205-9-peter.maydell@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Unicode legacy literal dumbed down to plain string literal, TODO
comment on displaying QEMU version added]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/index.html.in            |  1 -
 docs/interop/conf.py          |  2 +
 docs/interop/index.rst        |  1 +
 docs/interop/qemu-ga-ref.rst  | 13 ++++++
 docs/interop/qemu-ga-ref.texi | 80 -----------------------------------
 docs/meson.build              |  1 +
 meson.build                   |  3 --
 MAINTAINERS                   |  2 +-
 qga/meson.build               |  3 +-
 9 files changed, 19 insertions(+), 87 deletions(-)
 create mode 100644 docs/interop/qemu-ga-ref.rst
 delete mode 100644 docs/interop/qemu-ga-ref.texi

diff --git a/docs/index.html.in b/docs/index.html.in
index ca28047881..5b0f4e2bc2 100644
--- a/docs/index.html.in
+++ b/docs/index.html.in
@@ -13,7 +13,6 @@
             <li><a href="interop/index.html">System Emulation Management and Interoperability Guide</a></li>
             <li><a href="specs/index.html">System Emulation Guest Hardware Specifications</a></li>
             <li><a href="interop/qemu-qmp-ref.html">QMP Reference Manual</a></li>
-            <li><a href="interop/qemu-ga-ref.html">Guest Agent Protocol Reference</a></li>
         </ul>
     </body>
 </html>
diff --git a/docs/interop/conf.py b/docs/interop/conf.py
index 42ce7e3d36..4e5bbbbf95 100644
--- a/docs/interop/conf.py
+++ b/docs/interop/conf.py
@@ -19,4 +19,6 @@ html_theme_options['description'] = u'System Emulation Management and Interopera
 man_pages = [
     ('qemu-ga', 'qemu-ga', u'QEMU Guest Agent',
      ['Michael Roth <mdroth@linux.vnet.ibm.com>'], 8),
+    ('qemu-ga-ref', 'qemu-ga-ref', 'QEMU Guest Agent Protocol Reference',
+     [], 7),
 ]
diff --git a/docs/interop/index.rst b/docs/interop/index.rst
index 006f986420..738cdbe185 100644
--- a/docs/interop/index.rst
+++ b/docs/interop/index.rst
@@ -18,6 +18,7 @@ Contents:
    live-block-operations
    pr-helper
    qemu-ga
+   qemu-ga-ref
    vhost-user
    vhost-user-gpu
    vhost-vdpa
diff --git a/docs/interop/qemu-ga-ref.rst b/docs/interop/qemu-ga-ref.rst
new file mode 100644
index 0000000000..3f1c4f908f
--- /dev/null
+++ b/docs/interop/qemu-ga-ref.rst
@@ -0,0 +1,13 @@
+QEMU Guest Agent Protocol Reference
+===================================
+
+..
+   TODO: the old Texinfo manual used to note that this manual
+   is GPL-v2-or-later. We should make that reader-visible
+   both here and in our Sphinx manuals more generally.
+
+..
+   TODO: display the QEMU version, both here and in our Sphinx manuals
+   more generally.
+
+.. qapi-doc:: qga/qapi-schema.json
diff --git a/docs/interop/qemu-ga-ref.texi b/docs/interop/qemu-ga-ref.texi
deleted file mode 100644
index a23cc2ed7f..0000000000
--- a/docs/interop/qemu-ga-ref.texi
+++ /dev/null
@@ -1,80 +0,0 @@
-\input texinfo
-@setfilename qemu-ga-ref.info
-
-@include version.texi
-
-@exampleindent 0
-@paragraphindent 0
-
-@settitle QEMU Guest Agent Protocol Reference
-
-@iftex
-@center @image{docs/qemu_logo}
-@end iftex
-
-@copying
-This is the QEMU Guest Agent Protocol reference manual.
-
-Copyright @copyright{} 2016 The QEMU Project developers
-
-@quotation
-This manual is free documentation: you can redistribute it and/or
-modify it under the terms of the GNU General Public License as
-published by the Free Software Foundation, either version 2 of the
-License, or (at your option) any later version.
-
-This manual is distributed in the hope that it will be useful, but
-WITHOUT ANY WARRANTY; without even the implied warranty of
-MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-General Public License for more details.
-
-You should have received a copy of the GNU General Public License
-along with this manual.  If not, see http://www.gnu.org/licenses/.
-@end quotation
-@end copying
-
-@dircategory QEMU
-@direntry
-* QEMU-GA-Ref: (qemu-ga-ref).   QEMU Guest Agent Protocol Reference
-@end direntry
-
-@titlepage
-@title Guest Agent Protocol Reference Manual
-@subtitle QEMU version @value{VERSION}
-@page
-@vskip 0pt plus 1filll
-@insertcopying
-@end titlepage
-
-@contents
-
-@ifnottex
-@node Top
-@top QEMU Guest Agent protocol reference
-@end ifnottex
-
-@menu
-* API Reference::
-* Commands and Events Index::
-* Data Types Index::
-@end menu
-
-@node API Reference
-@chapter API Reference
-
-@c for texi2pod:
-@c man begin DESCRIPTION
-
-@include qga/qga-qapi-doc.texi
-
-@c man end
-
-@node Commands and Events Index
-@unnumbered Commands and Events Index
-@printindex fn
-
-@node Data Types Index
-@unnumbered Data Types Index
-@printindex tp
-
-@bye
diff --git a/docs/meson.build b/docs/meson.build
index 50f367349b..2569dd52ad 100644
--- a/docs/meson.build
+++ b/docs/meson.build
@@ -15,6 +15,7 @@ if build_docs
   man_pages = {
     'interop' : {
         'qemu-ga.8': (have_tools ? 'man8' : ''),
+        'qemu-ga-ref.7': 'man7',
     },
     'tools': {
         'qemu-img.1': (have_tools ? 'man1' : ''),
diff --git a/meson.build b/meson.build
index d36dd085b5..c18764a408 100644
--- a/meson.build
+++ b/meson.build
@@ -1221,9 +1221,6 @@ if build_docs
   texi = {
     'qemu-qmp-ref': ['docs/interop/qemu-qmp-ref.texi', qapi_doc_texi, version_texi],
   }
-  if 'CONFIG_GUEST_AGENT' in config_host
-    texi += {'qemu-ga-ref': ['docs/interop/qemu-ga-ref.texi', qga_qapi_doc_texi, version_texi]}
-  endif
 
   if makeinfo.found()
     cmd = [
diff --git a/MAINTAINERS b/MAINTAINERS
index ac3e4e465c..e1e8ae277d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2421,9 +2421,9 @@ M: Michael Roth <mdroth@linux.vnet.ibm.com>
 S: Maintained
 F: qga/
 F: docs/interop/qemu-ga.rst
+F: docs/interop/qemu-ga-ref.rst
 F: scripts/qemu-guest-agent/
 F: tests/test-qga.c
-F: docs/interop/qemu-ga-ref.texi
 T: git https://github.com/mdroth/qemu.git qga
 
 QOM
diff --git a/qga/meson.build b/qga/meson.build
index e5c5778a3e..1c312b50cc 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -16,7 +16,7 @@ qga_qapi_outputs = [
 ]
 
 qga_qapi_files = custom_target('QGA QAPI files',
-                               output: qga_qapi_outputs + ['qga-qapi-doc.texi'],
+                               output: qga_qapi_outputs,
                                input: 'qapi-schema.json',
                                command: [ qapi_gen, '-o', 'qga', '-p', 'qga-', '@INPUT0@' ],
                                depend_files: qapi_gen_depends)
@@ -27,7 +27,6 @@ foreach output: qga_qapi_outputs
   qga_ss.add(qga_qapi_files[i])
   i = i + 1
 endforeach
-qga_qapi_doc_texi = qga_qapi_files[i]
 
 qga_ss.add(files(
   'commands.c',
-- 
2.26.2



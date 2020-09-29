Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5261BC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:28:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0ABE2076B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cr+jvLeV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0ABE2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNMF0-0005WB-GE
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 16:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNM6D-0001sD-Dy
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:19:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48433)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNM64-0003Uu-P8
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:19:45 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601410776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5xXGdpZWFIbYsKeR6BJ9bRVsOlgEvEJGRYy4+ov2b0E=;
 b=Cr+jvLeVGOYfA03OZsALpLOm+wOyKBtF+3+JUcWM9nu3lzsB/fUdThu8nMdut5nZXDzy5G
 N2x+JpEnoXVYUgdyvj8iPeH+b0tjpHtrlFS4bX8md/duKsmkPVJ9CLOOjiEvpDYpn3G2Pa
 XT3cPVR7MP1XmS+kZd9aBtxIFfPD+l0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-XkbWE1Z2O723Dl8a1WF0Yw-1; Tue, 29 Sep 2020 16:19:32 -0400
X-MC-Unique: XkbWE1Z2O723Dl8a1WF0Yw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DFA710BBEC3;
 Tue, 29 Sep 2020 20:19:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B2FB6198E;
 Tue, 29 Sep 2020 20:19:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BA56011358C3; Tue, 29 Sep 2020 22:19:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/29] scripts/qapi: Move doc-comment whitespace stripping to
 doc.py
Date: Tue, 29 Sep 2020 22:19:09 +0200
Message-Id: <20200929201926.2155622-13-armbru@redhat.com>
In-Reply-To: <20200929201926.2155622-1-armbru@redhat.com>
References: <20200929201926.2155622-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
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

As we accumulate lines from doc comments when parsing the JSON, the
QAPIDoc class generally strips leading and trailing whitespace using
line.strip() when it calls _append_freeform().  This is fine for
Texinfo, but for rST leading whitespace is significant.  We'd like to
move to having the text in doc comments be rST format rather than a
custom syntax, so move the removal of leading whitespace from the
QAPIDoc class to the texinfo-specific processing code in
texi_format() in qapi/doc.py.

(Trailing whitespace will always be stripped by the rstrip() in
Section::append regardless.)

In a followup commit we will make the whitespace in the lines of doc
comment sections more consistently follow the input source.

There is no change to the generated .texi files before and after this
commit.

Because the qapi-schema test checks the exact values of the
documentation comments against a reference, we need to update that
reference to match the new whitespace.  In the first four places this
is now correctly checking that we did put in the amount of whitespace
to pass a rST-formatted list to the backend; in the last two places
the extra whitespace is 'wrong' and will go away again in the
following commit.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20200925162316.21205-5-peter.maydell@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/doc.py            |  1 +
 scripts/qapi/parser.py         | 12 ++++--------
 tests/qapi-schema/doc-good.out | 12 ++++++------
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index 92f584edcf..7764de1e4b 100644
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -79,6 +79,7 @@ def texi_format(doc):
     inlist = ''
     lastempty = False
     for line in doc.split('\n'):
+        line = line.strip()
         empty = line == ''
 
         # FIXME: Doing this in a single if / elif chain is
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 165925ca72..04bf10db37 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -427,10 +427,10 @@ class QAPIDoc:
                 self._append_line = self._append_various_line
                 self._append_various_line(line)
             else:
-                self._append_freeform(line.strip())
+                self._append_freeform(line)
         else:
             # This is a free-form documentation block
-            self._append_freeform(line.strip())
+            self._append_freeform(line)
 
     def _append_args_line(self, line):
         """
@@ -463,7 +463,7 @@ class QAPIDoc:
                 self._append_various_line(line)
             return
 
-        self._append_freeform(line.strip())
+        self._append_freeform(line)
 
     def _append_features_line(self, line):
         name = line.split(' ', 1)[0]
@@ -482,7 +482,7 @@ class QAPIDoc:
             self._append_various_line(line)
             return
 
-        self._append_freeform(line.strip())
+        self._append_freeform(line)
 
     def _append_various_line(self, line):
         """
@@ -505,10 +505,6 @@ class QAPIDoc:
             line = line[len(name)+1:]
             self._start_section(name[:-1])
 
-        if (not self._section.name or
-                not self._section.name.startswith('Example')):
-            line = line.strip()
-
         self._append_freeform(line)
 
     def _start_symbol_section(self, symbols_dict, name):
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index acb00ade17..9993ffcd89 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -78,20 +78,20 @@ doc freeform
 
 * List item one
 * Two, multiple
-lines
+  lines
 
 * Three
-Still in list
+  Still in list
 
 Not in list
 
 - Second list
-Note: still in list
+  Note: still in list
 
 Note: not in list
 
 1. Third list
-is numbered
+   is numbered
 
 2. another item
 
@@ -159,7 +159,7 @@ doc symbol=Alternate
 
     arg=i
 an integer
-@b is undocumented
+    @b is undocumented
     arg=b
 
     feature=alt-feat
@@ -174,7 +174,7 @@ doc symbol=cmd
 the first argument
     arg=arg2
 the second
-argument
+       argument
     arg=arg3
 
     feature=cmd-feat1
-- 
2.26.2



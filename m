Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C47C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 06:58:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF68C2068D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 06:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T3hPel38"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF68C2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFXaL-0006rE-2K
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 02:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kFXWO-0001Jj-Um
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 02:54:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27143
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kFXWK-0008Co-JL
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 02:54:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599548064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e0Ubs2uV2UEdHWgEjuOwfwCOCjyIjZmVF40Od2GCpBI=;
 b=T3hPel38Ebam7owlJlwgED9Wv0/gsNBPrXsLxcCKKDpAVuqWmPUdh3H5qN21pM7xKRudTb
 o8wvwSNVMjYBemxc9lNpJrKUgkh9P0NPfekjhT/+jKK11Q9+vD3xKDH8LQvteloa6hLkzl
 v8F7MWS3ExeY5wX7Dv1DEfXDlR4AH0E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-eQcoPOgNPMmKwCWY0Lv22g-1; Tue, 08 Sep 2020 02:54:20 -0400
X-MC-Unique: eQcoPOgNPMmKwCWY0Lv22g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 868361008548;
 Tue,  8 Sep 2020 06:54:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-68.ams2.redhat.com
 [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3EB9360C0F;
 Tue,  8 Sep 2020 06:54:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 894B91132941; Tue,  8 Sep 2020 08:54:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/5] qapi: Make section headings start a new doc comment block
Date: Tue,  8 Sep 2020 08:54:14 +0200
Message-Id: <20200908065417.3158250-3-armbru@redhat.com>
In-Reply-To: <20200908065417.3158250-1-armbru@redhat.com>
References: <20200908065417.3158250-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 00:33:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Our current QAPI doc-comment markup allows section headers (introduced
with a leading '=' or '==') anywhere in a free-form documentation
comment.  This works for Texinfo because the generator simply prints a
Texinfo section command at that point in the output stream.  For rST
generation, since we're assembling a tree of docutils nodes, this is
awkward because a new section implies starting a new section node at
the top level of the tree and generating text into there.

Make section headers start a new free-form documentation block, so the
future rST document generator doesn't have to look at every line in
free-form blocks and handle headings in odd places.

This change makes no difference to the generated Texinfo.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200320091805.5585-3-armbru@redhat.com>
---
 scripts/qapi/parser.py         | 21 +++++++++++++--------
 tests/qapi-schema/doc-good.out |  3 ++-
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index f12c67d7d2..165925ca72 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -52,8 +52,8 @@ class QAPISchemaParser:
             info = self.info
             if self.tok == '#':
                 self.reject_expr_doc(cur_doc)
-                cur_doc = self.get_doc(info)
-                self.docs.append(cur_doc)
+                for cur_doc in self.get_doc(info):
+                    self.docs.append(cur_doc)
                 continue
 
             expr = self.get_expr(False)
@@ -270,7 +270,8 @@ class QAPISchemaParser:
             raise QAPIParseError(
                 self, "junk after '##' at start of documentation comment")
 
-        doc = QAPIDoc(self, info)
+        docs = []
+        cur_doc = QAPIDoc(self, info)
         self.accept(False)
         while self.tok == '#':
             if self.val.startswith('##'):
@@ -279,15 +280,20 @@ class QAPISchemaParser:
                     raise QAPIParseError(
                         self,
                         "junk after '##' at end of documentation comment")
-                doc.end_comment()
+                cur_doc.end_comment()
+                docs.append(cur_doc)
                 self.accept()
-                return doc
+                return docs
             if self.val.startswith('# ='):
-                if doc.symbol:
+                if cur_doc.symbol:
                     raise QAPIParseError(
                         self,
                         "unexpected '=' markup in definition documentation")
-            doc.append(self.val)
+                if cur_doc.body.text:
+                    cur_doc.end_comment()
+                    docs.append(cur_doc)
+                    cur_doc = QAPIDoc(self, info)
+            cur_doc.append(self.val)
             self.accept(False)
 
         raise QAPIParseError(self, "documentation comment must end with '##'")
@@ -316,7 +322,6 @@ class QAPIDoc:
         def __init__(self, name=None):
             # optional section name (argument/member or section name)
             self.name = name
-            # the list of lines for this section
             self.text = ''
 
         def append(self, line):
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index 6757dd26a2..d78a424cd9 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -69,7 +69,8 @@ event EVT-BOXED Object
 doc freeform
     body=
 = Section
-
+doc freeform
+    body=
 == Subsection
 
 *strong* _with emphasis_
-- 
2.26.2



Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01771C47420
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:32:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D50A2076B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RP4QHz84"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D50A2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNMI6-0000vK-1l
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 16:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNM6G-0001uz-KF
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:19:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57945)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNM65-0003Uz-TR
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:19:48 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601410776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XDFJeVUsisnwDdRZpH272FpeMreIsJc+R3Xwkz1S64E=;
 b=RP4QHz84YQfhaA3cONV1MmUW5Bi1CIUR5mT7aP5YhVqGT6QJkCT7bO7SyLz1YDO+VFCjTB
 cIJtOG8r6jfAin2p40CBf5Zp9vGy3Jn68wOukoebfMNveMHC46Fu2dpRFF68ivsYuJFiws
 qih0mBcAoFoeTDxJg4G6sBuh5vteEd8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-w3dtr8e_OqeuXc4HY_u71A-1; Tue, 29 Sep 2020 16:19:34 -0400
X-MC-Unique: w3dtr8e_OqeuXc4HY_u71A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15AF5801AE9;
 Tue, 29 Sep 2020 20:19:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B435219C4F;
 Tue, 29 Sep 2020 20:19:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ED04711358D8; Tue, 29 Sep 2020 22:19:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 25/29] docs/devel/qapi-code-gen.txt: Update to new rST backend
 conventions
Date: Tue, 29 Sep 2020 22:19:22 +0200
Message-Id: <20200929201926.2155622-26-armbru@redhat.com>
In-Reply-To: <20200929201926.2155622-1-armbru@redhat.com>
References: <20200929201926.2155622-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

Update the documentation of QAPI document comment syntax to match
the new rST backend requirements. The principal changes are:
 * whitespace is now significant, and multiline definitions
   must have their second and subsequent lines indented to
   match the first line
 * general rST format markup is permitted, not just the small
   set of markup the old texinfo generator handled. For most
   things (notably bulleted and itemized lists) the old format
   was the same as rST is.
 * Specific things that might trip people up:
   - instead of *bold* and _italic_ rST has **bold** and *italic*
   - lists need a preceding and following blank line
   - a lone literal '*' will need to be backslash-escaped to
     avoid a rST syntax error
 * the old leading '|' for example (literal text) blocks is
   replaced by the standard rST '::' literal block.
 * we support arbitrary levels of sub- and sub-sub-heading, not
   just a main and sub-heading like the old texinfo generator
 * lists can now be nested

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20200925162316.21205-18-peter.maydell@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Commit message improved slightly]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-code-gen.txt | 83 +++++++++++++++++++++++-------------
 1 file changed, 53 insertions(+), 30 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 2a09d4d292..5fc67c99cd 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -824,23 +824,37 @@ See below for more on definition documentation.
 Free-form documentation may be used to provide additional text and
 structuring content.
 
+==== Headings and subheadings ====
+
+A free-form documentation comment containing a line which starts with
+some '=' symbols and then a space defines a section heading:
+
+    ##
+    # = This is a top level heading
+    #
+    # This is a free-form comment which will go under the
+    # top level heading.
+    ##
+
+    ##
+    # == This is a second level heading
+    ##
+
+A heading line must be the first line of the documentation
+comment block.
+
+Section headings must always be correctly nested, so you can only
+define a third-level heading inside a second-level heading, and so on.
 
 ==== Documentation markup ====
 
-Comment text starting with '=' is a section title:
+Documentation comments can use most rST markup.  In particular,
+a '::' literal block can be used for examples:
 
-    # = Section title
-
-Double the '=' for a subsection title:
-
-    # == Subsection title
-
-Both are only permitted in free-form documentation.
-
-'|' denotes examples:
-
-    # | Text of the example, may span
-    # | multiple lines
+    # ::
+    #
+    #   Text of the example, may span
+    #   multiple lines
 
 '*' starts an itemized list:
 
@@ -856,34 +870,33 @@ A decimal number followed by '.' starts a numbered list:
     #    multiple lines
     # 2. Second item
 
-The actual number doesn't matter.  You could even use '*' instead of
-'2.' for the second item.
+The actual number doesn't matter.
 
-Lists can't be nested.  Blank lines are currently not supported within
-lists.
+Lists of either kind must be preceded and followed by a blank line.
+If a list item's text spans multiple lines, then the second and
+subsequent lines must be correctly indented to line up with the
+first character of the first line.
 
-Additional whitespace between the initial '#' and the comment text is
-permitted.
-
-*foo* and _foo_ are for strong and emphasis styles respectively (they
-do not work over multiple lines).  @foo is used to reference a name in
-the schema.
+The usual '**strong**', '*emphasised*' and '``literal``' markup should
+be used.  If you need a single literal '*' you will need to
+backslash-escape it.  As an extension beyond the usual rST syntax, you
+can also use '@foo' to reference a name in the schema; this is
+rendered the same way as '``foo``'.
 
 Example:
 
 ##
-# = Section
-# == Subsection
-#
-# Some text foo with *strong* and _emphasis_
+# Some text foo with **bold** and *emphasis*
 # 1. with a list
 # 2. like that
 #
 # And some code:
-# | $ echo foo
-# | -> do this
-# | <- get that
 #
+# ::
+#
+#   $ echo foo
+#   -> do this
+#   <- get that
 ##
 
 
@@ -937,6 +950,16 @@ multiline argument descriptions.
 A 'Since: x.y.z' tagged section lists the release that introduced the
 definition.
 
+The text of a section can start on a new line, in
+which case it must not be indented at all.  It can also start
+on the same line as the 'Note:', 'Returns:', etc tag.  In this
+case if it spans multiple lines then second and subsequent
+lines must be indented to match the first.
+
+An 'Example' or 'Examples' section is automatically rendered
+entirely as literal fixed-width text.  In other sections,
+the text is formatted, and rST markup can be used.
+
 For example:
 
 ##
-- 
2.26.2



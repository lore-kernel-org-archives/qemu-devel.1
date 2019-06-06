Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456D3C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 12:03:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 065B8207E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 12:03:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 065B8207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59468 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYr7Y-0002Mw-8u
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 08:03:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hYr6Z-00021u-1F
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 08:02:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hYr6X-0003zA-7k
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 08:02:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hYr6P-0003AZ-CE; Thu, 06 Jun 2019 08:02:42 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7A88A80F79;
	Thu,  6 Jun 2019 12:01:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
	[10.36.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 093B7519C3;
	Thu,  6 Jun 2019 12:01:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 7447311386A0; Thu,  6 Jun 2019 14:01:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
References: <20190530110255.16225-1-kwolf@redhat.com>
	<20190530110255.16225-5-kwolf@redhat.com>
	<87blzbhs48.fsf@dusky.pond.sub.org>
Date: Thu, 06 Jun 2019 14:01:57 +0200
In-Reply-To: <87blzbhs48.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Thu, 06 Jun 2019 13:26:31 +0200")
Message-ID: <87muiuhqh6.fsf_-_@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Thu, 06 Jun 2019 12:02:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 4.5/6] qapi: Replace QAPIDoc._part by
 ._append_line, and rework comments
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pkrempa@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
This is on top of the fixup I appended to my review of v4.  I'd squash
all three patches together.

The next patch needs to be updated for this.

Unsquashed branch at git://repo.or.cz/qemu/armbru.git branch
qapi-features.

Let me know what you think.

 scripts/qapi/common.py | 109 ++++++++++++++++++++++++-----------------
 1 file changed, 63 insertions(+), 46 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index b42dad9b36..004b68df5c 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -102,6 +102,22 @@ class QAPISemError(QAPIError):
 
 
 class QAPIDoc(object):
+    """
+    A documentation comment block, either expression or free-form
+
+    Expression documentation blocks consist of
+
+    * a body section: one line naming the expression, followed by an
+      overview (any number of lines)
+
+    * argument sections: a description of each argument (for commands
+      and events) or member (for structs, unions and alternates)
+
+    * additional (non-argument) sections, possibly tagged
+
+    Free-form documentation blocks consist only of a body section.
+    """
+
     class Section(object):
         def __init__(self, name=None):
             # optional section name (argument/member or section name)
@@ -120,22 +136,6 @@ class QAPIDoc(object):
         def connect(self, member):
             self.member = member
 
-    class DocPart:
-        """
-        Expression documentation blocks consist of
-        * a BODY part: first line naming the expression, plus an
-          optional overview
-        * an ARGS part: description of each argument (for commands and
-          events) or member (for structs, unions and alternates),
-        * a VARIOUS part: optional tagged sections.
-
-        Free-form documentation blocks consist only of a BODY part.
-        """
-        # TODO Make it a subclass of Enum when Python 2 support is removed
-        BODY = 1
-        ARGS = 2
-        VARIOUS = 3
-
     def __init__(self, parser, info):
         # self._parser is used to report errors with QAPIParseError.  The
         # resulting error position depends on the state of the parser.
@@ -151,7 +151,7 @@ class QAPIDoc(object):
         self.sections = []
         # the current section
         self._section = self.body
-        self._part = QAPIDoc.DocPart.BODY
+        self._append_line = self._append_body_line
 
     def has_section(self, name):
         """Return True if we have a section with this name."""
@@ -164,20 +164,11 @@ class QAPIDoc(object):
         """
         Parse a comment line and add it to the documentation.
 
-        The way that the line is dealt with depends on which part of the
-        documentation we're parsing right now:
-
-        BODY means that we're ready to process free-form text into self.body. A
-        symbol name is only allowed if no other text was parsed yet. It is
-        interpreted as the symbol name that describes the currently documented
-        object. On getting the second symbol name, we proceed to ARGS.
-
-        ARGS means that we're parsing the arguments section. Any symbol name is
-        interpreted as an argument and an ArgSection is created for it.
-
-        VARIOUS is the final part where free-form sections may appear. This
-        includes named sections such as "Return:" as well as unnamed
-        paragraphs. Symbols are not allowed any more in this part.
+        The way that the line is dealt with depends on which part of
+        the documentation we're parsing right now:
+        * The body section: ._append_line is ._append_body_line
+        * An argument section: ._append_line is ._append_args_line
+        * An additional section: ._append_line is ._append_various_line
         """
         line = line[1:]
         if not line:
@@ -187,15 +178,7 @@ class QAPIDoc(object):
         if line[0] != ' ':
             raise QAPIParseError(self._parser, "Missing space after #")
         line = line[1:]
-
-        if self._part == QAPIDoc.DocPart.BODY:
-            self._append_body_line(line)
-        elif self._part == QAPIDoc.DocPart.ARGS:
-            self._append_args_line(line)
-        elif self._part == QAPIDoc.DocPart.VARIOUS:
-            self._append_various_line(line)
-        else:
-            assert False
+        self._append_line(line)
 
     def end_comment(self):
         self._end_section()
@@ -209,6 +192,19 @@ class QAPIDoc(object):
                         'TODO:')
 
     def _append_body_line(self, line):
+        """
+        Process a line of documentation text in the body section.
+
+        If this a symbol line and it is the section's first line, this
+        is an expression documentation block for that symbol.
+
+        If it's an expression documentation block, another symbol line
+        begins the argument section for the argument named by it, and
+        a section tag begins an additional section.  Start that
+        section and append the line to it.
+
+        Else, append the line to the current section.
+        """
         name = line.split(' ', 1)[0]
         # FIXME not nice: things like '#  @foo:' and '# @foo: ' aren't
         # recognized, and get silently treated as ordinary text
@@ -220,39 +216,60 @@ class QAPIDoc(object):
             if not self.symbol:
                 raise QAPIParseError(self._parser, "Invalid name")
         elif self.symbol:
-            # We already know that we document some symbol
+            # This is an expression documentation block
             if name.startswith('@') and name.endswith(':'):
-                self._part = QAPIDoc.DocPart.ARGS
+                self._append_line = self._append_args_line
                 self._append_args_line(line)
             elif self._is_section_tag(name):
-                self._part = QAPIDoc.DocPart.VARIOUS
+                self._append_line = self._append_various_line
                 self._append_various_line(line)
             else:
                 self._append_freeform(line.strip())
         else:
-            # This is free-form documentation without a symbol
+            # This is a free-form documentation block
             self._append_freeform(line.strip())
 
     def _append_args_line(self, line):
+        """
+        Process a line of documentation text in an argument section.
+
+        A symbol line begins the next argument section, a section tag
+        section or a non-indented line after a blank line begins an
+        additional section.  Start that section and append the line to
+        it.
+
+        Else, append the line to the current section.
+
+        """
         name = line.split(' ', 1)[0]
 
         if name.startswith('@') and name.endswith(':'):
             line = line[len(name)+1:]
             self._start_args_section(name[1:-1])
         elif self._is_section_tag(name):
-            self._part = QAPIDoc.DocPart.VARIOUS
+            self._append_line = self._append_various_line
             self._append_various_line(line)
             return
         elif (self._section.text.endswith('\n\n')
               and line and not line[0].isspace()):
             self._start_section()
-            self._part = QAPIDoc.DocPart.VARIOUS
+            self._append_line = self._append_various_line
             self._append_various_line(line)
             return
 
         self._append_freeform(line.strip())
 
     def _append_various_line(self, line):
+        """
+        Process a line of documentation text in an additional section.
+
+        A symbol line is an error.
+
+        A section tag begins an additional section.  Start that
+        section and append the line to it.
+
+        Else, append the line to the current section.
+        """
         name = line.split(' ', 1)[0]
 
         if name.startswith('@') and name.endswith(':'):
-- 
2.21.0



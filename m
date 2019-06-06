Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1027C28EB4
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:28:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 796742070B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 796742070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58738 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYqZB-0000XM-PS
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 07:28:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hYqXb-0007t8-SR
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:26:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hYqXZ-0004yw-MC
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:26:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hYqXV-0004rl-Bw; Thu, 06 Jun 2019 07:26:37 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CA064C18B2CA;
	Thu,  6 Jun 2019 11:26:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
	[10.36.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B194104B4F1;
	Thu,  6 Jun 2019 11:26:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id CFF8811386A0; Thu,  6 Jun 2019 13:26:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
References: <20190530110255.16225-1-kwolf@redhat.com>
	<20190530110255.16225-5-kwolf@redhat.com>
Date: Thu, 06 Jun 2019 13:26:31 +0200
In-Reply-To: <20190530110255.16225-5-kwolf@redhat.com> (Kevin Wolf's message
	of "Thu, 30 May 2019 13:02:53 +0200")
Message-ID: <87blzbhs48.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Thu, 06 Jun 2019 11:26:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 4/6] qapi: Disentangle QAPIDoc code
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

Kevin Wolf <kwolf@redhat.com> writes:

> Documentation comments follow a certain structure: First, we have a text
> with a general description (called QAPIDoc.body). After this,
> descriptions of the arguments follow. Finally, we have a part that
> contains various named sections.
>
> The code doesn't show this structure, but just checks various attributes
> that indicate indirectly which part is being processed, so it happens to
> do the right set of things in the right phase. This is hard to follow,
> and adding support for documentation of features would be even harder.
>
> This patch restructures the code so that the three parts are clearly
> separated. The code becomes a bit longer, but easier to follow. The
> resulting output remains unchanged.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  scripts/qapi/common.py | 122 ++++++++++++++++++++++++++++++++---------
>  1 file changed, 97 insertions(+), 25 deletions(-)
>
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index 9e4b6c00b5..55ccd216cf 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -120,6 +120,22 @@ class QAPIDoc(object):
>          def connect(self, member):
>              self.member = member
>  
> +    class DocPart:
> +        """

Did you drop the "A documentation part" headline intentionally?

> +        Expression documentation blocks consist of
> +        * a BODY part: first line naming the expression, plus an
> +          optional overview
> +        * an ARGS part: description of each argument (for commands and
> +          events) or member (for structs, unions and alternates),
> +        * a VARIOUS part: optional tagged sections.
> +
> +        Free-form documentation blocks consist only of a BODY part.
> +        """
> +        # TODO Make it a subclass of Enum when Python 2 support is removed
> +        BODY = 1
> +        ARGS = 2
> +        VARIOUS = 3
> +
>      def __init__(self, parser, info):
>          # self._parser is used to report errors with QAPIParseError.  The
>          # resulting error position depends on the state of the parser.
> @@ -135,6 +151,7 @@ class QAPIDoc(object):
>          self.sections = []
>          # the current section
>          self._section = self.body
> +        self._part = QAPIDoc.DocPart.BODY
>  
>      def has_section(self, name):
>          """Return True if we have a section with this name."""
> @@ -144,7 +161,24 @@ class QAPIDoc(object):
>          return False
>  
>      def append(self, line):
> -        """Parse a comment line and add it to the documentation."""
> +        """
> +        Parse a comment line and add it to the documentation.
> +
> +        The way that the line is dealt with depends on which part of the
> +        documentation we're parsing right now:
> +
> +        BODY means that we're ready to process free-form text into self.body. A
> +        symbol name is only allowed if no other text was parsed yet. It is
> +        interpreted as the symbol name that describes the currently documented
> +        object. On getting the second symbol name, we proceed to ARGS.
> +
> +        ARGS means that we're parsing the arguments section. Any symbol name is
> +        interpreted as an argument and an ArgSection is created for it.
> +
> +        VARIOUS is the final part where free-form sections may appear. This
> +        includes named sections such as "Return:" as well as unnamed
> +        paragraphs. Symbols are not allowed any more in this part.
> +        """

A few little things:

* The reader has to make the connection from BODY, ARGS, VARIOUS to
  self._part.  To help him a bit, I'd say something like "depends on
  which part of the documentation we're parsing right now, according to
  self._part:"

* In the paragraph on BODY: on first reading, "A symbol name is only
  allowed if no other text was parsed yet" appears to contradict "On
  getting the second symbol name".  It doesn't: the second symbol name
  doesn't belong to this part.  Perhaps we could phrase this more
  clearly.  Not sure it's worth the trouble.

* PEP 8: "For flowing long blocks of text with fewer structural
  restrictions (docstrings or comments), the line length should be
  limited to 72 characters."

* PEP 8: "You should use two spaces after a sentence-ending period in
  multi-sentence comments, except after the final sentence."

>          line = line[1:]
>          if not line:
>              self._append_freeform(line)
> @@ -154,37 +188,85 @@ class QAPIDoc(object):
>              raise QAPIParseError(self._parser, "Missing space after #")
>          line = line[1:]
>  
> +        if self._part == QAPIDoc.DocPart.BODY:
> +            self._append_body_line(line)
> +        elif self._part == QAPIDoc.DocPart.ARGS:
> +            self._append_args_line(line)
> +        elif self._part == QAPIDoc.DocPart.VARIOUS:
> +            self._append_various_line(line)
> +        else:
> +            assert False

In my review of v2, I suggested to use a function-valued variable for
the state machine.  I explored this, and will send my findings
separately.

> +
> +    def end_comment(self):
> +        self._end_section()
> +
> +    def _check_named_section(self, name):
> +        if name in ('Returns:', 'Since:',
> +                    # those are often singular or plural
> +                    'Note:', 'Notes:',
> +                    'Example:', 'Examples:',
> +                    'TODO:'):
> +            self._part = QAPIDoc.DocPart.VARIOUS
> +            return True
> +        return False

The side effect hidden in this function confused me once again, so I
played with the code to see whether avoiding it would be bothersome.
Turns out it isn't, proposed fixup appended.

> +
> +    def _append_body_line(self, line):
> +        name = line.split(' ', 1)[0]
>          # FIXME not nice: things like '#  @foo:' and '# @foo: ' aren't
>          # recognized, and get silently treated as ordinary text
> -        if self.symbol:
> -            self._append_symbol_line(line)
> -        elif not self.body.text and line.startswith('@'):
> +        if not self.symbol and not self.body.text and line.startswith('@'):
>              if not line.endswith(':'):
>                  raise QAPIParseError(self._parser, "Line should end with :")
>              self.symbol = line[1:-1]
>              # FIXME invalid names other than the empty string aren't flagged
>              if not self.symbol:
>                  raise QAPIParseError(self._parser, "Invalid name")
> +        elif self.symbol:
> +            # We already know that we document some symbol
> +            if name.startswith('@') and name.endswith(':'):
> +                self._part = QAPIDoc.DocPart.ARGS
> +                self._append_args_line(line)
> +            elif self.symbol and self._check_named_section(name):

Checking self.symbol again is redundant.

> +                self._append_various_line(line)
> +            else:
> +                self._append_freeform(line.strip())
>          else:
> -            self._append_freeform(line)
> -
> -    def end_comment(self):
> -        self._end_section()
> +            # This is free-form documentation without a symbol
> +            self._append_freeform(line.strip())
>  
> -    def _append_symbol_line(self, line):
> +    def _append_args_line(self, line):
>          name = line.split(' ', 1)[0]
>  
>          if name.startswith('@') and name.endswith(':'):
>              line = line[len(name)+1:]
>              self._start_args_section(name[1:-1])
> -        elif name in ('Returns:', 'Since:',
> -                      # those are often singular or plural
> -                      'Note:', 'Notes:',
> -                      'Example:', 'Examples:',
> -                      'TODO:'):
> +        elif self._check_named_section(name):
> +            self._append_various_line(line)
> +            return
> +        elif (self._section.text.endswith('\n\n')
> +              and line and not line[0].isspace()):
> +            self._start_section()
> +            self._part = QAPIDoc.DocPart.VARIOUS
> +            self._append_various_line(line)
> +            return
> +
> +        self._append_freeform(line.strip())
> +
> +    def _append_various_line(self, line):
> +        name = line.split(' ', 1)[0]
> +
> +        if name.startswith('@') and name.endswith(':'):
> +            raise QAPIParseError(self._parser,
> +                                 "'%s' can't follow '%s' section"
> +                                 % (name, self.sections[0].name))
> +        elif self._check_named_section(name):
>              line = line[len(name)+1:]
>              self._start_section(name[:-1])
>  
> +        if (not self._section.name or
> +                not self._section.name.startswith('Example')):
> +            line = line.strip()
> +
>          self._append_freeform(line)
>  
>      def _start_args_section(self, name):
> @@ -194,10 +276,7 @@ class QAPIDoc(object):
>          if name in self.args:
>              raise QAPIParseError(self._parser,
>                                   "'%s' parameter name duplicated" % name)
> -        if self.sections:
> -            raise QAPIParseError(self._parser,
> -                                 "'@%s:' can't follow '%s' section"
> -                                 % (name, self.sections[0].name))
> +        assert not self.sections
>          self._end_section()
>          self._section = QAPIDoc.ArgSection(name)
>          self.args[name] = self._section
> @@ -219,13 +298,6 @@ class QAPIDoc(object):
>              self._section = None
>  
>      def _append_freeform(self, line):
> -        in_arg = isinstance(self._section, QAPIDoc.ArgSection)
> -        if (in_arg and self._section.text.endswith('\n\n')
> -                and line and not line[0].isspace()):
> -            self._start_section()
> -        if (in_arg or not self._section.name
> -                or not self._section.name.startswith('Example')):
> -            line = line.strip()
>          match = re.match(r'(@\S+:)', line)
>          if match:
>              raise QAPIParseError(self._parser,

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 55ccd216cf..b42dad9b36 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -200,15 +200,13 @@ class QAPIDoc(object):
     def end_comment(self):
         self._end_section()
 
-    def _check_named_section(self, name):
-        if name in ('Returns:', 'Since:',
-                    # those are often singular or plural
-                    'Note:', 'Notes:',
-                    'Example:', 'Examples:',
-                    'TODO:'):
-            self._part = QAPIDoc.DocPart.VARIOUS
-            return True
-        return False
+    @staticmethod
+    def _is_section_tag(name):
+        return name in ('Returns:', 'Since:',
+                        # those are often singular or plural
+                        'Note:', 'Notes:',
+                        'Example:', 'Examples:',
+                        'TODO:')
 
     def _append_body_line(self, line):
         name = line.split(' ', 1)[0]
@@ -226,7 +224,8 @@ class QAPIDoc(object):
             if name.startswith('@') and name.endswith(':'):
                 self._part = QAPIDoc.DocPart.ARGS
                 self._append_args_line(line)
-            elif self.symbol and self._check_named_section(name):
+            elif self._is_section_tag(name):
+                self._part = QAPIDoc.DocPart.VARIOUS
                 self._append_various_line(line)
             else:
                 self._append_freeform(line.strip())
@@ -240,7 +239,8 @@ class QAPIDoc(object):
         if name.startswith('@') and name.endswith(':'):
             line = line[len(name)+1:]
             self._start_args_section(name[1:-1])
-        elif self._check_named_section(name):
+        elif self._is_section_tag(name):
+            self._part = QAPIDoc.DocPart.VARIOUS
             self._append_various_line(line)
             return
         elif (self._section.text.endswith('\n\n')
@@ -259,7 +259,7 @@ class QAPIDoc(object):
             raise QAPIParseError(self._parser,
                                  "'%s' can't follow '%s' section"
                                  % (name, self.sections[0].name))
-        elif self._check_named_section(name):
+        elif self._is_section_tag(name):
             line = line[len(name)+1:]
             self._start_section(name[:-1])
 


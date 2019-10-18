Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D282ECA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 08:02:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75E492089C
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 08:02:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75E492089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLNDR-0003xN-0M
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 04:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59575)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iLMve-0000p1-Vo
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:44:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iLMvT-0007kF-P1
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:44:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59770)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iLMvT-0007jN-3w
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:43:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 56FBE18B20E8;
 Fri, 18 Oct 2019 07:43:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EB4B15C1B5;
 Fri, 18 Oct 2019 07:43:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9B56B11329CF; Fri, 18 Oct 2019 09:43:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 6/7] qapi: Split up scripts/qapi/common.py
Date: Fri, 18 Oct 2019 09:43:44 +0200
Message-Id: <20191018074345.24034-7-armbru@redhat.com>
In-Reply-To: <20191018074345.24034-1-armbru@redhat.com>
References: <20191018074345.24034-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Fri, 18 Oct 2019 07:43:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: kwolf@redhat.com, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The QAPI code generator clocks in at some 3100 SLOC in 8 source files.
Almost 60% of the code is in qapi/common.py.  Split it into more
focused modules:

* Move QAPISchemaPragma and QAPISourceInfo to qapi/source.py.

* Move QAPIError and its sub-classes to qapi/error.py.

* Move QAPISchemaParser and QAPIDoc to parser.py.  Use the opportunity
  to put QAPISchemaParser first.

* Move check_expr() & friends to qapi/expr.py.  Use the opportunity to
  put the code into a more sensible order.

* Move QAPISchema & friends to qapi/schema.py

* Move QAPIGen and its sub-classes, ifcontext,
  QAPISchemaModularCVisitor, and QAPISchemaModularCVisitor to qapi/gen.py

* Delete camel_case(), it's unused since commit e98859a9b9 "qapi:
  Clean up after recent conversions to QAPISchemaVisitor"

A number of helper functions remain in qapi/common.py.  I considered
moving the code generator helpers to qapi/gen.py, but decided not to.
Perhaps we should rewrite them as methods of QAPIGen some day.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 Makefile                       |   13 +-
 scripts/qapi-gen.py            |   10 +-
 scripts/qapi/commands.py       |    1 +
 scripts/qapi/common.py         | 2321 --------------------------------
 scripts/qapi/doc.py            |    7 +-
 scripts/qapi/error.py          |   42 +
 scripts/qapi/events.py         |    2 +
 scripts/qapi/expr.py           |  377 ++++++
 scripts/qapi/gen.py            |  290 ++++
 scripts/qapi/introspect.py     |    5 +
 scripts/qapi/parser.py         |  569 ++++++++
 scripts/qapi/schema.py         | 1042 ++++++++++++++
 scripts/qapi/source.py         |   67 +
 scripts/qapi/types.py          |    2 +
 scripts/qapi/visit.py          |    2 +
 tests/Makefile.include         |   13 +-
 tests/qapi-schema/test-qapi.py |    6 +-
 17 files changed, 2434 insertions(+), 2335 deletions(-)
 create mode 100644 scripts/qapi/error.py
 create mode 100644 scripts/qapi/expr.py
 create mode 100644 scripts/qapi/gen.py
 create mode 100644 scripts/qapi/parser.py
 create mode 100644 scripts/qapi/schema.py
 create mode 100644 scripts/qapi/source.py

diff --git a/Makefile b/Makefile
index d20e7ffce3..0e994a275d 100644
--- a/Makefile
+++ b/Makefile
@@ -582,13 +582,20 @@ qemu-ga$(EXESUF): QEMU_CFLAGS +=3D -I qga/qapi-gene=
rated
 qemu-keymap$(EXESUF): LIBS +=3D $(XKBCOMMON_LIBS)
 qemu-keymap$(EXESUF): QEMU_CFLAGS +=3D $(XKBCOMMON_CFLAGS)
=20
-qapi-py =3D $(SRC_PATH)/scripts/qapi/commands.py \
+qapi-py =3D $(SRC_PATH)/scripts/qapi/__init__.py \
+$(SRC_PATH)/scripts/qapi/commands.py \
+$(SRC_PATH)/scripts/qapi/common.py \
+$(SRC_PATH)/scripts/qapi/doc.py \
+$(SRC_PATH)/scripts/qapi/error.py \
 $(SRC_PATH)/scripts/qapi/events.py \
+$(SRC_PATH)/scripts/qapi/expr.py \
+$(SRC_PATH)/scripts/qapi/gen.py \
 $(SRC_PATH)/scripts/qapi/introspect.py \
+$(SRC_PATH)/scripts/qapi/parser.py \
+$(SRC_PATH)/scripts/qapi/schema.py \
+$(SRC_PATH)/scripts/qapi/source.py \
 $(SRC_PATH)/scripts/qapi/types.py \
 $(SRC_PATH)/scripts/qapi/visit.py \
-$(SRC_PATH)/scripts/qapi/common.py \
-$(SRC_PATH)/scripts/qapi/doc.py \
 $(SRC_PATH)/scripts/qapi-gen.py
=20
 qga/qapi-generated/qga-qapi-types.c qga/qapi-generated/qga-qapi-types.h =
\
diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
index 3d98ca2e0c..f93f3c7c23 100755
--- a/scripts/qapi-gen.py
+++ b/scripts/qapi-gen.py
@@ -5,16 +5,18 @@
 # See the COPYING file in the top-level directory.
=20
 from __future__ import print_function
+
 import argparse
 import re
 import sys
-from qapi.common import QAPIError, QAPISchema
-from qapi.types import gen_types
-from qapi.visit import gen_visit
+
 from qapi.commands import gen_commands
+from qapi.doc import gen_doc
 from qapi.events import gen_events
 from qapi.introspect import gen_introspect
-from qapi.doc import gen_doc
+from qapi.schema import QAPIError, QAPISchema
+from qapi.types import gen_types
+from qapi.visit import gen_visit
=20
=20
 def main(argv):
diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 7e3dd1068a..898516b086 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -14,6 +14,7 @@ See the COPYING file in the top-level directory.
 """
=20
 from qapi.common import *
+from qapi.gen import QAPIGenCCode, QAPISchemaModularCVisitor, ifcontext
=20
=20
 def gen_command_decl(name, arg_type, boxed, ret_type):
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 306857f0c0..e00dcafce7 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -11,2056 +11,8 @@
 # This work is licensed under the terms of the GNU GPL, version 2.
 # See the COPYING file in the top-level directory.
=20
-from __future__ import print_function
-from contextlib import contextmanager
-import copy
-import errno
-import os
 import re
 import string
-import sys
-from collections import OrderedDict
-
-
-#
-# Parsing the schema into expressions
-#
-
-
-class QAPISchemaPragma(object):
-    def __init__(self):
-        # Are documentation comments required?
-        self.doc_required =3D False
-        # Whitelist of commands allowed to return a non-dictionary
-        self.returns_whitelist =3D []
-        # Whitelist of entities allowed to violate case conventions
-        self.name_case_whitelist =3D []
-
-
-class QAPISourceInfo(object):
-    def __init__(self, fname, line, parent):
-        self.fname =3D fname
-        self.line =3D line
-        self.parent =3D parent
-        self.pragma =3D parent.pragma if parent else QAPISchemaPragma()
-        self.defn_meta =3D None
-        self.defn_name =3D None
-
-    def set_defn(self, meta, name):
-        self.defn_meta =3D meta
-        self.defn_name =3D name
-
-    def next_line(self):
-        info =3D copy.copy(self)
-        info.line +=3D 1
-        return info
-
-    def loc(self):
-        if self.fname is None:
-            return sys.argv[0]
-        ret =3D self.fname
-        if self.line is not None:
-            ret +=3D ':%d' % self.line
-        return ret
-
-    def in_defn(self):
-        if self.defn_name:
-            return "%s: In %s '%s':\n" % (self.fname,
-                                          self.defn_meta, self.defn_name=
)
-        return ''
-
-    def include_path(self):
-        ret =3D ''
-        parent =3D self.parent
-        while parent:
-            ret =3D 'In file included from %s:\n' % parent.loc() + ret
-            parent =3D parent.parent
-        return ret
-
-    def __str__(self):
-        return self.include_path() + self.in_defn() + self.loc()
-
-
-class QAPIError(Exception):
-    def __init__(self, info, col, msg):
-        Exception.__init__(self)
-        self.info =3D info
-        self.col =3D col
-        self.msg =3D msg
-
-    def __str__(self):
-        loc =3D str(self.info)
-        if self.col is not None:
-            assert self.info.line is not None
-            loc +=3D ':%s' % self.col
-        return loc + ': ' + self.msg
-
-
-class QAPIParseError(QAPIError):
-    def __init__(self, parser, msg):
-        col =3D 1
-        for ch in parser.src[parser.line_pos:parser.pos]:
-            if ch =3D=3D '\t':
-                col =3D (col + 7) % 8 + 1
-            else:
-                col +=3D 1
-        QAPIError.__init__(self, parser.info, col, msg)
-
-
-class QAPISemError(QAPIError):
-    def __init__(self, info, msg):
-        QAPIError.__init__(self, info, None, msg)
-
-
-class QAPIDoc(object):
-    """
-    A documentation comment block, either definition or free-form
-
-    Definition documentation blocks consist of
-
-    * a body section: one line naming the definition, followed by an
-      overview (any number of lines)
-
-    * argument sections: a description of each argument (for commands
-      and events) or member (for structs, unions and alternates)
-
-    * features sections: a description of each feature flag
-
-    * additional (non-argument) sections, possibly tagged
-
-    Free-form documentation blocks consist only of a body section.
-    """
-
-    class Section(object):
-        def __init__(self, name=3DNone):
-            # optional section name (argument/member or section name)
-            self.name =3D name
-            # the list of lines for this section
-            self.text =3D ''
-
-        def append(self, line):
-            self.text +=3D line.rstrip() + '\n'
-
-    class ArgSection(Section):
-        def __init__(self, name):
-            QAPIDoc.Section.__init__(self, name)
-            self.member =3D None
-
-        def connect(self, member):
-            self.member =3D member
-
-    def __init__(self, parser, info):
-        # self._parser is used to report errors with QAPIParseError.  Th=
e
-        # resulting error position depends on the state of the parser.
-        # It happens to be the beginning of the comment.  More or less
-        # servicable, but action at a distance.
-        self._parser =3D parser
-        self.info =3D info
-        self.symbol =3D None
-        self.body =3D QAPIDoc.Section()
-        # dict mapping parameter name to ArgSection
-        self.args =3D OrderedDict()
-        self.features =3D OrderedDict()
-        # a list of Section
-        self.sections =3D []
-        # the current section
-        self._section =3D self.body
-        self._append_line =3D self._append_body_line
-
-    def has_section(self, name):
-        """Return True if we have a section with this name."""
-        for i in self.sections:
-            if i.name =3D=3D name:
-                return True
-        return False
-
-    def append(self, line):
-        """
-        Parse a comment line and add it to the documentation.
-
-        The way that the line is dealt with depends on which part of
-        the documentation we're parsing right now:
-        * The body section: ._append_line is ._append_body_line
-        * An argument section: ._append_line is ._append_args_line
-        * A features section: ._append_line is ._append_features_line
-        * An additional section: ._append_line is ._append_various_line
-        """
-        line =3D line[1:]
-        if not line:
-            self._append_freeform(line)
-            return
-
-        if line[0] !=3D ' ':
-            raise QAPIParseError(self._parser, "missing space after #")
-        line =3D line[1:]
-        self._append_line(line)
-
-    def end_comment(self):
-        self._end_section()
-
-    @staticmethod
-    def _is_section_tag(name):
-        return name in ('Returns:', 'Since:',
-                        # those are often singular or plural
-                        'Note:', 'Notes:',
-                        'Example:', 'Examples:',
-                        'TODO:')
-
-    def _append_body_line(self, line):
-        """
-        Process a line of documentation text in the body section.
-
-        If this a symbol line and it is the section's first line, this
-        is a definition documentation block for that symbol.
-
-        If it's a definition documentation block, another symbol line
-        begins the argument section for the argument named by it, and
-        a section tag begins an additional section.  Start that
-        section and append the line to it.
-
-        Else, append the line to the current section.
-        """
-        name =3D line.split(' ', 1)[0]
-        # FIXME not nice: things like '#  @foo:' and '# @foo: ' aren't
-        # recognized, and get silently treated as ordinary text
-        if not self.symbol and not self.body.text and line.startswith('@=
'):
-            if not line.endswith(':'):
-                raise QAPIParseError(self._parser, "line should end with=
 ':'")
-            self.symbol =3D line[1:-1]
-            # FIXME invalid names other than the empty string aren't fla=
gged
-            if not self.symbol:
-                raise QAPIParseError(self._parser, "invalid name")
-        elif self.symbol:
-            # This is a definition documentation block
-            if name.startswith('@') and name.endswith(':'):
-                self._append_line =3D self._append_args_line
-                self._append_args_line(line)
-            elif line =3D=3D 'Features:':
-                self._append_line =3D self._append_features_line
-            elif self._is_section_tag(name):
-                self._append_line =3D self._append_various_line
-                self._append_various_line(line)
-            else:
-                self._append_freeform(line.strip())
-        else:
-            # This is a free-form documentation block
-            self._append_freeform(line.strip())
-
-    def _append_args_line(self, line):
-        """
-        Process a line of documentation text in an argument section.
-
-        A symbol line begins the next argument section, a section tag
-        section or a non-indented line after a blank line begins an
-        additional section.  Start that section and append the line to
-        it.
-
-        Else, append the line to the current section.
-
-        """
-        name =3D line.split(' ', 1)[0]
-
-        if name.startswith('@') and name.endswith(':'):
-            line =3D line[len(name)+1:]
-            self._start_args_section(name[1:-1])
-        elif self._is_section_tag(name):
-            self._append_line =3D self._append_various_line
-            self._append_various_line(line)
-            return
-        elif (self._section.text.endswith('\n\n')
-              and line and not line[0].isspace()):
-            if line =3D=3D 'Features:':
-                self._append_line =3D self._append_features_line
-            else:
-                self._start_section()
-                self._append_line =3D self._append_various_line
-                self._append_various_line(line)
-            return
-
-        self._append_freeform(line.strip())
-
-    def _append_features_line(self, line):
-        name =3D line.split(' ', 1)[0]
-
-        if name.startswith('@') and name.endswith(':'):
-            line =3D line[len(name)+1:]
-            self._start_features_section(name[1:-1])
-        elif self._is_section_tag(name):
-            self._append_line =3D self._append_various_line
-            self._append_various_line(line)
-            return
-        elif (self._section.text.endswith('\n\n')
-              and line and not line[0].isspace()):
-            self._start_section()
-            self._append_line =3D self._append_various_line
-            self._append_various_line(line)
-            return
-
-        self._append_freeform(line.strip())
-
-    def _append_various_line(self, line):
-        """
-        Process a line of documentation text in an additional section.
-
-        A symbol line is an error.
-
-        A section tag begins an additional section.  Start that
-        section and append the line to it.
-
-        Else, append the line to the current section.
-        """
-        name =3D line.split(' ', 1)[0]
-
-        if name.startswith('@') and name.endswith(':'):
-            raise QAPIParseError(self._parser,
-                                 "'%s' can't follow '%s' section"
-                                 % (name, self.sections[0].name))
-        elif self._is_section_tag(name):
-            line =3D line[len(name)+1:]
-            self._start_section(name[:-1])
-
-        if (not self._section.name or
-                not self._section.name.startswith('Example')):
-            line =3D line.strip()
-
-        self._append_freeform(line)
-
-    def _start_symbol_section(self, symbols_dict, name):
-        # FIXME invalid names other than the empty string aren't flagged
-        if not name:
-            raise QAPIParseError(self._parser, "invalid parameter name")
-        if name in symbols_dict:
-            raise QAPIParseError(self._parser,
-                                 "'%s' parameter name duplicated" % name=
)
-        assert not self.sections
-        self._end_section()
-        self._section =3D QAPIDoc.ArgSection(name)
-        symbols_dict[name] =3D self._section
-
-    def _start_args_section(self, name):
-        self._start_symbol_section(self.args, name)
-
-    def _start_features_section(self, name):
-        self._start_symbol_section(self.features, name)
-
-    def _start_section(self, name=3DNone):
-        if name in ('Returns', 'Since') and self.has_section(name):
-            raise QAPIParseError(self._parser,
-                                 "duplicated '%s' section" % name)
-        self._end_section()
-        self._section =3D QAPIDoc.Section(name)
-        self.sections.append(self._section)
-
-    def _end_section(self):
-        if self._section:
-            text =3D self._section.text =3D self._section.text.strip()
-            if self._section.name and (not text or text.isspace()):
-                raise QAPIParseError(
-                    self._parser,
-                    "empty doc section '%s'" % self._section.name)
-            self._section =3D None
-
-    def _append_freeform(self, line):
-        match =3D re.match(r'(@\S+:)', line)
-        if match:
-            raise QAPIParseError(self._parser,
-                                 "'%s' not allowed in free-form document=
ation"
-                                 % match.group(1))
-        self._section.append(line)
-
-    def connect_member(self, member):
-        if member.name not in self.args:
-            # Undocumented TODO outlaw
-            self.args[member.name] =3D QAPIDoc.ArgSection(member.name)
-        self.args[member.name].connect(member)
-
-    def check_expr(self, expr):
-        if self.has_section('Returns') and 'command' not in expr:
-            raise QAPISemError(self.info,
-                               "'Returns:' is only valid for commands")
-
-    def check(self):
-        bogus =3D [name for name, section in self.args.items()
-                 if not section.member]
-        if bogus:
-            raise QAPISemError(
-                self.info,
-                "the following documented members are not in "
-                "the declaration: %s" % ", ".join(bogus))
-
-
-class QAPISchemaParser(object):
-
-    def __init__(self, fname, previously_included=3DNone, incl_info=3DNo=
ne):
-        previously_included =3D previously_included or set()
-        previously_included.add(os.path.abspath(fname))
-
-        try:
-            if sys.version_info[0] >=3D 3:
-                fp =3D open(fname, 'r', encoding=3D'utf-8')
-            else:
-                fp =3D open(fname, 'r')
-            self.src =3D fp.read()
-        except IOError as e:
-            raise QAPISemError(incl_info or QAPISourceInfo(None, None, N=
one),
-                               "can't read %s file '%s': %s"
-                               % ("include" if incl_info else "schema",
-                                  fname,
-                                  e.strerror))
-
-        if self.src =3D=3D '' or self.src[-1] !=3D '\n':
-            self.src +=3D '\n'
-        self.cursor =3D 0
-        self.info =3D QAPISourceInfo(fname, 1, incl_info)
-        self.line_pos =3D 0
-        self.exprs =3D []
-        self.docs =3D []
-        self.accept()
-        cur_doc =3D None
-
-        while self.tok is not None:
-            info =3D self.info
-            if self.tok =3D=3D '#':
-                self.reject_expr_doc(cur_doc)
-                cur_doc =3D self.get_doc(info)
-                self.docs.append(cur_doc)
-                continue
-
-            expr =3D self.get_expr(False)
-            if 'include' in expr:
-                self.reject_expr_doc(cur_doc)
-                if len(expr) !=3D 1:
-                    raise QAPISemError(info, "invalid 'include' directiv=
e")
-                include =3D expr['include']
-                if not isinstance(include, str):
-                    raise QAPISemError(info,
-                                       "value of 'include' must be a str=
ing")
-                incl_fname =3D os.path.join(os.path.dirname(fname),
-                                          include)
-                self.exprs.append({'expr': {'include': incl_fname},
-                                   'info': info})
-                exprs_include =3D self._include(include, info, incl_fnam=
e,
-                                              previously_included)
-                if exprs_include:
-                    self.exprs.extend(exprs_include.exprs)
-                    self.docs.extend(exprs_include.docs)
-            elif "pragma" in expr:
-                self.reject_expr_doc(cur_doc)
-                if len(expr) !=3D 1:
-                    raise QAPISemError(info, "invalid 'pragma' directive=
")
-                pragma =3D expr['pragma']
-                if not isinstance(pragma, dict):
-                    raise QAPISemError(
-                        info, "value of 'pragma' must be an object")
-                for name, value in pragma.items():
-                    self._pragma(name, value, info)
-            else:
-                expr_elem =3D {'expr': expr,
-                             'info': info}
-                if cur_doc:
-                    if not cur_doc.symbol:
-                        raise QAPISemError(
-                            cur_doc.info, "definition documentation requ=
ired")
-                    expr_elem['doc'] =3D cur_doc
-                self.exprs.append(expr_elem)
-            cur_doc =3D None
-        self.reject_expr_doc(cur_doc)
-
-    @staticmethod
-    def reject_expr_doc(doc):
-        if doc and doc.symbol:
-            raise QAPISemError(
-                doc.info,
-                "documentation for '%s' is not followed by the definitio=
n"
-                % doc.symbol)
-
-    def _include(self, include, info, incl_fname, previously_included):
-        incl_abs_fname =3D os.path.abspath(incl_fname)
-        # catch inclusion cycle
-        inf =3D info
-        while inf:
-            if incl_abs_fname =3D=3D os.path.abspath(inf.fname):
-                raise QAPISemError(info, "inclusion loop for %s" % inclu=
de)
-            inf =3D inf.parent
-
-        # skip multiple include of the same file
-        if incl_abs_fname in previously_included:
-            return None
-
-        return QAPISchemaParser(incl_fname, previously_included, info)
-
-    def _pragma(self, name, value, info):
-        if name =3D=3D 'doc-required':
-            if not isinstance(value, bool):
-                raise QAPISemError(info,
-                                   "pragma 'doc-required' must be boolea=
n")
-            info.pragma.doc_required =3D value
-        elif name =3D=3D 'returns-whitelist':
-            if (not isinstance(value, list)
-                    or any([not isinstance(elt, str) for elt in value]))=
:
-                raise QAPISemError(
-                    info,
-                    "pragma returns-whitelist must be a list of strings"=
)
-            info.pragma.returns_whitelist =3D value
-        elif name =3D=3D 'name-case-whitelist':
-            if (not isinstance(value, list)
-                    or any([not isinstance(elt, str) for elt in value]))=
:
-                raise QAPISemError(
-                    info,
-                    "pragma name-case-whitelist must be a list of string=
s")
-            info.pragma.name_case_whitelist =3D value
-        else:
-            raise QAPISemError(info, "unknown pragma '%s'" % name)
-
-    def accept(self, skip_comment=3DTrue):
-        while True:
-            self.tok =3D self.src[self.cursor]
-            self.pos =3D self.cursor
-            self.cursor +=3D 1
-            self.val =3D None
-
-            if self.tok =3D=3D '#':
-                if self.src[self.cursor] =3D=3D '#':
-                    # Start of doc comment
-                    skip_comment =3D False
-                self.cursor =3D self.src.find('\n', self.cursor)
-                if not skip_comment:
-                    self.val =3D self.src[self.pos:self.cursor]
-                    return
-            elif self.tok in '{}:,[]':
-                return
-            elif self.tok =3D=3D "'":
-                # Note: we accept only printable ASCII
-                string =3D ''
-                esc =3D False
-                while True:
-                    ch =3D self.src[self.cursor]
-                    self.cursor +=3D 1
-                    if ch =3D=3D '\n':
-                        raise QAPIParseError(self, "missing terminating =
\"'\"")
-                    if esc:
-                        # Note: we recognize only \\ because we have
-                        # no use for funny characters in strings
-                        if ch !=3D '\\':
-                            raise QAPIParseError(self,
-                                                 "unknown escape \\%s" %=
 ch)
-                        esc =3D False
-                    elif ch =3D=3D '\\':
-                        esc =3D True
-                        continue
-                    elif ch =3D=3D "'":
-                        self.val =3D string
-                        return
-                    if ord(ch) < 32 or ord(ch) >=3D 127:
-                        raise QAPIParseError(
-                            self, "funny character in string")
-                    string +=3D ch
-            elif self.src.startswith('true', self.pos):
-                self.val =3D True
-                self.cursor +=3D 3
-                return
-            elif self.src.startswith('false', self.pos):
-                self.val =3D False
-                self.cursor +=3D 4
-                return
-            elif self.tok =3D=3D '\n':
-                if self.cursor =3D=3D len(self.src):
-                    self.tok =3D None
-                    return
-                self.info =3D self.info.next_line()
-                self.line_pos =3D self.cursor
-            elif not self.tok.isspace():
-                # Show up to next structural, whitespace or quote
-                # character
-                match =3D re.match('[^[\\]{}:,\\s\'"]+',
-                                 self.src[self.cursor-1:])
-                raise QAPIParseError(self, "stray '%s'" % match.group(0)=
)
-
-    def get_members(self):
-        expr =3D OrderedDict()
-        if self.tok =3D=3D '}':
-            self.accept()
-            return expr
-        if self.tok !=3D "'":
-            raise QAPIParseError(self, "expected string or '}'")
-        while True:
-            key =3D self.val
-            self.accept()
-            if self.tok !=3D ':':
-                raise QAPIParseError(self, "expected ':'")
-            self.accept()
-            if key in expr:
-                raise QAPIParseError(self, "duplicate key '%s'" % key)
-            expr[key] =3D self.get_expr(True)
-            if self.tok =3D=3D '}':
-                self.accept()
-                return expr
-            if self.tok !=3D ',':
-                raise QAPIParseError(self, "expected ',' or '}'")
-            self.accept()
-            if self.tok !=3D "'":
-                raise QAPIParseError(self, "expected string")
-
-    def get_values(self):
-        expr =3D []
-        if self.tok =3D=3D ']':
-            self.accept()
-            return expr
-        if self.tok not in "{['tfn":
-            raise QAPIParseError(
-                self, "expected '{', '[', ']', string, boolean or 'null'=
")
-        while True:
-            expr.append(self.get_expr(True))
-            if self.tok =3D=3D ']':
-                self.accept()
-                return expr
-            if self.tok !=3D ',':
-                raise QAPIParseError(self, "expected ',' or ']'")
-            self.accept()
-
-    def get_expr(self, nested):
-        if self.tok !=3D '{' and not nested:
-            raise QAPIParseError(self, "expected '{'")
-        if self.tok =3D=3D '{':
-            self.accept()
-            expr =3D self.get_members()
-        elif self.tok =3D=3D '[':
-            self.accept()
-            expr =3D self.get_values()
-        elif self.tok in "'tfn":
-            expr =3D self.val
-            self.accept()
-        else:
-            raise QAPIParseError(
-                self, "expected '{', '[', string, boolean or 'null'")
-        return expr
-
-    def get_doc(self, info):
-        if self.val !=3D '##':
-            raise QAPIParseError(
-                self, "junk after '##' at start of documentation comment=
")
-
-        doc =3D QAPIDoc(self, info)
-        self.accept(False)
-        while self.tok =3D=3D '#':
-            if self.val.startswith('##'):
-                # End of doc comment
-                if self.val !=3D '##':
-                    raise QAPIParseError(
-                        self,
-                        "junk after '##' at end of documentation comment=
")
-                doc.end_comment()
-                self.accept()
-                return doc
-            else:
-                doc.append(self.val)
-            self.accept(False)
-
-        raise QAPIParseError(self, "documentation comment must end with =
'##'")
-
-
-#
-# Check (context-free) schema expression structure
-#
-
-# Names must be letters, numbers, -, and _.  They must start with letter=
,
-# except for downstream extensions which must start with __RFQDN_.
-# Dots are only valid in the downstream extension prefix.
-valid_name =3D re.compile(r'^(__[a-zA-Z0-9.-]+_)?'
-                        '[a-zA-Z][a-zA-Z0-9_-]*$')
-
-
-def check_name_is_str(name, info, source):
-    if not isinstance(name, str):
-        raise QAPISemError(info, "%s requires a string name" % source)
-
-
-def check_name_str(name, info, source,
-                   allow_optional=3DFalse, enum_member=3DFalse,
-                   permit_upper=3DFalse):
-    global valid_name
-    membername =3D name
-
-    if allow_optional and name.startswith('*'):
-        membername =3D name[1:]
-    # Enum members can start with a digit, because the generated C
-    # code always prefixes it with the enum name
-    if enum_member and membername[0].isdigit():
-        membername =3D 'D' + membername
-    # Reserve the entire 'q_' namespace for c_name(), and for 'q_empty'
-    # and 'q_obj_*' implicit type names.
-    if not valid_name.match(membername) or \
-       c_name(membername, False).startswith('q_'):
-        raise QAPISemError(info, "%s has an invalid name" % source)
-    if not permit_upper and name.lower() !=3D name:
-        raise QAPISemError(
-            info, "%s uses uppercase in name" % source)
-    assert not membername.startswith('*')
-
-
-def check_defn_name_str(name, info, meta):
-    check_name_str(name, info, meta, permit_upper=3DTrue)
-    if name.endswith('Kind') or name.endswith('List'):
-        raise QAPISemError(
-            info, "%s name should not end in '%s'" % (meta, name[-4:]))
-
-
-def check_if(expr, info, source):
-
-    def check_if_str(ifcond, info):
-        if not isinstance(ifcond, str):
-            raise QAPISemError(
-                info,
-                "'if' condition of %s must be a string or a list of stri=
ngs"
-                % source)
-        if ifcond.strip() =3D=3D '':
-            raise QAPISemError(
-                info,
-                "'if' condition '%s' of %s makes no sense"
-                % (ifcond, source))
-
-    ifcond =3D expr.get('if')
-    if ifcond is None:
-        return
-    if isinstance(ifcond, list):
-        if ifcond =3D=3D []:
-            raise QAPISemError(
-                info, "'if' condition [] of %s is useless" % source)
-        for elt in ifcond:
-            check_if_str(elt, info)
-    else:
-        check_if_str(ifcond, info)
-
-
-def check_type(value, info, source,
-               allow_array=3DFalse, allow_dict=3DFalse):
-    if value is None:
-        return
-
-    # Array type
-    if isinstance(value, list):
-        if not allow_array:
-            raise QAPISemError(info, "%s cannot be an array" % source)
-        if len(value) !=3D 1 or not isinstance(value[0], str):
-            raise QAPISemError(info,
-                               "%s: array type must contain single type =
name" %
-                               source)
-        return
-
-    # Type name
-    if isinstance(value, str):
-        return
-
-    # Anonymous type
-
-    if not allow_dict:
-        raise QAPISemError(info, "%s should be a type name" % source)
-
-    if not isinstance(value, OrderedDict):
-        raise QAPISemError(info,
-                           "%s should be an object or type name" % sourc=
e)
-
-    permit_upper =3D allow_dict in info.pragma.name_case_whitelist
-
-    # value is a dictionary, check that each member is okay
-    for (key, arg) in value.items():
-        key_source =3D "%s member '%s'" % (source, key)
-        check_name_str(key, info, key_source,
-                       allow_optional=3DTrue, permit_upper=3Dpermit_uppe=
r)
-        if c_name(key, False) =3D=3D 'u' or c_name(key, False).startswit=
h('has_'):
-            raise QAPISemError(info, "%s uses reserved name" % key_sourc=
e)
-        check_keys(arg, info, key_source, ['type'], ['if'])
-        check_if(arg, info, key_source)
-        normalize_if(arg)
-        check_type(arg['type'], info, key_source, allow_array=3DTrue)
-
-
-def check_command(expr, info):
-    args =3D expr.get('data')
-    rets =3D expr.get('returns')
-    boxed =3D expr.get('boxed', False)
-
-    if boxed and args is None:
-        raise QAPISemError(info, "'boxed': true requires 'data'")
-    check_type(args, info, "'data'", allow_dict=3Dnot boxed)
-    check_type(rets, info, "'returns'", allow_array=3DTrue)
-
-
-def check_event(expr, info):
-    args =3D expr.get('data')
-    boxed =3D expr.get('boxed', False)
-
-    if boxed and args is None:
-        raise QAPISemError(info, "'boxed': true requires 'data'")
-    check_type(args, info, "'data'", allow_dict=3Dnot boxed)
-
-
-def check_union(expr, info):
-    name =3D expr['union']
-    base =3D expr.get('base')
-    discriminator =3D expr.get('discriminator')
-    members =3D expr['data']
-
-    if discriminator is None:   # simple union
-        if base is not None:
-            raise QAPISemError(info, "'base' requires 'discriminator'")
-    else:                       # flat union
-        check_type(base, info, "'base'", allow_dict=3Dname)
-        if not base:
-            raise QAPISemError(info, "'discriminator' requires 'base'")
-        check_name_is_str(discriminator, info, "'discriminator'")
-
-    for (key, value) in members.items():
-        source =3D "'data' member '%s'" % key
-        check_name_str(key, info, source)
-        check_keys(value, info, source, ['type'], ['if'])
-        check_if(value, info, source)
-        normalize_if(value)
-        check_type(value['type'], info, source, allow_array=3Dnot base)
-
-
-def check_alternate(expr, info):
-    members =3D expr['data']
-
-    if len(members) =3D=3D 0:
-        raise QAPISemError(info, "'data' must not be empty")
-    for (key, value) in members.items():
-        source =3D "'data' member '%s'" % key
-        check_name_str(key, info, source)
-        check_keys(value, info, source, ['type'], ['if'])
-        check_if(value, info, source)
-        normalize_if(value)
-        check_type(value['type'], info, source)
-
-
-def check_enum(expr, info):
-    name =3D expr['enum']
-    members =3D expr['data']
-    prefix =3D expr.get('prefix')
-
-    if not isinstance(members, list):
-        raise QAPISemError(info, "'data' must be an array")
-    if prefix is not None and not isinstance(prefix, str):
-        raise QAPISemError(info, "'prefix' must be a string")
-
-    permit_upper =3D name in info.pragma.name_case_whitelist
-
-    for member in members:
-        source =3D "'data' member"
-        check_keys(member, info, source, ['name'], ['if'])
-        check_name_is_str(member['name'], info, source)
-        source =3D "%s '%s'" % (source, member['name'])
-        check_name_str(member['name'], info, source,
-                       enum_member=3DTrue, permit_upper=3Dpermit_upper)
-        check_if(member, info, source)
-        normalize_if(member)
-
-
-def check_struct(expr, info):
-    name =3D expr['struct']
-    members =3D expr['data']
-    features =3D expr.get('features')
-
-    check_type(members, info, "'data'", allow_dict=3Dname)
-    check_type(expr.get('base'), info, "'base'")
-
-    if features:
-        if not isinstance(features, list):
-            raise QAPISemError(info, "'features' must be an array")
-        for f in features:
-            source =3D "'features' member"
-            assert isinstance(f, dict)
-            check_keys(f, info, source, ['name'], ['if'])
-            check_name_is_str(f['name'], info, source)
-            source =3D "%s '%s'" % (source, f['name'])
-            check_name_str(f['name'], info, source)
-            check_if(f, info, source)
-            normalize_if(f)
-
-
-def check_keys(value, info, source, required, optional):
-
-    def pprint(elems):
-        return ', '.join("'" + e + "'" for e in sorted(elems))
-
-    missing =3D set(required) - set(value)
-    if missing:
-        raise QAPISemError(
-            info,
-            "%s misses key%s %s"
-            % (source, 's' if len(missing) > 1 else '',
-               pprint(missing)))
-    allowed =3D set(required + optional)
-    unknown =3D set(value) - allowed
-    if unknown:
-        raise QAPISemError(
-            info,
-            "%s has unknown key%s %s\nValid keys are %s."
-            % (source, 's' if len(unknown) > 1 else '',
-               pprint(unknown), pprint(allowed)))
-
-
-def check_flags(expr, info):
-    for key in ['gen', 'success-response']:
-        if key in expr and expr[key] is not False:
-            raise QAPISemError(
-                info, "flag '%s' may only use false value" % key)
-    for key in ['boxed', 'allow-oob', 'allow-preconfig']:
-        if key in expr and expr[key] is not True:
-            raise QAPISemError(
-                info, "flag '%s' may only use true value" % key)
-
-
-def normalize_enum(expr):
-    if isinstance(expr['data'], list):
-        expr['data'] =3D [m if isinstance(m, dict) else {'name': m}
-                        for m in expr['data']]
-
-
-def normalize_members(members):
-    if isinstance(members, OrderedDict):
-        for key, arg in members.items():
-            if isinstance(arg, dict):
-                continue
-            members[key] =3D {'type': arg}
-
-
-def normalize_features(features):
-    if isinstance(features, list):
-        features[:] =3D [f if isinstance(f, dict) else {'name': f}
-                       for f in features]
-
-
-def normalize_if(expr):
-    ifcond =3D expr.get('if')
-    if isinstance(ifcond, str):
-        expr['if'] =3D [ifcond]
-
-
-def check_exprs(exprs):
-    for expr_elem in exprs:
-        expr =3D expr_elem['expr']
-        info =3D expr_elem['info']
-        doc =3D expr_elem.get('doc')
-
-        if 'include' in expr:
-            continue
-
-        if 'enum' in expr:
-            meta =3D 'enum'
-        elif 'union' in expr:
-            meta =3D 'union'
-        elif 'alternate' in expr:
-            meta =3D 'alternate'
-        elif 'struct' in expr:
-            meta =3D 'struct'
-        elif 'command' in expr:
-            meta =3D 'command'
-        elif 'event' in expr:
-            meta =3D 'event'
-        else:
-            raise QAPISemError(info, "expression is missing metatype")
-
-        name =3D expr[meta]
-        check_name_is_str(name, info, "'%s'" % meta)
-        info.set_defn(meta, name)
-        check_defn_name_str(name, info, meta)
-
-        if doc:
-            if doc.symbol !=3D name:
-                raise QAPISemError(
-                    info, "documentation comment is for '%s'" % doc.symb=
ol)
-            doc.check_expr(expr)
-        elif info.pragma.doc_required:
-            raise QAPISemError(info,
-                               "documentation comment required")
-
-        if meta =3D=3D 'enum':
-            check_keys(expr, info, meta,
-                       ['enum', 'data'], ['if', 'prefix'])
-            normalize_enum(expr)
-            check_enum(expr, info)
-        elif meta =3D=3D 'union':
-            check_keys(expr, info, meta,
-                       ['union', 'data'],
-                       ['base', 'discriminator', 'if'])
-            normalize_members(expr.get('base'))
-            normalize_members(expr['data'])
-            check_union(expr, info)
-        elif meta =3D=3D 'alternate':
-            check_keys(expr, info, meta,
-                       ['alternate', 'data'], ['if'])
-            normalize_members(expr['data'])
-            check_alternate(expr, info)
-        elif meta =3D=3D 'struct':
-            check_keys(expr, info, meta,
-                       ['struct', 'data'], ['base', 'if', 'features'])
-            normalize_members(expr['data'])
-            normalize_features(expr.get('features'))
-            check_struct(expr, info)
-        elif meta =3D=3D 'command':
-            check_keys(expr, info, meta,
-                       ['command'],
-                       ['data', 'returns', 'boxed', 'if',
-                        'gen', 'success-response', 'allow-oob',
-                        'allow-preconfig'])
-            normalize_members(expr.get('data'))
-            check_command(expr, info)
-        elif meta =3D=3D 'event':
-            check_keys(expr, info, meta,
-                       ['event'], ['data', 'boxed', 'if'])
-            normalize_members(expr.get('data'))
-            check_event(expr, info)
-        else:
-            assert False, 'unexpected meta type'
-
-        normalize_if(expr)
-        check_if(expr, info, meta)
-        check_flags(expr, info)
-
-    return exprs
-
-
-#
-# Schema compiler frontend
-# TODO catching name collisions in generated code would be nice
-#
-
-class QAPISchemaEntity(object):
-    meta =3D None
-
-    def __init__(self, name, info, doc, ifcond=3DNone):
-        assert name is None or isinstance(name, str)
-        self.name =3D name
-        self._module =3D None
-        # For explicitly defined entities, info points to the (explicit)
-        # definition.  For builtins (and their arrays), info is None.
-        # For implicitly defined entities, info points to a place that
-        # triggered the implicit definition (there may be more than one
-        # such place).
-        self.info =3D info
-        self.doc =3D doc
-        self._ifcond =3D ifcond or []
-        self._checked =3D False
-
-    def c_name(self):
-        return c_name(self.name)
-
-    def check(self, schema):
-        assert not self._checked
-        if self.info:
-            self._module =3D os.path.relpath(self.info.fname,
-                                           os.path.dirname(schema.fname)=
)
-        self._checked =3D True
-
-    @property
-    def ifcond(self):
-        assert self._checked
-        return self._ifcond
-
-    @property
-    def module(self):
-        assert self._checked
-        return self._module
-
-    def is_implicit(self):
-        return not self.info
-
-    def visit(self, visitor):
-        assert self._checked
-
-    def describe(self):
-        assert self.meta
-        return "%s '%s'" % (self.meta, self.name)
-
-
-class QAPISchemaVisitor(object):
-    def visit_begin(self, schema):
-        pass
-
-    def visit_end(self):
-        pass
-
-    def visit_module(self, fname):
-        pass
-
-    def visit_needed(self, entity):
-        # Default to visiting everything
-        return True
-
-    def visit_include(self, fname, info):
-        pass
-
-    def visit_builtin_type(self, name, info, json_type):
-        pass
-
-    def visit_enum_type(self, name, info, ifcond, members, prefix):
-        pass
-
-    def visit_array_type(self, name, info, ifcond, element_type):
-        pass
-
-    def visit_object_type(self, name, info, ifcond, base, members, varia=
nts,
-                          features):
-        pass
-
-    def visit_object_type_flat(self, name, info, ifcond, members, varian=
ts,
-                               features):
-        pass
-
-    def visit_alternate_type(self, name, info, ifcond, variants):
-        pass
-
-    def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
-                      success_response, boxed, allow_oob, allow_preconfi=
g):
-        pass
-
-    def visit_event(self, name, info, ifcond, arg_type, boxed):
-        pass
-
-
-class QAPISchemaInclude(QAPISchemaEntity):
-
-    def __init__(self, fname, info):
-        QAPISchemaEntity.__init__(self, None, info, None)
-        self.fname =3D fname
-
-    def visit(self, visitor):
-        QAPISchemaEntity.visit(self, visitor)
-        visitor.visit_include(self.fname, self.info)
-
-
-class QAPISchemaType(QAPISchemaEntity):
-    # Return the C type for common use.
-    # For the types we commonly box, this is a pointer type.
-    def c_type(self):
-        pass
-
-    # Return the C type to be used in a parameter list.
-    def c_param_type(self):
-        return self.c_type()
-
-    # Return the C type to be used where we suppress boxing.
-    def c_unboxed_type(self):
-        return self.c_type()
-
-    def json_type(self):
-        pass
-
-    def alternate_qtype(self):
-        json2qtype =3D {
-            'null':    'QTYPE_QNULL',
-            'string':  'QTYPE_QSTRING',
-            'number':  'QTYPE_QNUM',
-            'int':     'QTYPE_QNUM',
-            'boolean': 'QTYPE_QBOOL',
-            'object':  'QTYPE_QDICT'
-        }
-        return json2qtype.get(self.json_type())
-
-    def doc_type(self):
-        if self.is_implicit():
-            return None
-        return self.name
-
-    def describe(self):
-        assert self.meta
-        return "%s type '%s'" % (self.meta, self.name)
-
-
-class QAPISchemaBuiltinType(QAPISchemaType):
-    meta =3D 'built-in'
-
-    def __init__(self, name, json_type, c_type):
-        QAPISchemaType.__init__(self, name, None, None)
-        assert not c_type or isinstance(c_type, str)
-        assert json_type in ('string', 'number', 'int', 'boolean', 'null=
',
-                             'value')
-        self._json_type_name =3D json_type
-        self._c_type_name =3D c_type
-
-    def c_name(self):
-        return self.name
-
-    def c_type(self):
-        return self._c_type_name
-
-    def c_param_type(self):
-        if self.name =3D=3D 'str':
-            return 'const ' + self._c_type_name
-        return self._c_type_name
-
-    def json_type(self):
-        return self._json_type_name
-
-    def doc_type(self):
-        return self.json_type()
-
-    def visit(self, visitor):
-        QAPISchemaType.visit(self, visitor)
-        visitor.visit_builtin_type(self.name, self.info, self.json_type(=
))
-
-
-class QAPISchemaEnumType(QAPISchemaType):
-    meta =3D 'enum'
-
-    def __init__(self, name, info, doc, ifcond, members, prefix):
-        QAPISchemaType.__init__(self, name, info, doc, ifcond)
-        for m in members:
-            assert isinstance(m, QAPISchemaEnumMember)
-            m.set_defined_in(name)
-        assert prefix is None or isinstance(prefix, str)
-        self.members =3D members
-        self.prefix =3D prefix
-
-    def check(self, schema):
-        QAPISchemaType.check(self, schema)
-        seen =3D {}
-        for m in self.members:
-            m.check_clash(self.info, seen)
-            if self.doc:
-                self.doc.connect_member(m)
-
-    def is_implicit(self):
-        # See QAPISchema._make_implicit_enum_type() and ._def_predefined=
s()
-        return self.name.endswith('Kind') or self.name =3D=3D 'QType'
-
-    def c_type(self):
-        return c_name(self.name)
-
-    def member_names(self):
-        return [m.name for m in self.members]
-
-    def json_type(self):
-        return 'string'
-
-    def visit(self, visitor):
-        QAPISchemaType.visit(self, visitor)
-        visitor.visit_enum_type(self.name, self.info, self.ifcond,
-                                self.members, self.prefix)
-
-
-class QAPISchemaArrayType(QAPISchemaType):
-    meta =3D 'array'
-
-    def __init__(self, name, info, element_type):
-        QAPISchemaType.__init__(self, name, info, None, None)
-        assert isinstance(element_type, str)
-        self._element_type_name =3D element_type
-        self.element_type =3D None
-
-    def check(self, schema):
-        QAPISchemaType.check(self, schema)
-        self.element_type =3D schema.resolve_type(
-            self._element_type_name, self.info,
-            self.info and self.info.defn_meta)
-        assert not isinstance(self.element_type, QAPISchemaArrayType)
-
-    @property
-    def ifcond(self):
-        assert self._checked
-        return self.element_type.ifcond
-
-    @property
-    def module(self):
-        assert self._checked
-        return self.element_type.module
-
-    def is_implicit(self):
-        return True
-
-    def c_type(self):
-        return c_name(self.name) + pointer_suffix
-
-    def json_type(self):
-        return 'array'
-
-    def doc_type(self):
-        elt_doc_type =3D self.element_type.doc_type()
-        if not elt_doc_type:
-            return None
-        return 'array of ' + elt_doc_type
-
-    def visit(self, visitor):
-        QAPISchemaType.visit(self, visitor)
-        visitor.visit_array_type(self.name, self.info, self.ifcond,
-                                 self.element_type)
-
-    def describe(self):
-        assert self.meta
-        return "%s type ['%s']" % (self.meta, self._element_type_name)
-
-
-class QAPISchemaObjectType(QAPISchemaType):
-    def __init__(self, name, info, doc, ifcond,
-                 base, local_members, variants, features):
-        # struct has local_members, optional base, and no variants
-        # flat union has base, variants, and no local_members
-        # simple union has local_members, variants, and no base
-        QAPISchemaType.__init__(self, name, info, doc, ifcond)
-        self.meta =3D 'union' if variants else 'struct'
-        assert base is None or isinstance(base, str)
-        for m in local_members:
-            assert isinstance(m, QAPISchemaObjectTypeMember)
-            m.set_defined_in(name)
-        if variants is not None:
-            assert isinstance(variants, QAPISchemaObjectTypeVariants)
-            variants.set_defined_in(name)
-        for f in features:
-            assert isinstance(f, QAPISchemaFeature)
-            f.set_defined_in(name)
-        self._base_name =3D base
-        self.base =3D None
-        self.local_members =3D local_members
-        self.variants =3D variants
-        self.members =3D None
-        self.features =3D features
-
-    def check(self, schema):
-        # This calls another type T's .check() exactly when the C
-        # struct emitted by gen_object() contains that T's C struct
-        # (pointers don't count).
-        if self.members is not None:
-            # A previous .check() completed: nothing to do
-            return
-        if self._checked:
-            # Recursed: C struct contains itself
-            raise QAPISemError(self.info,
-                               "object %s contains itself" % self.name)
-
-        QAPISchemaType.check(self, schema)
-        assert self._checked and self.members is None
-
-        seen =3D OrderedDict()
-        if self._base_name:
-            self.base =3D schema.resolve_type(self._base_name, self.info=
,
-                                            "'base'")
-            if (not isinstance(self.base, QAPISchemaObjectType)
-                    or self.base.variants):
-                raise QAPISemError(
-                    self.info,
-                    "'base' requires a struct type, %s isn't"
-                    % self.base.describe())
-            self.base.check(schema)
-            self.base.check_clash(self.info, seen)
-        for m in self.local_members:
-            m.check(schema)
-            m.check_clash(self.info, seen)
-            if self.doc:
-                self.doc.connect_member(m)
-        members =3D seen.values()
-
-        if self.variants:
-            self.variants.check(schema, seen)
-            self.variants.check_clash(self.info, seen)
-
-        # Features are in a name space separate from members
-        seen =3D {}
-        for f in self.features:
-            f.check_clash(self.info, seen)
-
-        if self.doc:
-            self.doc.check()
-
-        self.members =3D members  # mark completed
-
-    # Check that the members of this type do not cause duplicate JSON me=
mbers,
-    # and update seen to track the members seen so far. Report any error=
s
-    # on behalf of info, which is not necessarily self.info
-    def check_clash(self, info, seen):
-        assert self._checked
-        assert not self.variants       # not implemented
-        for m in self.members:
-            m.check_clash(info, seen)
-
-    @property
-    def ifcond(self):
-        assert self._checked
-        if isinstance(self._ifcond, QAPISchemaType):
-            # Simple union wrapper type inherits from wrapped type;
-            # see _make_implicit_object_type()
-            return self._ifcond.ifcond
-        return self._ifcond
-
-    def is_implicit(self):
-        # See QAPISchema._make_implicit_object_type(), as well as
-        # _def_predefineds()
-        return self.name.startswith('q_')
-
-    def is_empty(self):
-        assert self.members is not None
-        return not self.members and not self.variants
-
-    def c_name(self):
-        assert self.name !=3D 'q_empty'
-        return QAPISchemaType.c_name(self)
-
-    def c_type(self):
-        assert not self.is_implicit()
-        return c_name(self.name) + pointer_suffix
-
-    def c_unboxed_type(self):
-        return c_name(self.name)
-
-    def json_type(self):
-        return 'object'
-
-    def visit(self, visitor):
-        QAPISchemaType.visit(self, visitor)
-        visitor.visit_object_type(self.name, self.info, self.ifcond,
-                                  self.base, self.local_members, self.va=
riants,
-                                  self.features)
-        visitor.visit_object_type_flat(self.name, self.info, self.ifcond=
,
-                                       self.members, self.variants,
-                                       self.features)
-
-
-class QAPISchemaMember(object):
-    """ Represents object members, enum members and features """
-    role =3D 'member'
-
-    def __init__(self, name, info, ifcond=3DNone):
-        assert isinstance(name, str)
-        self.name =3D name
-        self.info =3D info
-        self.ifcond =3D ifcond or []
-        self.defined_in =3D None
-
-    def set_defined_in(self, name):
-        assert not self.defined_in
-        self.defined_in =3D name
-
-    def check_clash(self, info, seen):
-        cname =3D c_name(self.name)
-        if cname in seen:
-            raise QAPISemError(
-                info,
-                "%s collides with %s"
-                % (self.describe(info), seen[cname].describe(info)))
-        seen[cname] =3D self
-
-    def describe(self, info):
-        role =3D self.role
-        defined_in =3D self.defined_in
-        assert defined_in
-
-        if defined_in.startswith('q_obj_'):
-            # See QAPISchema._make_implicit_object_type() - reverse the
-            # mapping there to create a nice human-readable description
-            defined_in =3D defined_in[6:]
-            if defined_in.endswith('-arg'):
-                # Implicit type created for a command's dict 'data'
-                assert role =3D=3D 'member'
-                role =3D 'parameter'
-            elif defined_in.endswith('-base'):
-                # Implicit type created for a flat union's dict 'base'
-                role =3D 'base ' + role
-            else:
-                # Implicit type created for a simple union's branch
-                assert defined_in.endswith('-wrapper')
-                # Unreachable and not implemented
-                assert False
-        elif defined_in.endswith('Kind'):
-            # See QAPISchema._make_implicit_enum_type()
-            # Implicit enum created for simple union's branches
-            assert role =3D=3D 'value'
-            role =3D 'branch'
-        elif defined_in !=3D info.defn_name:
-            return "%s '%s' of type '%s'" % (role, self.name, defined_in=
)
-        return "%s '%s'" % (role, self.name)
-
-
-class QAPISchemaEnumMember(QAPISchemaMember):
-    role =3D 'value'
-
-
-class QAPISchemaFeature(QAPISchemaMember):
-    role =3D 'feature'
-
-
-class QAPISchemaObjectTypeMember(QAPISchemaMember):
-    def __init__(self, name, info, typ, optional, ifcond=3DNone):
-        QAPISchemaMember.__init__(self, name, info, ifcond)
-        assert isinstance(typ, str)
-        assert isinstance(optional, bool)
-        self._type_name =3D typ
-        self.type =3D None
-        self.optional =3D optional
-
-    def check(self, schema):
-        assert self.defined_in
-        self.type =3D schema.resolve_type(self._type_name, self.info,
-                                        self.describe)
-
-
-class QAPISchemaObjectTypeVariants(object):
-    def __init__(self, tag_name, info, tag_member, variants):
-        # Flat unions pass tag_name but not tag_member.
-        # Simple unions and alternates pass tag_member but not tag_name.
-        # After check(), tag_member is always set, and tag_name remains
-        # a reliable witness of being used by a flat union.
-        assert bool(tag_member) !=3D bool(tag_name)
-        assert (isinstance(tag_name, str) or
-                isinstance(tag_member, QAPISchemaObjectTypeMember))
-        for v in variants:
-            assert isinstance(v, QAPISchemaObjectTypeVariant)
-        self._tag_name =3D tag_name
-        self.info =3D info
-        self.tag_member =3D tag_member
-        self.variants =3D variants
-
-    def set_defined_in(self, name):
-        for v in self.variants:
-            v.set_defined_in(name)
-
-    def check(self, schema, seen):
-        if not self.tag_member: # flat union
-            self.tag_member =3D seen.get(c_name(self._tag_name))
-            base =3D "'base'"
-            # Pointing to the base type when not implicit would be
-            # nice, but we don't know it here
-            if not self.tag_member or self._tag_name !=3D self.tag_membe=
r.name:
-                raise QAPISemError(
-                    self.info,
-                    "discriminator '%s' is not a member of %s"
-                    % (self._tag_name, base))
-            # Here we do:
-            base_type =3D schema.lookup_type(self.tag_member.defined_in)
-            assert base_type
-            if not base_type.is_implicit():
-                base =3D "base type '%s'" % self.tag_member.defined_in
-            if not isinstance(self.tag_member.type, QAPISchemaEnumType):
-                raise QAPISemError(
-                    self.info,
-                    "discriminator member '%s' of %s must be of enum typ=
e"
-                    % (self._tag_name, base))
-            if self.tag_member.optional:
-                raise QAPISemError(
-                    self.info,
-                    "discriminator member '%s' of %s must not be optiona=
l"
-                    % (self._tag_name, base))
-            if self.tag_member.ifcond:
-                raise QAPISemError(
-                    self.info,
-                    "discriminator member '%s' of %s must not be conditi=
onal"
-                    % (self._tag_name, base))
-        else:                   # simple union
-            assert isinstance(self.tag_member.type, QAPISchemaEnumType)
-            assert not self.tag_member.optional
-            assert self.tag_member.ifcond =3D=3D []
-        if self._tag_name:    # flat union
-            # branches that are not explicitly covered get an empty type
-            cases =3D set([v.name for v in self.variants])
-            for m in self.tag_member.type.members:
-                if m.name not in cases:
-                    v =3D QAPISchemaObjectTypeVariant(m.name, self.info,
-                                                    'q_empty', m.ifcond)
-                    v.set_defined_in(self.tag_member.defined_in)
-                    self.variants.append(v)
-        if not self.variants:
-            raise QAPISemError(self.info, "union has no branches")
-        for v in self.variants:
-            v.check(schema)
-            # Union names must match enum values; alternate names are
-            # checked separately. Use 'seen' to tell the two apart.
-            if seen:
-                if v.name not in self.tag_member.type.member_names():
-                    raise QAPISemError(
-                        self.info,
-                        "branch '%s' is not a value of %s"
-                        % (v.name, self.tag_member.type.describe()))
-                if (not isinstance(v.type, QAPISchemaObjectType)
-                        or v.type.variants):
-                    raise QAPISemError(
-                        self.info,
-                        "%s cannot use %s"
-                        % (v.describe(self.info), v.type.describe()))
-                v.type.check(schema)
-
-    def check_clash(self, info, seen):
-        for v in self.variants:
-            # Reset seen map for each variant, since qapi names from one
-            # branch do not affect another branch
-            v.type.check_clash(info, dict(seen))
-
-
-class QAPISchemaObjectTypeVariant(QAPISchemaObjectTypeMember):
-    role =3D 'branch'
-
-    def __init__(self, name, info, typ, ifcond=3DNone):
-        QAPISchemaObjectTypeMember.__init__(self, name, info, typ,
-                                            False, ifcond)
-
-
-class QAPISchemaAlternateType(QAPISchemaType):
-    meta =3D 'alternate'
-
-    def __init__(self, name, info, doc, ifcond, variants):
-        QAPISchemaType.__init__(self, name, info, doc, ifcond)
-        assert isinstance(variants, QAPISchemaObjectTypeVariants)
-        assert variants.tag_member
-        variants.set_defined_in(name)
-        variants.tag_member.set_defined_in(self.name)
-        self.variants =3D variants
-
-    def check(self, schema):
-        QAPISchemaType.check(self, schema)
-        self.variants.tag_member.check(schema)
-        # Not calling self.variants.check_clash(), because there's nothi=
ng
-        # to clash with
-        self.variants.check(schema, {})
-        # Alternate branch names have no relation to the tag enum values=
;
-        # so we have to check for potential name collisions ourselves.
-        seen =3D {}
-        types_seen =3D {}
-        for v in self.variants.variants:
-            v.check_clash(self.info, seen)
-            qtype =3D v.type.alternate_qtype()
-            if not qtype:
-                raise QAPISemError(
-                    self.info,
-                    "%s cannot use %s"
-                    % (v.describe(self.info), v.type.describe()))
-            conflicting =3D set([qtype])
-            if qtype =3D=3D 'QTYPE_QSTRING':
-                if isinstance(v.type, QAPISchemaEnumType):
-                    for m in v.type.members:
-                        if m.name in ['on', 'off']:
-                            conflicting.add('QTYPE_QBOOL')
-                        if re.match(r'[-+0-9.]', m.name):
-                            # lazy, could be tightened
-                            conflicting.add('QTYPE_QNUM')
-                else:
-                    conflicting.add('QTYPE_QNUM')
-                    conflicting.add('QTYPE_QBOOL')
-            for qt in conflicting:
-                if qt in types_seen:
-                    raise QAPISemError(
-                        self.info,
-                        "%s can't be distinguished from '%s'"
-                        % (v.describe(self.info), types_seen[qt]))
-                types_seen[qt] =3D v.name
-            if self.doc:
-                self.doc.connect_member(v)
-        if self.doc:
-            self.doc.check()
-
-    def c_type(self):
-        return c_name(self.name) + pointer_suffix
-
-    def json_type(self):
-        return 'value'
-
-    def visit(self, visitor):
-        QAPISchemaType.visit(self, visitor)
-        visitor.visit_alternate_type(self.name, self.info, self.ifcond,
-                                     self.variants)
-
-
-class QAPISchemaCommand(QAPISchemaEntity):
-    meta =3D 'command'
-
-    def __init__(self, name, info, doc, ifcond, arg_type, ret_type,
-                 gen, success_response, boxed, allow_oob, allow_preconfi=
g):
-        QAPISchemaEntity.__init__(self, name, info, doc, ifcond)
-        assert not arg_type or isinstance(arg_type, str)
-        assert not ret_type or isinstance(ret_type, str)
-        self._arg_type_name =3D arg_type
-        self.arg_type =3D None
-        self._ret_type_name =3D ret_type
-        self.ret_type =3D None
-        self.gen =3D gen
-        self.success_response =3D success_response
-        self.boxed =3D boxed
-        self.allow_oob =3D allow_oob
-        self.allow_preconfig =3D allow_preconfig
-
-    def check(self, schema):
-        QAPISchemaEntity.check(self, schema)
-        if self._arg_type_name:
-            self.arg_type =3D schema.resolve_type(
-                self._arg_type_name, self.info, "command's 'data'")
-            if not isinstance(self.arg_type, QAPISchemaObjectType):
-                raise QAPISemError(
-                    self.info,
-                    "command's 'data' cannot take %s"
-                    % self.arg_type.describe())
-            if self.arg_type.variants and not self.boxed:
-                raise QAPISemError(
-                    self.info,
-                    "command's 'data' can take %s only with 'boxed': tru=
e"
-                    % self.arg_type.describe())
-        if self._ret_type_name:
-            self.ret_type =3D schema.resolve_type(
-                self._ret_type_name, self.info, "command's 'returns'")
-            if self.name not in self.info.pragma.returns_whitelist:
-                if not (isinstance(self.ret_type, QAPISchemaObjectType)
-                        or (isinstance(self.ret_type, QAPISchemaArrayTyp=
e)
-                            and isinstance(self.ret_type.element_type,
-                                           QAPISchemaObjectType))):
-                    raise QAPISemError(
-                        self.info,
-                        "command's 'returns' cannot take %s"
-                        % self.ret_type.describe())
-
-    def visit(self, visitor):
-        QAPISchemaEntity.visit(self, visitor)
-        visitor.visit_command(self.name, self.info, self.ifcond,
-                              self.arg_type, self.ret_type,
-                              self.gen, self.success_response,
-                              self.boxed, self.allow_oob,
-                              self.allow_preconfig)
-
-
-class QAPISchemaEvent(QAPISchemaEntity):
-    meta =3D 'event'
-
-    def __init__(self, name, info, doc, ifcond, arg_type, boxed):
-        QAPISchemaEntity.__init__(self, name, info, doc, ifcond)
-        assert not arg_type or isinstance(arg_type, str)
-        self._arg_type_name =3D arg_type
-        self.arg_type =3D None
-        self.boxed =3D boxed
-
-    def check(self, schema):
-        QAPISchemaEntity.check(self, schema)
-        if self._arg_type_name:
-            self.arg_type =3D schema.resolve_type(
-                self._arg_type_name, self.info, "event's 'data'")
-            if not isinstance(self.arg_type, QAPISchemaObjectType):
-                raise QAPISemError(
-                    self.info,
-                    "event's 'data' cannot take %s"
-                    % self.arg_type.describe())
-            if self.arg_type.variants and not self.boxed:
-                raise QAPISemError(
-                    self.info,
-                    "event's 'data' can take %s only with 'boxed': true"
-                    % self.arg_type.describe())
-
-    def visit(self, visitor):
-        QAPISchemaEntity.visit(self, visitor)
-        visitor.visit_event(self.name, self.info, self.ifcond,
-                            self.arg_type, self.boxed)
-
-
-class QAPISchema(object):
-    def __init__(self, fname):
-        self.fname =3D fname
-        parser =3D QAPISchemaParser(fname)
-        exprs =3D check_exprs(parser.exprs)
-        self.docs =3D parser.docs
-        self._entity_list =3D []
-        self._entity_dict =3D {}
-        self._predefining =3D True
-        self._def_predefineds()
-        self._predefining =3D False
-        self._def_exprs(exprs)
-        self.check()
-
-    def _def_entity(self, ent):
-        # Only the predefined types are allowed to not have info
-        assert ent.info or self._predefining
-        self._entity_list.append(ent)
-        if ent.name is None:
-            return
-        # TODO reject names that differ only in '_' vs. '.'  vs. '-',
-        # because they're liable to clash in generated C.
-        other_ent =3D self._entity_dict.get(ent.name)
-        if other_ent:
-            if other_ent.info:
-                where =3D QAPIError(other_ent.info, None, "previous defi=
nition")
-                raise QAPISemError(
-                    ent.info,
-                    "'%s' is already defined\n%s" % (ent.name, where))
-            raise QAPISemError(
-                ent.info, "%s is already defined" % other_ent.describe()=
)
-        self._entity_dict[ent.name] =3D ent
-
-    def lookup_entity(self, name, typ=3DNone):
-        ent =3D self._entity_dict.get(name)
-        if typ and not isinstance(ent, typ):
-            return None
-        return ent
-
-    def lookup_type(self, name):
-        return self.lookup_entity(name, QAPISchemaType)
-
-    def resolve_type(self, name, info, what):
-        typ =3D self.lookup_type(name)
-        if not typ:
-            if callable(what):
-                what =3D what(info)
-            raise QAPISemError(
-                info, "%s uses unknown type '%s'" % (what, name))
-        return typ
-
-    def _def_include(self, expr, info, doc):
-        include =3D expr['include']
-        assert doc is None
-        main_info =3D info
-        while main_info.parent:
-            main_info =3D main_info.parent
-        fname =3D os.path.relpath(include, os.path.dirname(main_info.fna=
me))
-        self._def_entity(QAPISchemaInclude(fname, info))
-
-    def _def_builtin_type(self, name, json_type, c_type):
-        self._def_entity(QAPISchemaBuiltinType(name, json_type, c_type))
-        # Instantiating only the arrays that are actually used would
-        # be nice, but we can't as long as their generated code
-        # (qapi-builtin-types.[ch]) may be shared by some other
-        # schema.
-        self._make_array_type(name, None)
-
-    def _def_predefineds(self):
-        for t in [('str',    'string',  'char' + pointer_suffix),
-                  ('number', 'number',  'double'),
-                  ('int',    'int',     'int64_t'),
-                  ('int8',   'int',     'int8_t'),
-                  ('int16',  'int',     'int16_t'),
-                  ('int32',  'int',     'int32_t'),
-                  ('int64',  'int',     'int64_t'),
-                  ('uint8',  'int',     'uint8_t'),
-                  ('uint16', 'int',     'uint16_t'),
-                  ('uint32', 'int',     'uint32_t'),
-                  ('uint64', 'int',     'uint64_t'),
-                  ('size',   'int',     'uint64_t'),
-                  ('bool',   'boolean', 'bool'),
-                  ('any',    'value',   'QObject' + pointer_suffix),
-                  ('null',   'null',    'QNull' + pointer_suffix)]:
-            self._def_builtin_type(*t)
-        self.the_empty_object_type =3D QAPISchemaObjectType(
-            'q_empty', None, None, None, None, [], None, [])
-        self._def_entity(self.the_empty_object_type)
-
-        qtypes =3D ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist'=
,
-                  'qbool']
-        qtype_values =3D self._make_enum_members(
-            [{'name': n} for n in qtypes], None)
-
-        self._def_entity(QAPISchemaEnumType('QType', None, None, None,
-                                            qtype_values, 'QTYPE'))
-
-    def _make_features(self, features, info):
-        return [QAPISchemaFeature(f['name'], info, f.get('if'))
-                for f in features]
-
-    def _make_enum_members(self, values, info):
-        return [QAPISchemaEnumMember(v['name'], info, v.get('if'))
-                for v in values]
-
-    def _make_implicit_enum_type(self, name, info, ifcond, values):
-        # See also QAPISchemaObjectTypeMember.describe()
-        name =3D name + 'Kind'    # reserved by check_defn_name_str()
-        self._def_entity(QAPISchemaEnumType(
-            name, info, None, ifcond, self._make_enum_members(values, in=
fo),
-            None))
-        return name
-
-    def _make_array_type(self, element_type, info):
-        name =3D element_type + 'List'    # reserved by check_defn_name_=
str()
-        if not self.lookup_type(name):
-            self._def_entity(QAPISchemaArrayType(name, info, element_typ=
e))
-        return name
-
-    def _make_implicit_object_type(self, name, info, doc, ifcond,
-                                   role, members):
-        if not members:
-            return None
-        # See also QAPISchemaObjectTypeMember.describe()
-        name =3D 'q_obj_%s-%s' % (name, role)
-        typ =3D self.lookup_entity(name, QAPISchemaObjectType)
-        if typ:
-            # The implicit object type has multiple users.  This can
-            # happen only for simple unions' implicit wrapper types.
-            # Its ifcond should be the disjunction of its user's
-            # ifconds.  Not implemented.  Instead, we always pass the
-            # wrapped type's ifcond, which is trivially the same for all
-            # users.  It's also necessary for the wrapper to compile.
-            # But it's not tight: the disjunction need not imply it.  We
-            # may end up compiling useless wrapper types.
-            # TODO kill simple unions or implement the disjunction
-            assert (ifcond or []) =3D=3D typ._ifcond # pylint: disable=3D=
protected-access
-        else:
-            self._def_entity(QAPISchemaObjectType(name, info, doc, ifcon=
d,
-                                                  None, members, None, [=
]))
-        return name
-
-    def _def_enum_type(self, expr, info, doc):
-        name =3D expr['enum']
-        data =3D expr['data']
-        prefix =3D expr.get('prefix')
-        ifcond =3D expr.get('if')
-        self._def_entity(QAPISchemaEnumType(
-            name, info, doc, ifcond,
-            self._make_enum_members(data, info), prefix))
-
-    def _make_member(self, name, typ, ifcond, info):
-        optional =3D False
-        if name.startswith('*'):
-            name =3D name[1:]
-            optional =3D True
-        if isinstance(typ, list):
-            assert len(typ) =3D=3D 1
-            typ =3D self._make_array_type(typ[0], info)
-        return QAPISchemaObjectTypeMember(name, info, typ, optional, ifc=
ond)
-
-    def _make_members(self, data, info):
-        return [self._make_member(key, value['type'], value.get('if'), i=
nfo)
-                for (key, value) in data.items()]
-
-    def _def_struct_type(self, expr, info, doc):
-        name =3D expr['struct']
-        base =3D expr.get('base')
-        data =3D expr['data']
-        ifcond =3D expr.get('if')
-        features =3D expr.get('features', [])
-        self._def_entity(QAPISchemaObjectType(
-            name, info, doc, ifcond, base,
-            self._make_members(data, info),
-            None,
-            self._make_features(features, info)))
-
-    def _make_variant(self, case, typ, ifcond, info):
-        return QAPISchemaObjectTypeVariant(case, info, typ, ifcond)
-
-    def _make_simple_variant(self, case, typ, ifcond, info):
-        if isinstance(typ, list):
-            assert len(typ) =3D=3D 1
-            typ =3D self._make_array_type(typ[0], info)
-        typ =3D self._make_implicit_object_type(
-            typ, info, None, self.lookup_type(typ),
-            'wrapper', [self._make_member('data', typ, None, info)])
-        return QAPISchemaObjectTypeVariant(case, info, typ, ifcond)
-
-    def _def_union_type(self, expr, info, doc):
-        name =3D expr['union']
-        data =3D expr['data']
-        base =3D expr.get('base')
-        ifcond =3D expr.get('if')
-        tag_name =3D expr.get('discriminator')
-        tag_member =3D None
-        if isinstance(base, dict):
-            base =3D self._make_implicit_object_type(
-                name, info, doc, ifcond,
-                'base', self._make_members(base, info))
-        if tag_name:
-            variants =3D [self._make_variant(key, value['type'],
-                                           value.get('if'), info)
-                        for (key, value) in data.items()]
-            members =3D []
-        else:
-            variants =3D [self._make_simple_variant(key, value['type'],
-                                                  value.get('if'), info)
-                        for (key, value) in data.items()]
-            enum =3D [{'name': v.name, 'if': v.ifcond} for v in variants=
]
-            typ =3D self._make_implicit_enum_type(name, info, ifcond, en=
um)
-            tag_member =3D QAPISchemaObjectTypeMember('type', info, typ,=
 False)
-            members =3D [tag_member]
-        self._def_entity(
-            QAPISchemaObjectType(name, info, doc, ifcond, base, members,
-                                 QAPISchemaObjectTypeVariants(
-                                     tag_name, info, tag_member, variant=
s),
-                                 []))
-
-    def _def_alternate_type(self, expr, info, doc):
-        name =3D expr['alternate']
-        data =3D expr['data']
-        ifcond =3D expr.get('if')
-        variants =3D [self._make_variant(key, value['type'], value.get('=
if'),
-                                       info)
-                    for (key, value) in data.items()]
-        tag_member =3D QAPISchemaObjectTypeMember('type', info, 'QType',=
 False)
-        self._def_entity(
-            QAPISchemaAlternateType(name, info, doc, ifcond,
-                                    QAPISchemaObjectTypeVariants(
-                                        None, info, tag_member, variants=
)))
-
-    def _def_command(self, expr, info, doc):
-        name =3D expr['command']
-        data =3D expr.get('data')
-        rets =3D expr.get('returns')
-        gen =3D expr.get('gen', True)
-        success_response =3D expr.get('success-response', True)
-        boxed =3D expr.get('boxed', False)
-        allow_oob =3D expr.get('allow-oob', False)
-        allow_preconfig =3D expr.get('allow-preconfig', False)
-        ifcond =3D expr.get('if')
-        if isinstance(data, OrderedDict):
-            data =3D self._make_implicit_object_type(
-                name, info, doc, ifcond, 'arg', self._make_members(data,=
 info))
-        if isinstance(rets, list):
-            assert len(rets) =3D=3D 1
-            rets =3D self._make_array_type(rets[0], info)
-        self._def_entity(QAPISchemaCommand(name, info, doc, ifcond, data=
, rets,
-                                           gen, success_response,
-                                           boxed, allow_oob, allow_preco=
nfig))
-
-    def _def_event(self, expr, info, doc):
-        name =3D expr['event']
-        data =3D expr.get('data')
-        boxed =3D expr.get('boxed', False)
-        ifcond =3D expr.get('if')
-        if isinstance(data, OrderedDict):
-            data =3D self._make_implicit_object_type(
-                name, info, doc, ifcond, 'arg', self._make_members(data,=
 info))
-        self._def_entity(QAPISchemaEvent(name, info, doc, ifcond, data, =
boxed))
-
-    def _def_exprs(self, exprs):
-        for expr_elem in exprs:
-            expr =3D expr_elem['expr']
-            info =3D expr_elem['info']
-            doc =3D expr_elem.get('doc')
-            if 'enum' in expr:
-                self._def_enum_type(expr, info, doc)
-            elif 'struct' in expr:
-                self._def_struct_type(expr, info, doc)
-            elif 'union' in expr:
-                self._def_union_type(expr, info, doc)
-            elif 'alternate' in expr:
-                self._def_alternate_type(expr, info, doc)
-            elif 'command' in expr:
-                self._def_command(expr, info, doc)
-            elif 'event' in expr:
-                self._def_event(expr, info, doc)
-            elif 'include' in expr:
-                self._def_include(expr, info, doc)
-            else:
-                assert False
-
-    def check(self):
-        for ent in self._entity_list:
-            ent.check(self)
-
-    def visit(self, visitor):
-        visitor.visit_begin(self)
-        module =3D None
-        visitor.visit_module(module)
-        for entity in self._entity_list:
-            if visitor.visit_needed(entity):
-                if entity.module !=3D module:
-                    module =3D entity.module
-                    visitor.visit_module(module)
-                entity.visit(visitor)
-        visitor.visit_end()
-
-
-#
-# Code generation helpers
-#
-
-def camel_case(name):
-    new_name =3D ''
-    first =3D True
-    for ch in name:
-        if ch in ['_', '-']:
-            first =3D True
-        elif first:
-            new_name +=3D ch.upper()
-            first =3D False
-        else:
-            new_name +=3D ch.lower()
-    return new_name
=20
=20
 # ENUMName -> ENUM_NAME, EnumName1 -> ENUM_NAME1
@@ -2223,22 +175,6 @@ def gen_endif(ifcond):
     return ret
=20
=20
-def _wrap_ifcond(ifcond, before, after):
-    if before =3D=3D after:
-        return after   # suppress empty #if ... #endif
-
-    assert after.startswith(before)
-    out =3D before
-    added =3D after[len(before):]
-    if added[0] =3D=3D '\n':
-        out +=3D '\n'
-        added =3D added[1:]
-    out +=3D gen_if(ifcond)
-    out +=3D added
-    out +=3D gen_endif(ifcond)
-    return out
-
-
 def build_params(arg_type, boxed, extra=3DNone):
     ret =3D ''
     sep =3D ''
@@ -2258,260 +194,3 @@ def build_params(arg_type, boxed, extra=3DNone):
     if extra:
         ret +=3D sep + extra
     return ret if ret else 'void'
-
-
-#
-# Accumulate and write output
-#
-
-class QAPIGen(object):
-
-    def __init__(self, fname):
-        self.fname =3D fname
-        self._preamble =3D ''
-        self._body =3D ''
-
-    def preamble_add(self, text):
-        self._preamble +=3D text
-
-    def add(self, text):
-        self._body +=3D text
-
-    def get_content(self):
-        return self._top() + self._preamble + self._body + self._bottom(=
)
-
-    def _top(self):
-        return ''
-
-    def _bottom(self):
-        return ''
-
-    def write(self, output_dir):
-        pathname =3D os.path.join(output_dir, self.fname)
-        dir =3D os.path.dirname(pathname)
-        if dir:
-            try:
-                os.makedirs(dir)
-            except os.error as e:
-                if e.errno !=3D errno.EEXIST:
-                    raise
-        fd =3D os.open(pathname, os.O_RDWR | os.O_CREAT, 0o666)
-        if sys.version_info[0] >=3D 3:
-            f =3D open(fd, 'r+', encoding=3D'utf-8')
-        else:
-            f =3D os.fdopen(fd, 'r+')
-        text =3D self.get_content()
-        oldtext =3D f.read(len(text) + 1)
-        if text !=3D oldtext:
-            f.seek(0)
-            f.truncate(0)
-            f.write(text)
-        f.close()
-
-
-@contextmanager
-def ifcontext(ifcond, *args):
-    """A 'with' statement context manager to wrap with start_if()/end_if=
()
-
-    *args: any number of QAPIGenCCode
-
-    Example::
-
-        with ifcontext(ifcond, self._genh, self._genc):
-            modify self._genh and self._genc ...
-
-    Is equivalent to calling::
-
-        self._genh.start_if(ifcond)
-        self._genc.start_if(ifcond)
-        modify self._genh and self._genc ...
-        self._genh.end_if()
-        self._genc.end_if()
-    """
-    for arg in args:
-        arg.start_if(ifcond)
-    yield
-    for arg in args:
-        arg.end_if()
-
-
-class QAPIGenCCode(QAPIGen):
-
-    def __init__(self, fname):
-        QAPIGen.__init__(self, fname)
-        self._start_if =3D None
-
-    def start_if(self, ifcond):
-        assert self._start_if is None
-        self._start_if =3D (ifcond, self._body, self._preamble)
-
-    def end_if(self):
-        assert self._start_if
-        self._wrap_ifcond()
-        self._start_if =3D None
-
-    def _wrap_ifcond(self):
-        self._body =3D _wrap_ifcond(self._start_if[0],
-                                  self._start_if[1], self._body)
-        self._preamble =3D _wrap_ifcond(self._start_if[0],
-                                      self._start_if[2], self._preamble)
-
-    def get_content(self):
-        assert self._start_if is None
-        return QAPIGen.get_content(self)
-
-
-class QAPIGenC(QAPIGenCCode):
-
-    def __init__(self, fname, blurb, pydoc):
-        QAPIGenCCode.__init__(self, fname)
-        self._blurb =3D blurb
-        self._copyright =3D '\n * '.join(re.findall(r'^Copyright .*', py=
doc,
-                                                  re.MULTILINE))
-
-    def _top(self):
-        return mcgen('''
-/* AUTOMATICALLY GENERATED, DO NOT MODIFY */
-
-/*
-%(blurb)s
- *
- * %(copyright)s
- *
- * This work is licensed under the terms of the GNU LGPL, version 2.1 or=
 later.
- * See the COPYING.LIB file in the top-level directory.
- */
-
-''',
-                     blurb=3Dself._blurb, copyright=3Dself._copyright)
-
-    def _bottom(self):
-        return mcgen('''
-
-/* Dummy declaration to prevent empty .o file */
-char qapi_dummy_%(name)s;
-''',
-                     name=3Dc_fname(self.fname))
-
-
-class QAPIGenH(QAPIGenC):
-
-    def _top(self):
-        return QAPIGenC._top(self) + guardstart(self.fname)
-
-    def _bottom(self):
-        return guardend(self.fname)
-
-
-class QAPIGenDoc(QAPIGen):
-
-    def _top(self):
-        return (QAPIGen._top(self)
-                + '@c AUTOMATICALLY GENERATED, DO NOT MODIFY\n\n')
-
-
-class QAPISchemaMonolithicCVisitor(QAPISchemaVisitor):
-
-    def __init__(self, prefix, what, blurb, pydoc):
-        self._prefix =3D prefix
-        self._what =3D what
-        self._genc =3D QAPIGenC(self._prefix + self._what + '.c',
-                              blurb, pydoc)
-        self._genh =3D QAPIGenH(self._prefix + self._what + '.h',
-                              blurb, pydoc)
-
-    def write(self, output_dir):
-        self._genc.write(output_dir)
-        self._genh.write(output_dir)
-
-
-class QAPISchemaModularCVisitor(QAPISchemaVisitor):
-
-    def __init__(self, prefix, what, blurb, pydoc):
-        self._prefix =3D prefix
-        self._what =3D what
-        self._blurb =3D blurb
-        self._pydoc =3D pydoc
-        self._genc =3D None
-        self._genh =3D None
-        self._module =3D {}
-        self._main_module =3D None
-
-    @staticmethod
-    def _is_user_module(name):
-        return name and not name.startswith('./')
-
-    @staticmethod
-    def _is_builtin_module(name):
-        return not name
-
-    def _module_dirname(self, what, name):
-        if self._is_user_module(name):
-            return os.path.dirname(name)
-        return ''
-
-    def _module_basename(self, what, name):
-        ret =3D '' if self._is_builtin_module(name) else self._prefix
-        if self._is_user_module(name):
-            basename =3D os.path.basename(name)
-            ret +=3D what
-            if name !=3D self._main_module:
-                ret +=3D '-' + os.path.splitext(basename)[0]
-        else:
-            name =3D name[2:] if name else 'builtin'
-            ret +=3D re.sub(r'-', '-' + name + '-', what)
-        return ret
-
-    def _module_filename(self, what, name):
-        return os.path.join(self._module_dirname(what, name),
-                            self._module_basename(what, name))
-
-    def _add_module(self, name, blurb):
-        basename =3D self._module_filename(self._what, name)
-        genc =3D QAPIGenC(basename + '.c', blurb, self._pydoc)
-        genh =3D QAPIGenH(basename + '.h', blurb, self._pydoc)
-        self._module[name] =3D (genc, genh)
-        self._set_module(name)
-
-    def _add_user_module(self, name, blurb):
-        assert self._is_user_module(name)
-        if self._main_module is None:
-            self._main_module =3D name
-        self._add_module(name, blurb)
-
-    def _add_system_module(self, name, blurb):
-        self._add_module(name and './' + name, blurb)
-
-    def _set_module(self, name):
-        self._genc, self._genh =3D self._module[name]
-
-    def write(self, output_dir, opt_builtins=3DFalse):
-        for name in self._module:
-            if self._is_builtin_module(name) and not opt_builtins:
-                continue
-            (genc, genh) =3D self._module[name]
-            genc.write(output_dir)
-            genh.write(output_dir)
-
-    def _begin_user_module(self, name):
-        pass
-
-    def visit_module(self, name):
-        if name in self._module:
-            self._set_module(name)
-        elif self._is_builtin_module(name):
-            # The built-in module has not been created.  No code may
-            # be generated.
-            self._genc =3D None
-            self._genh =3D None
-        else:
-            self._add_user_module(name, self._blurb)
-            self._begin_user_module(name)
-
-    def visit_include(self, name, info):
-        relname =3D os.path.relpath(self._module_filename(self._what, na=
me),
-                                  os.path.dirname(self._genh.fname))
-        self._genh.preamble_add(mcgen('''
-#include "%(relname)s.h"
-''',
-                                      relname=3Drelname))
diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index 693cc4486b..1c5125249f 100755
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -7,7 +7,8 @@
=20
 from __future__ import print_function
 import re
-import qapi.common
+from qapi.gen import QAPIGenDoc, QAPISchemaVisitor
+
=20
 MSG_FMT =3D """
 @deftypefn {type} {{}} {name}
@@ -216,10 +217,10 @@ def texi_entity(doc, what, ifcond, base=3DNone, var=
iants=3DNone,
             + texi_sections(doc, ifcond))
=20
=20
-class QAPISchemaGenDocVisitor(qapi.common.QAPISchemaVisitor):
+class QAPISchemaGenDocVisitor(QAPISchemaVisitor):
     def __init__(self, prefix):
         self._prefix =3D prefix
-        self._gen =3D qapi.common.QAPIGenDoc(self._prefix + 'qapi-doc.te=
xi')
+        self._gen =3D QAPIGenDoc(self._prefix + 'qapi-doc.texi')
         self.cur_doc =3D None
=20
     def write(self, output_dir):
diff --git a/scripts/qapi/error.py b/scripts/qapi/error.py
new file mode 100644
index 0000000000..1db6634044
--- /dev/null
+++ b/scripts/qapi/error.py
@@ -0,0 +1,42 @@
+#
+# QAPI error classes
+#
+# Copyright (c) 2017-2019 Red Hat Inc.
+#
+# Authors:
+#  Markus Armbruster <armbru@redhat.com>
+#  Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2.
+# See the COPYING file in the top-level directory.
+
+
+class QAPIError(Exception):
+    def __init__(self, info, col, msg):
+        Exception.__init__(self)
+        self.info =3D info
+        self.col =3D col
+        self.msg =3D msg
+
+    def __str__(self):
+        loc =3D str(self.info)
+        if self.col is not None:
+            assert self.info.line is not None
+            loc +=3D ':%s' % self.col
+        return loc + ': ' + self.msg
+
+
+class QAPIParseError(QAPIError):
+    def __init__(self, parser, msg):
+        col =3D 1
+        for ch in parser.src[parser.line_pos:parser.pos]:
+            if ch =3D=3D '\t':
+                col =3D (col + 7) % 8 + 1
+            else:
+                col +=3D 1
+        QAPIError.__init__(self, parser.info, col, msg)
+
+
+class QAPISemError(QAPIError):
+    def __init__(self, info, msg):
+        QAPIError.__init__(self, info, None, msg)
diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index a716a1d27f..10fc509fa9 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -13,6 +13,8 @@ See the COPYING file in the top-level directory.
 """
=20
 from qapi.common import *
+from qapi.gen import QAPISchemaModularCVisitor, ifcontext
+from qapi.schema import QAPISchemaEnumMember
 from qapi.types import gen_enum, gen_enum_lookup
=20
=20
diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
new file mode 100644
index 0000000000..da23063f57
--- /dev/null
+++ b/scripts/qapi/expr.py
@@ -0,0 +1,377 @@
+#
+# Check (context-free) QAPI schema expression structure
+#
+# Copyright IBM, Corp. 2011
+# Copyright (c) 2013-2019 Red Hat Inc.
+#
+# Authors:
+#  Anthony Liguori <aliguori@us.ibm.com>
+#  Markus Armbruster <armbru@redhat.com>
+#  Eric Blake <eblake@redhat.com>
+#  Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2.
+# See the COPYING file in the top-level directory.
+
+import re
+from collections import OrderedDict
+from qapi.common import c_name
+from qapi.error import QAPISemError
+
+
+# Names must be letters, numbers, -, and _.  They must start with letter=
,
+# except for downstream extensions which must start with __RFQDN_.
+# Dots are only valid in the downstream extension prefix.
+valid_name =3D re.compile(r'^(__[a-zA-Z0-9.-]+_)?'
+                        '[a-zA-Z][a-zA-Z0-9_-]*$')
+
+
+def check_name_is_str(name, info, source):
+    if not isinstance(name, str):
+        raise QAPISemError(info, "%s requires a string name" % source)
+
+
+def check_name_str(name, info, source,
+                   allow_optional=3DFalse, enum_member=3DFalse,
+                   permit_upper=3DFalse):
+    global valid_name
+    membername =3D name
+
+    if allow_optional and name.startswith('*'):
+        membername =3D name[1:]
+    # Enum members can start with a digit, because the generated C
+    # code always prefixes it with the enum name
+    if enum_member and membername[0].isdigit():
+        membername =3D 'D' + membername
+    # Reserve the entire 'q_' namespace for c_name(), and for 'q_empty'
+    # and 'q_obj_*' implicit type names.
+    if not valid_name.match(membername) or \
+       c_name(membername, False).startswith('q_'):
+        raise QAPISemError(info, "%s has an invalid name" % source)
+    if not permit_upper and name.lower() !=3D name:
+        raise QAPISemError(
+            info, "%s uses uppercase in name" % source)
+    assert not membername.startswith('*')
+
+
+def check_defn_name_str(name, info, meta):
+    check_name_str(name, info, meta, permit_upper=3DTrue)
+    if name.endswith('Kind') or name.endswith('List'):
+        raise QAPISemError(
+            info, "%s name should not end in '%s'" % (meta, name[-4:]))
+
+
+def check_keys(value, info, source, required, optional):
+
+    def pprint(elems):
+        return ', '.join("'" + e + "'" for e in sorted(elems))
+
+    missing =3D set(required) - set(value)
+    if missing:
+        raise QAPISemError(
+            info,
+            "%s misses key%s %s"
+            % (source, 's' if len(missing) > 1 else '',
+               pprint(missing)))
+    allowed =3D set(required + optional)
+    unknown =3D set(value) - allowed
+    if unknown:
+        raise QAPISemError(
+            info,
+            "%s has unknown key%s %s\nValid keys are %s."
+            % (source, 's' if len(unknown) > 1 else '',
+               pprint(unknown), pprint(allowed)))
+
+
+def check_flags(expr, info):
+    for key in ['gen', 'success-response']:
+        if key in expr and expr[key] is not False:
+            raise QAPISemError(
+                info, "flag '%s' may only use false value" % key)
+    for key in ['boxed', 'allow-oob', 'allow-preconfig']:
+        if key in expr and expr[key] is not True:
+            raise QAPISemError(
+                info, "flag '%s' may only use true value" % key)
+
+
+def normalize_if(expr):
+    ifcond =3D expr.get('if')
+    if isinstance(ifcond, str):
+        expr['if'] =3D [ifcond]
+
+
+def check_if(expr, info, source):
+
+    def check_if_str(ifcond, info):
+        if not isinstance(ifcond, str):
+            raise QAPISemError(
+                info,
+                "'if' condition of %s must be a string or a list of stri=
ngs"
+                % source)
+        if ifcond.strip() =3D=3D '':
+            raise QAPISemError(
+                info,
+                "'if' condition '%s' of %s makes no sense"
+                % (ifcond, source))
+
+    ifcond =3D expr.get('if')
+    if ifcond is None:
+        return
+    if isinstance(ifcond, list):
+        if ifcond =3D=3D []:
+            raise QAPISemError(
+                info, "'if' condition [] of %s is useless" % source)
+        for elt in ifcond:
+            check_if_str(elt, info)
+    else:
+        check_if_str(ifcond, info)
+
+
+def normalize_members(members):
+    if isinstance(members, OrderedDict):
+        for key, arg in members.items():
+            if isinstance(arg, dict):
+                continue
+            members[key] =3D {'type': arg}
+
+
+def check_type(value, info, source,
+               allow_array=3DFalse, allow_dict=3DFalse):
+    if value is None:
+        return
+
+    # Array type
+    if isinstance(value, list):
+        if not allow_array:
+            raise QAPISemError(info, "%s cannot be an array" % source)
+        if len(value) !=3D 1 or not isinstance(value[0], str):
+            raise QAPISemError(info,
+                               "%s: array type must contain single type =
name" %
+                               source)
+        return
+
+    # Type name
+    if isinstance(value, str):
+        return
+
+    # Anonymous type
+
+    if not allow_dict:
+        raise QAPISemError(info, "%s should be a type name" % source)
+
+    if not isinstance(value, OrderedDict):
+        raise QAPISemError(info,
+                           "%s should be an object or type name" % sourc=
e)
+
+    permit_upper =3D allow_dict in info.pragma.name_case_whitelist
+
+    # value is a dictionary, check that each member is okay
+    for (key, arg) in value.items():
+        key_source =3D "%s member '%s'" % (source, key)
+        check_name_str(key, info, key_source,
+                       allow_optional=3DTrue, permit_upper=3Dpermit_uppe=
r)
+        if c_name(key, False) =3D=3D 'u' or c_name(key, False).startswit=
h('has_'):
+            raise QAPISemError(info, "%s uses reserved name" % key_sourc=
e)
+        check_keys(arg, info, key_source, ['type'], ['if'])
+        check_if(arg, info, key_source)
+        normalize_if(arg)
+        check_type(arg['type'], info, key_source, allow_array=3DTrue)
+
+
+def normalize_features(features):
+    if isinstance(features, list):
+        features[:] =3D [f if isinstance(f, dict) else {'name': f}
+                       for f in features]
+
+
+def normalize_enum(expr):
+    if isinstance(expr['data'], list):
+        expr['data'] =3D [m if isinstance(m, dict) else {'name': m}
+                        for m in expr['data']]
+
+
+def check_enum(expr, info):
+    name =3D expr['enum']
+    members =3D expr['data']
+    prefix =3D expr.get('prefix')
+
+    if not isinstance(members, list):
+        raise QAPISemError(info, "'data' must be an array")
+    if prefix is not None and not isinstance(prefix, str):
+        raise QAPISemError(info, "'prefix' must be a string")
+
+    permit_upper =3D name in info.pragma.name_case_whitelist
+
+    for member in members:
+        source =3D "'data' member"
+        check_keys(member, info, source, ['name'], ['if'])
+        check_name_is_str(member['name'], info, source)
+        source =3D "%s '%s'" % (source, member['name'])
+        check_name_str(member['name'], info, source,
+                       enum_member=3DTrue, permit_upper=3Dpermit_upper)
+        check_if(member, info, source)
+        normalize_if(member)
+
+
+def check_struct(expr, info):
+    name =3D expr['struct']
+    members =3D expr['data']
+    features =3D expr.get('features')
+
+    check_type(members, info, "'data'", allow_dict=3Dname)
+    check_type(expr.get('base'), info, "'base'")
+
+    if features:
+        if not isinstance(features, list):
+            raise QAPISemError(info, "'features' must be an array")
+        for f in features:
+            source =3D "'features' member"
+            assert isinstance(f, dict)
+            check_keys(f, info, source, ['name'], ['if'])
+            check_name_is_str(f['name'], info, source)
+            source =3D "%s '%s'" % (source, f['name'])
+            check_name_str(f['name'], info, source)
+            check_if(f, info, source)
+            normalize_if(f)
+
+
+def check_union(expr, info):
+    name =3D expr['union']
+    base =3D expr.get('base')
+    discriminator =3D expr.get('discriminator')
+    members =3D expr['data']
+
+    if discriminator is None:   # simple union
+        if base is not None:
+            raise QAPISemError(info, "'base' requires 'discriminator'")
+    else:                       # flat union
+        check_type(base, info, "'base'", allow_dict=3Dname)
+        if not base:
+            raise QAPISemError(info, "'discriminator' requires 'base'")
+        check_name_is_str(discriminator, info, "'discriminator'")
+
+    for (key, value) in members.items():
+        source =3D "'data' member '%s'" % key
+        check_name_str(key, info, source)
+        check_keys(value, info, source, ['type'], ['if'])
+        check_if(value, info, source)
+        normalize_if(value)
+        check_type(value['type'], info, source, allow_array=3Dnot base)
+
+
+def check_alternate(expr, info):
+    members =3D expr['data']
+
+    if len(members) =3D=3D 0:
+        raise QAPISemError(info, "'data' must not be empty")
+    for (key, value) in members.items():
+        source =3D "'data' member '%s'" % key
+        check_name_str(key, info, source)
+        check_keys(value, info, source, ['type'], ['if'])
+        check_if(value, info, source)
+        normalize_if(value)
+        check_type(value['type'], info, source)
+
+
+def check_command(expr, info):
+    args =3D expr.get('data')
+    rets =3D expr.get('returns')
+    boxed =3D expr.get('boxed', False)
+
+    if boxed and args is None:
+        raise QAPISemError(info, "'boxed': true requires 'data'")
+    check_type(args, info, "'data'", allow_dict=3Dnot boxed)
+    check_type(rets, info, "'returns'", allow_array=3DTrue)
+
+
+def check_event(expr, info):
+    args =3D expr.get('data')
+    boxed =3D expr.get('boxed', False)
+
+    if boxed and args is None:
+        raise QAPISemError(info, "'boxed': true requires 'data'")
+    check_type(args, info, "'data'", allow_dict=3Dnot boxed)
+
+
+def check_exprs(exprs):
+    for expr_elem in exprs:
+        expr =3D expr_elem['expr']
+        info =3D expr_elem['info']
+        doc =3D expr_elem.get('doc')
+
+        if 'include' in expr:
+            continue
+
+        if 'enum' in expr:
+            meta =3D 'enum'
+        elif 'union' in expr:
+            meta =3D 'union'
+        elif 'alternate' in expr:
+            meta =3D 'alternate'
+        elif 'struct' in expr:
+            meta =3D 'struct'
+        elif 'command' in expr:
+            meta =3D 'command'
+        elif 'event' in expr:
+            meta =3D 'event'
+        else:
+            raise QAPISemError(info, "expression is missing metatype")
+
+        name =3D expr[meta]
+        check_name_is_str(name, info, "'%s'" % meta)
+        info.set_defn(meta, name)
+        check_defn_name_str(name, info, meta)
+
+        if doc:
+            if doc.symbol !=3D name:
+                raise QAPISemError(
+                    info, "documentation comment is for '%s'" % doc.symb=
ol)
+            doc.check_expr(expr)
+        elif info.pragma.doc_required:
+            raise QAPISemError(info,
+                               "documentation comment required")
+
+        if meta =3D=3D 'enum':
+            check_keys(expr, info, meta,
+                       ['enum', 'data'], ['if', 'prefix'])
+            normalize_enum(expr)
+            check_enum(expr, info)
+        elif meta =3D=3D 'union':
+            check_keys(expr, info, meta,
+                       ['union', 'data'],
+                       ['base', 'discriminator', 'if'])
+            normalize_members(expr.get('base'))
+            normalize_members(expr['data'])
+            check_union(expr, info)
+        elif meta =3D=3D 'alternate':
+            check_keys(expr, info, meta,
+                       ['alternate', 'data'], ['if'])
+            normalize_members(expr['data'])
+            check_alternate(expr, info)
+        elif meta =3D=3D 'struct':
+            check_keys(expr, info, meta,
+                       ['struct', 'data'], ['base', 'if', 'features'])
+            normalize_members(expr['data'])
+            normalize_features(expr.get('features'))
+            check_struct(expr, info)
+        elif meta =3D=3D 'command':
+            check_keys(expr, info, meta,
+                       ['command'],
+                       ['data', 'returns', 'boxed', 'if',
+                        'gen', 'success-response', 'allow-oob',
+                        'allow-preconfig'])
+            normalize_members(expr.get('data'))
+            check_command(expr, info)
+        elif meta =3D=3D 'event':
+            check_keys(expr, info, meta,
+                       ['event'], ['data', 'boxed', 'if'])
+            normalize_members(expr.get('data'))
+            check_event(expr, info)
+        else:
+            assert False, 'unexpected meta type'
+
+        normalize_if(expr)
+        check_if(expr, info, meta)
+        check_flags(expr, info)
+
+    return exprs
diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
new file mode 100644
index 0000000000..796c17c38a
--- /dev/null
+++ b/scripts/qapi/gen.py
@@ -0,0 +1,290 @@
+#
+# QAPI code generation
+#
+# Copyright (c) 2018-2019 Red Hat Inc.
+#
+# Authors:
+#  Markus Armbruster <armbru@redhat.com>
+#  Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2.
+# See the COPYING file in the top-level directory.
+
+
+import errno
+import os
+import re
+import sys
+from contextlib import contextmanager
+
+from qapi.common import *
+from qapi.schema import QAPISchemaVisitor
+
+
+class QAPIGen(object):
+
+    def __init__(self, fname):
+        self.fname =3D fname
+        self._preamble =3D ''
+        self._body =3D ''
+
+    def preamble_add(self, text):
+        self._preamble +=3D text
+
+    def add(self, text):
+        self._body +=3D text
+
+    def get_content(self):
+        return self._top() + self._preamble + self._body + self._bottom(=
)
+
+    def _top(self):
+        return ''
+
+    def _bottom(self):
+        return ''
+
+    def write(self, output_dir):
+        pathname =3D os.path.join(output_dir, self.fname)
+        dir =3D os.path.dirname(pathname)
+        if dir:
+            try:
+                os.makedirs(dir)
+            except os.error as e:
+                if e.errno !=3D errno.EEXIST:
+                    raise
+        fd =3D os.open(pathname, os.O_RDWR | os.O_CREAT, 0o666)
+        if sys.version_info[0] >=3D 3:
+            f =3D open(fd, 'r+', encoding=3D'utf-8')
+        else:
+            f =3D os.fdopen(fd, 'r+')
+        text =3D self.get_content()
+        oldtext =3D f.read(len(text) + 1)
+        if text !=3D oldtext:
+            f.seek(0)
+            f.truncate(0)
+            f.write(text)
+        f.close()
+
+
+def _wrap_ifcond(ifcond, before, after):
+    if before =3D=3D after:
+        return after   # suppress empty #if ... #endif
+
+    assert after.startswith(before)
+    out =3D before
+    added =3D after[len(before):]
+    if added[0] =3D=3D '\n':
+        out +=3D '\n'
+        added =3D added[1:]
+    out +=3D gen_if(ifcond)
+    out +=3D added
+    out +=3D gen_endif(ifcond)
+    return out
+
+
+class QAPIGenCCode(QAPIGen):
+
+    def __init__(self, fname):
+        QAPIGen.__init__(self, fname)
+        self._start_if =3D None
+
+    def start_if(self, ifcond):
+        assert self._start_if is None
+        self._start_if =3D (ifcond, self._body, self._preamble)
+
+    def end_if(self):
+        assert self._start_if
+        self._wrap_ifcond()
+        self._start_if =3D None
+
+    def _wrap_ifcond(self):
+        self._body =3D _wrap_ifcond(self._start_if[0],
+                                  self._start_if[1], self._body)
+        self._preamble =3D _wrap_ifcond(self._start_if[0],
+                                      self._start_if[2], self._preamble)
+
+    def get_content(self):
+        assert self._start_if is None
+        return QAPIGen.get_content(self)
+
+
+class QAPIGenC(QAPIGenCCode):
+
+    def __init__(self, fname, blurb, pydoc):
+        QAPIGenCCode.__init__(self, fname)
+        self._blurb =3D blurb
+        self._copyright =3D '\n * '.join(re.findall(r'^Copyright .*', py=
doc,
+                                                  re.MULTILINE))
+
+    def _top(self):
+        return mcgen('''
+/* AUTOMATICALLY GENERATED, DO NOT MODIFY */
+
+/*
+%(blurb)s
+ *
+ * %(copyright)s
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or=
 later.
+ * See the COPYING.LIB file in the top-level directory.
+ */
+
+''',
+                     blurb=3Dself._blurb, copyright=3Dself._copyright)
+
+    def _bottom(self):
+        return mcgen('''
+
+/* Dummy declaration to prevent empty .o file */
+char qapi_dummy_%(name)s;
+''',
+                     name=3Dc_fname(self.fname))
+
+
+class QAPIGenH(QAPIGenC):
+
+    def _top(self):
+        return QAPIGenC._top(self) + guardstart(self.fname)
+
+    def _bottom(self):
+        return guardend(self.fname)
+
+
+@contextmanager
+def ifcontext(ifcond, *args):
+    """A 'with' statement context manager to wrap with start_if()/end_if=
()
+
+    *args: any number of QAPIGenCCode
+
+    Example::
+
+        with ifcontext(ifcond, self._genh, self._genc):
+            modify self._genh and self._genc ...
+
+    Is equivalent to calling::
+
+        self._genh.start_if(ifcond)
+        self._genc.start_if(ifcond)
+        modify self._genh and self._genc ...
+        self._genh.end_if()
+        self._genc.end_if()
+    """
+    for arg in args:
+        arg.start_if(ifcond)
+    yield
+    for arg in args:
+        arg.end_if()
+
+
+class QAPIGenDoc(QAPIGen):
+
+    def _top(self):
+        return (QAPIGen._top(self)
+                + '@c AUTOMATICALLY GENERATED, DO NOT MODIFY\n\n')
+
+
+class QAPISchemaMonolithicCVisitor(QAPISchemaVisitor):
+
+    def __init__(self, prefix, what, blurb, pydoc):
+        self._prefix =3D prefix
+        self._what =3D what
+        self._genc =3D QAPIGenC(self._prefix + self._what + '.c',
+                              blurb, pydoc)
+        self._genh =3D QAPIGenH(self._prefix + self._what + '.h',
+                              blurb, pydoc)
+
+    def write(self, output_dir):
+        self._genc.write(output_dir)
+        self._genh.write(output_dir)
+
+
+class QAPISchemaModularCVisitor(QAPISchemaVisitor):
+
+    def __init__(self, prefix, what, blurb, pydoc):
+        self._prefix =3D prefix
+        self._what =3D what
+        self._blurb =3D blurb
+        self._pydoc =3D pydoc
+        self._genc =3D None
+        self._genh =3D None
+        self._module =3D {}
+        self._main_module =3D None
+
+    @staticmethod
+    def _is_user_module(name):
+        return name and not name.startswith('./')
+
+    @staticmethod
+    def _is_builtin_module(name):
+        return not name
+
+    def _module_dirname(self, what, name):
+        if self._is_user_module(name):
+            return os.path.dirname(name)
+        return ''
+
+    def _module_basename(self, what, name):
+        ret =3D '' if self._is_builtin_module(name) else self._prefix
+        if self._is_user_module(name):
+            basename =3D os.path.basename(name)
+            ret +=3D what
+            if name !=3D self._main_module:
+                ret +=3D '-' + os.path.splitext(basename)[0]
+        else:
+            name =3D name[2:] if name else 'builtin'
+            ret +=3D re.sub(r'-', '-' + name + '-', what)
+        return ret
+
+    def _module_filename(self, what, name):
+        return os.path.join(self._module_dirname(what, name),
+                            self._module_basename(what, name))
+
+    def _add_module(self, name, blurb):
+        basename =3D self._module_filename(self._what, name)
+        genc =3D QAPIGenC(basename + '.c', blurb, self._pydoc)
+        genh =3D QAPIGenH(basename + '.h', blurb, self._pydoc)
+        self._module[name] =3D (genc, genh)
+        self._set_module(name)
+
+    def _add_user_module(self, name, blurb):
+        assert self._is_user_module(name)
+        if self._main_module is None:
+            self._main_module =3D name
+        self._add_module(name, blurb)
+
+    def _add_system_module(self, name, blurb):
+        self._add_module(name and './' + name, blurb)
+
+    def _set_module(self, name):
+        self._genc, self._genh =3D self._module[name]
+
+    def write(self, output_dir, opt_builtins=3DFalse):
+        for name in self._module:
+            if self._is_builtin_module(name) and not opt_builtins:
+                continue
+            (genc, genh) =3D self._module[name]
+            genc.write(output_dir)
+            genh.write(output_dir)
+
+    def _begin_user_module(self, name):
+        pass
+
+    def visit_module(self, name):
+        if name in self._module:
+            self._set_module(name)
+        elif self._is_builtin_module(name):
+            # The built-in module has not been created.  No code may
+            # be generated.
+            self._genc =3D None
+            self._genh =3D None
+        else:
+            self._add_user_module(name, self._blurb)
+            self._begin_user_module(name)
+
+    def visit_include(self, name, info):
+        relname =3D os.path.relpath(self._module_filename(self._what, na=
me),
+                                  os.path.dirname(self._genh.fname))
+        self._genh.preamble_add(mcgen('''
+#include "%(relname)s.h"
+''',
+                                      relname=3Drelname))
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index f62cf0a2e1..4f257591de 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -10,7 +10,12 @@ This work is licensed under the terms of the GNU GPL, =
version 2.
 See the COPYING file in the top-level directory.
 """
=20
+import string
+
 from qapi.common import *
+from qapi.gen import QAPISchemaMonolithicCVisitor
+from qapi.schema import (QAPISchemaArrayType, QAPISchemaBuiltinType,
+                         QAPISchemaType)
=20
=20
 def to_qlit(obj, level=3D0, suppress_first_indent=3DFalse):
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
new file mode 100644
index 0000000000..cd7f88ebed
--- /dev/null
+++ b/scripts/qapi/parser.py
@@ -0,0 +1,569 @@
+#
+# QAPI schema parser
+#
+# Copyright IBM, Corp. 2011
+# Copyright (c) 2013-2019 Red Hat Inc.
+#
+# Authors:
+#  Anthony Liguori <aliguori@us.ibm.com>
+#  Markus Armbruster <armbru@redhat.com>
+#  Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
+#  Kevin Wolf <kwolf@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2.
+# See the COPYING file in the top-level directory.
+
+import os
+import re
+import sys
+from collections import OrderedDict
+
+from qapi.error import QAPIParseError, QAPISemError
+from qapi.source import QAPISourceInfo
+
+
+class QAPISchemaParser(object):
+
+    def __init__(self, fname, previously_included=3DNone, incl_info=3DNo=
ne):
+        previously_included =3D previously_included or set()
+        previously_included.add(os.path.abspath(fname))
+
+        try:
+            if sys.version_info[0] >=3D 3:
+                fp =3D open(fname, 'r', encoding=3D'utf-8')
+            else:
+                fp =3D open(fname, 'r')
+            self.src =3D fp.read()
+        except IOError as e:
+            raise QAPISemError(incl_info or QAPISourceInfo(None, None, N=
one),
+                               "can't read %s file '%s': %s"
+                               % ("include" if incl_info else "schema",
+                                  fname,
+                                  e.strerror))
+
+        if self.src =3D=3D '' or self.src[-1] !=3D '\n':
+            self.src +=3D '\n'
+        self.cursor =3D 0
+        self.info =3D QAPISourceInfo(fname, 1, incl_info)
+        self.line_pos =3D 0
+        self.exprs =3D []
+        self.docs =3D []
+        self.accept()
+        cur_doc =3D None
+
+        while self.tok is not None:
+            info =3D self.info
+            if self.tok =3D=3D '#':
+                self.reject_expr_doc(cur_doc)
+                cur_doc =3D self.get_doc(info)
+                self.docs.append(cur_doc)
+                continue
+
+            expr =3D self.get_expr(False)
+            if 'include' in expr:
+                self.reject_expr_doc(cur_doc)
+                if len(expr) !=3D 1:
+                    raise QAPISemError(info, "invalid 'include' directiv=
e")
+                include =3D expr['include']
+                if not isinstance(include, str):
+                    raise QAPISemError(info,
+                                       "value of 'include' must be a str=
ing")
+                incl_fname =3D os.path.join(os.path.dirname(fname),
+                                          include)
+                self.exprs.append({'expr': {'include': incl_fname},
+                                   'info': info})
+                exprs_include =3D self._include(include, info, incl_fnam=
e,
+                                              previously_included)
+                if exprs_include:
+                    self.exprs.extend(exprs_include.exprs)
+                    self.docs.extend(exprs_include.docs)
+            elif "pragma" in expr:
+                self.reject_expr_doc(cur_doc)
+                if len(expr) !=3D 1:
+                    raise QAPISemError(info, "invalid 'pragma' directive=
")
+                pragma =3D expr['pragma']
+                if not isinstance(pragma, dict):
+                    raise QAPISemError(
+                        info, "value of 'pragma' must be an object")
+                for name, value in pragma.items():
+                    self._pragma(name, value, info)
+            else:
+                expr_elem =3D {'expr': expr,
+                             'info': info}
+                if cur_doc:
+                    if not cur_doc.symbol:
+                        raise QAPISemError(
+                            cur_doc.info, "definition documentation requ=
ired")
+                    expr_elem['doc'] =3D cur_doc
+                self.exprs.append(expr_elem)
+            cur_doc =3D None
+        self.reject_expr_doc(cur_doc)
+
+    @staticmethod
+    def reject_expr_doc(doc):
+        if doc and doc.symbol:
+            raise QAPISemError(
+                doc.info,
+                "documentation for '%s' is not followed by the definitio=
n"
+                % doc.symbol)
+
+    def _include(self, include, info, incl_fname, previously_included):
+        incl_abs_fname =3D os.path.abspath(incl_fname)
+        # catch inclusion cycle
+        inf =3D info
+        while inf:
+            if incl_abs_fname =3D=3D os.path.abspath(inf.fname):
+                raise QAPISemError(info, "inclusion loop for %s" % inclu=
de)
+            inf =3D inf.parent
+
+        # skip multiple include of the same file
+        if incl_abs_fname in previously_included:
+            return None
+
+        return QAPISchemaParser(incl_fname, previously_included, info)
+
+    def _pragma(self, name, value, info):
+        if name =3D=3D 'doc-required':
+            if not isinstance(value, bool):
+                raise QAPISemError(info,
+                                   "pragma 'doc-required' must be boolea=
n")
+            info.pragma.doc_required =3D value
+        elif name =3D=3D 'returns-whitelist':
+            if (not isinstance(value, list)
+                    or any([not isinstance(elt, str) for elt in value]))=
:
+                raise QAPISemError(
+                    info,
+                    "pragma returns-whitelist must be a list of strings"=
)
+            info.pragma.returns_whitelist =3D value
+        elif name =3D=3D 'name-case-whitelist':
+            if (not isinstance(value, list)
+                    or any([not isinstance(elt, str) for elt in value]))=
:
+                raise QAPISemError(
+                    info,
+                    "pragma name-case-whitelist must be a list of string=
s")
+            info.pragma.name_case_whitelist =3D value
+        else:
+            raise QAPISemError(info, "unknown pragma '%s'" % name)
+
+    def accept(self, skip_comment=3DTrue):
+        while True:
+            self.tok =3D self.src[self.cursor]
+            self.pos =3D self.cursor
+            self.cursor +=3D 1
+            self.val =3D None
+
+            if self.tok =3D=3D '#':
+                if self.src[self.cursor] =3D=3D '#':
+                    # Start of doc comment
+                    skip_comment =3D False
+                self.cursor =3D self.src.find('\n', self.cursor)
+                if not skip_comment:
+                    self.val =3D self.src[self.pos:self.cursor]
+                    return
+            elif self.tok in '{}:,[]':
+                return
+            elif self.tok =3D=3D "'":
+                # Note: we accept only printable ASCII
+                string =3D ''
+                esc =3D False
+                while True:
+                    ch =3D self.src[self.cursor]
+                    self.cursor +=3D 1
+                    if ch =3D=3D '\n':
+                        raise QAPIParseError(self, "missing terminating =
\"'\"")
+                    if esc:
+                        # Note: we recognize only \\ because we have
+                        # no use for funny characters in strings
+                        if ch !=3D '\\':
+                            raise QAPIParseError(self,
+                                                 "unknown escape \\%s" %=
 ch)
+                        esc =3D False
+                    elif ch =3D=3D '\\':
+                        esc =3D True
+                        continue
+                    elif ch =3D=3D "'":
+                        self.val =3D string
+                        return
+                    if ord(ch) < 32 or ord(ch) >=3D 127:
+                        raise QAPIParseError(
+                            self, "funny character in string")
+                    string +=3D ch
+            elif self.src.startswith('true', self.pos):
+                self.val =3D True
+                self.cursor +=3D 3
+                return
+            elif self.src.startswith('false', self.pos):
+                self.val =3D False
+                self.cursor +=3D 4
+                return
+            elif self.tok =3D=3D '\n':
+                if self.cursor =3D=3D len(self.src):
+                    self.tok =3D None
+                    return
+                self.info =3D self.info.next_line()
+                self.line_pos =3D self.cursor
+            elif not self.tok.isspace():
+                # Show up to next structural, whitespace or quote
+                # character
+                match =3D re.match('[^[\\]{}:,\\s\'"]+',
+                                 self.src[self.cursor-1:])
+                raise QAPIParseError(self, "stray '%s'" % match.group(0)=
)
+
+    def get_members(self):
+        expr =3D OrderedDict()
+        if self.tok =3D=3D '}':
+            self.accept()
+            return expr
+        if self.tok !=3D "'":
+            raise QAPIParseError(self, "expected string or '}'")
+        while True:
+            key =3D self.val
+            self.accept()
+            if self.tok !=3D ':':
+                raise QAPIParseError(self, "expected ':'")
+            self.accept()
+            if key in expr:
+                raise QAPIParseError(self, "duplicate key '%s'" % key)
+            expr[key] =3D self.get_expr(True)
+            if self.tok =3D=3D '}':
+                self.accept()
+                return expr
+            if self.tok !=3D ',':
+                raise QAPIParseError(self, "expected ',' or '}'")
+            self.accept()
+            if self.tok !=3D "'":
+                raise QAPIParseError(self, "expected string")
+
+    def get_values(self):
+        expr =3D []
+        if self.tok =3D=3D ']':
+            self.accept()
+            return expr
+        if self.tok not in "{['tfn":
+            raise QAPIParseError(
+                self, "expected '{', '[', ']', string, boolean or 'null'=
")
+        while True:
+            expr.append(self.get_expr(True))
+            if self.tok =3D=3D ']':
+                self.accept()
+                return expr
+            if self.tok !=3D ',':
+                raise QAPIParseError(self, "expected ',' or ']'")
+            self.accept()
+
+    def get_expr(self, nested):
+        if self.tok !=3D '{' and not nested:
+            raise QAPIParseError(self, "expected '{'")
+        if self.tok =3D=3D '{':
+            self.accept()
+            expr =3D self.get_members()
+        elif self.tok =3D=3D '[':
+            self.accept()
+            expr =3D self.get_values()
+        elif self.tok in "'tfn":
+            expr =3D self.val
+            self.accept()
+        else:
+            raise QAPIParseError(
+                self, "expected '{', '[', string, boolean or 'null'")
+        return expr
+
+    def get_doc(self, info):
+        if self.val !=3D '##':
+            raise QAPIParseError(
+                self, "junk after '##' at start of documentation comment=
")
+
+        doc =3D QAPIDoc(self, info)
+        self.accept(False)
+        while self.tok =3D=3D '#':
+            if self.val.startswith('##'):
+                # End of doc comment
+                if self.val !=3D '##':
+                    raise QAPIParseError(
+                        self,
+                        "junk after '##' at end of documentation comment=
")
+                doc.end_comment()
+                self.accept()
+                return doc
+            else:
+                doc.append(self.val)
+            self.accept(False)
+
+        raise QAPIParseError(self, "documentation comment must end with =
'##'")
+
+
+class QAPIDoc(object):
+    """
+    A documentation comment block, either definition or free-form
+
+    Definition documentation blocks consist of
+
+    * a body section: one line naming the definition, followed by an
+      overview (any number of lines)
+
+    * argument sections: a description of each argument (for commands
+      and events) or member (for structs, unions and alternates)
+
+    * features sections: a description of each feature flag
+
+    * additional (non-argument) sections, possibly tagged
+
+    Free-form documentation blocks consist only of a body section.
+    """
+
+    class Section(object):
+        def __init__(self, name=3DNone):
+            # optional section name (argument/member or section name)
+            self.name =3D name
+            # the list of lines for this section
+            self.text =3D ''
+
+        def append(self, line):
+            self.text +=3D line.rstrip() + '\n'
+
+    class ArgSection(Section):
+        def __init__(self, name):
+            QAPIDoc.Section.__init__(self, name)
+            self.member =3D None
+
+        def connect(self, member):
+            self.member =3D member
+
+    def __init__(self, parser, info):
+        # self._parser is used to report errors with QAPIParseError.  Th=
e
+        # resulting error position depends on the state of the parser.
+        # It happens to be the beginning of the comment.  More or less
+        # servicable, but action at a distance.
+        self._parser =3D parser
+        self.info =3D info
+        self.symbol =3D None
+        self.body =3D QAPIDoc.Section()
+        # dict mapping parameter name to ArgSection
+        self.args =3D OrderedDict()
+        self.features =3D OrderedDict()
+        # a list of Section
+        self.sections =3D []
+        # the current section
+        self._section =3D self.body
+        self._append_line =3D self._append_body_line
+
+    def has_section(self, name):
+        """Return True if we have a section with this name."""
+        for i in self.sections:
+            if i.name =3D=3D name:
+                return True
+        return False
+
+    def append(self, line):
+        """
+        Parse a comment line and add it to the documentation.
+
+        The way that the line is dealt with depends on which part of
+        the documentation we're parsing right now:
+        * The body section: ._append_line is ._append_body_line
+        * An argument section: ._append_line is ._append_args_line
+        * A features section: ._append_line is ._append_features_line
+        * An additional section: ._append_line is ._append_various_line
+        """
+        line =3D line[1:]
+        if not line:
+            self._append_freeform(line)
+            return
+
+        if line[0] !=3D ' ':
+            raise QAPIParseError(self._parser, "missing space after #")
+        line =3D line[1:]
+        self._append_line(line)
+
+    def end_comment(self):
+        self._end_section()
+
+    @staticmethod
+    def _is_section_tag(name):
+        return name in ('Returns:', 'Since:',
+                        # those are often singular or plural
+                        'Note:', 'Notes:',
+                        'Example:', 'Examples:',
+                        'TODO:')
+
+    def _append_body_line(self, line):
+        """
+        Process a line of documentation text in the body section.
+
+        If this a symbol line and it is the section's first line, this
+        is a definition documentation block for that symbol.
+
+        If it's a definition documentation block, another symbol line
+        begins the argument section for the argument named by it, and
+        a section tag begins an additional section.  Start that
+        section and append the line to it.
+
+        Else, append the line to the current section.
+        """
+        name =3D line.split(' ', 1)[0]
+        # FIXME not nice: things like '#  @foo:' and '# @foo: ' aren't
+        # recognized, and get silently treated as ordinary text
+        if not self.symbol and not self.body.text and line.startswith('@=
'):
+            if not line.endswith(':'):
+                raise QAPIParseError(self._parser, "line should end with=
 ':'")
+            self.symbol =3D line[1:-1]
+            # FIXME invalid names other than the empty string aren't fla=
gged
+            if not self.symbol:
+                raise QAPIParseError(self._parser, "invalid name")
+        elif self.symbol:
+            # This is a definition documentation block
+            if name.startswith('@') and name.endswith(':'):
+                self._append_line =3D self._append_args_line
+                self._append_args_line(line)
+            elif line =3D=3D 'Features:':
+                self._append_line =3D self._append_features_line
+            elif self._is_section_tag(name):
+                self._append_line =3D self._append_various_line
+                self._append_various_line(line)
+            else:
+                self._append_freeform(line.strip())
+        else:
+            # This is a free-form documentation block
+            self._append_freeform(line.strip())
+
+    def _append_args_line(self, line):
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
+        name =3D line.split(' ', 1)[0]
+
+        if name.startswith('@') and name.endswith(':'):
+            line =3D line[len(name)+1:]
+            self._start_args_section(name[1:-1])
+        elif self._is_section_tag(name):
+            self._append_line =3D self._append_various_line
+            self._append_various_line(line)
+            return
+        elif (self._section.text.endswith('\n\n')
+              and line and not line[0].isspace()):
+            if line =3D=3D 'Features:':
+                self._append_line =3D self._append_features_line
+            else:
+                self._start_section()
+                self._append_line =3D self._append_various_line
+                self._append_various_line(line)
+            return
+
+        self._append_freeform(line.strip())
+
+    def _append_features_line(self, line):
+        name =3D line.split(' ', 1)[0]
+
+        if name.startswith('@') and name.endswith(':'):
+            line =3D line[len(name)+1:]
+            self._start_features_section(name[1:-1])
+        elif self._is_section_tag(name):
+            self._append_line =3D self._append_various_line
+            self._append_various_line(line)
+            return
+        elif (self._section.text.endswith('\n\n')
+              and line and not line[0].isspace()):
+            self._start_section()
+            self._append_line =3D self._append_various_line
+            self._append_various_line(line)
+            return
+
+        self._append_freeform(line.strip())
+
+    def _append_various_line(self, line):
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
+        name =3D line.split(' ', 1)[0]
+
+        if name.startswith('@') and name.endswith(':'):
+            raise QAPIParseError(self._parser,
+                                 "'%s' can't follow '%s' section"
+                                 % (name, self.sections[0].name))
+        elif self._is_section_tag(name):
+            line =3D line[len(name)+1:]
+            self._start_section(name[:-1])
+
+        if (not self._section.name or
+                not self._section.name.startswith('Example')):
+            line =3D line.strip()
+
+        self._append_freeform(line)
+
+    def _start_symbol_section(self, symbols_dict, name):
+        # FIXME invalid names other than the empty string aren't flagged
+        if not name:
+            raise QAPIParseError(self._parser, "invalid parameter name")
+        if name in symbols_dict:
+            raise QAPIParseError(self._parser,
+                                 "'%s' parameter name duplicated" % name=
)
+        assert not self.sections
+        self._end_section()
+        self._section =3D QAPIDoc.ArgSection(name)
+        symbols_dict[name] =3D self._section
+
+    def _start_args_section(self, name):
+        self._start_symbol_section(self.args, name)
+
+    def _start_features_section(self, name):
+        self._start_symbol_section(self.features, name)
+
+    def _start_section(self, name=3DNone):
+        if name in ('Returns', 'Since') and self.has_section(name):
+            raise QAPIParseError(self._parser,
+                                 "duplicated '%s' section" % name)
+        self._end_section()
+        self._section =3D QAPIDoc.Section(name)
+        self.sections.append(self._section)
+
+    def _end_section(self):
+        if self._section:
+            text =3D self._section.text =3D self._section.text.strip()
+            if self._section.name and (not text or text.isspace()):
+                raise QAPIParseError(
+                    self._parser,
+                    "empty doc section '%s'" % self._section.name)
+            self._section =3D None
+
+    def _append_freeform(self, line):
+        match =3D re.match(r'(@\S+:)', line)
+        if match:
+            raise QAPIParseError(self._parser,
+                                 "'%s' not allowed in free-form document=
ation"
+                                 % match.group(1))
+        self._section.append(line)
+
+    def connect_member(self, member):
+        if member.name not in self.args:
+            # Undocumented TODO outlaw
+            self.args[member.name] =3D QAPIDoc.ArgSection(member.name)
+        self.args[member.name].connect(member)
+
+    def check_expr(self, expr):
+        if self.has_section('Returns') and 'command' not in expr:
+            raise QAPISemError(self.info,
+                               "'Returns:' is only valid for commands")
+
+    def check(self):
+        bogus =3D [name for name, section in self.args.items()
+                 if not section.member]
+        if bogus:
+            raise QAPISemError(
+                self.info,
+                "the following documented members are not in "
+                "the declaration: %s" % ", ".join(bogus))
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
new file mode 100644
index 0000000000..38041098bd
--- /dev/null
+++ b/scripts/qapi/schema.py
@@ -0,0 +1,1042 @@
+#
+# QAPI schema internal representation
+#
+# Copyright (c) 2015-2019 Red Hat Inc.
+#
+# Authors:
+#  Markus Armbruster <armbru@redhat.com>
+#  Eric Blake <eblake@redhat.com>
+#  Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2.
+# See the COPYING file in the top-level directory.
+
+# TODO catching name collisions in generated code would be nice
+
+import os
+import re
+from collections import OrderedDict
+
+from qapi.common import c_name, pointer_suffix
+from qapi.error import QAPIError, QAPIParseError, QAPISemError
+from qapi.expr import check_exprs
+from qapi.parser import QAPISchemaParser
+
+
+class QAPISchemaEntity(object):
+    meta =3D None
+
+    def __init__(self, name, info, doc, ifcond=3DNone):
+        assert name is None or isinstance(name, str)
+        self.name =3D name
+        self._module =3D None
+        # For explicitly defined entities, info points to the (explicit)
+        # definition.  For builtins (and their arrays), info is None.
+        # For implicitly defined entities, info points to a place that
+        # triggered the implicit definition (there may be more than one
+        # such place).
+        self.info =3D info
+        self.doc =3D doc
+        self._ifcond =3D ifcond or []
+        self._checked =3D False
+
+    def c_name(self):
+        return c_name(self.name)
+
+    def check(self, schema):
+        assert not self._checked
+        if self.info:
+            self._module =3D os.path.relpath(self.info.fname,
+                                           os.path.dirname(schema.fname)=
)
+        self._checked =3D True
+
+    @property
+    def ifcond(self):
+        assert self._checked
+        return self._ifcond
+
+    @property
+    def module(self):
+        assert self._checked
+        return self._module
+
+    def is_implicit(self):
+        return not self.info
+
+    def visit(self, visitor):
+        assert self._checked
+
+    def describe(self):
+        assert self.meta
+        return "%s '%s'" % (self.meta, self.name)
+
+
+class QAPISchemaVisitor(object):
+    def visit_begin(self, schema):
+        pass
+
+    def visit_end(self):
+        pass
+
+    def visit_module(self, fname):
+        pass
+
+    def visit_needed(self, entity):
+        # Default to visiting everything
+        return True
+
+    def visit_include(self, fname, info):
+        pass
+
+    def visit_builtin_type(self, name, info, json_type):
+        pass
+
+    def visit_enum_type(self, name, info, ifcond, members, prefix):
+        pass
+
+    def visit_array_type(self, name, info, ifcond, element_type):
+        pass
+
+    def visit_object_type(self, name, info, ifcond, base, members, varia=
nts,
+                          features):
+        pass
+
+    def visit_object_type_flat(self, name, info, ifcond, members, varian=
ts,
+                               features):
+        pass
+
+    def visit_alternate_type(self, name, info, ifcond, variants):
+        pass
+
+    def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
+                      success_response, boxed, allow_oob, allow_preconfi=
g):
+        pass
+
+    def visit_event(self, name, info, ifcond, arg_type, boxed):
+        pass
+
+
+class QAPISchemaInclude(QAPISchemaEntity):
+
+    def __init__(self, fname, info):
+        QAPISchemaEntity.__init__(self, None, info, None)
+        self.fname =3D fname
+
+    def visit(self, visitor):
+        QAPISchemaEntity.visit(self, visitor)
+        visitor.visit_include(self.fname, self.info)
+
+
+class QAPISchemaType(QAPISchemaEntity):
+    # Return the C type for common use.
+    # For the types we commonly box, this is a pointer type.
+    def c_type(self):
+        pass
+
+    # Return the C type to be used in a parameter list.
+    def c_param_type(self):
+        return self.c_type()
+
+    # Return the C type to be used where we suppress boxing.
+    def c_unboxed_type(self):
+        return self.c_type()
+
+    def json_type(self):
+        pass
+
+    def alternate_qtype(self):
+        json2qtype =3D {
+            'null':    'QTYPE_QNULL',
+            'string':  'QTYPE_QSTRING',
+            'number':  'QTYPE_QNUM',
+            'int':     'QTYPE_QNUM',
+            'boolean': 'QTYPE_QBOOL',
+            'object':  'QTYPE_QDICT'
+        }
+        return json2qtype.get(self.json_type())
+
+    def doc_type(self):
+        if self.is_implicit():
+            return None
+        return self.name
+
+    def describe(self):
+        assert self.meta
+        return "%s type '%s'" % (self.meta, self.name)
+
+
+class QAPISchemaBuiltinType(QAPISchemaType):
+    meta =3D 'built-in'
+
+    def __init__(self, name, json_type, c_type):
+        QAPISchemaType.__init__(self, name, None, None)
+        assert not c_type or isinstance(c_type, str)
+        assert json_type in ('string', 'number', 'int', 'boolean', 'null=
',
+                             'value')
+        self._json_type_name =3D json_type
+        self._c_type_name =3D c_type
+
+    def c_name(self):
+        return self.name
+
+    def c_type(self):
+        return self._c_type_name
+
+    def c_param_type(self):
+        if self.name =3D=3D 'str':
+            return 'const ' + self._c_type_name
+        return self._c_type_name
+
+    def json_type(self):
+        return self._json_type_name
+
+    def doc_type(self):
+        return self.json_type()
+
+    def visit(self, visitor):
+        QAPISchemaType.visit(self, visitor)
+        visitor.visit_builtin_type(self.name, self.info, self.json_type(=
))
+
+
+class QAPISchemaEnumType(QAPISchemaType):
+    meta =3D 'enum'
+
+    def __init__(self, name, info, doc, ifcond, members, prefix):
+        QAPISchemaType.__init__(self, name, info, doc, ifcond)
+        for m in members:
+            assert isinstance(m, QAPISchemaEnumMember)
+            m.set_defined_in(name)
+        assert prefix is None or isinstance(prefix, str)
+        self.members =3D members
+        self.prefix =3D prefix
+
+    def check(self, schema):
+        QAPISchemaType.check(self, schema)
+        seen =3D {}
+        for m in self.members:
+            m.check_clash(self.info, seen)
+            if self.doc:
+                self.doc.connect_member(m)
+
+    def is_implicit(self):
+        # See QAPISchema._make_implicit_enum_type() and ._def_predefined=
s()
+        return self.name.endswith('Kind') or self.name =3D=3D 'QType'
+
+    def c_type(self):
+        return c_name(self.name)
+
+    def member_names(self):
+        return [m.name for m in self.members]
+
+    def json_type(self):
+        return 'string'
+
+    def visit(self, visitor):
+        QAPISchemaType.visit(self, visitor)
+        visitor.visit_enum_type(self.name, self.info, self.ifcond,
+                                self.members, self.prefix)
+
+
+class QAPISchemaArrayType(QAPISchemaType):
+    meta =3D 'array'
+
+    def __init__(self, name, info, element_type):
+        QAPISchemaType.__init__(self, name, info, None, None)
+        assert isinstance(element_type, str)
+        self._element_type_name =3D element_type
+        self.element_type =3D None
+
+    def check(self, schema):
+        QAPISchemaType.check(self, schema)
+        self.element_type =3D schema.resolve_type(
+            self._element_type_name, self.info,
+            self.info and self.info.defn_meta)
+        assert not isinstance(self.element_type, QAPISchemaArrayType)
+
+    @property
+    def ifcond(self):
+        assert self._checked
+        return self.element_type.ifcond
+
+    @property
+    def module(self):
+        assert self._checked
+        return self.element_type.module
+
+    def is_implicit(self):
+        return True
+
+    def c_type(self):
+        return c_name(self.name) + pointer_suffix
+
+    def json_type(self):
+        return 'array'
+
+    def doc_type(self):
+        elt_doc_type =3D self.element_type.doc_type()
+        if not elt_doc_type:
+            return None
+        return 'array of ' + elt_doc_type
+
+    def visit(self, visitor):
+        QAPISchemaType.visit(self, visitor)
+        visitor.visit_array_type(self.name, self.info, self.ifcond,
+                                 self.element_type)
+
+    def describe(self):
+        assert self.meta
+        return "%s type ['%s']" % (self.meta, self._element_type_name)
+
+
+class QAPISchemaObjectType(QAPISchemaType):
+    def __init__(self, name, info, doc, ifcond,
+                 base, local_members, variants, features):
+        # struct has local_members, optional base, and no variants
+        # flat union has base, variants, and no local_members
+        # simple union has local_members, variants, and no base
+        QAPISchemaType.__init__(self, name, info, doc, ifcond)
+        self.meta =3D 'union' if variants else 'struct'
+        assert base is None or isinstance(base, str)
+        for m in local_members:
+            assert isinstance(m, QAPISchemaObjectTypeMember)
+            m.set_defined_in(name)
+        if variants is not None:
+            assert isinstance(variants, QAPISchemaObjectTypeVariants)
+            variants.set_defined_in(name)
+        for f in features:
+            assert isinstance(f, QAPISchemaFeature)
+            f.set_defined_in(name)
+        self._base_name =3D base
+        self.base =3D None
+        self.local_members =3D local_members
+        self.variants =3D variants
+        self.members =3D None
+        self.features =3D features
+
+    def check(self, schema):
+        # This calls another type T's .check() exactly when the C
+        # struct emitted by gen_object() contains that T's C struct
+        # (pointers don't count).
+        if self.members is not None:
+            # A previous .check() completed: nothing to do
+            return
+        if self._checked:
+            # Recursed: C struct contains itself
+            raise QAPISemError(self.info,
+                               "object %s contains itself" % self.name)
+
+        QAPISchemaType.check(self, schema)
+        assert self._checked and self.members is None
+
+        seen =3D OrderedDict()
+        if self._base_name:
+            self.base =3D schema.resolve_type(self._base_name, self.info=
,
+                                            "'base'")
+            if (not isinstance(self.base, QAPISchemaObjectType)
+                    or self.base.variants):
+                raise QAPISemError(
+                    self.info,
+                    "'base' requires a struct type, %s isn't"
+                    % self.base.describe())
+            self.base.check(schema)
+            self.base.check_clash(self.info, seen)
+        for m in self.local_members:
+            m.check(schema)
+            m.check_clash(self.info, seen)
+            if self.doc:
+                self.doc.connect_member(m)
+        members =3D seen.values()
+
+        if self.variants:
+            self.variants.check(schema, seen)
+            self.variants.check_clash(self.info, seen)
+
+        # Features are in a name space separate from members
+        seen =3D {}
+        for f in self.features:
+            f.check_clash(self.info, seen)
+
+        if self.doc:
+            self.doc.check()
+
+        self.members =3D members  # mark completed
+
+    # Check that the members of this type do not cause duplicate JSON me=
mbers,
+    # and update seen to track the members seen so far. Report any error=
s
+    # on behalf of info, which is not necessarily self.info
+    def check_clash(self, info, seen):
+        assert self._checked
+        assert not self.variants       # not implemented
+        for m in self.members:
+            m.check_clash(info, seen)
+
+    @property
+    def ifcond(self):
+        assert self._checked
+        if isinstance(self._ifcond, QAPISchemaType):
+            # Simple union wrapper type inherits from wrapped type;
+            # see _make_implicit_object_type()
+            return self._ifcond.ifcond
+        return self._ifcond
+
+    def is_implicit(self):
+        # See QAPISchema._make_implicit_object_type(), as well as
+        # _def_predefineds()
+        return self.name.startswith('q_')
+
+    def is_empty(self):
+        assert self.members is not None
+        return not self.members and not self.variants
+
+    def c_name(self):
+        assert self.name !=3D 'q_empty'
+        return QAPISchemaType.c_name(self)
+
+    def c_type(self):
+        assert not self.is_implicit()
+        return c_name(self.name) + pointer_suffix
+
+    def c_unboxed_type(self):
+        return c_name(self.name)
+
+    def json_type(self):
+        return 'object'
+
+    def visit(self, visitor):
+        QAPISchemaType.visit(self, visitor)
+        visitor.visit_object_type(self.name, self.info, self.ifcond,
+                                  self.base, self.local_members, self.va=
riants,
+                                  self.features)
+        visitor.visit_object_type_flat(self.name, self.info, self.ifcond=
,
+                                       self.members, self.variants,
+                                       self.features)
+
+
+class QAPISchemaMember(object):
+    """ Represents object members, enum members and features """
+    role =3D 'member'
+
+    def __init__(self, name, info, ifcond=3DNone):
+        assert isinstance(name, str)
+        self.name =3D name
+        self.info =3D info
+        self.ifcond =3D ifcond or []
+        self.defined_in =3D None
+
+    def set_defined_in(self, name):
+        assert not self.defined_in
+        self.defined_in =3D name
+
+    def check_clash(self, info, seen):
+        cname =3D c_name(self.name)
+        if cname in seen:
+            raise QAPISemError(
+                info,
+                "%s collides with %s"
+                % (self.describe(info), seen[cname].describe(info)))
+        seen[cname] =3D self
+
+    def describe(self, info):
+        role =3D self.role
+        defined_in =3D self.defined_in
+        assert defined_in
+
+        if defined_in.startswith('q_obj_'):
+            # See QAPISchema._make_implicit_object_type() - reverse the
+            # mapping there to create a nice human-readable description
+            defined_in =3D defined_in[6:]
+            if defined_in.endswith('-arg'):
+                # Implicit type created for a command's dict 'data'
+                assert role =3D=3D 'member'
+                role =3D 'parameter'
+            elif defined_in.endswith('-base'):
+                # Implicit type created for a flat union's dict 'base'
+                role =3D 'base ' + role
+            else:
+                # Implicit type created for a simple union's branch
+                assert defined_in.endswith('-wrapper')
+                # Unreachable and not implemented
+                assert False
+        elif defined_in.endswith('Kind'):
+            # See QAPISchema._make_implicit_enum_type()
+            # Implicit enum created for simple union's branches
+            assert role =3D=3D 'value'
+            role =3D 'branch'
+        elif defined_in !=3D info.defn_name:
+            return "%s '%s' of type '%s'" % (role, self.name, defined_in=
)
+        return "%s '%s'" % (role, self.name)
+
+
+class QAPISchemaEnumMember(QAPISchemaMember):
+    role =3D 'value'
+
+
+class QAPISchemaFeature(QAPISchemaMember):
+    role =3D 'feature'
+
+
+class QAPISchemaObjectTypeMember(QAPISchemaMember):
+    def __init__(self, name, info, typ, optional, ifcond=3DNone):
+        QAPISchemaMember.__init__(self, name, info, ifcond)
+        assert isinstance(typ, str)
+        assert isinstance(optional, bool)
+        self._type_name =3D typ
+        self.type =3D None
+        self.optional =3D optional
+
+    def check(self, schema):
+        assert self.defined_in
+        self.type =3D schema.resolve_type(self._type_name, self.info,
+                                        self.describe)
+
+
+class QAPISchemaObjectTypeVariants(object):
+    def __init__(self, tag_name, info, tag_member, variants):
+        # Flat unions pass tag_name but not tag_member.
+        # Simple unions and alternates pass tag_member but not tag_name.
+        # After check(), tag_member is always set, and tag_name remains
+        # a reliable witness of being used by a flat union.
+        assert bool(tag_member) !=3D bool(tag_name)
+        assert (isinstance(tag_name, str) or
+                isinstance(tag_member, QAPISchemaObjectTypeMember))
+        for v in variants:
+            assert isinstance(v, QAPISchemaObjectTypeVariant)
+        self._tag_name =3D tag_name
+        self.info =3D info
+        self.tag_member =3D tag_member
+        self.variants =3D variants
+
+    def set_defined_in(self, name):
+        for v in self.variants:
+            v.set_defined_in(name)
+
+    def check(self, schema, seen):
+        if not self.tag_member: # flat union
+            self.tag_member =3D seen.get(c_name(self._tag_name))
+            base =3D "'base'"
+            # Pointing to the base type when not implicit would be
+            # nice, but we don't know it here
+            if not self.tag_member or self._tag_name !=3D self.tag_membe=
r.name:
+                raise QAPISemError(
+                    self.info,
+                    "discriminator '%s' is not a member of %s"
+                    % (self._tag_name, base))
+            # Here we do:
+            base_type =3D schema.lookup_type(self.tag_member.defined_in)
+            assert base_type
+            if not base_type.is_implicit():
+                base =3D "base type '%s'" % self.tag_member.defined_in
+            if not isinstance(self.tag_member.type, QAPISchemaEnumType):
+                raise QAPISemError(
+                    self.info,
+                    "discriminator member '%s' of %s must be of enum typ=
e"
+                    % (self._tag_name, base))
+            if self.tag_member.optional:
+                raise QAPISemError(
+                    self.info,
+                    "discriminator member '%s' of %s must not be optiona=
l"
+                    % (self._tag_name, base))
+            if self.tag_member.ifcond:
+                raise QAPISemError(
+                    self.info,
+                    "discriminator member '%s' of %s must not be conditi=
onal"
+                    % (self._tag_name, base))
+        else:                   # simple union
+            assert isinstance(self.tag_member.type, QAPISchemaEnumType)
+            assert not self.tag_member.optional
+            assert self.tag_member.ifcond =3D=3D []
+        if self._tag_name:    # flat union
+            # branches that are not explicitly covered get an empty type
+            cases =3D set([v.name for v in self.variants])
+            for m in self.tag_member.type.members:
+                if m.name not in cases:
+                    v =3D QAPISchemaObjectTypeVariant(m.name, self.info,
+                                                    'q_empty', m.ifcond)
+                    v.set_defined_in(self.tag_member.defined_in)
+                    self.variants.append(v)
+        if not self.variants:
+            raise QAPISemError(self.info, "union has no branches")
+        for v in self.variants:
+            v.check(schema)
+            # Union names must match enum values; alternate names are
+            # checked separately. Use 'seen' to tell the two apart.
+            if seen:
+                if v.name not in self.tag_member.type.member_names():
+                    raise QAPISemError(
+                        self.info,
+                        "branch '%s' is not a value of %s"
+                        % (v.name, self.tag_member.type.describe()))
+                if (not isinstance(v.type, QAPISchemaObjectType)
+                        or v.type.variants):
+                    raise QAPISemError(
+                        self.info,
+                        "%s cannot use %s"
+                        % (v.describe(self.info), v.type.describe()))
+                v.type.check(schema)
+
+    def check_clash(self, info, seen):
+        for v in self.variants:
+            # Reset seen map for each variant, since qapi names from one
+            # branch do not affect another branch
+            v.type.check_clash(info, dict(seen))
+
+
+class QAPISchemaObjectTypeVariant(QAPISchemaObjectTypeMember):
+    role =3D 'branch'
+
+    def __init__(self, name, info, typ, ifcond=3DNone):
+        QAPISchemaObjectTypeMember.__init__(self, name, info, typ,
+                                            False, ifcond)
+
+
+class QAPISchemaAlternateType(QAPISchemaType):
+    meta =3D 'alternate'
+
+    def __init__(self, name, info, doc, ifcond, variants):
+        QAPISchemaType.__init__(self, name, info, doc, ifcond)
+        assert isinstance(variants, QAPISchemaObjectTypeVariants)
+        assert variants.tag_member
+        variants.set_defined_in(name)
+        variants.tag_member.set_defined_in(self.name)
+        self.variants =3D variants
+
+    def check(self, schema):
+        QAPISchemaType.check(self, schema)
+        self.variants.tag_member.check(schema)
+        # Not calling self.variants.check_clash(), because there's nothi=
ng
+        # to clash with
+        self.variants.check(schema, {})
+        # Alternate branch names have no relation to the tag enum values=
;
+        # so we have to check for potential name collisions ourselves.
+        seen =3D {}
+        types_seen =3D {}
+        for v in self.variants.variants:
+            v.check_clash(self.info, seen)
+            qtype =3D v.type.alternate_qtype()
+            if not qtype:
+                raise QAPISemError(
+                    self.info,
+                    "%s cannot use %s"
+                    % (v.describe(self.info), v.type.describe()))
+            conflicting =3D set([qtype])
+            if qtype =3D=3D 'QTYPE_QSTRING':
+                if isinstance(v.type, QAPISchemaEnumType):
+                    for m in v.type.members:
+                        if m.name in ['on', 'off']:
+                            conflicting.add('QTYPE_QBOOL')
+                        if re.match(r'[-+0-9.]', m.name):
+                            # lazy, could be tightened
+                            conflicting.add('QTYPE_QNUM')
+                else:
+                    conflicting.add('QTYPE_QNUM')
+                    conflicting.add('QTYPE_QBOOL')
+            for qt in conflicting:
+                if qt in types_seen:
+                    raise QAPISemError(
+                        self.info,
+                        "%s can't be distinguished from '%s'"
+                        % (v.describe(self.info), types_seen[qt]))
+                types_seen[qt] =3D v.name
+            if self.doc:
+                self.doc.connect_member(v)
+        if self.doc:
+            self.doc.check()
+
+    def c_type(self):
+        return c_name(self.name) + pointer_suffix
+
+    def json_type(self):
+        return 'value'
+
+    def visit(self, visitor):
+        QAPISchemaType.visit(self, visitor)
+        visitor.visit_alternate_type(self.name, self.info, self.ifcond,
+                                     self.variants)
+
+
+class QAPISchemaCommand(QAPISchemaEntity):
+    meta =3D 'command'
+
+    def __init__(self, name, info, doc, ifcond, arg_type, ret_type,
+                 gen, success_response, boxed, allow_oob, allow_preconfi=
g):
+        QAPISchemaEntity.__init__(self, name, info, doc, ifcond)
+        assert not arg_type or isinstance(arg_type, str)
+        assert not ret_type or isinstance(ret_type, str)
+        self._arg_type_name =3D arg_type
+        self.arg_type =3D None
+        self._ret_type_name =3D ret_type
+        self.ret_type =3D None
+        self.gen =3D gen
+        self.success_response =3D success_response
+        self.boxed =3D boxed
+        self.allow_oob =3D allow_oob
+        self.allow_preconfig =3D allow_preconfig
+
+    def check(self, schema):
+        QAPISchemaEntity.check(self, schema)
+        if self._arg_type_name:
+            self.arg_type =3D schema.resolve_type(
+                self._arg_type_name, self.info, "command's 'data'")
+            if not isinstance(self.arg_type, QAPISchemaObjectType):
+                raise QAPISemError(
+                    self.info,
+                    "command's 'data' cannot take %s"
+                    % self.arg_type.describe())
+            if self.arg_type.variants and not self.boxed:
+                raise QAPISemError(
+                    self.info,
+                    "command's 'data' can take %s only with 'boxed': tru=
e"
+                    % self.arg_type.describe())
+        if self._ret_type_name:
+            self.ret_type =3D schema.resolve_type(
+                self._ret_type_name, self.info, "command's 'returns'")
+            if self.name not in self.info.pragma.returns_whitelist:
+                if not (isinstance(self.ret_type, QAPISchemaObjectType)
+                        or (isinstance(self.ret_type, QAPISchemaArrayTyp=
e)
+                            and isinstance(self.ret_type.element_type,
+                                           QAPISchemaObjectType))):
+                    raise QAPISemError(
+                        self.info,
+                        "command's 'returns' cannot take %s"
+                        % self.ret_type.describe())
+
+    def visit(self, visitor):
+        QAPISchemaEntity.visit(self, visitor)
+        visitor.visit_command(self.name, self.info, self.ifcond,
+                              self.arg_type, self.ret_type,
+                              self.gen, self.success_response,
+                              self.boxed, self.allow_oob,
+                              self.allow_preconfig)
+
+
+class QAPISchemaEvent(QAPISchemaEntity):
+    meta =3D 'event'
+
+    def __init__(self, name, info, doc, ifcond, arg_type, boxed):
+        QAPISchemaEntity.__init__(self, name, info, doc, ifcond)
+        assert not arg_type or isinstance(arg_type, str)
+        self._arg_type_name =3D arg_type
+        self.arg_type =3D None
+        self.boxed =3D boxed
+
+    def check(self, schema):
+        QAPISchemaEntity.check(self, schema)
+        if self._arg_type_name:
+            self.arg_type =3D schema.resolve_type(
+                self._arg_type_name, self.info, "event's 'data'")
+            if not isinstance(self.arg_type, QAPISchemaObjectType):
+                raise QAPISemError(
+                    self.info,
+                    "event's 'data' cannot take %s"
+                    % self.arg_type.describe())
+            if self.arg_type.variants and not self.boxed:
+                raise QAPISemError(
+                    self.info,
+                    "event's 'data' can take %s only with 'boxed': true"
+                    % self.arg_type.describe())
+
+    def visit(self, visitor):
+        QAPISchemaEntity.visit(self, visitor)
+        visitor.visit_event(self.name, self.info, self.ifcond,
+                            self.arg_type, self.boxed)
+
+
+class QAPISchema(object):
+    def __init__(self, fname):
+        self.fname =3D fname
+        parser =3D QAPISchemaParser(fname)
+        exprs =3D check_exprs(parser.exprs)
+        self.docs =3D parser.docs
+        self._entity_list =3D []
+        self._entity_dict =3D {}
+        self._predefining =3D True
+        self._def_predefineds()
+        self._predefining =3D False
+        self._def_exprs(exprs)
+        self.check()
+
+    def _def_entity(self, ent):
+        # Only the predefined types are allowed to not have info
+        assert ent.info or self._predefining
+        self._entity_list.append(ent)
+        if ent.name is None:
+            return
+        # TODO reject names that differ only in '_' vs. '.'  vs. '-',
+        # because they're liable to clash in generated C.
+        other_ent =3D self._entity_dict.get(ent.name)
+        if other_ent:
+            if other_ent.info:
+                where =3D QAPIError(other_ent.info, None, "previous defi=
nition")
+                raise QAPISemError(
+                    ent.info,
+                    "'%s' is already defined\n%s" % (ent.name, where))
+            raise QAPISemError(
+                ent.info, "%s is already defined" % other_ent.describe()=
)
+        self._entity_dict[ent.name] =3D ent
+
+    def lookup_entity(self, name, typ=3DNone):
+        ent =3D self._entity_dict.get(name)
+        if typ and not isinstance(ent, typ):
+            return None
+        return ent
+
+    def lookup_type(self, name):
+        return self.lookup_entity(name, QAPISchemaType)
+
+    def resolve_type(self, name, info, what):
+        typ =3D self.lookup_type(name)
+        if not typ:
+            if callable(what):
+                what =3D what(info)
+            raise QAPISemError(
+                info, "%s uses unknown type '%s'" % (what, name))
+        return typ
+
+    def _def_include(self, expr, info, doc):
+        include =3D expr['include']
+        assert doc is None
+        main_info =3D info
+        while main_info.parent:
+            main_info =3D main_info.parent
+        fname =3D os.path.relpath(include, os.path.dirname(main_info.fna=
me))
+        self._def_entity(QAPISchemaInclude(fname, info))
+
+    def _def_builtin_type(self, name, json_type, c_type):
+        self._def_entity(QAPISchemaBuiltinType(name, json_type, c_type))
+        # Instantiating only the arrays that are actually used would
+        # be nice, but we can't as long as their generated code
+        # (qapi-builtin-types.[ch]) may be shared by some other
+        # schema.
+        self._make_array_type(name, None)
+
+    def _def_predefineds(self):
+        for t in [('str',    'string',  'char' + pointer_suffix),
+                  ('number', 'number',  'double'),
+                  ('int',    'int',     'int64_t'),
+                  ('int8',   'int',     'int8_t'),
+                  ('int16',  'int',     'int16_t'),
+                  ('int32',  'int',     'int32_t'),
+                  ('int64',  'int',     'int64_t'),
+                  ('uint8',  'int',     'uint8_t'),
+                  ('uint16', 'int',     'uint16_t'),
+                  ('uint32', 'int',     'uint32_t'),
+                  ('uint64', 'int',     'uint64_t'),
+                  ('size',   'int',     'uint64_t'),
+                  ('bool',   'boolean', 'bool'),
+                  ('any',    'value',   'QObject' + pointer_suffix),
+                  ('null',   'null',    'QNull' + pointer_suffix)]:
+            self._def_builtin_type(*t)
+        self.the_empty_object_type =3D QAPISchemaObjectType(
+            'q_empty', None, None, None, None, [], None, [])
+        self._def_entity(self.the_empty_object_type)
+
+        qtypes =3D ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist'=
,
+                  'qbool']
+        qtype_values =3D self._make_enum_members(
+            [{'name': n} for n in qtypes], None)
+
+        self._def_entity(QAPISchemaEnumType('QType', None, None, None,
+                                            qtype_values, 'QTYPE'))
+
+    def _make_features(self, features, info):
+        return [QAPISchemaFeature(f['name'], info, f.get('if'))
+                for f in features]
+
+    def _make_enum_members(self, values, info):
+        return [QAPISchemaEnumMember(v['name'], info, v.get('if'))
+                for v in values]
+
+    def _make_implicit_enum_type(self, name, info, ifcond, values):
+        # See also QAPISchemaObjectTypeMember.describe()
+        name =3D name + 'Kind'    # reserved by check_defn_name_str()
+        self._def_entity(QAPISchemaEnumType(
+            name, info, None, ifcond, self._make_enum_members(values, in=
fo),
+            None))
+        return name
+
+    def _make_array_type(self, element_type, info):
+        name =3D element_type + 'List'    # reserved by check_defn_name_=
str()
+        if not self.lookup_type(name):
+            self._def_entity(QAPISchemaArrayType(name, info, element_typ=
e))
+        return name
+
+    def _make_implicit_object_type(self, name, info, doc, ifcond,
+                                   role, members):
+        if not members:
+            return None
+        # See also QAPISchemaObjectTypeMember.describe()
+        name =3D 'q_obj_%s-%s' % (name, role)
+        typ =3D self.lookup_entity(name, QAPISchemaObjectType)
+        if typ:
+            # The implicit object type has multiple users.  This can
+            # happen only for simple unions' implicit wrapper types.
+            # Its ifcond should be the disjunction of its user's
+            # ifconds.  Not implemented.  Instead, we always pass the
+            # wrapped type's ifcond, which is trivially the same for all
+            # users.  It's also necessary for the wrapper to compile.
+            # But it's not tight: the disjunction need not imply it.  We
+            # may end up compiling useless wrapper types.
+            # TODO kill simple unions or implement the disjunction
+            assert (ifcond or []) =3D=3D typ._ifcond # pylint: disable=3D=
protected-access
+        else:
+            self._def_entity(QAPISchemaObjectType(name, info, doc, ifcon=
d,
+                                                  None, members, None, [=
]))
+        return name
+
+    def _def_enum_type(self, expr, info, doc):
+        name =3D expr['enum']
+        data =3D expr['data']
+        prefix =3D expr.get('prefix')
+        ifcond =3D expr.get('if')
+        self._def_entity(QAPISchemaEnumType(
+            name, info, doc, ifcond,
+            self._make_enum_members(data, info), prefix))
+
+    def _make_member(self, name, typ, ifcond, info):
+        optional =3D False
+        if name.startswith('*'):
+            name =3D name[1:]
+            optional =3D True
+        if isinstance(typ, list):
+            assert len(typ) =3D=3D 1
+            typ =3D self._make_array_type(typ[0], info)
+        return QAPISchemaObjectTypeMember(name, info, typ, optional, ifc=
ond)
+
+    def _make_members(self, data, info):
+        return [self._make_member(key, value['type'], value.get('if'), i=
nfo)
+                for (key, value) in data.items()]
+
+    def _def_struct_type(self, expr, info, doc):
+        name =3D expr['struct']
+        base =3D expr.get('base')
+        data =3D expr['data']
+        ifcond =3D expr.get('if')
+        features =3D expr.get('features', [])
+        self._def_entity(QAPISchemaObjectType(
+            name, info, doc, ifcond, base,
+            self._make_members(data, info),
+            None,
+            self._make_features(features, info)))
+
+    def _make_variant(self, case, typ, ifcond, info):
+        return QAPISchemaObjectTypeVariant(case, info, typ, ifcond)
+
+    def _make_simple_variant(self, case, typ, ifcond, info):
+        if isinstance(typ, list):
+            assert len(typ) =3D=3D 1
+            typ =3D self._make_array_type(typ[0], info)
+        typ =3D self._make_implicit_object_type(
+            typ, info, None, self.lookup_type(typ),
+            'wrapper', [self._make_member('data', typ, None, info)])
+        return QAPISchemaObjectTypeVariant(case, info, typ, ifcond)
+
+    def _def_union_type(self, expr, info, doc):
+        name =3D expr['union']
+        data =3D expr['data']
+        base =3D expr.get('base')
+        ifcond =3D expr.get('if')
+        tag_name =3D expr.get('discriminator')
+        tag_member =3D None
+        if isinstance(base, dict):
+            base =3D self._make_implicit_object_type(
+                name, info, doc, ifcond,
+                'base', self._make_members(base, info))
+        if tag_name:
+            variants =3D [self._make_variant(key, value['type'],
+                                           value.get('if'), info)
+                        for (key, value) in data.items()]
+            members =3D []
+        else:
+            variants =3D [self._make_simple_variant(key, value['type'],
+                                                  value.get('if'), info)
+                        for (key, value) in data.items()]
+            enum =3D [{'name': v.name, 'if': v.ifcond} for v in variants=
]
+            typ =3D self._make_implicit_enum_type(name, info, ifcond, en=
um)
+            tag_member =3D QAPISchemaObjectTypeMember('type', info, typ,=
 False)
+            members =3D [tag_member]
+        self._def_entity(
+            QAPISchemaObjectType(name, info, doc, ifcond, base, members,
+                                 QAPISchemaObjectTypeVariants(
+                                     tag_name, info, tag_member, variant=
s),
+                                 []))
+
+    def _def_alternate_type(self, expr, info, doc):
+        name =3D expr['alternate']
+        data =3D expr['data']
+        ifcond =3D expr.get('if')
+        variants =3D [self._make_variant(key, value['type'], value.get('=
if'),
+                                       info)
+                    for (key, value) in data.items()]
+        tag_member =3D QAPISchemaObjectTypeMember('type', info, 'QType',=
 False)
+        self._def_entity(
+            QAPISchemaAlternateType(name, info, doc, ifcond,
+                                    QAPISchemaObjectTypeVariants(
+                                        None, info, tag_member, variants=
)))
+
+    def _def_command(self, expr, info, doc):
+        name =3D expr['command']
+        data =3D expr.get('data')
+        rets =3D expr.get('returns')
+        gen =3D expr.get('gen', True)
+        success_response =3D expr.get('success-response', True)
+        boxed =3D expr.get('boxed', False)
+        allow_oob =3D expr.get('allow-oob', False)
+        allow_preconfig =3D expr.get('allow-preconfig', False)
+        ifcond =3D expr.get('if')
+        if isinstance(data, OrderedDict):
+            data =3D self._make_implicit_object_type(
+                name, info, doc, ifcond, 'arg', self._make_members(data,=
 info))
+        if isinstance(rets, list):
+            assert len(rets) =3D=3D 1
+            rets =3D self._make_array_type(rets[0], info)
+        self._def_entity(QAPISchemaCommand(name, info, doc, ifcond, data=
, rets,
+                                           gen, success_response,
+                                           boxed, allow_oob, allow_preco=
nfig))
+
+    def _def_event(self, expr, info, doc):
+        name =3D expr['event']
+        data =3D expr.get('data')
+        boxed =3D expr.get('boxed', False)
+        ifcond =3D expr.get('if')
+        if isinstance(data, OrderedDict):
+            data =3D self._make_implicit_object_type(
+                name, info, doc, ifcond, 'arg', self._make_members(data,=
 info))
+        self._def_entity(QAPISchemaEvent(name, info, doc, ifcond, data, =
boxed))
+
+    def _def_exprs(self, exprs):
+        for expr_elem in exprs:
+            expr =3D expr_elem['expr']
+            info =3D expr_elem['info']
+            doc =3D expr_elem.get('doc')
+            if 'enum' in expr:
+                self._def_enum_type(expr, info, doc)
+            elif 'struct' in expr:
+                self._def_struct_type(expr, info, doc)
+            elif 'union' in expr:
+                self._def_union_type(expr, info, doc)
+            elif 'alternate' in expr:
+                self._def_alternate_type(expr, info, doc)
+            elif 'command' in expr:
+                self._def_command(expr, info, doc)
+            elif 'event' in expr:
+                self._def_event(expr, info, doc)
+            elif 'include' in expr:
+                self._def_include(expr, info, doc)
+            else:
+                assert False
+
+    def check(self):
+        for ent in self._entity_list:
+            ent.check(self)
+
+    def visit(self, visitor):
+        visitor.visit_begin(self)
+        module =3D None
+        visitor.visit_module(module)
+        for entity in self._entity_list:
+            if visitor.visit_needed(entity):
+                if entity.module !=3D module:
+                    module =3D entity.module
+                    visitor.visit_module(module)
+                entity.visit(visitor)
+        visitor.visit_end()
diff --git a/scripts/qapi/source.py b/scripts/qapi/source.py
new file mode 100644
index 0000000000..8956885033
--- /dev/null
+++ b/scripts/qapi/source.py
@@ -0,0 +1,67 @@
+#
+# QAPI frontend source file info
+#
+# Copyright (c) 2019 Red Hat Inc.
+#
+# Authors:
+#  Markus Armbruster <armbru@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2.
+# See the COPYING file in the top-level directory.
+
+import copy
+import sys
+
+
+class QAPISchemaPragma(object):
+    def __init__(self):
+        # Are documentation comments required?
+        self.doc_required =3D False
+        # Whitelist of commands allowed to return a non-dictionary
+        self.returns_whitelist =3D []
+        # Whitelist of entities allowed to violate case conventions
+        self.name_case_whitelist =3D []
+
+
+class QAPISourceInfo(object):
+    def __init__(self, fname, line, parent):
+        self.fname =3D fname
+        self.line =3D line
+        self.parent =3D parent
+        self.pragma =3D parent.pragma if parent else QAPISchemaPragma()
+        self.defn_meta =3D None
+        self.defn_name =3D None
+
+    def set_defn(self, meta, name):
+        self.defn_meta =3D meta
+        self.defn_name =3D name
+
+    def next_line(self):
+        info =3D copy.copy(self)
+        info.line +=3D 1
+        return info
+
+    def loc(self):
+        if self.fname is None:
+            return sys.argv[0]
+        ret =3D self.fname
+        if self.line is not None:
+            ret +=3D ':%d' % self.line
+        return ret
+
+    def in_defn(self):
+        if self.defn_name:
+            return "%s: In %s '%s':\n" % (self.fname,
+                                          self.defn_meta, self.defn_name=
)
+        return ''
+
+    def include_path(self):
+        ret =3D ''
+        parent =3D self.parent
+        while parent:
+            ret =3D 'In file included from %s:\n' % parent.loc() + ret
+            parent =3D parent.parent
+        return ret
+
+    def __str__(self):
+        return self.include_path() + self.in_defn() + self.loc()
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index 711543147d..d8751daa04 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -14,6 +14,8 @@ This work is licensed under the terms of the GNU GPL, v=
ersion 2.
 """
=20
 from qapi.common import *
+from qapi.gen import QAPISchemaModularCVisitor, ifcontext
+from qapi.schema import QAPISchemaEnumMember, QAPISchemaObjectType
=20
=20
 # variants must be emitted before their container; track what has alread=
y
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 484ebb66ad..c72f2bc5c0 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -14,6 +14,8 @@ See the COPYING file in the top-level directory.
 """
=20
 from qapi.common import *
+from qapi.gen import QAPISchemaModularCVisitor, ifcontext
+from qapi.schema import QAPISchemaObjectType
=20
=20
 def gen_visit_decl(name, scalar=3DFalse):
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 1b24b8ba10..09e5b410dc 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -31,13 +31,20 @@ ifneq ($(wildcard config-host.mak),)
 export SRC_PATH
=20
 # TODO don't duplicate $(SRC_PATH)/Makefile's qapi-py here
-qapi-py =3D $(SRC_PATH)/scripts/qapi/commands.py \
+qapi-py =3D $(SRC_PATH)/scripts/qapi/__init__.py \
+$(SRC_PATH)/scripts/qapi/commands.py \
+$(SRC_PATH)/scripts/qapi/common.py \
+$(SRC_PATH)/scripts/qapi/doc.py \
+$(SRC_PATH)/scripts/qapi/error.py \
 $(SRC_PATH)/scripts/qapi/events.py \
+$(SRC_PATH)/scripts/qapi/expr.py \
+$(SRC_PATH)/scripts/qapi/gen.py \
 $(SRC_PATH)/scripts/qapi/introspect.py \
+$(SRC_PATH)/scripts/qapi/parser.py \
+$(SRC_PATH)/scripts/qapi/schema.py \
+$(SRC_PATH)/scripts/qapi/source.py \
 $(SRC_PATH)/scripts/qapi/types.py \
 $(SRC_PATH)/scripts/qapi/visit.py \
-$(SRC_PATH)/scripts/qapi/common.py \
-$(SRC_PATH)/scripts/qapi/doc.py \
 $(SRC_PATH)/scripts/qapi-gen.py
=20
 # Get the list of all supported sysemu targets
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
index 42baa702b6..664254618a 100755
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -12,15 +12,19 @@
 #
=20
 from __future__ import print_function
+
 import argparse
 import difflib
 import os
 import sys
+
+from qapi.error import QAPIError
+from qapi.schema import QAPISchema, QAPISchemaVisitor
+
 if sys.version_info[0] < 3:
     from cStringIO import StringIO
 else:
     from io import StringIO
-from qapi.common import QAPIError, QAPISchema, QAPISchemaVisitor
=20
=20
 class QAPISchemaTestVisitor(QAPISchemaVisitor):
--=20
2.21.0



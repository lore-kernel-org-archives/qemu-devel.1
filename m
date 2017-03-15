Received: from eggs.gnu.org ([2001:4830:134:3::10]:33556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8Uv-0001Yd-HX
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8Uq-0000KA-8V
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1co8Up-0000I6-Pv
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:44 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 15 Mar 2017 13:57:08 +0100
Message-Id: <1489582656-31133-20-git-send-email-armbru@redhat.com>
In-Reply-To: <1489582656-31133-1-git-send-email-armbru@redhat.com>
References: <1489582656-31133-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.9 19/47] qapi: Prefer single-quoted
 strings more consistently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

PEP 8 advises:

    In Python, single-quoted strings and double-quoted strings are the
    same.  This PEP does not make a recommendation for this.  Pick a
    rule and stick to it.  When a string contains single or double
    quote characters, however, use the other one to avoid backslashes
    in the string.  It improves readability.

The QAPI generators succeed at picking a rule, but fail at sticking to
it.  Convert a bunch of double-quoted strings to single-quoted ones.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi-event.py      |  2 +-
 scripts/qapi-introspect.py |  4 +-
 scripts/qapi-types.py      |  4 +-
 scripts/qapi-visit.py      |  4 +-
 scripts/qapi.py            | 96 +++++++++++++++++++++++-----------------------
 scripts/qapi2texi.py       | 46 +++++++++++-----------
 6 files changed, 78 insertions(+), 78 deletions(-)

diff --git a/scripts/qapi-event.py b/scripts/qapi-event.py
index f4eb7f8..0485e39 100644
--- a/scripts/qapi-event.py
+++ b/scripts/qapi-event.py
@@ -223,7 +223,7 @@ fdecl.write(mcgen('''
 ''',
                   prefix=prefix))
 
-event_enum_name = c_name(prefix + "QAPIEvent", protect=False)
+event_enum_name = c_name(prefix + 'QAPIEvent', protect=False)
 
 schema = QAPISchema(input_file)
 gen = QAPISchemaGenEventVisitor()
diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
index fb72c61..032bcea 100644
--- a/scripts/qapi-introspect.py
+++ b/scripts/qapi-introspect.py
@@ -170,10 +170,10 @@ const char %(c_name)s[] = %(c_string)s;
 opt_unmask = False
 
 (input_file, output_dir, do_c, do_h, prefix, opts) = \
-    parse_command_line("u", ["unmask-non-abi-names"])
+    parse_command_line('u', ['unmask-non-abi-names'])
 
 for o, a in opts:
-    if o in ("-u", "--unmask-non-abi-names"):
+    if o in ('-u', '--unmask-non-abi-names'):
         opt_unmask = True
 
 c_comment = '''
diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
index dabc42e..b45e7b5 100644
--- a/scripts/qapi-types.py
+++ b/scripts/qapi-types.py
@@ -244,10 +244,10 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
 do_builtins = False
 
 (input_file, output_dir, do_c, do_h, prefix, opts) = \
-    parse_command_line("b", ["builtins"])
+    parse_command_line('b', ['builtins'])
 
 for o, a in opts:
-    if o in ("-b", "--builtins"):
+    if o in ('-b', '--builtins'):
         do_builtins = True
 
 c_comment = '''
diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
index 330b9f3..3d3936e 100644
--- a/scripts/qapi-visit.py
+++ b/scripts/qapi-visit.py
@@ -335,10 +335,10 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
 do_builtins = False
 
 (input_file, output_dir, do_c, do_h, prefix, opts) = \
-    parse_command_line("b", ["builtins"])
+    parse_command_line('b', ['builtins'])
 
 for o, a in opts:
-    if o in ("-b", "--builtins"):
+    if o in ('-b', '--builtins'):
         do_builtins = True
 
 c_comment = '''
diff --git a/scripts/qapi.py b/scripts/qapi.py
index 8088f60..8b7377e 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -58,9 +58,9 @@ all_names = {}
 
 
 def error_path(parent):
-    res = ""
+    res = ''
     while parent:
-        res = ("In file included from %s:%d:\n" % (parent['file'],
+        res = ('In file included from %s:%d:\n' % (parent['file'],
                                                    parent['line'])) + res
         parent = parent['parent']
     return res
@@ -76,10 +76,10 @@ class QAPIError(Exception):
         self.msg = msg
 
     def __str__(self):
-        loc = "%s:%d" % (self.fname, self.line)
+        loc = '%s:%d' % (self.fname, self.line)
         if self.col is not None:
-            loc += ":%s" % self.col
-        return error_path(self.info) + "%s: %s" % (loc, self.msg)
+            loc += ':%s' % self.col
+        return error_path(self.info) + '%s: %s' % (loc, self.msg)
 
 
 class QAPIParseError(QAPIError):
@@ -113,7 +113,7 @@ class QAPIDoc(object):
             self.content.append(line)
 
         def __repr__(self):
-            return "\n".join(self.content).strip()
+            return '\n'.join(self.content).strip()
 
     class ArgSection(Section):
         def __init__(self, name):
@@ -163,8 +163,8 @@ class QAPIDoc(object):
         # recognized, and get silently treated as ordinary text
         if self.symbol:
             self._append_symbol_line(line)
-        elif not self.body.content and line.startswith("@"):
-            if not line.endswith(":"):
+        elif not self.body.content and line.startswith('@'):
+            if not line.endswith(':'):
                 raise QAPIParseError(self.parser, "Line should end with :")
             self.symbol = line[1:-1]
             # FIXME invalid names other than the empty string aren't flagged
@@ -176,14 +176,14 @@ class QAPIDoc(object):
     def _append_symbol_line(self, line):
         name = line.split(' ', 1)[0]
 
-        if name.startswith("@") and name.endswith(":"):
+        if name.startswith('@') and name.endswith(':'):
             line = line[len(name)+1:]
             self._start_args_section(name[1:-1])
-        elif name in ("Returns:", "Since:",
+        elif name in ('Returns:', 'Since:',
                       # those are often singular or plural
-                      "Note:", "Notes:",
-                      "Example:", "Examples:",
-                      "TODO:"):
+                      'Note:', 'Notes:',
+                      'Example:', 'Examples:',
+                      'TODO:'):
             line = line[len(name)+1:]
             self._start_section(name[:-1])
 
@@ -203,8 +203,8 @@ class QAPIDoc(object):
         self.section = QAPIDoc.ArgSection(name)
         self.args[name] = self.section
 
-    def _start_section(self, name=""):
-        if name in ("Returns", "Since") and self.has_section(name):
+    def _start_section(self, name=''):
+        if name in ('Returns', 'Since') and self.has_section(name):
             raise QAPIParseError(self.parser,
                                  "Duplicated '%s' section" % name)
         self.section = QAPIDoc.Section(name)
@@ -217,7 +217,7 @@ class QAPIDoc(object):
                 and line and not line[0].isspace()):
             self._start_section()
         if (in_arg or not self.section.name
-                or not self.section.name.startswith("Example")):
+                or not self.section.name.startswith('Example')):
             line = line.strip()
         # TODO Drop this once the dust has settled
         if (isinstance(self.section, QAPIDoc.ArgSection)
@@ -262,7 +262,7 @@ class QAPISchemaParser(object):
             if 'include' in expr:
                 if len(expr) != 1:
                     raise QAPISemError(info, "Invalid 'include' directive")
-                include = expr["include"]
+                include = expr['include']
                 if not isinstance(include, str):
                     raise QAPISemError(info,
                                        "Value of 'include' must be a string")
@@ -347,7 +347,7 @@ class QAPISchemaParser(object):
                 if not skip_comment:
                     self.val = self.src[self.pos:self.cursor]
                     return
-            elif self.tok in "{}:,[]":
+            elif self.tok in '{}:,[]':
                 return
             elif self.tok == "'":
                 string = ''
@@ -373,7 +373,7 @@ class QAPISchemaParser(object):
                             for _ in range(0, 4):
                                 ch = self.src[self.cursor]
                                 self.cursor += 1
-                                if ch not in "0123456789abcdefABCDEF":
+                                if ch not in '0123456789abcdefABCDEF':
                                     raise QAPIParseError(self,
                                                          '\\u escape needs 4 '
                                                          'hex digits')
@@ -388,28 +388,28 @@ class QAPISchemaParser(object):
                                                      'only supports non-zero '
                                                      'values up to \\u007f')
                             string += chr(value)
-                        elif ch in "\\/'\"":
+                        elif ch in '\\/\'"':
                             string += ch
                         else:
                             raise QAPIParseError(self,
                                                  "Unknown escape \\%s" % ch)
                         esc = False
-                    elif ch == "\\":
+                    elif ch == '\\':
                         esc = True
                     elif ch == "'":
                         self.val = string
                         return
                     else:
                         string += ch
-            elif self.src.startswith("true", self.pos):
+            elif self.src.startswith('true', self.pos):
                 self.val = True
                 self.cursor += 3
                 return
-            elif self.src.startswith("false", self.pos):
+            elif self.src.startswith('false', self.pos):
                 self.val = False
                 self.cursor += 4
                 return
-            elif self.src.startswith("null", self.pos):
+            elif self.src.startswith('null', self.pos):
                 self.val = None
                 self.cursor += 3
                 return
@@ -523,11 +523,11 @@ def find_alternate_member_qtype(qapi_type):
     if qapi_type in builtin_types:
         return builtin_types[qapi_type]
     elif find_struct(qapi_type):
-        return "QTYPE_QDICT"
+        return 'QTYPE_QDICT'
     elif find_enum(qapi_type):
-        return "QTYPE_QSTRING"
+        return 'QTYPE_QSTRING'
     elif find_union(qapi_type):
-        return "QTYPE_QDICT"
+        return 'QTYPE_QDICT'
     return None
 
 
@@ -628,7 +628,7 @@ def find_union(name):
 def add_enum(name, info, enum_values=None, implicit=False):
     global enum_types
     add_name(name, info, 'enum', implicit)
-    enum_types.append({"enum_name": name, "enum_values": enum_values})
+    enum_types.append({'enum_name': name, 'enum_values': enum_values})
 
 
 def find_enum(name):
@@ -788,7 +788,7 @@ def check_union(expr, info):
                 raise QAPISemError(info,
                                    "Discriminator value '%s' is not found in "
                                    "enum '%s'"
-                                   % (key, enum_define["enum_name"]))
+                                   % (key, enum_define['enum_name']))
 
     # If discriminator is user-defined, ensure all values are covered
     if enum_define:
@@ -993,7 +993,7 @@ def check_definition_doc(doc, expr, info):
     args = set([name.strip('*') for name in args])
     if not doc_args.issubset(args):
         raise QAPISemError(info, "The following documented members are not in "
-                           "the declaration: %s" % ", ".join(doc_args - args))
+                           "the declaration: %s" % ', '.join(doc_args - args))
 
 
 def check_docs(docs):
@@ -1487,7 +1487,7 @@ class QAPISchemaEvent(QAPISchemaEntity):
 class QAPISchema(object):
     def __init__(self, fname):
         try:
-            parser = QAPISchemaParser(open(fname, "r"))
+            parser = QAPISchemaParser(open(fname, 'r'))
             self.exprs = check_exprs(parser.exprs)
             self.docs = check_docs(parser.docs)
             self._entity_dict = {}
@@ -1740,8 +1740,8 @@ def camel_to_upper(value):
     l = len(c_fun_str)
     for i in range(l):
         c = c_fun_str[i]
-        # When c is upper and no "_" appears before, do more checks
-        if c.isupper() and (i > 0) and c_fun_str[i - 1] != "_":
+        # When c is upper and no '_' appears before, do more checks
+        if c.isupper() and (i > 0) and c_fun_str[i - 1] != '_':
             if i < l - 1 and c_fun_str[i + 1].islower():
                 new_name += '_'
             elif c_fun_str[i - 1].isdigit():
@@ -1760,7 +1760,7 @@ c_name_trans = string.maketrans('.-', '__')
 
 # Map @name to a valid C identifier.
 # If @protect, avoid returning certain ticklish identifiers (like
-# C keywords) by prepending "q_".
+# C keywords) by prepending 'q_'.
 #
 # Used for converting 'name' from a 'name':'type' qapi definition
 # into a generated struct member, as well as converting type names
@@ -1798,7 +1798,7 @@ def c_name(name, protect=True):
     name = name.translate(c_name_trans)
     if protect and (name in c89_words | c99_words | c11_words | gcc_words
                     | cpp_words | polluted_words):
-        return "q_" + name
+        return 'q_' + name
     return name
 
 eatspace = '\033EATSPACE.'
@@ -1806,9 +1806,9 @@ pointer_suffix = ' *' + eatspace
 
 
 def genindent(count):
-    ret = ""
+    ret = ''
     for _ in range(count):
-        ret += " "
+        ret += ' '
     return ret
 
 indent_level = 0
@@ -1948,26 +1948,26 @@ def gen_params(arg_type, boxed, extra):
 #
 
 
-def parse_command_line(extra_options="", extra_long_options=[]):
+def parse_command_line(extra_options='', extra_long_options=[]):
 
     try:
         opts, args = getopt.gnu_getopt(sys.argv[1:],
-                                       "chp:o:" + extra_options,
-                                       ["source", "header", "prefix=",
-                                        "output-dir="] + extra_long_options)
+                                       'chp:o:' + extra_options,
+                                       ['source', 'header', 'prefix=',
+                                        'output-dir='] + extra_long_options)
     except getopt.GetoptError as err:
         print >>sys.stderr, "%s: %s" % (sys.argv[0], str(err))
         sys.exit(1)
 
-    output_dir = ""
-    prefix = ""
+    output_dir = ''
+    prefix = ''
     do_c = False
     do_h = False
     extra_opts = []
 
     for oa in opts:
         o, a = oa
-        if o in ("-p", "--prefix"):
+        if o in ('-p', '--prefix'):
             match = re.match(r'([A-Za-z_.-][A-Za-z0-9_.-]*)?', a)
             if match.end() != len(a):
                 print >>sys.stderr, \
@@ -1975,11 +1975,11 @@ def parse_command_line(extra_options="", extra_long_options=[]):
                     % (sys.argv[0], a[match.end()])
                 sys.exit(1)
             prefix = a
-        elif o in ("-o", "--output-dir"):
-            output_dir = a + "/"
-        elif o in ("-c", "--source"):
+        elif o in ('-o', '--output-dir'):
+            output_dir = a + '/'
+        elif o in ('-c', '--source'):
             do_c = True
-        elif o in ("-h", "--header"):
+        elif o in ('-h', '--header'):
             do_h = True
         else:
             extra_opts.append(oa)
diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 4583477..91cd593 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -50,7 +50,7 @@ def subst_vars(doc):
 
 def subst_braces(doc):
     """Replaces {} with @{ @}"""
-    return doc.replace("{", "@{").replace("}", "@}")
+    return doc.replace('{', '@{').replace('}', '@}')
 
 
 def texi_example(doc):
@@ -79,10 +79,10 @@ def texi_format(doc):
     doc = subst_vars(doc)
     doc = subst_emph(doc)
     doc = subst_strong(doc)
-    inlist = ""
+    inlist = ''
     lastempty = False
     for line in doc.split('\n'):
-        empty = line == ""
+        empty = line == ''
 
         # FIXME: Doing this in a single if / elif chain is
         # problematic.  For instance, a line without markup terminates
@@ -92,35 +92,35 @@ def texi_format(doc):
         #
         # Make sure to update section "Documentation markup" in
         # docs/qapi-code-gen.txt when fixing this.
-        if line.startswith("| "):
+        if line.startswith('| '):
             line = EXAMPLE_FMT(code=line[2:])
-        elif line.startswith("= "):
-            line = "@section " + line[2:]
-        elif line.startswith("== "):
-            line = "@subsection " + line[3:]
+        elif line.startswith('= '):
+            line = '@section ' + line[2:]
+        elif line.startswith('== '):
+            line = '@subsection ' + line[3:]
         elif re.match(r'^([0-9]*\.) ', line):
             if not inlist:
-                lines.append("@enumerate")
-                inlist = "enumerate"
-            line = line[line.find(" ")+1:]
-            lines.append("@item")
+                lines.append('@enumerate')
+                inlist = 'enumerate'
+            line = line[line.find(' ')+1:]
+            lines.append('@item')
         elif re.match(r'^[*-] ', line):
             if not inlist:
-                lines.append("@itemize %s" % {'*': "@bullet",
-                                              '-': "@minus"}[line[0]])
-                inlist = "itemize"
-            lines.append("@item")
+                lines.append('@itemize %s' % {'*': '@bullet',
+                                              '-': '@minus'}[line[0]])
+                inlist = 'itemize'
+            lines.append('@item')
             line = line[2:]
         elif lastempty and inlist:
-            lines.append("@end %s\n" % inlist)
-            inlist = ""
+            lines.append('@end %s\n' % inlist)
+            inlist = ''
 
         lastempty = empty
         lines.append(line)
 
     if inlist:
-        lines.append("@end %s\n" % inlist)
-    return "\n".join(lines)
+        lines.append('@end %s\n' % inlist)
+    return '\n'.join(lines)
 
 
 def texi_body(doc):
@@ -158,12 +158,12 @@ def texi_sections(doc):
     for section in doc.sections:
         name, doc = (section.name, str(section))
         func = texi_format
-        if name.startswith("Example"):
+        if name.startswith('Example'):
             func = texi_example
 
         if name:
             # prefer @b over @strong, so txt doesn't translate it to *Foo:*
-            body += "\n\n@b{%s:}\n" % name
+            body += '\n\n@b{%s:}\n' % name
 
         body += func(doc)
     return body
@@ -269,5 +269,5 @@ def main(argv):
     print texi_schema(schema)
 
 
-if __name__ == "__main__":
+if __name__ == '__main__':
     main(sys.argv)
-- 
2.7.4

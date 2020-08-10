Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F82AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:57:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BAE022BF3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZihLP3J/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BAE022BF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Dup-000659-Ek
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 15:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5Doi-0000a7-Ff
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:50:44 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:40512)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5Dod-0004lO-Uh
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:50:44 -0400
Received: by mail-wm1-x331.google.com with SMTP id k20so664787wmi.5
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 12:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=z/dTzF2aEpv733HceHEozLrO8vWXaXfUqU2qDmOaLKo=;
 b=ZihLP3J/KcleUK4I0C95+PUWmjfUomT5KyWRk0mfQMm2Iy/YBhOOv4YZJ51oz/C7UQ
 wQxDoWuSQpPa4UFB/L5k96XYJDxxwEmhgoafBNPaUmnBvKdRYMMig3WNzPwM0yMDpxSO
 DBTkRgCKSJko92CiGLByVMbeu1UqiMcp7L74G0WsgyaqRde6W937rsUTFviXeG4ApNx8
 IjuYagxEZQ4TFarkAxB/5+89JU7obrLTol3bnTa7edOixbWiO6Rza4Xm+44F16Ntxdn9
 VpXe/YQFgk9JZfjlj67Q0q6tiLgkGsaSfgFBbUfd32hmAjrnmeUVMDuwp+9QOOoDMU2m
 42MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=z/dTzF2aEpv733HceHEozLrO8vWXaXfUqU2qDmOaLKo=;
 b=ZOD3oPQF4E5oVJXd1MT9iPHfPpnb4wZKSTb3sbtgBQI6UsV8DurDCH6e/ZQJWposlv
 Terrl9yz3T5jrgQl5biSJWsshKCXc6z/Q4yew1uEYHI4Qowza1EhQiU3chmmx8KU5Ohq
 98yhF97WaOPt4ajZoK0X2rkcQRbL3LuZpvmYjJQey5NUmnJb8YBHk1Lkxl8Q0Kl217Pm
 HSOST+veOqpWj8Ez9u4gcXaYxbkysCTTM/2Q/py3wScWoDo4tXXTCO97sdFUAo3UaGp1
 0FUc9plByACv+veqv7SPE1sondh013TLA+0Upb9iuyQD7VWUtiq6QdjBHjeaXiwmBESL
 bSdw==
X-Gm-Message-State: AOAM5311EKl7EhVRQ+PuxQ1QMENDYfcZDW+JZNMwhEQoVCvbl88XUR4G
 u0vhNyKkFy7y83HTKoRyC4xFKRAF7JZJaA==
X-Google-Smtp-Source: ABdhPJwwfPRZJCMtmZ701QVCxP6QapxTeNzkKhG+1ueV7OsUhuKtqH7RfxrPOO3AY4WubFEitEK4LQ==
X-Received: by 2002:a7b:cf29:: with SMTP id m9mr757581wmg.88.1597089037183;
 Mon, 10 Aug 2020 12:50:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b129sm976087wmb.29.2020.08.10.12.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2020 12:50:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 09/20] docs/sphinx: Add new qapi-doc Sphinx extension
Date: Mon, 10 Aug 2020 20:50:08 +0100
Message-Id: <20200810195019.25427-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200810195019.25427-1-peter.maydell@linaro.org>
References: <20200810195019.25427-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some of our documentation is auto-generated from documentation
comments in the JSON schema.

For Sphinx, rather than creating a file to include, the most natural
way to handle this is to have a small custom Sphinx extension which
processes the JSON file and inserts documentation into the rST
file being processed.

This is the same approach that kerneldoc and hxtool use.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Changes v4->v5: match the changes in parameters to the
various visit_* methods from commit 7b3bc9e28f366
---
 docs/conf.py           |   6 +-
 docs/sphinx/qapidoc.py | 504 +++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS            |   1 +
 3 files changed, 510 insertions(+), 1 deletion(-)
 create mode 100644 docs/sphinx/qapidoc.py

diff --git a/docs/conf.py b/docs/conf.py
index d6e173ef77b..44ec5050717 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -52,7 +52,10 @@ except NameError:
 # add these directories to sys.path here. If the directory is relative to the
 # documentation root, use an absolute path starting from qemu_docdir.
 #
+# Our extensions are in docs/sphinx; the qapidoc extension requires
+# the QAPI modules from scripts/.
 sys.path.insert(0, os.path.join(qemu_docdir, "sphinx"))
+sys.path.insert(0, os.path.join(qemu_docdir, "../scripts"))
 
 
 # -- General configuration ------------------------------------------------
@@ -67,7 +70,7 @@ needs_sphinx = '1.6'
 # Add any Sphinx extension module names here, as strings. They can be
 # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
 # ones.
-extensions = ['kerneldoc', 'qmp_lexer', 'hxtool']
+extensions = ['kerneldoc', 'qmp_lexer', 'hxtool', 'qapidoc']
 
 # Add any paths that contain templates here, relative to this directory.
 templates_path = ['_templates']
@@ -241,3 +244,4 @@ texinfo_documents = [
 kerneldoc_bin = os.path.join(qemu_docdir, '../scripts/kernel-doc')
 kerneldoc_srctree = os.path.join(qemu_docdir, '..')
 hxtool_srctree = os.path.join(qemu_docdir, '..')
+qapidoc_srctree = os.path.join(qemu_docdir, '..')
diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
new file mode 100644
index 00000000000..4f571b2f45a
--- /dev/null
+++ b/docs/sphinx/qapidoc.py
@@ -0,0 +1,504 @@
+# coding=utf-8
+#
+# QEMU qapidoc QAPI file parsing extension
+#
+# Copyright (c) 2020 Linaro
+#
+# This work is licensed under the terms of the GNU GPLv2 or later.
+# See the COPYING file in the top-level directory.
+"""qapidoc is a Sphinx extension that implements the qapi-doc directive"""
+
+# The purpose of this extension is to read the documentation comments
+# in QAPI JSON schema files, and insert them all into the current document.
+# The conf.py file must set the qapidoc_srctree config value to
+# the root of the QEMU source tree.
+# Each qapi-doc:: directive takes one argument which is the
+# path of the .json file to process, relative to the source tree.
+
+import os
+import re
+
+from docutils import nodes
+from docutils.statemachine import ViewList
+from docutils.parsers.rst import directives, Directive
+from sphinx.errors import ExtensionError
+from sphinx.util.nodes import nested_parse_with_titles
+import sphinx
+from qapi.gen import QAPISchemaVisitor
+from qapi.schema import QAPIError, QAPISchema
+
+# Sphinx up to 1.6 uses AutodocReporter; 1.7 and later
+# use switch_source_input. Check borrowed from kerneldoc.py.
+Use_SSI = sphinx.__version__[:3] >= '1.7'
+if Use_SSI:
+    from sphinx.util.docutils import switch_source_input
+else:
+    from sphinx.ext.autodoc import AutodocReporter
+
+
+__version__ = '1.0'
+
+# Function borrowed from pydash, which is under the MIT license
+def intersperse(iterable, separator):
+    """Like join, but for arbitrary iterables, notably arrays"""
+    iterable = iter(iterable)
+    yield next(iterable)
+    for item in iterable:
+        yield separator
+        yield item
+
+class QAPISchemaGenRSTVisitor(QAPISchemaVisitor):
+    """A QAPI schema visitor which generates docutils/Sphinx nodes
+
+    This class builds up a tree of docutils/Sphinx nodes corresponding
+    to documentation for the various QAPI objects. To use it, first create
+    a QAPISchemaGenRSTVisitor object, and call its visit_begin() method.
+    Then you can call one of the two methods 'freeform' (to add documentation
+    for a freeform documentation chunk) or 'symbol' (to add documentation
+    for a QAPI symbol). These will cause the visitor to build up the
+    tree of document nodes. Once you've added all the documentation
+    via 'freeform' and 'symbol' method calls, you can call 'get_document_nodes'
+    to get the final list of document nodes (in a form suitable for returning
+    from a Sphinx directive's 'run' method).
+    """
+    def __init__(self, sphinx_directive):
+        self._cur_doc = None
+        self._sphinx_directive = sphinx_directive
+        self._top_node = nodes.section()
+        self._active_headings = [self._top_node]
+
+    def _serror(self, msg):
+        """Raise an exception giving a user-friendly syntax error message"""
+        file = self._cur_doc.info.fname
+        line = self._cur_doc.info.line
+        raise ExtensionError('%s line %d: syntax error: %s' % (file, line, msg))
+
+    def _make_dlitem(self, term, defn):
+        """Return a dlitem node with the specified term and definition.
+
+        term should be a list of Text and literal nodes.
+        defn should be one of:
+        - a string, which will be handed to _parse_text_into_node
+        - a list of Text and literal nodes, which will be put into
+          a paragraph node
+        """
+        dlitem = nodes.definition_list_item()
+        dlterm = nodes.term('', '', *term)
+        dlitem += dlterm
+        if defn:
+            dldef = nodes.definition()
+            if isinstance(defn, list):
+                dldef += nodes.paragraph('', '', *defn)
+            else:
+                self._parse_text_into_node(defn, dldef)
+            dlitem += dldef
+        return dlitem
+
+    def _make_section(self, title):
+        """Return a section node with optional title"""
+        section = nodes.section(ids=[self._sphinx_directive.new_serialno()])
+        if title:
+            section += nodes.title(title, title)
+        return section
+
+    def _nodes_for_ifcond(self, ifcond, with_if=True):
+        """Return list of Text, literal nodes for the ifcond
+
+        Return a list which gives text like ' (If: cond1, cond2, cond3)', where
+        the conditions are in literal-text and the commas are not.
+        If with_if is False, we don't return the "(If: " and ")".
+        """
+        condlist = intersperse([nodes.literal('', c) for c in ifcond],
+                               nodes.Text(', '))
+        if not with_if:
+            return condlist
+
+        nodelist = [nodes.Text(' ('), nodes.strong('', 'If: ')]
+        nodelist.extend(condlist)
+        nodelist.append(nodes.Text(')'))
+        return nodelist
+
+    def _nodes_for_one_member(self, member):
+        """Return list of Text, literal nodes for this member
+
+        Return a list of doctree nodes which give text like
+        'name: type (optional) (If: ...)' suitable for use as the
+        'term' part of a definition list item.
+        """
+        term = [nodes.literal('', member.name)]
+        if member.type.doc_type():
+            term.append(nodes.Text(': '))
+            term.append(nodes.literal('', member.type.doc_type()))
+        if member.optional:
+            term.append(nodes.Text(' (optional)'))
+        if member.ifcond:
+            term.extend(self._nodes_for_ifcond(member.ifcond))
+        return term
+
+    def _nodes_for_variant_when(self, variants, variant):
+        """Return list of Text, literal nodes for variant 'when' clause
+
+        Return a list of doctree nodes which give text like
+        'when tagname is variant (If: ...)' suitable for use in
+        the 'variants' part of a definition list.
+        """
+        term = [nodes.Text(' when '),
+                nodes.literal('', variants.tag_member.name),
+                nodes.Text(' is '),
+                nodes.literal('', '"%s"' % variant.name)]
+        if variant.ifcond:
+            term.extend(self._nodes_for_ifcond(variant.ifcond))
+        return term
+
+    def _nodes_for_members(self, doc, what, base=None, variants=None):
+        """Return doctree nodes for the table of members"""
+        dlnode = nodes.definition_list()
+        for section in doc.args.values():
+            term = self._nodes_for_one_member(section.member)
+            # TODO drop fallbacks when undocumented members are outlawed
+            if section.text:
+                defn = section.text
+            elif (variants and variants.tag_member == section.member
+                  and not section.member.type.doc_type()):
+                values = section.member.type.member_names()
+                defn = [nodes.Text('One of ')]
+                defn.extend(intersperse([nodes.literal('', v) for v in values],
+                                        nodes.Text(', ')))
+            else:
+                defn = [nodes.Text('Not documented')]
+
+            dlnode += self._make_dlitem(term, defn)
+
+        if base:
+            dlnode += self._make_dlitem([nodes.Text('The members of '),
+                                         nodes.literal('', base.doc_type())],
+                                        None)
+
+        if variants:
+            for v in variants.variants:
+                if v.type.is_implicit():
+                    assert not v.type.base and not v.type.variants
+                    for m in v.type.local_members:
+                        term = self._nodes_for_one_member(m)
+                        term.extend(self._nodes_for_variant_when(variants, v))
+                        dlnode += self._make_dlitem(term, None)
+                else:
+                    term = [nodes.Text('The members of '),
+                            nodes.literal('', v.type.doc_type())]
+                    term.extend(self._nodes_for_variant_when(variants, v))
+                    dlnode += self._make_dlitem(term, None)
+
+        if not dlnode.children:
+            return None
+
+        section = self._make_section(what)
+        section += dlnode
+        return section
+
+    def _nodes_for_enum_values(self, doc, what):
+        """Return doctree nodes for the table of enum values"""
+        seen_item = False
+        dlnode = nodes.definition_list()
+        for section in doc.args.values():
+            termtext = [nodes.literal('', section.member.name)]
+            if section.member.ifcond:
+                termtext.extend(self._nodes_for_ifcond(section.member.ifcond))
+            # TODO drop fallbacks when undocumented members are outlawed
+            if section.text:
+                defn = section.text
+            else:
+                defn = [nodes.Text('Not documented')]
+
+            dlnode += self._make_dlitem(termtext, defn)
+            seen_item = True
+
+        if not seen_item:
+            return None
+
+        section = self._make_section(what)
+        section += dlnode
+        return section
+
+    def _nodes_for_arguments(self, doc, boxed_arg_type):
+        """Return doctree nodes for the arguments section"""
+        if boxed_arg_type:
+            assert not doc.args
+            section = self._make_section('Arguments')
+            dlnode = nodes.definition_list()
+            dlnode += self._make_dlitem(
+                [nodes.Text('The members of '),
+                 nodes.literal('', boxed_arg_type.name)],
+                None)
+            section += dlnode
+            return section
+
+        return self._nodes_for_members(doc, 'Arguments')
+
+    def _nodes_for_features(self, doc):
+        """Return doctree nodes for the table of features"""
+        seen_item = False
+        dlnode = nodes.definition_list()
+        for section in doc.features.values():
+            dlnode += self._make_dlitem([nodes.literal('', section.name)],
+                                        section.text)
+            seen_item = True
+
+        if not seen_item:
+            return None
+
+        section = self._make_section('Features')
+        section += dlnode
+        return section
+
+    def _nodes_for_example(self, exampletext):
+        """Return doctree nodes for a code example snippet"""
+        return nodes.literal_block(exampletext, exampletext)
+
+    def _nodes_for_sections(self, doc, ifcond):
+        """Return doctree nodes for additional sections following arguments"""
+        nodelist = []
+        for section in doc.sections:
+            snode = self._make_section(section.name)
+            if section.name and section.name.startswith('Example'):
+                snode += self._nodes_for_example(section.text)
+            else:
+                self._parse_text_into_node(section.text, snode)
+            nodelist.append(snode)
+        if ifcond:
+            snode = self._make_section('If')
+            snode += self._nodes_for_ifcond(ifcond, with_if=False)
+            nodelist.append(snode)
+        if not nodelist:
+            return None
+        return nodelist
+
+    def _add_doc(self, typ, sections):
+        """Add documentation for a command/object/enum...
+
+        We assume we're documenting the thing defined in self._cur_doc.
+        typ is the type of thing being added ("Command", "Object", etc)
+
+        sections is a list of nodes for sections to add to the definition.
+        """
+
+        doc = self._cur_doc
+        snode = nodes.section(ids=[self._sphinx_directive.new_serialno()])
+        snode += nodes.title('', '', *[nodes.literal(doc.symbol, doc.symbol),
+                                       nodes.Text(' (' + typ + ')')])
+        self._parse_text_into_node(doc.body.text, snode)
+        for s in sections:
+            if s is not None:
+                snode += s
+        self._add_node_to_current_heading(snode)
+
+    def visit_enum_type(self, name, info, ifcond, features, members, prefix):
+        doc = self._cur_doc
+        self._add_doc('Enum',
+                      [self._nodes_for_enum_values(doc, 'Values'),
+                       self._nodes_for_features(doc),
+                       self._nodes_for_sections(doc, ifcond)])
+
+    def visit_object_type(self, name, info, ifcond, features,
+                          base, members, variants):
+        doc = self._cur_doc
+        if base and base.is_implicit():
+            base = None
+        self._add_doc('Object',
+                      [self._nodes_for_members(doc, 'Members', base, variants),
+                       self._nodes_for_features(doc),
+                       self._nodes_for_sections(doc, ifcond)])
+
+    def visit_alternate_type(self, name, info, ifcond, features, variants):
+        doc = self._cur_doc
+        self._add_doc('Alternate',
+                      [self._nodes_for_members(doc, 'Members'),
+                       self._nodes_for_features(doc),
+                       self._nodes_for_sections(doc, ifcond)])
+
+    def visit_command(self, name, info, ifcond, features, arg_type,
+                      ret_type, gen, success_response, boxed, allow_oob,
+                      allow_preconfig):
+        doc = self._cur_doc
+        self._add_doc('Command',
+                      [self._nodes_for_arguments(doc,
+                                                 arg_type if boxed else None),
+                       self._nodes_for_features(doc),
+                       self._nodes_for_sections(doc, ifcond)])
+
+    def visit_event(self, name, info, ifcond, features, arg_type, boxed):
+        doc = self._cur_doc
+        self._add_doc('Event',
+                      [self._nodes_for_arguments(doc,
+                                                 arg_type if boxed else None),
+                       self._nodes_for_features(doc),
+                       self._nodes_for_sections(doc, ifcond)])
+
+    def symbol(self, doc, entity):
+        """Add documentation for one symbol to the document tree
+
+        This is the main entry point which causes us to add documentation
+        nodes for a symbol (which could be a 'command', 'object', 'event',
+        etc). We do this by calling 'visit' on the schema entity, which
+        will then call back into one of our visit_* methods, depending
+        on what kind of thing this symbol is.
+        """
+        self._cur_doc = doc
+        entity.visit(self)
+        self._cur_doc = None
+
+    def _start_new_heading(self, heading, level):
+        """Start a new heading at the specified heading level
+
+        Create a new section whose title is 'heading' and which is placed
+        in the docutils node tree as a child of the most recent level-1
+        heading. Subsequent document sections (commands, freeform doc chunks,
+        etc) will be placed as children of this new heading section.
+        """
+        if len(self._active_headings) < level:
+            self._serror('Level %d subheading found outside a level %d heading'
+                         % (level, level - 1))
+        snode = self._make_section(heading)
+        self._active_headings[level - 1] += snode
+        self._active_headings = self._active_headings[:level]
+        self._active_headings.append(snode)
+
+    def _add_node_to_current_heading(self, node):
+        """Add the node to whatever the current active heading is"""
+        self._active_headings[-1] += node
+
+    def freeform(self, doc):
+        """Add a piece of 'freeform' documentation to the document tree
+
+        A 'freeform' document chunk doesn't relate to any particular
+        symbol (for instance, it could be an introduction).
+
+        As a special case, if the freeform document is a single line
+        of the form '= Heading text' it is treated as a section or subsection
+        heading, with the heading level indicated by the number of '=' signs.
+        """
+
+        # QAPIDoc documentation says free-form documentation blocks
+        # must have only a body section, nothing else.
+        assert not doc.sections
+        assert not doc.args
+        assert not doc.features
+        self._cur_doc = doc
+
+        if re.match(r'=+ ', doc.body.text):
+            # Section or subsection heading: must be the only thing in the block
+            (heading, _, rest) = doc.body.text.partition('\n')
+            if rest != '':
+                raise ExtensionError('%s line %s: section or subsection heading'
+                                     ' must be in its own doc comment block'
+                                     % (doc.info.fname, doc.info.line))
+            (leader, _, heading) = heading.partition(' ')
+            self._start_new_heading(heading, len(leader))
+            return
+
+        node = self._make_section(None)
+        self._parse_text_into_node(doc.body.text, node)
+        self._add_node_to_current_heading(node)
+        self._cur_doc = None
+
+    def _parse_text_into_node(self, doctext, node):
+        """Parse a chunk of QAPI-doc-format text into the node
+
+        The doc comment can contain most inline rST markup, including
+        bulleted and enumerated lists.
+        As an extra permitted piece of markup, @var will be turned
+        into ``var``.
+        """
+
+        # Handle the "@var means ``var`` case
+        doctext = re.sub(r'@([\w-]+)', r'``\1``', doctext)
+
+        rstlist = ViewList()
+        for line in doctext.splitlines():
+            # The reported line number will always be that of the start line
+            # of the doc comment, rather than the actual location of the error.
+            # Being more precise would require overhaul of the QAPIDoc class
+            # to track lines more exactly within all the sub-parts of the doc
+            # comment, as well as counting lines here.
+            rstlist.append(line, self._cur_doc.info.fname,
+                           self._cur_doc.info.line)
+        self._sphinx_directive.do_parse(rstlist, node)
+
+    def get_document_nodes(self):
+        """Return the list of docutils nodes which make up the document"""
+        return self._top_node.children
+
+class QAPIDocDirective(Directive):
+    """Extract documentation from the specified QAPI .json file"""
+    required_argument = 1
+    optional_arguments = 1
+    option_spec = {
+        'qapifile': directives.unchanged_required
+    }
+    has_content = False
+
+    def new_serialno(self):
+        """Return a unique new ID string suitable for use as a node's ID"""
+        env = self.state.document.settings.env
+        return 'qapidoc-%d' % env.new_serialno('qapidoc')
+
+    def run(self):
+        env = self.state.document.settings.env
+        qapifile = env.config.qapidoc_srctree + '/' + self.arguments[0]
+
+        # Tell sphinx of the dependency
+        env.note_dependency(os.path.abspath(qapifile))
+
+        try:
+            schema = QAPISchema(qapifile)
+        except QAPIError as err:
+            # Launder QAPI parse errors into Sphinx extension errors
+            # so they are displayed nicely to the user
+            raise ExtensionError(str(err))
+
+        vis = QAPISchemaGenRSTVisitor(self)
+        vis.visit_begin(schema)
+        for doc in schema.docs:
+            if doc.symbol:
+                vis.symbol(doc, schema.lookup_entity(doc.symbol))
+            else:
+                vis.freeform(doc)
+
+        return vis.get_document_nodes()
+
+    def do_parse(self, rstlist, node):
+        """Parse rST source lines and add them to the specified node
+
+        Take the list of rST source lines rstlist, parse them as
+        rST, and add the resulting docutils nodes as children of node.
+        The nodes are parsed in a way that allows them to include
+        subheadings (titles) without confusing the rendering of
+        anything else.
+        """
+        # This is from kerneldoc.py -- it works around an API change in
+        # Sphinx between 1.6 and 1.7. Unlike kerneldoc.py, we use
+        # sphinx.util.nodes.nested_parse_with_titles() rather than the
+        # plain self.state.nested_parse(), and so we can drop the saving
+        # of title_styles and section_level that kerneldoc.py does,
+        # because nested_parse_with_titles() does that for us.
+        if Use_SSI:
+            with switch_source_input(self.state, rstlist):
+                nested_parse_with_titles(self.state, rstlist, node)
+        else:
+            save = self.state.memo.reporter
+            self.state.memo.reporter = AutodocReporter(rstlist,
+                                                       self.state.memo.reporter)
+            try:
+                nested_parse_with_titles(self.state, rstlist, node)
+            finally:
+                self.state.memo.reporter = save
+
+def setup(app):
+    """ Register qapi-doc directive with Sphinx"""
+    app.add_config_value('qapidoc_srctree', None, 'env')
+    app.add_directive('qapi-doc', QAPIDocDirective)
+
+    return dict(
+        version=__version__,
+        parallel_read_safe=True,
+        parallel_write_safe=True
+    )
diff --git a/MAINTAINERS b/MAINTAINERS
index 0886eb3d2b5..fdd38f412d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3116,6 +3116,7 @@ M: Peter Maydell <peter.maydell@linaro.org>
 S: Maintained
 F: docs/conf.py
 F: docs/*/conf.py
+F: docs/sphinx/
 
 Miscellaneous
 -------------
-- 
2.20.1



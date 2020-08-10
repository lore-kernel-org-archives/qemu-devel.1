Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408AAC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:59:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDF7922BF3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="InJvmFMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDF7922BF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Dx5-0001Ao-UT
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 15:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5Dor-0000vx-NX
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:50:53 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40167)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5Don-0004sR-9h
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:50:53 -0400
Received: by mail-wr1-x443.google.com with SMTP id l2so9308651wrc.7
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 12:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ul05RQOEBEfTMdEpHtLX0A67yI0APyniOjyDQ7PDnTY=;
 b=InJvmFMmQoU8GfWzIpI/9BJ5/NsnzcTwiuBeLmc294ykZDArzZNnvDMJQY9j9yn9Zb
 x8i7Rpz9EbihR/ghvVpu/cQ30cc5ZYLFzpTa9UNDDhQLl9XJBsIQKJU0adiV93BEFJ1p
 PAczKpWEo6lN3eN4V4Qx3PCR6amvVbl1YueYgDxofuSb+jcFRUX5OlDwI+albg9EXlnA
 mZMQ/6MnRW8aB3szlpGkk/iA7MmOUAdep0Cz9rcWmhz3upimyzkIo5C6vo8Xbi6j3To+
 cxS08D4doNqIMSIL1G3Bs1sJpuPZ0vVCI+xthvO537PRa77u83zMhVL1R3dB9lkVBUnv
 RlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ul05RQOEBEfTMdEpHtLX0A67yI0APyniOjyDQ7PDnTY=;
 b=Pj5kbbH9tTTn8diHil5ga2yOWYLgwqnt7+WI8LN5o8255pNHIO+BMVqSl+CSV4pKzS
 glZVP8PUoj0Z8kmqBLdKQ1iPQ//kwUuj0JHtn2e/tn51eZrp5NEi5PQEEJyw9bZEd4VV
 DzEwUKuSTmxKxCpHWeKXVAJIPpziNIbReVlSG/R9BHqk9baHEl32B1+8ulc6piTNNa9u
 K9Pnd1Cp55ZWZKvo1jzHhymvdAmLlygdZRzPvIVfmp73z02KmH9sQ0Q0oyzZXYq5iEVm
 mRV01OCx1X5jyOt7lcfodk9c+BB7oPC9UVPv5Aj+oFGoDyicAJHMx9M16yU2ITbK2ljb
 QlQg==
X-Gm-Message-State: AOAM530hhsxXwaBS3h/Wc1pC4sV+6qyJi2vVNZf/JetMKGzQrnvHsHUR
 4HgI7msWhAUsa66qEA8jXgsv3mouGDdC0A==
X-Google-Smtp-Source: ABdhPJweocpKR71/Yb7bJ3YgyOyBhVL4ZYjjwBjFgl+Vu4sBKQMxLGrH1A33eUMwY/OlVfAgZOZAHQ==
X-Received: by 2002:adf:fc45:: with SMTP id e5mr27861778wrs.226.1597089046347; 
 Mon, 10 Aug 2020 12:50:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b129sm976087wmb.29.2020.08.10.12.50.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2020 12:50:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 14/20] scripts/qapi: Remove texinfo generation support
Date: Mon, 10 Aug 2020 20:50:13 +0100
Message-Id: <20200810195019.25427-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200810195019.25427-1-peter.maydell@linaro.org>
References: <20200810195019.25427-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
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

We no longer use the generated texinfo format documentation,
so delete the code that generates it, and the test case for
the generation.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 Makefile                        |   1 -
 scripts/qapi-gen.py             |   2 -
 scripts/qapi/doc.py             | 302 ------------------------------
 scripts/qapi/gen.py             |   7 -
 tests/Makefile.include          |  15 +-
 tests/qapi-schema/doc-good.texi | 313 --------------------------------
 6 files changed, 1 insertion(+), 639 deletions(-)
 delete mode 100644 scripts/qapi/doc.py
 delete mode 100644 tests/qapi-schema/doc-good.texi

diff --git a/Makefile b/Makefile
index 3df1cf68333..fc3ccc15030 100644
--- a/Makefile
+++ b/Makefile
@@ -626,7 +626,6 @@ qemu-keymap$(EXESUF): QEMU_CFLAGS += $(XKBCOMMON_CFLAGS)
 qapi-py = $(SRC_PATH)/scripts/qapi/__init__.py \
 $(SRC_PATH)/scripts/qapi/commands.py \
 $(SRC_PATH)/scripts/qapi/common.py \
-$(SRC_PATH)/scripts/qapi/doc.py \
 $(SRC_PATH)/scripts/qapi/error.py \
 $(SRC_PATH)/scripts/qapi/events.py \
 $(SRC_PATH)/scripts/qapi/expr.py \
diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
index 4b03f7d53be..541e8c1f55d 100755
--- a/scripts/qapi-gen.py
+++ b/scripts/qapi-gen.py
@@ -10,7 +10,6 @@ import re
 import sys
 
 from qapi.commands import gen_commands
-from qapi.doc import gen_doc
 from qapi.events import gen_events
 from qapi.introspect import gen_introspect
 from qapi.schema import QAPIError, QAPISchema
@@ -51,7 +50,6 @@ def main(argv):
     gen_commands(schema, args.output_dir, args.prefix)
     gen_events(schema, args.output_dir, args.prefix)
     gen_introspect(schema, args.output_dir, args.prefix, args.unmask)
-    gen_doc(schema, args.output_dir, args.prefix)
 
 
 if __name__ == '__main__':
diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
deleted file mode 100644
index 7764de1e4bc..00000000000
--- a/scripts/qapi/doc.py
+++ /dev/null
@@ -1,302 +0,0 @@
-# QAPI texi generator
-#
-# This work is licensed under the terms of the GNU LGPL, version 2+.
-# See the COPYING file in the top-level directory.
-"""This script produces the documentation of a qapi schema in texinfo format"""
-
-import re
-from qapi.gen import QAPIGenDoc, QAPISchemaVisitor
-
-
-MSG_FMT = """
-@deftypefn {type} {{}} {name}
-
-{body}{members}{features}{sections}
-@end deftypefn
-
-""".format
-
-TYPE_FMT = """
-@deftp {{{type}}} {name}
-
-{body}{members}{features}{sections}
-@end deftp
-
-""".format
-
-EXAMPLE_FMT = """@example
-{code}
-@end example
-""".format
-
-
-def subst_strong(doc):
-    """Replaces *foo* by @strong{foo}"""
-    return re.sub(r'\*([^*\n]+)\*', r'@strong{\1}', doc)
-
-
-def subst_emph(doc):
-    """Replaces _foo_ by @emph{foo}"""
-    return re.sub(r'\b_([^_\n]+)_\b', r'@emph{\1}', doc)
-
-
-def subst_vars(doc):
-    """Replaces @var by @code{var}"""
-    return re.sub(r'@([\w-]+)', r'@code{\1}', doc)
-
-
-def subst_braces(doc):
-    """Replaces {} with @{ @}"""
-    return doc.replace('{', '@{').replace('}', '@}')
-
-
-def texi_example(doc):
-    """Format @example"""
-    # TODO: Neglects to escape @ characters.
-    # We should probably escape them in subst_braces(), and rename the
-    # function to subst_special() or subs_texi_special().  If we do that, we
-    # need to delay it until after subst_vars() in texi_format().
-    doc = subst_braces(doc).strip('\n')
-    return EXAMPLE_FMT(code=doc)
-
-
-def texi_format(doc):
-    """
-    Format documentation
-
-    Lines starting with:
-    - |: generates an @example
-    - =: generates @section
-    - ==: generates @subsection
-    - 1. or 1): generates an @enumerate @item
-    - */-: generates an @itemize list
-    """
-    ret = ''
-    doc = subst_braces(doc)
-    doc = subst_vars(doc)
-    doc = subst_emph(doc)
-    doc = subst_strong(doc)
-    inlist = ''
-    lastempty = False
-    for line in doc.split('\n'):
-        line = line.strip()
-        empty = line == ''
-
-        # FIXME: Doing this in a single if / elif chain is
-        # problematic.  For instance, a line without markup terminates
-        # a list if it follows a blank line (reaches the final elif),
-        # but a line with some *other* markup, such as a = title
-        # doesn't.
-        #
-        # Make sure to update section "Documentation markup" in
-        # docs/devel/qapi-code-gen.txt when fixing this.
-        if line.startswith('| '):
-            line = EXAMPLE_FMT(code=line[2:])
-        elif line.startswith('= '):
-            line = '@section ' + line[2:]
-        elif line.startswith('== '):
-            line = '@subsection ' + line[3:]
-        elif re.match(r'^([0-9]*\.) ', line):
-            if not inlist:
-                ret += '@enumerate\n'
-                inlist = 'enumerate'
-            ret += '@item\n'
-            line = line[line.find(' ')+1:]
-        elif re.match(r'^[*-] ', line):
-            if not inlist:
-                ret += '@itemize %s\n' % {'*': '@bullet',
-                                          '-': '@minus'}[line[0]]
-                inlist = 'itemize'
-            ret += '@item\n'
-            line = line[2:]
-        elif lastempty and inlist:
-            ret += '@end %s\n\n' % inlist
-            inlist = ''
-
-        lastempty = empty
-        ret += line + '\n'
-
-    if inlist:
-        ret += '@end %s\n\n' % inlist
-    return ret
-
-
-def texi_body(doc):
-    """Format the main documentation body"""
-    return texi_format(doc.body.text)
-
-
-def texi_if(ifcond, prefix='\n', suffix='\n'):
-    """Format the #if condition"""
-    if not ifcond:
-        return ''
-    return '%s@b{If:} @code{%s}%s' % (prefix, ', '.join(ifcond), suffix)
-
-
-def texi_enum_value(value, desc, suffix):
-    """Format a table of members item for an enumeration value"""
-    return '@item @code{%s}\n%s%s' % (
-        value.name, desc, texi_if(value.ifcond, prefix='@*'))
-
-
-def texi_member(member, desc, suffix):
-    """Format a table of members item for an object type member"""
-    typ = member.type.doc_type()
-    membertype = ': ' + typ if typ else ''
-    return '@item @code{%s%s}%s%s\n%s%s' % (
-        member.name, membertype,
-        ' (optional)' if member.optional else '',
-        suffix, desc, texi_if(member.ifcond, prefix='@*'))
-
-
-def texi_members(doc, what, base=None, variants=None,
-                 member_func=texi_member):
-    """Format the table of members"""
-    items = ''
-    for section in doc.args.values():
-        # TODO Drop fallbacks when undocumented members are outlawed
-        if section.text:
-            desc = texi_format(section.text)
-        elif (variants and variants.tag_member == section.member
-              and not section.member.type.doc_type()):
-            values = section.member.type.member_names()
-            members_text = ', '.join(['@t{"%s"}' % v for v in values])
-            desc = 'One of ' + members_text + '\n'
-        else:
-            desc = 'Not documented\n'
-        items += member_func(section.member, desc, suffix='')
-    if base:
-        items += '@item The members of @code{%s}\n' % base.doc_type()
-    if variants:
-        for v in variants.variants:
-            when = ' when @code{%s} is @t{"%s"}%s' % (
-                variants.tag_member.name, v.name, texi_if(v.ifcond, " (", ")"))
-            if v.type.is_implicit():
-                assert not v.type.base and not v.type.variants
-                for m in v.type.local_members:
-                    items += member_func(m, desc='', suffix=when)
-            else:
-                items += '@item The members of @code{%s}%s\n' % (
-                    v.type.doc_type(), when)
-    if not items:
-        return ''
-    return '\n@b{%s:}\n@table @asis\n%s@end table\n' % (what, items)
-
-
-def texi_arguments(doc, boxed_arg_type):
-    if boxed_arg_type:
-        assert not doc.args
-        return ('\n@b{Arguments:} the members of @code{%s}\n'
-                % boxed_arg_type.name)
-    return texi_members(doc, 'Arguments')
-
-
-def texi_features(doc):
-    """Format the table of features"""
-    items = ''
-    for section in doc.features.values():
-        desc = texi_format(section.text)
-        items += '@item @code{%s}\n%s' % (section.name, desc)
-    if not items:
-        return ''
-    return '\n@b{Features:}\n@table @asis\n%s@end table\n' % (items)
-
-
-def texi_sections(doc, ifcond):
-    """Format additional sections following arguments"""
-    body = ''
-    for section in doc.sections:
-        if section.name:
-            # prefer @b over @strong, so txt doesn't translate it to *Foo:*
-            body += '\n@b{%s:}\n' % section.name
-        if section.name and section.name.startswith('Example'):
-            body += texi_example(section.text)
-        else:
-            body += texi_format(section.text)
-    body += texi_if(ifcond, suffix='')
-    return body
-
-
-def texi_type(typ, doc, ifcond, members):
-    return TYPE_FMT(type=typ,
-                    name=doc.symbol,
-                    body=texi_body(doc),
-                    members=members,
-                    features=texi_features(doc),
-                    sections=texi_sections(doc, ifcond))
-
-
-def texi_msg(typ, doc, ifcond, members):
-    return MSG_FMT(type=typ,
-                   name=doc.symbol,
-                   body=texi_body(doc),
-                   members=members,
-                   features=texi_features(doc),
-                   sections=texi_sections(doc, ifcond))
-
-
-class QAPISchemaGenDocVisitor(QAPISchemaVisitor):
-    def __init__(self, prefix):
-        self._prefix = prefix
-        self._gen = QAPIGenDoc(self._prefix + 'qapi-doc.texi')
-        self.cur_doc = None
-
-    def write(self, output_dir):
-        self._gen.write(output_dir)
-
-    def visit_enum_type(self, name, info, ifcond, features, members, prefix):
-        doc = self.cur_doc
-        self._gen.add(texi_type('Enum', doc, ifcond,
-                                texi_members(doc, 'Values',
-                                             member_func=texi_enum_value)))
-
-    def visit_object_type(self, name, info, ifcond, features,
-                          base, members, variants):
-        doc = self.cur_doc
-        if base and base.is_implicit():
-            base = None
-        self._gen.add(texi_type('Object', doc, ifcond,
-                                texi_members(doc, 'Members', base, variants)))
-
-    def visit_alternate_type(self, name, info, ifcond, features, variants):
-        doc = self.cur_doc
-        self._gen.add(texi_type('Alternate', doc, ifcond,
-                                texi_members(doc, 'Members')))
-
-    def visit_command(self, name, info, ifcond, features,
-                      arg_type, ret_type, gen, success_response, boxed,
-                      allow_oob, allow_preconfig):
-        doc = self.cur_doc
-        self._gen.add(texi_msg('Command', doc, ifcond,
-                               texi_arguments(doc,
-                                              arg_type if boxed else None)))
-
-    def visit_event(self, name, info, ifcond, features, arg_type, boxed):
-        doc = self.cur_doc
-        self._gen.add(texi_msg('Event', doc, ifcond,
-                               texi_arguments(doc,
-                                              arg_type if boxed else None)))
-
-    def symbol(self, doc, entity):
-        if self._gen._body:
-            self._gen.add('\n')
-        self.cur_doc = doc
-        entity.visit(self)
-        self.cur_doc = None
-
-    def freeform(self, doc):
-        assert not doc.args
-        if self._gen._body:
-            self._gen.add('\n')
-        self._gen.add(texi_body(doc) + texi_sections(doc, None))
-
-
-def gen_doc(schema, output_dir, prefix):
-    vis = QAPISchemaGenDocVisitor(prefix)
-    vis.visit_begin(schema)
-    for doc in schema.docs:
-        if doc.symbol:
-            vis.symbol(doc, schema.lookup_entity(doc.symbol))
-        else:
-            vis.freeform(doc)
-    vis.write(output_dir)
diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index bf5552a4e7f..ca66c82b5b8 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -178,13 +178,6 @@ def ifcontext(ifcond, *args):
         arg.end_if()
 
 
-class QAPIGenDoc(QAPIGen):
-
-    def _top(self):
-        return (super()._top()
-                + '@c AUTOMATICALLY GENERATED, DO NOT MODIFY\n\n')
-
-
 class QAPISchemaMonolithicCVisitor(QAPISchemaVisitor):
 
     def __init__(self, prefix, what, blurb, pydoc):
diff --git a/tests/Makefile.include b/tests/Makefile.include
index c7e4646ded7..ec83efeaa63 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -38,7 +38,6 @@ export SRC_PATH
 qapi-py = $(SRC_PATH)/scripts/qapi/__init__.py \
 $(SRC_PATH)/scripts/qapi/commands.py \
 $(SRC_PATH)/scripts/qapi/common.py \
-$(SRC_PATH)/scripts/qapi/doc.py \
 $(SRC_PATH)/scripts/qapi/error.py \
 $(SRC_PATH)/scripts/qapi/events.py \
 $(SRC_PATH)/scripts/qapi/expr.py \
@@ -501,16 +500,8 @@ tests/test-qapi-gen-timestamp: \
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
 		-o tests -p "test-" $<, \
 		"GEN","$(@:%-timestamp=%)")
-	@rm -f tests/test-qapi-doc.texi
 	@>$@
 
-tests/qapi-schema/doc-good.test.texi: $(SRC_PATH)/tests/qapi-schema/doc-good.json $(qapi-py)
-	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
-		-o tests/qapi-schema -p "doc-good-" $<, \
-		"GEN","$@")
-	@mv tests/qapi-schema/doc-good-qapi-doc.texi $@
-	@rm -f tests/qapi-schema/doc-good-qapi-*.[ch] tests/qapi-schema/doc-good-qmp-*.[ch]
-
 tests/qtest/dbus-vmstate1.h tests/qtest/dbus-vmstate1.c: tests/qtest/dbus-vmstate1-gen-timestamp ;
 tests/qtest/dbus-vmstate1-gen-timestamp: $(SRC_PATH)/tests/qtest/dbus-vmstate1.xml
 	$(call quiet-command,$(GDBUS_CODEGEN) $< \
@@ -891,10 +882,6 @@ check-tests/qapi-schema/frontend: $(addprefix $(SRC_PATH)/, $(check-qapi-schema-
 	  PYTHONIOENCODING=utf-8 $(PYTHON) $(SRC_PATH)/tests/qapi-schema/test-qapi.py $^, \
 	  TEST, check-qapi-schema)
 
-.PHONY: check-tests/qapi-schema/doc-good.texi
-check-tests/qapi-schema/doc-good.texi: tests/qapi-schema/doc-good.test.texi
-	@diff -u $(SRC_PATH)/tests/qapi-schema/doc-good.texi $<
-
 .PHONY: check-decodetree
 check-decodetree:
 	$(call quiet-command, \
@@ -956,7 +943,7 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR) get-vm-images
 # Consolidated targets
 
 .PHONY: check-block check-qapi-schema check-qtest check-unit check check-clean get-vm-images
-check-qapi-schema: check-tests/qapi-schema/frontend check-tests/qapi-schema/doc-good.texi
+check-qapi-schema: check-tests/qapi-schema/frontend
 check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
 ifeq ($(CONFIG_TOOLS),y)
 check-block: $(patsubst %,check-%, $(check-block-y))
diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good.texi
deleted file mode 100644
index 12808989ffb..00000000000
--- a/tests/qapi-schema/doc-good.texi
+++ /dev/null
@@ -1,313 +0,0 @@
-@c AUTOMATICALLY GENERATED, DO NOT MODIFY
-
-@section Section
-
-@subsection Subsection
-
-@strong{strong} @emph{with emphasis}
-@code{var} @{in braces@}
-
-@itemize @bullet
-@item
-List item one
-@item
-Two, multiple
-lines
-
-@item
-Three
-Still in list
-
-@end itemize
-
-Not in list
-
-@itemize @minus
-@item
-Second list
-Note: still in list
-
-@end itemize
-
-Note: not in list
-
-@enumerate
-@item
-Third list
-is numbered
-
-@item
-another item
-
-@end enumerate
-
-Returns: the King
-Since: the first age
-Notes:
-
-@enumerate
-@item
-Lorem ipsum dolor sit amet
-
-@item
-Ut enim ad minim veniam
-
-@end enumerate
-
-Duis aute irure dolor
-
-Example:
-
--> in
-<- out
-Examples:
-@itemize @minus
-@item
-@strong{verbatim}
-@item
-@{braces@}
-@end itemize
-
-
-
-@deftp {Enum} Enum
-
-
-
-@b{Values:}
-@table @asis
-@item @code{one}
-The @emph{one} @{and only@}
-@*@b{If:} @code{defined(IFONE)}
-@item @code{two}
-Not documented
-@end table
-
-@b{Features:}
-@table @asis
-@item @code{enum-feat}
-Also @emph{one} @{and only@}
-@end table
-@code{two} is undocumented
-
-@b{If:} @code{defined(IFCOND)}
-@end deftp
-
-
-
-@deftp {Object} Base
-
-
-
-@b{Members:}
-@table @asis
-@item @code{base1: Enum}
-the first member
-@end table
-
-@end deftp
-
-
-
-@deftp {Object} Variant1
-
-A paragraph
-
-Another paragraph (but no @code{var}: line)
-
-@b{Members:}
-@table @asis
-@item @code{var1: string}
-Not documented
-@*@b{If:} @code{defined(IFSTR)}
-@end table
-
-@b{Features:}
-@table @asis
-@item @code{variant1-feat}
-a feature
-@item @code{member-feat}
-a member feature
-@end table
-
-@end deftp
-
-
-
-@deftp {Object} Variant2
-
-
-
-@end deftp
-
-
-
-@deftp {Object} Object
-
-
-
-@b{Members:}
-@table @asis
-@item The members of @code{Base}
-@item The members of @code{Variant1} when @code{base1} is @t{"one"}
-@item The members of @code{Variant2} when @code{base1} is @t{"two"} (@b{If:} @code{IFTWO})
-@end table
-
-@b{Features:}
-@table @asis
-@item @code{union-feat1}
-a feature
-@end table
-
-@end deftp
-
-
-
-@deftp {Object} SugaredUnion
-
-
-
-@b{Members:}
-@table @asis
-@item @code{type}
-One of @t{"one"}, @t{"two"}
-@item @code{data: Variant1} when @code{type} is @t{"one"}
-@item @code{data: Variant2} when @code{type} is @t{"two"} (@b{If:} @code{IFTWO})
-@end table
-
-@b{Features:}
-@table @asis
-@item @code{union-feat2}
-a feature
-@end table
-
-@end deftp
-
-
-
-@deftp {Alternate} Alternate
-
-
-
-@b{Members:}
-@table @asis
-@item @code{i: int}
-an integer
-@code{b} is undocumented
-@item @code{b: boolean}
-Not documented
-@end table
-
-@b{Features:}
-@table @asis
-@item @code{alt-feat}
-a feature
-@end table
-
-@end deftp
-
-
-@subsection Another subsection
-
-
-@deftypefn Command {} cmd
-
-
-
-@b{Arguments:}
-@table @asis
-@item @code{arg1: int}
-the first argument
-@item @code{arg2: string} (optional)
-the second
-argument
-@item @code{arg3: boolean}
-Not documented
-@end table
-
-@b{Features:}
-@table @asis
-@item @code{cmd-feat1}
-a feature
-@item @code{cmd-feat2}
-another feature
-@end table
-
-@b{Note:}
-@code{arg3} is undocumented
-
-@b{Returns:}
-@code{Object}
-
-@b{TODO:}
-frobnicate
-
-@b{Notes:}
-@itemize @minus
-@item
-Lorem ipsum dolor sit amet
-@item
-Ut enim ad minim veniam
-
-@end itemize
-
-Duis aute irure dolor
-
-@b{Example:}
-@example
--> in
-<- out
-@end example
-
-@b{Examples:}
-@example
-- *verbatim*
-- @{braces@}
-@end example
-
-@b{Since:}
-2.10
-
-@end deftypefn
-
-
-
-@deftypefn Command {} cmd-boxed
-
-If you're bored enough to read this, go see a video of boxed cats
-
-@b{Arguments:} the members of @code{Object}
-
-@b{Features:}
-@table @asis
-@item @code{cmd-feat1}
-a feature
-@item @code{cmd-feat2}
-another feature
-@end table
-
-@b{Example:}
-@example
--> in
-
-<- out
-@end example
-
-@end deftypefn
-
-
-
-@deftypefn Event {} EVT-BOXED
-
-
-
-@b{Arguments:} the members of @code{Object}
-
-@b{Features:}
-@table @asis
-@item @code{feat3}
-a feature
-@end table
-
-@end deftypefn
-
-- 
2.20.1



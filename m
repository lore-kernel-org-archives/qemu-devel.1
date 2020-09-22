Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C777DC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:57:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62E49221EB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HGyAxBzk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62E49221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKrDq-0003AA-8D
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 18:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKqti-0006JE-3k
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:36:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40265)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKqtd-0007ot-Ll
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600814184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zYOmOo9imBbda8qkO2IraSrwFKE1gwRI/d1nAeUgSyw=;
 b=HGyAxBzkMFJ3YnupS5axc4ykTAH3osBlEigzjmUQT3afmgtPc0P+x2g9clvavQhokR8ZSR
 cmR23LJpNptYJu02dd5WjNktsiqcad7190Qhxd2av3FCoaaF472bRupoBLLlGYFkZXGnFN
 yBRzrDNlCWl0wCb/nU05OvBNVeys/Tw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-m6u-WVRzOamqY5d7gc5sxA-1; Tue, 22 Sep 2020 18:35:52 -0400
X-MC-Unique: m6u-WVRzOamqY5d7gc5sxA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5816186DD27;
 Tue, 22 Sep 2020 22:35:51 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D255760BF4;
 Tue, 22 Sep 2020 22:35:50 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 22/26] qapi/parser.py: add type hint annotations (QAPIDoc)
Date: Tue, 22 Sep 2020 18:35:21 -0400
Message-Id: <20200922223525.4085762-23-jsnow@redhat.com>
In-Reply-To: <20200922223525.4085762-1-jsnow@redhat.com>
References: <20200922223525.4085762-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Annotations do not change runtime behavior.
This commit *only* adds annotations.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/parser.py | 68 +++++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 30 deletions(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index f5f40ffa16..cdb64ffc22 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -23,6 +23,7 @@
     NamedTuple,
     Optional,
     Set,
+    TYPE_CHECKING,
     Type,
     TypeVar,
     Union,
@@ -32,6 +33,10 @@
 from .pragma import PragmaError
 from .source import QAPISourceInfo
 
+if TYPE_CHECKING:
+    # pylint: disable=cyclic-import
+    from .schema import QAPISchemaMember, QAPISchemaFeature
+
 
 _Value = Union[List[object], 'OrderedDict[str, object]', str, bool]
 # Necessary imprecision: mypy does not (yet?) support recursive types;
@@ -405,43 +410,43 @@ class QAPIDoc:
     """
 
     class Section:
-        def __init__(self, name=None):
+        def __init__(self, name: Optional[str] = None):
             # optional section name (argument/member or section name)
             self.name = name
             self.text = ''
 
-        def append(self, line):
+        def append(self, line: str) -> None:
             self.text += line.rstrip() + '\n'
 
     class ArgSection(Section):
-        def __init__(self, name):
+        def __init__(self, name: Optional[str] = None):
             super().__init__(name)
-            self.member = None
+            self.member: Optional['QAPISchemaMember'] = None
 
-        def connect(self, member):
+        def connect(self, member: 'QAPISchemaMember') -> None:
             self.member = member
 
-    def __init__(self, info):
+    def __init__(self, info: QAPISourceInfo):
         self.info = info
-        self.symbol = None
+        self.symbol: Optional[str] = None
         self.body = QAPIDoc.Section()
         # dict mapping parameter name to ArgSection
-        self.args = OrderedDict()
-        self.features = OrderedDict()
+        self.args: 'OrderedDict[str, QAPIDoc.ArgSection]' = OrderedDict()
+        self.features: 'OrderedDict[str, QAPIDoc.ArgSection]' = OrderedDict()
         # a list of Section
-        self.sections = []
+        self.sections: List[QAPIDoc.Section] = []
         # the current section
         self._section = self.body
         self._append_line = self._append_body_line
 
-    def has_section(self, name):
+    def has_section(self, name: str) -> bool:
         """Return True if we have a section with this name."""
         for i in self.sections:
             if i.name == name:
                 return True
         return False
 
-    def append(self, line):
+    def append(self, line: str) -> None:
         """
         Parse a comment line and add it to the documentation.
 
@@ -462,18 +467,18 @@ def append(self, line):
         line = line[1:]
         self._append_line(line)
 
-    def end_comment(self):
+    def end_comment(self) -> None:
         self._end_section()
 
     @classmethod
-    def _is_section_tag(cls, name):
+    def _is_section_tag(cls, name: str) -> bool:
         return name in ('Returns:', 'Since:',
                         # those are often singular or plural
                         'Note:', 'Notes:',
                         'Example:', 'Examples:',
                         'TODO:')
 
-    def _append_body_line(self, line):
+    def _append_body_line(self, line: str) -> None:
         """
         Process a line of documentation text in the body section.
 
@@ -513,7 +518,7 @@ def _append_body_line(self, line):
             # This is a free-form documentation block
             self._append_freeform(line.strip())
 
-    def _append_args_line(self, line):
+    def _append_args_line(self, line: str) -> None:
         """
         Process a line of documentation text in an argument section.
 
@@ -546,7 +551,7 @@ def _append_args_line(self, line):
 
         self._append_freeform(line.strip())
 
-    def _append_features_line(self, line):
+    def _append_features_line(self, line: str) -> None:
         name = line.split(' ', 1)[0]
 
         if name.startswith('@') and name.endswith(':'):
@@ -565,7 +570,7 @@ def _append_features_line(self, line):
 
         self._append_freeform(line.strip())
 
-    def _append_various_line(self, line):
+    def _append_various_line(self, line: str) -> None:
         """
         Process a line of documentation text in an additional section.
 
@@ -591,7 +596,10 @@ def _append_various_line(self, line):
 
         self._append_freeform(line)
 
-    def _start_symbol_section(self, symbols_dict, name):
+    def _start_symbol_section(
+            self,
+            symbols_dict: 'OrderedDict[str, QAPIDoc.ArgSection]',
+            name: str) -> None:
         # FIXME invalid names other than the empty string aren't flagged
         if not name:
             raise QAPIDocError("invalid parameter name")
@@ -602,20 +610,20 @@ def _start_symbol_section(self, symbols_dict, name):
         self._section = QAPIDoc.ArgSection(name)
         symbols_dict[name] = self._section
 
-    def _start_args_section(self, name):
+    def _start_args_section(self, name: str) -> None:
         self._start_symbol_section(self.args, name)
 
-    def _start_features_section(self, name):
+    def _start_features_section(self, name: str) -> None:
         self._start_symbol_section(self.features, name)
 
-    def _start_section(self, name=None):
+    def _start_section(self, name: Optional[str] = None) -> None:
         if name in ('Returns', 'Since') and self.has_section(name):
             raise QAPIDocError("duplicated '%s' section" % name)
         self._end_section()
         self._section = QAPIDoc.Section(name)
         self.sections.append(self._section)
 
-    def _end_section(self):
+    def _end_section(self) -> None:
         if self._section:
             text = self._section.text = self._section.text.strip()
             if self._section.name and (not text or text.isspace()):
@@ -623,34 +631,34 @@ def _end_section(self):
                     "empty doc section '%s'" % self._section.name)
             self._section = None
 
-    def _append_freeform(self, line):
+    def _append_freeform(self, line: str) -> None:
         match = re.match(r'(@\S+:)', line)
         if match:
             raise QAPIDocError("'%s' not allowed in free-form documentation"
                                % match.group(1))
         self._section.append(line)
 
-    def connect_member(self, member):
+    def connect_member(self, member: 'QAPISchemaMember') -> None:
         if member.name not in self.args:
             # Undocumented TODO outlaw
             self.args[member.name] = QAPIDoc.ArgSection(member.name)
         self.args[member.name].connect(member)
 
-    def connect_feature(self, feature):
+    def connect_feature(self, feature: 'QAPISchemaFeature') -> None:
         if feature.name not in self.features:
             raise QAPISemError(feature.info,
                                "feature '%s' lacks documentation"
                                % feature.name)
         self.features[feature.name].connect(feature)
 
-    def check_expr(self, expr):
+    def check_expr(self, expr: 'OrderedDict[str, object]') -> None:
         if self.has_section('Returns') and 'command' not in expr:
             raise QAPISemError(self.info,
                                "'Returns:' is only valid for commands")
 
-    def check(self):
-
-        def check_args_section(args):
+    def check(self) -> None:
+        def check_args_section(
+                args: 'OrderedDict[str, QAPIDoc.ArgSection]') -> None:
             bogus = [name for name, section in args.items()
                      if not section.member]
             if bogus:
-- 
2.26.2



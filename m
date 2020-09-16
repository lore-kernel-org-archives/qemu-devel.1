Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C7FC2BB84
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 18:34:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7431206B5
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 18:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNhhWTXC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7431206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIcFs-0006hE-Ov
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 14:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kIc7m-0007L8-4R
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 14:25:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53381)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kIc7Y-00013L-0T
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 14:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600280728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fGE5Sc5iaPgUs70IknP9LnXQxBsH0ZI0EwXTF12xUKs=;
 b=VNhhWTXClvKhC4dH8wWgt5gZ9iTPtqXCMtoq5qBPfPMOuKAHaL44dmKElHfW3zx5GUlSw/
 o59zS+bmX/w5nB+qbZMEK4q76TsEChrWwenlrxfjGZC8deztpaFZVX46xhij+iBDpCC7AD
 kAYoL98QhW9W0NH4f+vVoWDHzyvGaUw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-OIIc6ujAOwShkPOt5PIiGg-1; Wed, 16 Sep 2020 14:25:24 -0400
X-MC-Unique: OIIc6ujAOwShkPOt5PIiGg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 698F657083
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 18:25:23 +0000 (UTC)
Received: from localhost (ovpn-119-217.rdu2.redhat.com [10.10.119.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5BBA57EB7C;
 Wed, 16 Sep 2020 18:25:22 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/5] scripts/codeconverter: Update to latest version
Date: Wed, 16 Sep 2020 14:25:15 -0400
Message-Id: <20200916182519.415636-2-ehabkost@redhat.com>
In-Reply-To: <20200916182519.415636-1-ehabkost@redhat.com>
References: <20200916182519.415636-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I'm not documenting every single change in the codeconverter
script because most of that code will be deleted once we finish
the QOM code conversion.  This patch updates the script to the
latest version that was used to perform changes in the QOM code.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 .../codeconverter/codeconverter/patching.py   | 193 +++--
 .../codeconverter/codeconverter/qom_macros.py | 327 ++++++--
 .../codeconverter/qom_type_info.py            | 741 +++++++++++++++---
 .../codeconverter/test_patching.py            |   3 +-
 .../codeconverter/test_regexps.py             |  26 +-
 scripts/codeconverter/converter.py            |  12 +-
 6 files changed, 1057 insertions(+), 245 deletions(-)

diff --git a/scripts/codeconverter/codeconverter/patching.py b/scripts/codeconverter/codeconverter/patching.py
index 627a1a1b04..9e92505d39 100644
--- a/scripts/codeconverter/codeconverter/patching.py
+++ b/scripts/codeconverter/codeconverter/patching.py
@@ -5,7 +5,7 @@
 #
 # This work is licensed under the terms of the GNU GPL, version 2.  See
 # the COPYING file in the top-level directory.
-from typing import IO, Match, NamedTuple, Optional, Literal, Iterable, Type, Dict, List, Any, TypeVar, NewType, Tuple
+from typing import IO, Match, NamedTuple, Optional, Literal, Iterable, Type, Dict, List, Any, TypeVar, NewType, Tuple, Union
 from pathlib import Path
 from itertools import chain
 from tempfile import NamedTemporaryFile
@@ -47,7 +47,7 @@ class FileMatch:
 
     def __init__(self, f: 'FileInfo', m: Match) -> None:
         self.file: 'FileInfo' = f
-        self.match: Match = m
+        self.match: Match[str] = m
 
     @property
     def name(self) -> str:
@@ -68,8 +68,13 @@ class FileMatch:
     def line_col(self) -> LineAndColumn:
         return self.file.line_col(self.start())
 
-    def group(self, *args):
-        return self.match.group(*args)
+    def group(self, group: Union[int, str]) -> str:
+        return self.match.group(group)
+
+    def getgroup(self, group: str) -> Optional[str]:
+        if group not in self.match.groupdict():
+            return None
+        return self.match.group(group)
 
     def log(self, level, fmt, *args) -> None:
         pos = self.line_col()
@@ -163,18 +168,51 @@ class FileMatch:
         raise NotImplementedError()
 
     @classmethod
-    def find_matches(klass, content: str) -> Iterable[Match]:
-        """Generate match objects for class
+    def finditer(klass, content: str, pos=0, endpos=-1) -> Iterable[Match]:
+        """Helper for re.finditer()"""
+        if endpos >= 0:
+            content = content[:endpos]
+        return klass.compiled_re().finditer(content, pos)
 
-        Might be reimplemented by subclasses if they
-        intend to look for matches using a different method.
-        """
-        return klass.compiled_re().finditer(content)
+    @classmethod
+    def domatch(klass, content: str, pos=0, endpos=-1) -> Optional[Match]:
+        """Helper for re.match()"""
+        if endpos >= 0:
+            content = content[:endpos]
+        return klass.compiled_re().match(content, pos)
+
+    def group_finditer(self, klass: Type['FileMatch'], group: Union[str, int]) -> Iterable['FileMatch']:
+        assert self.file.original_content
+        return (klass(self.file, m)
+                for m in klass.finditer(self.file.original_content,
+                                        self.match.start(group),
+                                        self.match.end(group)))
+
+    def try_group_match(self, klass: Type['FileMatch'], group: Union[str, int]) -> Optional['FileMatch']:
+        assert self.file.original_content
+        m = klass.domatch(self.file.original_content,
+                          self.match.start(group),
+                          self.match.end(group))
+        if not m:
+            return None
+        else:
+            return klass(self.file, m)
+
+    def group_match(self, group: Union[str, int]) -> 'FileMatch':
+        m = self.try_group_match(FullMatch, group)
+        assert m
+        return m
 
     @property
     def allfiles(self) -> 'FileList':
         return self.file.allfiles
 
+class FullMatch(FileMatch):
+    """Regexp that will match all contents of string
+    Useful when used with group_match()
+    """
+    regexp = r'(?s).*' # (?s) is re.DOTALL
+
 def all_subclasses(c: Type[FileMatch]) -> Iterable[Type[FileMatch]]:
     for sc in c.__subclasses__():
         yield sc
@@ -201,7 +239,15 @@ def apply_patches(s: str, patches: Iterable[Patch]) -> str:
     """
     r = StringIO()
     last = 0
-    for p in sorted(patches):
+    def patch_sort_key(item: Tuple[int, Patch]) -> Tuple[int, int, int]:
+        """Patches are sorted by byte position,
+        patches at the same byte position are applied in the order
+        they were generated.
+        """
+        i,p = item
+        return (p.start, p.end, i)
+
+    for i,p in sorted(enumerate(patches), key=patch_sort_key):
         DBG("Applying patch at position %d (%s) - %d (%s): %r",
             p.start, line_col(s, p.start),
             p.end, line_col(s, p.end),
@@ -220,26 +266,35 @@ class RegexpScanner:
         self.match_index: Dict[Type[Any], List[FileMatch]] = {}
         self.match_name_index: Dict[Tuple[Type[Any], str, str], Optional[FileMatch]] = {}
 
-    def _find_matches(self, klass: Type[Any]) -> Iterable[FileMatch]:
+    def _matches_of_type(self, klass: Type[Any]) -> Iterable[FileMatch]:
         raise NotImplementedError()
 
     def matches_of_type(self, t: Type[T]) -> List[T]:
         if t not in self.match_index:
-            self.match_index[t] = list(self._find_matches(t))
-        return  self.match_index[t] # type: ignore
+            self.match_index[t] = list(self._matches_of_type(t))
+        return self.match_index[t] # type: ignore
 
-    def find_match(self, t: Type[T], name: str, group: str='name') -> Optional[T]:
+    def find_matches(self, t: Type[T], name: str, group: str='name') -> List[T]:
         indexkey = (t, name, group)
         if indexkey in self.match_name_index:
             return self.match_name_index[indexkey] # type: ignore
-        r: Optional[T] = None
+        r: List[T] = []
         for m in self.matches_of_type(t):
             assert isinstance(m, FileMatch)
-            if m.group(group) == name:
-                r = m # type: ignore
+            if m.getgroup(group) == name:
+                r.append(m) # type: ignore
         self.match_name_index[indexkey] = r # type: ignore
         return r
 
+    def find_match(self, t: Type[T], name: str, group: str='name') -> Optional[T]:
+        l = self.find_matches(t, name, group)
+        if not l:
+            return None
+        if len(l) > 1:
+            logger.warn("multiple matches found for %r (%s=%r)", t, group, name)
+            return None
+        return l[0]
+
     def reset_index(self) -> None:
         self.match_index.clear()
         self.match_name_index.clear()
@@ -258,18 +313,22 @@ class FileInfo(RegexpScanner):
     def __repr__(self) -> str:
         return f'<FileInfo {repr(self.filename)}>'
 
+    def filename_matches(self, name: str) -> bool:
+        nameparts = Path(name).parts
+        return self.filename.parts[-len(nameparts):] == nameparts
+
     def line_col(self, start: int) -> LineAndColumn:
         """Return line and column for a match object inside original_content"""
         return line_col(self.original_content, start)
 
-    def _find_matches(self, klass: Type[Any]) -> List[FileMatch]:
+    def _matches_of_type(self, klass: Type[Any]) -> List[FileMatch]:
         """Build FileMatch objects for each match of regexp"""
         if not hasattr(klass, 'regexp') or klass.regexp is None:
             return []
         assert hasattr(klass, 'regexp')
         DBG("%s: scanning for %s", self.filename, klass.__name__)
         DBG("regexp: %s", klass.regexp)
-        matches = [klass(self, m) for m in klass.find_matches(self.original_content)]
+        matches = [klass(self, m) for m in klass.finditer(self.original_content)]
         DBG('%s: %d matches found for %s: %s', self.filename, len(matches),
             klass.__name__,' '.join(names(matches)))
         return matches
@@ -277,7 +336,7 @@ class FileInfo(RegexpScanner):
     def find_match(self, t: Type[T], name: str, group: str='name') -> Optional[T]:
         for m in self.matches_of_type(t):
             assert isinstance(m, FileMatch)
-            if m.group(group) == name:
+            if m.getgroup(group) == name:
                 return m # type: ignore
         return None
 
@@ -299,7 +358,16 @@ class FileInfo(RegexpScanner):
         return (m for l in lists
                   for m in l)
 
-    def scan_for_matches(self, class_names: Optional[List[str]]=None) -> None:
+    def gen_patches(self, matches: List[FileMatch]) -> None:
+        for m in matches:
+            DBG("Generating patches for %r", m)
+            for i,p in enumerate(m.gen_patches()):
+                DBG("patch %d generated by %r:", i, m)
+                DBG("replace contents at %s-%s with %r",
+                    self.line_col(p.start), self.line_col(p.end), p.replacement)
+                self.patches.append(p)
+
+    def scan_for_matches(self, class_names: Optional[List[str]]=None) -> Iterable[FileMatch]:
         DBG("class names: %r", class_names)
         class_dict = match_class_dict()
         if class_names is None:
@@ -309,40 +377,9 @@ class FileInfo(RegexpScanner):
         DBG("class_names: %r", class_names)
         for cn in class_names:
             matches = self.matches_of_type(class_dict[cn])
-            if len(matches) > 0:
-                DBG('%s: %d matches found for %s: %s', self.filename,
-                     len(matches), cn, ' '.join(names(matches)))
-
-    def gen_patches(self) -> None:
-        for m in self.all_matches:
-            for i,p in enumerate(m.gen_patches()):
-                DBG("patch %d generated by %r:", i, m)
-                DBG("replace contents at %s-%s with %r",
-                    self.line_col(p.start), self.line_col(p.end), p.replacement)
-                self.patches.append(p)
-
-    def patch_content(self, max_passes=0, class_names: Optional[List[str]]=None) -> None:
-        """Multi-pass content patching loop
-
-        We run multiple passes because there are rules that will
-        delete init functions once they become empty.
-        """
-        passes = 0
-        total_patches  = 0
-        DBG("max_passes: %r", max_passes)
-        while not max_passes or max_passes <= 0 or passes < max_passes:
-            passes += 1
-            self.scan_for_matches(class_names)
-            self.gen_patches()
-            DBG("patch content: pass %d: %d patches generated", passes, len(self.patches))
-            total_patches += len(self.patches)
-            if not self.patches:
-                break
-            try:
-                self.apply_patches()
-            except PatchingError:
-                logger.exception("%s: failed to patch file", self.filename)
-        DBG("%s: %d patches applied total in %d passes", self.filename, total_patches, passes)
+            DBG('%d matches found for %s: %s',
+                    len(matches), cn, ' '.join(names(matches)))
+            yield from matches
 
     def apply_patches(self) -> None:
         """Replace self.original_content after applying patches from self.patches"""
@@ -384,14 +421,46 @@ class FileList(RegexpScanner):
     def __iter__(self):
         return iter(self.files)
 
-    def _find_matches(self, klass: Type[Any]) -> Iterable[FileMatch]:
-        return chain(*(f._find_matches(klass) for f in self.files))
+    def _matches_of_type(self, klass: Type[Any]) -> Iterable[FileMatch]:
+        return chain(*(f._matches_of_type(klass) for f in self.files))
 
-    def find_file(self, name) -> Optional[FileInfo]:
+    def find_file(self, name: str) -> Optional[FileInfo]:
         """Get file with path ending with @name"""
-        nameparts = Path(name).parts
         for f in self.files:
-            if f.filename.parts[:len(nameparts)] == nameparts:
+            if f.filename_matches(name):
                 return f
         else:
-            return None
\ No newline at end of file
+            return None
+
+    def one_pass(self, class_names: List[str]) -> int:
+        total_patches = 0
+        for f in self.files:
+            INFO("Scanning file %s", f.filename)
+            matches = list(f.scan_for_matches(class_names))
+            INFO("Generating patches for file %s", f.filename)
+            f.gen_patches(matches)
+            total_patches += len(f.patches)
+        if total_patches:
+            for f in self.files:
+                try:
+                    f.apply_patches()
+                except PatchingError:
+                    logger.exception("%s: failed to patch file", f.filename)
+        return total_patches
+
+    def patch_content(self, max_passes, class_names: List[str]) -> None:
+        """Multi-pass content patching loop
+
+        We run multiple passes because there are rules that will
+        delete init functions once they become empty.
+        """
+        passes = 0
+        total_patches  = 0
+        DBG("max_passes: %r", max_passes)
+        while not max_passes or max_passes <= 0 or passes < max_passes:
+            passes += 1
+            INFO("Running pass: %d", passes)
+            count = self.one_pass(class_names)
+            DBG("patch content: pass %d: %d patches generated", passes, count)
+            total_patches += count
+        DBG("%d patches applied total in %d passes", total_patches, passes)
diff --git a/scripts/codeconverter/codeconverter/qom_macros.py b/scripts/codeconverter/codeconverter/qom_macros.py
index 68a33d5c6f..2d2f2055a3 100644
--- a/scripts/codeconverter/codeconverter/qom_macros.py
+++ b/scripts/codeconverter/codeconverter/qom_macros.py
@@ -23,16 +23,24 @@ WARN = logger.warning
 
 RE_CONSTANT = OR(RE_STRING, RE_NUMBER)
 
-class ConstantDefine(FileMatch):
-    """Simple #define preprocessor directive for a constant"""
-    # if the macro contents are very simple, it might be included
-    # in the match group 'value'
+class DefineDirective(FileMatch):
+    """Match any #define directive"""
+    regexp = S(r'^[ \t]*#[ \t]*define', CPP_SPACE, NAMED('name', RE_IDENTIFIER), r'\b')
+
+class ExpressionDefine(FileMatch):
+    """Simple #define preprocessor directive for an expression"""
     regexp = S(r'^[ \t]*#[ \t]*define', CPP_SPACE, NAMED('name', RE_IDENTIFIER),
-               CPP_SPACE, NAMED('value', RE_CONSTANT), r'[ \t]*\n')
+               CPP_SPACE, NAMED('value', RE_EXPRESSION), r'[ \t]*\n')
 
     def provided_identifiers(self) -> Iterable[RequiredIdentifier]:
         yield RequiredIdentifier('constant', self.group('name'))
 
+class ConstantDefine(ExpressionDefine):
+    """Simple #define preprocessor directive for a number or string constant"""
+    regexp = S(r'^[ \t]*#[ \t]*define', CPP_SPACE, NAMED('name', RE_IDENTIFIER),
+               CPP_SPACE, NAMED('value', RE_CONSTANT), r'[ \t]*\n')
+
+
 class TypeIdentifiers(NamedTuple):
     """Type names found in type declarations"""
     # TYPE_MYDEVICE
@@ -236,13 +244,12 @@ class TypeCheckMacro(FileMatch):
     """OBJECT_CHECK/OBJECT_CLASS_CHECK/OBJECT_GET_CLASS macro definitions
     Will be replaced by DECLARE_*_CHECKERS macro
     """
-    #TODO: handle and convert INTERFACE_CHECK macros
     regexp = RE_CHECK_MACRO
 
     @property
     def checker(self) -> CheckerMacroName:
         """Name of checker macro being used"""
-        return self.group('checker')
+        return self.group('checker') # type: ignore
 
     @property
     def typedefname(self) -> Optional[str]:
@@ -330,6 +337,8 @@ class TypeCheckMacro(FileMatch):
                                instancetype=instancetype, uppercase=uppercase)
 
     def gen_patches(self) -> Iterable[Patch]:
+        # the implementation is a bit tricky because we need to group
+        # macros dealing with the same type into a single declaration
         if self.type_identifiers is None:
             self.warn("couldn't extract type information from macro %s", self.name)
             return
@@ -426,10 +435,61 @@ class TypeCheckMacro(FileMatch):
             yield self.prepend("/* FIXME: %s */\n" % (issue))
         yield self.append(new_decl)
 
-class DeclareInstanceChecker(FileMatch):
-    """DECLARE_INSTANCE_CHECKER use
-    Will be replaced with DECLARE_OBJ_CHECKERS if possible
+class InterfaceCheckMacro(FileMatch):
+    """Type checking macro using INTERFACE_CHECK
+    Will be replaced by DECLARE_INTERFACE_CHECKER
     """
+    regexp = S(RE_MACRO_DEFINE,
+               'INTERFACE_CHECK',
+               r'\s*\(\s*', OR(NAMED('instancetype', RE_IDENTIFIER), RE_TYPE, name='c_type'),
+               r'\s*,', CPP_SPACE,
+               OPTIONAL_PARS(RE_IDENTIFIER), r',', CPP_SPACE,
+               NAMED('qom_typename', RE_IDENTIFIER), r'\s*\)\n')
+
+    def required_identifiers(self) -> Iterable[RequiredIdentifier]:
+        yield RequiredIdentifier('include', '"qom/object.h"')
+        yield RequiredIdentifier('type', self.group('instancetype'))
+        yield RequiredIdentifier('constant', self.group('qom_typename'))
+
+    def gen_patches(self) -> Iterable[Patch]:
+        if self.file.filename_matches('qom/object.h'):
+            self.debug("skipping object.h")
+            return
+
+        typename = self.group('qom_typename')
+        uppercase = self.name
+        instancetype = self.group('instancetype')
+        c = f"DECLARE_INTERFACE_CHECKER({instancetype}, {uppercase},\n"+\
+            f"                          {typename})\n"
+        yield self.make_patch(c)
+
+
+class TypeDeclaration(FileMatch):
+    """Parent class to all type declarations"""
+    @property
+    def instancetype(self) -> Optional[str]:
+        return self.getgroup('instancetype')
+
+    @property
+    def classtype(self) -> Optional[str]:
+        return self.getgroup('classtype')
+
+    @property
+    def typename(self) -> Optional[str]:
+        return self.getgroup('typename')
+
+class TypeCheckerDeclaration(TypeDeclaration):
+    """Parent class to all type checker declarations"""
+    @property
+    def typename(self) -> str:
+        return self.group('typename')
+
+    @property
+    def uppercase(self) -> str:
+        return self.group('uppercase')
+
+class DeclareInstanceChecker(TypeCheckerDeclaration):
+    """DECLARE_INSTANCE_CHECKER use"""
     #TODO: replace lonely DECLARE_INSTANCE_CHECKER with DECLARE_OBJ_CHECKERS
     #      if all types are found.
     #      This will require looking up the correct class type in the TypeInfo
@@ -445,8 +505,45 @@ class DeclareInstanceChecker(FileMatch):
         yield RequiredIdentifier('constant', self.group('typename'))
         yield RequiredIdentifier('type', self.group('instancetype'))
 
-class DeclareClassCheckers(FileMatch):
-    """DECLARE_INSTANCE_CHECKER use"""
+class DeclareInterfaceChecker(TypeCheckerDeclaration):
+    """DECLARE_INTERFACE_CHECKER use"""
+    regexp = S(r'^[ \t]*DECLARE_INTERFACE_CHECKER\s*\(\s*',
+               NAMED('instancetype', RE_TYPE), r'\s*,\s*',
+               NAMED('uppercase', RE_IDENTIFIER), r'\s*,\s*',
+               OR(RE_IDENTIFIER, RE_STRING, RE_MACRO_CONCAT, RE_FUN_CALL, name='typename'), SP,
+               r'\)[ \t]*;?[ \t]*\n')
+
+    def required_identifiers(self) -> Iterable[RequiredIdentifier]:
+        yield RequiredIdentifier('include', '"qom/object.h"')
+        yield RequiredIdentifier('constant', self.group('typename'))
+        yield RequiredIdentifier('type', self.group('instancetype'))
+
+class DeclareInstanceType(TypeDeclaration):
+    """DECLARE_INSTANCE_TYPE use"""
+    regexp = S(r'^[ \t]*DECLARE_INSTANCE_TYPE\s*\(\s*',
+               NAMED('uppercase', RE_IDENTIFIER), r'\s*,\s*',
+               NAMED('instancetype', RE_TYPE), SP,
+               r'\)[ \t]*;?[ \t]*\n')
+
+    def required_identifiers(self) -> Iterable[RequiredIdentifier]:
+        yield RequiredIdentifier('include', '"qom/object.h"')
+        yield RequiredIdentifier('type', self.group('instancetype'))
+
+class DeclareClassType(TypeDeclaration):
+    """DECLARE_CLASS_TYPE use"""
+    regexp = S(r'^[ \t]*DECLARE_CLASS_TYPE\s*\(\s*',
+               NAMED('uppercase', RE_IDENTIFIER), r'\s*,\s*',
+               NAMED('classtype', RE_TYPE), SP,
+               r'\)[ \t]*;?[ \t]*\n')
+
+    def required_identifiers(self) -> Iterable[RequiredIdentifier]:
+        yield RequiredIdentifier('include', '"qom/object.h"')
+        yield RequiredIdentifier('type', self.group('classtype'))
+
+
+
+class DeclareClassCheckers(TypeCheckerDeclaration):
+    """DECLARE_CLASS_CHECKER use"""
     regexp = S(r'^[ \t]*DECLARE_CLASS_CHECKERS\s*\(\s*',
                NAMED('classtype', RE_TYPE), r'\s*,\s*',
                NAMED('uppercase', RE_IDENTIFIER), r'\s*,\s*',
@@ -458,10 +555,8 @@ class DeclareClassCheckers(FileMatch):
         yield RequiredIdentifier('constant', self.group('typename'))
         yield RequiredIdentifier('type', self.group('classtype'))
 
-class DeclareObjCheckers(FileMatch):
-    """DECLARE_OBJ_CHECKERS use
-    Will be replaced with OBJECT_DECLARE_TYPE if possible
-    """
+class DeclareObjCheckers(TypeCheckerDeclaration):
+    """DECLARE_OBJ_CHECKERS use"""
     #TODO: detect when OBJECT_DECLARE_SIMPLE_TYPE can be used
     regexp = S(r'^[ \t]*DECLARE_OBJ_CHECKERS\s*\(\s*',
                NAMED('instancetype', RE_TYPE), r'\s*,\s*',
@@ -476,44 +571,121 @@ class DeclareObjCheckers(FileMatch):
         yield RequiredIdentifier('type', self.group('classtype'))
         yield RequiredIdentifier('type', self.group('instancetype'))
 
-    def gen_patches(self):
-        ids = TypeIdentifiers(uppercase=self.group('uppercase'),
-                              typename=self.group('typename'),
-                              classtype=self.group('classtype'),
-                              instancetype=self.group('instancetype'))
-        issues = ids.check_consistency()
-        if issues:
-            for i in issues:
-                self.warn("inconsistent identifiers: %s", i)
+class TypeDeclarationFixup(FileMatch):
+    """Common base class for code that will look at a set of type declarations"""
+    regexp = RE_FILE_BEGIN
+    def gen_patches(self) -> Iterable[Patch]:
+        if self.file.filename_matches('qom/object.h'):
+            self.debug("skipping object.h")
             return
 
-        if self.group('typename') != 'TYPE_'+self.group('uppercase'):
-            self.warn("type %s mismatch with uppercase name %s", ids.typename, ids.uppercase)
-            return
+        # group checkers by uppercase name:
+        decl_types: List[Type[TypeDeclaration]] = [DeclareInstanceChecker, DeclareInstanceType,
+                                                   DeclareClassCheckers, DeclareClassType,
+                                                   DeclareObjCheckers]
+        checker_dict: Dict[str, List[TypeDeclaration]] = {}
+        for t in decl_types:
+            for m in self.file.matches_of_type(t):
+                checker_dict.setdefault(m.group('uppercase'), []).append(m)
+        self.debug("checker_dict: %r", checker_dict)
+        for uppercase,checkers in checker_dict.items():
+            fields = ('instancetype', 'classtype', 'uppercase', 'typename')
+            fvalues = dict((field, set(getattr(m, field) for m in checkers
+                                       if getattr(m, field, None) is not None))
+                            for field in fields)
+            for field,values in fvalues.items():
+                if len(values) > 1:
+                    for c in checkers:
+                        c.warn("%s mismatch (%s)", field, ' '.join(values))
+                    return
 
-        typedefs = [(t,self.file.find_match(SimpleTypedefMatch, t))
-                    for t in (ids.instancetype, ids.classtype)]
-        for t,td in typedefs:
-            if td is None:
-                self.warn("typedef %s not found", t)
-                break
-            if td.start() > self.start():
-                self.warn("typedef %s needs to be move earlier in the file", t)
-                break
-            #HACK: check if typedef is used between its definition and the macro
-            #TODO: check if the only match is inside the "struct { ... }" declaration
-            if re.search(r'\b'+t+r'\b', self.file.original_content[td.end():self.start()]):
-                self.warn("typedef %s can't be moved, it is used before the macro", t)
-                break
-        else:
-            for t,td in typedefs:
-                yield td.make_removal_patch()
+            field_dict = dict((f, v.pop() if v else None) for f,v in fvalues.items())
+            yield from self.gen_patches_for_type(uppercase, checkers, field_dict)
+
+    def find_conflicts(self, uppercase: str, checkers: List[TypeDeclaration]) -> bool:
+        """Look for conflicting declarations that would make it unsafe to add new ones"""
+        conflicting: List[FileMatch] = []
+        # conflicts in the same file:
+        conflicting.extend(chain(self.file.find_matches(DefineDirective, uppercase),
+                                 self.file.find_matches(DeclareInterfaceChecker, uppercase, 'uppercase'),
+                                 self.file.find_matches(DeclareClassType, uppercase, 'uppercase'),
+                                 self.file.find_matches(DeclareInstanceType, uppercase, 'uppercase')))
+
+        # conflicts in another file:
+        conflicting.extend(o for o in chain(self.allfiles.find_matches(DeclareInstanceChecker, uppercase, 'uppercase'),
+                                            self.allfiles.find_matches(DeclareClassCheckers, uppercase, 'uppercase'),
+                                            self.allfiles.find_matches(DeclareInterfaceChecker, uppercase, 'uppercase'),
+                                            self.allfiles.find_matches(DefineDirective, uppercase))
+                           if o is not None and o.file != self.file
+                               # if both are .c files, there's no conflict at all:
+                               and not (o.file.filename.suffix == '.c' and
+                                       self.file.filename.suffix == '.c'))
+
+        if conflicting:
+            for c in checkers:
+                c.warn("skipping due to conflicting %s macro", uppercase)
+            for o in conflicting:
+                if o is None:
+                    continue
+                o.warn("conflicting %s macro is here", uppercase)
+            return True
 
-            lowercase = ids.uppercase.lower()
-            # all is OK, we can replace the macro!
-            c = (f'OBJECT_DECLARE_TYPE({ids.instancetype}, {ids.classtype},\n'
-                 f'                    {lowercase}, {ids.uppercase})\n')
-            yield self.make_patch(c)
+        return False
+
+    def gen_patches_for_type(self, uppercase: str,
+                             checkers: List[TypeDeclaration],
+                             fields: Dict[str, Optional[str]]) -> Iterable[Patch]:
+        """Should be reimplemented by subclasses"""
+        return
+        yield
+
+class DeclareVoidTypes(TypeDeclarationFixup):
+    """Add DECLARE_*_TYPE(..., void) when there's no declared type"""
+    regexp = RE_FILE_BEGIN
+    def gen_patches_for_type(self, uppercase: str,
+                             checkers: List[TypeDeclaration],
+                             fields: Dict[str, Optional[str]]) -> Iterable[Patch]:
+        if self.find_conflicts(uppercase, checkers):
+            return
+
+        #_,last_checker = max((m.start(), m) for m in checkers)
+        _,first_checker = min((m.start(), m) for m in checkers)
+
+        if not any(m.instancetype for m in checkers):
+            yield first_checker.prepend(f'DECLARE_INSTANCE_TYPE({uppercase}, void)\n')
+        if not any(m.classtype for m in checkers):
+            yield first_checker.prepend(f'DECLARE_CLASS_TYPE({uppercase}, void)\n')
+
+        #if not all(len(v) == 1 for v in fvalues.values()):
+        #    return
+        #
+        #final_values = dict((field, values.pop())
+        #                    for field,values in fvalues.items())
+        #s = (f"DECLARE_OBJ_CHECKERS({final_values['instancetype']}, {final_values['classtype']},\n"+
+        #        f"                     {final_values['uppercase']}, {final_values['typename']})\n")
+        #for c in checkers:
+        #    yield c.make_removal_patch()
+        #yield last_checker.append(s)
+
+
+class AddDeclareTypeName(TypeDeclarationFixup):
+    """Add DECLARE_TYPE_NAME declarations if necessary"""
+    def gen_patches_for_type(self, uppercase: str,
+                             checkers: List[TypeDeclaration],
+                             fields: Dict[str, Optional[str]]) -> Iterable[Patch]:
+        typename = fields.get('typename')
+        if typename is None:
+            self.warn("typename unavailable")
+            return
+        if typename == f'TYPE_{uppercase}':
+            self.info("already using TYPE_%s as type name", uppercase)
+            return
+        if self.file.find_match(DeclareTypeName, uppercase, 'uppercase'):
+            self.info("type name for %s already declared", uppercase)
+            return
+        _,first_checker = min((m.start(), m) for m in checkers)
+        s = f'DECLARE_TYPE_NAME({uppercase}, {typename})\n'
+        yield first_checker.prepend(s)
 
 class TrivialClassStruct(FileMatch):
     """Trivial class struct"""
@@ -527,14 +699,13 @@ class DeclareTypeName(FileMatch):
                OR(RE_IDENTIFIER, RE_STRING, RE_MACRO_CONCAT, RE_FUN_CALL, name='typename'),
                r'\s*\);?[ \t]*\n')
 
-class ObjectDeclareType(FileMatch):
+class ObjectDeclareType(TypeCheckerDeclaration):
     """OBJECT_DECLARE_TYPE usage
     Will be replaced with OBJECT_DECLARE_SIMPLE_TYPE if possible
     """
     regexp = S(r'^[ \t]*OBJECT_DECLARE_TYPE\s*\(',
                NAMED('instancetype', RE_TYPE), r'\s*,\s*',
                NAMED('classtype', RE_TYPE), r'\s*,\s*',
-               NAMED('lowercase', RE_IDENTIFIER), r'\s*,\s*',
                NAMED('uppercase', RE_IDENTIFIER), SP,
                r'\)[ \t]*;?[ \t]*\n')
 
@@ -549,14 +720,42 @@ class ObjectDeclareType(FileMatch):
                  "                           %(uppercase)s, %(parent_struct)s)\n" % d)
             yield self.make_patch(c)
 
-def find_type_declaration(files: FileList, typename: str) -> Optional[FileMatch]:
-    """Find usage of DECLARE*CHECKER macro"""
-    for c in (DeclareInstanceChecker, DeclareClassCheckers, DeclareObjCheckers, DeclareTypeName):
-        d = files.find_match(c, name=typename, group='typename')
-        if d:
-            return d
+class ObjectDeclareSimpleType(TypeCheckerDeclaration):
+    """OBJECT_DECLARE_SIMPLE_TYPE usage"""
+    regexp = S(r'^[ \t]*OBJECT_DECLARE_SIMPLE_TYPE\s*\(',
+               NAMED('instancetype', RE_TYPE), r'\s*,\s*',
+               NAMED('uppercase', RE_IDENTIFIER), SP,
+               r'\)[ \t]*;?[ \t]*\n')
+
+class OldStyleObjectDeclareSimpleType(TypeCheckerDeclaration):
+    """OBJECT_DECLARE_SIMPLE_TYPE usage (old API)"""
+    regexp = S(r'^[ \t]*OBJECT_DECLARE_SIMPLE_TYPE\s*\(',
+               NAMED('instancetype', RE_TYPE), r'\s*,\s*',
+               NAMED('lowercase', RE_IDENTIFIER), r'\s*,\s*',
+               NAMED('uppercase', RE_IDENTIFIER), r'\s*,\s*',
+               NAMED('parent_classtype', RE_TYPE), SP,
+               r'\)[ \t]*;?[ \t]*\n')
+
+    @property
+    def classtype(self) -> Optional[str]:
+        instancetype = self.instancetype
+        assert instancetype
+        return f"{instancetype}Class"
+
+def find_typename_uppercase(files: FileList, typename: str) -> Optional[str]:
+    """Try to find what's the right MODULE_OBJ_NAME for a given type name"""
+    decl = files.find_match(DeclareTypeName, name=typename, group='typename')
+    if decl:
+        return decl.group('uppercase')
+    if typename.startswith('TYPE_'):
+        return typename[len('TYPE_'):]
     return None
 
+def find_type_checkers(files:FileList, name:str, group:str='uppercase') -> Iterable[TypeCheckerDeclaration]:
+    """Find usage of DECLARE*CHECKER macro"""
+    c: Type[TypeCheckerDeclaration]
+    for c in (DeclareInstanceChecker, DeclareClassCheckers, DeclareObjCheckers, ObjectDeclareType, ObjectDeclareSimpleType):
+        yield from files.find_matches(c, name=name, group=group)
 
 class Include(FileMatch):
     """#include directive"""
@@ -586,9 +785,13 @@ class MoveSymbols(FileMatch):
     regexp = RE_FILE_BEGIN
 
     def gen_patches(self) -> Iterator[Patch]:
+        if self.file.filename_matches('qom/object.h'):
+            self.debug("skipping object.h")
+            return
+
         index: Dict[RequiredIdentifier, SymbolUserList] = {}
         definition_classes = [SimpleTypedefMatch, FullStructTypedefMatch, ConstantDefine, Include]
-        user_classes = [TypeCheckMacro, DeclareObjCheckers, DeclareInstanceChecker, DeclareClassCheckers]
+        user_classes = [TypeCheckMacro, DeclareObjCheckers, DeclareInstanceChecker, DeclareClassCheckers, InterfaceCheckMacro]
 
         # first we scan for all symbol definitions and usage:
         for dc in definition_classes:
@@ -650,3 +853,9 @@ class MoveSymbols(FileMatch):
                 definition.warn("definition of %s %s needs to be moved earlier in the file", i.type, i.name)
                 earliest.warn("definition of %s %s is used here", i.type, i.name)
 
+
+class EmptyPreprocessorConditional(FileMatch):
+    """Delete empty preprocessor conditionals"""
+    regexp = r'^[ \t]*#(if|ifdef)[ \t].*\n+[ \t]*#endif[ \t]*\n'
+    def gen_patches(self) -> Iterable[Patch]:
+        yield self.make_removal_patch()
diff --git a/scripts/codeconverter/codeconverter/qom_type_info.py b/scripts/codeconverter/codeconverter/qom_type_info.py
index fc02058739..255cb59923 100644
--- a/scripts/codeconverter/codeconverter/qom_type_info.py
+++ b/scripts/codeconverter/codeconverter/qom_type_info.py
@@ -24,11 +24,6 @@ RE_TI_FIELDS = M(RE_TI_FIELD_INIT)
 
 RE_TYPEINFO_START = S(r'^[ \t]*', M(r'(static|const)\s+', name='modifiers'), r'TypeInfo\s+',
                       NAMED('name', RE_IDENTIFIER), r'\s*=\s*{[ \t]*\n')
-RE_TYPEINFO_DEF = S(RE_TYPEINFO_START,
-                    M(NAMED('fields', RE_TI_FIELDS),
-                      SP, NAMED('endcomments', RE_COMMENTS),
-                      r'};?\n',
-                      n='?', name='fullspec'))
 
 ParsedArray = List[str]
 ParsedInitializerValue = Union[str, ParsedArray]
@@ -36,26 +31,55 @@ class InitializerValue(NamedTuple):
     raw: str
     parsed: Optional[ParsedInitializerValue]
     match: Optional[Match]
-TypeInfoInitializers = Dict[str, InitializerValue]
-
-def parse_array(m: Match) -> ParsedArray:
-    #DBG('parse_array: %r', m.group(0))
-    return [m.group('arrayitem') for m in re.finditer(RE_ARRAY_ITEM, m.group('arrayitems'))]
-
-def parse_initializer_value(m: Match, s: str) -> InitializerValue:
-    parsed: Optional[ParsedInitializerValue] = None
-    #DBG("parse_initializer_value: %r", s)
-    array = re.match(RE_ARRAY, s)
-    if array:
-        parsed = parse_array(array)
-    return InitializerValue(s, parsed, m)
-
-class TypeInfoVar(FileMatch):
-    """TypeInfo variable declaration with initializer
-    Will be replaced by OBJECT_DEFINE_TYPE_EXTENDED macro
-    (not implemented yet)
+
+class ArrayItem(FileMatch):
+    regexp = RE_ARRAY_ITEM
+
+class ArrayInitializer(FileMatch):
+    regexp = RE_ARRAY
+
+    def parsed(self) -> ParsedArray:
+        #DBG('parse_array: %r', m.group(0))
+        return [m.group('arrayitem') for m in self.group_finditer(ArrayItem, 'arrayitems')]
+
+class FieldInitializer(FileMatch):
+    regexp = RE_TI_FIELD_INIT
+
+    @property
+    def raw(self) -> str:
+        return self.group('value')
+
+    @property
+    def parsed(self) -> ParsedInitializerValue:
+        parsed: ParsedInitializerValue = self.raw
+        #DBG("parse_initializer_value: %r", s)
+        array = self.try_group_match(ArrayInitializer, 'value')
+        if array:
+            assert isinstance(array, ArrayInitializer)
+            return array.parsed()
+        return parsed
+
+TypeInfoInitializers = Dict[str, FieldInitializer]
+
+class TypeDefinition(FileMatch):
+    """
+    Common base class for type definitions (TypeInfo variables or OBJECT_DEFINE* macros)
     """
-    regexp = RE_TYPEINFO_DEF
+    @property
+    def instancetype(self) -> Optional[str]:
+        return self.group('instancetype')
+
+    @property
+    def classtype(self) -> Optional[str]:
+        return self.group('classtype')
+
+    @property
+    def uppercase(self) -> Optional[str]:
+        return self.group('uppercase')
+
+    @property
+    def parent_uppercase(self) -> str:
+        return self.group('parent_uppercase')
 
     @property
     def initializers(self) -> Optional[TypeInfoInitializers]:
@@ -65,14 +89,26 @@ class TypeInfoVar(FileMatch):
         fields = self.group('fields')
         if fields is None:
             return None
-        d = dict((fm.group('field'), parse_initializer_value(fm, fm.group('value')))
-                  for fm in re.finditer(RE_TI_FIELD_INIT, fields))
-        self._initializers = d
-        return d
+        d = dict((fm.group('field'), fm)
+                  for fm in self.group_finditer(FieldInitializer, 'fields'))
+        self._initializers = d # type: ignore
+        return self._initializers
+
+
+class TypeInfoVar(TypeDefinition):
+    """TypeInfo variable declaration with initializer"""
+    regexp = S(NAMED('begin', RE_TYPEINFO_START),
+               M(NAMED('fields', RE_TI_FIELDS),
+                 NAMED('endcomments', SP, RE_COMMENTS),
+                 NAMED('end', r'};?\n'),
+                 n='?', name='fullspec'))
 
     def is_static(self) -> bool:
         return 'static' in self.group('modifiers')
 
+    def is_const(self) -> bool:
+        return 'const' in self.group('modifiers')
+
     def is_full(self) -> bool:
         return bool(self.group('fullspec'))
 
@@ -82,8 +118,46 @@ class TypeInfoVar(FileMatch):
             return {}
         return self.initializers
 
-    def get_initializer_value(self, field: str) -> InitializerValue:
-        return self.get_initializers().get(field, InitializerValue('', '', None))
+    def get_raw_initializer_value(self, field: str, default: str = '') -> str:
+        initializers = self.get_initializers()
+        if field in initializers:
+            return initializers[field].raw
+        else:
+            return default
+
+    @property
+    def typename(self) -> Optional[str]:
+        return self.get_raw_initializer_value('name')
+
+    @property
+    def uppercase(self) -> Optional[str]:
+        typename = self.typename
+        if not typename:
+            return None
+        if not typename.startswith('TYPE_'):
+            return None
+        return typename[len('TYPE_'):]
+
+    @property
+    def classtype(self) -> Optional[str]:
+        class_size = self.get_raw_initializer_value('class_size')
+        if not class_size:
+            return None
+        m = re.fullmatch(RE_SIZEOF, class_size)
+        if not m:
+            return None
+        return m.group('sizeoftype')
+
+    @property
+    def instancetype(self) -> Optional[str]:
+        instance_size = self.get_raw_initializer_value('instance_size')
+        if not instance_size:
+            return None
+        m = re.fullmatch(RE_SIZEOF, instance_size)
+        if not m:
+            return None
+        return m.group('sizeoftype')
+
 
     #def extract_identifiers(self) -> Optional[TypeIdentifiers]:
     #    """Try to extract identifiers from names being used"""
@@ -116,32 +190,105 @@ class TypeInfoVar(FileMatch):
         #                       uppercase=uppercase, lowercase=lowercase,
         #                       instancetype=instancetype, classtype=classtype)
 
-    def append_field(self, field, value) -> Patch:
+    def append_field(self, field: str, value: str) -> Patch:
         """Generate patch appending a field initializer"""
         content = f'    .{field} = {value},\n'
-        return Patch(self.match.end('fields'), self.match.end('fields'),
-                     content)
+        fm = self.group_match('fields')
+        assert fm
+        return fm.append(content)
 
     def patch_field(self, field: str, replacement: str) -> Patch:
         """Generate patch replacing a field initializer"""
-        values = self.initializers
-        assert values
-        value = values.get(field)
+        initializers = self.initializers
+        assert initializers
+        value = initializers.get(field)
         assert value
-        fm = value.match
-        assert fm
-        fstart = self.match.start('fields') + fm.start()
-        fend = self.match.start('fields') + fm.end()
-        return Patch(fstart, fend, replacement)
+        return value.make_patch(replacement)
+
+    def remove_field(self, field: str) -> Iterable[Patch]:
+        initializers = self.initializers
+        assert initializers
+        if field in initializers:
+            yield self.patch_field(field, '')
+
+    def remove_fields(self, *fields: str) -> Iterable[Patch]:
+        for f in fields:
+            yield from self.remove_field(f)
+
+    def patch_field_value(self, field: str, replacement: str) -> Patch:
+        """Replace just the value of a field initializer"""
+        initializers = self.initializers
+        assert initializers
+        value = initializers.get(field)
+        assert value
+        vm = value.group_match('value')
+        assert vm
+        return vm.make_patch(replacement)
+
+
+class RemoveRedundantClassSize(TypeInfoVar):
+    """Remove class_size when using OBJECT_DECLARE_SIMPLE_TYPE"""
+    def gen_patches(self) -> Iterable[Patch]:
+        initializers = self.initializers
+        if initializers is None:
+            return
+        if 'class_size' not in initializers:
+            return
+
+        self.debug("Handling %s", self.name)
+        m = re.fullmatch(RE_SIZEOF, initializers['class_size'].raw)
+        if not m:
+            self.warn("%s class_size is not sizeof?", self.name)
+            return
+        classtype = m.group('sizeoftype')
+        if not classtype.endswith('Class'):
+            self.warn("%s class size type (%s) is not *Class?", self.name, classtype)
+            return
+        self.debug("classtype is %s", classtype)
+        instancetype = classtype[:-len('Class')]
+        self.debug("intanceypte is %s", instancetype)
+        self.debug("searching for simpletype declaration using %s as InstanceType", instancetype)
+        decl = self.allfiles.find_match(OldStyleObjectDeclareSimpleType,
+                                        instancetype, 'instancetype')
+        if not decl:
+            self.debug("No simpletype declaration found for %s", instancetype)
+            return
+        self.debug("Found simple type declaration")
+        decl.debug("declaration is here")
+        yield from self.remove_field('class_size')
 
+class RemoveDeclareSimpleTypeArg(OldStyleObjectDeclareSimpleType):
+    """Remove class_size when using OBJECT_DECLARE_SIMPLE_TYPE"""
     def gen_patches(self) -> Iterable[Patch]:
+        c = (f'OBJECT_DECLARE_SIMPLE_TYPE({self.group("instancetype")}, {self.group("lowercase")},\n'
+             f'                           {self.group("uppercase")})\n')
+        yield self.make_patch(c)
+
+class UseDeclareTypeExtended(TypeInfoVar):
+    """Replace TypeInfo variable with OBJECT_DEFINE_TYPE_EXTENDED"""
+    def gen_patches(self) -> Iterable[Patch]:
+        # this will just ensure the caches for find_match() and matches_for_type()
+        # will be loaded in advance:
+        find_type_checkers(self.allfiles, 'xxxxxxxxxxxxxxxxx')
+
+        if not self.is_static():
+            self.info("Skipping non-static TypeInfo variable")
+            return
+
+        type_info_macro = self.file.find_match(TypeInfoMacro, self.name)
+        if not type_info_macro:
+            self.warn("TYPE_INFO(%s) line not found", self.name)
+            return
+
         values = self.initializers
         if values is None:
             return
         if 'name' not in values:
             self.warn("name not set in TypeInfo variable %s", self.name)
             return
+
         typename = values['name'].raw
+
         if 'parent' not in values:
             self.warn("parent not set in TypeInfo variable %s", self.name)
             return
@@ -167,49 +314,403 @@ class TypeInfoVar(FileMatch):
                 self.warn("class_size is set to: %r", values['class_size'].raw)
                 return
 
-        #NOTE: this will NOT work after declarations are converted
-        #      to OBJECT_DECLARE*
+        #for t in (typename, parent_typename):
+        #    if not re.fullmatch(RE_IDENTIFIER, t):
+        #        self.info("type name is not a macro/constant")
+        #        if instancetype or classtype:
+        #            self.warn("macro/constant type name is required for instance/class type")
+        #        if not self.file.force:
+        #            return
 
         # Now, the challenge is to find out the right MODULE_OBJ_NAME for the
         # type and for the parent type
-        instance_decl = find_type_declaration(self.allfiles, typename)
-        parent_decl = find_type_declaration(self.allfiles, parent_typename)
-
         self.info("TypeInfo variable for %s is here", typename)
-        if instance_decl:
-            instance_decl.info("instance type declaration (%s) is here", instance_decl.match.group('uppercase'))
-        if parent_decl:
-            parent_decl.info("parent type declaration (%s) is here", parent_decl.match.group('uppercase'))
+        uppercase = find_typename_uppercase(self.allfiles, typename)
+        if not uppercase:
+            self.info("Can't find right uppercase name for %s", typename)
+            if instancetype or classtype:
+                self.warn("Can't find right uppercase name for %s", typename)
+                self.warn("This will make type validation difficult in the future")
+            return
 
-        ok = True
-        if (instance_decl is None and (instancetype or classtype)):
-            self.warn("Can't find where type checkers for %s are declared.  We need them to validate sizes of %s", typename, self.name)
-            ok = False
-
-        if (instance_decl is not None
-            and 'instancetype' in instance_decl.match.groupdict()
-            and instancetype != instance_decl.group('instancetype')):
-            self.warn("type at instance_size is %r.  Should instance_size be set to sizeof(%s) ?",
-                      instancetype, instance_decl.group('instancetype'))
-            instance_decl.warn("Type checker declaration for %s is here", typename)
-            ok = False
-        if (instance_decl is not None
-            and 'classtype' in instance_decl.match.groupdict()
-            and classtype != instance_decl.group('classtype')):
-            self.warn("type at class_size is %r.  Should class_size be set to sizeof(%s) ?",
-                      classtype, instance_decl.group('classtype'))
-            instance_decl.warn("Type checker declaration for %s is here", typename)
-            ok = False
-
-        if not ok:
+        parent_uppercase = find_typename_uppercase(self.allfiles, parent_typename)
+        if not parent_uppercase:
+            self.info("Can't find right uppercase name for parent type (%s)", parent_typename)
+            if instancetype or classtype:
+                self.warn("Can't find right uppercase name for parent type (%s)", parent_typename)
+                self.warn("This will make type validation difficult in the future")
             return
 
+        ok = True
+
+        #checkers: List[TypeCheckerDeclaration] = list(find_type_checkers(self.allfiles, uppercase))
+        #for c in checkers:
+        #    c.info("instance type checker declaration (%s) is here", c.group('uppercase'))
+        #if not checkers:
+        #    self.info("No type checkers declared for %s", uppercase)
+        #    if instancetype or classtype:
+        #        self.warn("Can't find where type checkers for %s (%s) are declared.  We will need them to validate sizes of %s",
+        #                  typename, uppercase, self.name)
+
+        if not instancetype:
+            instancetype = 'void'
+        if not classtype:
+            classtype = 'void'
+
+        #checker_instancetypes = set(c.instancetype for c in checkers
+        #                            if c.instancetype is not None)
+        #if len(checker_instancetypes) > 1:
+        #    self.warn("ambiguous set of type checkers")
+        #    for c in checkers:
+        #        c.warn("instancetype is %s here", c.instancetype)
+        #    ok = False
+        #elif len(checker_instancetypes) == 1:
+        #    checker_instancetype = checker_instancetypes.pop()
+        #    DBG("checker instance type: %r", checker_instancetype)
+        #    if instancetype != checker_instancetype:
+        #        self.warn("type at instance_size is %r.  Should instance_size be set to sizeof(%s) ?",
+        #                instancetype, checker_instancetype)
+        #        ok = False
+        #else:
+        #    if instancetype != 'void':
+        #        self.warn("instance type checker for %s (%s) not found", typename, instancetype)
+        #        ok = False
+
+        #checker_classtypes = set(c.classtype for c in checkers
+        #                         if c.classtype is not None)
+        #if len(checker_classtypes) > 1:
+        #    self.warn("ambiguous set of type checkers")
+        #    for c in checkers:
+        #        c.warn("classtype is %s here", c.classtype)
+        #    ok = False
+        #elif len(checker_classtypes) == 1:
+        #    checker_classtype = checker_classtypes.pop()
+        #    DBG("checker class type: %r", checker_classtype)
+        #    if classtype != checker_classtype:
+        #        self.warn("type at class_size is %r.  Should class_size be set to sizeof(%s) ?",
+        #                classtype, checker_classtype)
+        #        ok = False
+        #else:
+        #    if classtype != 'void':
+        #        self.warn("class type checker for %s (%s) not found", typename, classtype)
+        #        ok = False
+
+        #if not ok:
+        #    for c in checkers:
+        #        c.warn("Type checker declaration for %s (%s) is here",
+        #                           typename, type(c).__name__)
+        #    return
+
         #if parent_decl is None:
         #    self.warn("Can't find where parent type %s is declared", parent_typename)
 
+        #yield self.prepend(f'DECLARE_TYPE_NAME({uppercase}, {typename})\n')
+        #if not instancetype:
+        #    yield self.prepend(f'DECLARE_INSTANCE_TYPE({uppercase}, void)\n')
+        #if not classtype:
+        #    yield self.prepend(f'DECLARE_CLASS_TYPE({uppercase}, void)\n')
         self.info("%s can be patched!", self.name)
-        return
-        yield
+        replaced_fields = ['name', 'parent', 'instance_size', 'class_size']
+        begin = self.group_match('begin')
+        newbegin =  f'OBJECT_DEFINE_TYPE_EXTENDED({self.name},\n'
+        newbegin += f'                            {instancetype}, {classtype},\n'
+        newbegin += f'                            {uppercase}, {parent_uppercase}'
+        if set(values.keys()) - set(replaced_fields):
+            newbegin += ',\n'
+        yield begin.make_patch(newbegin)
+        yield from self.remove_fields(*replaced_fields)
+        end = self.group_match('end')
+        yield end.make_patch(')\n')
+        yield type_info_macro.make_removal_patch()
+
+class ObjectDefineTypeExtended(TypeDefinition):
+    """OBJECT_DEFINE_TYPE_EXTENDED usage"""
+    regexp = S(r'^[ \t]*OBJECT_DEFINE_TYPE_EXTENDED\s*\(\s*',
+               NAMED('name', RE_IDENTIFIER), r'\s*,\s*',
+               NAMED('instancetype', RE_IDENTIFIER), r'\s*,\s*',
+               NAMED('classtype', RE_IDENTIFIER), r'\s*,\s*',
+               NAMED('uppercase', RE_IDENTIFIER), r'\s*,\s*',
+               NAMED('parent_uppercase', RE_IDENTIFIER),
+               M(r',\s*\n',
+                 NAMED('fields', RE_TI_FIELDS),
+                 n='?'),
+               r'\s*\);?\n?')
+
+class ObjectDefineType(TypeDefinition):
+    """OBJECT_DEFINE_TYPE usage"""
+    regexp = S(r'^[ \t]*OBJECT_DEFINE_TYPE\s*\(\s*',
+               NAMED('lowercase', RE_IDENTIFIER), r'\s*,\s*',
+               NAMED('uppercase', RE_IDENTIFIER), r'\s*,\s*',
+               NAMED('parent_uppercase', RE_IDENTIFIER),
+               M(r',\s*\n',
+                 NAMED('fields', RE_TI_FIELDS),
+                 n='?'),
+               r'\s*\);?\n?')
+
+def find_type_definitions(files: FileList, uppercase: str) -> Iterable[TypeDefinition]:
+    types: List[Type[TypeDefinition]] = [TypeInfoVar, ObjectDefineType, ObjectDefineTypeExtended]
+    for t in types:
+        for m in files.matches_of_type(t):
+            m.debug("uppercase: %s", m.uppercase)
+    yield from (m for t in types
+                  for m in files.matches_of_type(t)
+                if m.uppercase == uppercase)
+
+class AddDeclareVoidClassType(TypeDeclarationFixup):
+    """Will add DECLARE_CLASS_TYPE(..., void) if possible"""
+    def gen_patches_for_type(self, uppercase: str,
+                             checkers: List[TypeDeclaration],
+                             fields: Dict[str, Optional[str]]) -> Iterable[Patch]:
+        defs = list(find_type_definitions(self.allfiles, uppercase))
+        if len(defs) > 1:
+            self.warn("multiple definitions for %s", uppercase)
+            for d in defs:
+                d.warn("definition found here")
+            return
+        elif len(defs) == 0:
+            self.warn("type definition for %s not found", uppercase)
+            return
+        d = defs[0]
+        if d.classtype is None:
+            d.info("definition for %s has classtype, skipping", uppercase)
+            return
+        class_type_checkers = [c for c in checkers
+                               if c.classtype is not None]
+        if class_type_checkers:
+            for c in class_type_checkers:
+                c.warn("class type checker for %s is present here", uppercase)
+            return
+
+        _,last_checker = max((m.start(), m) for m in checkers)
+        s = f'DECLARE_CLASS_TYPE({uppercase}, void)\n'
+        yield last_checker.append(s)
+
+class AddDeclareVoidInstanceType(FileMatch):
+    """Will add DECLARE_INSTANCE_TYPE(..., void) if possible"""
+    regexp = S(r'^[ \t]*#[ \t]*define', CPP_SPACE,
+               NAMED('name', r'TYPE_[a-zA-Z0-9_]+\b'),
+               CPP_SPACE, r'.*\n')
+
+    def gen_patches(self) -> Iterable[Patch]:
+        assert self.name.startswith('TYPE_')
+        uppercase = self.name[len('TYPE_'):]
+        defs = list(find_type_definitions(self.allfiles, uppercase))
+        if len(defs) > 1:
+            self.warn("multiple definitions for %s", uppercase)
+            for d in defs:
+                d.warn("definition found here")
+            return
+        elif len(defs) == 0:
+            self.warn("type definition for %s not found", uppercase)
+            return
+        d = defs[0]
+        instancetype = d.instancetype
+        if instancetype is not None and instancetype != 'void':
+            return
+
+        instance_checkers = [c for c in find_type_checkers(self.allfiles, uppercase)
+                             if c.instancetype]
+        if instance_checkers:
+            d.warn("instance type checker for %s already declared", uppercase)
+            for c in instance_checkers:
+                c.warn("instance checker for %s is here", uppercase)
+            return
+
+        s = f'DECLARE_INSTANCE_TYPE({uppercase}, void)\n'
+        yield self.append(s)
+
+class AddObjectDeclareType(DeclareObjCheckers):
+    """Will add OBJECT_DECLARE_TYPE(...) if possible"""
+    def gen_patches(self) -> Iterable[Patch]:
+        uppercase = self.uppercase
+        typename = self.group('typename')
+        instancetype = self.group('instancetype')
+        classtype = self.group('classtype')
+
+        if typename != f'TYPE_{uppercase}':
+            self.warn("type name mismatch: %s vs %s", typename, uppercase)
+            return
+
+        typedefs = [(t,self.allfiles.find_matches(SimpleTypedefMatch, t))
+                    for t in (instancetype, classtype)]
+        for t,tds in typedefs:
+            if not tds:
+                self.warn("typedef %s not found", t)
+                return
+            for td in tds:
+                td_type = td.group('typedef_type')
+                if td_type != f'struct {t}':
+                    self.warn("typedef mismatch: %s is defined as %s", t, td_type)
+                    td.warn("typedef is here")
+                    return
+
+        # look for reuse of same struct type
+        other_instance_checkers = [c for c in find_type_checkers(self.allfiles, instancetype, 'instancetype')
+                                if c.uppercase != uppercase]
+        if other_instance_checkers:
+            self.warn("typedef %s is being reused", instancetype)
+            for ic in other_instance_checkers:
+                ic.warn("%s is reused here", instancetype)
+            if not self.file.force:
+                return
+
+        decl_types: List[Type[TypeDeclaration]] = [DeclareClassCheckers, DeclareObjCheckers]
+        class_decls = [m for t in decl_types
+                       for m in self.allfiles.find_matches(t, uppercase, 'uppercase')]
+
+        defs = list(find_type_definitions(self.allfiles, uppercase))
+        if len(defs) > 1:
+            self.warn("multiple definitions for %s", uppercase)
+            for d in defs:
+                d.warn("definition found here")
+            if not self.file.force:
+                return
+        elif len(defs) == 0:
+            self.warn("type definition for %s not found", uppercase)
+            if not self.file.force:
+                return
+        else:
+            d = defs[0]
+            if d.instancetype != instancetype:
+                self.warn("mismatching instance type for %s (%s)", uppercase, instancetype)
+                d.warn("instance type declared here (%s)", d.instancetype)
+                if not self.file.force:
+                    return
+            if d.classtype != classtype:
+                self.warn("mismatching class type for %s (%s)", uppercase, classtype)
+                d.warn("class type declared here (%s)", d.classtype)
+                if not self.file.force:
+                    return
+
+        assert self.file.original_content
+        for t,tds in typedefs:
+            assert tds
+            for td in tds:
+                if td.file is not self.file:
+                    continue
+
+                # delete typedefs that are truly redundant:
+                # 1) defined after DECLARE_OBJ_CHECKERS
+                if td.start() > self.start():
+                    yield td.make_removal_patch()
+                # 2) defined before DECLARE_OBJ_CHECKERS, but unused
+                elif not re.search(r'\b'+t+r'\b', self.file.original_content[td.end():self.start()]):
+                    yield td.make_removal_patch()
+
+        c = (f'OBJECT_DECLARE_TYPE({instancetype}, {classtype}, {uppercase})\n')
+        yield self.make_patch(c)
+
+class AddObjectDeclareSimpleType(DeclareInstanceChecker):
+    """Will add OBJECT_DECLARE_SIMPLE_TYPE(...) if possible"""
+    def gen_patches(self) -> Iterable[Patch]:
+        uppercase = self.uppercase
+        typename = self.group('typename')
+        instancetype = self.group('instancetype')
+
+        if typename != f'TYPE_{uppercase}':
+            self.warn("type name mismatch: %s vs %s", typename, uppercase)
+            return
+
+        typedefs = [(t,self.allfiles.find_matches(SimpleTypedefMatch, t))
+                    for t in (instancetype,)]
+        for t,tds in typedefs:
+            if not tds:
+                self.warn("typedef %s not found", t)
+                return
+            for td in tds:
+                td_type = td.group('typedef_type')
+                if td_type != f'struct {t}':
+                    self.warn("typedef mismatch: %s is defined as %s", t, td_type)
+                    td.warn("typedef is here")
+                    return
+
+        # look for reuse of same struct type
+        other_instance_checkers = [c for c in find_type_checkers(self.allfiles, instancetype, 'instancetype')
+                                if c.uppercase != uppercase]
+        if other_instance_checkers:
+            self.warn("typedef %s is being reused", instancetype)
+            for ic in other_instance_checkers:
+                ic.warn("%s is reused here", instancetype)
+            if not self.file.force:
+                return
+
+        decl_types: List[Type[TypeDeclaration]] = [DeclareClassCheckers, DeclareObjCheckers]
+        class_decls = [m for t in decl_types
+                       for m in self.allfiles.find_matches(t, uppercase, 'uppercase')]
+        if class_decls:
+            self.warn("class type declared for %s", uppercase)
+            for cd in class_decls:
+                cd.warn("class declaration found here")
+            return
+
+        defs = list(find_type_definitions(self.allfiles, uppercase))
+        if len(defs) > 1:
+            self.warn("multiple definitions for %s", uppercase)
+            for d in defs:
+                d.warn("definition found here")
+            if not self.file.force:
+                return
+        elif len(defs) == 0:
+            self.warn("type definition for %s not found", uppercase)
+            if not self.file.force:
+                return
+        else:
+            d = defs[0]
+            if d.instancetype != instancetype:
+                self.warn("mismatching instance type for %s (%s)", uppercase, instancetype)
+                d.warn("instance type declared here (%s)", d.instancetype)
+                if not self.file.force:
+                    return
+            if d.classtype:
+                self.warn("class type set for %s", uppercase)
+                d.warn("class type declared here")
+                if not self.file.force:
+                    return
+
+        assert self.file.original_content
+        for t,tds in typedefs:
+            assert tds
+            for td in tds:
+                if td.file is not self.file:
+                    continue
+
+                # delete typedefs that are truly redundant:
+                # 1) defined after DECLARE_OBJ_CHECKERS
+                if td.start() > self.start():
+                    yield td.make_removal_patch()
+                # 2) defined before DECLARE_OBJ_CHECKERS, but unused
+                elif not re.search(r'\b'+t+r'\b', self.file.original_content[td.end():self.start()]):
+                    yield td.make_removal_patch()
+
+        c = (f'OBJECT_DECLARE_SIMPLE_TYPE({instancetype}, {uppercase})\n')
+        yield self.make_patch(c)
+
+
+class TypeInfoStringName(TypeInfoVar):
+    """Replace hardcoded type names with TYPE_ constant"""
+    def gen_patches(self) -> Iterable[Patch]:
+        values = self.initializers
+        if values is None:
+            return
+        if 'name' not in values:
+            self.warn("name not set in TypeInfo variable %s", self.name)
+            return
+        typename = values['name'].raw
+        if re.fullmatch(RE_IDENTIFIER, typename):
+            return
+
+        self.warn("name %s is not an identifier", typename)
+        #all_defines = [m for m in self.allfiles.matches_of_type(ExpressionDefine)]
+        #self.debug("all_defines: %r", all_defines)
+        constants = [m for m in self.allfiles.matches_of_type(ExpressionDefine)
+                     if m.group('value').strip() == typename.strip()]
+        if not constants:
+            self.warn("No macro for %s found", typename)
+            return
+        if len(constants) > 1:
+            self.warn("I don't know which macro to use: %r", constants)
+            return
+        yield self.patch_field_value('name', constants[0].name)
 
 class RedundantTypeSizes(TypeInfoVar):
     """Remove redundant instance_size/class_size from TypeInfo vars"""
@@ -230,8 +731,8 @@ class RedundantTypeSizes(TypeInfoVar):
             self.debug("no need to validate %s", self.name)
             return
 
-        instance_decl = find_type_declaration(self.allfiles, typename)
-        if instance_decl:
+        instance_decls = find_type_checkers(self.allfiles, typename)
+        if instance_decls:
             self.debug("won't touch TypeInfo var that has type checkers")
             return
 
@@ -240,12 +741,12 @@ class RedundantTypeSizes(TypeInfoVar):
             self.warn("Can't find TypeInfo for %s", parent_typename)
             return
 
-        if 'instance_size' in values and parent.get_initializer_value('instance_size').raw != values['instance_size'].raw:
+        if 'instance_size' in values and parent.get_raw_initializer_value('instance_size') != values['instance_size'].raw:
             self.info("instance_size mismatch")
             parent.info("parent type declared here")
             return
 
-        if 'class_size' in values and parent.get_initializer_value('class_size').raw != values['class_size'].raw:
+        if 'class_size' in values and parent.get_raw_initializer_value('class_size') != values['class_size'].raw:
             self.info("class_size mismatch")
             parent.info("parent type declared here")
             return
@@ -303,10 +804,11 @@ class RedundantTypeSizes(TypeInfoVar):
 #                yield self.append_field('class_init', ids.lowercase+'_class_init')
 
 class TypeInitMacro(FileMatch):
-    """type_init(...) macro use
-    Will be deleted if function is empty
-    """
+    """Use of type_init(...) macro"""
     regexp = S(r'^[ \t]*type_init\s*\(\s*', NAMED('name', RE_IDENTIFIER), r'\s*\);?[ \t]*\n')
+
+class DeleteEmptyTypeInitFunc(TypeInitMacro):
+    """Delete empty function declared using type_init(...)"""
     def gen_patches(self) -> Iterable[Patch]:
         fn = self.file.find_match(StaticVoidFunction, self.name)
         DBG("function for %s: %s", self.name, fn)
@@ -331,7 +833,7 @@ class StaticVoidFunction(FileMatch):
                         r'#[^\n]*\n',
                         r'\n',
                         repeat='*')),
-               r'}\n')
+               r'};?\n')
 
     @property
     def body(self) -> str:
@@ -340,34 +842,40 @@ class StaticVoidFunction(FileMatch):
     def has_preprocessor_directive(self) -> bool:
         return bool(re.search(r'^[ \t]*#', self.body, re.MULTILINE))
 
-class TypeRegisterCall(FileMatch):
+def find_containing_func(m: FileMatch) -> Optional['StaticVoidFunction']:
+    """Return function containing this match"""
+    for fn in m.file.matches_of_type(StaticVoidFunction):
+        if fn.contains(m):
+            return fn
+    return None
+
+class TypeRegisterStaticCall(FileMatch):
     """type_register_static() call
     Will be replaced by TYPE_INFO() macro
     """
-    regexp = S(r'^[ \t]*type_register_static\s*\(&\s*', NAMED('name', RE_IDENTIFIER), r'\s*\);[ \t]*\n')
-
-    def function(self) -> Optional['StaticVoidFunction']:
-        """Return function containing this call"""
-        for m in self.file.matches_of_type(StaticVoidFunction):
-            if m.contains(self):
-                return m
-        return None
+    regexp = S(r'^[ \t]*', NAMED('func_name', 'type_register_static'),
+               r'\s*\(&\s*', NAMED('name', RE_IDENTIFIER), r'\s*\);[ \t]*\n')
 
+class UseTypeInfo(TypeRegisterStaticCall):
+    """Replace type_register_static() call with TYPE_INFO declaration"""
     def gen_patches(self) -> Iterable[Patch]:
-        fn = self.function()
-        if fn is None:
-            self.warn("can't find function where type_register_static(&%s) is called", self.name)
-            return
+        fn = find_containing_func(self)
+        if fn:
+            DBG("%r is inside %r", self, fn)
+            type_init = self.file.find_match(TypeInitMacro, fn.name)
+            if type_init is None:
+                self.warn("can't find type_init(%s) line", fn.name)
+                if not self.file.force:
+                    return
+        else:
+            self.warn("can't identify the function where type_register_static(&%s) is called", self.name)
+            if not self.file.force:
+                return
 
         #if fn.has_preprocessor_directive() and not self.file.force:
         #    self.warn("function %s has preprocessor directives, this requires --force", fn.name)
         #    return
 
-        type_init = self.file.find_match(TypeInitMacro, fn.name)
-        if type_init is None:
-            self.warn("can't find type_init(%s) line", fn.name)
-            return
-
         var = self.file.find_match(TypeInfoVar, self.name)
         if var is None:
             self.warn("can't find TypeInfo var declaration for %s", self.name)
@@ -375,24 +883,51 @@ class TypeRegisterCall(FileMatch):
 
         if not var.is_full():
             self.warn("variable declaration %s wasn't parsed fully", var.name)
-            return
+            if not self.file.force:
+                return
 
-        if fn.contains(var):
+        if fn and fn.contains(var):
             self.warn("TypeInfo %s variable is inside a function", self.name)
-            return
+            if not self.file.force:
+                return
 
         # delete type_register_static() call:
         yield self.make_patch('')
         # append TYPE_REGISTER(...) after variable declaration:
         yield var.append(f'TYPE_INFO({self.name})\n')
 
+class TypeRegisterCall(FileMatch):
+    """type_register_static() call"""
+    regexp = S(r'^[ \t]*', NAMED('func_name', 'type_register'),
+               r'\s*\(&\s*', NAMED('name', RE_IDENTIFIER), r'\s*\);[ \t]*\n')
+
+class MakeTypeRegisterStatic(TypeRegisterCall):
+    """Make type_register() call static if variable is static const"""
+    def gen_patches(self):
+        var = self.file.find_match(TypeInfoVar, self.name)
+        if var is None:
+            self.warn("can't find TypeInfo var declaration for %s", self.name)
+            return
+        if var.is_static() and var.is_const():
+            yield self.group_match('func_name').make_patch('type_register_static')
+
+class MakeTypeRegisterNotStatic(TypeRegisterStaticCall):
+    """Make type_register() call static if variable is static const"""
+    def gen_patches(self):
+        var = self.file.find_match(TypeInfoVar, self.name)
+        if var is None:
+            self.warn("can't find TypeInfo var declaration for %s", self.name)
+            return
+        if not var.is_static() or not var.is_const():
+            yield self.group_match('func_name').make_patch('type_register')
+
 class TypeInfoMacro(FileMatch):
     """TYPE_INFO macro usage"""
     regexp = S(r'^[ \t]*TYPE_INFO\s*\(\s*', NAMED('name', RE_IDENTIFIER), r'\s*\)[ \t]*;?[ \t]*\n')
 
 def find_type_info(files: RegexpScanner, name: str) -> Optional[TypeInfoVar]:
     ti = [ti for ti in files.matches_of_type(TypeInfoVar)
-            if ti.get_initializer_value('name').raw == name]
+            if ti.get_raw_initializer_value('name') == name]
     DBG("type info vars: %r", ti)
     if len(ti) > 1:
         DBG("multiple TypeInfo vars found for %s", name)
diff --git a/scripts/codeconverter/codeconverter/test_patching.py b/scripts/codeconverter/codeconverter/test_patching.py
index 5998af81c9..71dfbd47e1 100644
--- a/scripts/codeconverter/codeconverter/test_patching.py
+++ b/scripts/codeconverter/codeconverter/test_patching.py
@@ -31,7 +31,6 @@ def test_pattern_patching():
     files = FileList()
     f = FileInfo(files, of.name)
     f.load()
-    f.scan_for_matches()
     matches = f.matches_of_type(BasicPattern)
     assert len(matches) == 2
     p2 = matches[1]
@@ -40,7 +39,7 @@ def test_pattern_patching():
     f.patches.append(p2.append('XXX'))
 
     # apply all patches:
-    f.gen_patches()
+    f.gen_patches(matches)
     patched = f.get_patched_content()
     assert patched == ('one line\n'+
                        'this pattern will be patched: defBBBBBhij\n'+
diff --git a/scripts/codeconverter/codeconverter/test_regexps.py b/scripts/codeconverter/codeconverter/test_regexps.py
index 9b84d689a6..a445634d88 100644
--- a/scripts/codeconverter/codeconverter/test_regexps.py
+++ b/scripts/codeconverter/codeconverter/test_regexps.py
@@ -9,7 +9,7 @@ from .regexps import *
 from .qom_macros import *
 from .qom_type_info import *
 
-def test_res():
+def test_res() -> None:
     def fullmatch(regexp, s):
         return re.fullmatch(regexp, s, re.MULTILINE)
 
@@ -113,10 +113,10 @@ static const TypeInfo char_file_type_info = {
              * need to set up reset or vmstate, and has no realize method.
              */''')
 
-    print(RE_TYPEINFO_DEF)
+    print(TypeInfoVar.regexp)
     test_empty = 'static const TypeInfo x86_base_cpu_type_info = {\n'+\
                  '};\n';
-    assert fullmatch(RE_TYPEINFO_DEF, test_empty)
+    assert fullmatch(TypeInfoVar.regexp, test_empty)
 
     test_simple = r'''
     static const TypeInfo x86_base_cpu_type_info = {
@@ -125,7 +125,7 @@ static const TypeInfo char_file_type_info = {
         .class_init = x86_cpu_base_class_init,
     };
     '''
-    assert re.search(RE_TYPEINFO_DEF, test_simple, re.MULTILINE)
+    assert re.search(TypeInfoVar.regexp, test_simple, re.MULTILINE)
 
     test_interfaces = r'''
     static const TypeInfo acpi_ged_info = {
@@ -141,7 +141,7 @@ static const TypeInfo char_file_type_info = {
         }
     };
     '''
-    assert re.search(RE_TYPEINFO_DEF, test_interfaces, re.MULTILINE)
+    assert re.search(TypeInfoVar.regexp, test_interfaces, re.MULTILINE)
 
     test_comments = r'''
     static const TypeInfo palm_misc_gpio_info = {
@@ -155,7 +155,7 @@ static const TypeInfo char_file_type_info = {
          */
     };
     '''
-    assert re.search(RE_TYPEINFO_DEF, test_comments, re.MULTILINE)
+    assert re.search(TypeInfoVar.regexp, test_comments, re.MULTILINE)
 
     test_comments = r'''
     static const TypeInfo tpm_crb_info = {
@@ -170,7 +170,7 @@ static const TypeInfo char_file_type_info = {
         }
     };
     '''
-    assert re.search(RE_TYPEINFO_DEF, test_comments, re.MULTILINE)
+    assert re.search(TypeInfoVar.regexp, test_comments, re.MULTILINE)
 
 def test_struct_re():
     print('---')
@@ -232,8 +232,8 @@ def test_initial_includes():
 
 /* pflash_cfi01.c */
 '''
-    print(repr(list(m.groupdict() for m in re.finditer(InitialIncludes.regexp, c, re.MULTILINE))))
-    m = re.match(InitialIncludes.regexp, c, re.MULTILINE)
+    print(repr(list(m.groupdict() for m in InitialIncludes.finditer(c))))
+    m = InitialIncludes.domatch(c)
     assert m
     print(repr(m.group(0)))
     assert m.group(0).endswith('#include "exec/hwaddr.h"\n')
@@ -247,8 +247,8 @@ def test_initial_includes():
 
 
 '''
-    print(repr(list(m.groupdict() for m in re.finditer(InitialIncludes.regexp, c, re.MULTILINE))))
-    m = re.match(InitialIncludes.regexp, c, re.MULTILINE)
+    print(repr(list(m.groupdict() for m in InitialIncludes.finditer(c))))
+    m = InitialIncludes.domatch(c)
     assert m
     print(repr(m.group(0)))
     assert m.group(0).endswith('#include "9p.h"\n')
@@ -274,8 +274,8 @@ def test_initial_includes():
 /* Missing stuff:
    SCTRL_P[12](END|ST)INC
 '''
-    print(repr(list(m.groupdict() for m in re.finditer(InitialIncludes.regexp, c, re.MULTILINE))))
-    m = re.match(InitialIncludes.regexp, c, re.MULTILINE)
+    print(repr(list(m.groupdict() for m in InitialIncludes.finditer(c))))
+    m = InitialIncludes.domatch(c)
     assert m
     print(repr(m.group(0)))
     assert m.group(0).endswith('#include "sysemu/dma.h"\n')
diff --git a/scripts/codeconverter/converter.py b/scripts/codeconverter/converter.py
index ebaf9b57ce..75cb515d93 100755
--- a/scripts/codeconverter/converter.py
+++ b/scripts/codeconverter/converter.py
@@ -42,7 +42,7 @@ def process_all_files(parser: argparse.ArgumentParser, args: argparse.Namespace)
             for t in f.matches_of_type(TypeInfoVar):
                 assert isinstance(t, TypeInfoVar)
                 values = [f.filename, t.name] + \
-                         [t.get_initializer_value(f).raw
+                         [t.get_raw_initializer_value(f)
                           for f in TI_FIELDS]
                 DBG('values: %r', values)
                 assert all('\t' not in v for v in values)
@@ -55,18 +55,18 @@ def process_all_files(parser: argparse.ArgumentParser, args: argparse.Namespace)
         parser.error("--pattern is required")
 
     classes = [p for arg in args.patterns
-                for p in re.split(r'[\s,]', arg)]
+               for p in re.split(r'[\s,]', arg)
+               if p.strip()]
     for c in classes:
-        if c not in match_classes:
+        if c not in match_classes \
+           or not match_classes[c].regexp:
             print("Invalid pattern name: %s" % (c), file=sys.stderr)
             print("Valid patterns:", file=sys.stderr)
             print(PATTERN_HELP, file=sys.stderr)
             sys.exit(1)
 
     DBG("classes: %r", classes)
-    for f in files:
-        DBG("patching contents of %s", f.filename)
-        f.patch_content(max_passes=args.passes, class_names=classes)
+    files.patch_content(max_passes=args.passes, class_names=classes)
 
     for f in files:
         #alltypes.extend(f.type_infos)
-- 
2.26.2



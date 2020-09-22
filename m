Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F7BC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:42:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79AD42076E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HFpqFgk0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79AD42076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKqzy-0006A5-JU
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 18:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKqt1-0004Xt-5Z
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:35:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35018)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKqsy-0007eD-SU
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600814144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k1e9wsLbffSunTe91GgJ+qycPBufyfpYi6x1TgpznJg=;
 b=HFpqFgk0QHGHLflaxRpIX8h7n2DPIwonsT7PgxuirJ84SN+RfZGSSTLInLL0HvNH+kIGxj
 g1JJUU4mQeynHfHCXGwWy6RoCBA7m6apZ3LYZ+nrXhmljKmrxc2T7JbN67c35lE1mU6cN5
 /CeyCO8p16qy+Qdb1WF1lBmlTEG/c+U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-Gbu67MJLOgiG1-ovuTSCOw-1; Tue, 22 Sep 2020 18:35:42 -0400
X-MC-Unique: Gbu67MJLOgiG1-ovuTSCOw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 609CB1005E64;
 Tue, 22 Sep 2020 22:35:41 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 94B6F60BF4;
 Tue, 22 Sep 2020 22:35:40 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 13/26] qapi/parser.py: add type hint annotations
Date: Tue, 22 Sep 2020 18:35:12 -0400
Message-Id: <20200922223525.4085762-14-jsnow@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 15:47:47
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

Annotations for QAPIDoc are in a later commit.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/parser.py | 69 ++++++++++++++++++++++++++++++------------
 1 file changed, 49 insertions(+), 20 deletions(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 9a1007f779..d9aae4ddb7 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -14,18 +14,35 @@
 # This work is licensed under the terms of the GNU GPL, version 2.
 # See the COPYING file in the top-level directory.
 
+
+from collections import OrderedDict
 import os
 import re
-from collections import OrderedDict
-from typing import List, Type, TypeVar, cast
+from typing import (
+    Any,
+    Dict,
+    List,
+    Optional,
+    Set,
+    Type,
+    TypeVar,
+    Union,
+    cast,
+)
 
 from .error import QAPIError, QAPISourceError, QAPISemError
 from .source import QAPISourceInfo
 
 
+Expression = Dict[str, Any]
+_Value = Union[List[object], 'OrderedDict[str, object]', str, bool]
+# Necessary imprecision: mypy does not (yet?) support recursive types;
+# so we must stub out that recursion with 'object'.
+# Note, we do not support numerics or null in this parser.
+
+
 class QAPIParseError(QAPISourceError):
     """Error class for all QAPI schema parsing errors."""
-
     T = TypeVar('T', bound='QAPIParseError')
 
     @classmethod
@@ -45,22 +62,25 @@ class QAPIDocError(QAPIError):
 
 class QAPISchemaParser:
 
-    def __init__(self, fname, previously_included=None, incl_info=None):
+    def __init__(self,
+                 fname: str,
+                 previously_included: Optional[Set[str]] = None,
+                 incl_info: Optional[QAPISourceInfo] = None):
         self._fname = fname
         self._included = previously_included or set()
         self._included.add(os.path.abspath(self._fname))
 
         # Lexer state (see `accept` for details):
-        self.tok = None
+        self.tok: Optional[str] = None
         self.pos = 0
         self.cursor = 0
-        self.val = None
+        self.val: Optional[Union[bool, str]] = None
         self.info = QAPISourceInfo(self._fname, parent=incl_info)
         self.line_pos = 0
 
         # Parser output:
-        self.exprs = []
-        self.docs = []
+        self.exprs: List[Expression] = []
+        self.docs: List[QAPIDoc] = []
 
         # Showtime!
         try:
@@ -76,7 +96,7 @@ def __init__(self, fname, previously_included=None, incl_info=None):
             raise QAPIParseError(context, msg) from e
         self._parse()
 
-    def _parse(self):
+    def _parse(self) -> None:
         cur_doc = None
 
         # Prime the lexer:
@@ -140,7 +160,7 @@ def _parse_error(self, msg: str) -> QAPIParseError:
         return QAPIParseError.make(self, msg)
 
     @classmethod
-    def reject_expr_doc(cls, doc):
+    def reject_expr_doc(cls, doc: Optional['QAPIDoc']) -> None:
         if doc and doc.symbol:
             raise QAPISemError(
                 doc.info,
@@ -148,7 +168,12 @@ def reject_expr_doc(cls, doc):
                 % doc.symbol)
 
     @classmethod
-    def _include(cls, include, info, incl_fname, previously_included):
+    def _include(cls,
+                 include: str,
+                 info: QAPISourceInfo,
+                 incl_fname: str,
+                 previously_included: Set[str]
+                 ) -> Optional['QAPISchemaParser']:
         incl_abs_fname = os.path.abspath(incl_fname)
         # catch inclusion cycle
         inf = info
@@ -164,7 +189,10 @@ def _include(cls, include, info, incl_fname, previously_included):
         return QAPISchemaParser(incl_fname, previously_included, info)
 
     @classmethod
-    def _pragma(cls, name, value, info):
+    def _pragma(cls,
+                name: str,
+                value: object,
+                info: QAPISourceInfo) -> None:
         if name == 'doc-required':
             if not isinstance(value, bool):
                 raise QAPISemError(info,
@@ -187,7 +215,7 @@ def _pragma(cls, name, value, info):
         else:
             raise QAPISemError(info, "unknown pragma '%s'" % name)
 
-    def accept(self, skip_comment=True):
+    def accept(self, skip_comment: bool = True) -> None:
         while True:
             self.tok = self.src[self.cursor]
             self.pos = self.cursor
@@ -249,8 +277,8 @@ def accept(self, skip_comment=True):
                                  self.src[self.cursor-1:])
                 raise self._parse_error("stray '%s'" % match.group(0))
 
-    def get_members(self):
-        expr = OrderedDict()
+    def get_members(self) -> 'OrderedDict[str, object]':
+        expr: 'OrderedDict[str, object]' = OrderedDict()
         if self.tok == '}':
             self.accept()
             return expr
@@ -276,8 +304,8 @@ def get_members(self):
             if self.tok != "'":
                 raise self._parse_error("expected string")
 
-    def get_values(self):
-        expr = []
+    def get_values(self) -> List[object]:
+        expr: List[object] = []
         if self.tok == ']':
             self.accept()
             return expr
@@ -293,7 +321,8 @@ def get_values(self):
                 raise self._parse_error("expected ',' or ']'")
             self.accept()
 
-    def get_expr(self, nested):
+    def get_expr(self, nested: bool = False) -> _Value:
+        expr: _Value
         if self.tok != '{' and not nested:
             raise self._parse_error("expected '{'")
         if self.tok == '{':
@@ -310,7 +339,7 @@ def get_expr(self, nested):
                 "expected '{', '[', string, or boolean")
         return expr
 
-    def _get_doc(self, info):
+    def _get_doc(self, info: QAPISourceInfo) -> List['QAPIDoc']:
         if self.val != '##':
             raise self._parse_error(
                 "junk after '##' at start of documentation comment")
@@ -342,7 +371,7 @@ def _get_doc(self, info):
 
         raise self._parse_error("documentation comment must end with '##'")
 
-    def get_doc(self, info):
+    def get_doc(self, info: QAPISourceInfo) -> List['QAPIDoc']:
         try:
             return self._get_doc(info)
         except QAPIDocError as err:
-- 
2.26.2



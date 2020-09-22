Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C7BC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 21:54:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 064D8207C3
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 21:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iH9JzcxO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 064D8207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKqEv-0005PE-5Y
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 17:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpbP-00012t-5z
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:13:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26117)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpbN-00063I-2L
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600809208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qvntVAw7UwIjWN4n9HMRaHDxuagSIVWP9zNN1NsSEL8=;
 b=iH9JzcxOiSp0p/vXEwZSPCQsryqSWj5/TGKQnk7Dgeb0bSqSg9ORfh79JJa4ls0osZ5D49
 XkhDQ8CriwqbaO2m9RtBWQY81UPjHJbUbNGfxOFZjGSV42J/v+6YfsnS0L7W2einEI+fZE
 MAuTMNAr7dZ7Nif7HRgMxqYnkPJIYWg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-ZBVXaUMgO4q0rl6R1uaKrQ-1; Tue, 22 Sep 2020 17:13:26 -0400
X-MC-Unique: ZBVXaUMgO4q0rl6R1uaKrQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0384C805EE4;
 Tue, 22 Sep 2020 21:13:25 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 98462614F5;
 Tue, 22 Sep 2020 21:13:23 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 08/16] qapi/expr.py: add type hint annotations
Date: Tue, 22 Sep 2020 17:13:05 -0400
Message-Id: <20200922211313.4082880-9-jsnow@redhat.com>
In-Reply-To: <20200922211313.4082880-1-jsnow@redhat.com>
References: <20200922211313.4082880-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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
 scripts/qapi/expr.py  | 65 +++++++++++++++++++++++++++----------------
 scripts/qapi/mypy.ini |  5 ----
 2 files changed, 41 insertions(+), 29 deletions(-)

diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
index 4a3352a2bd..6b064a2138 100644
--- a/scripts/qapi/expr.py
+++ b/scripts/qapi/expr.py
@@ -16,8 +16,11 @@
 
 import re
 from typing import (
+    Iterable,
+    List,
     MutableMapping,
     Optional,
+    Union,
     cast,
 )
 
@@ -27,10 +30,11 @@
 from .source import QAPISourceInfo
 
 
-# Expressions in their raw form are JSON-like structures with arbitrary forms.
-# Minimally, their top-level form must be a mapping of strings to values.
-Expression = MutableMapping[str, object]
+# Arbitrary form for a JSON-like object.
+_JSObject = MutableMapping[str, object]
 
+# Expressions in their raw form are (just) JSON-like objects.
+Expression = _JSObject
 
 # Names must be letters, numbers, -, and _.  They must start with letter,
 # except for downstream extensions which must start with __RFQDN_.
@@ -39,14 +43,19 @@
                         '[a-zA-Z][a-zA-Z0-9_-]*$')
 
 
-def check_name_is_str(name, info, source):
+def check_name_is_str(name: object,
+                      info: QAPISourceInfo,
+                      source: str) -> None:
     if not isinstance(name, str):
         raise QAPISemError(info, "%s requires a string name" % source)
 
 
-def check_name_str(name, info, source,
-                   allow_optional=False, enum_member=False,
-                   permit_upper=False):
+def check_name_str(name: str,
+                   info: QAPISourceInfo,
+                   source: str,
+                   allow_optional: bool = False,
+                   enum_member: bool = False,
+                   permit_upper: bool = False) -> None:
     membername = name
 
     if allow_optional and name.startswith('*'):
@@ -66,16 +75,20 @@ def check_name_str(name, info, source,
     assert not membername.startswith('*')
 
 
-def check_defn_name_str(name, info, meta):
+def check_defn_name_str(name: str, info: QAPISourceInfo, meta: str) -> None:
     check_name_str(name, info, meta, permit_upper=True)
     if name.endswith('Kind') or name.endswith('List'):
         raise QAPISemError(
             info, "%s name should not end in '%s'" % (meta, name[-4:]))
 
 
-def check_keys(value, info, source, required, optional):
+def check_keys(value: _JSObject,
+               info: QAPISourceInfo,
+               source: str,
+               required: List[str],
+               optional: List[str]) -> None:
 
-    def pprint(elems):
+    def pprint(elems: Iterable[str]) -> str:
         return ', '.join("'" + e + "'" for e in sorted(elems))
 
     missing = set(required) - set(value)
@@ -95,7 +108,7 @@ def pprint(elems):
                pprint(unknown), pprint(allowed)))
 
 
-def check_flags(expr, info):
+def check_flags(expr: Expression, info: QAPISourceInfo) -> None:
     for key in ['gen', 'success-response']:
         if key in expr and expr[key] is not False:
             raise QAPISemError(
@@ -106,9 +119,9 @@ def check_flags(expr, info):
                 info, "flag '%s' may only use true value" % key)
 
 
-def check_if(expr, info, source):
+def check_if(expr: _JSObject, info: QAPISourceInfo, source: str) -> None:
 
-    def check_if_str(ifcond):
+    def check_if_str(ifcond: object) -> None:
         if not isinstance(ifcond, str):
             raise QAPISemError(
                 info,
@@ -134,7 +147,7 @@ def check_if_str(ifcond):
         expr['if'] = [ifcond]
 
 
-def normalize_members(members):
+def normalize_members(members: object) -> None:
     if isinstance(members, dict):
         for key, arg in members.items():
             if isinstance(arg, dict):
@@ -142,8 +155,11 @@ def normalize_members(members):
             members[key] = {'type': arg}
 
 
-def check_type(value, info, source,
-               allow_array=False, allow_dict=False):
+def check_type(value: Optional[object],
+               info: QAPISourceInfo,
+               source: str,
+               allow_array: bool = False,
+               allow_dict: Union[bool, str] = False) -> None:
     if value is None:
         return
 
@@ -187,7 +203,8 @@ def check_type(value, info, source,
         check_type(arg['type'], info, key_source, allow_array=True)
 
 
-def check_features(features, info):
+def check_features(features: Optional[object],
+                   info: QAPISourceInfo) -> None:
     if features is None:
         return
     if not isinstance(features, list):
@@ -204,7 +221,7 @@ def check_features(features, info):
         check_if(f, info, source)
 
 
-def check_enum(expr, info):
+def check_enum(expr: Expression, info: QAPISourceInfo) -> None:
     name = expr['enum']
     members = expr['data']
     prefix = expr.get('prefix')
@@ -228,7 +245,7 @@ def check_enum(expr, info):
         check_if(member, info, source)
 
 
-def check_struct(expr, info):
+def check_struct(expr: Expression, info: QAPISourceInfo) -> None:
     name = cast(str, expr['struct'])  # Asserted in check_exprs
     members = expr['data']
 
@@ -236,7 +253,7 @@ def check_struct(expr, info):
     check_type(expr.get('base'), info, "'base'")
 
 
-def check_union(expr, info):
+def check_union(expr: Expression, info: QAPISourceInfo) -> None:
     name = cast(str, expr['union'])  # Asserted in check_exprs
     base = expr.get('base')
     discriminator = expr.get('discriminator')
@@ -262,7 +279,7 @@ def check_union(expr, info):
         check_type(value['type'], info, source, allow_array=not base)
 
 
-def check_alternate(expr, info):
+def check_alternate(expr: Expression, info: QAPISourceInfo) -> None:
     members = expr['data']
 
     if not members:
@@ -279,7 +296,7 @@ def check_alternate(expr, info):
         check_type(value['type'], info, source)
 
 
-def check_command(expr, info):
+def check_command(expr: Expression, info: QAPISourceInfo) -> None:
     args = expr.get('data')
     rets = expr.get('returns')
     boxed = expr.get('boxed', False)
@@ -290,7 +307,7 @@ def check_command(expr, info):
     check_type(rets, info, "'returns'", allow_array=True)
 
 
-def check_event(expr, info):
+def check_event(expr: Expression, info: QAPISourceInfo) -> None:
     args = expr.get('data')
     boxed = expr.get('boxed', False)
 
@@ -299,7 +316,7 @@ def check_event(expr, info):
     check_type(args, info, "'data'", allow_dict=not boxed)
 
 
-def check_exprs(exprs):
+def check_exprs(exprs: List[_JSObject]) -> List[_JSObject]:
     for expr_elem in exprs:
         # Expression
         assert isinstance(expr_elem['expr'], dict)
diff --git a/scripts/qapi/mypy.ini b/scripts/qapi/mypy.ini
index 5ab3433c5f..0d0111930f 100644
--- a/scripts/qapi/mypy.ini
+++ b/scripts/qapi/mypy.ini
@@ -14,11 +14,6 @@ disallow_untyped_defs = False
 disallow_incomplete_defs = False
 check_untyped_defs = False
 
-[mypy-qapi.expr]
-disallow_untyped_defs = False
-disallow_incomplete_defs = False
-check_untyped_defs = False
-
 [mypy-qapi.parser]
 disallow_untyped_defs = False
 disallow_incomplete_defs = False
-- 
2.26.2



Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF45C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 04:49:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5786F2075A
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 04:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DfHci/1k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5786F2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNU3C-0005DX-9L
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 00:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kNTnS-0001FS-1e
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 00:32:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57210)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kNTnN-0000ac-2j
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 00:32:53 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601440365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ByDlvOtSsfN8S4NZCIhG3gH/OvkJg2U+5cEP3dfJlBI=;
 b=DfHci/1k268mC8SWwFOp8LbmJ7LrjNwocPAUij7jMZyK0fwrHUEta2xQVVPZyihi9cMlmW
 rGd8j/ZbF1JjNSm534J0dT79k5uq0a0Cqg6+47x2wuErABRswtPu80BquS5LLkLdF+BZvc
 VeyyI4yz7uQRY8MiTz5DSowVDj3hkfc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-bPYAfmtQMNm1_jKoJGEBxQ-1; Wed, 30 Sep 2020 00:32:43 -0400
X-MC-Unique: bPYAfmtQMNm1_jKoJGEBxQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 064CF1074651;
 Wed, 30 Sep 2020 04:32:42 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 27F9073678;
 Wed, 30 Sep 2020 04:32:40 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 23/46] qapi/events.py: add type hint annotations
Date: Wed, 30 Sep 2020 00:31:27 -0400
Message-Id: <20200930043150.1454766-24-jsnow@redhat.com>
In-Reply-To: <20200930043150.1454766-1-jsnow@redhat.com>
References: <20200930043150.1454766-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Annotations do not change runtime behavior.
This commit *only* adds annotations.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
---
 scripts/qapi/events.py | 46 ++++++++++++++++++++++++++++++++----------
 scripts/qapi/mypy.ini  |  5 -----
 2 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index f840a62ed92..57e0939e963 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -12,19 +12,31 @@
 See the COPYING file in the top-level directory.
 """
 
+from typing import List
+
 from .common import c_enum_const, c_name, mcgen
 from .gen import QAPISchemaModularCVisitor, build_params, ifcontext
-from .schema import QAPISchemaEnumMember
+from .schema import (
+    QAPISchema,
+    QAPISchemaEnumMember,
+    QAPISchemaFeature,
+    QAPISchemaObjectType,
+)
+from .source import QAPISourceInfo
 from .types import gen_enum, gen_enum_lookup
 
 
-def build_event_send_proto(name, arg_type, boxed):
+def build_event_send_proto(name: str,
+                           arg_type: QAPISchemaObjectType,
+                           boxed: bool) -> str:
     return 'void qapi_event_send_%(c_name)s(%(param)s)' % {
         'c_name': c_name(name.lower()),
         'param': build_params(arg_type, boxed)}
 
 
-def gen_event_send_decl(name, arg_type, boxed):
+def gen_event_send_decl(name: str,
+                        arg_type: QAPISchemaObjectType,
+                        boxed: bool) -> str:
     return mcgen('''
 
 %(proto)s;
@@ -33,7 +45,7 @@ def gen_event_send_decl(name, arg_type, boxed):
 
 
 # Declare and initialize an object 'qapi' using parameters from build_params()
-def gen_param_var(typ):
+def gen_param_var(typ: QAPISchemaObjectType) -> str:
     assert not typ.variants
     ret = mcgen('''
     %(c_name)s param = {
@@ -61,7 +73,11 @@ def gen_param_var(typ):
     return ret
 
 
-def gen_event_send(name, arg_type, boxed, event_enum_name, event_emit):
+def gen_event_send(name: str,
+                   arg_type: QAPISchemaObjectType,
+                   boxed: bool,
+                   event_enum_name: str,
+                   event_emit: str) -> str:
     # FIXME: Our declaration of local variables (and of 'errp' in the
     # parameter list) can collide with exploded members of the event's
     # data type passed in as parameters.  If this collision ever hits in
@@ -137,15 +153,15 @@ def gen_event_send(name, arg_type, boxed, event_enum_name, event_emit):
 
 class QAPISchemaGenEventVisitor(QAPISchemaModularCVisitor):
 
-    def __init__(self, prefix):
+    def __init__(self, prefix: str):
         super().__init__(
             prefix, 'qapi-events',
             ' * Schema-defined QAPI/QMP events', None, __doc__)
         self._event_enum_name = c_name(prefix + 'QAPIEvent', protect=False)
-        self._event_enum_members = []
+        self._event_enum_members: List[QAPISchemaEnumMember] = []
         self._event_emit_name = c_name(prefix + 'qapi_event_emit')
 
-    def _begin_user_module(self, name):
+    def _begin_user_module(self, name: str) -> None:
         events = self._module_basename('qapi-events', name)
         types = self._module_basename('qapi-types', name)
         visit = self._module_basename('qapi-visit', name)
@@ -168,7 +184,7 @@ def _begin_user_module(self, name):
 ''',
                              types=types))
 
-    def visit_end(self):
+    def visit_end(self) -> None:
         self._add_system_module('emit', ' * QAPI Events emission')
         self._genc.preamble_add(mcgen('''
 #include "qemu/osdep.h"
@@ -189,7 +205,13 @@ def visit_end(self):
                              event_emit=self._event_emit_name,
                              event_enum=self._event_enum_name))
 
-    def visit_event(self, name, info, ifcond, features, arg_type, boxed):
+    def visit_event(self,
+                    name: str,
+                    info: QAPISourceInfo,
+                    ifcond: List[str],
+                    features: List[QAPISchemaFeature],
+                    arg_type: QAPISchemaObjectType,
+                    boxed: bool) -> None:
         with ifcontext(ifcond, self._genh, self._genc):
             self._genh.add(gen_event_send_decl(name, arg_type, boxed))
             self._genc.add(gen_event_send(name, arg_type, boxed,
@@ -200,7 +222,9 @@ def visit_event(self, name, info, ifcond, features, arg_type, boxed):
         self._event_enum_members.append(QAPISchemaEnumMember(name, None))
 
 
-def gen_events(schema, output_dir, prefix):
+def gen_events(schema: QAPISchema,
+               output_dir: str,
+               prefix: str) -> None:
     vis = QAPISchemaGenEventVisitor(prefix)
     schema.visit(vis)
     vis.write(output_dir)
diff --git a/scripts/qapi/mypy.ini b/scripts/qapi/mypy.ini
index 00fac15dc6e..5df11e53fd1 100644
--- a/scripts/qapi/mypy.ini
+++ b/scripts/qapi/mypy.ini
@@ -14,11 +14,6 @@ disallow_untyped_defs = False
 disallow_incomplete_defs = False
 check_untyped_defs = False
 
-[mypy-qapi.events]
-disallow_untyped_defs = False
-disallow_incomplete_defs = False
-check_untyped_defs = False
-
 [mypy-qapi.expr]
 disallow_untyped_defs = False
 disallow_incomplete_defs = False
-- 
2.26.2



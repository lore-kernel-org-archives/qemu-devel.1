Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7492FC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 10:14:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F0CF20782
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 10:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tmr0P6jr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F0CF20782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRBt1-00008B-0C
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 06:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kRBbA-00088Z-Dj
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 05:55:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59121)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kRBat-0002k6-NY
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 05:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602323715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NoNd8cI7Yj62m2cE9erhVoipWQ+s2fztx4QOy0Vwg3E=;
 b=Tmr0P6jrs3wET9CNKHSROp9N8d4X2pCPBFaVbmGDQYV5mFo2Ou/pDnIaRTq7yMHG5OKReS
 v4v4taEEkwVcsMnSftNCOYR9JuGyIClZAis0Dp/mdOGcA8UTKUkLrJBdb/B4LVk0dJtf69
 eMze1m3inZS6qdBFeGrEUCZElgItnnc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-LNp8N5vvNjeTscst8CBLNQ-1; Sat, 10 Oct 2020 05:55:10 -0400
X-MC-Unique: LNp8N5vvNjeTscst8CBLNQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E963F1005E7A;
 Sat, 10 Oct 2020 09:55:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 953E955760;
 Sat, 10 Oct 2020 09:55:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E162B112995F; Sat, 10 Oct 2020 11:55:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 22/34] qapi/commands.py: add type hint annotations
Date: Sat, 10 Oct 2020 11:54:52 +0200
Message-Id: <20201010095504.796182-23-armbru@redhat.com>
In-Reply-To: <20201010095504.796182-1-armbru@redhat.com>
References: <20201010095504.796182-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/10 03:36:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: peter.maydell@linaro.org, John Snow <jsnow@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

Annotations do not change runtime behavior.
This commit *only* adds annotations.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20201009161558.107041-23-jsnow@redhat.com>
Message-Id: <20201009161558.107041-24-jsnow@redhat.com>
[mypy.ini update squashed in]
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/commands.py | 74 ++++++++++++++++++++++++++++++----------
 scripts/qapi/mypy.ini    |  5 ---
 2 files changed, 56 insertions(+), 23 deletions(-)

diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index b0abb985a4..50978090b4 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -13,16 +13,34 @@ This work is licensed under the terms of the GNU GPL, version 2.
 See the COPYING file in the top-level directory.
 """
 
+from typing import (
+    Dict,
+    List,
+    Optional,
+    Set,
+)
+
 from .common import c_name, mcgen
 from .gen import (
+    QAPIGenC,
     QAPIGenCCode,
     QAPISchemaModularCVisitor,
     build_params,
     ifcontext,
 )
+from .schema import (
+    QAPISchema,
+    QAPISchemaFeature,
+    QAPISchemaObjectType,
+    QAPISchemaType,
+)
+from .source import QAPISourceInfo
 
 
-def gen_command_decl(name, arg_type, boxed, ret_type):
+def gen_command_decl(name: str,
+                     arg_type: Optional[QAPISchemaObjectType],
+                     boxed: bool,
+                     ret_type: Optional[QAPISchemaType]) -> str:
     return mcgen('''
 %(c_type)s qmp_%(c_name)s(%(params)s);
 ''',
@@ -31,7 +49,10 @@ def gen_command_decl(name, arg_type, boxed, ret_type):
                  params=build_params(arg_type, boxed, 'Error **errp'))
 
 
-def gen_call(name, arg_type, boxed, ret_type):
+def gen_call(name: str,
+             arg_type: Optional[QAPISchemaObjectType],
+             boxed: bool,
+             ret_type: Optional[QAPISchemaType]) -> str:
     ret = ''
 
     argstr = ''
@@ -67,7 +88,7 @@ def gen_call(name, arg_type, boxed, ret_type):
     return ret
 
 
-def gen_marshal_output(ret_type):
+def gen_marshal_output(ret_type: QAPISchemaType) -> str:
     return mcgen('''
 
 static void qmp_marshal_output_%(c_name)s(%(c_type)s ret_in,
@@ -88,19 +109,22 @@ static void qmp_marshal_output_%(c_name)s(%(c_type)s ret_in,
                  c_type=ret_type.c_type(), c_name=ret_type.c_name())
 
 
-def build_marshal_proto(name):
+def build_marshal_proto(name: str) -> str:
     return ('void qmp_marshal_%s(QDict *args, QObject **ret, Error **errp)'
             % c_name(name))
 
 
-def gen_marshal_decl(name):
+def gen_marshal_decl(name: str) -> str:
     return mcgen('''
 %(proto)s;
 ''',
                  proto=build_marshal_proto(name))
 
 
-def gen_marshal(name, arg_type, boxed, ret_type):
+def gen_marshal(name: str,
+                arg_type: Optional[QAPISchemaObjectType],
+                boxed: bool,
+                ret_type: Optional[QAPISchemaType]) -> str:
     have_args = boxed or (arg_type and not arg_type.is_empty())
 
     ret = mcgen('''
@@ -182,8 +206,11 @@ out:
     return ret
 
 
-def gen_register_command(name, success_response, allow_oob, allow_preconfig,
-                         coroutine):
+def gen_register_command(name: str,
+                         success_response: bool,
+                         allow_oob: bool,
+                         allow_preconfig: bool,
+                         coroutine: bool) -> str:
     options = []
 
     if not success_response:
@@ -207,7 +234,7 @@ def gen_register_command(name, success_response, allow_oob, allow_preconfig,
     return ret
 
 
-def gen_registry(registry, prefix):
+def gen_registry(registry: str, prefix: str) -> str:
     ret = mcgen('''
 
 void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds)
@@ -224,15 +251,14 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds)
 
 
 class QAPISchemaGenCommandVisitor(QAPISchemaModularCVisitor):
-
-    def __init__(self, prefix):
+    def __init__(self, prefix: str):
         super().__init__(
             prefix, 'qapi-commands',
             ' * Schema-defined QAPI/QMP commands', None, __doc__)
         self._regy = QAPIGenCCode(None)
-        self._visited_ret_types = {}
+        self._visited_ret_types: Dict[QAPIGenC, Set[QAPISchemaType]] = {}
 
-    def _begin_user_module(self, name):
+    def _begin_user_module(self, name: str) -> None:
         self._visited_ret_types[self._genc] = set()
         commands = self._module_basename('qapi-commands', name)
         types = self._module_basename('qapi-types', name)
@@ -256,7 +282,7 @@ class QAPISchemaGenCommandVisitor(QAPISchemaModularCVisitor):
 ''',
                              types=types))
 
-    def visit_end(self):
+    def visit_end(self) -> None:
         self._add_system_module('init', ' * QAPI Commands initialization')
         self._genh.add(mcgen('''
 #include "qapi/qmp/dispatch.h"
@@ -272,9 +298,19 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
                                       prefix=self._prefix))
         self._genc.add(gen_registry(self._regy.get_content(), self._prefix))
 
-    def visit_command(self, name, info, ifcond, features,
-                      arg_type, ret_type, gen, success_response, boxed,
-                      allow_oob, allow_preconfig, coroutine):
+    def visit_command(self,
+                      name: str,
+                      info: QAPISourceInfo,
+                      ifcond: List[str],
+                      features: List[QAPISchemaFeature],
+                      arg_type: Optional[QAPISchemaObjectType],
+                      ret_type: Optional[QAPISchemaType],
+                      gen: bool,
+                      success_response: bool,
+                      boxed: bool,
+                      allow_oob: bool,
+                      allow_preconfig: bool,
+                      coroutine: bool) -> None:
         if not gen:
             return
         # FIXME: If T is a user-defined type, the user is responsible
@@ -296,7 +332,9 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
                                                 coroutine))
 
 
-def gen_commands(schema, output_dir, prefix):
+def gen_commands(schema: QAPISchema,
+                 output_dir: str,
+                 prefix: str) -> None:
     vis = QAPISchemaGenCommandVisitor(prefix)
     schema.visit(vis)
     vis.write(output_dir)
diff --git a/scripts/qapi/mypy.ini b/scripts/qapi/mypy.ini
index 5df11e53fd..8ab9ac52cc 100644
--- a/scripts/qapi/mypy.ini
+++ b/scripts/qapi/mypy.ini
@@ -4,11 +4,6 @@ strict_optional = False
 disallow_untyped_calls = False
 python_version = 3.6
 
-[mypy-qapi.commands]
-disallow_untyped_defs = False
-disallow_incomplete_defs = False
-check_untyped_defs = False
-
 [mypy-qapi.error]
 disallow_untyped_defs = False
 disallow_incomplete_defs = False
-- 
2.26.2



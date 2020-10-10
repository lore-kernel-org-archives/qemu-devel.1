Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F287C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 10:04:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E113A2184D
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 10:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VbfmgjOs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E113A2184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRBkC-00038z-VL
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 06:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kRBay-0007ge-4b
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 05:55:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30514)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kRBaq-0002i4-J4
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 05:55:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602323711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ELrnHUm3FmPmEFoV//Ry0cEPisr1NwN4/ZIjDDz+JCY=;
 b=VbfmgjOsywwx8KW0PC8COxRvAWKzlY19sFL0kNjPZVe2eAzqiLAK7UgXNzgG5otb5ysJW6
 KM1PSZBkxIdByGNLxA9dil46ZwY0RkYwdZYjB6/hxtQoIKcbHjhVDqbICLmo3gINeXHdOh
 dAePBtcBB5uNscHkrfaUrEN72ocRhHU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-49Vr-WV6Mty9aoxeBTz-WA-1; Sat, 10 Oct 2020 05:55:09 -0400
X-MC-Unique: 49Vr-WV6Mty9aoxeBTz-WA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74A9B107AD98;
 Sat, 10 Oct 2020 09:55:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 207DA75128;
 Sat, 10 Oct 2020 09:55:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B285C112CE1A; Sat, 10 Oct 2020 11:55:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/34] qapi: delint using flake8
Date: Sat, 10 Oct 2020 11:54:38 +0200
Message-Id: <20201010095504.796182-9-armbru@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/10 02:57:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Petty style guide fixes and line length enforcement.  Not a big win, not
a big loss, but flake8 passes 100% on the qapi module, which gives us an
easy baseline to enforce hereafter.

A note on the flake8 exception: flake8 will warn on *any* bare except,
but pylint's is context-aware and will suppress the warning if you
re-raise the exception.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20201009161558.107041-9-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/.flake8     |  2 ++
 scripts/qapi/commands.py |  3 ++-
 scripts/qapi/schema.py   |  8 +++++---
 scripts/qapi/visit.py    | 16 +++++++++++-----
 4 files changed, 20 insertions(+), 9 deletions(-)
 create mode 100644 scripts/qapi/.flake8

diff --git a/scripts/qapi/.flake8 b/scripts/qapi/.flake8
new file mode 100644
index 0000000000..6b158c68b8
--- /dev/null
+++ b/scripts/qapi/.flake8
@@ -0,0 +1,2 @@
+[flake8]
+extend-ignore = E722  # Prefer pylint's bare-except checks to flake8's
diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index e06c10afcd..cde0c1e777 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -65,7 +65,8 @@ def gen_call(name, arg_type, boxed, ret_type):
 def gen_marshal_output(ret_type):
     return mcgen('''
 
-static void qmp_marshal_output_%(c_name)s(%(c_type)s ret_in, QObject **ret_out, Error **errp)
+static void qmp_marshal_output_%(c_name)s(%(c_type)s ret_in,
+                                QObject **ret_out, Error **errp)
 {
     Visitor *v;
 
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 71ebb1e396..afd750989e 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -536,7 +536,7 @@ class QAPISchemaVariants:
             v.set_defined_in(name)
 
     def check(self, schema, seen):
-        if not self.tag_member: # flat union
+        if not self.tag_member:  # flat union
             self.tag_member = seen.get(c_name(self._tag_name))
             base = "'base'"
             # Pointing to the base type when not implicit would be
@@ -824,7 +824,7 @@ class QAPISchema:
         self._entity_dict = {}
         self._module_dict = OrderedDict()
         self._schema_dir = os.path.dirname(fname)
-        self._make_module(None) # built-ins
+        self._make_module(None)  # built-ins
         self._make_module(fname)
         self._predefining = True
         self._def_predefineds()
@@ -968,7 +968,9 @@ class QAPISchema:
             # But it's not tight: the disjunction need not imply it.  We
             # may end up compiling useless wrapper types.
             # TODO kill simple unions or implement the disjunction
-            assert (ifcond or []) == typ._ifcond # pylint: disable=protected-access
+
+            # pylint: disable=protected-access
+            assert (ifcond or []) == typ._ifcond
         else:
             self._def_entity(QAPISchemaObjectType(
                 name, info, None, ifcond, None, None, members, None))
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index ea277e7704..9fdbe5b9ef 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -31,7 +31,9 @@ def gen_visit_decl(name, scalar=False):
     if not scalar:
         c_type += '*'
     return mcgen('''
-bool visit_type_%(c_name)s(Visitor *v, const char *name, %(c_type)sobj, Error **errp);
+
+bool visit_type_%(c_name)s(Visitor *v, const char *name,
+                 %(c_type)sobj, Error **errp);
 ''',
                  c_name=c_name(name), c_type=c_type)
 
@@ -125,7 +127,8 @@ bool visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp)
 def gen_visit_list(name, element_type):
     return mcgen('''
 
-bool visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **obj, Error **errp)
+bool visit_type_%(c_name)s(Visitor *v, const char *name,
+                 %(c_name)s **obj, Error **errp)
 {
     bool ok = false;
     %(c_name)s *tail;
@@ -158,7 +161,8 @@ out_obj:
 def gen_visit_enum(name):
     return mcgen('''
 
-bool visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s *obj, Error **errp)
+bool visit_type_%(c_name)s(Visitor *v, const char *name,
+                 %(c_name)s *obj, Error **errp)
 {
     int value = *obj;
     bool ok = visit_type_enum(v, name, &value, &%(c_name)s_lookup, errp);
@@ -172,7 +176,8 @@ bool visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s *obj, Error
 def gen_visit_alternate(name, variants):
     ret = mcgen('''
 
-bool visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **obj, Error **errp)
+bool visit_type_%(c_name)s(Visitor *v, const char *name,
+                 %(c_name)s **obj, Error **errp)
 {
     bool ok = false;
 
@@ -247,7 +252,8 @@ out_obj:
 def gen_visit_object(name, base, members, variants):
     return mcgen('''
 
-bool visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **obj, Error **errp)
+bool visit_type_%(c_name)s(Visitor *v, const char *name,
+                 %(c_name)s **obj, Error **errp)
 {
     bool ok = false;
 
-- 
2.26.2



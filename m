Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EC6C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 22:44:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1027920B1F
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 22:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Swayl9bM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1027920B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIJgw-0003RB-5j
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 18:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIJdG-0006cg-Bk
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 18:41:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24532
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIJdE-0002cS-3f
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 18:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600209657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sV7DeP8u+LoeKvhOOaEL4L2bfZhEJsCamxKagVcd3e4=;
 b=Swayl9bM7Ih7vdyxWtvBMm3eq/Q2BhjAt9t/tOkaud4oyerUUGH+PmN30/R7gciHtGbJgh
 hYxouHa6SfnlPGp+XK2aDcN5HLA8afbc4Nc7lQBWX0x8O2aQGPsX+r/oEqJJq1auHa3xoF
 hNF9Cy+UX6KBsjx0mR2GzpM6jMol228=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-zMokrybSP1mCeGy44QhRrA-1; Tue, 15 Sep 2020 18:40:55 -0400
X-MC-Unique: zMokrybSP1mCeGy44QhRrA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96A49191E2A6;
 Tue, 15 Sep 2020 22:40:47 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A95A581C43;
 Tue, 15 Sep 2020 22:40:46 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 06/37] qapi: delint using flake8
Date: Tue, 15 Sep 2020 18:39:56 -0400
Message-Id: <20200915224027.2529813-7-jsnow@redhat.com>
In-Reply-To: <20200915224027.2529813-1-jsnow@redhat.com>
References: <20200915224027.2529813-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 18:40:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Petty style guide fixes and line length enforcement.  Not a big win, not
a big loss, but flake8 passes 100% on the qapi module, which gives us an
easy baseline to enforce hereafter.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/.flake8     |  2 ++
 scripts/qapi/commands.py |  3 ++-
 scripts/qapi/schema.py   |  8 +++++---
 scripts/qapi/visit.py    | 15 ++++++++++-----
 4 files changed, 19 insertions(+), 9 deletions(-)
 create mode 100644 scripts/qapi/.flake8

diff --git a/scripts/qapi/.flake8 b/scripts/qapi/.flake8
new file mode 100644
index 0000000000..45d8146f3f
--- /dev/null
+++ b/scripts/qapi/.flake8
@@ -0,0 +1,2 @@
+[flake8]
+extend-ignore = E722  # Pylint handles this, but smarter.
\ No newline at end of file
diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index e1df0e341f..2e4b4de0fa 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -69,7 +69,8 @@ def gen_call(name, arg_type, boxed, ret_type):
 def gen_marshal_output(ret_type):
     return mcgen('''
 
-static void qmp_marshal_output_%(c_name)s(%(c_type)s ret_in, QObject **ret_out, Error **errp)
+static void qmp_marshal_output_%(c_name)s(%(c_type)s ret_in, QObject **ret_out,
+                                          Error **errp)
 {
     Visitor *v;
 
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index a835ee6fde..b77e0e56b2 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -536,7 +536,7 @@ def set_defined_in(self, name):
             v.set_defined_in(name)
 
     def check(self, schema, seen):
-        if not self.tag_member: # flat union
+        if not self.tag_member:  # flat union
             self.tag_member = seen.get(c_name(self._tag_name))
             base = "'base'"
             # Pointing to the base type when not implicit would be
@@ -821,7 +821,7 @@ def __init__(self, fname):
         self._entity_dict = {}
         self._module_dict = OrderedDict()
         self._schema_dir = os.path.dirname(fname)
-        self._make_module(None) # built-ins
+        self._make_module(None)  # built-ins
         self._make_module(fname)
         self._predefining = True
         self._def_predefineds()
@@ -965,7 +965,9 @@ def _make_implicit_object_type(self, name, info, ifcond, role, members):
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
index ea277e7704..31bf46e7f7 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -31,7 +31,8 @@ def gen_visit_decl(name, scalar=False):
     if not scalar:
         c_type += '*'
     return mcgen('''
-bool visit_type_%(c_name)s(Visitor *v, const char *name, %(c_type)sobj, Error **errp);
+bool visit_type_%(c_name)s(Visitor *v, const char *name, %(c_type)sobj,
+                           Error **errp);
 ''',
                  c_name=c_name(name), c_type=c_type)
 
@@ -125,7 +126,8 @@ def gen_visit_object_members(name, base, members, variants):
 def gen_visit_list(name, element_type):
     return mcgen('''
 
-bool visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **obj, Error **errp)
+bool visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **obj,
+                           Error **errp)
 {
     bool ok = false;
     %(c_name)s *tail;
@@ -158,7 +160,8 @@ def gen_visit_list(name, element_type):
 def gen_visit_enum(name):
     return mcgen('''
 
-bool visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s *obj, Error **errp)
+bool visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s *obj,
+                           Error **errp)
 {
     int value = *obj;
     bool ok = visit_type_enum(v, name, &value, &%(c_name)s_lookup, errp);
@@ -172,7 +175,8 @@ def gen_visit_enum(name):
 def gen_visit_alternate(name, variants):
     ret = mcgen('''
 
-bool visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **obj, Error **errp)
+bool visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **obj,
+                           Error **errp)
 {
     bool ok = false;
 
@@ -247,7 +251,8 @@ def gen_visit_alternate(name, variants):
 def gen_visit_object(name, base, members, variants):
     return mcgen('''
 
-bool visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **obj, Error **errp)
+bool visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **obj,
+                           Error **errp)
 {
     bool ok = false;
 
-- 
2.26.2



Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDA0C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 23:09:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CF22208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 23:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dmUNn4qw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CF22208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIK4n-0007Oy-DI
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 19:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIJeE-0007py-BE
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 18:42:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46219)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIJe8-0002kM-PB
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 18:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600209710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=asnqf+6Vai1qIfw6CHYSJVBHm5QKlKuylIT9SkdgwV4=;
 b=dmUNn4qw1PWMbDClNmc1cuUDx+j8eqv7xZzsWpOxt6wW7s9QYPctNcl11opAXO1QSzcDeB
 JAuvWMMIbGP88aRQdVR7PIksC/J4uw7CMpw2b5sDwFP98n5qYyjr+bLPyFW4sooaaGc4di
 lFTzhjtTKWdjUkBwXPpIUP5YiGDRrxg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-mEIk7QMiNr6ABqOphL4Wwg-1; Tue, 15 Sep 2020 18:41:27 -0400
X-MC-Unique: mEIk7QMiNr6ABqOphL4Wwg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8863E190A3EE;
 Tue, 15 Sep 2020 22:41:25 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9AB5860BE5;
 Tue, 15 Sep 2020 22:41:24 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 35/37] qapi/types.py: remove one-letter variables
Date: Tue, 15 Sep 2020 18:40:25 -0400
Message-Id: <20200915224027.2529813-36-jsnow@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:10:32
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
Cc: John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"John, if pylint told you to jump off a bridge, would you?"
Hey, if it looked like fun, I might.

Now that this file is clean, enable pylint checks on this file.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/pylintrc |  1 -
 scripts/qapi/types.py | 29 +++++++++++++++--------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/scripts/qapi/pylintrc b/scripts/qapi/pylintrc
index 3aebb0d228..9ca6b60caf 100644
--- a/scripts/qapi/pylintrc
+++ b/scripts/qapi/pylintrc
@@ -7,7 +7,6 @@ ignore-patterns=doc.py,
                 expr.py,
                 parser.py,
                 schema.py,
-                types.py,
                 visit.py,
 
 
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index 274d62fac8..a0a06b68c5 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -49,14 +49,14 @@ def gen_enum_lookup(name: str,
     .array = (const char *const[]) {
 ''',
                 c_name=c_name(name))
-    for m in members:
-        ret += gen_if(m.ifcond)
-        index = c_enum_const(name, m.name, prefix)
+    for member in members:
+        ret += gen_if(member.ifcond)
+        index = c_enum_const(name, member.name, prefix)
         ret += mcgen('''
         [%(index)s] = "%(name)s",
 ''',
-                     index=index, name=m.name)
-        ret += gen_endif(m.ifcond)
+                     index=index, name=member.name)
+        ret += gen_endif(member.ifcond)
 
     ret += mcgen('''
     },
@@ -79,13 +79,13 @@ def gen_enum(name: str,
 ''',
                 c_name=c_name(name))
 
-    for m in enum_members:
-        ret += gen_if(m.ifcond)
+    for member in enum_members:
+        ret += gen_if(member.ifcond)
         ret += mcgen('''
     %(c_enum)s,
 ''',
-                     c_enum=c_enum_const(name, m.name, prefix))
-        ret += gen_endif(m.ifcond)
+                     c_enum=c_enum_const(name, member.name, prefix))
+        ret += gen_endif(member.ifcond)
 
     ret += mcgen('''
 } %(c_name)s;
@@ -148,11 +148,12 @@ def gen_object(name: str, ifcond: List[str],
     objects_seen.add(name)
 
     ret = ''
-    if variants:
-        for v in variants.variants:
-            if isinstance(v.type, QAPISchemaObjectType):
-                ret += gen_object(v.type.name, v.type.ifcond, v.type.base,
-                                  v.type.local_members, v.type.variants)
+    for variant in variants.variants if variants else ():
+        obj = variant.type
+        if not isinstance(obj, QAPISchemaObjectType):
+            continue
+        ret += gen_object(obj.name, obj.ifcond, obj.base,
+                          obj.local_members, obj.variants)
 
     ret += mcgen('''
 
-- 
2.26.2



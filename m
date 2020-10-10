Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451FEC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 10:06:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAF5721655
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 10:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L7wAE4o6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF5721655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRBlW-0004Yk-Uj
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 06:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kRBb0-0007lU-6C
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 05:55:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58203)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kRBar-0002ib-KI
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 05:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602323712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ao9fLjNxzBRwBdHPAuwWjC1KIhOvq0YxftmVMBJpNAs=;
 b=L7wAE4o6Dy782auj2cdnzj3/DDrRKMm5FqH6n/mIZCzIQ2jkGIl6p3zEIaTv4y/n4oszqs
 fXWYX5G3BjZQzqhT7c28Ib2ZMiVeMM5XCjN3xSj6iTmOSrmotxcQqaQtVWPwq3dPMa5Vnz
 j5XIqjN2Gp9tD5shxqbYxm1/x0ey3X0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-h0z2hVjSNwm_OzA7JU_GoQ-1; Sat, 10 Oct 2020 05:55:10 -0400
X-MC-Unique: h0z2hVjSNwm_OzA7JU_GoQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF412107AD94;
 Sat, 10 Oct 2020 09:55:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8DC2C76640;
 Sat, 10 Oct 2020 09:55:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C9D9C112993C; Sat, 10 Oct 2020 11:55:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/34] qapi/common.py: add type hint annotations
Date: Sat, 10 Oct 2020 11:54:45 +0200
Message-Id: <20201010095504.796182-16-armbru@redhat.com>
In-Reply-To: <20201010095504.796182-1-armbru@redhat.com>
References: <20201010095504.796182-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

Annotations do not change runtime behavior.
This commit *only* adds annotations.

Note that build_params() cannot be fully annotated due to import
dependency issues.  The commit after next will take care of it.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20201009161558.107041-16-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/common.py | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 338adedef4..74a2c001ed 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -12,6 +12,7 @@
 # See the COPYING file in the top-level directory.
 
 import re
+from typing import Optional, Sequence
 
 
 EATSPACE = '\033EATSPACE.'
@@ -22,7 +23,7 @@ _C_NAME_TRANS = str.maketrans('.-', '__')
 # ENUMName -> ENUM_NAME, EnumName1 -> ENUM_NAME1
 # ENUM_NAME -> ENUM_NAME, ENUM_NAME1 -> ENUM_NAME1, ENUM_Name2 -> ENUM_NAME2
 # ENUM24_Name -> ENUM24_NAME
-def camel_to_upper(value):
+def camel_to_upper(value: str) -> str:
     c_fun_str = c_name(value, False)
     if value.isupper():
         return c_fun_str
@@ -41,7 +42,9 @@ def camel_to_upper(value):
     return new_name.lstrip('_').upper()
 
 
-def c_enum_const(type_name, const_name, prefix=None):
+def c_enum_const(type_name: str,
+                 const_name: str,
+                 prefix: Optional[str] = None) -> str:
     if prefix is not None:
         type_name = prefix
     return camel_to_upper(type_name) + '_' + c_name(const_name, False).upper()
@@ -56,7 +59,7 @@ def c_enum_const(type_name, const_name, prefix=None):
 # into substrings of a generated C function name.
 # '__a.b_c' -> '__a_b_c', 'x-foo' -> 'x_foo'
 # protect=True: 'int' -> 'q_int'; protect=False: 'int' -> 'int'
-def c_name(name, protect=True):
+def c_name(name: str, protect: bool = True) -> str:
     # ANSI X3J11/88-090, 3.1.1
     c89_words = set(['auto', 'break', 'case', 'char', 'const', 'continue',
                      'default', 'do', 'double', 'else', 'enum', 'extern',
@@ -131,24 +134,24 @@ indent = Indentation()
 
 # Generate @code with @kwds interpolated.
 # Obey indent, and strip EATSPACE.
-def cgen(code, **kwds):
+def cgen(code: str, **kwds: object) -> str:
     raw = code % kwds
     if indent:
         raw = re.sub(r'^(?!(#|$))', str(indent), raw, flags=re.MULTILINE)
     return re.sub(re.escape(EATSPACE) + r' *', '', raw)
 
 
-def mcgen(code, **kwds):
+def mcgen(code: str, **kwds: object) -> str:
     if code[0] == '\n':
         code = code[1:]
     return cgen(code, **kwds)
 
 
-def c_fname(filename):
+def c_fname(filename: str) -> str:
     return re.sub(r'[^A-Za-z0-9_]', '_', filename)
 
 
-def guardstart(name):
+def guardstart(name: str) -> str:
     return mcgen('''
 #ifndef %(name)s
 #define %(name)s
@@ -157,7 +160,7 @@ def guardstart(name):
                  name=c_fname(name).upper())
 
 
-def guardend(name):
+def guardend(name: str) -> str:
     return mcgen('''
 
 #endif /* %(name)s */
@@ -165,7 +168,7 @@ def guardend(name):
                  name=c_fname(name).upper())
 
 
-def gen_if(ifcond):
+def gen_if(ifcond: Sequence[str]) -> str:
     ret = ''
     for ifc in ifcond:
         ret += mcgen('''
@@ -174,7 +177,7 @@ def gen_if(ifcond):
     return ret
 
 
-def gen_endif(ifcond):
+def gen_endif(ifcond: Sequence[str]) -> str:
     ret = ''
     for ifc in reversed(ifcond):
         ret += mcgen('''
@@ -183,7 +186,9 @@ def gen_endif(ifcond):
     return ret
 
 
-def build_params(arg_type, boxed, extra=None):
+def build_params(arg_type,
+                 boxed: bool,
+                 extra: Optional[str] = None) -> str:
     ret = ''
     sep = ''
     if boxed:
-- 
2.26.2



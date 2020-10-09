Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFEAC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:32:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 358E520732
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Owbm5rCC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 358E520732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQvJy-0008Q9-EX
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 12:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQv4K-0004Ae-2X
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:16:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40314)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQv4G-0003Hq-JX
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602260184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uzWtOCuBHxv0uBQt9mqperOOrxpQMDVzXHiuOcdXAu8=;
 b=Owbm5rCCJrVHIJdDVPljS+HP5422QTQ8hUVLqpN8hba+LaALxUmA1M7526VsF1vEODyGoh
 Fd4BTe2sFp3QPu62SAI8MSNQBH1q0jpFTtLpOMUCKzDC90Qyq+0BeANmt/wX/+EzLyw9y4
 2dRGw4ton5H/h5PCCAO1xd8rUDX+sPs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-B7d_QcfOO_KJxNLbIM-3Aw-1; Fri, 09 Oct 2020 12:16:22 -0400
X-MC-Unique: B7d_QcfOO_KJxNLbIM-3Aw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A5B0101962D;
 Fri,  9 Oct 2020 16:16:21 +0000 (UTC)
Received: from scv.redhat.com (ovpn-112-203.rdu2.redhat.com [10.10.112.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7DFE21A92A;
 Fri,  9 Oct 2020 16:16:20 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 15/36] qapi/common.py: add type hint annotations
Date: Fri,  9 Oct 2020 12:15:37 -0400
Message-Id: <20201009161558.107041-16-jsnow@redhat.com>
In-Reply-To: <20201009161558.107041-1-jsnow@redhat.com>
References: <20201009161558.107041-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:37
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Annotations do not change runtime behavior.
This commit *only* adds annotations.

Note that build_params() cannot be fully annotated due to import
dependency issues.  The commit after next will take care of it.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
---
 scripts/qapi/common.py | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 338adedef4f..74a2c001ed9 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -12,6 +12,7 @@
 # See the COPYING file in the top-level directory.
 
 import re
+from typing import Optional, Sequence
 
 
 EATSPACE = '\033EATSPACE.'
@@ -22,7 +23,7 @@
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
@@ -131,24 +134,24 @@ def decrease(self, amount: int = 4) -> None:
 
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



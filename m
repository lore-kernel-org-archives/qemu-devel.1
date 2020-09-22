Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C00C4727D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 21:10:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 940B0206FB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 21:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="elzd7yhW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 940B0206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKpYm-0004r4-Jm
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 17:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpQ0-000270-5a
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:01:44 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56632
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpPw-0004ZK-9d
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600808492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5SQ8w3odRh+wnwdi2Hx0UP7mPEEusa6HSgBmceA9Df8=;
 b=elzd7yhWhW+8dXKccMqtoSGU+MOJMHuYmtEJmfHUqe4st1FXOqdNqNg1Uo0KrazhEVenXw
 /bOQY9rsTc6QeS4m61BgW8vIoxySij0OYjyLZvC8eTmQGZvRaxhirZ3+PVeqXFDnzfoCnq
 H6eUmwe3FVgy2OqkXe4KTt7gDiFdsGA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-9B-mL5M0OGeRS2Xw1KhDKw-1; Tue, 22 Sep 2020 17:01:28 -0400
X-MC-Unique: 9B-mL5M0OGeRS2Xw1KhDKw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 245FE8014D9;
 Tue, 22 Sep 2020 21:01:27 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 36ED75577A;
 Tue, 22 Sep 2020 21:01:26 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 14/38] qapi/common.py: Convert comments into docstrings,
 and elaborate
Date: Tue, 22 Sep 2020 17:00:37 -0400
Message-Id: <20200922210101.4081073-15-jsnow@redhat.com>
In-Reply-To: <20200922210101.4081073-1-jsnow@redhat.com>
References: <20200922210101.4081073-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 17:01:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As docstrings, they'll show up in documentation and IDE help.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/common.py | 51 ++++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 0ce4a107e6..730283722a 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -20,10 +20,18 @@
 _C_NAME_TRANS = str.maketrans('.-', '__')
 
 
-# ENUMName -> ENUM_NAME, EnumName1 -> ENUM_NAME1
-# ENUM_NAME -> ENUM_NAME, ENUM_NAME1 -> ENUM_NAME1, ENUM_Name2 -> ENUM_NAME2
-# ENUM24_Name -> ENUM24_NAME
 def camel_to_upper(value: str) -> str:
+    """
+    Converts CamelCase to CAMEL_CASE.
+
+    Examples:
+      ENUMName -> ENUM_NAME
+      EnumName1 -> ENUM_NAME1
+      ENUM_NAME -> ENUM_NAME
+      ENUM_NAME1 -> ENUM_NAME1
+      ENUM_Name2 -> ENUM_NAME2
+      ENUM24_Name -> ENUM24_NAME
+    """
     c_fun_str = c_name(value, False)
     if value.isupper():
         return c_fun_str
@@ -45,21 +53,33 @@ def camel_to_upper(value: str) -> str:
 def c_enum_const(type_name: str,
                  const_name: str,
                  prefix: Optional[str] = None) -> str:
+    """
+    Generate a C enumeration constant name.
+
+    :param type_name: The name of the enumeration.
+    :param const_name: The name of this constant.
+    :param prefix: Optional, prefix that overrides the type_name.
+    """
     if prefix is not None:
         type_name = prefix
     return camel_to_upper(type_name) + '_' + c_name(const_name, False).upper()
 
 
-# Map @name to a valid C identifier.
-# If @protect, avoid returning certain ticklish identifiers (like
-# C keywords) by prepending 'q_'.
-#
-# Used for converting 'name' from a 'name':'type' qapi definition
-# into a generated struct member, as well as converting type names
-# into substrings of a generated C function name.
-# '__a.b_c' -> '__a_b_c', 'x-foo' -> 'x_foo'
-# protect=True: 'int' -> 'q_int'; protect=False: 'int' -> 'int'
 def c_name(name: str, protect: bool = True) -> str:
+    """
+    Map `name` to a valid C identifier.
+
+    Used for converting 'name' from a 'name':'type' qapi definition
+    into a generated struct member, as well as converting type names
+    into substrings of a generated C function name.
+
+    '__a.b_c' -> '__a_b_c', 'x-foo' -> 'x_foo'
+    protect=True: 'int' -> 'q_int'; protect=False: 'int' -> 'int'
+
+    :param name: The name to map.
+    :param protect: If true, avoid returning certain ticklish identifiers
+                    (like C keywords) by prepending ``q_``.
+    """
     # ANSI X3J11/88-090, 3.1.1
     c89_words = set(['auto', 'break', 'case', 'char', 'const', 'continue',
                      'default', 'do', 'double', 'else', 'enum', 'extern',
@@ -134,9 +154,12 @@ def decrease(self, amount: int = 4) -> int:
 indent = Indentation()
 
 
-# Generate @code with @kwds interpolated.
-# Obey indent, and strip EATSPACE.
 def cgen(code: str, **kwds: object) -> str:
+    """
+    Generate `code` with `kwds` interpolated.
+
+    Obey `indent`, and strip `EATSPACE`.
+    """
     raw = code % kwds
     if indent:
         raw = re.sub(r'^(?!(#|$))', str(indent), raw, flags=re.MULTILINE)
-- 
2.26.2



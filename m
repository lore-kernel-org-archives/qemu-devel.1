Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959F8CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:06:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CED920684
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i5lyq6LG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CED920684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMpBN-0003yf-Vt
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 04:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iMp1k-0002k4-4p
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 03:56:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iMp1i-0005s7-4f
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 03:56:24 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51854
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iMp1h-0005r0-VU
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 03:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571730981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8tt0ujFNqH0oDdENo6dUGphI9Uupe4n59EzI89lI7QE=;
 b=i5lyq6LGHEoHVs2KeRj5f5jRxdJJOTyrS+55NMRMMbN4wgwNoGZ1AQ8r9NG/FOt7NBKs8x
 6I2F4E8c7A4re2cLAGnaBWLAJ3JsZcGuIHoVzjf8nMuMwy/yjtynCMEp4aOLVwSWvrOlU2
 QOeczOTZcv2VAQzg2vREyWaM85S5HQk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-CIb-pPhWO0e1Grlh8dpINg-1; Tue, 22 Oct 2019 03:56:19 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC20447B
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 07:56:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 830106012C;
 Tue, 22 Oct 2019 07:56:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 84D361132989; Tue, 22 Oct 2019 09:56:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/12] tests/qapi-schema: Tidy up test output indentation
Date: Tue, 22 Oct 2019 09:56:11 +0200
Message-Id: <20191022075615.956-9-armbru@redhat.com>
In-Reply-To: <20191022075615.956-1-armbru@redhat.com>
References: <20191022075615.956-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: CIb-pPhWO0e1Grlh8dpINg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Peter Krempa <pkrempa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Command and event details are indented three spaces, everything else
four.  Messed up in commit 156402e5042.  Use four spaces consistently.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Peter Krempa <pkrempa@redhat.com>
Message-Id: <20191018081454.21369-2-armbru@redhat.com>
---
 tests/qapi-schema/doc-good.out         |  4 +-
 tests/qapi-schema/event-case.out       |  2 +-
 tests/qapi-schema/indented-expr.out    |  4 +-
 tests/qapi-schema/qapi-schema-test.out | 52 +++++++++++++-------------
 tests/qapi-schema/test-qapi.py         |  4 +-
 5 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.ou=
t
index d3bca343eb..6562e1f412 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -46,9 +46,9 @@ object q_obj_cmd-arg
     member arg2: str optional=3DTrue
     member arg3: bool optional=3DFalse
 command cmd q_obj_cmd-arg -> Object
-   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
+    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
 command cmd-boxed Object -> None
-   gen=3DTrue success_response=3DTrue boxed=3DTrue oob=3DFalse preconfig=
=3DFalse
+    gen=3DTrue success_response=3DTrue boxed=3DTrue oob=3DFalse preconfig=
=3DFalse
 doc freeform
     body=3D
 =3D Section
diff --git a/tests/qapi-schema/event-case.out b/tests/qapi-schema/event-cas=
e.out
index ec8a1406e4..42ae519656 100644
--- a/tests/qapi-schema/event-case.out
+++ b/tests/qapi-schema/event-case.out
@@ -11,4 +11,4 @@ enum QType
     member qbool
 module event-case.json
 event oops None
-   boxed=3DFalse
+    boxed=3DFalse
diff --git a/tests/qapi-schema/indented-expr.out b/tests/qapi-schema/indent=
ed-expr.out
index bffdf6756d..04356775cd 100644
--- a/tests/qapi-schema/indented-expr.out
+++ b/tests/qapi-schema/indented-expr.out
@@ -11,6 +11,6 @@ enum QType
     member qbool
 module indented-expr.json
 command eins None -> None
-   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
+    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
 command zwei None -> None
-   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
+    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qap=
i-schema-test.out
index 98031da96f..aca43186a9 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -33,7 +33,7 @@ object Union
     case value3: q_empty
     case value4: q_empty
 command user_def_cmd0 Empty2 -> Empty2
-   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
+    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
 enum QEnumTwo
     prefix QENUM_TWO
     member value1
@@ -205,35 +205,35 @@ object SecondArrayRef
     member s: StatusList optional=3DFalse
 module qapi-schema-test.json
 command user_def_cmd None -> None
-   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
+    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
 object q_obj_user_def_cmd1-arg
     member ud1a: UserDefOne optional=3DFalse
 command user_def_cmd1 q_obj_user_def_cmd1-arg -> None
-   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
+    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
 object q_obj_user_def_cmd2-arg
     member ud1a: UserDefOne optional=3DFalse
     member ud1b: UserDefOne optional=3DTrue
 command user_def_cmd2 q_obj_user_def_cmd2-arg -> UserDefTwo
-   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
+    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
 command cmd-success-response None -> None
-   gen=3DTrue success_response=3DFalse boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
+    gen=3DTrue success_response=3DFalse boxed=3DFalse oob=3DFalse preconfi=
g=3DFalse
 object q_obj_guest-get-time-arg
     member a: int optional=3DFalse
     member b: int optional=3DTrue
 command guest-get-time q_obj_guest-get-time-arg -> int
-   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
+    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
 object q_obj_guest-sync-arg
     member arg: any optional=3DFalse
 command guest-sync q_obj_guest-sync-arg -> any
-   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
+    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
 command boxed-struct UserDefZero -> None
-   gen=3DTrue success_response=3DTrue boxed=3DTrue oob=3DFalse preconfig=
=3DFalse
+    gen=3DTrue success_response=3DTrue boxed=3DTrue oob=3DFalse preconfig=
=3DFalse
 command boxed-union UserDefListUnion -> None
-   gen=3DTrue success_response=3DTrue boxed=3DTrue oob=3DFalse preconfig=
=3DFalse
+    gen=3DTrue success_response=3DTrue boxed=3DTrue oob=3DFalse preconfig=
=3DFalse
 command boxed-empty Empty1 -> None
-   gen=3DTrue success_response=3DTrue boxed=3DTrue oob=3DFalse preconfig=
=3DFalse
+    gen=3DTrue success_response=3DTrue boxed=3DTrue oob=3DFalse preconfig=
=3DFalse
 command test-flags-command None -> None
-   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DTrue preconfig=
=3DTrue
+    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DTrue preconfig=
=3DTrue
 object UserDefOptions
     member i64: intList optional=3DTrue
     member u64: uint64List optional=3DTrue
@@ -245,28 +245,28 @@ object EventStructOne
     member string: str optional=3DFalse
     member enum2: EnumOne optional=3DTrue
 event EVENT_A None
-   boxed=3DFalse
+    boxed=3DFalse
 event EVENT_B None
-   boxed=3DFalse
+    boxed=3DFalse
 object q_obj_EVENT_C-arg
     member a: int optional=3DTrue
     member b: UserDefOne optional=3DTrue
     member c: str optional=3DFalse
 event EVENT_C q_obj_EVENT_C-arg
-   boxed=3DFalse
+    boxed=3DFalse
 object q_obj_EVENT_D-arg
     member a: EventStructOne optional=3DFalse
     member b: str optional=3DFalse
     member c: str optional=3DTrue
     member enum3: EnumOne optional=3DTrue
 event EVENT_D q_obj_EVENT_D-arg
-   boxed=3DFalse
+    boxed=3DFalse
 event EVENT_E UserDefZero
-   boxed=3DTrue
+    boxed=3DTrue
 event EVENT_F UserDefFlatUnion
-   boxed=3DTrue
+    boxed=3DTrue
 event EVENT_G Empty1
-   boxed=3DTrue
+    boxed=3DTrue
 enum __org.qemu_x-Enum
     member __org.qemu_x-value
 object __org.qemu_x-Base
@@ -297,7 +297,7 @@ alternate __org.qemu_x-Alt
     tag type
     case __org.qemu_x-branch: __org.qemu_x-Base
 event __ORG.QEMU_X-EVENT __org.qemu_x-Struct
-   boxed=3DFalse
+    boxed=3DFalse
 array __org.qemu_x-EnumList __org.qemu_x-Enum
 array __org.qemu_x-StructList __org.qemu_x-Struct
 object q_obj___org.qemu_x-command-arg
@@ -306,7 +306,7 @@ object q_obj___org.qemu_x-command-arg
     member c: __org.qemu_x-Union2 optional=3DFalse
     member d: __org.qemu_x-Alt optional=3DFalse
 command __org.qemu_x-command q_obj___org.qemu_x-command-arg -> __org.qemu_=
x-Union1
-   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
+    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
 object TestIfStruct
     member foo: int optional=3DFalse
     member bar: int optional=3DFalse
@@ -335,7 +335,7 @@ object q_obj_TestIfUnionCmd-arg
     member union_cmd_arg: TestIfUnion optional=3DFalse
     if ['defined(TEST_IF_UNION)']
 command TestIfUnionCmd q_obj_TestIfUnionCmd-arg -> None
-   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
+    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
     if ['defined(TEST_IF_UNION)']
 alternate TestIfAlternate
     tag type
@@ -347,7 +347,7 @@ object q_obj_TestIfAlternateCmd-arg
     member alt_cmd_arg: TestIfAlternate optional=3DFalse
     if ['defined(TEST_IF_ALT)']
 command TestIfAlternateCmd q_obj_TestIfAlternateCmd-arg -> None
-   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
+    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
     if ['defined(TEST_IF_ALT)']
 object q_obj_TestIfCmd-arg
     member foo: TestIfStruct optional=3DFalse
@@ -355,10 +355,10 @@ object q_obj_TestIfCmd-arg
         if ['defined(TEST_IF_CMD_BAR)']
     if ['defined(TEST_IF_CMD)', 'defined(TEST_IF_STRUCT)']
 command TestIfCmd q_obj_TestIfCmd-arg -> UserDefThree
-   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
+    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
     if ['defined(TEST_IF_CMD)', 'defined(TEST_IF_STRUCT)']
 command TestCmdReturnDefThree None -> UserDefThree
-   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
+    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
 array TestIfEnumList TestIfEnum
     if ['defined(TEST_IF_ENUM)']
 object q_obj_TestIfEvent-arg
@@ -367,7 +367,7 @@ object q_obj_TestIfEvent-arg
         if ['defined(TEST_IF_EVT_BAR)']
     if ['defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)']
 event TestIfEvent q_obj_TestIfEvent-arg
-   boxed=3DFalse
+    boxed=3DFalse
     if ['defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)']
 object FeatureStruct0
     member foo: int optional=3DFalse
@@ -411,4 +411,4 @@ object q_obj_test-features-arg
     member cfs2: CondFeatureStruct2 optional=3DFalse
     member cfs3: CondFeatureStruct3 optional=3DFalse
 command test-features q_obj_test-features-arg -> None
-   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
+    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.p=
y
index 664254618a..29d9435bf7 100755
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -76,13 +76,13 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
         print('command %s %s -> %s'
               % (name, arg_type and arg_type.name,
                  ret_type and ret_type.name))
-        print('   gen=3D%s success_response=3D%s boxed=3D%s oob=3D%s preco=
nfig=3D%s'
+        print('    gen=3D%s success_response=3D%s boxed=3D%s oob=3D%s prec=
onfig=3D%s'
               % (gen, success_response, boxed, allow_oob, allow_preconfig)=
)
         self._print_if(ifcond)
=20
     def visit_event(self, name, info, ifcond, arg_type, boxed):
         print('event %s %s' % (name, arg_type and arg_type.name))
-        print('   boxed=3D%s' % boxed)
+        print('    boxed=3D%s' % boxed)
         self._print_if(ifcond)
=20
     @staticmethod
--=20
2.21.0



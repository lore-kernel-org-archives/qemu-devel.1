Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85398C83002
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 05:34:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FBD82082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 05:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cHz8NwuP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FBD82082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU1qI-0002fj-Dy
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 01:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jU1n6-00055g-7m
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 01:31:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jU1n0-0002eV-CI
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 01:31:19 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60721
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jU1mz-0002cz-05
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 01:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588224671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aQ2V8I06TRh/yCSDwVBZnjKc28nYXGyrW6V12H/La1I=;
 b=cHz8NwuPDOPUYIQZWj+rc35BUvvjbek4kKA6Wag+Cd72kts0BpPW9YoML3z6nV0iKavGwq
 DXCGAnqZRy8b2ORB3EseiOL1tVgdhz7l+SweOR95skx9mloGDfrt1rfjMXPpqf4DUyc7FJ
 ZVY/ZhVPt4OM2ivkPJFFIQJSMkLOLn4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-RxpMF8QKNpWGcE9_FI21wg-1; Thu, 30 Apr 2020 01:31:09 -0400
X-MC-Unique: RxpMF8QKNpWGcE9_FI21wg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 383BAA0BD8
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 05:31:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D6AC65C1BE;
 Thu, 30 Apr 2020 05:31:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F0B1A11358C6; Thu, 30 Apr 2020 07:31:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/20] qapi: Polish prose in visitor.h
Date: Thu, 30 Apr 2020 07:30:54 +0200
Message-Id: <20200430053104.32204-11-armbru@redhat.com>
In-Reply-To: <20200430053104.32204-1-armbru@redhat.com>
References: <20200430053104.32204-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:04:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200424084338.26803-6-armbru@redhat.com>
---
 include/qapi/visitor.h | 104 +++++++++++++++++++++--------------------
 1 file changed, 54 insertions(+), 50 deletions(-)

diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
index 09df7099c6..a425ea514c 100644
--- a/include/qapi/visitor.h
+++ b/include/qapi/visitor.h
@@ -25,19 +25,21 @@
  * for doing work at each node of a QAPI graph; it can also be used
  * for a virtual walk, where there is no actual QAPI C struct.
  *
- * There are four kinds of visitor classes: input visitors (QObject,
- * string, and QemuOpts) parse an external representation and build
- * the corresponding QAPI graph, output visitors (QObject and string) take
- * a completed QAPI graph and generate an external representation, the
- * dealloc visitor can take a QAPI graph (possibly partially
- * constructed) and recursively free its resources, and the clone
- * visitor performs a deep clone of one QAPI object to another.  While
- * the dealloc and QObject input/output visitors are general, the string,
- * QemuOpts, and clone visitors have some implementation limitations;
- * see the documentation for each visitor for more details on what it
- * supports.  Also, see visitor-impl.h for the callback contracts
- * implemented by each visitor, and docs/devel/qapi-code-gen.txt for more
- * about the QAPI code generator.
+ * There are four kinds of visitors: input visitors (QObject, string,
+ * and QemuOpts) parse an external representation and build the
+ * corresponding QAPI object, output visitors (QObject and string)
+ * take a QAPI object and generate an external representation, the
+ * dealloc visitor takes a QAPI object (possibly partially
+ * constructed) and recursively frees it, and the clone visitor
+ * performs a deep clone of a QAPI object.
+ *
+ * While the dealloc and QObject input/output visitors are general,
+ * the string, QemuOpts, and clone visitors have some implementation
+ * limitations; see the documentation for each visitor for more
+ * details on what it supports.  Also, see visitor-impl.h for the
+ * callback contracts implemented by each visitor, and
+ * docs/devel/qapi-code-gen.txt for more about the QAPI code
+ * generator.
  *
  * All of the visitors are created via:
  *
@@ -45,11 +47,15 @@
  *
  * A visitor should be used for exactly one top-level visit_type_FOO()
  * or virtual walk; if that is successful, the caller can optionally
- * call visit_complete() (for now, useful only for output visits, but
- * safe to call on all visits).  Then, regardless of success or
- * failure, the user should call visit_free() to clean up resources.
- * It is okay to free the visitor without completing the visit, if
- * some other error is detected in the meantime.
+ * call visit_complete() (useful only for output visits, but safe to
+ * call on all visits).  Then, regardless of success or failure, the
+ * user should call visit_free() to clean up resources.  It is okay to
+ * free the visitor without completing the visit, if some other error
+ * is detected in the meantime.
+ *
+ * The clone and dealloc visitor should not be used directly outside
+ * of QAPI code.  Use the qapi_free_FOO() and QAPI_CLONE() instead,
+ * described below.
  *
  * All QAPI types have a corresponding function with a signature
  * roughly compatible with this:
@@ -68,22 +74,26 @@
  * alternate, @name should equal the name used for visiting the
  * alternate.
  *
- * The visit_type_FOO() functions expect a non-null @obj argument;
- * they allocate *@obj during input visits, leave it unchanged on
- * output visits, and recursively free any resources during a dealloc
- * visit.  Each function also takes the customary @errp argument (see
+ * The visit_type_FOO() functions take a non-null @obj argument; they
+ * allocate *@obj during input visits, leave it unchanged during
+ * output and clone visits, and free it (recursively) during a dealloc
+ * visit.
+ *
+ * Each function also takes the customary @errp argument (see
  * qapi/error.h for details), for reporting any errors (such as if a
  * member @name is not present, or is present but not the specified
  * type).
  *
  * If an error is detected during visit_type_FOO() with an input
- * visitor, then *@obj will be NULL for pointer types, and left
- * unchanged for scalar types.  Using an output or clone visitor with
- * an incomplete object has undefined behavior (other than a special
- * case for visit_type_str() treating NULL like ""), while the dealloc
- * visitor safely handles incomplete objects.  Since input visitors
- * never produce an incomplete object, such an object is possible only
- * by manual construction.
+ * visitor, then *@obj will be set to NULL for pointer types, and left
+ * unchanged for scalar types.
+ *
+ * Using an output or clone visitor with an incomplete object has
+ * undefined behavior (other than a special case for visit_type_str()
+ * treating NULL like ""), while the dealloc visitor safely handles
+ * incomplete objects.  Since input visitors never produce an
+ * incomplete object, such an object is possible only by manual
+ * construction.
  *
  * For the QAPI object types (structs, unions, and alternates), there
  * is an additional generated function in qapi-visit-MODULE.h
@@ -100,23 +110,20 @@
  *
  * void qapi_free_FOO(FOO *obj);
  *
- * where behaves like free() in that @obj may be NULL.  Such objects
- * may also be used with the following macro, provided alongside the
- * clone visitor:
+ * Does nothing when @obj is NULL.
+ *
+ * Such objects may also be used with macro
  *
  * Type *QAPI_CLONE(Type, src);
  *
- * in order to perform a deep clone of @src.  Because of the generated
- * qapi_free functions and the QAPI_CLONE() macro, the clone and
- * dealloc visitor should not be used directly outside of QAPI code.
+ * in order to perform a deep clone of @src.
  *
- * QAPI types can also inherit from a base class; when this happens, a
- * function is generated for easily going from the derived type to the
- * base type:
+ * For QAPI types can that inherit from a base type, a function is
+ * generated for going from the derived type to the base type:
  *
  * BASE *qapi_CHILD_base(CHILD *obj);
  *
- * For a real QAPI struct, typical input usage involves:
+ * Typical input visitor usage involves:
  *
  * <example>
  *  Foo *f;
@@ -153,7 +160,7 @@
  *  qapi_free_FooList(l);
  * </example>
  *
- * Similarly, typical output usage is:
+ * Typical output visitor usage:
  *
  * <example>
  *  Foo *f =3D ...obtain populated object...
@@ -172,17 +179,8 @@
  *  visit_free(v);
  * </example>
  *
- * When visiting a real QAPI struct, this file provides several
- * helpers that rely on in-tree information to control the walk:
- * visit_optional() for the 'has_member' field associated with
- * optional 'member' in the C struct; and visit_next_list() for
- * advancing through a FooList linked list.  Similarly, the
- * visit_is_input() helper makes it possible to write code that is
- * visitor-agnostic everywhere except for cleanup.  Only the generated
- * visit_type functions need to use these helpers.
- *
  * It is also possible to use the visitors to do a virtual walk, where
- * no actual QAPI struct is present.  In this situation, decisions
+ * no actual QAPI object is present.  In this situation, decisions
  * about what needs to be walked are made by the calling code, and
  * structured visits are split between pairs of start and end methods
  * (where the end method must be called if the start function
@@ -227,6 +225,12 @@
  * out:
  *  visit_free(v);
  * </example>
+ *
+ * This file provides helpers for use by the generated
+ * visit_type_FOO(): visit_optional() for the 'has_member' field
+ * associated with optional 'member' in the C struct,
+ * visit_next_list() for advancing through a FooList linked list, and
+ * visit_is_input() for cleaning up on failure.
  */
=20
 /*** Useful types ***/
--=20
2.21.1



Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07726C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 21:29:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7377D206ED
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 21:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TgsEXeM0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7377D206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcEjY-0000H4-DP
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 16:29:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kcEg0-0003tg-QG
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 16:26:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20231)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kcEfv-0005ao-R7
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 16:26:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604957167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mqjSxmtyytIvtr/jbMfZrxqKMEvbF2yA6d1phOfsCeA=;
 b=TgsEXeM0sAf3ZTubM71WE3OWTuiu8poZEPIJgSYRmtwZXjGulh8Np3T/y9hh2ZFnvuB2dv
 9Ib2WpGlSm9JNU+FKNzEhq31wqvVLJ3uzlkk3XGewgSKULef23FcDnumX26hYgZ44ZFPJy
 UC9pLkwjd5B24TvnL79PhC4W0Y9CgMY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-tWM-M0sqPACrn9m18rMuEA-1; Mon, 09 Nov 2020 16:26:00 -0500
X-MC-Unique: tWM-M0sqPACrn9m18rMuEA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 228BF835B8E
 for <qemu-devel@nongnu.org>; Mon,  9 Nov 2020 21:25:59 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DEA8D5D9CC;
 Mon,  9 Nov 2020 21:25:58 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/8] qobject: Include API docs in docs/devel/qobject.html
Date: Mon,  9 Nov 2020 16:25:49 -0500
Message-Id: <20201109212556.3934583-2-ehabkost@redhat.com>
In-Reply-To: <20201109212556.3934583-1-ehabkost@redhat.com>
References: <20201109212556.3934583-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Render existing doc comments at docs/devel/qobject.html.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 docs/devel/index.rst       |  1 +
 docs/devel/qobject.rst     | 11 +++++++++
 include/qapi/qmp/qnum.h    |  4 +++-
 include/qapi/qmp/qobject.h | 48 +++++++++++++++++++++++++-------------
 qobject/qnum.c             | 19 ++++++++++++---
 5 files changed, 63 insertions(+), 20 deletions(-)
 create mode 100644 docs/devel/qobject.rst

diff --git a/docs/devel/index.rst b/docs/devel/index.rst
index 77baae5c77..7f8e5e3071 100644
--- a/docs/devel/index.rst
+++ b/docs/devel/index.rst
@@ -34,3 +34,4 @@ Contents:
    clocks
    qom
    block-coroutine-wrapper
+   qobject
diff --git a/docs/devel/qobject.rst b/docs/devel/qobject.rst
new file mode 100644
index 0000000000..4f192ced7c
--- /dev/null
+++ b/docs/devel/qobject.rst
@@ -0,0 +1,11 @@
+QObject API
+===========
+
+.. kernel-doc:: include/qapi/qmp/qobject.h
+
+QNum module
+-----------
+
+.. kernel-doc:: include/qapi/qmp/qnum.h
+
+.. kernel-doc:: qobject/qnum.c
diff --git a/include/qapi/qmp/qnum.h b/include/qapi/qmp/qnum.h
index bbae0a5ec8..25f4733efc 100644
--- a/include/qapi/qmp/qnum.h
+++ b/include/qapi/qmp/qnum.h
@@ -23,7 +23,9 @@ typedef enum {
     QNUM_DOUBLE
 } QNumKind;
 
-/*
+/**
+ * DOC:
+ *
  * QNum encapsulates how our dialect of JSON fills in the blanks left
  * by the JSON specification (RFC 8259) regarding numbers.
  *
diff --git a/include/qapi/qmp/qobject.h b/include/qapi/qmp/qobject.h
index fcfd549220..bdc33bdb65 100644
--- a/include/qapi/qmp/qobject.h
+++ b/include/qapi/qmp/qobject.h
@@ -1,5 +1,5 @@
 /*
- * QEMU Object Model.
+ * QObject API
  *
  * Based on ideas by Avi Kivity <avi@redhat.com>
  *
@@ -10,24 +10,31 @@
  *
  * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
+ */
+
+/**
+ * DOC: QObject Reference Counts Terminology
  *
- * QObject Reference Counts Terminology
- * ------------------------------------
+ * Returning references
+ * --------------------
  *
- *  - Returning references: A function that returns an object may
- *  return it as either a weak or a strong reference.  If the
- *  reference is strong, you are responsible for calling
- *  qobject_unref() on the reference when you are done.
+ * A function that returns an object may return it as either a
+ * weak or a strong reference.  If the reference is strong, you
+ * are responsible for calling qobject_unref() on the reference
+ * when you are done.
  *
- *  If the reference is weak, the owner of the reference may free it at
- *  any time in the future.  Before storing the reference anywhere, you
- *  should call qobject_ref() to make the reference strong.
+ * If the reference is weak, the owner of the reference may free it at
+ * any time in the future.  Before storing the reference anywhere, you
+ * should call qobject_ref() to make the reference strong.
  *
- *  - Transferring ownership: when you transfer ownership of a reference
- *  by calling a function, you are no longer responsible for calling
- *  qobject_unref() when the reference is no longer needed.  In other words,
- *  when the function returns you must behave as if the reference to the
- *  passed object was weak.
+ * Transferring ownership
+ * ----------------------
+ *
+ * When you transfer ownership of a reference by calling a
+ * function, you are no longer responsible for calling
+ * qobject_unref() when the reference is no longer needed.  In
+ * other words, when the function returns you must behave as if
+ * the reference to the passed object was weak.
  */
 #ifndef QOBJECT_H
 #define QOBJECT_H
@@ -81,6 +88,8 @@ static inline void qobject_ref_impl(QObject *obj)
 
 /**
  * qobject_is_equal(): Return whether the two objects are equal.
+ * @x: QObject pointer
+ * @y: QObject pointer
  *
  * Any of the pointers may be NULL; return true if both are.  Always
  * return false if only one is (therefore a QNull object is not
@@ -90,6 +99,7 @@ bool qobject_is_equal(const QObject *x, const QObject *y);
 
 /**
  * qobject_destroy(): Free resources used by the object
+ * @obj: QObject pointer
  */
 void qobject_destroy(QObject *obj);
 
@@ -103,6 +113,7 @@ static inline void qobject_unref_impl(QObject *obj)
 
 /**
  * qobject_ref(): Increment QObject's reference count
+ * @obj: QObject pointer
  *
  * Returns: the same @obj. The type of @obj will be propagated to the
  * return type.
@@ -115,12 +126,14 @@ static inline void qobject_unref_impl(QObject *obj)
 
 /**
  * qobject_unref(): Decrement QObject's reference count, deallocate
- * when it reaches zero
+ *                  when it reaches zero
+ * @obj: QObject pointer
  */
 #define qobject_unref(obj) qobject_unref_impl(QOBJECT(obj))
 
 /**
  * qobject_type(): Return the QObject's type
+ * @obj: QObject pointer
  */
 static inline QType qobject_type(const QObject *obj)
 {
@@ -130,6 +143,9 @@ static inline QType qobject_type(const QObject *obj)
 
 /**
  * qobject_check_type(): Helper function for the qobject_to() macro.
+ * @obj: QObject pointer
+ * @type: Expected type of QObject
+ *
  * Return @obj, but only if @obj is not NULL and @type is equal to
  * @obj's type.  Return NULL otherwise.
  */
diff --git a/qobject/qnum.c b/qobject/qnum.c
index 7012fc57f2..017c8aa739 100644
--- a/qobject/qnum.c
+++ b/qobject/qnum.c
@@ -17,6 +17,7 @@
 
 /**
  * qnum_from_int(): Create a new QNum from an int64_t
+ * @value: int64_t value
  *
  * Return strong reference.
  */
@@ -33,6 +34,7 @@ QNum *qnum_from_int(int64_t value)
 
 /**
  * qnum_from_uint(): Create a new QNum from an uint64_t
+ * @value: uint64_t value
  *
  * Return strong reference.
  */
@@ -49,6 +51,7 @@ QNum *qnum_from_uint(uint64_t value)
 
 /**
  * qnum_from_double(): Create a new QNum from a double
+ * @value: double value
  *
  * Return strong reference.
  */
@@ -65,6 +68,8 @@ QNum *qnum_from_double(double value)
 
 /**
  * qnum_get_try_int(): Get an integer representation of the number
+ * @qn: QNum object
+ * @val: pointer to value
  *
  * Return true on success.
  */
@@ -90,6 +95,7 @@ bool qnum_get_try_int(const QNum *qn, int64_t *val)
 
 /**
  * qnum_get_int(): Get an integer representation of the number
+ * @qn: QNum object
  *
  * assert() on failure.
  */
@@ -102,7 +108,9 @@ int64_t qnum_get_int(const QNum *qn)
 }
 
 /**
- * qnum_get_uint(): Get an unsigned integer from the number
+ * qnum_value_get_try_uint(): Get an unsigned integer from the number
+ * @qn: QNum object
+ * @val: pointer to value
  *
  * Return true on success.
  */
@@ -128,6 +136,7 @@ bool qnum_get_try_uint(const QNum *qn, uint64_t *val)
 
 /**
  * qnum_get_uint(): Get an unsigned integer from the number
+ * @qn: QNum object
  *
  * assert() on failure.
  */
@@ -141,6 +150,7 @@ uint64_t qnum_get_uint(const QNum *qn)
 
 /**
  * qnum_get_double(): Get a float representation of the number
+ * @qn: QNum object
  *
  * qnum_get_double() loses precision for integers beyond 53 bits.
  */
@@ -200,6 +210,8 @@ char *qnum_to_string(QNum *qn)
 
 /**
  * qnum_is_equal(): Test whether the two QNums are equal
+ * @x: QNum object
+ * @y: QNum object
  *
  * Negative integers are never considered equal to unsigned integers,
  * but positive integers in the range [0, INT64_MAX] are considered
@@ -253,8 +265,9 @@ bool qnum_is_equal(const QObject *x, const QObject *y)
 }
 
 /**
- * qnum_destroy_obj(): Free all memory allocated by a
- * QNum object
+ * qnum_destroy_obj(): Free all memory allocated by a QNum object
+ *
+ * @obj: QNum object to be destroyed
  */
 void qnum_destroy_obj(QObject *obj)
 {
-- 
2.28.0



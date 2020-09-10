Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5D0C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 22:18:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BB83208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 22:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O0wiLpLc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BB83208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGUu7-0006hM-Cs
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 18:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGUqs-0001N1-Q7
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 18:15:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55758)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGUqq-0002Y6-K1
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 18:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599776131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=60kJRWsv9vXT2j/z3MQG9A7zs7ChKkqbd7xOBFxgyCY=;
 b=O0wiLpLcWExXzfqF0U11/gYfG9DJhU2Ajq27JUNMgAd1HifSFpcvTY93Y++yYCptpSLD6m
 Q6ilYrqcPvDP7bb/DcBvZmqan6yJD73527ShbaTjoHI/gBEdmW/6ouKGChasyqWF8E8yiZ
 TQezU43Sd5sNT1OLcnWQPh1l/ILEQ7o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-4tHtf9T2N8SVd7_jIjDE8A-1; Thu, 10 Sep 2020 18:15:29 -0400
X-MC-Unique: 4tHtf9T2N8SVd7_jIjDE8A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3905A1084C83;
 Thu, 10 Sep 2020 22:15:28 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ED4F260BF1;
 Thu, 10 Sep 2020 22:15:27 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/9] qom: Document all function parameters in doc comments
Date: Thu, 10 Sep 2020 18:15:18 -0400
Message-Id: <20200910221526.10041-2-ehabkost@redhat.com>
In-Reply-To: <20200910221526.10041-1-ehabkost@redhat.com>
References: <20200910221526.10041-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 18:15:31
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

kernel-doc requires all function parameters to be documented, so
document them all.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qom/object.h | 47 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 056f67ab3b..ad2b91ec6c 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1176,6 +1176,11 @@ Object *object_dynamic_cast(Object *obj, const char *typename);
 
 /**
  * object_dynamic_cast_assert:
+ * @obj: The object to cast.
+ * @typename: The @typename to cast to.
+ * @file: Source code file where function was called
+ * @line: Source code line where function was called
+ * @func: Name of function where this function was called
  *
  * See object_dynamic_cast() for a description of the parameters of this
  * function.  The only difference in behavior is that this function asserts
@@ -1252,6 +1257,9 @@ type_init(do_qemu_init_ ## type_array)
  * object_class_dynamic_cast_assert:
  * @klass: The #ObjectClass to attempt to cast.
  * @typename: The QOM typename of the class to cast to.
+ * @file: Source code file where function was called
+ * @line: Source code line where function was called
+ * @func: Name of function where this function was called
  *
  * See object_class_dynamic_cast() for a description of the parameters
  * of this function.  The only difference in behavior is that this function
@@ -1403,6 +1411,23 @@ ObjectProperty *object_property_try_add(Object *obj, const char *name,
  * object_property_add:
  * Same as object_property_try_add() with @errp hardcoded to
  * &error_abort.
+ *
+ * @obj: the object to add a property to
+ * @name: the name of the property.  This can contain any character except for
+ *  a forward slash.  In general, you should use hyphens '-' instead of
+ *  underscores '_' when naming properties.
+ * @type: the type name of the property.  This namespace is pretty loosely
+ *   defined.  Sub namespaces are constructed by using a prefix and then
+ *   to angle brackets.  For instance, the type 'virtio-net-pci' in the
+ *   'link' namespace would be 'link<virtio-net-pci>'.
+ * @get: The getter to be called to read a property.  If this is NULL, then
+ *   the property cannot be read.
+ * @set: the setter to be called to write a property.  If this is NULL,
+ *   then the property cannot be written.
+ * @release: called when the property is removed from the object.  This is
+ *   meant to allow a property to free its opaque upon object
+ *   destruction.  This may be NULL.
+ * @opaque: an opaque pointer to pass to the callbacks for the property
  */
 ObjectProperty *object_property_add(Object *obj, const char *name,
                                     const char *type,
@@ -1476,6 +1501,7 @@ typedef struct ObjectPropertyIterator {
 
 /**
  * object_property_iter_init:
+ * @iter: the iterator instance
  * @obj: the object
  *
  * Initializes an iterator for traversing all properties
@@ -1504,6 +1530,7 @@ void object_property_iter_init(ObjectPropertyIterator *iter,
 
 /**
  * object_class_property_iter_init:
+ * @iter: the iterator instance
  * @klass: the class
  *
  * Initializes an iterator for traversing all properties
@@ -1551,6 +1578,7 @@ bool object_property_get(Object *obj, const char *name, Visitor *v,
 
 /**
  * object_property_set_str:
+ * @obj: the object
  * @name: the name of the property
  * @value: the value to be written to the property
  * @errp: returns an error if this function fails
@@ -1577,6 +1605,7 @@ char *object_property_get_str(Object *obj, const char *name,
 
 /**
  * object_property_set_link:
+ * @obj: the object
  * @name: the name of the property
  * @value: the value to be written to the property
  * @errp: returns an error if this function fails
@@ -1607,6 +1636,7 @@ Object *object_property_get_link(Object *obj, const char *name,
 
 /**
  * object_property_set_bool:
+ * @obj: the object
  * @name: the name of the property
  * @value: the value to be written to the property
  * @errp: returns an error if this function fails
@@ -1632,6 +1662,7 @@ bool object_property_get_bool(Object *obj, const char *name,
 
 /**
  * object_property_set_int:
+ * @obj: the object
  * @name: the name of the property
  * @value: the value to be written to the property
  * @errp: returns an error if this function fails
@@ -1657,6 +1688,7 @@ int64_t object_property_get_int(Object *obj, const char *name,
 
 /**
  * object_property_set_uint:
+ * @obj: the object
  * @name: the name of the property
  * @value: the value to be written to the property
  * @errp: returns an error if this function fails
@@ -1780,6 +1812,7 @@ Object *object_get_internal_root(void);
 
 /**
  * object_get_canonical_path_component:
+ * @obj: the object
  *
  * Returns: The final component in the object's canonical path.  The canonical
  * path is the path within the composition tree starting from the root.
@@ -1789,6 +1822,7 @@ const char *object_get_canonical_path_component(const Object *obj);
 
 /**
  * object_get_canonical_path:
+ * @obj: the object
  *
  * Returns: The canonical path for a object, newly allocated.  This is
  * the path within the composition tree starting from the root.  Use
@@ -1878,6 +1912,10 @@ ObjectProperty *object_property_try_add_child(Object *obj, const char *name,
 
 /**
  * object_property_add_child:
+ * @obj: the object to add a property to
+ * @name: the name of the property
+ * @child: the child object
+ *
  * Same as object_property_try_add_child() with @errp hardcoded to
  * &error_abort
  */
@@ -1895,13 +1933,17 @@ typedef enum {
 
 /**
  * object_property_allow_set_link:
+ * @obj: the object to add a property to
+ * @name: the name of the property
+ * @child: the child object
+ * @errp: pointer to error object
  *
  * The default implementation of the object_property_add_link() check()
  * callback function.  It allows the link property to be set and never returns
  * an error.
  */
-void object_property_allow_set_link(const Object *, const char *,
-                                    Object *, Error **);
+void object_property_allow_set_link(const Object *obj, const char *name,
+                                    Object *child, Error **errp);
 
 /**
  * object_property_add_link:
@@ -1995,6 +2037,7 @@ ObjectProperty *object_class_property_add_bool(ObjectClass *klass,
  * @obj: the object to add a property to
  * @name: the name of the property
  * @typename: the name of the enum data type
+ * @lookup: enum value namelookup table
  * @get: the getter or %NULL if the property is write-only.
  * @set: the setter or %NULL if the property is read-only
  *
-- 
2.26.2



Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0B7C4741F
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:17:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7F6C23600
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YCig7G2G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F6C23600
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLOJm-0004VY-Mu
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 06:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNUA-00024w-VD
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:24:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51171)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNU8-0006AC-51
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:24:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600939455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YR0eNptahBdVqNvtWe3Oz45TLkJtCDSMYfvOzUxnlCo=;
 b=YCig7G2GEts9e7d9xUr+PkHbTe4Xp2HAZ2LUdMVD9bKoitijv2RFr9FHIEJgoGiFvN7Hrz
 wn6DO+4JsruJKYHO606nU2J/7EEshHEOz5UW++azdbsq7dmLH4SUfhcWT1Glg0RQYth5gi
 Jtr9pUgBZS501O5+fZ94zfjKVpCxLuY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-XVWwYrBJMoul44AkeeaYbw-1; Thu, 24 Sep 2020 05:24:13 -0400
X-MC-Unique: XVWwYrBJMoul44AkeeaYbw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72EF2427C0
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 09:24:12 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C77CC6198D;
 Thu, 24 Sep 2020 09:24:09 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 66/92] qom: Document all function parameters in doc comments
Date: Thu, 24 Sep 2020 05:22:48 -0400
Message-Id: <20200924092314.1722645-67-pbonzini@redhat.com>
In-Reply-To: <20200924092314.1722645-1-pbonzini@redhat.com>
References: <20200924092314.1722645-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eduardo Habkost <ehabkost@redhat.com>

kernel-doc requires all function parameters to be documented, so
document them all.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20200910221526.10041-2-ehabkost@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qom/object.h | 47 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 19cccd3f5f..fe0c9b7735 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1179,6 +1179,11 @@ Object *object_dynamic_cast(Object *obj, const char *typename);
 
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
@@ -1255,6 +1260,9 @@ type_init(do_qemu_init_ ## type_array)
  * object_class_dynamic_cast_assert:
  * @klass: The #ObjectClass to attempt to cast.
  * @typename: The QOM typename of the class to cast to.
+ * @file: Source code file where function was called
+ * @line: Source code line where function was called
+ * @func: Name of function where this function was called
  *
  * See object_class_dynamic_cast() for a description of the parameters
  * of this function.  The only difference in behavior is that this function
@@ -1406,6 +1414,23 @@ ObjectProperty *object_property_try_add(Object *obj, const char *name,
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
@@ -1479,6 +1504,7 @@ typedef struct ObjectPropertyIterator {
 
 /**
  * object_property_iter_init:
+ * @iter: the iterator instance
  * @obj: the object
  *
  * Initializes an iterator for traversing all properties
@@ -1507,6 +1533,7 @@ void object_property_iter_init(ObjectPropertyIterator *iter,
 
 /**
  * object_class_property_iter_init:
+ * @iter: the iterator instance
  * @klass: the class
  *
  * Initializes an iterator for traversing all properties
@@ -1554,6 +1581,7 @@ bool object_property_get(Object *obj, const char *name, Visitor *v,
 
 /**
  * object_property_set_str:
+ * @obj: the object
  * @name: the name of the property
  * @value: the value to be written to the property
  * @errp: returns an error if this function fails
@@ -1580,6 +1608,7 @@ char *object_property_get_str(Object *obj, const char *name,
 
 /**
  * object_property_set_link:
+ * @obj: the object
  * @name: the name of the property
  * @value: the value to be written to the property
  * @errp: returns an error if this function fails
@@ -1610,6 +1639,7 @@ Object *object_property_get_link(Object *obj, const char *name,
 
 /**
  * object_property_set_bool:
+ * @obj: the object
  * @name: the name of the property
  * @value: the value to be written to the property
  * @errp: returns an error if this function fails
@@ -1635,6 +1665,7 @@ bool object_property_get_bool(Object *obj, const char *name,
 
 /**
  * object_property_set_int:
+ * @obj: the object
  * @name: the name of the property
  * @value: the value to be written to the property
  * @errp: returns an error if this function fails
@@ -1660,6 +1691,7 @@ int64_t object_property_get_int(Object *obj, const char *name,
 
 /**
  * object_property_set_uint:
+ * @obj: the object
  * @name: the name of the property
  * @value: the value to be written to the property
  * @errp: returns an error if this function fails
@@ -1783,6 +1815,7 @@ Object *object_get_internal_root(void);
 
 /**
  * object_get_canonical_path_component:
+ * @obj: the object
  *
  * Returns: The final component in the object's canonical path.  The canonical
  * path is the path within the composition tree starting from the root.
@@ -1792,6 +1825,7 @@ const char *object_get_canonical_path_component(const Object *obj);
 
 /**
  * object_get_canonical_path:
+ * @obj: the object
  *
  * Returns: The canonical path for a object, newly allocated.  This is
  * the path within the composition tree starting from the root.  Use
@@ -1881,6 +1915,10 @@ ObjectProperty *object_property_try_add_child(Object *obj, const char *name,
 
 /**
  * object_property_add_child:
+ * @obj: the object to add a property to
+ * @name: the name of the property
+ * @child: the child object
+ *
  * Same as object_property_try_add_child() with @errp hardcoded to
  * &error_abort
  */
@@ -1898,13 +1936,17 @@ typedef enum {
 
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
@@ -1998,6 +2040,7 @@ ObjectProperty *object_class_property_add_bool(ObjectClass *klass,
  * @obj: the object to add a property to
  * @name: the name of the property
  * @typename: the name of the enum data type
+ * @lookup: enum value namelookup table
  * @get: the getter or %NULL if the property is write-only.
  * @set: the setter or %NULL if the property is read-only
  *
-- 
2.26.2




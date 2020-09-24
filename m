Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95EEC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:21:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4689323600
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="huqnO0qT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4689323600
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLONc-00016a-CJ
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 06:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNUY-00033P-Db
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:24:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41944)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNUW-0006Ce-2F
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600939479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=neynTPykMVT69D9xSmX+p5xUsT3sYnJigTKUA/YKnIo=;
 b=huqnO0qTfDaoBhTRowkijprOG6p2/XQmaDrT6v3BsoSDQ6a/xw87Y/3gdBZI6BmSoDvDAz
 XuSmvqjZnjSL2o9vsiWAi6+YwBCGsgwdGRSstIr75xOGkhnEPzQAQCnaQH1OC6M1XvOWnh
 dFwH2msvAzM6HODdQR8ehYgwi1RJ4IA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-3CLcmmiDPde59O834i7AGw-1; Thu, 24 Sep 2020 05:24:37 -0400
X-MC-Unique: 3CLcmmiDPde59O834i7AGw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6742C87137B
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 09:24:36 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 53FC85C1C7;
 Thu, 24 Sep 2020 09:24:33 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 72/92] qom: Add code block markup to all code blocks
Date: Thu, 24 Sep 2020 05:22:54 -0400
Message-Id: <20200924092314.1722645-73-pbonzini@redhat.com>
In-Reply-To: <20200924092314.1722645-1-pbonzini@redhat.com>
References: <20200924092314.1722645-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
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

Convert all example/codelisting markup to Sphinx code-block.

There are a few sections where backslashes at the end of lines
break code formatting.  A comment was added noting that this is
an issue.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20200910221526.10041-8-ehabkost@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qom/object.h | 135 ++++++++++++++++++-------------------------
 1 file changed, 56 insertions(+), 79 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index d96ac334c8..d839a2c39f 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -31,6 +31,8 @@ typedef struct InterfaceInfo InterfaceInfo;
 /**
  * DOC:
  *
+ * .. highlight:: c
+ *
  * The QEMU Object Model provides a framework for registering user creatable
  * types and instantiating objects from those types.  QOM provides the following
  * features:
@@ -39,9 +41,9 @@ typedef struct InterfaceInfo InterfaceInfo;
  *  - Support for single-inheritance of types
  *  - Multiple inheritance of stateless interfaces
  *
- * <example>
- *   <title>Creating a minimal type</title>
- *      <programlisting>
+ * .. code-block:: c
+ *    :caption: Creating a minimal type
+ *
  *    #include "qdev.h"
  *
  *    #define TYPE_MY_DEVICE "my-device"
@@ -68,8 +70,6 @@ typedef struct InterfaceInfo InterfaceInfo;
  *    }
  *
  *    type_init(my_device_register_types)
- *      </programlisting>
- * </example>
  *
  * In the above example, we create a simple type that is described by #TypeInfo.
  * #TypeInfo describes information about the type including what it inherits
@@ -78,8 +78,8 @@ typedef struct InterfaceInfo InterfaceInfo;
  * Alternatively several static types could be registered using helper macro
  * DEFINE_TYPES()
  *
- * <example>
- *      <programlisting>
+ * .. code-block:: c
+ *
  *    static const TypeInfo device_types_info[] = {
  *        {
  *            .name = TYPE_MY_DEVICE_A,
@@ -94,8 +94,6 @@ typedef struct InterfaceInfo InterfaceInfo;
  *    };
  *
  *    DEFINE_TYPES(device_types_info)
- *      </programlisting>
- * </example>
  *
  * Every type has an #ObjectClass associated with it.  #ObjectClass derivatives
  * are instantiated dynamically but there is only ever one instance for any
@@ -108,17 +106,19 @@ typedef struct InterfaceInfo InterfaceInfo;
  * OBJECT_CHECK() and OBJECT_CLASS_CHECK() to make it easier to convert to a
  * specific type:
  *
- * <example>
- *   <title>Typecasting macros</title>
- *   <programlisting>
+ * .. kernel-doc messes up with the code block below because of the
+ *    backslash at the end of lines.  This will be fixes if we move this
+ *    content to qom.rst.
+ *
+ * .. code-block:: c
+ *    :caption: Typecasting macros
+ *
  *    #define MY_DEVICE_GET_CLASS(obj) \
  *       OBJECT_GET_CLASS(MyDeviceClass, obj, TYPE_MY_DEVICE)
  *    #define MY_DEVICE_CLASS(klass) \
  *       OBJECT_CLASS_CHECK(MyDeviceClass, klass, TYPE_MY_DEVICE)
  *    #define MY_DEVICE(obj) \
  *       OBJECT_CHECK(MyDevice, obj, TYPE_MY_DEVICE)
- *   </programlisting>
- * </example>
  *
  * Class Initialization
  * ====================
@@ -141,9 +141,9 @@ typedef struct InterfaceInfo InterfaceInfo;
  * its virtual functions.  Here is how the above example might be modified
  * to introduce an overridden virtual function:
  *
- * <example>
- *   <title>Overriding a virtual function</title>
- *      <programlisting>
+ * .. code-block:: c
+ *    :caption: Overriding a virtual function
+ *
  *    #include "qdev.h"
  *
  *    void my_device_class_init(ObjectClass *klass, void *class_data)
@@ -158,16 +158,14 @@ typedef struct InterfaceInfo InterfaceInfo;
  *        .instance_size = sizeof(MyDevice),
  *        .class_init = my_device_class_init,
  *    };
- *      </programlisting>
- * </example>
  *
  * Introducing new virtual methods requires a class to define its own
  * struct and to add a .class_size member to the #TypeInfo.  Each method
  * will also have a wrapper function to call it easily:
  *
- * <example>
- *   <title>Defining an abstract class</title>
- *      <programlisting>
+ * .. code-block:: c
+ *    :caption: Defining an abstract class
+ *
  *    #include "qdev.h"
  *
  *    typedef struct MyDeviceClass
@@ -191,8 +189,6 @@ typedef struct InterfaceInfo InterfaceInfo;
  *
  *        klass->frobnicate(obj);
  *    }
- *      </programlisting>
- * </example>
  *
  * Interfaces
  * ==========
@@ -230,13 +226,13 @@ typedef struct InterfaceInfo InterfaceInfo;
  *
  * To invoke the method being overridden, the preferred solution is to store
  * the original value in the overriding class before overriding the method.
- * This corresponds to |[ {super,base}.method(...) ]| in Java and C#
+ * This corresponds to ``{super,base}.method(...)`` in Java and C#
  * respectively; this frees the overriding class from hardcoding its parent
  * class, which someone might choose to change at some point.
  *
- * <example>
- *   <title>Overriding a virtual method</title>
- *      <programlisting>
+ * .. code-block:: c
+ *    :caption: Overriding a virtual method
+ *
  *    typedef struct MyState MyState;
  *
  *    typedef void (*MyDoSomething)(MyState *obj);
@@ -297,8 +293,6 @@ typedef struct InterfaceInfo InterfaceInfo;
  *        .class_size = sizeof(DerivedClass),
  *        .class_init = derived_class_init,
  *    };
- *      </programlisting>
- * </example>
  *
  * Alternatively, object_class_by_name() can be used to obtain the class and
  * its non-overridden methods for a specific type. This would correspond to
@@ -320,18 +314,16 @@ typedef struct InterfaceInfo InterfaceInfo;
  * OBJECT_DECLARE_SIMPLE_TYPE macro is suitable, and is commonly placed
  * in the header file:
  *
- * <example>
- *   <title>Declaring a simple type</title>
- *   <programlisting>
+ * .. code-block:: c
+ *    :caption: Declaring a simple type
+ *
  *     OBJECT_DECLARE_SIMPLE_TYPE(MyDevice, my_device, MY_DEVICE, DEVICE)
- *   </programlisting>
- * </example>
  *
  * This is equivalent to the following:
  *
- * <example>
- *   <title>Expansion from declaring a simple type</title>
- *   <programlisting>
+ * .. code-block:: c
+ *    :caption: Expansion from declaring a simple type
+ *
  *     typedef struct MyDevice MyDevice;
  *     typedef struct MyDeviceClass MyDeviceClass;
  *
@@ -347,8 +339,6 @@ typedef struct InterfaceInfo InterfaceInfo;
  *     struct MyDeviceClass {
  *         DeviceClass parent_class;
  *     };
- *   </programlisting>
- * </example>
  *
  * The 'struct MyDevice' needs to be declared separately.
  * If the type requires virtual functions to be declared in the class
@@ -359,18 +349,16 @@ typedef struct InterfaceInfo InterfaceInfo;
  * To implement the type, the OBJECT_DEFINE macro family is available.
  * In the simple case the OBJECT_DEFINE_TYPE macro is suitable:
  *
- * <example>
- *   <title>Defining a simple type</title>
- *   <programlisting>
+ * .. code-block:: c
+ *    :caption: Defining a simple type
+ *
  *     OBJECT_DEFINE_TYPE(MyDevice, my_device, MY_DEVICE, DEVICE)
- *   </programlisting>
- * </example>
  *
  * This is equivalent to the following:
  *
- * <example>
- *   <title>Expansion from defining a simple type</title>
- *   <programlisting>
+ * .. code-block:: c
+ *    :caption: Expansion from defining a simple type
+ *
  *     static void my_device_finalize(Object *obj);
  *     static void my_device_class_init(ObjectClass *oc, void *data);
  *     static void my_device_init(Object *obj);
@@ -391,8 +379,6 @@ typedef struct InterfaceInfo InterfaceInfo;
  *         type_register_static(&my_device_info);
  *     }
  *     type_init(my_device_register_types);
- *   </programlisting>
- * </example>
  *
  * This is sufficient to get the type registered with the type
  * system, and the three standard methods now need to be implemented
@@ -402,24 +388,20 @@ typedef struct InterfaceInfo InterfaceInfo;
  * OBJECT_DEFINE_TYPE_WITH_INTERFACES() macro can be used instead.
  * This accepts an array of interface type names.
  *
- * <example>
- *   <title>Defining a simple type implementing interfaces</title>
- *   <programlisting>
+ * .. code-block:: c
+ *    :caption: Defining a simple type implementing interfaces
+ *
  *     OBJECT_DEFINE_TYPE_WITH_INTERFACES(MyDevice, my_device,
  *                                        MY_DEVICE, DEVICE,
  *                                        { TYPE_USER_CREATABLE }, { NULL })
- *   </programlisting>
- * </example>
  *
  * If the type is not intended to be instantiated, then then
  * the OBJECT_DEFINE_ABSTRACT_TYPE() macro can be used instead:
  *
- * <example>
- *   <title>Defining a simple type</title>
- *   <programlisting>
+ * .. code-block:: c
+ *    :caption: Defining a simple abstract type
+ *
  *     OBJECT_DEFINE_ABSTRACT_TYPE(MyDevice, my_device, MY_DEVICE, DEVICE)
- *   </programlisting>
- * </example>
  */
 
 
@@ -982,9 +964,9 @@ Object *object_new(const char *typename);
  * object will be marked complete once all the properties have been
  * processed.
  *
- * <example>
- *   <title>Creating an object with properties</title>
- *      <programlisting>
+ * .. code-block:: c
+ *    :caption: Creating an object with properties
+ *
  *      Error *err = NULL;
  *      Object *obj;
  *
@@ -1001,8 +983,6 @@ Object *object_new(const char *typename);
  *      if (!obj) {
  *        error_reportf_err(err, "Cannot create memory backend: ");
  *      }
- *      </programlisting>
- * </example>
  *
  * The returned object will have one stable reference maintained
  * for as long as it is present in the object hierarchy.
@@ -1051,9 +1031,9 @@ void object_apply_compat_props(Object *obj);
  * strings. The propname of %NULL indicates the end of the property
  * list.
  *
- * <example>
- *   <title>Update an object's properties</title>
- *      <programlisting>
+ * .. code-block:: c
+ *    :caption: Update an object's properties
+ *
  *      Error *err = NULL;
  *      Object *obj = ...get / create object...;
  *
@@ -1066,8 +1046,6 @@ void object_apply_compat_props(Object *obj);
  *                            NULL)) {
  *        error_reportf_err(err, "Cannot set properties: ");
  *      }
- *      </programlisting>
- * </example>
  *
  * The returned object will have one stable reference maintained
  * for as long as it is present in the object hierarchy.
@@ -1155,10 +1133,11 @@ bool object_initialize_child_with_propsv(Object *parentobj,
  * object.
  * @type: The name of the type of the object to instantiate.
  *
- * This is like
- * object_initialize_child_with_props(parent, propname,
- *                                    child, sizeof(*child), type,
- *                                    &error_abort, NULL)
+ * This is like::
+ *
+ *   object_initialize_child_with_props(parent, propname,
+ *                                      child, sizeof(*child), type,
+ *                                      &error_abort, NULL)
  */
 #define object_initialize_child(parent, propname, child, type)          \
     object_initialize_child_internal((parent), (propname),              \
@@ -1517,9 +1496,9 @@ typedef struct ObjectPropertyIterator {
  *
  * Typical usage pattern would be
  *
- * <example>
- *   <title>Using object property iterators</title>
- *      <programlisting>
+ * .. code-block:: c
+ *    :caption: Using object property iterators
+ *
  *      ObjectProperty *prop;
  *      ObjectPropertyIterator iter;
  *
@@ -1527,8 +1506,6 @@ typedef struct ObjectPropertyIterator {
  *      while ((prop = object_property_iter_next(&iter))) {
  *        ... do something with prop ...
  *      }
- *      </programlisting>
- * </example>
  */
 void object_property_iter_init(ObjectPropertyIterator *iter,
                                Object *obj);
-- 
2.26.2




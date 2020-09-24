Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E95C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:57:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C47AC21D91
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nue7uU4a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C47AC21D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLO0R-0007Vt-Pp
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 05:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNUh-0003Fq-DH
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:24:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47602)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNUd-0006DW-L6
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600939485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OLAKqL1m1PZfleNbUpWIHaKkhJlBka0cIAGQUl4V9yM=;
 b=Nue7uU4a+vGQjFtcaJUE4MExwMleSXCSTTrYSlw8kUoTvES5VerBS8oYH+6RzGZy2JkbD4
 J3/6yDWqLwxsw8VGFpoi+6OkMlxDDTgsIoHxZ1UkjMpfrKjyuuv8/2UfXSsmaPnXJbmpeN
 uyHTLPd4Y2K7tJ8s+61c250OTymfmm4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-96IvbB5HMbep14Wh6-S78g-1; Thu, 24 Sep 2020 05:24:43 -0400
X-MC-Unique: 96IvbB5HMbep14Wh6-S78g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B53964177
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 09:24:42 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 90ACB5C1C7;
 Thu, 24 Sep 2020 09:24:39 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 74/92] docs: Move object.h overview doc comment to qom.rst
Date: Thu, 24 Sep 2020 05:22:56 -0400
Message-Id: <20200924092314.1722645-75-pbonzini@redhat.com>
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

Move the whole contents of the overview doc comment from object.h
to qom.rst.

This makes the documentation source easier to read and edit, and
also solves the backslash escaping issue at the typecasting macro
examples.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20200910221526.10041-10-ehabkost@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/qom.rst   | 373 ++++++++++++++++++++++++++++++++++++++++++
 include/qom/object.h | 377 -------------------------------------------
 2 files changed, 373 insertions(+), 377 deletions(-)

diff --git a/docs/devel/qom.rst b/docs/devel/qom.rst
index dc5be79a4a..0b943b2a1a 100644
--- a/docs/devel/qom.rst
+++ b/docs/devel/qom.rst
@@ -2,4 +2,377 @@
 The QEMU Object Model (QOM)
 ===========================
 
+.. highlight:: c
+
+The QEMU Object Model provides a framework for registering user creatable
+types and instantiating objects from those types.  QOM provides the following
+features:
+
+ - System for dynamically registering types
+ - Support for single-inheritance of types
+ - Multiple inheritance of stateless interfaces
+
+.. code-block:: c
+   :caption: Creating a minimal type
+
+   #include "qdev.h"
+
+   #define TYPE_MY_DEVICE "my-device"
+
+   // No new virtual functions: we can reuse the typedef for the
+   // superclass.
+   typedef DeviceClass MyDeviceClass;
+   typedef struct MyDevice
+   {
+       DeviceState parent;
+
+       int reg0, reg1, reg2;
+   } MyDevice;
+
+   static const TypeInfo my_device_info = {
+       .name = TYPE_MY_DEVICE,
+       .parent = TYPE_DEVICE,
+       .instance_size = sizeof(MyDevice),
+   };
+
+   static void my_device_register_types(void)
+   {
+       type_register_static(&my_device_info);
+   }
+
+   type_init(my_device_register_types)
+
+In the above example, we create a simple type that is described by #TypeInfo.
+#TypeInfo describes information about the type including what it inherits
+from, the instance and class size, and constructor/destructor hooks.
+
+Alternatively several static types could be registered using helper macro
+DEFINE_TYPES()
+
+.. code-block:: c
+
+   static const TypeInfo device_types_info[] = {
+       {
+           .name = TYPE_MY_DEVICE_A,
+           .parent = TYPE_DEVICE,
+           .instance_size = sizeof(MyDeviceA),
+       },
+       {
+           .name = TYPE_MY_DEVICE_B,
+           .parent = TYPE_DEVICE,
+           .instance_size = sizeof(MyDeviceB),
+       },
+   };
+
+   DEFINE_TYPES(device_types_info)
+
+Every type has an #ObjectClass associated with it.  #ObjectClass derivatives
+are instantiated dynamically but there is only ever one instance for any
+given type.  The #ObjectClass typically holds a table of function pointers
+for the virtual methods implemented by this type.
+
+Using object_new(), a new #Object derivative will be instantiated.  You can
+cast an #Object to a subclass (or base-class) type using
+object_dynamic_cast().  You typically want to define macro wrappers around
+OBJECT_CHECK() and OBJECT_CLASS_CHECK() to make it easier to convert to a
+specific type:
+
+.. code-block:: c
+   :caption: Typecasting macros
+
+   #define MY_DEVICE_GET_CLASS(obj) \
+      OBJECT_GET_CLASS(MyDeviceClass, obj, TYPE_MY_DEVICE)
+   #define MY_DEVICE_CLASS(klass) \
+      OBJECT_CLASS_CHECK(MyDeviceClass, klass, TYPE_MY_DEVICE)
+   #define MY_DEVICE(obj) \
+      OBJECT_CHECK(MyDevice, obj, TYPE_MY_DEVICE)
+
+Class Initialization
+====================
+
+Before an object is initialized, the class for the object must be
+initialized.  There is only one class object for all instance objects
+that is created lazily.
+
+Classes are initialized by first initializing any parent classes (if
+necessary).  After the parent class object has initialized, it will be
+copied into the current class object and any additional storage in the
+class object is zero filled.
+
+The effect of this is that classes automatically inherit any virtual
+function pointers that the parent class has already initialized.  All
+other fields will be zero filled.
+
+Once all of the parent classes have been initialized, #TypeInfo::class_init
+is called to let the class being instantiated provide default initialize for
+its virtual functions.  Here is how the above example might be modified
+to introduce an overridden virtual function:
+
+.. code-block:: c
+   :caption: Overriding a virtual function
+
+   #include "qdev.h"
+
+   void my_device_class_init(ObjectClass *klass, void *class_data)
+   {
+       DeviceClass *dc = DEVICE_CLASS(klass);
+       dc->reset = my_device_reset;
+   }
+
+   static const TypeInfo my_device_info = {
+       .name = TYPE_MY_DEVICE,
+       .parent = TYPE_DEVICE,
+       .instance_size = sizeof(MyDevice),
+       .class_init = my_device_class_init,
+   };
+
+Introducing new virtual methods requires a class to define its own
+struct and to add a .class_size member to the #TypeInfo.  Each method
+will also have a wrapper function to call it easily:
+
+.. code-block:: c
+   :caption: Defining an abstract class
+
+   #include "qdev.h"
+
+   typedef struct MyDeviceClass
+   {
+       DeviceClass parent;
+
+       void (*frobnicate) (MyDevice *obj);
+   } MyDeviceClass;
+
+   static const TypeInfo my_device_info = {
+       .name = TYPE_MY_DEVICE,
+       .parent = TYPE_DEVICE,
+       .instance_size = sizeof(MyDevice),
+       .abstract = true, // or set a default in my_device_class_init
+       .class_size = sizeof(MyDeviceClass),
+   };
+
+   void my_device_frobnicate(MyDevice *obj)
+   {
+       MyDeviceClass *klass = MY_DEVICE_GET_CLASS(obj);
+
+       klass->frobnicate(obj);
+   }
+
+Interfaces
+==========
+
+Interfaces allow a limited form of multiple inheritance.  Instances are
+similar to normal types except for the fact that are only defined by
+their classes and never carry any state.  As a consequence, a pointer to
+an interface instance should always be of incomplete type in order to be
+sure it cannot be dereferenced.  That is, you should define the
+'typedef struct SomethingIf SomethingIf' so that you can pass around
+``SomethingIf *si`` arguments, but not define a ``struct SomethingIf { ... }``.
+The only things you can validly do with a ``SomethingIf *`` are to pass it as
+an argument to a method on its corresponding SomethingIfClass, or to
+dynamically cast it to an object that implements the interface.
+
+Methods
+=======
+
+A <emphasis>method</emphasis> is a function within the namespace scope of
+a class. It usually operates on the object instance by passing it as a
+strongly-typed first argument.
+If it does not operate on an object instance, it is dubbed
+<emphasis>class method</emphasis>.
+
+Methods cannot be overloaded. That is, the #ObjectClass and method name
+uniquely identity the function to be called; the signature does not vary
+except for trailing varargs.
+
+Methods are always <emphasis>virtual</emphasis>. Overriding a method in
+#TypeInfo.class_init of a subclass leads to any user of the class obtained
+via OBJECT_GET_CLASS() accessing the overridden function.
+The original function is not automatically invoked. It is the responsibility
+of the overriding class to determine whether and when to invoke the method
+being overridden.
+
+To invoke the method being overridden, the preferred solution is to store
+the original value in the overriding class before overriding the method.
+This corresponds to ``{super,base}.method(...)`` in Java and C#
+respectively; this frees the overriding class from hardcoding its parent
+class, which someone might choose to change at some point.
+
+.. code-block:: c
+   :caption: Overriding a virtual method
+
+   typedef struct MyState MyState;
+
+   typedef void (*MyDoSomething)(MyState *obj);
+
+   typedef struct MyClass {
+       ObjectClass parent_class;
+
+       MyDoSomething do_something;
+   } MyClass;
+
+   static void my_do_something(MyState *obj)
+   {
+       // do something
+   }
+
+   static void my_class_init(ObjectClass *oc, void *data)
+   {
+       MyClass *mc = MY_CLASS(oc);
+
+       mc->do_something = my_do_something;
+   }
+
+   static const TypeInfo my_type_info = {
+       .name = TYPE_MY,
+       .parent = TYPE_OBJECT,
+       .instance_size = sizeof(MyState),
+       .class_size = sizeof(MyClass),
+       .class_init = my_class_init,
+   };
+
+   typedef struct DerivedClass {
+       MyClass parent_class;
+
+       MyDoSomething parent_do_something;
+   } DerivedClass;
+
+   static void derived_do_something(MyState *obj)
+   {
+       DerivedClass *dc = DERIVED_GET_CLASS(obj);
+
+       // do something here
+       dc->parent_do_something(obj);
+       // do something else here
+   }
+
+   static void derived_class_init(ObjectClass *oc, void *data)
+   {
+       MyClass *mc = MY_CLASS(oc);
+       DerivedClass *dc = DERIVED_CLASS(oc);
+
+       dc->parent_do_something = mc->do_something;
+       mc->do_something = derived_do_something;
+   }
+
+   static const TypeInfo derived_type_info = {
+       .name = TYPE_DERIVED,
+       .parent = TYPE_MY,
+       .class_size = sizeof(DerivedClass),
+       .class_init = derived_class_init,
+   };
+
+Alternatively, object_class_by_name() can be used to obtain the class and
+its non-overridden methods for a specific type. This would correspond to
+``MyClass::method(...)`` in C++.
+
+The first example of such a QOM method was #CPUClass.reset,
+another example is #DeviceClass.realize.
+
+Standard type declaration and definition macros
+===============================================
+
+A lot of the code outlined above follows a standard pattern and naming
+convention. To reduce the amount of boilerplate code that needs to be
+written for a new type there are two sets of macros to generate the
+common parts in a standard format.
+
+A type is declared using the OBJECT_DECLARE macro family. In types
+which do not require any virtual functions in the class, the
+OBJECT_DECLARE_SIMPLE_TYPE macro is suitable, and is commonly placed
+in the header file:
+
+.. code-block:: c
+   :caption: Declaring a simple type
+
+    OBJECT_DECLARE_SIMPLE_TYPE(MyDevice, my_device, MY_DEVICE, DEVICE)
+
+This is equivalent to the following:
+
+.. code-block:: c
+   :caption: Expansion from declaring a simple type
+
+    typedef struct MyDevice MyDevice;
+    typedef struct MyDeviceClass MyDeviceClass;
+
+    G_DEFINE_AUTOPTR_CLEANUP_FUNC(MyDeviceClass, object_unref)
+
+    #define MY_DEVICE_GET_CLASS(void *obj) \
+            OBJECT_GET_CLASS(MyDeviceClass, obj, TYPE_MY_DEVICE)
+    #define MY_DEVICE_CLASS(void *klass) \
+            OBJECT_CLASS_CHECK(MyDeviceClass, klass, TYPE_MY_DEVICE)
+    #define MY_DEVICE(void *obj)
+            OBJECT_CHECK(MyDevice, obj, TYPE_MY_DEVICE)
+
+    struct MyDeviceClass {
+        DeviceClass parent_class;
+    };
+
+The 'struct MyDevice' needs to be declared separately.
+If the type requires virtual functions to be declared in the class
+struct, then the alternative OBJECT_DECLARE_TYPE() macro can be
+used. This does the same as OBJECT_DECLARE_SIMPLE_TYPE(), but without
+the 'struct MyDeviceClass' definition.
+
+To implement the type, the OBJECT_DEFINE macro family is available.
+In the simple case the OBJECT_DEFINE_TYPE macro is suitable:
+
+.. code-block:: c
+   :caption: Defining a simple type
+
+    OBJECT_DEFINE_TYPE(MyDevice, my_device, MY_DEVICE, DEVICE)
+
+This is equivalent to the following:
+
+.. code-block:: c
+   :caption: Expansion from defining a simple type
+
+    static void my_device_finalize(Object *obj);
+    static void my_device_class_init(ObjectClass *oc, void *data);
+    static void my_device_init(Object *obj);
+
+    static const TypeInfo my_device_info = {
+        .parent = TYPE_DEVICE,
+        .name = TYPE_MY_DEVICE,
+        .instance_size = sizeof(MyDevice),
+        .instance_init = my_device_init,
+        .instance_finalize = my_device_finalize,
+        .class_size = sizeof(MyDeviceClass),
+        .class_init = my_device_class_init,
+    };
+
+    static void
+    my_device_register_types(void)
+    {
+        type_register_static(&my_device_info);
+    }
+    type_init(my_device_register_types);
+
+This is sufficient to get the type registered with the type
+system, and the three standard methods now need to be implemented
+along with any other logic required for the type.
+
+If the type needs to implement one or more interfaces, then the
+OBJECT_DEFINE_TYPE_WITH_INTERFACES() macro can be used instead.
+This accepts an array of interface type names.
+
+.. code-block:: c
+   :caption: Defining a simple type implementing interfaces
+
+    OBJECT_DEFINE_TYPE_WITH_INTERFACES(MyDevice, my_device,
+                                       MY_DEVICE, DEVICE,
+                                       { TYPE_USER_CREATABLE }, { NULL })
+
+If the type is not intended to be instantiated, then then
+the OBJECT_DEFINE_ABSTRACT_TYPE() macro can be used instead:
+
+.. code-block:: c
+   :caption: Defining a simple abstract type
+
+    OBJECT_DEFINE_ABSTRACT_TYPE(MyDevice, my_device, MY_DEVICE, DEVICE)
+
+
+
+API Reference
+-------------
+
 .. kernel-doc:: include/qom/object.h
diff --git a/include/qom/object.h b/include/qom/object.h
index d839a2c39f..93b6418dbc 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -28,383 +28,6 @@ typedef struct InterfaceInfo InterfaceInfo;
 
 #define TYPE_OBJECT "object"
 
-/**
- * DOC:
- *
- * .. highlight:: c
- *
- * The QEMU Object Model provides a framework for registering user creatable
- * types and instantiating objects from those types.  QOM provides the following
- * features:
- *
- *  - System for dynamically registering types
- *  - Support for single-inheritance of types
- *  - Multiple inheritance of stateless interfaces
- *
- * .. code-block:: c
- *    :caption: Creating a minimal type
- *
- *    #include "qdev.h"
- *
- *    #define TYPE_MY_DEVICE "my-device"
- *
- *    // No new virtual functions: we can reuse the typedef for the
- *    // superclass.
- *    typedef DeviceClass MyDeviceClass;
- *    typedef struct MyDevice
- *    {
- *        DeviceState parent;
- *
- *        int reg0, reg1, reg2;
- *    } MyDevice;
- *
- *    static const TypeInfo my_device_info = {
- *        .name = TYPE_MY_DEVICE,
- *        .parent = TYPE_DEVICE,
- *        .instance_size = sizeof(MyDevice),
- *    };
- *
- *    static void my_device_register_types(void)
- *    {
- *        type_register_static(&my_device_info);
- *    }
- *
- *    type_init(my_device_register_types)
- *
- * In the above example, we create a simple type that is described by #TypeInfo.
- * #TypeInfo describes information about the type including what it inherits
- * from, the instance and class size, and constructor/destructor hooks.
- *
- * Alternatively several static types could be registered using helper macro
- * DEFINE_TYPES()
- *
- * .. code-block:: c
- *
- *    static const TypeInfo device_types_info[] = {
- *        {
- *            .name = TYPE_MY_DEVICE_A,
- *            .parent = TYPE_DEVICE,
- *            .instance_size = sizeof(MyDeviceA),
- *        },
- *        {
- *            .name = TYPE_MY_DEVICE_B,
- *            .parent = TYPE_DEVICE,
- *            .instance_size = sizeof(MyDeviceB),
- *        },
- *    };
- *
- *    DEFINE_TYPES(device_types_info)
- *
- * Every type has an #ObjectClass associated with it.  #ObjectClass derivatives
- * are instantiated dynamically but there is only ever one instance for any
- * given type.  The #ObjectClass typically holds a table of function pointers
- * for the virtual methods implemented by this type.
- *
- * Using object_new(), a new #Object derivative will be instantiated.  You can
- * cast an #Object to a subclass (or base-class) type using
- * object_dynamic_cast().  You typically want to define macro wrappers around
- * OBJECT_CHECK() and OBJECT_CLASS_CHECK() to make it easier to convert to a
- * specific type:
- *
- * .. kernel-doc messes up with the code block below because of the
- *    backslash at the end of lines.  This will be fixes if we move this
- *    content to qom.rst.
- *
- * .. code-block:: c
- *    :caption: Typecasting macros
- *
- *    #define MY_DEVICE_GET_CLASS(obj) \
- *       OBJECT_GET_CLASS(MyDeviceClass, obj, TYPE_MY_DEVICE)
- *    #define MY_DEVICE_CLASS(klass) \
- *       OBJECT_CLASS_CHECK(MyDeviceClass, klass, TYPE_MY_DEVICE)
- *    #define MY_DEVICE(obj) \
- *       OBJECT_CHECK(MyDevice, obj, TYPE_MY_DEVICE)
- *
- * Class Initialization
- * ====================
- *
- * Before an object is initialized, the class for the object must be
- * initialized.  There is only one class object for all instance objects
- * that is created lazily.
- *
- * Classes are initialized by first initializing any parent classes (if
- * necessary).  After the parent class object has initialized, it will be
- * copied into the current class object and any additional storage in the
- * class object is zero filled.
- *
- * The effect of this is that classes automatically inherit any virtual
- * function pointers that the parent class has already initialized.  All
- * other fields will be zero filled.
- *
- * Once all of the parent classes have been initialized, #TypeInfo::class_init
- * is called to let the class being instantiated provide default initialize for
- * its virtual functions.  Here is how the above example might be modified
- * to introduce an overridden virtual function:
- *
- * .. code-block:: c
- *    :caption: Overriding a virtual function
- *
- *    #include "qdev.h"
- *
- *    void my_device_class_init(ObjectClass *klass, void *class_data)
- *    {
- *        DeviceClass *dc = DEVICE_CLASS(klass);
- *        dc->reset = my_device_reset;
- *    }
- *
- *    static const TypeInfo my_device_info = {
- *        .name = TYPE_MY_DEVICE,
- *        .parent = TYPE_DEVICE,
- *        .instance_size = sizeof(MyDevice),
- *        .class_init = my_device_class_init,
- *    };
- *
- * Introducing new virtual methods requires a class to define its own
- * struct and to add a .class_size member to the #TypeInfo.  Each method
- * will also have a wrapper function to call it easily:
- *
- * .. code-block:: c
- *    :caption: Defining an abstract class
- *
- *    #include "qdev.h"
- *
- *    typedef struct MyDeviceClass
- *    {
- *        DeviceClass parent;
- *
- *        void (*frobnicate) (MyDevice *obj);
- *    } MyDeviceClass;
- *
- *    static const TypeInfo my_device_info = {
- *        .name = TYPE_MY_DEVICE,
- *        .parent = TYPE_DEVICE,
- *        .instance_size = sizeof(MyDevice),
- *        .abstract = true, // or set a default in my_device_class_init
- *        .class_size = sizeof(MyDeviceClass),
- *    };
- *
- *    void my_device_frobnicate(MyDevice *obj)
- *    {
- *        MyDeviceClass *klass = MY_DEVICE_GET_CLASS(obj);
- *
- *        klass->frobnicate(obj);
- *    }
- *
- * Interfaces
- * ==========
- *
- * Interfaces allow a limited form of multiple inheritance.  Instances are
- * similar to normal types except for the fact that are only defined by
- * their classes and never carry any state.  As a consequence, a pointer to
- * an interface instance should always be of incomplete type in order to be
- * sure it cannot be dereferenced.  That is, you should define the
- * 'typedef struct SomethingIf SomethingIf' so that you can pass around
- * ``SomethingIf *si`` arguments, but not define a ``struct SomethingIf { ... }``.
- * The only things you can validly do with a ``SomethingIf *`` are to pass it as
- * an argument to a method on its corresponding SomethingIfClass, or to
- * dynamically cast it to an object that implements the interface.
- *
- * Methods
- * =======
- *
- * A <emphasis>method</emphasis> is a function within the namespace scope of
- * a class. It usually operates on the object instance by passing it as a
- * strongly-typed first argument.
- * If it does not operate on an object instance, it is dubbed
- * <emphasis>class method</emphasis>.
- *
- * Methods cannot be overloaded. That is, the #ObjectClass and method name
- * uniquely identity the function to be called; the signature does not vary
- * except for trailing varargs.
- *
- * Methods are always <emphasis>virtual</emphasis>. Overriding a method in
- * #TypeInfo.class_init of a subclass leads to any user of the class obtained
- * via OBJECT_GET_CLASS() accessing the overridden function.
- * The original function is not automatically invoked. It is the responsibility
- * of the overriding class to determine whether and when to invoke the method
- * being overridden.
- *
- * To invoke the method being overridden, the preferred solution is to store
- * the original value in the overriding class before overriding the method.
- * This corresponds to ``{super,base}.method(...)`` in Java and C#
- * respectively; this frees the overriding class from hardcoding its parent
- * class, which someone might choose to change at some point.
- *
- * .. code-block:: c
- *    :caption: Overriding a virtual method
- *
- *    typedef struct MyState MyState;
- *
- *    typedef void (*MyDoSomething)(MyState *obj);
- *
- *    typedef struct MyClass {
- *        ObjectClass parent_class;
- *
- *        MyDoSomething do_something;
- *    } MyClass;
- *
- *    static void my_do_something(MyState *obj)
- *    {
- *        // do something
- *    }
- *
- *    static void my_class_init(ObjectClass *oc, void *data)
- *    {
- *        MyClass *mc = MY_CLASS(oc);
- *
- *        mc->do_something = my_do_something;
- *    }
- *
- *    static const TypeInfo my_type_info = {
- *        .name = TYPE_MY,
- *        .parent = TYPE_OBJECT,
- *        .instance_size = sizeof(MyState),
- *        .class_size = sizeof(MyClass),
- *        .class_init = my_class_init,
- *    };
- *
- *    typedef struct DerivedClass {
- *        MyClass parent_class;
- *
- *        MyDoSomething parent_do_something;
- *    } DerivedClass;
- *
- *    static void derived_do_something(MyState *obj)
- *    {
- *        DerivedClass *dc = DERIVED_GET_CLASS(obj);
- *
- *        // do something here
- *        dc->parent_do_something(obj);
- *        // do something else here
- *    }
- *
- *    static void derived_class_init(ObjectClass *oc, void *data)
- *    {
- *        MyClass *mc = MY_CLASS(oc);
- *        DerivedClass *dc = DERIVED_CLASS(oc);
- *
- *        dc->parent_do_something = mc->do_something;
- *        mc->do_something = derived_do_something;
- *    }
- *
- *    static const TypeInfo derived_type_info = {
- *        .name = TYPE_DERIVED,
- *        .parent = TYPE_MY,
- *        .class_size = sizeof(DerivedClass),
- *        .class_init = derived_class_init,
- *    };
- *
- * Alternatively, object_class_by_name() can be used to obtain the class and
- * its non-overridden methods for a specific type. This would correspond to
- * ``MyClass::method(...)`` in C++.
- *
- * The first example of such a QOM method was #CPUClass.reset,
- * another example is #DeviceClass.realize.
- *
- * Standard type declaration and definition macros
- * ===============================================
- *
- * A lot of the code outlined above follows a standard pattern and naming
- * convention. To reduce the amount of boilerplate code that needs to be
- * written for a new type there are two sets of macros to generate the
- * common parts in a standard format.
- *
- * A type is declared using the OBJECT_DECLARE macro family. In types
- * which do not require any virtual functions in the class, the
- * OBJECT_DECLARE_SIMPLE_TYPE macro is suitable, and is commonly placed
- * in the header file:
- *
- * .. code-block:: c
- *    :caption: Declaring a simple type
- *
- *     OBJECT_DECLARE_SIMPLE_TYPE(MyDevice, my_device, MY_DEVICE, DEVICE)
- *
- * This is equivalent to the following:
- *
- * .. code-block:: c
- *    :caption: Expansion from declaring a simple type
- *
- *     typedef struct MyDevice MyDevice;
- *     typedef struct MyDeviceClass MyDeviceClass;
- *
- *     G_DEFINE_AUTOPTR_CLEANUP_FUNC(MyDeviceClass, object_unref)
- *
- *     #define MY_DEVICE_GET_CLASS(void *obj) \
- *             OBJECT_GET_CLASS(MyDeviceClass, obj, TYPE_MY_DEVICE)
- *     #define MY_DEVICE_CLASS(void *klass) \
- *             OBJECT_CLASS_CHECK(MyDeviceClass, klass, TYPE_MY_DEVICE)
- *     #define MY_DEVICE(void *obj)
- *             OBJECT_CHECK(MyDevice, obj, TYPE_MY_DEVICE)
- *
- *     struct MyDeviceClass {
- *         DeviceClass parent_class;
- *     };
- *
- * The 'struct MyDevice' needs to be declared separately.
- * If the type requires virtual functions to be declared in the class
- * struct, then the alternative OBJECT_DECLARE_TYPE() macro can be
- * used. This does the same as OBJECT_DECLARE_SIMPLE_TYPE(), but without
- * the 'struct MyDeviceClass' definition.
- *
- * To implement the type, the OBJECT_DEFINE macro family is available.
- * In the simple case the OBJECT_DEFINE_TYPE macro is suitable:
- *
- * .. code-block:: c
- *    :caption: Defining a simple type
- *
- *     OBJECT_DEFINE_TYPE(MyDevice, my_device, MY_DEVICE, DEVICE)
- *
- * This is equivalent to the following:
- *
- * .. code-block:: c
- *    :caption: Expansion from defining a simple type
- *
- *     static void my_device_finalize(Object *obj);
- *     static void my_device_class_init(ObjectClass *oc, void *data);
- *     static void my_device_init(Object *obj);
- *
- *     static const TypeInfo my_device_info = {
- *         .parent = TYPE_DEVICE,
- *         .name = TYPE_MY_DEVICE,
- *         .instance_size = sizeof(MyDevice),
- *         .instance_init = my_device_init,
- *         .instance_finalize = my_device_finalize,
- *         .class_size = sizeof(MyDeviceClass),
- *         .class_init = my_device_class_init,
- *     };
- *
- *     static void
- *     my_device_register_types(void)
- *     {
- *         type_register_static(&my_device_info);
- *     }
- *     type_init(my_device_register_types);
- *
- * This is sufficient to get the type registered with the type
- * system, and the three standard methods now need to be implemented
- * along with any other logic required for the type.
- *
- * If the type needs to implement one or more interfaces, then the
- * OBJECT_DEFINE_TYPE_WITH_INTERFACES() macro can be used instead.
- * This accepts an array of interface type names.
- *
- * .. code-block:: c
- *    :caption: Defining a simple type implementing interfaces
- *
- *     OBJECT_DEFINE_TYPE_WITH_INTERFACES(MyDevice, my_device,
- *                                        MY_DEVICE, DEVICE,
- *                                        { TYPE_USER_CREATABLE }, { NULL })
- *
- * If the type is not intended to be instantiated, then then
- * the OBJECT_DEFINE_ABSTRACT_TYPE() macro can be used instead:
- *
- * .. code-block:: c
- *    :caption: Defining a simple abstract type
- *
- *     OBJECT_DEFINE_ABSTRACT_TYPE(MyDevice, my_device, MY_DEVICE, DEVICE)
- */
-
-
 typedef struct ObjectProperty ObjectProperty;
 
 /**
-- 
2.26.2




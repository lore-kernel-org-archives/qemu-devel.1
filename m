Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0129C2D0E2
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:06:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1137C2396E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NNXmHE56"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1137C2396E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLO9A-0003XW-18
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 06:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNUV-0002uL-2o
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:24:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22968)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNUS-0006CL-Rt
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:24:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600939476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=otYHQOMFdSOLhJDRC1U4bXxdy6Eb2QW4yPQcZmtBbJg=;
 b=NNXmHE56yJhi+NwaggvKne/dBgCW1Irj/dfuwG8qYvZZwq4HPApgrtt563UxxIJl2QuMqH
 8qjSsQ1qIiSRPI1GrAATEzYTPSrGlWrh8k4ExYWnyVkaEJhwF7ajsBtqvYO1F9hGAiNG02
 pfUpHYWMOsj1MFPzMEvPuRWielgYYos=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-G3p5KZOcNCmKhv5rhI0KuA-1; Thu, 24 Sep 2020 05:24:34 -0400
X-MC-Unique: G3p5KZOcNCmKhv5rhI0KuA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32D5D104D3F8
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 09:24:33 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 425F05C1C7;
 Thu, 24 Sep 2020 09:24:30 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 71/92] qom: Indent existing code examples
Date: Thu, 24 Sep 2020 05:22:53 -0400
Message-Id: <20200924092314.1722645-72-pbonzini@redhat.com>
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

This indents existing code examples that are not indented yet,
just to make future conversion to Sphinx markup easier to review.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20200910221526.10041-7-ehabkost@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qom/object.h | 376 +++++++++++++++++++++----------------------
 1 file changed, 188 insertions(+), 188 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 5418464de4..d96ac334c8 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -41,34 +41,34 @@ typedef struct InterfaceInfo InterfaceInfo;
  *
  * <example>
  *   <title>Creating a minimal type</title>
- *   <programlisting>
- * #include "qdev.h"
- *
- * #define TYPE_MY_DEVICE "my-device"
- *
- * // No new virtual functions: we can reuse the typedef for the
- * // superclass.
- * typedef DeviceClass MyDeviceClass;
- * typedef struct MyDevice
- * {
- *     DeviceState parent;
- *
- *     int reg0, reg1, reg2;
- * } MyDevice;
- *
- * static const TypeInfo my_device_info = {
- *     .name = TYPE_MY_DEVICE,
- *     .parent = TYPE_DEVICE,
- *     .instance_size = sizeof(MyDevice),
- * };
- *
- * static void my_device_register_types(void)
- * {
- *     type_register_static(&my_device_info);
- * }
- *
- * type_init(my_device_register_types)
- *   </programlisting>
+ *      <programlisting>
+ *    #include "qdev.h"
+ *
+ *    #define TYPE_MY_DEVICE "my-device"
+ *
+ *    // No new virtual functions: we can reuse the typedef for the
+ *    // superclass.
+ *    typedef DeviceClass MyDeviceClass;
+ *    typedef struct MyDevice
+ *    {
+ *        DeviceState parent;
+ *
+ *        int reg0, reg1, reg2;
+ *    } MyDevice;
+ *
+ *    static const TypeInfo my_device_info = {
+ *        .name = TYPE_MY_DEVICE,
+ *        .parent = TYPE_DEVICE,
+ *        .instance_size = sizeof(MyDevice),
+ *    };
+ *
+ *    static void my_device_register_types(void)
+ *    {
+ *        type_register_static(&my_device_info);
+ *    }
+ *
+ *    type_init(my_device_register_types)
+ *      </programlisting>
  * </example>
  *
  * In the above example, we create a simple type that is described by #TypeInfo.
@@ -79,22 +79,22 @@ typedef struct InterfaceInfo InterfaceInfo;
  * DEFINE_TYPES()
  *
  * <example>
- *   <programlisting>
- * static const TypeInfo device_types_info[] = {
- *     {
- *         .name = TYPE_MY_DEVICE_A,
- *         .parent = TYPE_DEVICE,
- *         .instance_size = sizeof(MyDeviceA),
- *     },
- *     {
- *         .name = TYPE_MY_DEVICE_B,
- *         .parent = TYPE_DEVICE,
- *         .instance_size = sizeof(MyDeviceB),
- *     },
- * };
- *
- * DEFINE_TYPES(device_types_info)
- *   </programlisting>
+ *      <programlisting>
+ *    static const TypeInfo device_types_info[] = {
+ *        {
+ *            .name = TYPE_MY_DEVICE_A,
+ *            .parent = TYPE_DEVICE,
+ *            .instance_size = sizeof(MyDeviceA),
+ *        },
+ *        {
+ *            .name = TYPE_MY_DEVICE_B,
+ *            .parent = TYPE_DEVICE,
+ *            .instance_size = sizeof(MyDeviceB),
+ *        },
+ *    };
+ *
+ *    DEFINE_TYPES(device_types_info)
+ *      </programlisting>
  * </example>
  *
  * Every type has an #ObjectClass associated with it.  #ObjectClass derivatives
@@ -143,22 +143,22 @@ typedef struct InterfaceInfo InterfaceInfo;
  *
  * <example>
  *   <title>Overriding a virtual function</title>
- *   <programlisting>
- * #include "qdev.h"
- *
- * void my_device_class_init(ObjectClass *klass, void *class_data)
- * {
- *     DeviceClass *dc = DEVICE_CLASS(klass);
- *     dc->reset = my_device_reset;
- * }
- *
- * static const TypeInfo my_device_info = {
- *     .name = TYPE_MY_DEVICE,
- *     .parent = TYPE_DEVICE,
- *     .instance_size = sizeof(MyDevice),
- *     .class_init = my_device_class_init,
- * };
- *   </programlisting>
+ *      <programlisting>
+ *    #include "qdev.h"
+ *
+ *    void my_device_class_init(ObjectClass *klass, void *class_data)
+ *    {
+ *        DeviceClass *dc = DEVICE_CLASS(klass);
+ *        dc->reset = my_device_reset;
+ *    }
+ *
+ *    static const TypeInfo my_device_info = {
+ *        .name = TYPE_MY_DEVICE,
+ *        .parent = TYPE_DEVICE,
+ *        .instance_size = sizeof(MyDevice),
+ *        .class_init = my_device_class_init,
+ *    };
+ *      </programlisting>
  * </example>
  *
  * Introducing new virtual methods requires a class to define its own
@@ -167,31 +167,31 @@ typedef struct InterfaceInfo InterfaceInfo;
  *
  * <example>
  *   <title>Defining an abstract class</title>
- *   <programlisting>
- * #include "qdev.h"
- *
- * typedef struct MyDeviceClass
- * {
- *     DeviceClass parent;
- *
- *     void (*frobnicate) (MyDevice *obj);
- * } MyDeviceClass;
- *
- * static const TypeInfo my_device_info = {
- *     .name = TYPE_MY_DEVICE,
- *     .parent = TYPE_DEVICE,
- *     .instance_size = sizeof(MyDevice),
- *     .abstract = true, // or set a default in my_device_class_init
- *     .class_size = sizeof(MyDeviceClass),
- * };
- *
- * void my_device_frobnicate(MyDevice *obj)
- * {
- *     MyDeviceClass *klass = MY_DEVICE_GET_CLASS(obj);
- *
- *     klass->frobnicate(obj);
- * }
- *   </programlisting>
+ *      <programlisting>
+ *    #include "qdev.h"
+ *
+ *    typedef struct MyDeviceClass
+ *    {
+ *        DeviceClass parent;
+ *
+ *        void (*frobnicate) (MyDevice *obj);
+ *    } MyDeviceClass;
+ *
+ *    static const TypeInfo my_device_info = {
+ *        .name = TYPE_MY_DEVICE,
+ *        .parent = TYPE_DEVICE,
+ *        .instance_size = sizeof(MyDevice),
+ *        .abstract = true, // or set a default in my_device_class_init
+ *        .class_size = sizeof(MyDeviceClass),
+ *    };
+ *
+ *    void my_device_frobnicate(MyDevice *obj)
+ *    {
+ *        MyDeviceClass *klass = MY_DEVICE_GET_CLASS(obj);
+ *
+ *        klass->frobnicate(obj);
+ *    }
+ *      </programlisting>
  * </example>
  *
  * Interfaces
@@ -236,68 +236,68 @@ typedef struct InterfaceInfo InterfaceInfo;
  *
  * <example>
  *   <title>Overriding a virtual method</title>
- *   <programlisting>
- * typedef struct MyState MyState;
- *
- * typedef void (*MyDoSomething)(MyState *obj);
- *
- * typedef struct MyClass {
- *     ObjectClass parent_class;
- *
- *     MyDoSomething do_something;
- * } MyClass;
- *
- * static void my_do_something(MyState *obj)
- * {
- *     // do something
- * }
- *
- * static void my_class_init(ObjectClass *oc, void *data)
- * {
- *     MyClass *mc = MY_CLASS(oc);
- *
- *     mc->do_something = my_do_something;
- * }
- *
- * static const TypeInfo my_type_info = {
- *     .name = TYPE_MY,
- *     .parent = TYPE_OBJECT,
- *     .instance_size = sizeof(MyState),
- *     .class_size = sizeof(MyClass),
- *     .class_init = my_class_init,
- * };
- *
- * typedef struct DerivedClass {
- *     MyClass parent_class;
- *
- *     MyDoSomething parent_do_something;
- * } DerivedClass;
- *
- * static void derived_do_something(MyState *obj)
- * {
- *     DerivedClass *dc = DERIVED_GET_CLASS(obj);
- *
- *     // do something here
- *     dc->parent_do_something(obj);
- *     // do something else here
- * }
- *
- * static void derived_class_init(ObjectClass *oc, void *data)
- * {
- *     MyClass *mc = MY_CLASS(oc);
- *     DerivedClass *dc = DERIVED_CLASS(oc);
- *
- *     dc->parent_do_something = mc->do_something;
- *     mc->do_something = derived_do_something;
- * }
- *
- * static const TypeInfo derived_type_info = {
- *     .name = TYPE_DERIVED,
- *     .parent = TYPE_MY,
- *     .class_size = sizeof(DerivedClass),
- *     .class_init = derived_class_init,
- * };
- *   </programlisting>
+ *      <programlisting>
+ *    typedef struct MyState MyState;
+ *
+ *    typedef void (*MyDoSomething)(MyState *obj);
+ *
+ *    typedef struct MyClass {
+ *        ObjectClass parent_class;
+ *
+ *        MyDoSomething do_something;
+ *    } MyClass;
+ *
+ *    static void my_do_something(MyState *obj)
+ *    {
+ *        // do something
+ *    }
+ *
+ *    static void my_class_init(ObjectClass *oc, void *data)
+ *    {
+ *        MyClass *mc = MY_CLASS(oc);
+ *
+ *        mc->do_something = my_do_something;
+ *    }
+ *
+ *    static const TypeInfo my_type_info = {
+ *        .name = TYPE_MY,
+ *        .parent = TYPE_OBJECT,
+ *        .instance_size = sizeof(MyState),
+ *        .class_size = sizeof(MyClass),
+ *        .class_init = my_class_init,
+ *    };
+ *
+ *    typedef struct DerivedClass {
+ *        MyClass parent_class;
+ *
+ *        MyDoSomething parent_do_something;
+ *    } DerivedClass;
+ *
+ *    static void derived_do_something(MyState *obj)
+ *    {
+ *        DerivedClass *dc = DERIVED_GET_CLASS(obj);
+ *
+ *        // do something here
+ *        dc->parent_do_something(obj);
+ *        // do something else here
+ *    }
+ *
+ *    static void derived_class_init(ObjectClass *oc, void *data)
+ *    {
+ *        MyClass *mc = MY_CLASS(oc);
+ *        DerivedClass *dc = DERIVED_CLASS(oc);
+ *
+ *        dc->parent_do_something = mc->do_something;
+ *        mc->do_something = derived_do_something;
+ *    }
+ *
+ *    static const TypeInfo derived_type_info = {
+ *        .name = TYPE_DERIVED,
+ *        .parent = TYPE_MY,
+ *        .class_size = sizeof(DerivedClass),
+ *        .class_init = derived_class_init,
+ *    };
+ *      </programlisting>
  * </example>
  *
  * Alternatively, object_class_by_name() can be used to obtain the class and
@@ -984,24 +984,24 @@ Object *object_new(const char *typename);
  *
  * <example>
  *   <title>Creating an object with properties</title>
- *   <programlisting>
- *   Error *err = NULL;
- *   Object *obj;
- *
- *   obj = object_new_with_props(TYPE_MEMORY_BACKEND_FILE,
- *                               object_get_objects_root(),
- *                               "hostmem0",
- *                               &err,
- *                               "share", "yes",
- *                               "mem-path", "/dev/shm/somefile",
- *                               "prealloc", "yes",
- *                               "size", "1048576",
- *                               NULL);
- *
- *   if (!obj) {
- *     error_reportf_err(err, "Cannot create memory backend: ");
- *   }
- *   </programlisting>
+ *      <programlisting>
+ *      Error *err = NULL;
+ *      Object *obj;
+ *
+ *      obj = object_new_with_props(TYPE_MEMORY_BACKEND_FILE,
+ *                                  object_get_objects_root(),
+ *                                  "hostmem0",
+ *                                  &err,
+ *                                  "share", "yes",
+ *                                  "mem-path", "/dev/shm/somefile",
+ *                                  "prealloc", "yes",
+ *                                  "size", "1048576",
+ *                                  NULL);
+ *
+ *      if (!obj) {
+ *        error_reportf_err(err, "Cannot create memory backend: ");
+ *      }
+ *      </programlisting>
  * </example>
  *
  * The returned object will have one stable reference maintained
@@ -1053,20 +1053,20 @@ void object_apply_compat_props(Object *obj);
  *
  * <example>
  *   <title>Update an object's properties</title>
- *   <programlisting>
- *   Error *err = NULL;
- *   Object *obj = ...get / create object...;
- *
- *   if (!object_set_props(obj,
- *                         &err,
- *                         "share", "yes",
- *                         "mem-path", "/dev/shm/somefile",
- *                         "prealloc", "yes",
- *                         "size", "1048576",
- *                         NULL)) {
- *     error_reportf_err(err, "Cannot set properties: ");
- *   }
- *   </programlisting>
+ *      <programlisting>
+ *      Error *err = NULL;
+ *      Object *obj = ...get / create object...;
+ *
+ *      if (!object_set_props(obj,
+ *                            &err,
+ *                            "share", "yes",
+ *                            "mem-path", "/dev/shm/somefile",
+ *                            "prealloc", "yes",
+ *                            "size", "1048576",
+ *                            NULL)) {
+ *        error_reportf_err(err, "Cannot set properties: ");
+ *      }
+ *      </programlisting>
  * </example>
  *
  * The returned object will have one stable reference maintained
@@ -1519,15 +1519,15 @@ typedef struct ObjectPropertyIterator {
  *
  * <example>
  *   <title>Using object property iterators</title>
- *   <programlisting>
- *   ObjectProperty *prop;
- *   ObjectPropertyIterator iter;
- *
- *   object_property_iter_init(&iter, obj);
- *   while ((prop = object_property_iter_next(&iter))) {
- *     ... do something with prop ...
- *   }
- *   </programlisting>
+ *      <programlisting>
+ *      ObjectProperty *prop;
+ *      ObjectPropertyIterator iter;
+ *
+ *      object_property_iter_init(&iter, obj);
+ *      while ((prop = object_property_iter_next(&iter))) {
+ *        ... do something with prop ...
+ *      }
+ *      </programlisting>
  * </example>
  */
 void object_property_iter_init(ObjectPropertyIterator *iter,
-- 
2.26.2




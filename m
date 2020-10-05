Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C4CC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 21:20:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCB3F208C3
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 21:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W4f7YBfO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB3F208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPXu4-0003VP-T3
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 17:20:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kPXkb-0008OJ-E5
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 17:10:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30936)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kPXkZ-0007Sa-5S
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 17:10:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601932226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W+yWMzr7we7iUkfgz+kLkjKlVO4iF5CR5vCYlbGAjXM=;
 b=W4f7YBfOAkZL1pwBGmjK7kbbGB3e2q7oK5KA6Ye7TGMMbgSDn6P/Mx+JxstlS26FfBAh2S
 y2cwdcSR0jE5phLfw8Zlc1wUbgLqyyK9ECrGkLcXspZpviN5jfRmWYVf599o9rMRPs2VBy
 H7yccILMO6thfrxkJNl8WAaYG561Ick=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-6n565AwYO3mNHhBpxhkKoA-1; Mon, 05 Oct 2020 17:10:24 -0400
X-MC-Unique: 6n565AwYO3mNHhBpxhkKoA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 625071DDED;
 Mon,  5 Oct 2020 21:10:23 +0000 (UTC)
Received: from localhost (ovpn-119-102.rdu2.redhat.com [10.10.119.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ECE3160BFA;
 Mon,  5 Oct 2020 21:10:22 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 13/21] docs/devel/qom: Fix indentation of code blocks
Date: Mon,  5 Oct 2020 17:09:52 -0400
Message-Id: <20201005211000.710404-14-ehabkost@redhat.com>
In-Reply-To: <20201005211000.710404-1-ehabkost@redhat.com>
References: <20201005211000.710404-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 01:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some code blocks had one extra space, fix that.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20201003025424.199291-4-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 docs/devel/qom.rst | 76 +++++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/docs/devel/qom.rst b/docs/devel/qom.rst
index c4857d95c8e..a47e1b9a239 100644
--- a/docs/devel/qom.rst
+++ b/docs/devel/qom.rst
@@ -284,28 +284,28 @@ in the header file:
 .. code-block:: c
    :caption: Declaring a simple type
 
-    OBJECT_DECLARE_SIMPLE_TYPE(MyDevice, my_device, MY_DEVICE, DEVICE)
+   OBJECT_DECLARE_SIMPLE_TYPE(MyDevice, my_device, MY_DEVICE, DEVICE)
 
 This is equivalent to the following:
 
 .. code-block:: c
    :caption: Expansion from declaring a simple type
 
-    typedef struct MyDevice MyDevice;
-    typedef struct MyDeviceClass MyDeviceClass;
+   typedef struct MyDevice MyDevice;
+   typedef struct MyDeviceClass MyDeviceClass;
 
-    G_DEFINE_AUTOPTR_CLEANUP_FUNC(MyDeviceClass, object_unref)
+   G_DEFINE_AUTOPTR_CLEANUP_FUNC(MyDeviceClass, object_unref)
 
-    #define MY_DEVICE_GET_CLASS(void *obj) \
-            OBJECT_GET_CLASS(MyDeviceClass, obj, TYPE_MY_DEVICE)
-    #define MY_DEVICE_CLASS(void *klass) \
-            OBJECT_CLASS_CHECK(MyDeviceClass, klass, TYPE_MY_DEVICE)
-    #define MY_DEVICE(void *obj)
-            OBJECT_CHECK(MyDevice, obj, TYPE_MY_DEVICE)
+   #define MY_DEVICE_GET_CLASS(void *obj) \
+           OBJECT_GET_CLASS(MyDeviceClass, obj, TYPE_MY_DEVICE)
+   #define MY_DEVICE_CLASS(void *klass) \
+           OBJECT_CLASS_CHECK(MyDeviceClass, klass, TYPE_MY_DEVICE)
+   #define MY_DEVICE(void *obj)
+           OBJECT_CHECK(MyDevice, obj, TYPE_MY_DEVICE)
 
-    struct MyDeviceClass {
-        DeviceClass parent_class;
-    };
+   struct MyDeviceClass {
+       DeviceClass parent_class;
+   };
 
 The 'struct MyDevice' needs to be declared separately.
 If the type requires virtual functions to be declared in the class
@@ -319,33 +319,33 @@ In the simple case the OBJECT_DEFINE_TYPE macro is suitable:
 .. code-block:: c
    :caption: Defining a simple type
 
-    OBJECT_DEFINE_TYPE(MyDevice, my_device, MY_DEVICE, DEVICE)
+   OBJECT_DEFINE_TYPE(MyDevice, my_device, MY_DEVICE, DEVICE)
 
 This is equivalent to the following:
 
 .. code-block:: c
    :caption: Expansion from defining a simple type
 
-    static void my_device_finalize(Object *obj);
-    static void my_device_class_init(ObjectClass *oc, void *data);
-    static void my_device_init(Object *obj);
-
-    static const TypeInfo my_device_info = {
-        .parent = TYPE_DEVICE,
-        .name = TYPE_MY_DEVICE,
-        .instance_size = sizeof(MyDevice),
-        .instance_init = my_device_init,
-        .instance_finalize = my_device_finalize,
-        .class_size = sizeof(MyDeviceClass),
-        .class_init = my_device_class_init,
-    };
-
-    static void
-    my_device_register_types(void)
-    {
-        type_register_static(&my_device_info);
-    }
-    type_init(my_device_register_types);
+   static void my_device_finalize(Object *obj);
+   static void my_device_class_init(ObjectClass *oc, void *data);
+   static void my_device_init(Object *obj);
+
+   static const TypeInfo my_device_info = {
+       .parent = TYPE_DEVICE,
+       .name = TYPE_MY_DEVICE,
+       .instance_size = sizeof(MyDevice),
+       .instance_init = my_device_init,
+       .instance_finalize = my_device_finalize,
+       .class_size = sizeof(MyDeviceClass),
+       .class_init = my_device_class_init,
+   };
+
+   static void
+   my_device_register_types(void)
+   {
+       type_register_static(&my_device_info);
+   }
+   type_init(my_device_register_types);
 
 This is sufficient to get the type registered with the type
 system, and the three standard methods now need to be implemented
@@ -358,9 +358,9 @@ This accepts an array of interface type names.
 .. code-block:: c
    :caption: Defining a simple type implementing interfaces
 
-    OBJECT_DEFINE_TYPE_WITH_INTERFACES(MyDevice, my_device,
-                                       MY_DEVICE, DEVICE,
-                                       { TYPE_USER_CREATABLE }, { NULL })
+   OBJECT_DEFINE_TYPE_WITH_INTERFACES(MyDevice, my_device,
+                                      MY_DEVICE, DEVICE,
+                                      { TYPE_USER_CREATABLE }, { NULL })
 
 If the type is not intended to be instantiated, then then
 the OBJECT_DEFINE_ABSTRACT_TYPE() macro can be used instead:
@@ -368,7 +368,7 @@ the OBJECT_DEFINE_ABSTRACT_TYPE() macro can be used instead:
 .. code-block:: c
    :caption: Defining a simple abstract type
 
-    OBJECT_DEFINE_ABSTRACT_TYPE(MyDevice, my_device, MY_DEVICE, DEVICE)
+   OBJECT_DEFINE_ABSTRACT_TYPE(MyDevice, my_device, MY_DEVICE, DEVICE)
 
 
 
-- 
2.26.2



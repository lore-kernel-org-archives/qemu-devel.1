Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E299C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 19:24:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 584FE2067D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 19:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M8ksUNtc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 584FE2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jygpn-0002VP-Gq
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 15:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jygp6-0001lj-7L
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 15:24:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56688
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jygp3-0000EC-9r
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 15:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595532243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t7wbNdASdF8akO3e0Ul4/2V25kSHararNuSs7DsAJCc=;
 b=M8ksUNtc2am1J+e+vuoJwBpoGzvZDXFlc+jwgws26fNEftzIViTVzTKlgOdwOyU9QfapdO
 Gjv80CFuu7wttMviTfp2I/Qbkgg489u1rA5AEsxNcWk6nVvc9HzmFSOr8buPsxRNghpzwb
 Glzsy09YMazVFX3g3UTjZuvnLW91Hcc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-NtXPsA5SOD6iKvMXGc_eiQ-1; Thu, 23 Jul 2020 15:23:56 -0400
X-MC-Unique: NtXPsA5SOD6iKvMXGc_eiQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB0161B18BC1
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 19:23:55 +0000 (UTC)
Received: from [10.3.112.189] (ovpn-112-189.phx2.redhat.com [10.3.112.189])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5DD5619D7E;
 Thu, 23 Jul 2020 19:23:55 +0000 (UTC)
Subject: Re: [PATCH 2/4] qom: provide convenient macros for declaring and
 defining types
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200723181410.3145233-1-berrange@redhat.com>
 <20200723181410.3145233-3-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <2e34d495-b98a-2dd3-2ae6-7ecef14f0d3e@redhat.com>
Date: Thu, 23 Jul 2020 14:23:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200723181410.3145233-3-berrange@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 22:13:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/23/20 1:14 PM, Daniel P. Berrangé wrote:
> When creating new QOM types, there is a lot of boilerplate code that
> must be repeated using a standard pattern. This is tedious to write
> and liable to suffer from subtle inconsistencies. Thus it would
> benefit from some simple automation.
> 
> QOM was loosely inspired by GLib's GObject, and indeed GObject suffers
> from the same burden of boilerplate code, but has long provided a set of
> macros to eliminate this burden in the source implementation. More
> recently it has also provided a set of macros to eliminate this burden
> in the header declaration.
> 
> In GLib there are the G_DECLARE_* and G_DEFINE_* family of macros
> for the header declaration and source implementation respectively:
> 
>    https://developer.gnome.org/gobject/stable/chapter-gobject.html
>    https://developer.gnome.org/gobject/stable/howto-gobject.html
> 
> This patch takes inspiration from GObject to provide the equivalent
> functionality for QOM.
> 

> 
> IOW, in both cases the maintainer now only has to think about the
> interesting part of the code which implements useful functionality
> and avoids much of the boilerplate.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   include/qom/object.h | 277 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 277 insertions(+)
> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 1f8aa2d48e..be64421089 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -304,6 +304,119 @@ typedef struct InterfaceInfo InterfaceInfo;
>    *
>    * The first example of such a QOM method was #CPUClass.reset,
>    * another example is #DeviceClass.realize.
> + *
> + * # Standard type declaration and definition macros #
> + *
> + * A lot of the code outlined above follows a standard pattern and naming
> + * convention. To reduce the amount of boilerplate code that needs to be
> + * written for a new type there are two sets of macros to generate the
> + * common parts in a standard format.
> + *
> + * A type is declared using the OBJECT_DECLARE macro family. In types
> + * which do not require any virtual functions in the class, the
> + * OBJECT_DECLARE_SIMPLE_TYPE macro is suitable, and is commonly placed
> + * in the header file:
> + *
> + * <example>
> + *   <title>Declaring a simple type</title>
> + *   <programlisting>
> + *     OBJECT_DECLARE_SIMPLE_TYPE(MyDevice, my_device, MY_DEVICE, DEVICE)

How sensitive is this macro to trailing semicolon?  Must the user omit 
it (as shown here), supply it (by tweaking the macro to be a syntax 
error if one is not supplied), or is it optional?  I guess whatever glib 
does is fine to copy, though.

Hmm. I think you meant to use s/ DEVICE/ Device/ here...

> + *   </programlisting>
> + * </example>
> + *
> + * This is equivalent to the following:
> + *
> + * <example>
> + *   <title>Expansion from declaring a simple type</title>
> + *   <programlisting>
> + *     typedef struct MyDevice MyDevice;
> + *     typedef struct MyDeviceClass MyDeviceClass;
> + *
> + *     G_DEFINE_AUTOPTR_CLEANUP_FUNC(MyDeviceClass, object_unref)
> + *
> + *     #define MY_DEVICE_GET_CLASS(void *obj) \
> + *             OBJECT_GET_CLASS(MyDeviceClass, obj, TYPE_MY_DEVICE)

How'd you manage to invoke #define inside the OBJECT_DECLARE_SIMPLE_TYPE 
macro expansion?

/me reads ahead

Oh, you didn't; you used a static inline function instead.  But the 
effect is the same, so claiming the equivalence here, while slightly 
misleading, is not horrible.

> + *     #define MY_DEVICE_CLASS(void *klass) \
> + *             OBJECT_CLASS_CHECK(MyDeviceClass, klass, TYPE_MY_DEVICE)
> + *     #define MY_DEVICE(void *obj)
> + *             OBJECT_CHECK(MyDevice, obj, TYPE_MY_DEVICE)
> + *
> + *     struct MyDeviceClass {
> + *         DeviceClass parent_class;

...given that this line is constructed as arg4##Class, and the fact that 
we have DeviceClass, not DEVICEClass.

> + *     };
> + *   </programlisting>
> + * </example>
> + *
> + * The 'struct MyDevice' needs to be declared separately.
> + * If the type requires virtual functions to be declared in the class
> + * struct, then the alternative OBJECT_DECLARE_TYPE() macro can be
> + * used. This does the same as OBJECT_DECLARE_SIMPLE_TYPE(), but without
> + * the 'struct MyDeviceClass' definition.
> + *
> + * To implement the type, the OBJECT_DEFINE macro family is available.
> + * In the simple case the OBJECT_DEFINE_TYPE macro is suitable:
> + *
> + * <example>
> + *   <title>Defining a simple type</title>
> + *   <programlisting>
> + *     OBJECT_DEFINE_TYPE(MyDevice, my_device, MY_DEVICE, DEVICE)

Unlike the declare, here, using DEVICE looks correct...

> + *   </programlisting>
> + * </example>
> + *
> + * This is equivalent to the following:
> + *
> + * <example>
> + *   <title>Expansion from defining a simple type</title>
> + *   <programlisting>
> + *     static void my_device_finalize(Object *obj);
> + *     static void my_device_class_init(ObjectClass *oc, void *data);
> + *     static void my_device_init(Object *obj);
> + *
> + *     static const TypeInfo my_device_info = {
> + *         .parent = TYPE_DEVICE,

...given the expansion here.

> + *         .name = TYPE_MY_DEVICE,
> + *         .instance_size = sizeof(MyDevice),
> + *         .instance_init = my_device_init,
> + *         .instance_finalize = my_device_finalize,
> + *         .class_size = sizeof(MyDeviceClass),
> + *         .class_init = my_device_class_init,
> + *     };
> + *
> + *     static void
> + *     my_device_register_types(void)
> + *     {
> + *         type_register_static(&my_device_info);
> + *     }
> + *     type_init(my_device_register_types);
> + *   </programlisting>
> + * </example>
> + *
> + * This is sufficient to get the type registered with the type
> + * system, and the three standard methods now need to be implemented
> + * along with any other logic required for the type.
> + *
> + * If the type needs to implement one or more interfaces, then the
> + * OBJECT_DEFINE_TYPE_WITH_INTERFACES() macro can be used instead.
> + * This accepts an array of interface type names.
> + *
> + * <example>
> + *   <title>Defining a simple type implementing interfaces</title>
> + *   <programlisting>
> + *     OBJECT_DEFINE_TYPE_WITH_INTERFACES(MyDevice, my_device,
> + *                                        MY_DEVICE, DEVICE,
> + *                                        { TYPE_USER_CREATABLE }, { NULL })
> + *   </programlisting>
> + * </example>
> + *
> + * If the type is not intended to be instantiated, then then
> + * the OBJECT_DEFINE_ABSTRACT_TYPE() macro can be used instead:
> + *
> + * <example>
> + *   <title>Defining a simple type</title>

This title should probably mention 'abstract'.

> + *   <programlisting>
> + *     OBJECT_DEFINE_ABSTRACT_TYPE(MyDevice, my_device, MY_DEVICE, DEVICE)
> + *   </programlisting>
> + * </example>
>    */
>   
>   
> @@ -440,6 +553,170 @@ struct Object
>       Object *parent;
>   };
>   
> +/**
> + * OBJECT_DECLARE_TYPE:
> + * @ModuleObjName: the object name with initial capitalization
> + * @module_obj_name: the object name in lowercase with underscore separators
> + * @MODULE_OBJ_NAME: the object name in uppercase with underscore separators
> + *
> + * This macro is typically used in a header file, and will:
> + *
> + *   - create the typedefs for the object and class structs
> + *   - register the type for use with g_autoptr
> + *   - provide three standard type cast functions
> + *
> + * The object struct and class struct need to be declared manually.
> + */
> +#define OBJECT_DECLARE_TYPE(ModuleObjName, module_obj_name, MODULE_OBJ_NAME) \
> +    typedef struct ModuleObjName ModuleObjName; \
> +    typedef struct ModuleObjName##Class ModuleObjName##Class; \
> +    \
> +    G_DEFINE_AUTOPTR_CLEANUP_FUNC(ModuleObjName##Class, object_unref) \
> +    \
> +    static inline G_GNUC_UNUSED ModuleObjName##Class * \
> +    MODULE_OBJ_NAME##_GET_CLASS(void *obj) \
> +    { return OBJECT_GET_CLASS(ModuleObjName##Class, obj, \
> +                              TYPE_##MODULE_OBJ_NAME); } \
> +    \
> +    static inline G_GNUC_UNUSED ModuleObjName##Class * \
> +    MODULE_OBJ_NAME##_CLASS(void *klass) \
> +    { return OBJECT_CLASS_CHECK(ModuleObjName##Class, klass, \
> +                                TYPE_##MODULE_OBJ_NAME); } \
> +    \
> +    static inline G_GNUC_UNUSED ModuleObjName * \
> +    MODULE_OBJ_NAME(void *obj) \
> +    { return OBJECT_CHECK(ModuleObjName, obj, \
> +                          TYPE_##MODULE_OBJ_NAME); }
> +
> +/**
> + * OBJECT_DECLARE_SIMPLE_TYPE:
> + * @ModuleObjName: the object name with initial caps
> + * @module_obj_name: the object name in lowercase with underscore separators
> + * @MODULE_OBJ_NAME: the object name in uppercase with underscore separators
> + * @ParentModuleObjName: the parent object name with initial caps
> + *
> + * This does the same as OBJECT_DECLARE_TYPE(), but also declares
> + * the class struct, thus only the object struct needs to be declare

declared

> + * manually.
> + *
> + * This macro should be used unless the class struct needs to have
> + * virtual methods declared.
> + */
> +#define OBJECT_DECLARE_SIMPLE_TYPE(ModuleObjName, module_obj_name, \
> +                                   MODULE_OBJ_NAME, ParentModuleObjName) \
> +    OBJECT_DECLARE_TYPE(ModuleObjName, module_obj_name, MODULE_OBJ_NAME) \
> +    struct ModuleObjName##Class { ParentModuleObjName##Class parent_class; };
> +
> +
> +/**
> + * OBJECT_DEFINE_TYPE_EXTENDED:
> + * @ModuleObjName: the object name with initial caps
> + * @module_obj_name: the object name in lowercase with underscore separators
> + * @MODULE_OBJ_NAME: the object name in uppercase with underscore separators
> + * @PARENT_MODULE_OBJ_NAME: the parent object name in uppercase with underscore
> + *                          separators
> + * @ABSTRACT: boolean flag to indicate whether the object can be instantiated
> + * @...: list of initializers for "InterfaceInfo" to declare implemented interfaces
> + *
> + * This macro is typically used in a source file, and will:
> + *
> + *   - declare prototypes for _finalize, _class_init and _init methods
> + *   - declare the TypeInfo struct instance
> + *   - provide the constructor to register the type
> + *
> + * After using this macro, implementations of the _finalize, _class_init,
> + * and _init methods need to be written. Any of these can be zero-line
> + * no-op impls if no special logic is required for a given type.
> + *
> + * This macro should rarely be used, instead one of the more specialized
> + * macros is usually a better choice.
> + */
> +#define OBJECT_DEFINE_TYPE_EXTENDED(ModuleObjName, module_obj_name, \
> +                                    MODULE_OBJ_NAME, PARENT_MODULE_OBJ_NAME, \
> +                                    ABSTRACT, ...) \
> +    static void \
> +    module_obj_name##_finalize(Object *obj); \
> +    static void \
> +    module_obj_name##_class_init(ObjectClass *oc, void *data); \
> +    static void \
> +    module_obj_name##_init(Object *obj); \
> +    \
> +    static const TypeInfo module_obj_name##_info = { \
> +        .parent = TYPE_##PARENT_MODULE_OBJ_NAME, \
> +        .name = TYPE_##MODULE_OBJ_NAME, \
> +        .instance_size = sizeof(ModuleObjName), \
> +        .instance_init = module_obj_name##_init, \
> +        .instance_finalize = module_obj_name##_finalize, \
> +        .class_size = sizeof(ModuleObjName##Class), \
> +        .class_init = module_obj_name##_class_init, \
> +        .abstract = ABSTRACT, \
> +        .interfaces = (InterfaceInfo[]) { __VA_ARGS__ } , \

Odd space before comma.

> +    }; \
> +    \
> +    static void \
> +    module_obj_name##_register_types(void) \
> +    { \
> +        type_register_static(&module_obj_name##_info); \
> +    } \
> +    type_init(module_obj_name##_register_types);
> +
> +/**
> + * OBJECT_DEFINE_TYPE:
> + * @ModuleObjName: the object name with initial caps
> + * @module_obj_name: the object name in lowercase with underscore separators
> + * @MODULE_OBJ_NAME: the object name in uppercase with underscore separators
> + * @PARENT_MODULE_OBJ_NAME: the parent object name in uppercase with underscore
> + *                          separators
> + *
> + * This is a specialization of OBJECT_DEFINE_TYPE_EXTENDED, which is suitable
> + * for the common case of a non-abstract type, without any interfaces.
> + */
> +#define OBJECT_DEFINE_TYPE(ModuleObjName, module_obj_name, MODULE_OBJ_NAME, \
> +                           PARENT_MODULE_OBJ_NAME) \
> +    OBJECT_DEFINE_TYPE_EXTENDED(ModuleObjName, module_obj_name, \
> +                                MODULE_OBJ_NAME, PARENT_MODULE_OBJ_NAME, \
> +                                false, { NULL })
> +
> +/**
> + * OBJECT_DEFINE_TYPE_WITH_INTERFACES:
> + * @ModuleObjName: the object name with initial caps
> + * @module_obj_name: the object name in lowercase with underscore separators
> + * @MODULE_OBJ_NAME: the object name in uppercase with underscore separators
> + * @PARENT_MODULE_OBJ_NAME: the parent object name in uppercase with underscore
> + *                          separators
> + * @...: list of initializers for "InterfaceInfo" to declare implemented interfaces
> + *
> + * This is a specialization of OBJECT_DEFINE_TYPE_EXTENDED, which is suitable
> + * for the common case of a non-abstract type, with one or more implemented
> + * interfaces.
> + *
> + * Note when passing the list of interfaces, be sure to include the final
> + * NULL entry, e.g.  { TYPE_USER_CREATABLE }, { NULL }
> + */
> +#define OBJECT_DEFINE_TYPE_WITH_INTERFACES(ModuleObjName, module_obj_name, \
> +                                           MODULE_OBJ_NAME, \
> +                                           PARENT_MODULE_OBJ_NAME, ...) \
> +    OBJECT_DEFINE_TYPE_EXTENDED(ModuleObjName, module_obj_name, \
> +                                MODULE_OBJ_NAME, PARENT_MODULE_OBJ_NAME, \
> +                                false, __VA_ARGS__)
> +
> +/**
> + * OBJECT_DEFINE_ABSTRACT_TYPE:
> + * @ModuleObjName: the object name with initial caps
> + * @module_obj_name: the object name in lowercase with underscore separators
> + * @MODULE_OBJ_NAME: the object name in uppercase with underscore separators
> + * @PARENT_MODULE_OBJ_NAME: the parent object name in uppercase with underscore
> + *                          separators
> + *
> + * This is a specialization of OBJECT_DEFINE_TYPE_EXTENDED, which is suitable
> + * for defining an abstract type, without any interfaces.
> + */
> +#define OBJECT_DEFINE_ABSTRACT_TYPE(ModuleObjName, module_obj_name, \
> +                                    MODULE_OBJ_NAME, PARENT_MODULE_OBJ_NAME) \
> +    OBJECT_DEFINE_TYPE_EXTENDED(ModuleObjName, module_obj_name, \
> +                                MODULE_OBJ_NAME, PARENT_MODULE_OBJ_NAME, \
> +                                true, { NULL })
> +
>   /**
>    * TypeInfo:
>    * @name: The name of the type.
> 

A couple minor spelling findings, but overall looks good.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org



Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35B2C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 18:23:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C95A2076C
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 18:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WReH1vbo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C95A2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5YvV-0000j1-Q9
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 14:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k5Yuf-0008Ro-0c
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 14:22:17 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37794
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k5Yuc-0005wV-NK
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 14:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597170132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6mRtnlhYpzdhARZbQLETgIpPtJqB7M0tHplyWBb94qY=;
 b=WReH1vbokoEfbbLg3z8S/XPGZ6vWrHjEvxy/exIWhtivj0UHW4VQ5+/Qbx+85RkzMbABdl
 kZWIenl7db8i7DGfO04PuhWidP5tujykZoKc8me5NGATIb/8X7fhJO9dS9XEn/h9Zwx9u1
 o3T0fZ2CnnoQC1k4+R6jY5qh1Wy/23E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-YyaJmkI7O1e7mXux60Y8kg-1; Tue, 11 Aug 2020 14:22:09 -0400
X-MC-Unique: YyaJmkI7O1e7mXux60Y8kg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24D3E107ACCA
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 18:22:08 +0000 (UTC)
Received: from localhost (ovpn-117-153.rdu2.redhat.com [10.10.117.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C93BF65C9B;
 Tue, 11 Aug 2020 18:22:07 +0000 (UTC)
Date: Tue, 11 Aug 2020 14:22:06 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 2/4] qom: provide convenient macros for declaring and
 defining types
Message-ID: <20200811182206.GI1700540@habkost.net>
References: <20200723181410.3145233-1-berrange@redhat.com>
 <20200723181410.3145233-3-berrange@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200723181410.3145233-3-berrange@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 10:41:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I've just noticed this:

On Thu, Jul 23, 2020 at 07:14:08PM +0100, Daniel P. Berrangé wrote:
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
>   https://developer.gnome.org/gobject/stable/chapter-gobject.html
>   https://developer.gnome.org/gobject/stable/howto-gobject.html
> 
> This patch takes inspiration from GObject to provide the equivalent
> functionality for QOM.
> 
> In the header file, instead of:
> 
>     typedef struct MyDevice MyDevice;
>     typedef struct MyDeviceClass MyDeviceClass;
> 
>     G_DEFINE_AUTOPTR_CLEANUP_FUNC(MyDeviceClass, object_unref)

Isn't this supposed to be
  G_DEFINE_AUTOPTR_CLEANUP_FUNC(MyDevice, object_unref)
?

> 
>     #define MY_DEVICE_GET_CLASS(void *obj) \
>             OBJECT_GET_CLASS(MyDeviceClass, obj, TYPE_MY_DEVICE)
>     #define MY_DEVICE_CLASS(void *klass) \
>             OBJECT_CLASS_CHECK(MyDeviceClass, klass, TYPE_MY_DEVICE)
>     #define MY_DEVICE(void *obj)
>             OBJECT_CHECK(MyDevice, obj, TYPE_MY_DEVICE)
> 
>     struct MyDeviceClass {
>         DeviceClass parent_class;
>     };
> 
> We now have
> 
>     OBJECT_DECLARE_SIMPLE_TYPE(MyDevice, my_device, MY_DEVICE, DEVICE)
> 
> In cases where the class needs some virtual methods, it can be left
> to be implemented manually using
> 
>     OBJECT_DECLARE_TYPE(MyDevice, my_device, MY_DEVICE)
> 
> Note that these macros are including support for g_autoptr() for the
> object types, which is something previously only supported for variables
> declared as the base Object * type.
[...]
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
> + *     #define MY_DEVICE_CLASS(void *klass) \
> + *             OBJECT_CLASS_CHECK(MyDeviceClass, klass, TYPE_MY_DEVICE)
> + *     #define MY_DEVICE(void *obj)
> + *             OBJECT_CHECK(MyDevice, obj, TYPE_MY_DEVICE)
> + *
> + *     struct MyDeviceClass {
> + *         DeviceClass parent_class;
> + *     };
> + *   </programlisting>
> + * </example>
[...]
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
[...]

-- 
Eduardo



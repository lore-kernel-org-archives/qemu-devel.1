Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D351C433E5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 09:14:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5838B206EB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 09:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VD6PkrRn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5838B206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jytmV-000280-Ke
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 05:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jytkE-0007jK-Ec
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 05:11:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47245
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jytkC-0004P5-5d
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 05:11:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595581914;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vvw5OOQQywREUTH9/mftqFa8Udf5KmbuMGz9B2gj0n0=;
 b=VD6PkrRnd+ZxMY7B3K6+GOYSuMXGwCNzkPBcZ2CMNeR2f6LB2J28jW0iKqR2ZEIyZvxXnF
 fbjfuyDN4anpnuBSbkI5WuTVzyvDEKQq2aV5LbFrfY8CMyhc6d8YmR49cq8ENO0si5U8go
 3CqEFnVBfOpfgXlmZENonb3/CZTOU08=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-VyZDMFFIOSiuvDDpYuMfqQ-1; Fri, 24 Jul 2020 05:11:48 -0400
X-MC-Unique: VyZDMFFIOSiuvDDpYuMfqQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C40F100CCC0
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 09:11:48 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.43])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9075B71D00;
 Fri, 24 Jul 2020 09:11:46 +0000 (UTC)
Date: Fri, 24 Jul 2020 10:11:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 2/4] qom: provide convenient macros for declaring and
 defining types
Message-ID: <20200724091143.GB3146350@redhat.com>
References: <20200723181410.3145233-1-berrange@redhat.com>
 <20200723181410.3145233-3-berrange@redhat.com>
 <2e34d495-b98a-2dd3-2ae6-7ecef14f0d3e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <2e34d495-b98a-2dd3-2ae6-7ecef14f0d3e@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 00:01:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 23, 2020 at 02:23:54PM -0500, Eric Blake wrote:
> On 7/23/20 1:14 PM, Daniel P. Berrangé wrote:
> > When creating new QOM types, there is a lot of boilerplate code that
> > must be repeated using a standard pattern. This is tedious to write
> > and liable to suffer from subtle inconsistencies. Thus it would
> > benefit from some simple automation.
> > 
> > QOM was loosely inspired by GLib's GObject, and indeed GObject suffers
> > from the same burden of boilerplate code, but has long provided a set of
> > macros to eliminate this burden in the source implementation. More
> > recently it has also provided a set of macros to eliminate this burden
> > in the header declaration.
> > 
> > In GLib there are the G_DECLARE_* and G_DEFINE_* family of macros
> > for the header declaration and source implementation respectively:
> > 
> >    https://developer.gnome.org/gobject/stable/chapter-gobject.html
> >    https://developer.gnome.org/gobject/stable/howto-gobject.html
> > 
> > This patch takes inspiration from GObject to provide the equivalent
> > functionality for QOM.
> > 
> 
> > 
> > IOW, in both cases the maintainer now only has to think about the
> > interesting part of the code which implements useful functionality
> > and avoids much of the boilerplate.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   include/qom/object.h | 277 +++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 277 insertions(+)
> > 
> > diff --git a/include/qom/object.h b/include/qom/object.h
> > index 1f8aa2d48e..be64421089 100644
> > --- a/include/qom/object.h
> > +++ b/include/qom/object.h
> > @@ -304,6 +304,119 @@ typedef struct InterfaceInfo InterfaceInfo;
> >    *
> >    * The first example of such a QOM method was #CPUClass.reset,
> >    * another example is #DeviceClass.realize.
> > + *
> > + * # Standard type declaration and definition macros #
> > + *
> > + * A lot of the code outlined above follows a standard pattern and naming
> > + * convention. To reduce the amount of boilerplate code that needs to be
> > + * written for a new type there are two sets of macros to generate the
> > + * common parts in a standard format.
> > + *
> > + * A type is declared using the OBJECT_DECLARE macro family. In types
> > + * which do not require any virtual functions in the class, the
> > + * OBJECT_DECLARE_SIMPLE_TYPE macro is suitable, and is commonly placed
> > + * in the header file:
> > + *
> > + * <example>
> > + *   <title>Declaring a simple type</title>
> > + *   <programlisting>
> > + *     OBJECT_DECLARE_SIMPLE_TYPE(MyDevice, my_device, MY_DEVICE, DEVICE)
> 
> How sensitive is this macro to trailing semicolon?  Must the user omit it
> (as shown here), supply it (by tweaking the macro to be a syntax error if
> one is not supplied), or is it optional?  I guess whatever glib does is fine
> to copy, though.

Testing it appears it tolerates a ";" but GLib doesn't use it typically
in this case.

> 
> Hmm. I think you meant to use s/ DEVICE/ Device/ here...

Yes.

> 
> > + *   </programlisting>
> > + * </example>
> > + *
> > + * This is equivalent to the following:
> > + *
> > + * <example>
> > + *   <title>Expansion from declaring a simple type</title>
> > + *   <programlisting>
> > + *     typedef struct MyDevice MyDevice;
> > + *     typedef struct MyDeviceClass MyDeviceClass;
> > + *
> > + *     G_DEFINE_AUTOPTR_CLEANUP_FUNC(MyDeviceClass, object_unref)
> > + *
> > + *     #define MY_DEVICE_GET_CLASS(void *obj) \
> > + *             OBJECT_GET_CLASS(MyDeviceClass, obj, TYPE_MY_DEVICE)
> 
> How'd you manage to invoke #define inside the OBJECT_DECLARE_SIMPLE_TYPE
> macro expansion?
> 
> /me reads ahead
> 
> Oh, you didn't; you used a static inline function instead.  But the effect
> is the same, so claiming the equivalence here, while slightly misleading, is
> not horrible.

Yes, I was in two minds here, whether to illustrate the real inline
function, or the macro. I choose the macro to make it clear what kind
of code is being replaced, rather than what kind of code it strictly
produces.

> > + *     #define MY_DEVICE_CLASS(void *klass) \
> > + *             OBJECT_CLASS_CHECK(MyDeviceClass, klass, TYPE_MY_DEVICE)
> > + *     #define MY_DEVICE(void *obj)
> > + *             OBJECT_CHECK(MyDevice, obj, TYPE_MY_DEVICE)
> > + *
> > + *     struct MyDeviceClass {
> > + *         DeviceClass parent_class;
> 
> ...given that this line is constructed as arg4##Class, and the fact that we
> have DeviceClass, not DEVICEClass.
> 
> > + *     };
> > + *   </programlisting>
> > + * </example>
> > + *
> > + * The 'struct MyDevice' needs to be declared separately.
> > + * If the type requires virtual functions to be declared in the class
> > + * struct, then the alternative OBJECT_DECLARE_TYPE() macro can be
> > + * used. This does the same as OBJECT_DECLARE_SIMPLE_TYPE(), but without
> > + * the 'struct MyDeviceClass' definition.
> > + *
> > + * To implement the type, the OBJECT_DEFINE macro family is available.
> > + * In the simple case the OBJECT_DEFINE_TYPE macro is suitable:
> > + *
> > + * <example>
> > + *   <title>Defining a simple type</title>
> > + *   <programlisting>
> > + *     OBJECT_DEFINE_TYPE(MyDevice, my_device, MY_DEVICE, DEVICE)
> 
> Unlike the declare, here, using DEVICE looks correct...

Yes.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



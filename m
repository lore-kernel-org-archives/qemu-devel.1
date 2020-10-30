Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D95EC00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 21:01:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9240020709
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 21:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eXhUps+3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9240020709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYbWz-0005XC-7w
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 17:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYbVj-0004c7-BZ
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 17:00:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25869)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYbVg-00049a-9i
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 17:00:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604091629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mwW+Pd5zFdBCCvI10iBlGOT390kR9hm3PGDMNQV7CHU=;
 b=eXhUps+3l83TLhv13jDjuC6HxJVzvUiUTIdGzkX9wQffNadFC6Bn/InzYYUTkoHoS+HkEU
 XVaiZiBnhNJMj2+uar6rpSxfTjkZL3OpG8u6StEaddgctOet16KMy2a4lugFysXmQcFXKv
 DdNeZ9VOURSpa3AA/PjvkhQoLl9b81I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-9c5oP_LOMrGBaY5yOnXZ7A-1; Fri, 30 Oct 2020 17:00:27 -0400
X-MC-Unique: 9c5oP_LOMrGBaY5yOnXZ7A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43D3F186DD4E
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 21:00:26 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B202710013C1;
 Fri, 30 Oct 2020 21:00:25 +0000 (UTC)
Date: Fri, 30 Oct 2020 17:00:24 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 34/36] machine: Use DEFINE_PROP_STRING for string
 properties
Message-ID: <20201030210024.GR5733@habkost.net>
References: <20201029220246.472693-1-ehabkost@redhat.com>
 <20201029220246.472693-35-ehabkost@redhat.com>
 <ae632c6e-017b-e0e6-0cb2-9ace77a13ff9@redhat.com>
 <20201030200348.GQ5733@habkost.net>
 <CABgObfa5Yt=Si7i0ohhYQdMSzGqj5QEnMmTpO7MsCds0fgW_Mg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABgObfa5Yt=Si7i0ohhYQdMSzGqj5QEnMmTpO7MsCds0fgW_Mg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 16:21:37
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 30, 2020 at 09:41:46PM +0100, Paolo Bonzini wrote:
> Il ven 30 ott 2020, 21:03 Eduardo Habkost <ehabkost@redhat.com> ha scritto:
> 
> > >     OBJECT_CLASS_PROPERTY_ADD_STR(oc, MachineState, kernel_filename,
> > >                                   "kernel", prop_allow_set_always);
> >
> > I like the idea of having an interface like this, but I would
> > like to avoid having to write even more boilerplate for each
> > property type to make this work.
> >
> > What would you think of:
> >    OBJECT_CLASS_PROPERTY_ADD(oc,
> >        PROP_STRING("kernel", MachineState, kernel_filename),
> >        prop_allow_set_always);
> >
> > Then we could make the same PROP_STRING macro usable both as
> > object_class_property_add_static() argument and as initializer
> > for existing static Property arrays.
> >
> 
> The name should be an argument to OBJECT_CLASS_PROPERTY_ADD though (which
> could be a function and not  macro; perhaps
> object_class_property_add_field?). PROP_STRING would be
> DEFINE_PROP_STRING(NULL, etc.) and would not be entirely reusable in
> Property arrays.
> 
> But even with that snag I agree with your less-boilerplate argument against
> my proposal.
> 
> Since most if not all device properties would have to specify the same
> allow-set function, we would end up defining more macros
> DEVICE_CLASS_PROPERTY_ADD_STR, and so on. If the Property isbpassed a
> struct, instead, we can define just one wrapper
> device_class_property_add_field.
> 
> So what about:
> 
> 1) add new constructors without the DEFINE prefix and without the name
> argument
> 
> 2) add object_class_property_add_field
> 
> And later:
> 
> 3) add device_class_property_add_field and remove dc->props
> 
> 4) remove the name field from Property.

Sounds good, and I like the "field property" name.  It is more
descriptive than "static property".

-- 
Eduardo



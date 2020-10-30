Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5A7C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 20:06:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7EFB22263
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 20:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OhGrJje/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7EFB22263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYaf6-0004TS-P5
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 16:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYacv-0002qQ-R5
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 16:03:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59920)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYacs-0005KN-St
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 16:03:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604088233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oa0Nr06We3e8yw8p9yIF8Mjxcg6gOnJZod504R71qtM=;
 b=OhGrJje/v4SQeb7JRNk4wR9xH4R2H58iIZOW4/mLSHjzymAjiS9g7XPaDzUFDAvOIDXC9X
 BnGLpP+oMunRBBxpa3kbrJ31LHWZSEMIYcaEgeEvaYEKEXSQu8qa6WpiWgdqDici9EqaAO
 j3opitXj8Ub2lo7pHXCvzjFfJ1sEMZ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-U8k2llpqOLedLFXdNqY5IA-1; Fri, 30 Oct 2020 16:03:51 -0400
X-MC-Unique: U8k2llpqOLedLFXdNqY5IA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49343100854A
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 20:03:50 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E4ECF55792;
 Fri, 30 Oct 2020 20:03:49 +0000 (UTC)
Date: Fri, 30 Oct 2020 16:03:48 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 34/36] machine: Use DEFINE_PROP_STRING for string
 properties
Message-ID: <20201030200348.GQ5733@habkost.net>
References: <20201029220246.472693-1-ehabkost@redhat.com>
 <20201029220246.472693-35-ehabkost@redhat.com>
 <ae632c6e-017b-e0e6-0cb2-9ace77a13ff9@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ae632c6e-017b-e0e6-0cb2-9ace77a13ff9@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 30, 2020 at 06:10:34PM +0100, Paolo Bonzini wrote:
> On 29/10/20 23:02, Eduardo Habkost wrote:
> > +static Property machine_props[] = {
> > +    DEFINE_PROP_STRING("kernel", MachineState, kernel_filename),
> > +    DEFINE_PROP_STRING("initrd", MachineState, initrd_filename),
> > +    DEFINE_PROP_STRING("append", MachineState, kernel_cmdline),
> > +    DEFINE_PROP_STRING("dtb", MachineState, dtb),
> > +    DEFINE_PROP_STRING("dumpdtb", MachineState, dumpdtb),
> > +    DEFINE_PROP_STRING("dt-compatible", MachineState, dt_compatible),
> > +    DEFINE_PROP_STRING("firmware", MachineState, firmware),
> > +    DEFINE_PROP_STRING("memory-backend", MachineState, ram_memdev_id),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> 
> While I think generalizing the _code_ for static properties is obviously
> a good idea, I am not sure about generalizing the interface for adding them.
> 
> The reason is that we already have a place for adding properties in
> class_init, and having a second makes things "less local", so to speak.
> 
> What do you think about adding macros like
> 
>     OBJECT_CLASS_PROPERTY_ADD_STR(oc, MachineState, kernel_filename,
>                                   "kernel", prop_allow_set_always);

I like the idea of having an interface like this, but I would
like to avoid having to write even more boilerplate for each
property type to make this work.

What would you think of:

   OBJECT_CLASS_PROPERTY_ADD(oc,
       PROP_STRING("kernel", MachineState, kernel_filename),
       prop_allow_set_always);

Then we could make the same PROP_STRING macro usable both as
object_class_property_add_static() argument and as initializer
for existing static Property arrays.

-- 
Eduardo



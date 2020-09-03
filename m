Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C9CC433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:28:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9278920758
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y6VBvrac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9278920758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDs6P-0008Kj-OT
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 12:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDs5g-0007cI-5u
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:28:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60529
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDs5e-0002Hy-2x
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599150476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FUSpVNU9wskY8gocipTDH0zGtahy4Kk1NVcmQ//E4i8=;
 b=Y6VBvract0onJ5lx8tQWFizyw6A9WSJp4pP2vAz0W5/wuttoDxWWbls22CvMw1AbbBkZGx
 rAPpIOyiQjdRwokrDeCR3P306pQH7BS17zyQN6q6RcBwZde5m0NJRMNWPFkljOeFuD09ej
 5VEMzRqViIvQQFAWSKuPRNwzH59aDas=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-DAWAcoPFMDCriPTaKy6x2A-1; Thu, 03 Sep 2020 12:27:54 -0400
X-MC-Unique: DAWAcoPFMDCriPTaKy6x2A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7A6410162BC;
 Thu,  3 Sep 2020 16:27:40 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0A3BE756C6;
 Thu,  3 Sep 2020 16:27:33 +0000 (UTC)
Date: Thu, 3 Sep 2020 12:27:32 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 16/63] i8259: Rename TYPE_KVM_I8259 to TYPE_KVM_PIC
Message-ID: <20200903162732.GJ4940@habkost.net>
References: <20200902224311.1321159-1-ehabkost@redhat.com>
 <20200902224311.1321159-17-ehabkost@redhat.com>
 <edcbfa50-c0cd-27f2-f114-2d987715531b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <edcbfa50-c0cd-27f2-f114-2d987715531b@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 00:24:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 berrange@redhat.com, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 03, 2020 at 02:53:52PM +0200, Philippe Mathieu-Daudé wrote:
> On 9/3/20 12:42 AM, Eduardo Habkost wrote:
> > This will make the type name constant consistent with the name of
> > the type checking macro.
> > 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Richard Henderson <rth@twiddle.net>
> > Cc: Eduardo Habkost <ehabkost@redhat.com>
> > Cc: qemu-devel@nongnu.org
> > ---
> >  hw/i386/kvm/i8259.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
> > index 3f8bf69e9c..687c0cd536 100644
> > --- a/hw/i386/kvm/i8259.c
> > +++ b/hw/i386/kvm/i8259.c
> > @@ -19,10 +19,10 @@
> >  #include "sysemu/kvm.h"
> >  #include "qom/object.h"
> >  
> > -#define TYPE_KVM_I8259 "kvm-i8259"
> > +#define TYPE_KVM_PIC "kvm-i8259"
> 
> I disagree with this patch, as we have various KVM INTC and only one
> KVM_I8259.
> 
> TYPE_KVM_ARM_GIC and TYPE_KVM_S390_FLIC are kind of TYPE_KVM_INTC ...
> 
> Can we rename it KVM_I8259_PIC?

I'm inclined to agree, but I'm not completely sure.

Why is it OK to have a macro named KVM_PIC, a struct named
KVMPICClass, a struct named PICCommonState, but not OK to have a
constant named TYPE_KVM_PIC?  What about the TYPE_PIC_COMMON
constant?

All these symbols are internal to the i8259 code and aren't
expected to be unique globally.  Are TYPE_* names more special
and expected to be unique globally?  If yes, why?

-- 
Eduardo



Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16560C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 08:52:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D05A7206F4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 08:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pef4zBQH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D05A7206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZW4m-0006lT-U1
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 04:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jZW4E-0006Lz-Co
 for qemu-devel@nongnu.org; Fri, 15 May 2020 04:51:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54474
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jZW4D-0004kf-DE
 for qemu-devel@nongnu.org; Fri, 15 May 2020 04:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589532700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GObPfDjQ2ihLN6kiGyfn/3ObOefGCwhkD6WNYXVH588=;
 b=Pef4zBQHGLPwhd9ohPcp/8L9KTSDsfTIfN8nokfiJ9rdG2zBNjXzfGaAYY5+Mep4/5Yrra
 0JBagY2BysLQ7sgzvaIHZOCnvbvyrDMowTyplShzObPy4okPZnIVBdttiFqQFYmXKOqIQx
 Uj7v0tMKGwAEaEFxPG5jXr69049XTZI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-WbbLMCvtP2KAq2_J9HXc1Q-1; Fri, 15 May 2020 04:51:38 -0400
X-MC-Unique: WbbLMCvtP2KAq2_J9HXc1Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 365C3835B74;
 Fri, 15 May 2020 08:51:37 +0000 (UTC)
Received: from gondolin (ovpn-112-229.ams2.redhat.com [10.36.112.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 54EC682A0A;
 Fri, 15 May 2020 08:51:36 +0000 (UTC)
Date: Fri, 15 May 2020 10:51:33 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 1/3] docs/s390x: document the virtual css
Message-ID: <20200515105133.12ffb2be.cohuck@redhat.com>
In-Reply-To: <7876d0f3-7bb9-38b9-6675-94ba6bd47a1a@redhat.com>
References: <20200505135025.14614-1-cohuck@redhat.com>
 <20200505135025.14614-2-cohuck@redhat.com>
 <7876d0f3-7bb9-38b9-6675-94ba6bd47a1a@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 23:27:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 15 May 2020 09:04:13 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 05/05/2020 15.50, Cornelia Huck wrote:

> > +Examples
> > +--------
> > +
> > +* a virtio-net device, cssid/ssid/devno automatically assigned::
> > +
> > +    -device virtio-net-ccw
> > +
> > +  In a Linux guest (without default devices and no other devices specified
> > +  prior to this one), this will show up as ``0.0.0000`` under subchannel
> > +  ``0.0.0000``.  
> 
> Maybe mention the QEMU side again, e.g. that when you run "info qtree"
> in the HMP monitor, you see the device with dev_id = "fe.0.0000".

Yes, that's a good idea.

> 
> > +* a virtio-rng device in subchannel set ``0``::
> > +
> > +    -device virtio-rng-ccw,devno=fe.0.0042
> > +
> > +  If added to the same Linux guest as above, it would show up as ``0.0.0042``
> > +  under subchannel ``0.0.0001``.  
> 
> Does "same" matter here? Otherwise, maybe just say "to a Linux guest" ?

I wanted to provide the subchannel number in my examples as well. As
QEMU always picks the first free one (and you cannot specify it
manually), I wanted to make the examples build upon each other.

> 
> > +* a virtio-gpu device in subchannel set ``2``::
> > +
> > +    -device virtio-gpu-ccw,devno=fe.2.1111
> > +
> > +  If added to the same Linux guest as above, it would show up as ``0.2.1111``
> > +  under subchannel ``0.2.0000``.  
> 
> Dito.

dito :)

> 
> > +* a virtio-mouse device in a non-standard channel subsystem::
> > +
> > +    -device virtio-mouse-ccw,devno=2.0.2222
> > +
> > +  This would not show up in a standard Linux guest.  
> 
> Ok ... and what happens if you use devno=0.0.1234 ? Will that then show
> up under fe.0.1234 in the guest??

That won't show up in the guest, either -- do you think I should add an
example for that as well?



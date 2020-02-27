Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9991C3F2C0
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 21:53:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93A502469F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 21:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DavPWkZ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A502469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7R6K-00047P-Q7
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 16:53:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43371)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j7R5S-0003D1-Tm
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 16:52:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j7R5Q-000800-Mv
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 16:52:54 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21367
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j7R5Q-0007zc-FN
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 16:52:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582840371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TAk0J/UrkyFWQvHhzzx69BBlqin1TdNAV4qTTX+2Xek=;
 b=DavPWkZ0Ujp58CX9+xYKqVncRGyBUtlkrUakTvkUpgPMH2Flnq7Yljtn7srjVKxAJRKwXY
 NDuX+Tl4913HTqptooVWv+pt+wVfveB7jMbe6UNTNhPyp2f/rndzyF/fV1DB6cr+hkPlHB
 SyYlBvx+vIwFcr8Jh4T6wfkreUnIVyo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-Gd_dWbFKP3un0WOWlCxn5Q-1; Thu, 27 Feb 2020 16:52:49 -0500
X-MC-Unique: Gd_dWbFKP3un0WOWlCxn5Q-1
Received: by mail-qk1-f199.google.com with SMTP id s18so865892qkj.6
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 13:52:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=moAMlzzskKtcd8zwTAhcFbpbO3z3rlAsS3DQi4Rje5s=;
 b=Dp6VBnl3rWerTeFvNiAhzoAorNAJiJ3hrMlOxf0Gji9rJ6s9OD+AoJ6LSvUdySNtgo
 pQCee6KxQZ97y6/O+2lwxqPEMd2gyQejqvNXijZE+oNuKWvnNZduDg40cyL76AALtHOG
 FvcpWaXxPTnUZ2Sat8uRdM6TrHOtai3z0M2Qj5g2UfvWmzN6p9jNRRpsVRAqieIwwhU1
 ptOXnwEF3akpIkAOd6h/+at8gsrw7MKrh+Nd2iCUDemyAGOHDcB0r9y6dVpvJZpx4Q6b
 Nyb7Bb/n6YJAa+ExVPlgnZe28ZksCK2c7H4nT5y63uaWv5Q13EnWZdm6z09VGIoz9dP6
 N3Uw==
X-Gm-Message-State: APjAAAXEqtw336mH8rkxFRT6A4KeT0LTB71QludB6NJKI5spYRb3NbA5
 qA6PVBfAWUYCoUaE3p5svUFYIL0s/Qu/Ae4sEdstmtXIsbDXkjrt5lv9CX8J09XaacwRbgiXvx/
 jz6wraUDFisG6y7o=
X-Received: by 2002:ac8:5399:: with SMTP id x25mr1479934qtp.208.1582840369227; 
 Thu, 27 Feb 2020 13:52:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqxJY6Bad+jQzAptrRwSwtvzGLs8QA6T4pM49JlJmwzIinu+zlLZte5226FV0HofUFlAidyVpA==
X-Received: by 2002:ac8:5399:: with SMTP id x25mr1479907qtp.208.1582840368844; 
 Thu, 27 Feb 2020 13:52:48 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id h8sm3857635qtm.51.2020.02.27.13.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2020 13:52:47 -0800 (PST)
Date: Thu, 27 Feb 2020 16:52:46 -0500
From: Peter Xu <peterx@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v1.1 4/5] KVM: Kick resamplefd for split kernel irqchip
Message-ID: <20200227215246.GM180973@xz-x1>
References: <20200227170048.236599-1-peterx@redhat.com>
 <5e69c385-b27c-61d4-5856-21bcf5e9c8f5@redhat.com>
 <20200227180003.GJ180973@xz-x1>
 <2852480c-89fe-4c4e-75be-7322592976b6@redhat.com>
 <20200227191900.GK180973@xz-x1>
 <8ab9ccaa-7060-9e90-d4a9-a9de32610381@redhat.com>
MIME-Version: 1.0
In-Reply-To: <8ab9ccaa-7060-9e90-d4a9-a9de32610381@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 27, 2020 at 10:14:47PM +0100, Auger Eric wrote:
> Hi Peter,

Hi, Eric,

[...]

> >>>>> +             * the KVM resample fd kick is skipped.  The userspace
> >>>>> +             * needs to remember the resamplefd and kick it when w=
e
> >>>>> +             * receive EOI of this IRQ.
> >>>> Practically we now talk about a VFIO ACTION_UNMASK classical eventfd
> >>>> As such isn't it a bit weird to handle those normal UNMASK eventfds =
in
> >>>> the KVM code?
> >>>
> >>> I'm not sure I completely get the question, but this should be
> >>> something general to KVM resamplefd support.  In other words, this
> >>> should also fix other devices (besides VFIO) when they're using the
> >>> KVM resamplefd, because IMHO it's the resamplefd and split irqchip
> >>> which is really broken here.
> >> Here is my understanding (& memories): the KVM resamplefd is an eventf=
d
> >> you register to KVM so that KVM triggers the resamplefd when KVM traps
> >> the EOI. Here I understand this is the userspace IOAPIC that traps the
> >> EOI and not the in-kernel virtual interrupt controller. So I would hav=
e
> >> expected you just need to signal the VFIO UNMASK eventfd to re-enable
> >> the physical IRQ (which was automasked). This is no more a KVM
> >> resamplefd strictly speaking as KVM is not involved anymore in the
> >> deactivation process.
> >=20
> > Yes KVM kernel side should not be involed when we're using split
> > irqchip in this case.  However it should still belongs to the work of
> > the userspace KVM module (kvm-all.c) so that it can still "mimic" the
> > resamplefd feature that KVM_IRQFD provides.
> OK. So that what my actual question. Should this be handled by kvm-all.c?

It should fix KVM split irqchip with resamplefd, so I think it's
natural to do this in kvm-all.c (I'm a bit puzzled on where else we
can put this... :).  Or did I misunderstood your question?

> >=20
> >>>
> >>> With that in mind, I think KVM should not need to even know what's
> >>> behind the resamplefd (in VFIO's case, it's the UNMASK eventfd).  It
> >>> just needs to kick it when IOAPIC EOI comes for the specific IRQ
> >> But above the userspace directly calls
> >> event_notifier_set(rfd->resample_event);
> >>
> >> This is not KVM anymore that "kicks it". Or maybe I miss something. So
> >> my comment was, why is it handled in the QEMU KVM layer?
> >=20
> > It's my fault to be unclear on using "KVM" above.  I should really say
> > it as kvm-all.c, say, the QEMU layer for the kernel KVM module.
> >=20
> > Indeed this problem is complicated... let me try to summarize.
> >=20
> > Firstly KVM split irqchip and resamplefd is not really going to work
> > in the kernel (I think we just overlooked that when introducing the
> > 2nd feature, no matter which one comes first), because the resample
> > operation should be part of IOAPIC EOI, nevertheless when using split
> > irqchip IOAPIC is in userspace.
> >=20
> > After we noticed this, Alex somewhere proposed to disable that in KVM,
> > which is actually the 1st kernel patch (654f1f13ea56).
> >=20
> > We should (at the same time) propose patch 1 too in this series but I
> > guess everybody just forgot this afterwards (Paolo actually proposed
> > mostly the whole solution but I guess it got forgotten too)...
> >=20
> > About the fast path speedup: the main logic should be to mimic the
> > same resamplefd feature as provided by KVM_IRQFD but this time only in
> > the userspace.  However now we're implementing the same logic only
> > within userspace kvm-all.c, and the kernel KVM should be totally not
> > aware of this.  Doing that benefits us in that the KVM interface in
> > QEMU does not need to be changed (majorly kvm_irqchip_assign_irqfd()).
> > What we need to do is just to wire up the userspace IOAPIC with these
> > resamplefds.  And the idea is actually the same too - someone (VFIO)
> > wants to have one fd (which is the resamplefd) kicked when EOI comes
> > when requesting for a KVM irqfd, no matter who's going to kick it
> > (kernel KVM or userspace).  That's all.
>=20
> Yep I think it makes sense to accelerate the trigger path. And for the
> EOI path if you have means to trap this on the userspace irqchip it
> looks better than doing the map/unmap dance. So it looks a good iead to
> me. Now shall it be in kvm-all.c or elsewhere, to me it is not the most
> important, as long as we reach a consensus and the scheme gets
> documented somewhere.

Sure.

For documentation: as mentioned above, I think the irqfd users will
always use the interface just like before, and the resamplefd should
work exactly like what KVM_IRQFD and kvm_irqchip_assign_irqfd() was
offering before this patch too.  IMO it'll just start to work even for
split irqchips which was silently broken without being noticed.

Thanks,

--=20
Peter Xu



Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86098C3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 15:26:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FC152469F
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 15:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GL2Q/ebS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC152469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7hWx-00049o-Im
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 10:26:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45150)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j7hVz-0003Sk-Hk
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:25:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j7hVy-0006bq-8H
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:25:23 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32660
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j7hVy-0006av-3m
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:25:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582903521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wqgpS/wP2px5A8TpF3M2tuM/x6dRLXInYCPWcmLeS6w=;
 b=GL2Q/ebScXWhdTjGoyIdT+K+6aQP3KGUOgw0GDNE+Mrs50fCBXMot6CTETrh4+aQphniRx
 eO9HN9gcHYcrRUT8esqJ17PZzAmYM9oRqi1mnJdCSx5e1XKXerr8uSxJGGEwpyj5XZiSFC
 YujZ9Jm4FwVMMXZze9jH0ua2l3lLGVg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-30zQAP4RP32KCkBx3ve78g-1; Fri, 28 Feb 2020 10:25:14 -0500
X-MC-Unique: 30zQAP4RP32KCkBx3ve78g-1
Received: by mail-qk1-f197.google.com with SMTP id q123so3171178qkb.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 07:25:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ZeOvIeIebjD6Y7OJNPFUne+pi+e35r4bwDtwDQoZl3o=;
 b=K8txX1fosAkZz8/VU7Wmo1zbC0smswpBMj8khCI/1GTqaxoaOz9BzViThKkn4FJkcr
 KluphpsfzfimBBpOZgpmPFZV89D//b8k+r8pARZtcdla5S7yeh50+XRI8rw36koaAot2
 19kBNna2jdot4AxWBsIpglZOsw4OYDXsNR1rJF8yE90j+x9mGdx0Jg47MdkPnFgQfDhv
 FTd17KECPuU/rWFGB401Ui84S8e4oPgiuwehmuM69RSPvBdFus62yUTbSf06nLfGsX8p
 Xb3nxavfwuvcwzTKLdlrqhdiFEIVPzJ8ZnUeJplrUm+ksMnbn+hGatxN7W5/KlamedpL
 QV0A==
X-Gm-Message-State: APjAAAVw4uMBCm1FYlMf5WL9HMPFjloVtaPD/8VqJaR9seEChAu/v54t
 fseHL7l+h0G0gkqWaKzPsYXvqIT66D+rBMjuS1kgItQZqfuUKRYiGqXbO4RVP6g6QewxhMr3qYf
 Nt96anIswvXurIZw=
X-Received: by 2002:ac8:739a:: with SMTP id t26mr4794657qtp.53.1582903513926; 
 Fri, 28 Feb 2020 07:25:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqzQk4QjgqIVi8XE9EgBWiGRLOK5oibia/gfHK109pT+XeJyVoFzKc30/lcJ2q/9vca6URgftw==
X-Received: by 2002:ac8:739a:: with SMTP id t26mr4794639qtp.53.1582903513660; 
 Fri, 28 Feb 2020 07:25:13 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id t13sm5148174qkm.60.2020.02.28.07.25.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 07:25:13 -0800 (PST)
Date: Fri, 28 Feb 2020 10:25:11 -0500
From: Peter Xu <peterx@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/5] vfio/pci: Fix up breakage against split irqchip and
 INTx
Message-ID: <20200228152511.GS180973@xz-x1>
References: <20200226225048.216508-1-peterx@redhat.com>
 <cf2fab93-d1bc-8a4c-3a26-f14f12bdc07d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cf2fab93-d1bc-8a4c-3a26-f14f12bdc07d@redhat.com>
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 28, 2020 at 11:36:55AM +0100, Paolo Bonzini wrote:
> On 26/02/20 23:50, Peter Xu wrote:
> > VFIO INTx is not working with split irqchip.  On new kernels KVM_IRQFD
> > will directly fail with resamplefd attached so QEMU will automatically
> > fallback to the INTx slow path.  However on old kernels it's still
> > broken.
> >=20
> > Only until recently I noticed that this could also break PXE boot for
> > assigned NICs [1].  My wild guess is that the PXE ROM will be mostly
> > using INTx as well, which means we can't bypass that even if we
> > enables MSI for the guest kernel.
> >=20
> > This series tries to first fix this issue function-wise, then speed up
> > for the INTx again with resamplefd (mostly following the ideas
> > proposed by Paolo one year ago [2]).  My TCP_RR test shows that:
> >=20
> >   - Before this series: this is broken, no number to show
> >=20
> >   - After patch 1 (enable slow path): get 63% perf comparing to full
> >     kernel irqchip
>=20
> Oh, I thought something like patch 1 had already been applied.
>=20
> One comment: because you're bypassing IOAPIC when raising the irq, the
> IOAPIC's remote_irr for example will not be set.  Most OSes probably
> don't care, but it's at least worth a comment.

Ouch I should definitely do that...  How about something like this
(in ioapic_eoi_broadcast(), I even changed kvm_resample_fd_notify to
return a boolean to show whether some GSI is kicked so for this case
we don't need to proceed on checking irr and remote irr):

            /*
             * When IOAPIC is in the userspace while APIC is still in
             * the kernel (i.e., split irqchip), we have a trick to
             * kick the resamplefd logic for registered irqfds from
             * userspace to deactivate the IRQ.  When that happens, it
             * means the irq bypassed userspace IOAPIC (so the irr and
             * remote-irr of the table entry should be bypassed too
             * even if interrupt come), then we don't need to clear
             * the remote-IRR and check irr again because they'll
             * always be zeros.
             */
            if (kvm_resample_fd_notify(n)) {
                continue;
            }

I confess this is still tricky, and actually after some careful read I
noticed you've proposed a similar kernel fix for the problem too which
I overlooked (https://patchwork.kernel.org/patch/10738541/#22609933).
My current thought is that we keep this hackery in userspace only so
we keep split+resamplefd forbidden in the kernel and be clean there.

What's your opinion?

(I should have marked this series as RFC when post)

Thanks,

--=20
Peter Xu



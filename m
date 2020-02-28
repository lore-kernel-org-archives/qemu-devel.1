Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53455C3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 14:58:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14A802072A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 14:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ldbidj50"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A802072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7h6I-00055m-8L
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 09:58:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40645)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j7h5c-0004ek-4T
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 09:58:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j7h5b-0007Jv-4F
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 09:58:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31311
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j7h5b-0007JH-0g
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 09:58:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582901885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J0baf9IIXBYV7PvLaQY0bCdaqLne7bstTOv3tPL9+Pg=;
 b=Ldbidj50/wmq2jRzr2sobOFfvKIv0djNKMG1Z2plY0VrRdl2tplHqjuBDjNC5PaQxKLOVY
 bcAOy3iM6lZvhHVqDpxFNxiPAt+5UhN3S4o7jAGbE1KL9zSF3FxHvOwjrcGLIVxuyRHM5u
 iuNjzdg0PRVwrJEd+1VOtUGziFCLiQ8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-VTyMYG18MfeKWQ-MEcgvRg-1; Fri, 28 Feb 2020 09:58:03 -0500
X-MC-Unique: VTyMYG18MfeKWQ-MEcgvRg-1
Received: by mail-qt1-f200.google.com with SMTP id t4so3135384qtd.3
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 06:58:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pFoGFf/7nt2NEkz52rJNFp9fZYcvnDk0Ekq6exGgrnA=;
 b=rM4drvExMgKik6rOm0ZoM4cYqnhMduifnoPo91NDV7NfX/p7WQEdev1DI6sZExxeLW
 ALpHB2Abl0knwbZIW3AREm5CKZiShtM5QtcP13CPdAjEyGb1I1D2WxEaOXTnNqMbjK5G
 icUA5lBAhgL4Q/GS5DbznD/5GiHL5jB+GsFnswfsfMUoP0McPuH+w9SCzZp5SWikA6kZ
 /Mvts7a4t2fObMNxHogVo7wgZvRpQ/1gRgTBFBHxeY3lXv38sHzCIHTR015MRRizQF58
 VxBSsuIpaLIBGryV9cOCA5gbGVGpNTE+UGnH0zZqR7+v1+fo1TIQEPfAQ+E9Lx6ITFBW
 PkhQ==
X-Gm-Message-State: APjAAAUSO88knwvKu4zX3X0TFn0eqiTUcoXxirLSDzbn+9Pq67fEris7
 v7KD9bhv3ygtZ4yZqs3E7ltoii4ypcCsFtOlhpfYyex+0p0YaygfXZbnqdEirWYh9NNdF9SCwm7
 yNQM7Ja9i3DPARM8=
X-Received: by 2002:a0c:9164:: with SMTP id q91mr3965993qvq.115.1582901882768; 
 Fri, 28 Feb 2020 06:58:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqyTn3DM4khwEV4UJTxgNcpTNm1FZAcCl+qevBFKwXM986BO8HtMh3Rt8VCx9LAiThelDAMR2Q==
X-Received: by 2002:a0c:9164:: with SMTP id q91mr3965969qvq.115.1582901882480; 
 Fri, 28 Feb 2020 06:58:02 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id f7sm5548949qtc.29.2020.02.28.06.58.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 06:58:01 -0800 (PST)
Date: Fri, 28 Feb 2020 09:58:00 -0500
From: Peter Xu <peterx@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 4/5] KVM: Kick resamplefd for split kernel irqchip
Message-ID: <20200228145800.GR180973@xz-x1>
References: <20200226225510.217077-1-peterx@redhat.com>
 <0c8147b1-ee26-cd5d-1592-f07371feaeb8@redhat.com>
MIME-Version: 1.0
In-Reply-To: <0c8147b1-ee26-cd5d-1592-f07371feaeb8@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

On Fri, Feb 28, 2020 at 11:34:46AM +0100, Paolo Bonzini wrote:
> On 26/02/20 23:55, Peter Xu wrote:
> > +
> > +            /* Kick resamplefd if KVM is bypassed */
> > +            kvm_resample_fd_notify(n);
>=20
> This is only needed for level-triggered interrupts, so it can be placed
> below the test.

Yes I was thinking it the same way, however...  I noticed that VFIO
will even mask edge INTx after getting IRQ (vfio_intx_handler).  And
if look into current KVM kernel implementation, it has done the same
logic to ack edge triggerred irqs (kvm_ioapic_update_eoi_one), we
should logically ack it here too even for edge-triggered?

Thanks,

>=20
> Paolo
>=20
> > +            if (((entry >> IOAPIC_LVT_TRIGGER_MODE_SHIFT) & 1) !=3D
> > +                IOAPIC_TRIGGER_LEVEL) {
> >                  continue;
>=20

--=20
Peter Xu



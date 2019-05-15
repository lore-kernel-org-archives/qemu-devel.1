Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67F7C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 15:04:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9017520818
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 15:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vy3BcbLd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9017520818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38324 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQvRu-0005oX-MX
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 11:04:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hQvQ5-0004vd-AW
	for qemu-devel@nongnu.org; Wed, 15 May 2019 11:02:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hQvPz-00072E-Lj
	for qemu-devel@nongnu.org; Wed, 15 May 2019 11:02:13 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:34660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hQvPz-00070n-8q
	for qemu-devel@nongnu.org; Wed, 15 May 2019 11:02:07 -0400
Received: by mail-ot1-x330.google.com with SMTP id l17so325090otq.1
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 08:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=D3+PsrFIkM91AP5VuhcwBaagk2YeyL/RyrrR+O/CEyo=;
	b=Vy3BcbLdUH7v1p8H8E56jBzZVZPusosFmmZdKZSu7h65prhvEiX7AOc9CRs2B5iiGc
	Vp0hPNXD3DyVu+o4Uhivs4tkx+XF/JWpsuVOk4ol29DXz2Y3XKaBWY4cuAGsEn09XMat
	+gIQ/tUuDleqxAgOzJLjeu+2k7ikxUFA+m7K1/DTmgrVR/1NuErvzI/VQvuSl3Pb/vkt
	22hAembzma2p7hydPGj9x5Dfx2nniXf7R0LCfHZakCFKHOBEmKgLzeSTFD5iN+qYAMob
	cpb6oZhqQ/X0r25/lodsBFBAPpKtzgFo4o+QYIWUXaOLKSPnwlr7pp7j49V+JRucsv6E
	ot0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=D3+PsrFIkM91AP5VuhcwBaagk2YeyL/RyrrR+O/CEyo=;
	b=eckFZb+4JThVQ83mu8lPEyyzEQ/qvPTUke5QILiYQ+j+2VNZjlmi5n4ZJzLFDzmw5+
	wjJsKzsm/9Z3ozkJRQW0qSa4GqbH1g109cducjeN24UZb8/98Y5Kp+fhSvu7oaOqGf6C
	AJvIVBowmN0y+wIuxYQpp8S9IJg870JNUQR0An1JqjycDF147LdornjcnFovlH9ZprFL
	2Su/DOnrXiOv45VuoJvKpBNvZDRcNwZHepvwE1oYSQRf3JVgSJRYn0zqZFIyYuYfjyty
	CY0EBtpePJWWSh3U8PuO6Zvtid2ZaDYdrswF+yj8cTeEuIWIvzfdbPSnvTRO8QxeV7Rr
	cY/Q==
X-Gm-Message-State: APjAAAWTbJYZjgUsMq9lYf6dhcEZPbidce2b6bx19P43ebPbKCMNIGCJ
	crd6WizicKBXf4VPZ+WVHahLABAUQa59y/m+XsM=
X-Google-Smtp-Source: APXvYqwi//h5edo4jdKjfodY9Cb7gcc3m3PD8yVi9mjD6TRkrBemCaVCaQdys70KPDwWoit3+LFtqB3mucxNH/WhXQA=
X-Received: by 2002:a9d:2c2a:: with SMTP id f39mr24050037otb.67.1557932526139; 
	Wed, 15 May 2019 08:02:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAKXe6SKBgMcq+p7EB1kRWLSbg9NvZg1Mr24UrX8S+kpzq-GR4Q@mail.gmail.com>
	<c707e882-e194-355a-d96c-bfb00a8db247@redhat.com>
	<CAKXe6SKetRL1uEww7wZeOCU5d8t+qrDDjzk3uBsQuhiQzt5S6w@mail.gmail.com>
	<20190515074616.3d6e6b32@x1.home>
	<9e0c77b53b1507e4a2aab2f6296cc7c716864ad3.camel@redhat.com>
	<20190515085359.1f94c81f@x1.home>
In-Reply-To: <20190515085359.1f94c81f@x1.home>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 15 May 2019 23:01:29 +0800
Message-ID: <CAKXe6SKybTqSf1J9WD+QfNLHzG+xvRcC5tEsAcdhU3pxn=_vrw@mail.gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::330
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] Question about the vfio device interrupt
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Auger Eric <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Qemu Developers <qemu-devel@nongnu.org>,
	Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alex Williamson <alex.williamson@redhat.com> =E4=BA=8E2019=E5=B9=B45=E6=9C=
=8815=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8810:54=E5=86=99=E9=81=93=
=EF=BC=9A

> On Wed, 15 May 2019 17:27:52 +0300
> Maxim Levitsky <mlevitsk@redhat.com> wrote:
>
> > Hi!
> >
> > Let me add my 0.2 cents to this discussion by sharing my summary of INT=
x
> emulation in VFIO:
> >
> > COMMON:
> > * real interrupt is signaled in the kernel
> > * vfio-pci kernel interrupt hanlder (vfio_intx_handler), masks the INTx
> flag
> > * vfio-pci kernel interrupt handler triggers an eventfd, if the
> interrupt is not virtually intx masked
> >   (an eventfd which was registred for VFIO_IRQ_SET_DATA_EVENTFD |
> VFIO_IRQ_SET_ACTION_TRIGGER)
> >
> >
> > KERNEL INTERRUPT CONTROLLER CASE:
> >
> > * the vfio-pci eventfd is listened by the kvm (set by KVM_IRQFD ioctl),
> and delivered to guest ioapic
> >   (the setup is done by qemu in vfio_intx_enable_kvm, the same eventfd
> is given to vfio-pci and to kvm)
> > * when guest writes eoi, an 'resamplefd' is (which is registered by
> vfio_intx_enable_kvm too)
> >   is triggered.
> >   the vfio_intx_enable_kvm tells the vfio pci module
> (VFIO_IRQ_SET_DATA_EVENTFD | VFIO_IRQ_SET_ACTION_UNMASK)
> >   to listen to that 'resamplefd' and unmask the interrupt
> >   (here too, a same eventfd is given to kvm and to vfio-pci, but here
> the kvm signals it, and vfio-pci listens to it).
> >
> >
> > USERSPACE QEMU CASE:
> >
> >   (only happens in short period while vfio_intx_enable is running and
> before it calles the vfio_intx_enable_kvm)
> >   (or when vfio_intx_enable_kvm fails)
> >
> > * the vfio-pci eventfd is listened by the qemu (vfio_intx_interrupt)
> > * the vfio_intx_interrupt (in qemu)
> >       * masks the interrupt using kernel vfio interface
> >       * unmaps all the device bars and sets a timer to map them again
> >       * sends the interrupt down the qemu stack till it is reinjected t=
o
> the guest
> > * any bar access now goes to qemu via EPT fault
> (vfio_region_read/vfio_region_write)
> > * the bar access
> >       * triggers (vfio_eoi->vfio_intx_eoi) which unmasks (using
> vfio-pci) the interrupt
> >         the idea is that first few bar accesses should ack the interrup=
t
> and thus avoid flood
> >         but some interrupts could still happen (one per bar access)
>
> Full points :)  Thanks,
>


Thanks very much Alex and Maxim!
I appreciate it.

Thanks,
Li Qiang




>
> Alex
>

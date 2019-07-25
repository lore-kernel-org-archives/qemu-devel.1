Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A294C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 12:10:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32A88218F0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 12:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A88218F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqcaH-000590-5t
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 08:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59121)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hqca6-0004hq-PZ
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 08:10:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hqca5-00052c-LN
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 08:10:46 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35394)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hqca5-00052K-HA
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 08:10:45 -0400
Received: by mail-qk1-f194.google.com with SMTP id r21so36242674qke.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 05:10:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=I53Dx2FsuRKetD7AAF5Ldl51XTuX5dwS652ir6FMNvQ=;
 b=FOQeJHavoBkWTV6/DvbA6Co0hT57j5AqeFVx7r1b6Ei34cIKoB+k4hDHr9Tb4XQ/gi
 AK+BKoDDwOaA7wZXH2JYJig6o6HoHt8oZDyfnTr3utk8yxbvp7RZjaKSFFkwhDwo8SXv
 ranOXyl4WsjW7nUG9XqvFnzs1PC1GkHlrJGwignSQDckKDWGjQJJ6YsihwT8byynDpfW
 17NDOAdjWBGgts0H2tUDch//JqcagBAlMNpbi2TNlsqI1QkBba7B7SGIvND/+xUkz5Xi
 cY8cuWD2hlz7Wsgcoe7VWNNt9vy5Conb1OXk1wr7rXDSd47ehdPALwxZjHn6Yww6b+VG
 s+3w==
X-Gm-Message-State: APjAAAXIRK4OxOkpdRwudDzmMRIngpznPnhYqFvp3/ZbfFwr6ET6gzkE
 zTiygr0LdpSxJGOl32k0ixm8rA==
X-Google-Smtp-Source: APXvYqxWPYVS/Haz29pZ3e9YBn00fEyscu3TH2WYXebtHKpqDtvceZZ+ew3Z9i2SDckX1EBtOrLEIw==
X-Received: by 2002:a37:ef03:: with SMTP id j3mr11361262qkk.233.1564056644937; 
 Thu, 25 Jul 2019 05:10:44 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 f132sm20738148qke.88.2019.07.25.05.10.40
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 05:10:44 -0700 (PDT)
Date: Thu, 25 Jul 2019 08:10:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190725080556-mutt-send-email-mst@kernel.org>
References: <20190702121106.28374-1-slp@redhat.com>
 <CAFEAcA-k76t9_TJnYSF_kocgba9dYMyf=Q6OBY2VVuhiWsbqrw@mail.gmail.com>
 <87a7dwnxwj.fsf@redhat.com>
 <CAFEAcA_XfRS1b-4ANmR5WLL=19Md6Dp7+M_FAK8pQAJn2MaCOA@mail.gmail.com>
 <20190702220400.GA13923@localhost>
 <20190725055908-mutt-send-email-mst@kernel.org>
 <CAFEAcA-uDtTFOyTwMY5KtWeqvirxDejQdvnx5OCZ8pyUhKhE+w@mail.gmail.com>
 <87pnlymm47.fsf@redhat.com>
 <d48da49f-c8d8-00f7-1634-569e8d924b8a@redhat.com>
 <CAJSP0QUJCh-SaZ9NQ+Wr8vr7R+gBsfhYmBrx45B4z2G9v9L=1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJSP0QUJCh-SaZ9NQ+Wr8vr7R+gBsfhYmBrx45B4z2G9v9L=1A@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.222.194
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Introduce the microvm machine type
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Maran Wilson <maran.wilson@oracle.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 25, 2019 at 01:01:29PM +0100, Stefan Hajnoczi wrote:
> On Thu, Jul 25, 2019 at 12:23 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
> > On 25/07/19 12:42, Sergio Lopez wrote:
> > > Peter Maydell <peter.maydell@linaro.org> writes:
> > >> On Thu, 25 Jul 2019 at 10:59, Michael S. Tsirkin <mst@redhat.com> wrote:
> > >>> OK so please start with adding virtio 1 support. Guest bits
> > >>> have been ready for years now.
> > >>
> > >> I'd still rather we just used pci virtio. If pci isn't
> > >> fast enough at startup, do something to make it faster...
> > >
> > > Actually, removing PCI (and ACPI), is one of the main ways microvm has
> > > to reduce not only boot time, but also the exposed surface and the
> > > general footprint.
> > >
> > > I think we need to discuss and settle whether using virtio-mmio (even if
> > > maintained and upgraded to virtio 1) for a new machine type is
> > > acceptable or not. Because if it isn't, we should probably just ditch
> > > the whole microvm idea and move to something else.
> >
> > I agree.  IMNSHO the reduced attack surface from removing PCI is
> > (mostly) security theater, however the boot time numbers that Sergio
> > showed for microvm are quite extreme and I don't think there is any hope
> > of getting even close with a PCI-based virtual machine.
> >
> > So I'd even go a step further: if using virtio-mmio for a new machine
> > type is not acceptable, we should admit that boot time optimization in
> > QEMU is basically as good as it can get---low-hanging fruit has been
> > picked with PVH and mmap is the logical next step, but all that's left
> > is optimizing the guest or something else.
> 
> I haven't seen enough analysis to declare boot time optimization done.
> QEMU startup can be profiled and improved.

Right, and that will always stay the case. OTOH imho microvm is
non-intrusive enough, and small enough, that we'd just put it upstream
after addressing low-level comments.
This will allow more contributions from people interested in boot time.
With no cross-version migration support, or maybe migration
disabled completely, maintainance burden should not be too high.
Not everyone wants to hack on pci/acpi specifically.


> The numbers show that removing PCI and ACPI makes things faster but
> this doesn't justify removing them.  Understanding of why they are
> slow is what justifies removing them.  Otherwise it could just be a
> misconfiguration, inefficient implementation, etc and we've seen there
> is low-hanging fruit.
> 
> How much time is spent doing PCI initialization?  Is the vmexit
> pattern for PCI initialization as good as the hardware interface
> allows?

I know in the bios we wanted to use memory mapped for pci config
accesses for a very long time now. This makes each vmexit slower but
cuts the number of exits by half. Only affects seabios though.




> Without an analysis of why things are slow it's not possible come to
> an informed decision.
> 
> Stefan


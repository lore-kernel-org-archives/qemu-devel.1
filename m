Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD661C41514
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 13:48:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 486E622BF5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 13:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 486E622BF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqe6a-0003x0-9o
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 09:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53763)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hqe6O-0003XE-WA
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 09:48:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hqe6N-0000bG-Li
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 09:48:12 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34673)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hqe6N-0000ac-Fq
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 09:48:11 -0400
Received: by mail-qk1-f196.google.com with SMTP id t8so36445093qkt.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 06:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pSuFaS01Nrwwx8Or9Uvqw95qq3RbiHfbGxDnJP4T+1s=;
 b=AIm8cfHZESfCzotR6jndZA02YO06mo4cC9D/M0g25DVIY4YevkdkdkAMJH9P2m8w25
 Sqg7Dt1Q/J3QdGEfqsw18BRaRwR3JrQM3wFo+iSSztxdN68wf4Q8iIXqBZgXPaD+3C5P
 5reK4WkYZeSm1Fbd/QEFi6au3JF4J4VwTXNW2sRMZEZxywCJYcqdXrWMpxS/BsIxUUSy
 P/+oGQ6mkYvmft8z8F6hIMNA+5AnBVqv+2+IPAtkHMO0fSTVCaxKlQubN5F9/Tn+IGmq
 NBSs1cEBhZ7JGvf2XTjKH6g6yamMo7ZgXxk6FSzRgx/ZVSmrtHBpVzxYQ53RTctB9Gtu
 TYaA==
X-Gm-Message-State: APjAAAV6YDb+J8bh9KMihlwWBftlmPPGDkl4dr6d5GosHDGVwbsaTSuc
 AyroVFhPF/Df+1q7AxtKs+D77A==
X-Google-Smtp-Source: APXvYqyiExGW0DV5YM3zSOTi6SWJ7bCiGXqcnj5RrQulQuqWJP9npxF0Qzh2PmQjIY7yETlCsPiBrA==
X-Received: by 2002:a37:a48e:: with SMTP id
 n136mr60063990qke.223.1564062490942; 
 Thu, 25 Jul 2019 06:48:10 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 l19sm28929706qtb.6.2019.07.25.06.48.06
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 06:48:09 -0700 (PDT)
Date: Thu, 25 Jul 2019 09:48:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190725092709-mutt-send-email-mst@kernel.org>
References: <87a7dwnxwj.fsf@redhat.com>
 <CAFEAcA_XfRS1b-4ANmR5WLL=19Md6Dp7+M_FAK8pQAJn2MaCOA@mail.gmail.com>
 <20190702220400.GA13923@localhost>
 <20190725055908-mutt-send-email-mst@kernel.org>
 <CAFEAcA-uDtTFOyTwMY5KtWeqvirxDejQdvnx5OCZ8pyUhKhE+w@mail.gmail.com>
 <87pnlymm47.fsf@redhat.com>
 <d48da49f-c8d8-00f7-1634-569e8d924b8a@redhat.com>
 <CAJSP0QUJCh-SaZ9NQ+Wr8vr7R+gBsfhYmBrx45B4z2G9v9L=1A@mail.gmail.com>
 <20190725080556-mutt-send-email-mst@kernel.org>
 <CAJSP0QVvnXV8Ha0yaO84qLL6unVroV5GqcuL-x9ruB7o_24WBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJSP0QVvnXV8Ha0yaO84qLL6unVroV5GqcuL-x9ruB7o_24WBA@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.222.196
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

On Thu, Jul 25, 2019 at 02:26:12PM +0100, Stefan Hajnoczi wrote:
> On Thu, Jul 25, 2019 at 1:10 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Thu, Jul 25, 2019 at 01:01:29PM +0100, Stefan Hajnoczi wrote:
> > > On Thu, Jul 25, 2019 at 12:23 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
> > > > On 25/07/19 12:42, Sergio Lopez wrote:
> > > > > Peter Maydell <peter.maydell@linaro.org> writes:
> > > > >> On Thu, 25 Jul 2019 at 10:59, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >>> OK so please start with adding virtio 1 support. Guest bits
> > > > >>> have been ready for years now.
> > > > >>
> > > > >> I'd still rather we just used pci virtio. If pci isn't
> > > > >> fast enough at startup, do something to make it faster...
> > > > >
> > > > > Actually, removing PCI (and ACPI), is one of the main ways microvm has
> > > > > to reduce not only boot time, but also the exposed surface and the
> > > > > general footprint.
> > > > >
> > > > > I think we need to discuss and settle whether using virtio-mmio (even if
> > > > > maintained and upgraded to virtio 1) for a new machine type is
> > > > > acceptable or not. Because if it isn't, we should probably just ditch
> > > > > the whole microvm idea and move to something else.
> > > >
> > > > I agree.  IMNSHO the reduced attack surface from removing PCI is
> > > > (mostly) security theater, however the boot time numbers that Sergio
> > > > showed for microvm are quite extreme and I don't think there is any hope
> > > > of getting even close with a PCI-based virtual machine.
> > > >
> > > > So I'd even go a step further: if using virtio-mmio for a new machine
> > > > type is not acceptable, we should admit that boot time optimization in
> > > > QEMU is basically as good as it can get---low-hanging fruit has been
> > > > picked with PVH and mmap is the logical next step, but all that's left
> > > > is optimizing the guest or something else.
> > >
> > > I haven't seen enough analysis to declare boot time optimization done.
> > > QEMU startup can be profiled and improved.
> >
> > Right, and that will always stay the case.
> 
> The microvm design has a premise and it can be answered definitively
> through performance analysis.
> 
> If I had to explain to someone why PCI or ACPI significantly slows
> things down, I couldn't honestly do so.

well with pci each device describes itself. you read
this description dword by dword normally. typical
description is 20-50 words.

if both bios and linux do this, that's twice the amount.

bios also uses two vmexits for each access.

there's also the resource allocation game.

I would say up to 200 exits per device is reasonable.


>  I say significantly because
> PCI init definitely requires more vmexits but can it be a small
> number?

each bus is scanned for devices. 32 accesses, 256 bus numbers
(that's the lastbus thing). Paolo posted a hack just
for the root bus but whenever we have a bridge the problem
will just re-surface.

pcie is actually link based so downstream buses do not
need to be scanned outside device 0 unless we see
a multifunction bit set. I don't think linux
implements this optimization atm.
But still the case for internal buses.


> For ACPI I have no idea why it would consume significant
> amounts of time.


me neither. I suspect it's not vmexit related at all.  Is ACPI driver in
linux just slow?  It's not been designed to be on any data path...
I'd love to know. I don't feel it's fair to ask someone
interested in writing new performant code to necessary optimize
old non-performant one.

> Until we have this knowledge, the premise of microvm is unproven and
> merging it would be premature because maybe we can get into the same
> ballpark by optimizing existing code.

maybe but who is working on this right now?

If it's possible to make PC faster but not enough people
know how to do it, and enough people know how to make microvm
faster, then it does not matter what's possible in theory.


> 
> I'm sorry for being a pain.  I actually think the analysis will
> support microvm, but it still needs to be done in order to justify it.
> 
> Stefan

At some level it would be great to have someone do detailed performance
profiling. But it is a lot of work, which also needs to be justified
given there's working code, and it's not bad code at that.

Yes speeding up PC would be nice but if everyone's gut feeling is it
won't get us what microvm is trying to achieve, why spend cycles making
sure?

-- 
MST


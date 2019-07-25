Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C096C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 14:35:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 747B221901
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 14:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 747B221901
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqeqK-0006Q5-La
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 10:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36260)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hqeq8-00061d-0u
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:35:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hqeq6-0001Qu-RQ
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:35:27 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43579)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hqeq6-0001Qc-Mo
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:35:26 -0400
Received: by mail-qk1-f194.google.com with SMTP id m14so10895985qka.10
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 07:35:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HdNbTjLy0F7WcbRO43oOIdF+JAUK323kw/y21MI2Huw=;
 b=Li5gaWVkxiGo/rln38C44SZgyfPNvxbzmRPyfduPcVxyXVFvguOdD6eCrrV4NZICIC
 qXIt8ycDfM9rEkXmVmI8fsyFCp912uuvDsm8+SyXXclIcfPr193BZfwrPY5lusSEybrS
 7HfnFwituSD6LZkmO1VGBzSNMdchhA0ox5vVAlphY5Gu/F7uAJLlsaXVz0wOCABxhu+g
 mFoWS2wWxF3VU3Lv8ohfWnUrKqLmZMir7RmPoNW/bgAYf2Ch/KVMFeZhVwBSG6TTNFo0
 lcpDC/aKJOSGUfPh//FyvA+CRvwVAf7ziMqg4u4b/8+RTYkGzALFd8Q1zsntnblkSCD9
 RgvQ==
X-Gm-Message-State: APjAAAWpjdOUfaSSo2lGBuAhMXeTZeExZ+6vFoFuGlMsD609HUxuiYnd
 EYWEdXi5rahqbhpyv9vEqf67cA==
X-Google-Smtp-Source: APXvYqz0VEcNWaYthRmf0IQ1Ji61BTSC+J5wE+bNvkwA5W0dNJvKMTQED9XlwR3zma5cTSYWA5zIcw==
X-Received: by 2002:a37:ad0:: with SMTP id 199mr59010438qkk.90.1564065325945; 
 Thu, 25 Jul 2019 07:35:25 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 j6sm21927010qkf.119.2019.07.25.07.35.22
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 07:35:25 -0700 (PDT)
Date: Thu, 25 Jul 2019 10:35:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190725103033-mutt-send-email-mst@kernel.org>
References: <20190725055908-mutt-send-email-mst@kernel.org>
 <CAFEAcA-uDtTFOyTwMY5KtWeqvirxDejQdvnx5OCZ8pyUhKhE+w@mail.gmail.com>
 <87pnlymm47.fsf@redhat.com>
 <d48da49f-c8d8-00f7-1634-569e8d924b8a@redhat.com>
 <CAJSP0QUJCh-SaZ9NQ+Wr8vr7R+gBsfhYmBrx45B4z2G9v9L=1A@mail.gmail.com>
 <20190725080556-mutt-send-email-mst@kernel.org>
 <CAJSP0QVvnXV8Ha0yaO84qLL6unVroV5GqcuL-x9ruB7o_24WBA@mail.gmail.com>
 <ddc31318-dc52-b9f2-5a9d-bd1fc650df5b@redhat.com>
 <CAFEAcA-zBb0mXX1JLoWxz46JDAZFySUZpdONo5uw=KLgJqJ94w@mail.gmail.com>
 <af3acd26-f114-5889-182a-7dbd025393b9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af3acd26-f114-5889-182a-7dbd025393b9@redhat.com>
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
 Maran Wilson <maran.wilson@oracle.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 25, 2019 at 04:26:42PM +0200, Paolo Bonzini wrote:
> On 25/07/19 16:04, Peter Maydell wrote:
> > On Thu, 25 Jul 2019 at 14:43, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >> To me *maintainability is the biggest consideration* when introducing a
> >> new feature.  "We can do just as well with q35" is a good reason to
> >> deprecate and delete microvm, but not a good reason to reject it now as
> >> long as microvm is good enough in terms of maintainability.
> > 
> > I think maintainability matters, but also important is "are
> > we going in the right direction in the first place?".
> > virtio-mmio is (variously deliberately and accidentally)
> > quite a long way behind virtio-pci, and certain kinds of things
> > (hotplug, extensibility beyond a certain number of endpoints)
> > are not going to be possible (either ever, or without a lot
> > of extra design and implementation work to reimplement stuff
> > we have already today with PCI). Are we sure we're not going
> > to end up with a stream of "oh, now we need to implement X for
> > virtio-mmio (that virtio-pci already has)", "users want Y now
> > (that virtio-pci already has)", etc?
> 
> I think this is part of maintainability in a wider sense.  For every
> missing feature there should be a good reason why it's not needed.  And
> if there is already code to do that in QEMU, then there should be an
> excellent reason why it's not being used.  (This was the essence of the
> firmware debate).
> 
> So for microvm you could do without hotplug because the idea is that you
> just tear down the VM and restart it.  Lack of MSI is actually what
> worries me the most, but we could say that microvm clients generally
> have little multiprocessing so it's not common to have multiple network
> flows at the same time and so you don't need multiqueue.

Me too, and in fact someone just posted
	virtio-mmio: support multiple interrupt vectors


> For microvm in particular there are two reasons why we can take some
> shortcuts (but with care):
> 
> - we won't support versioned machine types for microvm.  microvm guests
> die every time you upgrade QEMU, by design.  So this is not another QED,
> which implemented more features than qcow2 but did so at the wrong place
> of the stack.  In fact it's exactly the opposite (it implements less
> features, so that the implementation of e.g. q35 or PCI is untouched and
> does not need one-off boot time optimization hacks)
> 
> - we know that Amazon is using something very similar to microvm in
> production, with virtio-mmio, so the feature set is at least usable for
> something.
> 
> > The other thing is that once we've introduced something we're
> > stuck with whatever it does, because we don't like breaking
> > backwards compatibility. So I think getting the virtio-legacy
> > vs virtio-1 story sorted out before we land microvm is
> > important, at least to the point where we know we haven't
> > backed ourselves into a corner or required a lot of extra
> > effort on transitional-device support that we could have
> > avoided.
> 
> Even though we won't support versioned machine types, I think there is
> agreement that virtio 0.9 is a bad idea and should be fixed.
> 
> Paolo

Right, for the simple reason that mmio does not support transitional
devices, only transitional drivers.  So if we commit to supporting old
guests, we won't be able to back out of that.

> > Which isn't to say that I'm against the microvm approach;
> > just that I'd like us to consider and make a decision on
> > these issues before landing it, rather than just saying
> > "the patches in themselves look good, let's merge it".
> > 
> > thanks
> > -- PMM
> > 


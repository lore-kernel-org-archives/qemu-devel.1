Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773C6C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 12:01:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44B1622C7B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 12:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8AqHeyo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44B1622C7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqcRX-0000yW-HX
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 08:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57479)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hqcRM-0000Zn-Vh
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 08:01:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hqcRL-0000Dd-5D
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 08:01:44 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:34026)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hqcRJ-0000Cw-Fi
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 08:01:43 -0400
Received: by mail-qt1-x841.google.com with SMTP id k10so48827451qtq.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 05:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5X9rHepd70q6K2ZONvtNhRHPsgYeQJev3TWcle09cHA=;
 b=l8AqHeyoaO40CTUsd6lb2uUmVRA5cF8WKUiGGiISQul0rvWARcD7hSYN796w4QbCyr
 8ZvkiP73nWfyEzKFWzoBXJzIInfjwoTtx5QmmtzbYJQ8WFgkaYRoT2EmMqnKZApC4HSP
 5HXpISG6G5+/GzceAq3phF9D51OtC+AacDjGQbIUzNUq0tdIGaNWKAmRDdYuFdpSjzv6
 drWLnCMqUsoMBwxgXrYuzy1Q8yJ1TJxudFtdGhVm6zHo1cSChdjzCieg5GrF1N0hzDDa
 b+0NPhLFH4hcFsnqJYuAspbSwbrRAYsvdEXaCnP+ICGspCgIbWI865C6GeHf4NMUpBFn
 Hu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5X9rHepd70q6K2ZONvtNhRHPsgYeQJev3TWcle09cHA=;
 b=Gx1qgKzNNtOz2ynLOheBKv6q+s0sKV57O25uqSufuai7N3RsDIOPFz0YBasMsCw+r8
 OjUiXEQBz53oQNlI7c0SYOKh1iZR/8kDkpzzpLOOHtsI4yeW2UGqaGzsrWcGZ++w9y/+
 ZljFtvGv8Kd/xFezyA3fujxvtHFkRvd4uxGUJ7zcIp4iJo/b1JzzpS64sLcjkK6vT0cb
 o7NwLgKwqAgDqzmSU3q3VSozNlM+vtj4EB5eqPden7gy/Wfe7kSptkbz0z7MACUenyVk
 YQlxo+YVPnrCrhL2y+OZTHRf7hVM5tHTCJ7WWIyMJgpUfRk4KjgRop8H3TvPiwOxEOxl
 E8QA==
X-Gm-Message-State: APjAAAWP1+zSg697jXppKb1jzL5gwm4Rh+9BwcgRQv0QczaHMmhADGhg
 M1q+cEUXT1ehtySVaXMlT6LH7QCRUxY2xxnC1Xs=
X-Google-Smtp-Source: APXvYqx/qZJTQVgfsZTq0vZokbe8rnWMzbETQkvSDNulVQiLdSinLnOlwpueiurU2TBYiBgu1w10VEqCARqbx9jPCy4=
X-Received: by 2002:a0c:dd86:: with SMTP id v6mr63465741qvk.176.1564056100361; 
 Thu, 25 Jul 2019 05:01:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190702121106.28374-1-slp@redhat.com>
 <CAFEAcA-k76t9_TJnYSF_kocgba9dYMyf=Q6OBY2VVuhiWsbqrw@mail.gmail.com>
 <87a7dwnxwj.fsf@redhat.com>
 <CAFEAcA_XfRS1b-4ANmR5WLL=19Md6Dp7+M_FAK8pQAJn2MaCOA@mail.gmail.com>
 <20190702220400.GA13923@localhost>
 <20190725055908-mutt-send-email-mst@kernel.org>
 <CAFEAcA-uDtTFOyTwMY5KtWeqvirxDejQdvnx5OCZ8pyUhKhE+w@mail.gmail.com>
 <87pnlymm47.fsf@redhat.com> <d48da49f-c8d8-00f7-1634-569e8d924b8a@redhat.com>
In-Reply-To: <d48da49f-c8d8-00f7-1634-569e8d924b8a@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 25 Jul 2019 13:01:29 +0100
Message-ID: <CAJSP0QUJCh-SaZ9NQ+Wr8vr7R+gBsfhYmBrx45B4z2G9v9L=1A@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
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
 "Michael S. Tsirkin" <mst@redhat.com>, Maran Wilson <maran.wilson@oracle.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 25, 2019 at 12:23 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 25/07/19 12:42, Sergio Lopez wrote:
> > Peter Maydell <peter.maydell@linaro.org> writes:
> >> On Thu, 25 Jul 2019 at 10:59, Michael S. Tsirkin <mst@redhat.com> wrote:
> >>> OK so please start with adding virtio 1 support. Guest bits
> >>> have been ready for years now.
> >>
> >> I'd still rather we just used pci virtio. If pci isn't
> >> fast enough at startup, do something to make it faster...
> >
> > Actually, removing PCI (and ACPI), is one of the main ways microvm has
> > to reduce not only boot time, but also the exposed surface and the
> > general footprint.
> >
> > I think we need to discuss and settle whether using virtio-mmio (even if
> > maintained and upgraded to virtio 1) for a new machine type is
> > acceptable or not. Because if it isn't, we should probably just ditch
> > the whole microvm idea and move to something else.
>
> I agree.  IMNSHO the reduced attack surface from removing PCI is
> (mostly) security theater, however the boot time numbers that Sergio
> showed for microvm are quite extreme and I don't think there is any hope
> of getting even close with a PCI-based virtual machine.
>
> So I'd even go a step further: if using virtio-mmio for a new machine
> type is not acceptable, we should admit that boot time optimization in
> QEMU is basically as good as it can get---low-hanging fruit has been
> picked with PVH and mmap is the logical next step, but all that's left
> is optimizing the guest or something else.

I haven't seen enough analysis to declare boot time optimization done.
QEMU startup can be profiled and improved.

The numbers show that removing PCI and ACPI makes things faster but
this doesn't justify removing them.  Understanding of why they are
slow is what justifies removing them.  Otherwise it could just be a
misconfiguration, inefficient implementation, etc and we've seen there
is low-hanging fruit.

How much time is spent doing PCI initialization?  Is the vmexit
pattern for PCI initialization as good as the hardware interface
allows?

Without an analysis of why things are slow it's not possible come to
an informed decision.

Stefan


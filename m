Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABE6C76194
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 13:26:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC6D122BF5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 13:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3KwQOoU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC6D122BF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqdlU-0002Ea-6g
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 09:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48606)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hqdlJ-0001p2-Ql
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 09:26:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hqdlI-0004Hx-Nv
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 09:26:25 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:35672)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hqdlI-0004Hr-IJ
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 09:26:24 -0400
Received: by mail-qk1-x742.google.com with SMTP id r21so36425654qke.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 06:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JCpwHxay66n2Cu3svBtvZoN3m3jfu9nruKWW/12VLQU=;
 b=T3KwQOoUGUowJwCIZ5p7/vfpChT4o/CQH6HlbgJs1kFs3WuZvHWGVsXAmsxyWvMGBp
 YT0+O5yFeqVHDsg59H4YNJpgktpc3oxvrLLWzElE9N2/jVQECf+TOvbWqo9+vO77LopN
 Mr/Ywb0Ngkeny6+900CvI5pEuEMShSp2uhO7mVIZ6iY5GwhE8eygIvPYmTr1FiOi6Hid
 +QHfrnEY41DP7szy2tF7nSljHbEpvwmQbg17/mxSLRiG14Opf9Oh1VzaH5litTcaabkc
 2kqQxiWaFMR3YvD4xBUbRCMA2hMSyOHbHQ450eeeBKA4kij+5FvyzSJ70a+/yHIWMTZL
 fl2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JCpwHxay66n2Cu3svBtvZoN3m3jfu9nruKWW/12VLQU=;
 b=h930iWc6oKhVFDiuw8DhijAKCv6hmhgQjIt8cZNdKNDp0Ih+yBhnncH2uh1GJQGExN
 9MWQ+0Th2h8t6/ktOkzT1QsrjD+oWSbekOrCHqpwmUH2atiyQeFguOzZLA/FlsSUxlJj
 L58ftXOOv66SWAWeO8zn6uzlt2xWE7FpdPC7n0N/R8eMUCxQYqGU6U4K87EPHjerBLIv
 f/Dgj//EtXUHnx4jdJx6/2qf1oQ5NFpsPGhxuFHKyZPoR1jY/cNOVe5MoP+hl1yBYnNT
 Ngzz5hCROzN6pX0UmU6BaBHoHVjgXhUg57lr2Ib0SpYmds8RYrDJNkObDBWVrQUHARXc
 Ea1Q==
X-Gm-Message-State: APjAAAXu45bKhvRPpQN5g9sly6kAdsi9RiOrYepr3rS9nmryy9HP0F5U
 lQA4FqJerAKGuELzcMatK8ZbElyeMNzzjkCry5U=
X-Google-Smtp-Source: APXvYqyc151JJetOCIOMt2yS/zed1Trc9DiE9mmecMs10Fd9K84CYEwwJw2NDUKVU0hFmSvGKn7cMzR14imQxFBY94E=
X-Received: by 2002:a05:620a:1310:: with SMTP id
 o16mr56103298qkj.196.1564061183791; 
 Thu, 25 Jul 2019 06:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190702121106.28374-1-slp@redhat.com>
 <CAFEAcA-k76t9_TJnYSF_kocgba9dYMyf=Q6OBY2VVuhiWsbqrw@mail.gmail.com>
 <87a7dwnxwj.fsf@redhat.com>
 <CAFEAcA_XfRS1b-4ANmR5WLL=19Md6Dp7+M_FAK8pQAJn2MaCOA@mail.gmail.com>
 <20190702220400.GA13923@localhost>
 <20190725055908-mutt-send-email-mst@kernel.org>
 <CAFEAcA-uDtTFOyTwMY5KtWeqvirxDejQdvnx5OCZ8pyUhKhE+w@mail.gmail.com>
 <87pnlymm47.fsf@redhat.com> <d48da49f-c8d8-00f7-1634-569e8d924b8a@redhat.com>
 <CAJSP0QUJCh-SaZ9NQ+Wr8vr7R+gBsfhYmBrx45B4z2G9v9L=1A@mail.gmail.com>
 <20190725080556-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190725080556-mutt-send-email-mst@kernel.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 25 Jul 2019 14:26:12 +0100
Message-ID: <CAJSP0QVvnXV8Ha0yaO84qLL6unVroV5GqcuL-x9ruB7o_24WBA@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
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

On Thu, Jul 25, 2019 at 1:10 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> On Thu, Jul 25, 2019 at 01:01:29PM +0100, Stefan Hajnoczi wrote:
> > On Thu, Jul 25, 2019 at 12:23 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
> > > On 25/07/19 12:42, Sergio Lopez wrote:
> > > > Peter Maydell <peter.maydell@linaro.org> writes:
> > > >> On Thu, 25 Jul 2019 at 10:59, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >>> OK so please start with adding virtio 1 support. Guest bits
> > > >>> have been ready for years now.
> > > >>
> > > >> I'd still rather we just used pci virtio. If pci isn't
> > > >> fast enough at startup, do something to make it faster...
> > > >
> > > > Actually, removing PCI (and ACPI), is one of the main ways microvm has
> > > > to reduce not only boot time, but also the exposed surface and the
> > > > general footprint.
> > > >
> > > > I think we need to discuss and settle whether using virtio-mmio (even if
> > > > maintained and upgraded to virtio 1) for a new machine type is
> > > > acceptable or not. Because if it isn't, we should probably just ditch
> > > > the whole microvm idea and move to something else.
> > >
> > > I agree.  IMNSHO the reduced attack surface from removing PCI is
> > > (mostly) security theater, however the boot time numbers that Sergio
> > > showed for microvm are quite extreme and I don't think there is any hope
> > > of getting even close with a PCI-based virtual machine.
> > >
> > > So I'd even go a step further: if using virtio-mmio for a new machine
> > > type is not acceptable, we should admit that boot time optimization in
> > > QEMU is basically as good as it can get---low-hanging fruit has been
> > > picked with PVH and mmap is the logical next step, but all that's left
> > > is optimizing the guest or something else.
> >
> > I haven't seen enough analysis to declare boot time optimization done.
> > QEMU startup can be profiled and improved.
>
> Right, and that will always stay the case.

The microvm design has a premise and it can be answered definitively
through performance analysis.

If I had to explain to someone why PCI or ACPI significantly slows
things down, I couldn't honestly do so.  I say significantly because
PCI init definitely requires more vmexits but can it be a small
number?  For ACPI I have no idea why it would consume significant
amounts of time.

Until we have this knowledge, the premise of microvm is unproven and
merging it would be premature because maybe we can get into the same
ballpark by optimizing existing code.

I'm sorry for being a pain.  I actually think the analysis will
support microvm, but it still needs to be done in order to justify it.

Stefan


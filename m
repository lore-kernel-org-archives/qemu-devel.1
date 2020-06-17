Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0835C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:59:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78FA32088E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78FA32088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlaTF-0003YE-Pt
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 11:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guilherme.piccoli@canonical.com>)
 id 1jlaSO-0002fN-Sw
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 11:58:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59375)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
 (Exim 4.90_1) (envelope-from <guilherme.piccoli@canonical.com>)
 id 1jlaSM-0006ZY-Ra
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 11:58:32 -0400
Received: from mail-ej1-f72.google.com ([209.85.218.72])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <guilherme.piccoli@canonical.com>) id 1jlaSK-0003rE-Ro
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 15:58:28 +0000
Received: by mail-ej1-f72.google.com with SMTP id bg25so1314413ejb.12
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 08:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RdHGnEjlH+Mi5ZqYwppp48TZAEiD+1F8zacrTigiN+Y=;
 b=K7bFW0ZnERYYnJWmRoFew9RByRxDzGOdcR92NI9gAwTLatEt39/aZPlk3hEZRXICAt
 lSjtxHvw4+lR9UjmF1MMA/IdUlN/iu7xgcTf9rwG7JrpR9iXPDA5EzVo1gxp35VVhXkV
 YiKfq0DVWvKJsuI7/3oigN29iWG4JkuTxb1wW1KSoGDIi32XLK6b+NMYOs3iB1emER0L
 6G9fdsSnZg0PGzm3c400Lucr0WxMopEXaw6nl6MVHrn2sWNbzNNkV/Dl98C8ybYRkZql
 kkQZogVmNLge83g2pHctp31HFAE0uCU3JhoQAwm+rI9nBc5JlgPrTnKkbaijNf1Gm2OQ
 2Crw==
X-Gm-Message-State: AOAM531GAzm5hWreVteDECZKcUq/3yPwBCoQgI3Zr1yiT3XbogkaqgaV
 tOS7WijZ9mXtTth2XlIRnlaEZ5b7gOfVKXSVYtvAp9YECPuqRFqJPoHJKkkF1aT58/X7nV/s3E6
 KOCV+H9FSHNFicxR9YR5Wj1c1o15kvClnR1BmgaCEI0S9gfSE
X-Received: by 2002:a50:ee08:: with SMTP id g8mr7574028eds.267.1592409508458; 
 Wed, 17 Jun 2020 08:58:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQcRWOWbV2cVIXJITXzfVmVlX5/ggUXb9oeLo+NNx/O4Zt/YpMA1PBUYxe0pB2iKZvnjcKrx9npw8slXqdTh0=
X-Received: by 2002:a50:ee08:: with SMTP id g8mr7574006eds.267.1592409508198; 
 Wed, 17 Jun 2020 08:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <99779e9c-f05f-501b-b4be-ff719f140a88@canonical.com>
 <20200616165043.24y2cp53axk7uggy@sirius.home.kraxel.org>
 <20200616165746.GH2788@work-vm>
 <CAHD1Q_zGu4Q63HjHx3aZKu3wh8NppuP6T4kgnUN3j=-ZDufVZA@mail.gmail.com>
 <b423f4a4-2552-bdc8-7c9f-41f200aef672@redhat.com>
 <20200617134652.GE2776@work-vm>
 <20200617154959.GZ2366737@habkost.net>
In-Reply-To: <20200617154959.GZ2366737@habkost.net>
From: Guilherme Piccoli <gpiccoli@canonical.com>
Date: Wed, 17 Jun 2020 12:57:52 -0300
Message-ID: <CAHD1Q_z7E79HwCeFEg8yQOUGsOZRQuhL-zc4RXJdubT3eYp+NA@mail.gmail.com>
Subject: Re: ovmf / PCI passthrough impaired due to very limiting PCI64
 aperture
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=91.189.89.112;
 envelope-from=guilherme.piccoli@canonical.com; helo=youngberry.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 11:58:29
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: Pedro Principeza <pedro.principeza@canonical.com>,
 Dann Frazier <dann.frazier@canonical.com>, qemu-devel@nongnu.org,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 fw@gpiccoli.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Can't qemu reads the host physical bits and pass that as fw_cfg as
"real_host_physbits" or something like that?
OVMF could rely on that - if such property is available, we use it to
extend the PCI64 aperture.

On Wed, Jun 17, 2020 at 12:50 PM Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> On Wed, Jun 17, 2020 at 02:46:52PM +0100, Dr. David Alan Gilbert wrote:
> > * Laszlo Ersek (lersek@redhat.com) wrote:
> > > On 06/16/20 19:14, Guilherme Piccoli wrote:
> > > > Thanks Gerd, Dave and Eduardo for the prompt responses!
> > > >
> > > > So, I understand that when we use "-host-physical-bits", we are
> > > > passing the *real* number for the guest, correct? So, in this case we
> > > > can trust that the guest physbits matches the true host physbits.
> > > >
> > > > What if then we have OVMF relying in the physbits *iff*
> > > > "-host-phys-bits" is used (which is the default in RH and a possible
> > > > machine configuration on libvirt XML in Ubuntu), and we have OVMF
> > > > fallbacks to 36-bit otherwise?
> > >
> > > I've now read the commit message on QEMU commit 258fe08bd341d, and the
> > > complexity is simply stunning.
> > >
> > > Right now, OVMF calculates the guest physical address space size from
> > > various range sizes (such as hotplug memory area end, default or
> > > user-configured PCI64 MMIO aperture), and derives the minimum suitable
> > > guest-phys address width from that address space size. This width is
> > > then exposed to the rest of the firmware with the CPU HOB (hand-off
> > > block), which in turn controls how the GCD (global coherency domain)
> > > memory space map is sized. Etc.
> > >
> > > If QEMU can provide a *reliable* GPA width, in some info channel (CPUID
> > > or even fw_cfg), then the above calculation could be reversed in OVMF.
> > > We could take the width as a given (-> produce the CPU HOB directly),
> > > plus calculate the *remaining* address space between the GPA space size
> > > given by the width, and the end of the memory hotplug area end. If the
> > > "remaining size" were negative, then obviously QEMU would have been
> > > misconfigured, so we'd halt the boot. Otherwise, the remaining area
> > > could be used as PCI64 MMIO aperture (PEI memory footprint of DXE page
> > > tables be darned).
> > >
> > > > Now, regarding the problem "to trust or not" in the guests' physbits,
> > > > I think it's an orthogonal discussion to some extent. It'd be nice to
> > > > have that check, and as Eduardo said, prevent migration in such cases.
> > > > But it's not really preventing OVMF big PCI64 aperture if we only
> > > > increase the aperture _when  "-host-physical-bits" is used_.
> > >
> > > I don't know what exactly those flags do, but I doubt they are clearly
> > > visible to OVMF in any particular way.
> >
> > The firmware should trust whatever it reads from the cpuid and thus gets
> > told from qemu; if qemu is doing the wrong thing there then that's our
> > problem and we need to fix it in qemu.
>
> It is impossible to provide a MAXPHYADDR that the guest can trust
> unconditionally and allow live migration to hosts with different
> sizes at the same time.
>
> Unless we want to drop support live migration to hosts with
> different sizes entirely, we need additional bits to tell the
> guest how much it can trust MAXPHYADDR.
>
> --
> Eduardo
>


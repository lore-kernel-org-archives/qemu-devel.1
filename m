Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E61EC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 09:21:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 058F920659
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 09:21:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 058F920659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhsV3-0005c7-5j
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 05:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47370)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hhsUW-0005C7-ER
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:20:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hhsUV-0007SH-5m
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:20:52 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39241)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hhsUU-0007Qy-UV
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:20:51 -0400
Received: by mail-qk1-f195.google.com with SMTP id i125so10401574qkd.6
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 02:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XPqTY2i5v4Xy9UuvIK6/LYBa1pG1FvSmfEb9q49RmNs=;
 b=GAcB4sT7cJ76wpBTik4iMu4lGRH+vsEzBVioKvAp7ZVbDKr5nON5RvzIHwV+UePh4L
 6QvdDXG68CQUaTBzfTbcA563jVBT3mLiKlp7chAgroRNfrLn+7Id+Dm06ABSI8bnO/8h
 RmJZto2UvcOxJtcKlZIpXDs1Km5+k1iIzxcpjgjWagm8j1X2YoNHBefnEiso1NTKZn8E
 LNreqEqQjJCz/UxaJoC7gOiMywQJBSPtKrysNLXqlQMXDhblrdOZgsQrA/QNMmAdzugK
 XQ7H89qReMDNozdgPQCzz2ERB8IwyFAgcnoOPqwaRECABOKX4wJb94Cs4MrgMUqMrLkb
 a+1g==
X-Gm-Message-State: APjAAAX+JtkuaIzAqtF5VZXgCXkYG9FFXDaMlOGyW7xBJxyOCPGMjX8c
 OLG9aXKAmOFmk8XlMKpi+jT6Aw==
X-Google-Smtp-Source: APXvYqygw12FihgX7gTtnM47v4fx2pvSOwTizTAEOY8S+RKoZGKNnynqOoZmmMMEcM32zTUsrwiX9A==
X-Received: by 2002:a37:7083:: with SMTP id l125mr18885261qkc.71.1561972849732; 
 Mon, 01 Jul 2019 02:20:49 -0700 (PDT)
Received: from redhat.com ([37.26.146.159])
 by smtp.gmail.com with ESMTPSA id o5sm4500534qkf.10.2019.07.01.02.20.46
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 02:20:48 -0700 (PDT)
Date: Mon, 1 Jul 2019 05:20:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190701051959-mutt-send-email-mst@kernel.org>
References: <20190621064615.20099-1-mst@redhat.com>
 <20190621064615.20099-4-mst@redhat.com>
 <20190625150730.31d9d699@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625150730.31d9d699@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.222.195
Subject: Re: [Qemu-devel] [PATCH 3/3] pcie: work around for racy guest init
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 25, 2019 at 03:07:30PM +0200, Igor Mammedov wrote:
> On Fri, 21 Jun 2019 02:46:50 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > During boot, linux guests tend to clear all bits in pcie slot status
> > register which is used for hotplug.
> > If they clear bits that weren't set this is racy and will lose events:
> > not a big problem for manual hotplug on bare-metal, but a problem for us.
> > 
> > For example, the following is broken ATM:
> > 
> > /x86_64-softmmu/qemu-system-x86_64 -enable-kvm -S -machine q35  \
> >     -device pcie-root-port,id=pcie_root_port_0,slot=2,chassis=2,addr=0x2,bus=pcie.0 \
> >     -device virtio-balloon-pci,id=balloon,bus=pcie_root_port_0 \
> >     -monitor stdio disk.qcow2
> > (qemu)device_del balloon
> > (qemu)cont
> > 
> > Balloon isn't deleted as it should.
> > 
> > As a work-around, detect this attempt to clear slot status and revert
> > status to what it was before the write.
> > 
> > Note: in theory this can be detected as a duplicate button press
> > which cancels the previous press. Does not seem to happen in
> > practice as guests seem to only have this bug during init.
> > 
> > Note2: the right thing to do is probably to fix Linux to
> > read status before clearing it, and act on the bits that are set.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  hw/pci/pcie.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> > 
> > diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> > index f8490a00de..c605d32dd4 100644
> > --- a/hw/pci/pcie.c
> > +++ b/hw/pci/pcie.c
> > @@ -610,6 +610,25 @@ void pcie_cap_slot_write_config(PCIDevice *dev, uint16_t slt_ctl, uint16_t slt_s
> >      uint16_t sltsta = pci_get_word(exp_cap + PCI_EXP_SLTSTA);
> >  
> >      if (ranges_overlap(addr, len, pos + PCI_EXP_SLTSTA, 2)) {
> > +        /*
> > +         * Guests tend to clears all bits during init.
> > +         * If they clear bits that weren't set this is racy and will lose events:
> > +         * not a big problem for manual button presses, but a problem for us.
> > +         * As a work-around, detect this and revert status to what it was
> > +         * before the write.
> > +         *
> > +         * Note: in theory this can be detected as a duplicate button press
> > +         * which cancels the previous press. Does not seem to happen in
> > +         * practice as guests seem to only have this bug during init.
> > +         */
> > +#define PCIE_SLOT_EVENTS (PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD | \
> > +                          PCI_EXP_SLTSTA_MRLSC | PCI_EXP_SLTSTA_PDC | \
> > +                          PCI_EXP_SLTSTA_CC)
> > +
> > +        if (val & ~slt_sta & PCIE_SLOT_EVENTS) {
> > +            sltsta = (sltsta & ~PCIE_SLOT_EVENTS) | (slt_sta & PCIE_SLOT_EVENTS);
> I'm reading it as:
>   sltsta = LOWER_PART(sltsta) | UPPER_PART(sltsta)
> which basically
>   sltsta = sltsta
> or am I missing something here?

You are missing the underscore.

slt_sta is the old value.
sltsta is the new value.

> > +            pci_set_word(exp_cap + PCI_EXP_SLTSTA, sltsta);
> > +        }
> >          hotplug_event_clear(dev);
> >      }
> >  


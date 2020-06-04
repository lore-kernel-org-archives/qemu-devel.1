Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E797C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 11:15:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 690CD206A2
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 11:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RqlIywtQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 690CD206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgnpw-00064t-ID
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 07:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jgnpO-0005Yf-VW
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 07:14:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39232
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jgnpO-0007GT-0r
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 07:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591269269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tIOFagEcNRF+Vbbj9M+l/mm3M9pKBR0VJFuMTJIBtmI=;
 b=RqlIywtQ96LgCB/2ojmIcWI9ReF+N1qiT6Ffqh/OfrkGVha8VIXMc4YvPf+pICexgCG6SJ
 NecOttxR8yEdQBlVIPr3vflxe0AGQKLEpU5yQ85SDrDDwy/20iN60fFmLjl/yAuajOAN8+
 34bhL+UWyLl+ATd338Jdxl3Sp5p4UVs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-4scckTd0PuSPDrmDBqlsDw-1; Thu, 04 Jun 2020 07:14:27 -0400
X-MC-Unique: 4scckTd0PuSPDrmDBqlsDw-1
Received: by mail-wm1-f72.google.com with SMTP id v23so1887689wmj.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 04:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tIOFagEcNRF+Vbbj9M+l/mm3M9pKBR0VJFuMTJIBtmI=;
 b=jj29F7cTHk7EwIgKF4PmoGV47aSbglzkGmOtN8e+W4ulohr76q608MSEB1i2zp1qRJ
 raswOfWNpaP5/tWgtqdgobn4+1www0cIeonRjrezrSH5ajHe20v51DHwBWFrMa+tfyoo
 KjGc8RvPb4POVZr+aIdI73c4lcDORNuEGR1Lct/1VcjVr2xFnZVvPcG45dovizUvAT7l
 GnpiXHGwvKxxdhAlTMb7XYLaSq1Jk9/Qw2qAt1XsG204ksGYW0V4io3xvmhy0chLFZlt
 +wUiKhZQtxpBQ0IJk3Mha6fnvoo1P02HL2wygiAHbY+NRyJmbKcgHAurZ8+7KTVGd9ch
 GMqw==
X-Gm-Message-State: AOAM530eM6F0JxMVWpYalmlLPsB66Bttt0Hg21eu7IhNsu2u7W8X7fdt
 klVxH1eicaLBwmbiCwOsqZ+jVtCwMYvCadl0/dtWXgAEjS7uun25j3y0yCjqY6ZaMu07hAKh3nw
 wa9sYAzWCe+yG4D8=
X-Received: by 2002:a1c:a901:: with SMTP id s1mr3775533wme.66.1591269266702;
 Thu, 04 Jun 2020 04:14:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw99Trp3Tnv06RqUGkC9lV/1Sn05N6J4rwpWDKpga16Hk3obnHmc65QcXGhMHhZV5M51V43zw==
X-Received: by 2002:a1c:a901:: with SMTP id s1mr3775516wme.66.1591269266425;
 Thu, 04 Jun 2020 04:14:26 -0700 (PDT)
Received: from redhat.com ([2a00:a040:185:f65:9a3b:8fff:fed3:ad8d])
 by smtp.gmail.com with ESMTPSA id u3sm6759741wmg.38.2020.06.04.04.14.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 04:14:25 -0700 (PDT)
Date: Thu, 4 Jun 2020 07:14:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH] hw/pci/pcie: Move hot plug capability check to pre_plug
 callback
Message-ID: <20200604071341-mutt-send-email-mst@kernel.org>
References: <20200601162934.842648-1-jusual@redhat.com>
 <20200604125755.12944ac4@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200604125755.12944ac4@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:14:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 04, 2020 at 12:57:55PM +0200, Igor Mammedov wrote:
> On Mon,  1 Jun 2020 18:29:34 +0200
> Julia Suvorova <jusual@redhat.com> wrote:
> 
> > Check for hot plug capability earlier to avoid removing devices attached
> > during the initialization process.
> > 
> > Run qemu with an unattached drive:
> >   -drive file=$FILE,if=none,id=drive0 \
> >   -device pcie-root-port,id=rp0,slot=3,bus=pcie.0,hotplug=off
> > Hotplug a block device:
> >   device_add virtio-blk-pci,id=blk0,drive=drive0,bus=rp0
> > If hotplug fails on plug_cb, drive0 will be deleted.
> > 
> > Signed-off-by: Julia Suvorova <jusual@redhat.com>
> > ---
> > Hard to say if it's a bug or generally acceptable behaviour, but seems like
> > hotplug_handler_plug should never fail.
> 
> _unplug shouldn't fail the rest are allowed to, but it's hard to unwind
> intialization cleanly to _plug stage so if it's possible to do checks
> at _pre_plug time (i.e. before device's realize() is called) we should do so.
> 
> Acked-by: Igor Mammedov <imammedo@redhat.com>


Makes sense. Julia could you repost with a tweaked commit log
and I'll apply. Thanks!


> > 
> >  hw/pci/pcie.c | 19 +++++++++++--------
> >  1 file changed, 11 insertions(+), 8 deletions(-)
> > 
> > diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> > index f50e10b8fb..5b9c022d91 100644
> > --- a/hw/pci/pcie.c
> > +++ b/hw/pci/pcie.c
> > @@ -407,6 +407,17 @@ static void pcie_cap_slot_plug_common(PCIDevice *hotplug_dev, DeviceState *dev,
> >  void pcie_cap_slot_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
> >                                 Error **errp)
> >  {
> > +    PCIDevice *hotplug_pdev = PCI_DEVICE(hotplug_dev);
> > +    uint8_t *exp_cap = hotplug_pdev->config + hotplug_pdev->exp.exp_cap;
> > +    uint32_t sltcap = pci_get_word(exp_cap + PCI_EXP_SLTCAP);
> > +
> > +    /* Check if hot-plug is disabled on the slot */
> > +    if (dev->hotplugged && (sltcap & PCI_EXP_SLTCAP_HPC) == 0) {
> > +        error_setg(errp, "Hot-plug failed: unsupported by the port device '%s'",
> > +                         DEVICE(hotplug_pdev)->id);
> > +        return;
> > +    }
> > +
> >      pcie_cap_slot_plug_common(PCI_DEVICE(hotplug_dev), dev, errp);
> >  }
> >  
> > @@ -415,7 +426,6 @@ void pcie_cap_slot_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
> >  {
> >      PCIDevice *hotplug_pdev = PCI_DEVICE(hotplug_dev);
> >      uint8_t *exp_cap = hotplug_pdev->config + hotplug_pdev->exp.exp_cap;
> > -    uint32_t sltcap = pci_get_word(exp_cap + PCI_EXP_SLTCAP);
> >      PCIDevice *pci_dev = PCI_DEVICE(dev);
> >  
> >      /* Don't send event when device is enabled during qemu machine creation:
> > @@ -431,13 +441,6 @@ void pcie_cap_slot_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
> >          return;
> >      }
> >  
> > -    /* Check if hot-plug is disabled on the slot */
> > -    if ((sltcap & PCI_EXP_SLTCAP_HPC) == 0) {
> > -        error_setg(errp, "Hot-plug failed: unsupported by the port device '%s'",
> > -                         DEVICE(hotplug_pdev)->id);
> > -        return;
> > -    }
> > -
> >      /* To enable multifunction hot-plug, we just ensure the function
> >       * 0 added last. When function 0 is added, we set the sltsta and
> >       * inform OS via event notification.



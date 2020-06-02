Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88051C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 07:17:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E636206A2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 07:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kd/rE1/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E636206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg1BB-0005u1-KA
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 03:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsuvorov@redhat.com>)
 id 1jg1AP-0005UR-VQ
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 03:16:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48378
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsuvorov@redhat.com>)
 id 1jg1AO-0003Rz-U2
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 03:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591082215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6ujx9sBfzByzVI+siI1TyJfOhyDV4pBVCQtQPtkZhE8=;
 b=Kd/rE1/f6bYgPBomsJ5yjC4fbDKkAgL5sPPz+C2R7nZ2Tx2qZ7bmhT9jxJ4C53JUGDaglZ
 bd1dJr0tZJCK7FUBPg5PsH4N/dC8n+oJswJB9zNYH/Ez1XgYgJP4uLoajjqVR3UoWUXvL5
 9upCc4YGsoc7jB3HqWYER9F4ZWfCwhU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-sDymJKgWMpelV9OOepb_ig-1; Tue, 02 Jun 2020 03:16:53 -0400
X-MC-Unique: sDymJKgWMpelV9OOepb_ig-1
Received: by mail-lf1-f69.google.com with SMTP id n17so3092957lfe.15
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 00:16:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6ujx9sBfzByzVI+siI1TyJfOhyDV4pBVCQtQPtkZhE8=;
 b=Cahcajt5gsW1u4WbhMPIIbAABO/NqCRUnZstdmBV27jIuH/B20wj5j/tDIwn6LWJem
 pmqnc8xFTYskhc8Kd9THtP29ssRCm490UsZydrCOncFbGSpAFdGvykF+YAN5kjSdd1Jt
 qWTSQy91FjqGXDdbr06nby6Rf+9jnnp7+LRXvCP+CXMz1yi+YRtyF8OiGNxYxkYuMuKm
 9+6oSbe931OY834vdzKKNRX2MLj2dQMrpStCiNHrE39EoxW6Bun3RnrEUNN3OiDmjFBu
 95apNmqhlznxFAGD6JEFq2frzJHD4mo2MWfOM574wqUtLSl/CMm50lcyA3pnfgdVtQ95
 +FdA==
X-Gm-Message-State: AOAM531vg4vW/Uza21vYbPOGwJqYWGGk54fKaE2433sQJp7O9mdfkApR
 TjTH7Nm5pWNUHO/6kX2QZVtr1VvOc8iCvZl2rMvsSV9DQPOeqkM/DmOYo0px3bUJd73KZL51XpZ
 EZwNGRZgihrq+jZtcRA8FzH/FBv0hNu8=
X-Received: by 2002:a2e:8654:: with SMTP id i20mr11476000ljj.79.1591082212191; 
 Tue, 02 Jun 2020 00:16:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyA3mKK7BV0KJtlNgnDON5hSWAbaEFWTkTfzzyX2A/LqJtt+zefDZEO0Qlt0J4e8UKn4B+HDmt6D3FJDK7ZjL8=
X-Received: by 2002:a2e:8654:: with SMTP id i20mr11475984ljj.79.1591082211878; 
 Tue, 02 Jun 2020 00:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200601162934.842648-1-jusual@redhat.com>
 <20200601235345-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200601235345-mutt-send-email-mst@kernel.org>
From: Julia Suvorova <jusual@redhat.com>
Date: Tue, 2 Jun 2020 09:16:40 +0200
Message-ID: <CAMDeoFXGv6bkt=XSjOJq4iL06aZCe+VF3QvP2X9qrhOhPWA0FQ@mail.gmail.com>
Subject: Re: [PATCH] hw/pci/pcie: Move hot plug capability check to pre_plug
 callback
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jsuvorov@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 23:49:17
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 2, 2020 at 5:54 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Jun 01, 2020 at 06:29:34PM +0200, Julia Suvorova wrote:
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
>
>
> Fixes: 0501e1aa1d32a6 ("hw/pci/pcie: Forbid hot-plug if it's disabled on the slot")
>
> correct?

Yes.

> > ---
> > Hard to say if it's a bug or generally acceptable behaviour, but seems like
> > hotplug_handler_plug should never fail.
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
> > --
> > 2.25.4
>



Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9A8C2D0E1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 16:10:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF542221EB
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 16:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MZaEJLk9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF542221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGlck-00054f-NH
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 12:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kGlbn-0004OV-Ft
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 12:09:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27470
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kGlbl-0005d0-83
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 12:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599840543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fs4QeAgnrhZqhHD4eB4fKyWZ528JUfm45eKObDFqIqU=;
 b=MZaEJLk9orSHyOqsrtvqhIV3kWLXHe9bxjdKtkiR8GFG3Bi+o4ejQSp+Qrms88m3ebqFpp
 KgUUoKMFPKR/hZMNEIJdvYllsK0y0NRJGFnIwKCLuZYkYcb95cqHZ+O3w+5KvlsBnYui8p
 2DjH7l9P+enGGu0MTbQKA357tThCS0g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-l2eqZk8ePcOxn_anrYj3_Q-1; Fri, 11 Sep 2020 12:09:01 -0400
X-MC-Unique: l2eqZk8ePcOxn_anrYj3_Q-1
Received: by mail-wr1-f72.google.com with SMTP id 33so3650678wrk.12
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 09:09:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Fs4QeAgnrhZqhHD4eB4fKyWZ528JUfm45eKObDFqIqU=;
 b=r7a2e10IQKSAqE7HIpbZgU6umi2G9d5sxWZdAvYcs8nEXVOJxFQrCMgSUjmWH/5Tg9
 /D+7YZuXwyI9CmrJordmw16r6EMDEem74J3pNZ4wgHLFjGrUOohg1b0Tqn/IVPtLgtqu
 dmBoelX01cN/x3ZpZc+xNrvvF4cAJdwxam4VCYvUsGXKVTUOk/N1JtCnk516uYS7+tfk
 W+GmwHmnCUcyITnFOuON4dhOqux8XHoH0AR0d8ERyi5d4UFt5cxkYzl02a9t22Tf27Nj
 Vdxb7yA8Hn1vZOv7CfOBqLIF56PKK4auxKOXVmvUtANTfcYq16aSBm2Q8CzYj4SKWx7H
 5Y+A==
X-Gm-Message-State: AOAM530wN7b9GCE6BMioB6CiJ1o6Tzq/Ly/lJsY3qvXkT96iXzm9CvGO
 HM6y1FJXPHHL25oPHvqRugNM4RicnM1697T32JuQUGWPKUmvoU2QtwRH00gbOQW5Y6gMyn/Aste
 MY0fFrt43n0G8sLw=
X-Received: by 2002:a5d:494b:: with SMTP id r11mr2758615wrs.227.1599840539192; 
 Fri, 11 Sep 2020 09:08:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGaiFVKGNKr+tXJwKr3NYiE9OB09RiV6jJlFUkUiof/aaX7m4wFRFWtRUMiK7A0vSrXECNtg==
X-Received: by 2002:a5d:494b:: with SMTP id r11mr2758596wrs.227.1599840538960; 
 Fri, 11 Sep 2020 09:08:58 -0700 (PDT)
Received: from redhat.com ([176.230.64.162])
 by smtp.gmail.com with ESMTPSA id o6sm5566304wrm.76.2020.09.11.09.08.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2020 09:08:58 -0700 (PDT)
Date: Fri, 11 Sep 2020 12:08:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <ani@anisinha.ca>
Subject: Re: [PATCH v3] i440fx/acpi: do not add hotplug related amls for cold
 plugged bridges
Message-ID: <20200911120838-mutt-send-email-mst@kernel.org>
References: <20200904161000.12115-1-ani@anisinha.ca>
 <CAMDeoFVQWeWArPty2z4rNbdmS7O2X66SaONqiKzFqFpaKwuNDg@mail.gmail.com>
 <98b26cfa-3ff7-4302-9fc2-0e6672cfbd08@Spark>
 <a6c38469-356d-4629-be12-92129e1b1b96@Spark>
 <20200911115138-mutt-send-email-mst@kernel.org>
 <CAARzgwyKccWaPDSwsAg7bW7=F7DxAsf7Lw=TvqOkp_i6tdXZow@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAARzgwyKccWaPDSwsAg7bW7=F7DxAsf7Lw=TvqOkp_i6tdXZow@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 03:40:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 11, 2020 at 09:35:42PM +0530, Ani Sinha wrote:
> On Fri, Sep 11, 2020 at 9:22 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Sep 10, 2020 at 12:19:19AM +0530, Ani Sinha wrote:
> > > On Sep 10, 2020, 00:00 +0530, Ani Sinha <ani@anisinha.ca>, wrote:
> > >
> > >     On Sep 9, 2020, 23:20 +0530, Julia Suvorova <jusual@redhat.com>, wrote:
> > >
> > >         On Fri, Sep 4, 2020 at 6:10 PM Ani Sinha <ani@anisinha.ca> wrote:
> > >
> > >
> > >
> > >             Cold plugged bridges are not hot unpluggable, even when their
> > >             hotplug
> > >
> > >             property (acpi-pci-hotplug-with-bridge-support) is turned off.
> > >             Please see
> > >
> > >             the function acpi_pcihp_pc_no_hotplug() (thanks Julia). However,
> > >             with
> > >
> > >             the current implementaton, windows would try to hot-unplug a pci
> > >             bridge when
> > >
> > >             it's hotplug switch is off. This is regardless of whether there are
> > >             devices
> > >
> > >             attached to the bridge. This is because we add amls like _EJ0 etc
> > >             for the
> > >
> > >             pci slot where the bridge is cold plugged. We have a demo video
> > >             here:
> > >
> > >             https://youtu.be/pME2sjyQweo
> > >
> > >
> > >
> > >             In this fix, we identify a cold plugged bridge and for cold plugged
> > >             bridges,
> > >
> > >             we do not add the appropriate amls and acpi methods that are used
> > >             by the OS
> > >
> > >             to identify a hot-pluggable/unpluggable pci device. After this
> > >             change, Windows
> > >
> > >             does not show an option to eject the PCI bridge. A demo video is
> > >             here:
> > >
> > >             https://youtu.be/kbgej5B9Hgs
> > >
> > >
> > >
> > >             While at it, I have also updated a stale comment.
> > >
> > >
> > >
> > >             This change is tested with a Windows 2012R2 guest image and Windows
> > >             2019 server
> > >
> > >             guest image running on Ubuntu 18.04 host. This change is based off
> > >             of upstream
> > >
> > >             qemu master branch tag v5.1.0.
> > >
> > >
> > >
> > >             Signed-off-by: Ani Sinha <ani@anisinha.ca>
> > >
> > >
> > >
> > >         Reviewed-by: Julia Suvorova <jusual@redhat.com>
> > >
> > >
> > >
> > >         BTW, aren't all bridges handled in build_append_pci_bus_devices()
> > >         cold-plugged?
> > >
> > >
> > >
> > >     Yes they are.
> > >
> > >
> > > Maybe as an improvement we can simply identify a bridge instead of a cold
> > > plugged bridge. However let’s have that improvement as a separate patch on top
> > > of this. Also let’s see what Igor thinks.
> >
> > Well this changes acpi tables so I don't see how this will pass
> > the unit tests. Did you test this change?
> 
> There were no unit tests to cover this bridge flag. I have added the
> unit tests. It's the same one you have queued.


Hmm. somehow the new tests fail for me ...

> >
> >
> > >
> > >
> > >
> > >             ---
> > >
> > >             hw/i386/acpi-build.c | 12 ++++++------
> > >
> > >             1 file changed, 6 insertions(+), 6 deletions(-)
> > >
> > >
> > >
> > >             changelog:
> > >
> > >             v3: commit log updates providing more accurate information as
> > >             received from Julia.
> > >
> > >             v2: cosmetic commit log updates with patch testing information.
> > >
> > >             v1: initial patch.
> > >
> > >
> > >
> > >
> > >
> > >             diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > >
> > >             index b7bcbbbb2a..90b863f4ec 100644
> > >
> > >             --- a/hw/i386/acpi-build.c
> > >
> > >             +++ b/hw/i386/acpi-build.c
> > >
> > >             @@ -359,6 +359,7 @@ static void build_append_pci_bus_devices(Aml
> > >             *parent_scope, PCIBus *bus,
> > >
> > >             int slot = PCI_SLOT(i);
> > >
> > >             bool hotplug_enabled_dev;
> > >
> > >             bool bridge_in_acpi;
> > >
> > >             + bool cold_plugged_bridge;
> > >
> > >
> > >
> > >             if (!pdev) {
> > >
> > >             if (bsel) { /* add hotplug slots for non present devices */
> > >
> > >             @@ -380,15 +381,14 @@ static void build_append_pci_bus_devices(Aml
> > >             *parent_scope, PCIBus *bus,
> > >
> > >             pc = PCI_DEVICE_GET_CLASS(pdev);
> > >
> > >             dc = DEVICE_GET_CLASS(pdev);
> > >
> > >
> > >
> > >             - /* When hotplug for bridges is enabled, bridges are
> > >
> > >             - * described in ACPI separately (see build_pci_bus_end).
> > >
> > >             - * In this case they aren't themselves hot-pluggable.
> > >
> > >             + /*
> > >
> > >             + * Cold plugged bridges aren't themselves hot-pluggable.
> > >
> > >             * Hotplugged bridges *are* hot-pluggable.
> > >
> > >             */
> > >
> > >             - bridge_in_acpi = pc->is_bridge && pcihp_bridge_en &&
> > >
> > >             - !DEVICE(pdev)->hotplugged;
> > >
> > >             + cold_plugged_bridge = pc->is_bridge && !DEVICE(pdev)->hotplugged;
> > >
> > >             + bridge_in_acpi = cold_plugged_bridge && pcihp_bridge_en;
> > >
> > >
> > >
> > >             - hotplug_enabled_dev = bsel && dc->hotpluggable && !
> > >             bridge_in_acpi;
> > >
> > >             + hotplug_enabled_dev = bsel && dc->hotpluggable && !
> > >             cold_plugged_bridge;
> > >
> > >
> > >
> > >             if (pc->class_id == PCI_CLASS_BRIDGE_ISA) {
> > >
> > >             continue;
> > >
> > >             --
> > >
> > >             2.17.1
> > >
> > >
> > >
> > >
> > >
> >



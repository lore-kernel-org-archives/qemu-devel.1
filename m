Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C06C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:47:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C25B12078D
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="lAlpLYx4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C25B12078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHntI-0001fI-OB
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 08:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kHnlX-0005Bu-8q
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:39:27 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53924)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kHnlU-0001Ka-9w
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:39:26 -0400
Received: by mail-wm1-x341.google.com with SMTP id x23so10473926wmi.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 05:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VMiUI0IdDL9Hi13m4LQNY0pABp3pYSdAmMrfMn5DiPs=;
 b=lAlpLYx4RsluakyT3uUNh4Ppgtq045aHJrL/jjk1WBFU6R5OtYRXQPHQHqPmTyBmYU
 tdZLbKQ4HVJvezkEJmgwrf/fkoEQsDtpcOSN2ObScnSOEpYaVMXoL7W8HCDARbE+IPv3
 AIRufHmJ3QsSEVKT+XWxEl7Z5Krqz/OhVn2MdGvMi8TQ0rQpbf4KgK/LyrA5o396Jdi4
 yDstopP/il5NodfcFXhsxHkEc6b/ClRD6qKfu6F5OGG8uC7k/HXUYRCttEgsWHS1ptne
 hGV+zELuxelsQm4srHarXPVculY7EKmJa9xtCUU+xL1RiY7/MyUjV/DwNTS9Rlfdn6BB
 QiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VMiUI0IdDL9Hi13m4LQNY0pABp3pYSdAmMrfMn5DiPs=;
 b=M1cIEy7AK/MtglyLObpDH84faKXbvr9ugtaZsc+mtbqMKDe7sFUbYZScu03es8Je/j
 nmqOP6Iyn+TOb0hiNw4kArLxKToabP5CXgxr+GTmoZmPeVreF0GJoKMRld/i2ug1eajR
 Y4vz9bKmVnePq8oOETYuz5aX+66/nu6lFS4QUOVSFEvSOC+6rW0PJQy/WqfrQ+/XJy59
 adp0PkdK2Z8CYOXQy9pwXOcN6DrQZ0wEC9H28RvvByiXHGdaGNA0BSk4oV9f4f+2heWp
 U2+DyZvb9v6k9jQUi9eHL9b74Ni1/puEl7rxHGUerzaoUfsAJTIn69whYaJ/Vo1d4x3Z
 DSaw==
X-Gm-Message-State: AOAM531PIsLRNp0stlozHP01OCSJgpR0s2L2F/zGifATsZQPtZln9COl
 6NdGgkexb23+9cbHfgfb81Bdf1CMv9GNJffqyqlIuQ==
X-Google-Smtp-Source: ABdhPJxTQgF596RyF5uZ/BYTXDeoF5T9UxNl/sbVthT5Tq/J5PJqw7MBMGC6s+7twUed3Xj3TQUpEfqGYN9IKpqApgY=
X-Received: by 2002:a1c:e256:: with SMTP id z83mr15931518wmg.137.1600087162590; 
 Mon, 14 Sep 2020 05:39:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200911180755.28409-1-ani@anisinha.ca>
 <20200911180755.28409-5-ani@anisinha.ca>
 <20200914143646.073027f1@redhat.com>
In-Reply-To: <20200914143646.073027f1@redhat.com>
From: Ani Sinha <ani@anisinha.ca>
Date: Mon, 14 Sep 2020 18:09:11 +0530
Message-ID: <CAARzgwzbBTC7PFvE_P-K6qGbhqsbJwJiscTDCsYbJ6m=oyONXw@mail.gmail.com>
Subject: Re: [PATCH 5/9] i440fx/acpi: do not add hotplug related amls for cold
 plugged bridges
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=2a00:1450:4864:20::341;
 envelope-from=ani@anisinha.ca; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 14, 2020 at 6:07 PM Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Fri, 11 Sep 2020 23:37:51 +0530
> Ani Sinha <ani@anisinha.ca> wrote:
>
> > Cold plugged bridges are not hot unpluggable, even when their hotplug
> > property (acpi-pci-hotplug-with-bridge-support) is turned off. Please see
> > the function acpi_pcihp_pc_no_hotplug() (thanks Julia). However, with
> > the current implementaton, windows would try to hot-unplug a pci bridge when
> > it's hotplug switch is off. This is regardless of whether there are devices
> > attached to the bridge. This is because we add amls like _EJ0 etc for the
> > pci slot where the bridge is cold plugged. We have a demo video here:
> > https://youtu.be/pME2sjyQweo
> >
> > In this fix, we identify a cold plugged bridge and for cold plugged bridges,
> > we do not add the appropriate amls and acpi methods that are used by the OS
> > to identify a hot-pluggable/unpluggable pci device. After this change, Windows
> > does not show an option to eject the PCI bridge. A demo video is here:
> > https://youtu.be/kbgej5B9Hgs
> >
> > As a result of the patch, the following are the changes to the DSDT ACPI table:
> >
> > @@ -858,38 +858,33 @@
> >                      Return (Zero)
> >                  }
> >
> >                  Method (_S2D, 0, NotSerialized)  // _S2D: S2 Device State
> >                  {
> >                      Return (Zero)
> >                  }
> >
> >                  Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
> >                  {
> >                      Return (Zero)
> >                  }
> >              }
> >
> >              Device (S18)
> >              {
> > -                Name (_SUN, 0x03)  // _SUN: Slot User Number
> >                  Name (_ADR, 0x00030000)  // _ADR: Address
> > -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> > -                {
> > -                    PCEJ (BSEL, _SUN)
> > -                }
> >              }
> >
> >              Device (S20)
> >              {
> >                  Name (_SUN, 0x04)  // _SUN: Slot User Number
> >                  Name (_ADR, 0x00040000)  // _ADR: Address
> >                  Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> >                  {
> >                      PCEJ (BSEL, _SUN)
> >                  }
> >              }
> >
> >              Device (S28)
> >              {
> >                  Name (_SUN, 0x05)  // _SUN: Slot User Number
> >                  Name (_ADR, 0x00050000)  // _ADR: Address
> > @@ -1148,37 +1143,32 @@
> >                      PCEJ (BSEL, _SUN)
> >                  }
> >              }
> >
> >              Device (SF8)
> >              {
> >                  Name (_SUN, 0x1F)  // _SUN: Slot User Number
> >                  Name (_ADR, 0x001F0000)  // _ADR: Address
> >                  Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> >                  {
> >                      PCEJ (BSEL, _SUN)
> >                  }
> >              }
> >
> >              Method (DVNT, 2, NotSerialized)
> >              {
> > -                If ((Arg0 & 0x08))
> > -                {
> > -                    Notify (S18, Arg1)
> > -                }
> > -
> >                  If ((Arg0 & 0x10))
> >                  {
> >                      Notify (S20, Arg1)
> >                  }
> >
> >                  If ((Arg0 & 0x20))
> >                  {
> >                      Notify (S28, Arg1)
> >                  }
> >
> >                  If ((Arg0 & 0x40))
> >                  {
> >                      Notify (S30, Arg1)
> >                  }
> >
> >                  If ((Arg0 & 0x80))
> >
> > While at it, I have also updated a stale comment.
> >
> > This change is tested with a Windows 2012R2 guest image and Windows 2019 server
> > guest image running on Ubuntu 18.04 host. This change is based off of upstream
> > qemu master branch tag v5.1.0.
> >
> > Signed-off-by: Ani Sinha <ani@anisinha.ca>
>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Julia Suvorova <jusual@redhat.com>

From the previous thread.

>
> > ---
> >  hw/i386/acpi-build.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index 7a5a8b3521..e079b686f5 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -359,6 +359,7 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
> >          int slot = PCI_SLOT(i);
> >          bool hotplug_enabled_dev;
> >          bool bridge_in_acpi;
> > +        bool cold_plugged_bridge;
> >
> >          if (!pdev) {
> >              if (bsel) { /* add hotplug slots for non present devices */
> > @@ -380,15 +381,14 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
> >          pc = PCI_DEVICE_GET_CLASS(pdev);
> >          dc = DEVICE_GET_CLASS(pdev);
> >
> > -        /* When hotplug for bridges is enabled, bridges are
> > -         * described in ACPI separately (see build_pci_bus_end).
> > -         * In this case they aren't themselves hot-pluggable.
> > +        /*
> > +         * Cold plugged bridges aren't themselves hot-pluggable.
> >           * Hotplugged bridges *are* hot-pluggable.
> >           */
> > -        bridge_in_acpi = pc->is_bridge && pcihp_bridge_en &&
> > -            !DEVICE(pdev)->hotplugged;
> > +        cold_plugged_bridge = pc->is_bridge && !DEVICE(pdev)->hotplugged;
> > +        bridge_in_acpi =  cold_plugged_bridge && pcihp_bridge_en;
> >
> > -        hotplug_enabled_dev = bsel && dc->hotpluggable && !bridge_in_acpi;
> > +        hotplug_enabled_dev = bsel && dc->hotpluggable && !cold_plugged_bridge;
> >
> >          if (pc->class_id == PCI_CLASS_BRIDGE_ISA) {
> >              continue;
>


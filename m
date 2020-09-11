Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCCAC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 16:18:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9829F20659
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 16:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="NYTY8uOT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9829F20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGlkp-0002lB-HP
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 12:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kGljy-0001ir-Ge
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 12:17:35 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43466)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kGljw-00073E-49
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 12:17:34 -0400
Received: by mail-wr1-x443.google.com with SMTP id k15so12029192wrn.10
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 09:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=uFhQ2KLKC8mlboeZe0/jA/JieS7Bzs4PAyRyK1+D7GI=;
 b=NYTY8uOTioZe9rFDq3993W/8cigUWtmzL/f/pKXnbVcDBvy5HSDADh5c6vbJ0rf2es
 qicG2xNNr9XmhMhm6nhh5gQ62JnOHjzRMtFlF0iyTL/5Gc8OTUMJKkrsemEU5O0Z+To4
 7Z+t/H7nWG5evKqOG0U/tNRWelxAYlniYje6WjLWcrTY4iywtRjlWgs0yS86g1Azttsy
 dNku90kMIk1JNRa9id7E3vdYvYODM+Cf0/+l33uKoi6pCiRFPWi3wj775mc7s+CFgHrQ
 6Fm5KmHvPNRvf7PhKN9EMciNRgLYrW6Qp23GOGCNVFTNxiwlIFevI416d6qMPtrXh6ko
 fd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=uFhQ2KLKC8mlboeZe0/jA/JieS7Bzs4PAyRyK1+D7GI=;
 b=R4a1KW/KD1BIdfT2j8+pip8QMUIwzay2l1o9bxUQdt7V6zjdNAzKy0xw5AYDRT8I90
 AUHdH01AyXBBk2pwuJ/yTvGns2SkhC1t8dGgq0FrsQPqsP42x98wH+Z3jCBSQq5Ce2N6
 zbfAWyuLyl0bmF2imYe2fydfarQa2OLrBi/tMa9Tx7MAOpxSNKd5/qZ7iPNbQxyuk+SR
 KSF2N6YY2wnrXehCMRymP6Q/Sh0nD/ut1WuqQ1cajHRxzjG0J4n67j2tTYdFi8KetKPM
 SnbKbLX1hTl7YeUagFmuIRSkEU3c5fFNj9l8UjIlYQOiKEWg+tanwYwp0ZFhCvodV4Wq
 7F4g==
X-Gm-Message-State: AOAM533hQc6QnTOGZnlvq1LbvPYu32DAQ2IfRFoFBH/qGT7/JmDUZNUf
 t9dX3X1CmnSKNlZ8+au6yJ7lMteNRLbqabFOL9aRnQ==
X-Google-Smtp-Source: ABdhPJzma2OKstJDKfn43MtIWf83IjfD1eN8I3+YuyeVcyYKkj673Qp60MzLao6aabS3ifOyE2LzL7IWGGLCzV4M1JA=
X-Received: by 2002:adf:a48d:: with SMTP id g13mr2785823wrb.212.1599841050568; 
 Fri, 11 Sep 2020 09:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200904161000.12115-1-ani@anisinha.ca>
 <CAMDeoFVQWeWArPty2z4rNbdmS7O2X66SaONqiKzFqFpaKwuNDg@mail.gmail.com>
 <98b26cfa-3ff7-4302-9fc2-0e6672cfbd08@Spark>
 <a6c38469-356d-4629-be12-92129e1b1b96@Spark>
 <20200911115138-mutt-send-email-mst@kernel.org>
 <CAARzgwyKccWaPDSwsAg7bW7=F7DxAsf7Lw=TvqOkp_i6tdXZow@mail.gmail.com>
 <20200911120838-mutt-send-email-mst@kernel.org>
 <CAARzgwyg83QyuVCi303K6gKHYKqB1GE7ez89c825KjWF3w7J4g@mail.gmail.com>
In-Reply-To: <CAARzgwyg83QyuVCi303K6gKHYKqB1GE7ez89c825KjWF3w7J4g@mail.gmail.com>
From: Ani Sinha <ani@anisinha.ca>
Date: Fri, 11 Sep 2020 21:47:19 +0530
Message-ID: <CAARzgww8rwq8KajRhCo7SEDRnADJ5s=kgacf89BfzowUrk1e-A@mail.gmail.com>
Subject: Re: [PATCH v3] i440fx/acpi: do not add hotplug related amls for cold
 plugged bridges
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::443;
 envelope-from=ani@anisinha.ca; helo=mail-wr1-x443.google.com
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 11, 2020 at 9:45 PM Ani Sinha <ani@anisinha.ca> wrote:
>
> On Fri, Sep 11, 2020 at 9:39 PM Michael S. Tsirkin <mst@redhat.com> wrote=
:
> >
> > On Fri, Sep 11, 2020 at 09:35:42PM +0530, Ani Sinha wrote:
> > > On Fri, Sep 11, 2020 at 9:22 PM Michael S. Tsirkin <mst@redhat.com> w=
rote:
> > > >
> > > > On Thu, Sep 10, 2020 at 12:19:19AM +0530, Ani Sinha wrote:
> > > > > On Sep 10, 2020, 00:00 +0530, Ani Sinha <ani@anisinha.ca>, wrote:
> > > > >
> > > > >     On Sep 9, 2020, 23:20 +0530, Julia Suvorova <jusual@redhat.co=
m>, wrote:
> > > > >
> > > > >         On Fri, Sep 4, 2020 at 6:10 PM Ani Sinha <ani@anisinha.ca=
> wrote:
> > > > >
> > > > >
> > > > >
> > > > >             Cold plugged bridges are not hot unpluggable, even wh=
en their
> > > > >             hotplug
> > > > >
> > > > >             property (acpi-pci-hotplug-with-bridge-support) is tu=
rned off.
> > > > >             Please see
> > > > >
> > > > >             the function acpi_pcihp_pc_no_hotplug() (thanks Julia=
). However,
> > > > >             with
> > > > >
> > > > >             the current implementaton, windows would try to hot-u=
nplug a pci
> > > > >             bridge when
> > > > >
> > > > >             it's hotplug switch is off. This is regardless of whe=
ther there are
> > > > >             devices
> > > > >
> > > > >             attached to the bridge. This is because we add amls l=
ike _EJ0 etc
> > > > >             for the
> > > > >
> > > > >             pci slot where the bridge is cold plugged. We have a =
demo video
> > > > >             here:
> > > > >
> > > > >             https://youtu.be/pME2sjyQweo
> > > > >
> > > > >
> > > > >
> > > > >             In this fix, we identify a cold plugged bridge and fo=
r cold plugged
> > > > >             bridges,
> > > > >
> > > > >             we do not add the appropriate amls and acpi methods t=
hat are used
> > > > >             by the OS
> > > > >
> > > > >             to identify a hot-pluggable/unpluggable pci device. A=
fter this
> > > > >             change, Windows
> > > > >
> > > > >             does not show an option to eject the PCI bridge. A de=
mo video is
> > > > >             here:
> > > > >
> > > > >             https://youtu.be/kbgej5B9Hgs
> > > > >
> > > > >
> > > > >
> > > > >             While at it, I have also updated a stale comment.
> > > > >
> > > > >
> > > > >
> > > > >             This change is tested with a Windows 2012R2 guest ima=
ge and Windows
> > > > >             2019 server
> > > > >
> > > > >             guest image running on Ubuntu 18.04 host. This change=
 is based off
> > > > >             of upstream
> > > > >
> > > > >             qemu master branch tag v5.1.0.
> > > > >
> > > > >
> > > > >
> > > > >             Signed-off-by: Ani Sinha <ani@anisinha.ca>
> > > > >
> > > > >
> > > > >
> > > > >         Reviewed-by: Julia Suvorova <jusual@redhat.com>
> > > > >
> > > > >
> > > > >
> > > > >         BTW, aren't all bridges handled in build_append_pci_bus_d=
evices()
> > > > >         cold-plugged?
> > > > >
> > > > >
> > > > >
> > > > >     Yes they are.
> > > > >
> > > > >
> > > > > Maybe as an improvement we can simply identify a bridge instead o=
f a cold
> > > > > plugged bridge. However let=E2=80=99s have that improvement as a =
separate patch on top
> > > > > of this. Also let=E2=80=99s see what Igor thinks.
> > > >
> > > > Well this changes acpi tables so I don't see how this will pass
> > > > the unit tests. Did you test this change?
> > >
> > > There were no unit tests to cover this bridge flag. I have added the
> > > unit tests. It's the same one you have queued.
> >
> >
> > Hmm. somehow the new tests fail for me ...
>
> Maybe you need to pull this change out, make sure the tests passes and
> then apply it again:
>
> commit b26b2241baefc51fe2069b83cea9cfa654e75a43 (HEAD -> v5.1.0)
> Author: Ani Sinha <ani@anisinha.ca>
> Date:   Tue Sep 1 15:19:22 2020 +0530
>
>     piix4: don't reserve hw resources when hotplug is off globally
>
>     When acpi hotplug is turned off for both root pci bus as well as for =
pci
>     bridges, we should not generate the related amls for DSDT table or
> initialize
>     related hw ports or reserve hw resources. This change makes sure all =
those
>     operations are turned off in the case acpi pci hotplug is off globall=
y.
>
>     Signed-off-by: Ani Sinha <ani@anisinha.ca>

For this patch, I have not sent any updated unit tests.

>
>
> >
> > > >
> > > >
> > > > >
> > > > >
> > > > >
> > > > >             ---
> > > > >
> > > > >             hw/i386/acpi-build.c | 12 ++++++------
> > > > >
> > > > >             1 file changed, 6 insertions(+), 6 deletions(-)
> > > > >
> > > > >
> > > > >
> > > > >             changelog:
> > > > >
> > > > >             v3: commit log updates providing more accurate inform=
ation as
> > > > >             received from Julia.
> > > > >
> > > > >             v2: cosmetic commit log updates with patch testing in=
formation.
> > > > >
> > > > >             v1: initial patch.
> > > > >
> > > > >
> > > > >
> > > > >
> > > > >
> > > > >             diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-buil=
d.c
> > > > >
> > > > >             index b7bcbbbb2a..90b863f4ec 100644
> > > > >
> > > > >             --- a/hw/i386/acpi-build.c
> > > > >
> > > > >             +++ b/hw/i386/acpi-build.c
> > > > >
> > > > >             @@ -359,6 +359,7 @@ static void build_append_pci_bus_=
devices(Aml
> > > > >             *parent_scope, PCIBus *bus,
> > > > >
> > > > >             int slot =3D PCI_SLOT(i);
> > > > >
> > > > >             bool hotplug_enabled_dev;
> > > > >
> > > > >             bool bridge_in_acpi;
> > > > >
> > > > >             + bool cold_plugged_bridge;
> > > > >
> > > > >
> > > > >
> > > > >             if (!pdev) {
> > > > >
> > > > >             if (bsel) { /* add hotplug slots for non present devi=
ces */
> > > > >
> > > > >             @@ -380,15 +381,14 @@ static void build_append_pci_bu=
s_devices(Aml
> > > > >             *parent_scope, PCIBus *bus,
> > > > >
> > > > >             pc =3D PCI_DEVICE_GET_CLASS(pdev);
> > > > >
> > > > >             dc =3D DEVICE_GET_CLASS(pdev);
> > > > >
> > > > >
> > > > >
> > > > >             - /* When hotplug for bridges is enabled, bridges are
> > > > >
> > > > >             - * described in ACPI separately (see build_pci_bus_e=
nd).
> > > > >
> > > > >             - * In this case they aren't themselves hot-pluggable=
.
> > > > >
> > > > >             + /*
> > > > >
> > > > >             + * Cold plugged bridges aren't themselves hot-plugga=
ble.
> > > > >
> > > > >             * Hotplugged bridges *are* hot-pluggable.
> > > > >
> > > > >             */
> > > > >
> > > > >             - bridge_in_acpi =3D pc->is_bridge && pcihp_bridge_en=
 &&
> > > > >
> > > > >             - !DEVICE(pdev)->hotplugged;
> > > > >
> > > > >             + cold_plugged_bridge =3D pc->is_bridge && !DEVICE(pd=
ev)->hotplugged;
> > > > >
> > > > >             + bridge_in_acpi =3D cold_plugged_bridge && pcihp_bri=
dge_en;
> > > > >
> > > > >
> > > > >
> > > > >             - hotplug_enabled_dev =3D bsel && dc->hotpluggable &&=
 !
> > > > >             bridge_in_acpi;
> > > > >
> > > > >             + hotplug_enabled_dev =3D bsel && dc->hotpluggable &&=
 !
> > > > >             cold_plugged_bridge;
> > > > >
> > > > >
> > > > >
> > > > >             if (pc->class_id =3D=3D PCI_CLASS_BRIDGE_ISA) {
> > > > >
> > > > >             continue;
> > > > >
> > > > >             --
> > > > >
> > > > >             2.17.1
> > > > >
> > > > >
> > > > >
> > > > >
> > > > >
> > > >
> >


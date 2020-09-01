Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F169AC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:05:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B82D8206EF
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="RjGOrLug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B82D8206EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD52X-0000kq-T8
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 08:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kD51y-0000Ea-He
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 08:04:54 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43070)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kD51v-0004XV-Ql
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 08:04:54 -0400
Received: by mail-wr1-x441.google.com with SMTP id k15so1220528wrn.10
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 05:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=L/LjdGhIGGcl8WBr9RWbbswS3n+uVGKwk6PLw/Q/wVA=;
 b=RjGOrLugKjvElCYVoRucYDwnSrBSfydomkLggSRf4sGFHDznU+touQoVQp6Jb81pk1
 GUSx5m7jvIHZJcJVCT7YFwDWOb/yPinN9G/th27aBucVUltBe9ym6NEdquNGtcDwfIvm
 M/HuHTiAohmbGT9ZthMhd7s7iWKEuifBJjXA3o96/wq2P+Ct4tKExuIt4KM1kElS7+ox
 tX43l/iMXJw4JaEdBAYaYWQsP3S4VNJ8yLXJ7noQkfKfqxChc1HhUwkLIeshJLtOo4k0
 1w9qVyNu8vgi2AqS6y12PjPcn3udrVjwDgrAhTBv9CkMQnLrbFMl8zKgyIJZGP0XVoMQ
 9gHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=L/LjdGhIGGcl8WBr9RWbbswS3n+uVGKwk6PLw/Q/wVA=;
 b=PcBBbJBxoaOkhPgQ6Kg9livS/8CZbc9/XHDwApJv5iNt/y8ZzYpNLUVt7ahXrmCW3z
 uCqOqSE24m7R+KBwe9rvKX+n2z6NyRvUReANT99X5RpaGiuBvX8vnpUcMnb0q7mGd04o
 ZXiZmReeC7eqnAEB9ljO/5JgyMx7ycSOwl1neN0Ux2VnzWdtEirBZ0WgNxTkRYemEs8T
 gegMEmzGY+h1UpQSAAapdcAW4U2lIz0N881tJ5OermTh9J8/ajT7k7DRHi7A8z5gkIq9
 z/BHZNIImhaSRicCa82PC3j8TAKrEKl6b5/EuvDvvGyeba7PZVoobxL7JGPn3Opb1I4l
 Ap8Q==
X-Gm-Message-State: AOAM53187023O02lHuYqeLqcaXZ/2lomLgk0UTyn8IfiZYy1+xqdWQ42
 kDPKZQKL1//8ZRDaV1lbJ4vfHO/SRe/j83ExrSRdxA==
X-Google-Smtp-Source: ABdhPJxSI7nFYcZPEKwfs52qTf9CdsnN8Hs5xVzPlyM/iCD/dxuCN6S+PFLzq/SXvWXIbJV0MHQHm6Wjh/M52g9vxDU=
X-Received: by 2002:adf:bb44:: with SMTP id x4mr1537333wrg.76.1598961889951;
 Tue, 01 Sep 2020 05:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200827133954.2118749-1-mst@redhat.com>
 <20200827133954.2118749-7-mst@redhat.com>
 <20200827194115.673f94de@imammedo-mac>
 <CAARzgwzLcu5iHrXNZrVbg2Yx27AvyYWrKqBZ0wK7CveQ_eKgsQ@mail.gmail.com>
 <20200828114907.42961cd3@redhat.com>
 <d67e8431-b23a-46ee-94f3-544c4476848e@Spark>
 <CAMDeoFXa2NPwCE3u-OVsBGQQWOY9yk_048iL8gieboGU5Hj7+w@mail.gmail.com>
 <CAARzgwx+61UKm7-Qhgwm-Da60BuYmMKUMC7vcscOQf3SihYvmg@mail.gmail.com>
In-Reply-To: <CAARzgwx+61UKm7-Qhgwm-Da60BuYmMKUMC7vcscOQf3SihYvmg@mail.gmail.com>
From: Ani Sinha <ani@anisinha.ca>
Date: Tue, 1 Sep 2020 17:34:37 +0530
Message-ID: <CAARzgwxY2-6XzAqHSdGVPCfdZgnjyqOt29cJg+EwdyU+uiJbMg@mail.gmail.com>
Subject: Re: [PULL 06/13] Introduce a new flag for i440fx to disable PCI
 hotplug on the root bus
To: Julia Suvorova <jusual@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=2a00:1450:4864:20::441;
 envelope-from=ani@anisinha.ca; helo=mail-wr1-x441.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 1, 2020 at 11:57 AM Ani Sinha <ani@anisinha.ca> wrote:
>
> On Fri, Aug 28, 2020 at 6:40 PM Julia Suvorova <jusual@redhat.com> wrote:
> >
> > On Fri, Aug 28, 2020 at 11:53 AM Ani Sinha <ani@anisinha.ca> wrote:
> > >
> > >
> > > Ani
> > > On Aug 28, 2020, 15:19 +0530, Igor Mammedov <imammedo@redhat.com>, wrote:
> > >
> > > On Thu, 27 Aug 2020 23:29:34 +0530
> > >
> > > Ani Sinha <ani@anisinha.ca> wrote:
> > >
> > >
> > > On Thu, Aug 27, 2020 at 11:11 PM Igor Mammedov <imammedo@redhat.com> wrote:
> > >
> > >
> > > On Thu, 27 Aug 2020 09:40:34 -0400
> > >
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >
> > >
> > > From: Ani Sinha <ani@anisinha.ca>
> > >
> > >
> > > We introduce a new global flag 'acpi-root-pci-hotplug' for i440fx with which
> > >
> > > we can turn on or off PCI device hotplug on the root bus. This flag can be
> > >
> > > used to prevent all PCI devices from getting hotplugged or unplugged from the
> > >
> > > root PCI bus.
> > >
> > > This feature is targetted mostly towards Windows VMs. It is useful in cases
> > >
> > > where some hypervisor admins want to deploy guest VMs in a way so that the
> > >
> > > users of the guest OSes are not able to hot-eject certain PCI devices from
> > >
> > > the Windows system tray. Laine has explained the use case here in detail:
> > >
> > > https://www.redhat.com/archives/libvir-list/2020-February/msg00110.html
> > >
> > >
> > > Julia has resolved this issue for PCIE buses with the following commit:
> > >
> > > 530a0963184e57e71a5b538 ("pcie_root_port: Add hotplug disabling option")
> > >
> > >
> > > This commit attempts to introduce similar behavior for PCI root buses used in
> > >
> > > i440fx machine types (although in this case, we do not have a per-slot
> > >
> > > capability to turn hotplug on or off).
> > >
> > >
> > > Usage:
> > >
> > > -global PIIX4_PM.acpi-root-pci-hotplug=off
> > >
> > >
> > > By default, this option is enabled which means that hotplug is turned on for
> > >
> > > the PCI root bus.
> > >
> > >
> > > The previously existing flag 'acpi-pci-hotplug-with-bridge-support' for PCI-PCI
> > >
> > > bridges remain as is and can be used along with this new flag to control PCI
> > >
> > > hotplug on PCI bridges.
> > >
> > >
> > > This change has been tested using a Windows 2012R2 server guest image and also
> > >
> > > with a Windows 2019 server guest image on a Ubuntu 18.04 host using the latest
> > >
> > > master qemu from upstream.
> > >
> > >
> > > Signed-off-by: Ani Sinha <ani@anisinha.ca>
> > >
> > > Message-Id: <20200821165403.26589-1-ani@anisinha.ca>
> > >
> > > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > >
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > >
> > >
> > >
> > > Tested-by: Igor Mammedov <imammedo@redhat.com>
> > >
> > > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > >
> > > A glitch in scripts?
> > >
> > > I didn't review nor tested this (v8) version
> > >
> > >
> > > oops! I am so eager to get this done and dusted :)
> > >
> > > it's merged now,
> > >
> > >
> > > Wait it merged without your review?
> >
> > Yeah, not only added into the pull request, but actually merged.
> >
> > >
> > > can you add a test case for it please?
> > >
> > >
> > > You can use test_acpi_piix4_tcg_bridge() as model.
> > >
> > > See header comment at the top of bios-tables-test.c
> > >
> > > for how to prepare and submit testcase.
> > >
> > >
> > > Will get on it.
> >
> > Also, while the whole approach seems good to me, it leaves the hotplug
> > registers initialized (see build_piix4_pci_hotplug()), even if both
> > root and bridges hotplug are disabled. Which you can exploit by
> > writing something like this to the io registers:
> >
> > outl 0xae10 0
> > outl 0xae08 your_slot
> >
> > And because of these quite interesting lines the device will be
> > successfully unplugged:
> >
> > static PCIBus *acpi_pcihp_find_hotplug_bus(AcpiPciHpState *s, int bsel)
> > {
> > ...
> >     /* Make bsel 0 eject root bus if bsel property is not set,
> >      * for compatibility with non acpi setups.
> >      * TODO: really needed?
> >      */
> >     if (!bsel && !find.bus) {
> >         find.bus = s->root;
> >     }
> >     return find.bus;
> > }
> >
>
> I have sent a patch to address this. Please review.
>
> > Could you please cover both issues in the follow-up patches?
>
> Also julia, looking at the code, should we also set pm->pcihp_io_len
> to 0 as well in case where bridge and pci bus 0 hotplugs are both
> disabled?

I have sent a RFC patch where I check if at least one of the two
options is ON in the conditional below. Seems the right thing to do
instead of setting the io_len to 0.

This is because I see:
>
>    /* reserve PCIHP resources */
>     if (pm->pcihp_io_len) {
>
> which we do not want to do if PCI hotplug is disabled altogether?
>
> >
> > Best regards, Julia Suvorova.
> >
> > >
> > >
> > >
> > > ---
> > >
> > > include/hw/acpi/pcihp.h | 2 +-
> > >
> > > hw/acpi/pcihp.c | 23 ++++++++++++++++++++++-
> > >
> > > hw/acpi/piix4.c | 5 ++++-
> > >
> > > 3 files changed, 27 insertions(+), 3 deletions(-)
> > >
> > >
> > > diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
> > >
> > > index 8bc4a4c01d..02f4665767 100644
> > >
> > > --- a/include/hw/acpi/pcihp.h
> > >
> > > +++ b/include/hw/acpi/pcihp.h
> > >
> > > @@ -67,7 +67,7 @@ void acpi_pcihp_device_unplug_request_cb(HotplugHandler *hotplug_dev,
> > >
> > > Error **errp);
> > >
> > >
> > > /* Called on reset */
> > >
> > > -void acpi_pcihp_reset(AcpiPciHpState *s);
> > >
> > > +void acpi_pcihp_reset(AcpiPciHpState *s, bool acpihp_root_off);
> > >
> > >
> > > extern const VMStateDescription vmstate_acpi_pcihp_pci_status;
> > >
> > >
> > > diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> > >
> > > index 9e31ab2da4..39b1f74442 100644
> > >
> > > --- a/hw/acpi/pcihp.c
> > >
> > > +++ b/hw/acpi/pcihp.c
> > >
> > > @@ -104,6 +104,24 @@ static void acpi_set_pci_info(void)
> > >
> > > }
> > >
> > > }
> > >
> > >
> > > +static void acpi_pcihp_disable_root_bus(void)
> > >
> > > +{
> > >
> > > + static bool root_hp_disabled;
> > >
> > > + PCIBus *bus;
> > >
> > > +
> > >
> > > + if (root_hp_disabled) {
> > >
> > > + return;
> > >
> > > + }
> > >
> > > +
> > >
> > > + bus = find_i440fx();
> > >
> > > + if (bus) {
> > >
> > > + /* setting the hotplug handler to NULL makes the bus non-hotpluggable */
> > >
> > > + qbus_set_hotplug_handler(BUS(bus), NULL);
> > >
> > > + }
> > >
> > > + root_hp_disabled = true;
> > >
> > > + return;
> > >
> > > +}
> > >
> > > +
> > >
> > > static void acpi_pcihp_test_hotplug_bus(PCIBus *bus, void *opaque)
> > >
> > > {
> > >
> > > AcpiPciHpFind *find = opaque;
> > >
> > > @@ -209,8 +227,11 @@ static void acpi_pcihp_update(AcpiPciHpState *s)
> > >
> > > }
> > >
> > > }
> > >
> > >
> > > -void acpi_pcihp_reset(AcpiPciHpState *s)
> > >
> > > +void acpi_pcihp_reset(AcpiPciHpState *s, bool acpihp_root_off)
> > >
> > > {
> > >
> > > + if (acpihp_root_off) {
> > >
> > > + acpi_pcihp_disable_root_bus();
> > >
> > > + }
> > >
> > > acpi_set_pci_info();
> > >
> > > acpi_pcihp_update(s);
> > >
> > > }
> > >
> > > diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> > >
> > > index 26bac4f16c..e6163bb6ce 100644
> > >
> > > --- a/hw/acpi/piix4.c
> > >
> > > +++ b/hw/acpi/piix4.c
> > >
> > > @@ -78,6 +78,7 @@ typedef struct PIIX4PMState {
> > >
> > >
> > > AcpiPciHpState acpi_pci_hotplug;
> > >
> > > bool use_acpi_hotplug_bridge;
> > >
> > > + bool use_acpi_root_pci_hotplug;
> > >
> > >
> > > uint8_t disable_s3;
> > >
> > > uint8_t disable_s4;
> > >
> > > @@ -324,7 +325,7 @@ static void piix4_pm_reset(DeviceState *dev)
> > >
> > > pci_conf[0x5B] = 0x02;
> > >
> > > }
> > >
> > > pm_io_space_update(s);
> > >
> > > - acpi_pcihp_reset(&s->acpi_pci_hotplug);
> > >
> > > + acpi_pcihp_reset(&s->acpi_pci_hotplug, !s->use_acpi_root_pci_hotplug);
> > >
> > > }
> > >
> > >
> > > static void piix4_pm_powerdown_req(Notifier *n, void *opaque)
> > >
> > > @@ -635,6 +636,8 @@ static Property piix4_pm_properties[] = {
> > >
> > > DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_VAL, PIIX4PMState, s4_val, 2),
> > >
> > > DEFINE_PROP_BOOL("acpi-pci-hotplug-with-bridge-support", PIIX4PMState,
> > >
> > > use_acpi_hotplug_bridge, true),
> > >
> > > + DEFINE_PROP_BOOL("acpi-root-pci-hotplug", PIIX4PMState,
> > >
> > > + use_acpi_root_pci_hotplug, true),
> > >
> > > DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4PMState,
> > >
> > > acpi_memory_hotplug.is_enabled, true),
> > >
> > > DEFINE_PROP_END_OF_LIST(),
> > >
> > >
> > >
> > >
> >


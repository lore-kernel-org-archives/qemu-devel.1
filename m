Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FFEC433E6
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 10:03:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4589A20714
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 10:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="j6rStCYn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4589A20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCKBo-0000yj-Gy
	for qemu-devel@archiver.kernel.org; Sun, 30 Aug 2020 06:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kCKBB-0000T1-3e
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 06:03:17 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55283)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kCKB4-0004gR-Nm
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 06:03:16 -0400
Received: by mail-wm1-x341.google.com with SMTP id s13so2804760wmh.4
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2020 03:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=t1vBJ1qLIqxSp0AoNhmDZG+DDphJfRbLjlNI0nqOfvQ=;
 b=j6rStCYnjme3pZzQyk5zS602CChGRLnDbm76zm89yu4s0YVx7aUNn6pV8Oeb1l75G0
 VuHoBozslctQ9mnwhFFN8DiM7GoQMv5BtZKMio9REjmM8B2fh0AQmWCG8zEdQp7mOHWn
 efsLdFU+4hfOyEtssFek/eNVAWJUWwwpHxgmw9maw8JNVUcQYaU7dXOfyLtc1nxY02yW
 Denh5ty2mzIzVCAEjacaDHmCVy6SD77x7bKgz6wyloD5+709nMJERNDJnb1f32JcN4nZ
 uTYqOMK9M6RjZqzYFTLhJr90N8rMquLFhDDPbS+5XVLoGOXoHs8H8EkotDjxR16/qpHe
 BLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=t1vBJ1qLIqxSp0AoNhmDZG+DDphJfRbLjlNI0nqOfvQ=;
 b=dcn2SnIkNWMo9W0cUaEmINzp+lxE0mwuRJ+En2eBF8/Et37UF8qIDiceizJ2WTbp1O
 ebL59jpNk6jMg8omObWP1sGfiyuyFWSIii/zAByo0XuBBw8WvGCcSOVoCuxeiJ7LQUZD
 BgohYwtpe2rUBMzil2Dmg7tR8taub5bXk+6diXqB7KfGSQMtUiDIE65YCYFguP7dbpLS
 dsoImdhiFTGVbKGkJwLb/Um08SicFGDzE7Q8GvRqxSD2IzysecWSq7xSV4OZEbDIJ3kk
 hoVD6xn0iipwKhsiS+52nwuRn6vZIY/2PEE6lHkpw75oVQNmO14NDEkxlCkokUrR82K+
 nq6A==
X-Gm-Message-State: AOAM530rwBGrn+2LAZDs1R4pcBoZXSh3YcoAhZZ8upxNGGuGv1CVncsD
 A8VssRPpafRL5jHu2adqdlkNrDKk9H79bfv6jfwEag==
X-Google-Smtp-Source: ABdhPJx77wmO7MCTVToHfq+wf7LLdonJX/Z3lREvR5euD4MJhNw1v3jLEoxMd8HjQghR3Ax8CKVm4Fq4ZQkQ3h4suOk=
X-Received: by 2002:a1c:b407:: with SMTP id d7mr6221167wmf.59.1598781788442;
 Sun, 30 Aug 2020 03:03:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200827133954.2118749-1-mst@redhat.com>
 <20200827133954.2118749-7-mst@redhat.com>
 <20200827194115.673f94de@imammedo-mac>
 <CAARzgwzLcu5iHrXNZrVbg2Yx27AvyYWrKqBZ0wK7CveQ_eKgsQ@mail.gmail.com>
 <20200828114907.42961cd3@redhat.com>
In-Reply-To: <20200828114907.42961cd3@redhat.com>
From: Ani Sinha <ani@anisinha.ca>
Date: Sun, 30 Aug 2020 15:32:57 +0530
Message-ID: <CAARzgwxcXOURzwzQhkxaAiKnT_eZHhKX10Q1v5C9MGY5HP11Dw@mail.gmail.com>
Subject: Re: [PULL 06/13] Introduce a new flag for i440fx to disable PCI
 hotplug on the root bus
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 28, 2020 at 3:19 PM Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Thu, 27 Aug 2020 23:29:34 +0530
> Ani Sinha <ani@anisinha.ca> wrote:
>
> > On Thu, Aug 27, 2020 at 11:11 PM Igor Mammedov <imammedo@redhat.com> wrote:
> > >
> > > On Thu, 27 Aug 2020 09:40:34 -0400
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >
> > > > From: Ani Sinha <ani@anisinha.ca>
> > > >
> > > > We introduce a new global flag 'acpi-root-pci-hotplug' for i440fx with which
> > > > we can turn on or off PCI device hotplug on the root bus. This flag can be
> > > > used to prevent all PCI devices from getting hotplugged or unplugged from the
> > > > root PCI bus.
> > > > This feature is targetted mostly towards Windows VMs. It is useful in cases
> > > > where some hypervisor admins want to deploy guest VMs in a way so that the
> > > > users of the guest OSes are not able to hot-eject certain PCI devices from
> > > > the Windows system tray. Laine has explained the use case here in detail:
> > > > https://www.redhat.com/archives/libvir-list/2020-February/msg00110.html
> > > >
> > > > Julia has resolved this issue for PCIE buses with the following commit:
> > > > 530a0963184e57e71a5b538 ("pcie_root_port: Add hotplug disabling option")
> > > >
> > > > This commit attempts to introduce similar behavior for PCI root buses used in
> > > > i440fx machine types (although in this case, we do not have a per-slot
> > > > capability to turn hotplug on or off).
> > > >
> > > > Usage:
> > > >    -global PIIX4_PM.acpi-root-pci-hotplug=off
> > > >
> > > > By default, this option is enabled which means that hotplug is turned on for
> > > > the PCI root bus.
> > > >
> > > > The previously existing flag 'acpi-pci-hotplug-with-bridge-support' for PCI-PCI
> > > > bridges remain as is and can be used along with this new flag to control PCI
> > > > hotplug on PCI bridges.
> > > >
> > > > This change has been tested using a Windows 2012R2 server guest image and also
> > > > with a Windows 2019 server guest image on a Ubuntu 18.04 host using the latest
> > > > master qemu from upstream.
> > > >
> > > > Signed-off-by: Ani Sinha <ani@anisinha.ca>
> > > > Message-Id: <20200821165403.26589-1-ani@anisinha.ca>
> > > > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > >
> > >
> > > > Tested-by: Igor Mammedov <imammedo@redhat.com>
> > > > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > > A glitch in scripts?
> > > I didn't review nor tested this (v8) version
> >
> > oops! I am so eager to get this done and dusted :)
> it's merged now,
>
> can you add a test case for it please?

Yes just sent the unit test patch set.

>
> You can use test_acpi_piix4_tcg_bridge() as model.
> See header comment at the top of bios-tables-test.c
> for how to prepare and submit testcase.
>
> >
> > >
> > > > ---
> > > >  include/hw/acpi/pcihp.h |  2 +-
> > > >  hw/acpi/pcihp.c         | 23 ++++++++++++++++++++++-
> > > >  hw/acpi/piix4.c         |  5 ++++-
> > > >  3 files changed, 27 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
> > > > index 8bc4a4c01d..02f4665767 100644
> > > > --- a/include/hw/acpi/pcihp.h
> > > > +++ b/include/hw/acpi/pcihp.h
> > > > @@ -67,7 +67,7 @@ void acpi_pcihp_device_unplug_request_cb(HotplugHandler *hotplug_dev,
> > > >                                           Error **errp);
> > > >
> > > >  /* Called on reset */
> > > > -void acpi_pcihp_reset(AcpiPciHpState *s);
> > > > +void acpi_pcihp_reset(AcpiPciHpState *s, bool acpihp_root_off);
> > > >
> > > >  extern const VMStateDescription vmstate_acpi_pcihp_pci_status;
> > > >
> > > > diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> > > > index 9e31ab2da4..39b1f74442 100644
> > > > --- a/hw/acpi/pcihp.c
> > > > +++ b/hw/acpi/pcihp.c
> > > > @@ -104,6 +104,24 @@ static void acpi_set_pci_info(void)
> > > >      }
> > > >  }
> > > >
> > > > +static void acpi_pcihp_disable_root_bus(void)
> > > > +{
> > > > +    static bool root_hp_disabled;
> > > > +    PCIBus *bus;
> > > > +
> > > > +    if (root_hp_disabled) {
> > > > +        return;
> > > > +    }
> > > > +
> > > > +    bus = find_i440fx();
> > > > +    if (bus) {
> > > > +        /* setting the hotplug handler to NULL makes the bus non-hotpluggable */
> > > > +        qbus_set_hotplug_handler(BUS(bus), NULL);
> > > > +    }
> > > > +    root_hp_disabled = true;
> > > > +    return;
> > > > +}
> > > > +
> > > >  static void acpi_pcihp_test_hotplug_bus(PCIBus *bus, void *opaque)
> > > >  {
> > > >      AcpiPciHpFind *find = opaque;
> > > > @@ -209,8 +227,11 @@ static void acpi_pcihp_update(AcpiPciHpState *s)
> > > >      }
> > > >  }
> > > >
> > > > -void acpi_pcihp_reset(AcpiPciHpState *s)
> > > > +void acpi_pcihp_reset(AcpiPciHpState *s, bool acpihp_root_off)
> > > >  {
> > > > +    if (acpihp_root_off) {
> > > > +        acpi_pcihp_disable_root_bus();
> > > > +    }
> > > >      acpi_set_pci_info();
> > > >      acpi_pcihp_update(s);
> > > >  }
> > > > diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> > > > index 26bac4f16c..e6163bb6ce 100644
> > > > --- a/hw/acpi/piix4.c
> > > > +++ b/hw/acpi/piix4.c
> > > > @@ -78,6 +78,7 @@ typedef struct PIIX4PMState {
> > > >
> > > >      AcpiPciHpState acpi_pci_hotplug;
> > > >      bool use_acpi_hotplug_bridge;
> > > > +    bool use_acpi_root_pci_hotplug;
> > > >
> > > >      uint8_t disable_s3;
> > > >      uint8_t disable_s4;
> > > > @@ -324,7 +325,7 @@ static void piix4_pm_reset(DeviceState *dev)
> > > >          pci_conf[0x5B] = 0x02;
> > > >      }
> > > >      pm_io_space_update(s);
> > > > -    acpi_pcihp_reset(&s->acpi_pci_hotplug);
> > > > +    acpi_pcihp_reset(&s->acpi_pci_hotplug, !s->use_acpi_root_pci_hotplug);
> > > >  }
> > > >
> > > >  static void piix4_pm_powerdown_req(Notifier *n, void *opaque)
> > > > @@ -635,6 +636,8 @@ static Property piix4_pm_properties[] = {
> > > >      DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_VAL, PIIX4PMState, s4_val, 2),
> > > >      DEFINE_PROP_BOOL("acpi-pci-hotplug-with-bridge-support", PIIX4PMState,
> > > >                       use_acpi_hotplug_bridge, true),
> > > > +    DEFINE_PROP_BOOL("acpi-root-pci-hotplug", PIIX4PMState,
> > > > +                     use_acpi_root_pci_hotplug, true),
> > > >      DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4PMState,
> > > >                       acpi_memory_hotplug.is_enabled, true),
> > > >      DEFINE_PROP_END_OF_LIST(),
> > >
> >
>


Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7FAC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 14:04:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A3512075E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 14:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="nIZh0SFN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A3512075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAw2K-0002te-Fr
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 10:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kAw1H-0001dh-NQ
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 10:03:20 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34319)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kAw1C-0001q2-B9
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 10:03:19 -0400
Received: by mail-pg1-x541.google.com with SMTP id i10so1088566pgk.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 07:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:message-id:in-reply-to:references:subject
 :mime-version; bh=htXWgTZwcmAQX6fDvFG4pQlXh+kxBRLp0HbaFaGWD5s=;
 b=nIZh0SFNGW/gmjEEheKigR1qGu8VB/GgmQfVAdcWlq/KaxvhnIRBwywN0ursV/Ru0E
 bB4jeFIvfoGuLDy0vJJM8hFn9BvEkAPSm099FX3kEsHAxbEQFatcLZkuOSBpFn9WZ0kM
 pWEgl4okTAAZjj5jb/KuI47eP2R5Eu3BG6GQ/tK9iaD0SLSaWIVjNA04sLkenWT0ePQr
 MN+bivgnrcgIRAsUqnxfBf5IzQ9MZ0c/yW48JtNURRq0UWIPnwnMmoJbQNRRPSigjCgt
 ZE8mwoaiciCPffqpjAOgl1preFnQRZRAOUPfATvsM9YiVnoUM1fxjkpZ2zHu05cRUVi+
 gKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
 :references:subject:mime-version;
 bh=htXWgTZwcmAQX6fDvFG4pQlXh+kxBRLp0HbaFaGWD5s=;
 b=lN1iVeCDep3PaY9ZFz9+9vZxZmu9ZjQ62UKU+5cuvKYNMnNHYtikebIcj/78H0FPIf
 8tIRTTxiUFU5R8ynrSa1lRGITUOUGEti/J3dfVroOfWRNOlavzb31+UlZYkS0V4tcIys
 2N6uhFa6xQCTj28lZZSAD3QXe5SkqDHMmrWC1wINzL20TyJoCe1lBmfZHg50zIFAmntf
 eK6jzzY9Q1A2y5T9Dxp9GYvMhFkgOakVyCVluKOcWK+A3SLsAwbpr6F7WOcJm0gKOXD0
 R3dIronpCbjsXDeLLw8poUYNSbr2hk3zvIwB4xTfPo/o4j1bN9wXiUt8Ms0AnwqVdjFM
 JrDw==
X-Gm-Message-State: AOAM531z0JGms37ZnFJ1tZzb6PsH5jIgvSZg0DLDczUffSeYdrk68Vvt
 fDqdYDgy9isNA7tOArGpt+E/EQ==
X-Google-Smtp-Source: ABdhPJwaMJKtFPXcah224kkKIIPuPblsI753P2H1+4NW5iZEykEE04IRQLsxJXzNKkU2ZP+mb+Cdqg==
X-Received: by 2002:a63:f813:: with SMTP id n19mr10489917pgh.34.1598450592085; 
 Wed, 26 Aug 2020 07:03:12 -0700 (PDT)
Received: from [192.168.1.3] ([115.96.152.215])
 by smtp.gmail.com with ESMTPSA id t33sm2416118pga.72.2020.08.26.07.03.07
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Aug 2020 07:03:11 -0700 (PDT)
Date: Wed, 26 Aug 2020 19:32:52 +0530
From: Ani Sinha <ani@anisinha.ca>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <21506f68-cb7f-49a7-b949-9fc92c69578f@Spark>
In-Reply-To: <20200826140303.2514a68f@redhat.com>
References: <20200821165403.26589-1-ani@anisinha.ca>
 <CAARzgwwrc0ioTsUibT1J2EiiW3QdOgFxyd4S5TtaFzPV+-JeBQ@mail.gmail.com>
 <20200826140303.2514a68f@redhat.com>
Subject: Re: [PATCH V8] Introduce a new flag for i440fx to disable PCI
 hotplug on the root bus
X-Readdle-Message-ID: 21506f68-cb7f-49a7-b949-9fc92c69578f@Spark
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="5f466b99_19495cff_239"
Received-SPF: none client-ip=2607:f8b0:4864:20::541;
 envelope-from=ani@anisinha.ca; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--5f466b99_19495cff_239
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Ani
On Aug 26, 2020, 17:33 +0530, Igor Mammedov <imammedo@redhat.com>, wrote:
> On Mon, 24 Aug 2020 20:32:04 +0530
> Ani Sinha <ani@anisinha.ca> wrote:
>
> > Reminder to kindly review this patch.
>
> I'm a bit occupied elsewhere right now,
> will look into it later when more urgent tasks are dealt with.
>
> Maybe Julia can help with review (CCed)
> (she should be familiar with the pci hotplug code atm)

Thanks Julia upfront. Also may be you could also perform your own independent testing of the change?

>
>
> > On Fri, Aug 21, 2020 at 10:24 PM Ani Sinha <ani@anisinha.ca> wrote:
> >
> > > We introduce a new global flag 'acpi-root-pci-hotplug' for i440fx with
> > > which
> > >
> > > we can turn on or off PCI device hotplug on the root bus. This flag can be
> > >
> > > used to prevent all PCI devices from getting hotplugged or unplugged from
> > > the
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
> > >
> > > Julia has resolved this issue for PCIE buses with the following commit:
> > >
> > > 530a0963184e57e71a5b538 ("pcie_root_port: Add hotplug disabling option")
> > >
> > >
> > >
> > > This commit attempts to introduce similar behavior for PCI root buses used
> > > in
> > >
> > > i440fx machine types (although in this case, we do not have a per-slot
> > >
> > > capability to turn hotplug on or off).
> > >
> > >
> > >
> > > Usage:
> > >
> > > -global PIIX4_PM.acpi-root-pci-hotplug=off
> > >
> > >
> > >
> > > By default, this option is enabled which means that hotplug is turned on
> > > for
> > >
> > > the PCI root bus.
> > >
> > >
> > >
> > > The previously existing flag 'acpi-pci-hotplug-with-bridge-support' for
> > > PCI-PCI
> > >
> > > bridges remain as is and can be used along with this new flag to control
> > > PCI
> > >
> > > hotplug on PCI bridges.
> > >
> > >
> > >
> > > This change has been tested using a Windows 2012R2 server guest image and
> > > also
> > >
> > > with a Windows 2019 server guest image on a Ubuntu 18.04 host using the
> > > latest
> > >
> > > master qemu from upstream.
> > >
> > >
> > >
> > > Signed-off-by: Ani Sinha <ani@anisinha.ca>
> > >
> > > ---
> > >
> > > hw/acpi/pcihp.c | 23 ++++++++++++++++++++++-
> > >
> > > hw/acpi/piix4.c | 5 ++++-
> > >
> > > include/hw/acpi/pcihp.h | 2 +-
> > >
> > > 3 files changed, 27 insertions(+), 3 deletions(-)
> > >
> > >
> > >
> > > Change Log:
> > >
> > > V7..V8: Cosmetic. Removed extra new line in the patch. Rebased to latest
> > >
> > > upstream master and retested with both versions of Windows.
> > >
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
> > > + /* setting the hotplug handler to NULL makes the bus
> > > non-hotpluggable */
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
> > >
> > > AcpiPciHpState acpi_pci_hotplug;
> > >
> > > bool use_acpi_hotplug_bridge;
> > >
> > > + bool use_acpi_root_pci_hotplug;
> > >
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
> > > diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
> > >
> > > index 8bc4a4c01d..02f4665767 100644
> > >
> > > --- a/include/hw/acpi/pcihp.h
> > >
> > > +++ b/include/hw/acpi/pcihp.h
> > >
> > > @@ -67,7 +67,7 @@ void acpi_pcihp_device_unplug_request_cb(HotplugHandler
> > > *hotplug_dev,
> > >
> > > Error **errp);
> > >
> > >
> > >
> > > /* Called on reset */
> > >
> > > -void acpi_pcihp_reset(AcpiPciHpState *s);
> > >
> > > +void acpi_pcihp_reset(AcpiPciHpState *s, bool acpihp_root_off);
> > >
> > >
> > >
> > > extern const VMStateDescription vmstate_acpi_pcihp_pci_status;
> > >
> > >
> > >
> > > --
> > >
> > > 2.17.1
> > >
> > >
> > >
> > >
>

--5f466b99_19495cff_239
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html xmlns=3D=22http://www.w3.org/1999/xhtml=22>
<head>
<title></title>
</head>
<body>
<div name=3D=22messageSignatureSection=22><br />
Ani</div>
<div name=3D=22messageReplySection=22>
<div dir=3D=22auto=22>On Aug 26, 2020, 17:33 +0530, Igor Mammedov &lt;ima=
mmedo=40redhat.com&gt;, wrote:</div>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>On Mon, 24 Aug 2020 20:32:04 +05=
30</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>Ani Sinha &lt;ani=40anisinha.ca&=
gt; wrote:</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>Reminder to kindly review this p=
atch.</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>I'm a bit occupied elsewhere rig=
ht now,</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>will look into it later when mor=
e urgent tasks are dealt with.</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>Maybe Julia can help with review=
 (CCed)</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>(she should be familiar with the=
 pci hotplug code atm)</blockquote>
<div dir=3D=22auto=22><br />
Thanks Julia upfront. Also may be you could also perform your own indepen=
dent testing of the change=3F&=23160;<br />
<br /></div>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>On =46ri, Aug 21, 2020 at 10:24 =
PM Ani Sinha &lt;ani=40anisinha.ca&gt; wrote:</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>We introduce a new global flag '=
acpi-root-pci-hotplug' for i440fx with</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>which</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>we can turn on or off PCI device=
 hotplug on the root bus. This flag can be</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>used to prevent all PCI devices =
from getting hotplugged or unplugged from</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>the</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>root PCI bus.</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>This feature is targetted mostly=
 towards Windows VMs. It is useful in cases</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>where some hypervisor admins wan=
t to deploy guest VMs in a way so that the</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>users of the guest OSes are not =
able to hot-eject certain PCI devices from</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>the Windows system tray. Laine h=
as explained the use case here in detail:</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>https://www.redhat.com/archives/=
libvir-list/2020-=46ebruary/msg00110.html</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>Julia has resolved this issue fo=
r PCIE buses with the following commit:</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>530a0963184e57e71a5b538 (=22pcie=
=5Froot=5Fport: Add hotplug disabling option=22)</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>This commit attempts to introduc=
e similar behavior for PCI root buses used</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>in</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>i440fx machine types (although i=
n this case, we do not have a per-slot</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>capability to turn hotplug on or=
 off).</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>Usage:</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>-global PIIX4=5FPM.acpi-root-pci=
-hotplug=3Doff</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>By default, this option is enabl=
ed which means that hotplug is turned on</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>for</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>the PCI root bus.</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>The previously existing flag 'ac=
pi-pci-hotplug-with-bridge-support' for</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>PCI-PCI</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>bridges remain as is and can be =
used along with this new flag to control</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>PCI</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>hotplug on PCI bridges.</blockqu=
ote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>This change has been tested usin=
g a Windows 2012R2 server guest image and</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>also</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>with a Windows 2019 server guest=
 image on a Ubuntu 18.04 host using the</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>latest</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>master qemu from upstream.</bloc=
kquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>Signed-off-by: Ani Sinha &lt;ani=
=40anisinha.ca&gt;</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>---</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>hw/acpi/pcihp.c =7C 23 +++++++++=
+++++++++++++-</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>hw/acpi/piix4.c =7C 5 ++++-</blo=
ckquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>include/hw/acpi/pcihp.h =7C 2 +-=
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>3 files changed, 27 insertions(+=
), 3 deletions(-)</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>Change Log:</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>V7..V8: Cosmetic. Removed extra =
new line in the patch. Rebased to latest</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>upstream master and retested wit=
h both versions of Windows.</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>diff --git a/hw/acpi/pcihp.c b/h=
w/acpi/pcihp.c</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>index 9e31ab2da4..39b1f74442 100=
644</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>--- a/hw/acpi/pcihp.c</blockquot=
e>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+++ b/hw/acpi/pcihp.c</blockquot=
e>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=40=40 -104,6 +104,24 =40=40 sta=
tic void acpi=5Fset=5Fpci=5Finfo(void)</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=7D</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=7D</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+static void acpi=5Fpcihp=5Fdisa=
ble=5Froot=5Fbus(void)</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+=7B</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ static bool root=5Fhp=5Fdisabl=
ed;</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ PCIBus *bus;</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ if (root=5Fhp=5Fdisabled) =7B<=
/blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ return;</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ =7D</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ bus =3D find=5Fi440fx();</bloc=
kquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ if (bus) =7B</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ /* setting the hotplug handler=
 to NULL makes the bus</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>non-hotpluggable */</blockquote>=

</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ qbus=5Fset=5Fhotplug=5Fhandler=
(BUS(bus), NULL);</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ =7D</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ root=5Fhp=5Fdisabled =3D true;=
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ return;</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+=7D</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>static void acpi=5Fpcihp=5Ftest=5F=
hotplug=5Fbus(PCIBus *bus, void *opaque)</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=7B</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>AcpiPciHp=46ind *find =3D opaque=
;</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=40=40 -209,8 +227,11 =40=40 sta=
tic void acpi=5Fpcihp=5Fupdate(AcpiPciHpState *s)</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=7D</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=7D</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>-void acpi=5Fpcihp=5Freset(AcpiP=
ciHpState *s)</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+void acpi=5Fpcihp=5Freset(AcpiP=
ciHpState *s, bool acpihp=5Froot=5Foff)</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=7B</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ if (acpihp=5Froot=5Foff) =7B</=
blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ acpi=5Fpcihp=5Fdisable=5Froot=5F=
bus();</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ =7D</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>acpi=5Fset=5Fpci=5Finfo();</bloc=
kquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>acpi=5Fpcihp=5Fupdate(s);</block=
quote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=7D</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>diff --git a/hw/acpi/piix4.c b/h=
w/acpi/piix4.c</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>index 26bac4f16c..e6163bb6ce 100=
644</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>--- a/hw/acpi/piix4.c</blockquot=
e>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+++ b/hw/acpi/piix4.c</blockquot=
e>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=40=40 -78,6 +78,7 =40=40 typede=
f struct PIIX4PMState =7B</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>AcpiPciHpState acpi=5Fpci=5Fhotp=
lug;</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>bool use=5Facpi=5Fhotplug=5Fbrid=
ge;</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ bool use=5Facpi=5Froot=5Fpci=5F=
hotplug;</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>uint8=5Ft disable=5Fs3;</blockqu=
ote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>uint8=5Ft disable=5Fs4;</blockqu=
ote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=40=40 -324,7 +325,7 =40=40 stat=
ic void piix4=5Fpm=5Freset(DeviceState *dev)</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>pci=5Fconf=5B0x5B=5D =3D 0x02;</=
blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=7D</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>pm=5Fio=5Fspace=5Fupdate(s);</bl=
ockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>- acpi=5Fpcihp=5Freset(&amp;s-&g=
t;acpi=5Fpci=5Fhotplug);</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ acpi=5Fpcihp=5Freset(&amp;s-&g=
t;acpi=5Fpci=5Fhotplug, =21s-&gt;use=5Facpi=5Froot=5Fpci=5Fhotplug);</blo=
ckquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=7D</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>static void piix4=5Fpm=5Fpowerdo=
wn=5Freq(Notifier *n, void *opaque)</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=40=40 -635,6 +636,8 =40=40 stat=
ic Property piix4=5Fpm=5Fproperties=5B=5D =3D =7B</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>DE=46INE=5FPROP=5FUINT8(ACPI=5FP=
M=5FPROP=5FS4=5FVAL, PIIX4PMState, s4=5Fval, 2),</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>DE=46INE=5FPROP=5FBOOL(=22acpi-p=
ci-hotplug-with-bridge-support=22, PIIX4PMState,</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>use=5Facpi=5Fhotplug=5Fbridge, t=
rue),</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ DE=46INE=5FPROP=5FBOOL(=22acpi=
-root-pci-hotplug=22, PIIX4PMState,</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+ use=5Facpi=5Froot=5Fpci=5Fhotp=
lug, true),</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>DE=46INE=5FPROP=5FBOOL(=22memory=
-hotplug-support=22, PIIX4PMState,</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>acpi=5Fmemory=5Fhotplug.is=5Fena=
bled, true),</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>DE=46INE=5FPROP=5FEND=5FO=46=5FL=
IST(),</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>diff --git a/include/hw/acpi/pci=
hp.h b/include/hw/acpi/pcihp.h</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>index 8bc4a4c01d..02f4665767 100=
644</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>--- a/include/hw/acpi/pcihp.h</b=
lockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+++ b/include/hw/acpi/pcihp.h</b=
lockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=40=40 -67,7 +67,7 =40=40 void a=
cpi=5Fpcihp=5Fdevice=5Funplug=5Frequest=5Fcb(HotplugHandler</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>*hotplug=5Fdev,</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>Error **errp);</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>/* Called on reset */</blockquot=
e>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>-void acpi=5Fpcihp=5Freset(AcpiP=
ciHpState *s);</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>+void acpi=5Fpcihp=5Freset(AcpiP=
ciHpState *s, bool acpihp=5Froot=5Foff);</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>extern const VMStateDescription =
vmstate=5Facpi=5Fpcihp=5Fpci=5Fstatus;</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>--</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>2.17.1</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</div>
</body>
</html>

--5f466b99_19495cff_239--



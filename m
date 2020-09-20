Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3C0C43465
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 11:02:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6BD320796
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 11:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6BD320796
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJx7F-0000gW-Rg
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 07:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kJwxW-0002R2-UM; Sun, 20 Sep 2020 06:52:42 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:17535)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kJwxO-0002tS-Vh; Sun, 20 Sep 2020 06:52:42 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id DC84D74594E;
 Sun, 20 Sep 2020 12:52:23 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9675B745712; Sun, 20 Sep 2020 12:52:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 94DAF745702;
 Sun, 20 Sep 2020 12:52:23 +0200 (CEST)
Date: Sun, 20 Sep 2020 12:52:23 +0200 (CEST)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH 5/6] macio: don't reference serial_hd() directly within
 the device
In-Reply-To: <20200920082018.16135-6-mark.cave-ayland@ilande.co.uk>
Message-ID: <c16922ec-9bd1-b990-23a2-ddc73abaeea@eik.bme.hu>
References: <20200920082018.16135-1-mark.cave-ayland@ilande.co.uk>
 <20200920082018.16135-6-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/20 06:52:24
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, armbru@redhat.com,
 atar4qemu@gmail.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: BALATON Zoltan <balaton@eik.bme.hu>
From: BALATON Zoltan via <qemu-devel@nongnu.org>

On Sun, 20 Sep 2020, Mark Cave-Ayland wrote:
> Instead use qdev_prop_set_chr() to configure the ESCC serial chardevs at the
> Mac Old World and New World machine level.
>
> Also remove the now obsolete comment referring to the use of serial_hd() and
> change user_createable to true accordingly.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
> hw/misc/macio/macio.c | 5 +----
> hw/ppc/mac_newworld.c | 6 ++++++
> hw/ppc/mac_oldworld.c | 6 ++++++
> 3 files changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
> index 679722628e..ce641d41fd 100644
> --- a/hw/misc/macio/macio.c
> +++ b/hw/misc/macio/macio.c
> @@ -109,8 +109,6 @@ static void macio_common_realize(PCIDevice *d, Error **errp)
>     qdev_prop_set_uint32(DEVICE(&s->escc), "disabled", 0);
>     qdev_prop_set_uint32(DEVICE(&s->escc), "frequency", ESCC_CLOCK);
>     qdev_prop_set_uint32(DEVICE(&s->escc), "it_shift", 4);
> -    qdev_prop_set_chr(DEVICE(&s->escc), "chrA", serial_hd(0));
> -    qdev_prop_set_chr(DEVICE(&s->escc), "chrB", serial_hd(1));
>     qdev_prop_set_uint32(DEVICE(&s->escc), "chnBtype", escc_serial);
>     qdev_prop_set_uint32(DEVICE(&s->escc), "chnAtype", escc_serial);
>     if (!qdev_realize(DEVICE(&s->escc), BUS(&s->macio_bus), errp)) {
> @@ -458,8 +456,7 @@ static void macio_class_init(ObjectClass *klass, void *data)
>     k->class_id = PCI_CLASS_OTHERS << 8;
>     device_class_set_props(dc, macio_properties);
>     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> -    /* Reason: Uses serial_hds in macio_instance_init */
> -    dc->user_creatable = false;
> +    dc->user_creatable = true;

According to a comment in

https://git.qemu.org/?p=qemu.git;a=blob;f=hw/core/qdev.c;h=96772a15bd5b76d3ebe27d45ed1f2c1beb7f5386;hb=HEAD#l1135

user_creatable = true is the default and most devices don't set it 
explicitely so I think you can just remove the line setting it here.

Regards,
BALATON Zoltan

> }
>
> static const TypeInfo macio_bus_info = {
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index e42bd7a626..e59b30e0a7 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -123,6 +123,7 @@ static void ppc_core99_init(MachineState *machine)
>     UNINHostState *uninorth_pci;
>     PCIBus *pci_bus;
>     PCIDevice *macio;
> +    ESCCState *escc;
>     bool has_pmu, has_adb;
>     MACIOIDEState *macio_ide;
>     BusState *adb_bus;
> @@ -382,6 +383,11 @@ static void ppc_core99_init(MachineState *machine)
>     qdev_prop_set_bit(dev, "has-adb", has_adb);
>     object_property_set_link(OBJECT(macio), "pic", OBJECT(pic_dev),
>                              &error_abort);
> +
> +    escc = ESCC(object_resolve_path_component(OBJECT(macio), "escc"));
> +    qdev_prop_set_chr(DEVICE(escc), "chrA", serial_hd(0));
> +    qdev_prop_set_chr(DEVICE(escc), "chrB", serial_hd(1));
> +
>     pci_realize_and_unref(macio, pci_bus, &error_fatal);
>
>     /* We only emulate 2 out of 3 IDE controllers for now */
> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> index 7aba040f1b..25ade63ba3 100644
> --- a/hw/ppc/mac_oldworld.c
> +++ b/hw/ppc/mac_oldworld.c
> @@ -96,6 +96,7 @@ static void ppc_heathrow_init(MachineState *machine)
>     PCIBus *pci_bus;
>     PCIDevice *macio;
>     MACIOIDEState *macio_ide;
> +    ESCCState *escc;
>     SysBusDevice *s;
>     DeviceState *dev, *pic_dev;
>     BusState *adb_bus;
> @@ -283,6 +284,11 @@ static void ppc_heathrow_init(MachineState *machine)
>     qdev_prop_set_uint64(dev, "frequency", tbfreq);
>     object_property_set_link(OBJECT(macio), "pic", OBJECT(pic_dev),
>                              &error_abort);
> +
> +    escc = ESCC(object_resolve_path_component(OBJECT(macio), "escc"));
> +    qdev_prop_set_chr(DEVICE(escc), "chrA", serial_hd(0));
> +    qdev_prop_set_chr(DEVICE(escc), "chrB", serial_hd(1));
> +
>     pci_realize_and_unref(macio, pci_bus, &error_fatal);
>
>     macio_ide = MACIO_IDE(object_resolve_path_component(OBJECT(macio),
>


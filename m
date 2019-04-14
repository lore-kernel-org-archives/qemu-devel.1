Return-Path: <SRS0=wjfX=SQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DC4C10F13
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2019 15:45:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BD7420880
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2019 15:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=reactos.org header.i=@reactos.org header.b="PgE1fWNq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BD7420880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=reactos.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37081 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFhJo-0000o4-R6
	for qemu-devel@archiver.kernel.org; Sun, 14 Apr 2019 11:45:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1hFhIP-0008SF-NF
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 11:43:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1hFhIO-0002gf-OD
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 11:43:53 -0400
Received: from iserv.reactos.org ([2a01:4f8:1c17:5ae1::1]:59482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1hFhIL-0002aw-Sq; Sun, 14 Apr 2019 11:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=reactos.org
	; s=25047;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
	Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=u7mm2CS6TSvJIq9pzV8hRd6luYNs+kcqFsGVQcpGtDE=;
	b=PgE1fWNqztSuy+CuOhmTg8IlB0
	1kpRGjofcMare4UT9oP+xP4QltGSXffQY8ocpI9IieKRwpu+LUuJBETAGGZeL0M0lgMgfJOaGqo3r
	/TdMiA0f2JND7wTQLVkkq9Xb6IHJCclo1KwBGR3UIGtpW48u1AnzHe3bjeP6OQCKS/OU=; 
Received: from rob92-5-82-227-227-196.fbx.proxad.net ([82.227.227.196]
	helo=[192.168.0.35]) by iserv.reactos.org with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
	(envelope-from <hpoussin@reactos.org>)
	id 1hFhIB-00063s-Tf; Sun, 14 Apr 2019 15:43:40 +0000
To: Artyom Tarasenko <atar4qemu@gmail.com>, qemu-devel@nongnu.org
References: <1555103178-21894-1-git-send-email-atar4qemu@gmail.com>
	<1555103178-21894-2-git-send-email-atar4qemu@gmail.com>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <e9e9724c-4a8f-e374-8ddf-4e9d4586fa40@reactos.org>
Date: Sun, 14 Apr 2019 17:43:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1555103178-21894-2-git-send-email-atar4qemu@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a01:4f8:1c17:5ae1::1
Subject: Re: [Qemu-devel] [PATCH 1/4] lsi53c895a: hide 53c895a registers in
 53c810
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
	qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190414154337.1lggxNIDddEFJUbit3HH4eQ0-pfnJMoVI3zCPQ_zg1k@z>

Le 12/04/2019 à 23:06, Artyom Tarasenko a écrit :
> AIX/PReP does access to the aliased IO registers of 53810.
> Implement aliasing to make the AIX driver work.
> 
> Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
> ---
>   hw/scsi/lsi53c895a.c | 31 ++++++++++++++++++++++++++-----
>   1 file changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
> index da7239d..08841e0 100644
> --- a/hw/scsi/lsi53c895a.c
> +++ b/hw/scsi/lsi53c895a.c
> @@ -2266,11 +2266,13 @@ static const struct SCSIBusInfo lsi_scsi_info = {
>       .cancel = lsi_request_cancelled
>   };
>   
> -static void lsi_scsi_realize(PCIDevice *dev, Error **errp)
> +static void lsi_scsi_realize_8xx(PCIDevice *dev, Error **errp, uint16_t type)

You can probably remove this change, and replace it by
uint16_t type = PCI_DEVICE_GET_CLASS(dev)->device_id;

>   {
>       LSIState *s = LSI53C895A(dev);
>       DeviceState *d = DEVICE(dev);
>       uint8_t *pci_conf;
> +    uint64_t mmio_size;
> +    MemoryRegion *mr;
>   
>       pci_conf = dev->config;
>   
> @@ -2279,13 +2281,21 @@ static void lsi_scsi_realize(PCIDevice *dev, Error **errp)
>       /* Interrupt pin A */
>       pci_conf[PCI_INTERRUPT_PIN] = 0x01;
>   
> -    memory_region_init_io(&s->mmio_io, OBJECT(s), &lsi_mmio_ops, s,
> -                          "lsi-mmio", 0x400);
>       memory_region_init_io(&s->ram_io, OBJECT(s), &lsi_ram_ops, s,
>                             "lsi-ram", 0x2000);
>       memory_region_init_io(&s->io_io, OBJECT(s), &lsi_io_ops, s,
>                             "lsi-io", 256);
> -
> +    if (type == PCI_DEVICE_ID_LSI_53C895A) {
> +        mmio_size = 0x400;
> +    } else {
> +        mr = g_new(MemoryRegion, 1);
> +        memory_region_init_alias(mr, OBJECT(d), "lsi-io-alias", &s->io_io,
> +                                 0, 0x80);
> +        memory_region_add_subregion_overlap(&s->io_io, 0x80, mr, -1);
> +        mmio_size = 0x80;
> +    }
> +    memory_region_init_io(&s->mmio_io, OBJECT(s), &lsi_mmio_ops, s,
> +                          "lsi-mmio", mmio_size);
>       address_space_init(&s->pci_io_as, pci_address_space_io(dev), "lsi-pci-io");
>       qdev_init_gpio_out(d, &s->ext_irq, 1);
>   
> @@ -2297,6 +2307,16 @@ static void lsi_scsi_realize(PCIDevice *dev, Error **errp)
>       scsi_bus_new(&s->bus, sizeof(s->bus), d, &lsi_scsi_info, NULL);
>   }
>   
> +static void lsi_scsi_realize_895A(PCIDevice *dev, Error **errp)
> +{
> +    lsi_scsi_realize_8xx(dev, errp, PCI_DEVICE_ID_LSI_53C895A);
> +}
> +
> +static void lsi_scsi_realize_810(PCIDevice *dev, Error **errp)
> +{
> +    lsi_scsi_realize_8xx(dev, errp, PCI_DEVICE_ID_LSI_53C810);
> +}

... so you can also remove these functions
> +
>   static void lsi_scsi_unrealize(DeviceState *dev, Error **errp)
>   {
>       LSIState *s = LSI53C895A(dev);
> @@ -2309,7 +2329,7 @@ static void lsi_class_init(ObjectClass *klass, void *data)
>       DeviceClass *dc = DEVICE_CLASS(klass);
>       PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
>   
> -    k->realize = lsi_scsi_realize;
> +    k->realize = lsi_scsi_realize_895A;

... so you can also remove this change
>       k->vendor_id = PCI_VENDOR_ID_LSI_LOGIC;
>       k->device_id = PCI_DEVICE_ID_LSI_53C895A;
>       k->class_id = PCI_CLASS_STORAGE_SCSI;
> @@ -2335,6 +2355,7 @@ static void lsi53c810_class_init(ObjectClass *klass, void *data)
>   {
>       PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
>   
> +    k->realize = lsi_scsi_realize_810;
... and this one.

>       k->device_id = PCI_DEVICE_ID_LSI_53C810;
>   }
>   
> 

Hervé


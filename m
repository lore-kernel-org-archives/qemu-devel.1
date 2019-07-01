Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC60C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 09:57:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 375D020881
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 09:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 375D020881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hht3T-0003i7-HA
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 05:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55004)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hht2c-00039F-1A
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:56:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hht2a-0005TX-VA
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:56:05 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36959)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hht2a-0005RZ-Oz
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:56:04 -0400
Received: by mail-wm1-f68.google.com with SMTP id f17so15170562wme.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 02:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=esYtdvA6iVIBBEVsUukNwSp6DwYedmsNl6Re3bXnZqM=;
 b=DtlkTqBVP8BTmAqHxG/tDKjUSBMe1XZRssvO0TYDNFdHJb+2doc4bdqisV4PX2VFds
 /oIT0syQA6jjmHLPSCPJfSSJ6GhT971ZVixTpZyP7wv6kp74fvY8N+/kpR9Sw9RTsGpG
 ey9wu+Exm2nrQ7d8GjBTiBx1mrO7obpjmwO5d66HejdibcG5JdtHF347FjvIF2ZfmjMf
 TdoHlaYCSIenXym7/dPbsgIlJsvsptcQzkGYbs/NTp86Hzb6kU6TUohPnCYORHmZSGfs
 6GXXQQusQtEtgdP7A1fgM2/0nJSwR6UwehKKyeex7/92rC/npCBNCwSVh0SNgIO7aaJ5
 OehQ==
X-Gm-Message-State: APjAAAVFo98gBH9taK47sVuM0ZIvdDUHomRQm4s4wUTbZTNN1j8pVJKz
 pW1Apx/0AIIK7wmLVRI2ZeH8AQ==
X-Google-Smtp-Source: APXvYqzv97stbd2CRVzxT9Z8tYIP/gBIUuQgOu16IwPlTd1NOvPuyrH4YsB1kc3ZTHPvq85bcu9nUA==
X-Received: by 2002:a1c:7217:: with SMTP id n23mr16919880wmc.47.1561974962737; 
 Mon, 01 Jul 2019 02:56:02 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id o12sm10075331wrx.63.2019.07.01.02.56.01
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jul 2019 02:56:02 -0700 (PDT)
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
References: <20190701093232.28575-1-mst@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <2911eb5c-08cb-e0fb-e079-8738476d2f37@redhat.com>
Date: Mon, 1 Jul 2019 11:56:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190701093232.28575-1-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH 4/3] pcie: minor cleanups for slot
 control/status
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
Cc: Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/1/19 11:34 AM, Michael S. Tsirkin wrote:
> Rename function arguments to make intent clearer.
> Better documentation for slot control logic.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> 
>  include/hw/pci/pcie.h |  3 ++-
>  hw/pci/pcie.c         | 17 +++++++++++------
>  2 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
> index 8d90c0e193..34f277735c 100644
> --- a/include/hw/pci/pcie.h
> +++ b/include/hw/pci/pcie.h
> @@ -108,7 +108,8 @@ void pcie_cap_lnkctl_reset(PCIDevice *dev);
>  void pcie_cap_slot_init(PCIDevice *dev, uint16_t slot);
>  void pcie_cap_slot_reset(PCIDevice *dev);
>  void pcie_cap_slot_get(PCIDevice *dev, uint16_t *slot_ctl, uint16_t *slt_sta);
> -void pcie_cap_slot_write_config(PCIDevice *dev, uint16_t slot_ctl, uint16_t slt_sta,
> +void pcie_cap_slot_write_config(PCIDevice *dev,
> +                                uint16_t old_slot_ctl, uint16_t old_slt_sta,
>                                  uint32_t addr, uint32_t val, int len);
>  int pcie_cap_slot_post_load(void *opaque, int version_id);
>  void pcie_cap_slot_push_attention_button(PCIDevice *dev);
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index c605d32dd4..a6beb567bd 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -602,7 +602,8 @@ void pcie_cap_slot_get(PCIDevice *dev, uint16_t *slt_ctl, uint16_t *slt_sta)
>      *slt_sta = pci_get_word(exp_cap + PCI_EXP_SLTSTA);
>  }
>  
> -void pcie_cap_slot_write_config(PCIDevice *dev, uint16_t slt_ctl, uint16_t slt_sta,
> +void pcie_cap_slot_write_config(PCIDevice *dev,
> +                                uint16_t old_slt_ctl, uint16_t old_slt_sta,
>                                  uint32_t addr, uint32_t val, int len)
>  {
>      uint32_t pos = dev->exp.exp_cap;
> @@ -625,8 +626,8 @@ void pcie_cap_slot_write_config(PCIDevice *dev, uint16_t slt_ctl, uint16_t slt_s
>                            PCI_EXP_SLTSTA_MRLSC | PCI_EXP_SLTSTA_PDC | \
>                            PCI_EXP_SLTSTA_CC)
>  
> -        if (val & ~slt_sta & PCIE_SLOT_EVENTS) {
> -            sltsta = (sltsta & ~PCIE_SLOT_EVENTS) | (slt_sta & PCIE_SLOT_EVENTS);
> +        if (val & ~old_slt_sta & PCIE_SLOT_EVENTS) {
> +            sltsta = (sltsta & ~PCIE_SLOT_EVENTS) | (old_slt_sta & PCIE_SLOT_EVENTS);
>              pci_set_word(exp_cap + PCI_EXP_SLTSTA, sltsta);
>          }
>          hotplug_event_clear(dev);
> @@ -646,13 +647,17 @@ void pcie_cap_slot_write_config(PCIDevice *dev, uint16_t slt_ctl, uint16_t slt_s
>      }
>  
>      /*
> -     * If the slot is polulated, power indicator is off and power
> +     * If the slot is populated, power indicator is off and power
>       * controller is off, it is safe to detach the devices.
> +     *
> +     * Note: don't detach if condition was already true:
> +     * this is a work around for guests that overwrite
> +     * control of powered off slots before powering them on.
>       */
>      if ((sltsta & PCI_EXP_SLTSTA_PDS) && (val & PCI_EXP_SLTCTL_PCC) &&
>          (val & PCI_EXP_SLTCTL_PIC_OFF) == PCI_EXP_SLTCTL_PIC_OFF &&
> -        (!(slt_ctl & PCI_EXP_SLTCTL_PCC) ||
> -        (slt_ctl & PCI_EXP_SLTCTL_PIC_OFF) != PCI_EXP_SLTCTL_PIC_OFF)) {
> +        (!(old_slt_ctl & PCI_EXP_SLTCTL_PCC) ||
> +        (old_slt_ctl & PCI_EXP_SLTCTL_PIC_OFF) != PCI_EXP_SLTCTL_PIC_OFF)) {
>          PCIBus *sec_bus = pci_bridge_get_sec_bus(PCI_BRIDGE(dev));
>          pci_for_each_device(sec_bus, pci_bus_num(sec_bus),
>                              pcie_unplug_device, NULL);
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


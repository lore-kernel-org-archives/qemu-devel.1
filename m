Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46BDC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 14:43:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A1952064B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 14:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A1952064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhxX0-0005Az-Lk
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 10:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46787)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dinechin@redhat.com>) id 1hhwiO-0000Q9-KH
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:51:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dinechin@redhat.com>) id 1hhwiN-0001vh-Fg
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:51:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33088)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dinechin@redhat.com>) id 1hhwiN-0001n0-6P
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:51:27 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6B8B13003BF1
 for <qemu-devel@nongnu.org>; Mon,  1 Jul 2019 13:51:14 +0000 (UTC)
Received: from ptitpuce (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A3A1F6085B;
 Mon,  1 Jul 2019 13:51:13 +0000 (UTC)
References: <20190621064615.20099-1-mst@redhat.com>
 <20190701093232.28575-1-mst@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.2
From: Christophe de Dinechin <dinechin@redhat.com>
To: qemu-devel@nongnu.org
In-reply-to: <20190701093232.28575-1-mst@redhat.com>
Date: Mon, 01 Jul 2019 15:51:10 +0200
Message-ID: <m1h885hnht.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Mon, 01 Jul 2019 13:51:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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


Michael S. Tsirkin writes:

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

Good idea.
Reviewed-by: Christophe de Dinechin <dinechin@redhat.com>

--
Cheers,
Christophe de Dinechin (IRC c3d)


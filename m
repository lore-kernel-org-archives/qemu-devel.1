Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73CAC4740C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 18:14:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 955E1218DE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 18:14:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 955E1218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7OB8-00050q-QS
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 14:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57363)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1i7OAI-0004E0-CI
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 14:13:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1i7OAG-0001eE-FT
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 14:13:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35892)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1i7OAB-0001bX-GM; Mon, 09 Sep 2019 14:13:19 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 92F50C0740CD;
 Mon,  9 Sep 2019 18:13:18 +0000 (UTC)
Received: from [10.18.17.230] (dhcp-17-230.bos.redhat.com [10.18.17.230])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C00BD3DB3;
 Mon,  9 Sep 2019 18:13:02 +0000 (UTC)
To: andychiu <andychiu@synology.com>, qemu-devel@nongnu.org, mst@redhat.com
References: <1568049517-10261-1-git-send-email-andychiu@synology.com>
From: John Snow <jsnow@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <6eb1dbda-85fe-de7c-613c-a6871fc2d28f@redhat.com>
Date: Mon, 9 Sep 2019 14:13:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568049517-10261-1-git-send-email-andychiu@synology.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Mon, 09 Sep 2019 18:13:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] ahci: enable pci bus master MemoryRegion
 before loading ahci engines
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
Cc: qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/9/19 1:18 PM, andychiu via Qemu-devel wrote:
> If Windows 10 guests have enabled 'turn off hard disk after idle'
> option in power settings, and the guest has a SATA disk plugged in,
> the SATA disk will be turned off after a specified idle time.
> If the guest is live migrated or saved/loaded with its SATA disk
> turned off, the following error will occur:
> 
> qemu-system-x86_64: AHCI: Failed to start FIS receive engine: bad FIS receive buffer address
> qemu-system-x86_64: Failed to load ich9_ahci:ahci
> qemu-system-x86_64: error while loading state for instance 0x0 of device '0000:00:1a.0/ich9_ahci'
> qemu-system-x86_64: load of migration failed: Operation not permitted
> 

Oof. That can't have been fun to discover.

> Observation from trace logs shows that a while after Windows 10 turns off
> a SATA disk (IDE disks don't have the following behavior),
> it will disable the PCI_COMMAND_MASTER flag of the pci device containing
> the ahci device. When the the disk is turning back on,
> the PCI_COMMAND_MASTER flag will be restored first.
> But if the guest is migrated or saved/loaded while the disk is off,
> the post_load callback of ahci device, ahci_state_post_load(), will fail
> at ahci_cond_start_engines() if the MemoryRegion
> pci_dev->bus_master_enable_region is not enabled, with pci_dev pointing
> to the PCIDevice struct containing the ahci device.
> 
> This patch enables pci_dev->bus_master_enable_region before calling
> ahci_cond_start_engines() in ahci_state_post_load(), and restore the
> MemoryRegion to its original state afterwards.>

This looks good to me from an AHCI perspective, but I'm not as clear on
the implications of toggling the MemoryRegion, so I have some doubts.


MST, can you chime in and clear my confusion?

I suppose when the PCI_COMMAND_MASTER bit is turned off, we disable the
memory region, as a guest would be unable to establish a new mapping in
this time, so it makes sense that the attempt to map it fails.

What's less clear to me is what happens to existing mappings when a
region is disabled. Are they invalidated? If so, does it make sense that
we are trying to establish a mapping here at all? Maybe it's absolutely
correct that this fails.

(I suppose, though, that the simple toggling of the region won't be a
guest-visible event, so it's probably safe to do. Right?)

What I find weird for AHCI is this: We try to engage the CLB mapping
before the FIS mapping, but we fail at the FIS mapping. So why is
PORT_CMD_FIS_RX set while PORT_CMD_START is unset?

It kind of looks like we only half-heartedly stopped the AHCI device.
Maybe that's just what Windows does, but I wonder if there's a bug where
we're erroneously leaving PORT_CMD_FIS_RX set when we've been disabled.
It seems like the guest would need to re-set the mappings anyway, so
maybe trying to restore a stale mapping is not the right thing to do.



Andy, if you have traces left over: What AHCI registers does Windows
touch when it disables the AHCI device? What registers does it touch
when it re-engages it?

I just want to make sure I'm not leaving something dangling by accident.

--js

> Signed-off-by: andychiu <andychiu@synology.com>
> ---
>  hw/ide/ahci.c | 53 ++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 36 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index d45393c..83f8c30 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -1649,33 +1649,52 @@ static const VMStateDescription vmstate_ahci_device = {
>      },
>  };
>  
> +static int ahci_state_load_engines(AHCIState *s, AHCIDevice *ad)
> +{
> +    AHCIPortRegs *pr = &ad->port_regs;
> +    DeviceState *dev_state = s->container;
> +    PCIDevice *pci_dev = (PCIDevice *) object_dynamic_cast(OBJECT(dev_state),
> +                                                           TYPE_PCI_DEVICE);
> +    bool pci_bus_master_enabled = pci_dev->bus_master_enable_region.enabled;
> +
> +    if (!(pr->cmd & PORT_CMD_START) && (pr->cmd & PORT_CMD_LIST_ON)) {
> +        error_report("AHCI: DMA engine should be off, but status bit "
> +                     "indicates it is still running.");
> +        return -1;
> +    }
> +    if (!(pr->cmd & PORT_CMD_FIS_RX) && (pr->cmd & PORT_CMD_FIS_ON)) {
> +        error_report("AHCI: FIS RX engine should be off, but status bit "
> +                     "indicates it is still running.");
> +        return -1;
> +    }
> +
> +    memory_region_set_enabled(&pci_dev->bus_master_enable_region, true);
> +
> +    /*
> +     * After a migrate, the DMA/FIS engines are "off" and
> +     * need to be conditionally restarted
> +     */
> +    pr->cmd &= ~(PORT_CMD_LIST_ON | PORT_CMD_FIS_ON);
> +    if (ahci_cond_start_engines(ad) != 0) {
> +        return -1;
> +    }
> +    memory_region_set_enabled(&pci_dev->bus_master_enable_region,
> +                              pci_bus_master_enabled);
> +
> +    return 0;
> +}
> +
>  static int ahci_state_post_load(void *opaque, int version_id)
>  {
>      int i, j;
>      struct AHCIDevice *ad;
>      NCQTransferState *ncq_tfs;
> -    AHCIPortRegs *pr;
>      AHCIState *s = opaque;
>  
>      for (i = 0; i < s->ports; i++) {
>          ad = &s->dev[i];
> -        pr = &ad->port_regs;
> -
> -        if (!(pr->cmd & PORT_CMD_START) && (pr->cmd & PORT_CMD_LIST_ON)) {
> -            error_report("AHCI: DMA engine should be off, but status bit "
> -                         "indicates it is still running.");
> -            return -1;
> -        }
> -        if (!(pr->cmd & PORT_CMD_FIS_RX) && (pr->cmd & PORT_CMD_FIS_ON)) {
> -            error_report("AHCI: FIS RX engine should be off, but status bit "
> -                         "indicates it is still running.");
> -            return -1;
> -        }
>  
> -        /* After a migrate, the DMA/FIS engines are "off" and
> -         * need to be conditionally restarted */
> -        pr->cmd &= ~(PORT_CMD_LIST_ON | PORT_CMD_FIS_ON);
> -        if (ahci_cond_start_engines(ad) != 0) {
> +        if (ahci_state_load_engines(s, ad)) {
>              return -1;
>          }
>  
> 


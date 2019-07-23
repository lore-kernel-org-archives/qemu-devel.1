Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320CFC7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:09:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0674420828
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:09:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0674420828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hprjU-00008B-9L
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 06:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57024)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hprjI-0008BO-Pt
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:09:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hprjH-00022M-Gk
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:09:08 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34947)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hprjH-00021q-8Q
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:09:07 -0400
Received: by mail-qk1-f196.google.com with SMTP id r21so30702740qke.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 03:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=IIOnwA/aumQgTw5Rs1wZnfRNnU6XOCLIJkXlgzCYjw4=;
 b=qYEXk+XkkKw4VmU4r3jko/FBVtP5HmIc5CPo+lhUX9yG4JylbD7O+A1PfS31HI3/EF
 HbRVfybY1VkgXChEfDk384SLOWwP4lm1XreB0e7cPFlzZg77pF9T0SGO3mcBkKi+40CW
 an4YH9G/aTFhLMq4NdZKtF+vcaB3GKtIvb7W1ZBnkR5q+iIBI81+Rqgcvmob88BQzqbS
 stFH6ValzZcrqXA0/1Hs8YassdwiIET+8G1I7AFaLMWHh+FQJTlDWeQKUmmadMRs418z
 Kol3qFCbAJcv4j/tU19BNYlchLGKIiba1Yy854ISFOOSJmcWlLyaLgo9Ck3tFoOvsMBn
 6J8A==
X-Gm-Message-State: APjAAAVihxsOttgvfRNtRcDqyq/Y5hhhsgI0TIv7WYgkG8mcml8ufoI7
 9IpQdkkfUhIxJpI6TfgmRT7eig==
X-Google-Smtp-Source: APXvYqzPBjucb8a8qtumZ2VViB/fikqyhqpzL4uEHvoUKaNfCcm8lF+RDn+JBy6XQCq0ty+FCtM95g==
X-Received: by 2002:a05:620a:1497:: with SMTP id
 w23mr48847845qkj.49.1563876546677; 
 Tue, 23 Jul 2019 03:09:06 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 s25sm18592650qkm.130.2019.07.23.03.09.03
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 23 Jul 2019 03:09:05 -0700 (PDT)
Date: Tue, 23 Jul 2019 06:09:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhangbo (Oscar)" <oscar.zhangbo@huawei.com>
Message-ID: <20190723054623-mutt-send-email-mst@kernel.org>
References: <0259E1C966E8C54AA93AA2B1240828E672DF1C9F@dggeml509-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0259E1C966E8C54AA93AA2B1240828E672DF1C9F@dggeml509-mbx.china.huawei.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.222.196
Subject: Re: [Qemu-devel] [PATCH] pcie: fix device unplug timeout
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
Cc: fangying <fangying1@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "limingwang \(A\)" <limingwang@huawei.com>,
 "dengkai \(A\)" <dengkai1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 23, 2019 at 07:48:00AM +0000, Zhangbo (Oscar) wrote:
> If the linux kernel only receives an ABP event during pcie unplug, it will sleep 5s 
> to expect a PDC event, which will cause device unplug timeout.

My understanding is that there's no timeout. Spec says:
	If present, the Power Indicator provides visual feedback to the human operator (if the system
	software accepts the request initiated by the Attention Button) by blinking. Once the Power
	Indicator begins blinking, a 5-second abort interval exists during which a second depression of the
	Attention Button cancels the operation.

this is exactly what linux implements.
Thus after an ABP event, linux starts a 5 second timer:
	schedule_delayed_work(&ctrl->button_work, 5 * HZ);


> In the meanwhile, if the kernel only receives a PDC event during the unplug, it
> will wait for at least 1 second before checking card present as data link layer
> state changed (link down) event reported prior to presence detect changed
> (card is not present).

I don't understand what you are saying exactly.
But I don't see any other delayed work in
drivers/pci/hotplug/pciehp_ctrl.c


> Therefore we can send both ABP and PDC events to the kernel in unplug process
> to avoid unplug timeout.
> 
> Signed-off-by: limingwang@huawei.com
> Signed-off-by: fangying1@huawei.com
> Signed-off-by: oscar.zhangbo@huawei.com

I see this in linux:

/**
 * pciehp_check_presence() - synthesize event if presence has changed
 *              
 * On probe and resume, an explicit presence check is necessary to bring up an
 * occupied slot or bring down an unoccupied slot.  This can't be triggered by
 * events in the Slot Status register, they may be stale and are therefore
 * cleared.  Secondly, sending an interrupt for "events that occur while
 * interrupt generation is disabled [when] interrupt generation is subsequently
 * enabled" is optional per PCIe r4.0, sec 6.7.3.4.
 */


My suggestion therefore is to try to clear Presence Detect State,
set presence detect changed and do not set attention button
pressed.


> ---
>  hw/pci/pcie.c         | 8 ++------
>  include/hw/pci/pcie.h | 1 -
>  2 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 174f392..a800f23 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -485,7 +485,8 @@ void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
>                                       PCI_EXP_LNKSTA_DLLLA);
>      }
>  
> -    pcie_cap_slot_push_attention_button(PCI_DEVICE(hotplug_dev));
> +    pcie_cap_slot_event(PCI_DEVICE(hotplug_dev),
> +                        PCI_EXP_HP_EV_PDC | PCI_EXP_HP_EV_ABP);
>  }
>  
>  /* pci express slot for pci express root/downstream port
> @@ -701,11 +702,6 @@ int pcie_cap_slot_post_load(void *opaque, int version_id)
>      return 0;
>  }
>  
> -void pcie_cap_slot_push_attention_button(PCIDevice *dev)
> -{
> -    pcie_cap_slot_event(dev, PCI_EXP_HP_EV_ABP);
> -}
> -
>  /* root control/capabilities/status. PME isn't emulated for now */
>  void pcie_cap_root_init(PCIDevice *dev)
>  {
> diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
> index 8cf3361..0975a54 100644
> --- a/include/hw/pci/pcie.h
> +++ b/include/hw/pci/pcie.h
> @@ -112,7 +112,6 @@ void pcie_cap_slot_write_config(PCIDevice *dev,
>                                  uint16_t old_slt_ctl, uint16_t old_slt_sta,
>                                  uint32_t addr, uint32_t val, int len);
>  int pcie_cap_slot_post_load(void *opaque, int version_id);
> -void pcie_cap_slot_push_attention_button(PCIDevice *dev);
>  
>  void pcie_cap_root_init(PCIDevice *dev);
>  void pcie_cap_root_reset(PCIDevice *dev);
> -- 
> 1.8.3.1


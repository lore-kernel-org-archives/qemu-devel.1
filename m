Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F71C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 09:45:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64D2E21743
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 09:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D2E21743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hprMQ-00078q-A1
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 05:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50146)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hprMB-0006aM-KV
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 05:45:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hprMA-0006T5-Hg
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 05:45:15 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46997)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hprMA-0006SK-DU
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 05:45:14 -0400
Received: by mail-qk1-f194.google.com with SMTP id r4so30548741qkm.13
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 02:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=gSprAtwiaLQoqrFU9f9MUC1DgUAXFkCecIoomSTxO8Y=;
 b=S5+IqWmneQ18X/D3eGuBL4GP3/PrFv4Vz5R/ysTLro+F/qSYnmzeNReSL+wuyefwFX
 Bs01dFp2yecb65yAD+I6lMWe2ga1J1YALEWcWSVmw2BjdCbUIsUZQlMthIG4A0F9Z/JX
 Il+nPiXn2iqgVMm2w96qQhnD8geOUd9BWKVfxZxccJGFWLbz3BUKt2RKBA0fjBo7Lxv1
 I/vl1u6AfVOh3Ot0M5Lblofyd1KVhHRo2yrrYJoUkQrpbtx3TScNbBesyouBSmBMhjHw
 RlVlD2aT2Ey/ODxsO+MnRkM1kgjl2+7fOSUSWZwGuBGXMV/9rKpyrooQ0s596BkrKaGv
 mGcw==
X-Gm-Message-State: APjAAAXvV8tsQARILxT2YL8AY3goegIefjxrts1AG0thjakg2l3UP2y4
 UA+9b33gzWsVbdL2hEnNa2uPJQ==
X-Google-Smtp-Source: APXvYqxVxXH/vIvDvdXMfeJZnxhZU8DrpuesSUL3cx7SOjPxDthEVLUcT+1gVq4U7QMLozmEeZrv7g==
X-Received: by 2002:a37:49c2:: with SMTP id
 w185mr44160836qka.407.1563875113165; 
 Tue, 23 Jul 2019 02:45:13 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 o12sm18252832qkg.99.2019.07.23.02.45.10
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 23 Jul 2019 02:45:12 -0700 (PDT)
Date: Tue, 23 Jul 2019 05:45:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhangbo (Oscar)" <oscar.zhangbo@huawei.com>
Message-ID: <20190723053038-mutt-send-email-mst@kernel.org>
References: <0259E1C966E8C54AA93AA2B1240828E672DF1C92@dggeml509-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0259E1C966E8C54AA93AA2B1240828E672DF1C92@dggeml509-mbx.china.huawei.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.222.194
Subject: Re: [Qemu-devel] [PATCH] pcie: fix device hotplug failure at the
 meantime of VM boot
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

On Tue, Jul 23, 2019 at 07:47:51AM +0000, Zhangbo (Oscar) wrote:
> If the PCI_EXP_LNKSTA_DLLLA capability is set by default, linux kernel will send 
> PDC event to detect whether there is a device in pcie slot. If a device is pluged
> in the pcie-root-port at the same time, hot-plug device will send ABP + PDC
> events to the kernel. The VM kernel will wrongly unplug the device if two PDC
> events get too close. Thus we'd better set the PCI_EXP_LNKSTA_DLLLA
> capability only in hotplug callback.

Could you please describe a reproducer in a bit more detail?


> 
> By the way, we should clean up the PCI_EXP_LNKSTA_DLLLA capability during
> unplug to avoid VM restart or migration failure which will enter the same
> abnormal scenario as above.
> 
> Signed-off-by: limingwang@huawei.com
> Signed-off-by: fangying1@huawei.com
> Signed-off-by: oscar.zhangbo@huawei.com

So looking at linux I see:

 * pciehp_card_present_or_link_active() - whether given slot is occupied
 * @ctrl: PCIe hotplug controller
 *
 * Unlike pciehp_card_present(), which determines presence solely from the
 * Presence Detect State bit, this helper also returns true if the Link Active
 * bit is set.  This is a concession to broken hotplug ports which hardwire
 * Presence Detect State to zero, such as Wilocity's [1ae9:0200].

so it looks like linux actually looks at presence detect state,
but we have a bug just like Wilocity's and keeping
link active up fixes that. Can't we fix the bug instead?

> ---
>  hw/pci/pcie.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index a6beb56..174f392 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -75,10 +75,6 @@ pcie_cap_v1_fill(PCIDevice *dev, uint8_t port, uint8_t type, uint8_t version)
>                   QEMU_PCI_EXP_LNKSTA_NLW(QEMU_PCI_EXP_LNK_X1) |
>                   QEMU_PCI_EXP_LNKSTA_CLS(QEMU_PCI_EXP_LNK_2_5GT));
>  
> -    if (dev->cap_present & QEMU_PCIE_LNKSTA_DLLLA) {
> -        pci_word_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA,
> -                                   PCI_EXP_LNKSTA_DLLLA);
> -    }
>  
>      /* We changed link status bits over time, and changing them across
>       * migrations is generally fine as hardware changes them too.

Does this actually change anything?

I don't know why do we bother setting it here but we do
set it later in pcie_cap_slot_plug_cb, correct?

I'd like to understand whether this is part of fix or
just a cleanup.


> @@ -484,6 +480,11 @@ void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
>          return;
>      }
>  
> +    if (pci_dev->cap_present & QEMU_PCIE_LNKSTA_DLLLA) {
> +        pci_word_test_and_clear_mask(exp_cap + PCI_EXP_LNKSTA,
> +                                     PCI_EXP_LNKSTA_DLLLA);
> +    }
> +
>      pcie_cap_slot_push_attention_button(PCI_DEVICE(hotplug_dev));
>  }

So this reports data link inactive immediately after
unplug request. Seems a bit questionable: guest did not
respond yet. I'd like to see a comment explaining why
this makes sense.


> -- 
> 1.8.3.1


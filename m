Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EFFC7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:11:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35F7F22580
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:11:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35F7F22580
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hprlT-0002tm-H6
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 06:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57731)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hprlJ-0002SA-Th
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:11:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hprlI-0003Pm-RT
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:11:13 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42739)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hprlI-0003PP-La
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:11:12 -0400
Received: by mail-qt1-f196.google.com with SMTP id h18so41309640qtm.9
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 03:11:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qMTXUAhbXc04VRrgW8r3rg9IulmNSELCVoFiBYes1cg=;
 b=L42d6YN94dYC/NTR9lzmkDV4QvtJk5JKzKdPdNw7y9sV44GO6OebXKC1Z5E4Tyai0H
 7kTeQVvtOqe60XpNJ4j2MnE6iFu7BhDW6vskMwOChPY477WuUY57rKC/eZMT0pyIrXLK
 9r8ZJb29g1LXCnbdVJx4NukXgNK9ueEJ5z6b7Mcf9XGu8mJYKbrRCrg+qaDf2SuVKmW5
 P46iXUbkD2xeNHvp9VHZ/Z+bAFMjatyafUA2GRSHoHr2bA+jMvOspHSFaTByX62g6ig9
 mCG525/HxUl/eoau9Uny1TK1z1Zx5XiUscQo62bqBZMy2xIgDqaSUcQ6JR0GO+4W4kTz
 88rA==
X-Gm-Message-State: APjAAAWe/odpIoIoG1rORp+BVXUxhqjTC6KxXILa/rQqWnFsP2K7QiVh
 4s1zEOj0TNxqjJWJbBoYt9phew==
X-Google-Smtp-Source: APXvYqxakYWsyUg3QZV22fGqih4iId8HF2yjbrLKX+2eTQEQlV1PoeApMP7khwm2Os7Bc5STyyT6kQ==
X-Received: by 2002:ac8:2c17:: with SMTP id d23mr51701060qta.385.1563876672239; 
 Tue, 23 Jul 2019 03:11:12 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 s25sm18594281qkm.130.2019.07.23.03.11.09
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 23 Jul 2019 03:11:11 -0700 (PDT)
Date: Tue, 23 Jul 2019 06:11:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhangbo (Oscar)" <oscar.zhangbo@huawei.com>
Message-ID: <20190723061101-mutt-send-email-mst@kernel.org>
References: <0259E1C966E8C54AA93AA2B1240828E672DF3D38@dggeml509-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0259E1C966E8C54AA93AA2B1240828E672DF3D38@dggeml509-mbx.china.huawei.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.196
Subject: Re: [Qemu-devel] [PATCH v2] pcie: fix device hotplug failure at the
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
Cc: fangying <fangying1@huawei.com>, "philmd@redhat.com" <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "limingwang \(A\)" <limingwang@huawei.com>,
 "dengkai \(A\)" <dengkai1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 23, 2019 at 09:31:30AM +0000, Zhangbo (Oscar) wrote:
> If the PCI_EXP_LNKSTA_DLLLA capability is set by default, linux kernel will send 
> PDC event to detect whether there is a device in pcie slot. If a device is pluged
> in the pcie-root-port at the same time, hot-plug device will send ABP + PDC
> events to the kernel. The VM kernel will wrongly unplug the device if two PDC
> events get too close. Thus we'd better set the PCI_EXP_LNKSTA_DLLLA
> capability only in hotplug callback.
> 
> By the way, we should clean up the PCI_EXP_LNKSTA_DLLLA capability during
> unplug to avoid VM restart or migration failure which will enter the same
> abnormal scenario as above.
> 
> Signed-off-by: Li Mingwang <limingwang@huawei.com>
> Signed-off-by: Fang Ying <fangying1@huawei.com>
> Signed-off-by: Zhang Bo <oscar.zhangbo@huawei.com>


I responded on v1 before seeing v2. As there's no change to patch
or commit log, same comments apply.



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
>  
> -- 
> 1.8.3.1


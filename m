Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367F6C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:11:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D79320828
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:11:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D79320828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hprlG-00024f-Ak
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 06:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57632)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hprl6-0001fl-M9
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:11:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hprl5-0003Fw-My
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:11:00 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43803)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hprl5-0003Fi-Ia
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:10:59 -0400
Received: by mail-qt1-f195.google.com with SMTP id w17so41284997qto.10
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 03:10:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=e2UR3b32uBfN4C4pohoH9cOWtmjRQ2EylHicq93v7/4=;
 b=dOqzkSMBwse3WVveuyZQXDqLsZck8ih+tQgv8AIqGJW8R3h7013+MOec3ol9YtUsSL
 0r+xIQrBvV9UCKuOkofCNFO+18q2uxJZxeY0yk1t6xV9ns2YgFjuTIg92ea6Ja4pbMZp
 it9py0DVQeVyjueDiaYpsBerlG4umsbcx1oz6sGuZhlpvNlXOXjhzK1TO+O+5V/bjeBm
 hymtsrTAJbrrAJEYuxQSnGWQ4F3OAsbOa3zhrS1GE3rXBRpgIZmGph70Kdst2GfnPKuc
 KA4EJfw+w1iIGldN6CtL+ygIYn73cVB9D4OMHKnokOqmEDFOmnHhmj2rBv2dTM4inPTR
 w1Zg==
X-Gm-Message-State: APjAAAUL1K/GrDLpgNgnLL3QmSfK+8BMvCFgHD6pfXxzzNtlKQAomC67
 mA60sAmrhhwpMB5xh5qSK/dexg==
X-Google-Smtp-Source: APXvYqwHHCmYt4g1tjEz+8VQjToCLep5eOD5gNsCFsOHdMS3mpGBGaHaTV3gLgODV9e4WtCdwoftHg==
X-Received: by 2002:a0c:8690:: with SMTP id 16mr55493929qvf.228.1563876659108; 
 Tue, 23 Jul 2019 03:10:59 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 z1sm22305728qkg.103.2019.07.23.03.10.56
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 23 Jul 2019 03:10:58 -0700 (PDT)
Date: Tue, 23 Jul 2019 06:10:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhangbo (Oscar)" <oscar.zhangbo@huawei.com>
Message-ID: <20190723061015-mutt-send-email-mst@kernel.org>
References: <0259E1C966E8C54AA93AA2B1240828E672DF3D45@dggeml509-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0259E1C966E8C54AA93AA2B1240828E672DF3D45@dggeml509-mbx.china.huawei.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.195
Subject: Re: [Qemu-devel] [PATCH v2] pcie: fix device unplug timeout
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

On Tue, Jul 23, 2019 at 09:33:43AM +0000, Zhangbo (Oscar) wrote:
> If the linux kernel only receives an ABP event during pcie unplug, it will sleep 5s 
> to expect a PDC event, which will cause device unplug timeout.
> 
> In the meanwhile, if the kernel only receives a PDC event during the unplug, it
> will wait for at least 1 second before checking card present as data link layer
> state changed (link down) event reported prior to presence detect changed
> (card is not present).
> 
> Therefore we can send both ABP and PDC events to the kernel in unplug process
> to avoid unplug timeout.
> 
> Signed-off-by: Li Mingwang <limingwang@huawei.com>
> Signed-off-by: Fang Ying <fangying1@huawei.com>
> Signed-off-by: Zhang Bo <oscar.zhangbo@huawei.com>

I responded on v1 before seeing v2. As there's no change to patch
or commit log, same comments apply.

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


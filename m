Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944B9C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 03:55:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60AAA20734
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 03:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kr90j6iq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60AAA20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfy12-0002cx-LJ
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 23:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jfy0N-00023s-Rj
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 23:54:23 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57208
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jfy0M-00063i-UI
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 23:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591070062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D++OBQza0KttrNjmccgiaBufVcdkIm/Ua6XWCxSXoN8=;
 b=Kr90j6iqxI/AK24IZT8fbBuWT5LPd24TMdde9/vTqEf5jduuEJAAIv2tHUqyIhZMEo0dWo
 rCv4gIL3y2G2ek9yFSXIbhD6MTaNnP2Imwsl+cIZS1WDz4JJrY2eKNpEhOYf8s/h/SRXgG
 DkNI4Y0tVW2ZS3Bf63DfaRE6LoNScvs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-AJdJpsQxMQaREGGPz4TLwg-1; Mon, 01 Jun 2020 23:54:20 -0400
X-MC-Unique: AJdJpsQxMQaREGGPz4TLwg-1
Received: by mail-wm1-f70.google.com with SMTP id t145so445682wmt.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 20:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=D++OBQza0KttrNjmccgiaBufVcdkIm/Ua6XWCxSXoN8=;
 b=funE+JaN2u56A1UUEiMx1hrWJVw/gEr/pnBKN1Lb0KyLVD9gf0wnOSR2YoIvdFKxQE
 3fHcsTBExkJ+ovLf5pu9gswfX8YsTgClX51XCHgd6qgHauaApErZNITq3L8avUJV+bj+
 joubdsZQmbpmLA8T434Y1IhhvMK3/FN9JPOWtXper5JNxRbBhy4svaCETyuf2n1yXOTP
 XAeXa/VDsySNum14erAyixO+BCJGMvleH7buEQJ4hlhdXAs7xAXljyjHdulY6MQPFPJ/
 5QqVGrWNfqrslz9rOdCY6mjelfOX/Z9R5MdTgKlAMq6Wvbf17YUp3gPOVOHINpIF2hH/
 qEbw==
X-Gm-Message-State: AOAM532VV+mwokOJawqoU2IecvgPpWg+CkyBkJPvn9SiliuL2NvjJb2q
 FhO2CWWlFO3j0vfp0ZbNPpBPRmzjRrV6549wtbHdiMH0SbccXUVxzOE397yNQ59MMCi9an5k+Og
 oU+DWzC2EmwXEIwo=
X-Received: by 2002:a05:600c:2259:: with SMTP id
 a25mr2301624wmm.32.1591070059469; 
 Mon, 01 Jun 2020 20:54:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRlF0V76LVv8Ca+AJHz5TAMUkJjfSRRCkgPioa3IJgzH/TjoIyzookqQ0a1Eg9sAP6xyEwRQ==
X-Received: by 2002:a05:600c:2259:: with SMTP id
 a25mr2301606wmm.32.1591070059237; 
 Mon, 01 Jun 2020 20:54:19 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
 by smtp.gmail.com with ESMTPSA id
 z206sm1677507wmg.30.2020.06.01.20.54.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 20:54:18 -0700 (PDT)
Date: Mon, 1 Jun 2020 23:54:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Julia Suvorova <jusual@redhat.com>
Subject: Re: [PATCH] hw/pci/pcie: Move hot plug capability check to pre_plug
 callback
Message-ID: <20200601235345-mutt-send-email-mst@kernel.org>
References: <20200601162934.842648-1-jusual@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200601162934.842648-1-jusual@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 22:14:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 01, 2020 at 06:29:34PM +0200, Julia Suvorova wrote:
> Check for hot plug capability earlier to avoid removing devices attached
> during the initialization process.
> 
> Run qemu with an unattached drive:
>   -drive file=$FILE,if=none,id=drive0 \
>   -device pcie-root-port,id=rp0,slot=3,bus=pcie.0,hotplug=off
> Hotplug a block device:
>   device_add virtio-blk-pci,id=blk0,drive=drive0,bus=rp0
> If hotplug fails on plug_cb, drive0 will be deleted.
> 
> Signed-off-by: Julia Suvorova <jusual@redhat.com>


Fixes: 0501e1aa1d32a6 ("hw/pci/pcie: Forbid hot-plug if it's disabled on the slot")

correct?


> ---
> Hard to say if it's a bug or generally acceptable behaviour, but seems like
> hotplug_handler_plug should never fail.
> 
>  hw/pci/pcie.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index f50e10b8fb..5b9c022d91 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -407,6 +407,17 @@ static void pcie_cap_slot_plug_common(PCIDevice *hotplug_dev, DeviceState *dev,
>  void pcie_cap_slot_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>                                 Error **errp)
>  {
> +    PCIDevice *hotplug_pdev = PCI_DEVICE(hotplug_dev);
> +    uint8_t *exp_cap = hotplug_pdev->config + hotplug_pdev->exp.exp_cap;
> +    uint32_t sltcap = pci_get_word(exp_cap + PCI_EXP_SLTCAP);
> +
> +    /* Check if hot-plug is disabled on the slot */
> +    if (dev->hotplugged && (sltcap & PCI_EXP_SLTCAP_HPC) == 0) {
> +        error_setg(errp, "Hot-plug failed: unsupported by the port device '%s'",
> +                         DEVICE(hotplug_pdev)->id);
> +        return;
> +    }
> +
>      pcie_cap_slot_plug_common(PCI_DEVICE(hotplug_dev), dev, errp);
>  }
>  
> @@ -415,7 +426,6 @@ void pcie_cap_slot_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>  {
>      PCIDevice *hotplug_pdev = PCI_DEVICE(hotplug_dev);
>      uint8_t *exp_cap = hotplug_pdev->config + hotplug_pdev->exp.exp_cap;
> -    uint32_t sltcap = pci_get_word(exp_cap + PCI_EXP_SLTCAP);
>      PCIDevice *pci_dev = PCI_DEVICE(dev);
>  
>      /* Don't send event when device is enabled during qemu machine creation:
> @@ -431,13 +441,6 @@ void pcie_cap_slot_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>          return;
>      }
>  
> -    /* Check if hot-plug is disabled on the slot */
> -    if ((sltcap & PCI_EXP_SLTCAP_HPC) == 0) {
> -        error_setg(errp, "Hot-plug failed: unsupported by the port device '%s'",
> -                         DEVICE(hotplug_pdev)->id);
> -        return;
> -    }
> -
>      /* To enable multifunction hot-plug, we just ensure the function
>       * 0 added last. When function 0 is added, we set the sltsta and
>       * inform OS via event notification.
> -- 
> 2.25.4



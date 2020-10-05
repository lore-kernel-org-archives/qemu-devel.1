Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2E0C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 10:10:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C87562078D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 10:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QAUJpMsB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C87562078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPNRY-000469-GK
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 06:10:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kPNQQ-0003E1-2K
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 06:08:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26666)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kPNQN-0004aS-91
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 06:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601892533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TdsU31Y6+2Ghjei+LWeknDEB4YNzgiAu4yaqLeuA/hU=;
 b=QAUJpMsB6TM9ohZTc1Isq1NZOpNV97f7IyVWWK0PvRKRLPwQ/WC4jGCdhEeTlTxnQdYFqI
 W88b2v2XSEMM3R4Y/BvtAfGR1KKXeIY9FpT9BDpizj+/yoU5XTYwEPvL+ubjJTOXL18W9X
 E9iqQcZ3OuvRfgaXgpHaWyLrwJtAtGQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-KF6SwmjmN2mD5bap2nlvzw-1; Mon, 05 Oct 2020 06:08:51 -0400
X-MC-Unique: KF6SwmjmN2mD5bap2nlvzw-1
Received: by mail-wr1-f70.google.com with SMTP id j7so3814299wro.14
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 03:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TdsU31Y6+2Ghjei+LWeknDEB4YNzgiAu4yaqLeuA/hU=;
 b=O4Tf6KPc/F+U31fieka4hz3TQXeoi6u3rEVxHjl4ycnMgvNFFXM8Gx/lgMRS1eoLxA
 t36jb6mP3H0WL2cs9VxZgeiH2RoN4GVOH/oiIUmngMjj5X/AJwHyrfBc21oJug/d1U+M
 TV/O11jK6r/CugGYflQi6ojHlPrNnWbxFRsjzrNosGVf8VMlCyWstjlGsTc7FjL9aIFC
 SCdGNArkbZXmr+qAad16W1yB7yYQ4Pj64tYYee1khS6rKtCIufkUVd8dfsfX4C10DCu+
 tm/G6Cm5aRJhiIizXsrYZw1QS60Eb5m/XOgnHzZbfm/byvheDPCAmOHsbZLsyzy0Y7Zi
 oFNw==
X-Gm-Message-State: AOAM533zsDfE9DgoDX4A7wEw1RkQDgA6AQ6wnf1AU+5t/fMZ85vtGJU0
 LftqTuzuS+ytCHOdjtO6reacZoh5KFB0iUtueO/wumbGX0+Ff/eHDlpH4Ohc2sVNxNCv0wXDyab
 mzyF0PaQ925Ofa10=
X-Received: by 2002:a05:600c:290c:: with SMTP id
 i12mr1473603wmd.119.1601892529558; 
 Mon, 05 Oct 2020 03:08:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGuI+z7AqfCdWC5xP+gkwi2xxMboOdvfYvAK9aQS+CE5orXPeQCVYec35BRD7dj3SBRbzE6g==
X-Received: by 2002:a05:600c:290c:: with SMTP id
 i12mr1473580wmd.119.1601892529348; 
 Mon, 05 Oct 2020 03:08:49 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id a5sm12469267wrp.37.2020.10.05.03.08.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 03:08:48 -0700 (PDT)
Date: Mon, 5 Oct 2020 06:08:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: andrew@daynix.com
Subject: Re: [PATCH v2 2/2] hw/virtio-pci Added AER capability.
Message-ID: <20201005060809-mutt-send-email-mst@kernel.org>
References: <20201005090140.90461-1-andrew@daynix.com>
 <20201005090140.90461-3-andrew@daynix.com>
MIME-Version: 1.0
In-Reply-To: <20201005090140.90461-3-andrew@daynix.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 01:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.745,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 05, 2020 at 12:01:40PM +0300, andrew@daynix.com wrote:
> From: Andrew <andrew@daynix.com>
> 
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1857668
> Added AER capability for virtio-pci devices.
> Also added property for devices, by default AER is enabled.


Looking at code it's disabled by default, isn't it?

> 
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> ---
>  hw/virtio/virtio-pci.c | 16 ++++++++++++++++
>  hw/virtio/virtio-pci.h |  4 ++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index ae60c1e249..e0a7936f9c 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1807,6 +1807,12 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
>           */
>          pci_set_word(pci_dev->config + pos + PCI_PM_PMC, 0x3);
>  
> +        if (proxy->flags & VIRTIO_PCI_FLAG_AER) {
> +            pcie_aer_init(pci_dev, PCI_ERR_VER, last_pcie_cap_offset,
> +                          PCI_ERR_SIZEOF, NULL);
> +            last_pcie_cap_offset += PCI_ERR_SIZEOF;
> +        }
> +
>          if (proxy->flags & VIRTIO_PCI_FLAG_INIT_DEVERR) {
>              /* Init error enabling flags */
>              pcie_cap_deverr_init(pci_dev);
> @@ -1848,7 +1854,15 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
>  
>  static void virtio_pci_exit(PCIDevice *pci_dev)
>  {
> +    VirtIOPCIProxy *proxy = VIRTIO_PCI(pci_dev);
> +    bool pcie_port = pci_bus_is_express(pci_get_bus(pci_dev)) &&
> +                     !pci_bus_is_root(pci_get_bus(pci_dev));
> +
>      msix_uninit_exclusive_bar(pci_dev);
> +    if (proxy->flags & VIRTIO_PCI_FLAG_AER && pcie_port &&
> +        pci_is_express(pci_dev)) {
> +        pcie_aer_exit(pci_dev);
> +    }
>  }
>  
>  static void virtio_pci_reset(DeviceState *qdev)
> @@ -1901,6 +1915,8 @@ static Property virtio_pci_properties[] = {
>                      VIRTIO_PCI_FLAG_INIT_PM_BIT, true),
>      DEFINE_PROP_BIT("x-pcie-flr-init", VirtIOPCIProxy, flags,
>                      VIRTIO_PCI_FLAG_INIT_FLR_BIT, true),
> +    DEFINE_PROP_BIT("aer", VirtIOPCIProxy, flags,
> +                    VIRTIO_PCI_FLAG_AER_BIT, false),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
> index 91096f0291..3986b4f0e3 100644
> --- a/hw/virtio/virtio-pci.h
> +++ b/hw/virtio/virtio-pci.h
> @@ -45,6 +45,7 @@ enum {
>      VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT,
>      VIRTIO_PCI_FLAG_INIT_PM_BIT,
>      VIRTIO_PCI_FLAG_INIT_FLR_BIT,
> +    VIRTIO_PCI_FLAG_AER_BIT,
>  };
>  
>  /* Need to activate work-arounds for buggy guests at vmstate load. */
> @@ -84,6 +85,9 @@ enum {
>  /* Init Function Level Reset capability */
>  #define VIRTIO_PCI_FLAG_INIT_FLR (1 << VIRTIO_PCI_FLAG_INIT_FLR_BIT)
>  
> +/* Advanced Error Reporting capability */
> +#define VIRTIO_PCI_FLAG_AER (1 << VIRTIO_PCI_FLAG_AER_BIT)
> +
>  typedef struct {
>      MSIMessage msg;
>      int virq;
> -- 
> 2.28.0



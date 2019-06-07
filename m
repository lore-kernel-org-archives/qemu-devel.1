Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B29C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 12:35:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0BFF208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 12:35:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0BFF208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50076 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZE5e-00066s-JL
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 08:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60620)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hZDK4-0004BO-RR
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 07:46:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hZDJz-0006yB-U9
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 07:46:15 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40329)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hZDJz-0006xG-Md
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 07:46:11 -0400
Received: by mail-qt1-f193.google.com with SMTP id a15so1813342qtn.7
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 04:46:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=85juaT/QTtDXAlpqsx7ncPXjy3Ja4G+zLiVr+S7ruSo=;
 b=Cf78M+o20CfXEfJD+fRDlPMDQVX8/9P7gMw5em8u872naCvoQ5L64JQBRK8gOotGBR
 oU2ZRpnnIM/Xqo//MzbbihfNIZkTbu/LkFrWrKEf+9CvTSTfY0po/qEzxgFX3k5RuHlb
 PK9HWeHM2NPRqTG2B4VdH2oS2sUV3baqw5NR+rCbkdiUUTrURs9Nq6YXT2xP6UZCJlc6
 sHYdVxjneBAgm2hmWgKdbwqgIQPv2QH63hiuxURJpIBVUvnY4fg+bWsRDnpDWiisrtHA
 h20NeHgWHJ29qgUpQ/ijaGNZKpfLVMbsVLjtJbrwGLZ3fq3F0caPGajWr6axIFURvLXD
 GjTw==
X-Gm-Message-State: APjAAAWErznviDBVO0bkF7rlULs+4xA11ftNlaUnucLbTDhemBuFIpce
 4zI+gs24pxoC2fWWpWXOTC1zcA==
X-Google-Smtp-Source: APXvYqxKLznHglUl0Nj03sa9/gQept+KVPePOLqEyODW/zwkB9+VqHxrXxTDhLU2EFVJZ4eSCPPz6Q==
X-Received: by 2002:ac8:7342:: with SMTP id q2mr4774497qtp.134.1559907971135; 
 Fri, 07 Jun 2019 04:46:11 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
 [100.0.197.103])
 by smtp.gmail.com with ESMTPSA id p1sm934591qti.83.2019.06.07.04.46.09
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 04:46:10 -0700 (PDT)
Date: Fri, 7 Jun 2019 07:46:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190607074602-mutt-send-email-mst@kernel.org>
References: <20190607083444.32175-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607083444.32175-1-kraxel@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.193
Subject: Re: [Qemu-devel] [PATCH] edid: flip the default to enabled
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 07, 2019 at 10:34:44AM +0200, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  include/hw/virtio/virtio-gpu.h | 2 +-
>  hw/core/machine.c              | 8 +++++++-
>  hw/display/bochs-display.c     | 2 +-
>  hw/display/vga-pci.c           | 4 ++--
>  4 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index 8ecac1987a7f..6dd57f2025ec 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -125,7 +125,7 @@ typedef struct VirtIOGPUBaseClass {
>  #define VIRTIO_GPU_BASE_PROPERTIES(_state, _conf)                       \
>      DEFINE_PROP_UINT32("max_outputs", _state, _conf.max_outputs, 1),    \
>      DEFINE_PROP_BIT("edid", _state, _conf.flags, \
> -                    VIRTIO_GPU_FLAG_EDID_ENABLED, false), \
> +                    VIRTIO_GPU_FLAG_EDID_ENABLED, true), \
>      DEFINE_PROP_UINT32("xres", _state, _conf.xres, 1024), \
>      DEFINE_PROP_UINT32("yres", _state, _conf.yres, 768)
>  
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index f1a0f45f9c83..84ebb8d24701 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -24,7 +24,13 @@
>  #include "hw/pci/pci.h"
>  #include "hw/mem/nvdimm.h"
>  
> -GlobalProperty hw_compat_4_0_1[] = {};
> +GlobalProperty hw_compat_4_0_1[] = {
> +    { "VGA",            "edid", "false" },
> +    { "secondary-vga",  "edid", "false" },
> +    { "bochs-display",  "edid", "false" },
> +    { "virtio-vga",     "edid", "false" },
> +    { "virtio-gpu-pci", "edid", "false" },
> +};
>  const size_t hw_compat_4_0_1_len = G_N_ELEMENTS(hw_compat_4_0_1);
>  
>  GlobalProperty hw_compat_4_0[] = {};
> diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
> index 3d439eb2407b..681a047d793c 100644
> --- a/hw/display/bochs-display.c
> +++ b/hw/display/bochs-display.c
> @@ -336,7 +336,7 @@ static void bochs_display_exit(PCIDevice *dev)
>  
>  static Property bochs_display_properties[] = {
>      DEFINE_PROP_SIZE("vgamem", BochsDisplayState, vgamem, 16 * MiB),
> -    DEFINE_PROP_BOOL("edid", BochsDisplayState, enable_edid, false),
> +    DEFINE_PROP_BOOL("edid", BochsDisplayState, enable_edid, true),
>      DEFINE_EDID_PROPERTIES(BochsDisplayState, edid_info),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
> index a17c96e703fe..3b76457ab077 100644
> --- a/hw/display/vga-pci.c
> +++ b/hw/display/vga-pci.c
> @@ -338,7 +338,7 @@ static Property vga_pci_properties[] = {
>      DEFINE_PROP_BIT("qemu-extended-regs",
>                      PCIVGAState, flags, PCI_VGA_FLAG_ENABLE_QEXT, true),
>      DEFINE_PROP_BIT("edid",
> -                    PCIVGAState, flags, PCI_VGA_FLAG_ENABLE_EDID, false),
> +                    PCIVGAState, flags, PCI_VGA_FLAG_ENABLE_EDID, true),
>      DEFINE_EDID_PROPERTIES(PCIVGAState, edid_info),
>      DEFINE_PROP_BOOL("global-vmstate", PCIVGAState, vga.global_vmstate, false),
>      DEFINE_PROP_END_OF_LIST(),
> @@ -349,7 +349,7 @@ static Property secondary_pci_properties[] = {
>      DEFINE_PROP_BIT("qemu-extended-regs",
>                      PCIVGAState, flags, PCI_VGA_FLAG_ENABLE_QEXT, true),
>      DEFINE_PROP_BIT("edid",
> -                    PCIVGAState, flags, PCI_VGA_FLAG_ENABLE_EDID, false),
> +                    PCIVGAState, flags, PCI_VGA_FLAG_ENABLE_EDID, true),
>      DEFINE_EDID_PROPERTIES(PCIVGAState, edid_info),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> -- 
> 2.18.1


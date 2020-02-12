Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A768C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 12:38:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1658B20714
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 12:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="epN6vtEk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1658B20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1rHt-0008N5-8y
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 07:38:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58258)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1j1rGj-000739-I0
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 07:37:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1j1rGi-0005JM-Eg
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 07:37:29 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20329
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1j1rGi-0005Iy-A3
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 07:37:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581511048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ch0Os69EavHi56PkV+gk7anWeI9LNbnZDQVQ0oXLcuM=;
 b=epN6vtEkNekzoCBBQVoMhEjsy2srOA1rxlKCX1VTxTdzxFBEhut+i2riLwMEJa/TbjHnXH
 2RrHeES9WrtVTZL0r2MzU3z5SmUgpFh7IspLrlHuFVr8rkKvzyaOIdsj0unJ+fdgiqINAK
 VuD5EQXDBHZbGn0u/lVlMT+dDBidrMA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-pi0NvwoVMJCj4jthK_4Jjg-1; Wed, 12 Feb 2020 07:37:24 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E027F18C8C01;
 Wed, 12 Feb 2020 12:37:22 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B35595C102;
 Wed, 12 Feb 2020 12:37:20 +0000 (UTC)
Message-ID: <dde54d12c2bb55c29ab7d19ab2cfc0dbf37ae1f0.camel@redhat.com>
Subject: Re: [PATCH v5 24/26] nvme: change controller pci id
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <k.jensen@samsung.com>, qemu-block@nongnu.org
Date: Wed, 12 Feb 2020 14:37:09 +0200
In-Reply-To: <20200204095208.269131-25-k.jensen@samsung.com>
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095231eucas1p21019b1d857fcda9d67950e7d01de6b6a@eucas1p2.samsung.com>
 <20200204095208.269131-25-k.jensen@samsung.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: pi0NvwoVMJCj4jthK_4Jjg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-02-04 at 10:52 +0100, Klaus Jensen wrote:
> There are two reasons for changing this:
> 
>   1. The nvme device currently uses an internal Intel device id.
> 
>   2. Since commits "nvme: fix write zeroes offset and count" and "nvme:
>      support multiple namespaces" the controller device no longer has
>      the quirks that the Linux kernel think it has.
> 
>      As the quirks are applied based on pci vendor and device id, change
>      them to get rid of the quirks.
> 
> To keep backward compatibility, add a new 'x-use-intel-id' parameter to
> the nvme device to force use of the Intel vendor and device id. This is
> off by default but add a compat property to set this for machines 4.2
> and older.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/block/nvme.c   | 13 +++++++++----
>  hw/block/nvme.h   |  4 +++-
>  hw/core/machine.c |  1 +
>  3 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 3a377bc56734..bdef53a590b0 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -2467,8 +2467,15 @@ static void nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev)
>  
>      pci_conf[PCI_INTERRUPT_PIN] = 1;
>      pci_config_set_prog_interface(pci_conf, 0x2);
> -    pci_config_set_vendor_id(pci_conf, PCI_VENDOR_ID_INTEL);
> -    pci_config_set_device_id(pci_conf, 0x5845);
> +
> +    if (n->params.use_intel_id) {
> +        pci_config_set_vendor_id(pci_conf, PCI_VENDOR_ID_INTEL);
> +        pci_config_set_device_id(pci_conf, 0x5846);
> +    } else {
> +        pci_config_set_vendor_id(pci_conf, PCI_VENDOR_ID_REDHAT);
> +        pci_config_set_device_id(pci_conf, PCI_DEVICE_ID_REDHAT_NVME);
> +    }
> +
>      pci_config_set_class(pci_conf, PCI_CLASS_STORAGE_EXPRESS);
>      pcie_endpoint_cap_init(pci_dev, 0x80);
>  
> @@ -2638,8 +2645,6 @@ static void nvme_class_init(ObjectClass *oc, void *data)
>      pc->realize = nvme_realize;
>      pc->exit = nvme_exit;
>      pc->class_id = PCI_CLASS_STORAGE_EXPRESS;
> -    pc->vendor_id = PCI_VENDOR_ID_INTEL;
> -    pc->device_id = 0x5845;
>      pc->revision = 2;
>  
>      set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index c3cef0f024da..6b584f53ed64 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -12,7 +12,8 @@
>      DEFINE_PROP_UINT32("num_queues", _state, _props.num_queues, 64), \
>      DEFINE_PROP_UINT8("aerl", _state, _props.aerl, 3), \
>      DEFINE_PROP_UINT32("aer_max_queued", _state, _props.aer_max_queued, 64), \
> -    DEFINE_PROP_UINT8("mdts", _state, _props.mdts, 7)
> +    DEFINE_PROP_UINT8("mdts", _state, _props.mdts, 7), \
> +    DEFINE_PROP_BOOL("x-use-intel-id", _state, _props.use_intel_id, false)
>  
>  typedef struct NvmeParams {
>      char     *serial;
> @@ -21,6 +22,7 @@ typedef struct NvmeParams {
>      uint8_t  aerl;
>      uint32_t aer_max_queued;
>      uint8_t  mdts;
> +    bool     use_intel_id;
>  } NvmeParams;
>  
>  typedef struct NvmeAsyncEvent {
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 3e288bfceb7f..984412d98c9d 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -34,6 +34,7 @@ GlobalProperty hw_compat_4_2[] = {
>      { "vhost-blk-device", "seg_max_adjust", "off"},
>      { "usb-host", "suppress-remote-wake", "off" },
>      { "usb-redir", "suppress-remote-wake", "off" },
> +    { "nvme", "x-use-intel-id", "on"},
>  };
>  const size_t hw_compat_4_2_len = G_N_ELEMENTS(hw_compat_4_2);
>  

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky



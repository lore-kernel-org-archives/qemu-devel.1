Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEEEC5517A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 19:48:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F05D206D8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 19:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E8lF79Fs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F05D206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcD9Z-0006RI-Cl
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 14:48:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kcD8O-00058E-Bu
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 14:47:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31205)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kcD8M-0001vM-24
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 14:47:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604951240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZcvZt/j+SZ0NBmKbtTu+OpgQ9tIRgjGkxHGXixoaLjQ=;
 b=E8lF79FsabdNaSAYsVRFRHLylpstUc4HM1Dy7GfOlDU7fY7u0L2kQwB71RSgwuh/ls4Tlf
 ZFv6YGElzY6WUkKae9vHG56hGTQKszbE7aZ/qIKE2BeWq/fRkSGc5wtQXJOp9MXSIKmaP+
 ckAj8CLvfSPXP03O3Nw5C46dPKa0OEA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-DCb5CntuOBOfXDW_1PKqaA-1; Mon, 09 Nov 2020 14:47:16 -0500
X-MC-Unique: DCb5CntuOBOfXDW_1PKqaA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD7CE5F9DB;
 Mon,  9 Nov 2020 19:47:14 +0000 (UTC)
Received: from [10.36.114.37] (ovpn-114-37.ams2.redhat.com [10.36.114.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6AB8B5D9CC;
 Mon,  9 Nov 2020 19:47:10 +0000 (UTC)
Subject: Re: [PATCH v2] hw/arm/virt enable support for virtio-mem
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org
References: <20201105174311.566751-1-Jonathan.Cameron@huawei.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <5b1dff01-7e6b-78d2-d55a-20c0617c3076@redhat.com>
Date: Mon, 9 Nov 2020 20:47:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201105174311.566751-1-Jonathan.Cameron@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, linuxarm@huawei.com,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05.11.20 18:43, Jonathan Cameron wrote:
> Basically a cut and paste job from the x86 support with the exception of
> needing a larger block size as the Memory Block Size (MIN_SECTION_SIZE)
> on ARM64 in Linux is 1G.
> 
> Tested:
> * In full emulation and with KVM on an arm64 server.
> * cold and hotplug for the virtio-mem-pci device.
> * Wide range of memory sizes, added at creation and later.
> * Fairly basic memory usage of memory added.  Seems to function as normal.
> * NUMA setup with virtio-mem-pci devices on each node.
> * Simple migration test.
> 
> Related kernel patch just enables the Kconfig item for ARM64 as an
> alternative to x86 in drivers/virtio/Kconfig
> 
> The original patches from David Hildenbrand stated that he thought it should
> work for ARM64 but it wasn't enabled in the kernel [1]
> It appears he was correct and everything 'just works'.
> 
> The build system related stuff is intended to ensure virtio-mem support is
> not built for arm32 (build will fail due no defined block size).
> If there is a more elegant way to do this, please point me in the right
> direction.

You might be aware of https://virtio-mem.gitlab.io/developer-guide.html 
and the "issue" with 64k base pages - 512MB granularity. Similar as the 
question from Auger, have you tried running arm64 with differing page 
sizes in host/guest?

With recent kernels, you can use "memhp_default_state=online_movable" on 
the kernel cmdline to make memory unplug more likely to succeed - 
especially with 64k base pages. You just have to be sure to not hotplug 
"too much memory" to a VM.


I had my prototype living at

git@github.com:davidhildenbrand/qemu.git / virtio-mem-arm64

which looks very similar to your patch. That is good :)

[...]

>   static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>                                           DeviceState *dev, Error **errp)
>   {
> @@ -2336,6 +2389,9 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>       if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>           virt_memory_plug(hotplug_dev, dev, errp);
>       }
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
> +        virt_virtio_md_pci_plug(hotplug_dev, dev, errp);
> +    }

These better all be "else if".

>       if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
>           PCIDevice *pdev = PCI_DEVICE(dev);
>   
> @@ -2363,6 +2419,11 @@ static void virt_dimm_unplug_request(HotplugHandler *hotplug_dev,
>           goto out;
>       }
>   
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
> +        error_setg(&local_err,
> +                   "virtio-mem based memory devices cannot be unplugged.");
> +        goto out;
> +    }

This should go into virt_machine_device_unplug_request_cb() instead, no?
[...]


-- 
Thanks,

David / dhildenb



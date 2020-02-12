Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5ACC35242
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 02:59:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3D7D206DB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 02:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3D7D206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1iEt-00080S-UI
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 21:58:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39102)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jing2.liu@linux.intel.com>) id 1j1iEG-0007Gt-6N
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 21:58:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jing2.liu@linux.intel.com>) id 1j1iEE-00087I-PW
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 21:58:20 -0500
Received: from mga03.intel.com ([134.134.136.65]:37031)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jing2.liu@linux.intel.com>)
 id 1j1iEE-00082I-GG
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 21:58:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Feb 2020 18:58:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; d="scan'208";a="281114068"
Received: from liujing-mobl1.ccr.corp.intel.com (HELO [10.254.46.75])
 ([10.254.46.75])
 by FMSMGA003.fm.intel.com with ESMTP; 11 Feb 2020 18:58:14 -0800
Subject: Re: [virtio-dev] Re: [PATCH v2 2/5] virtio-mmio: refactor common
 functionality
To: "Michael S. Tsirkin" <mst@redhat.com>, Zha Bin <zhabin@linux.alibaba.com>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <0268807dc26ecdf5620de9000758d05ca0b21f3f.1581305609.git.zhabin@linux.alibaba.com>
 <20200211061758-mutt-send-email-mst@kernel.org>
From: "Liu, Jing2" <jing2.liu@linux.intel.com>
Message-ID: <787bac48-3fd0-316a-a99a-8c93154dc8e2@linux.intel.com>
Date: Wed, 12 Feb 2020 10:58:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200211061758-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.65
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
Cc: virtio-dev@lists.oasis-open.org, slp@redhat.com, jasowang@redhat.com,
 linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
 chao.p.peng@linux.intel.com, gerry@linux.alibaba.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2/11/2020 7:19 PM, Michael S. Tsirkin wrote:
> On Mon, Feb 10, 2020 at 05:05:18PM +0800, Zha Bin wrote:
>> From: Liu Jiang <gerry@linux.alibaba.com>
>>
>> Common functionality is refactored into virtio_mmio_common.h
>> in order to MSI support in later patch set.
>>
>> Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
>> Co-developed-by: Zha Bin <zhabin@linux.alibaba.com>
>> Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
>> Co-developed-by: Jing Liu <jing2.liu@linux.intel.com>
>> Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
>> Co-developed-by: Chao Peng <chao.p.peng@linux.intel.com>
>> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> What does this proliferation of header files achieve?
> common with what?

We're considering that the virtio mmio structure is useful for virtio 
mmio msi file so refactor out.

e.g. to get the base of virtio_mmio_device from struct msi_desc *desc.

Jing


>> ---
>>   drivers/virtio/virtio_mmio.c        | 21 +--------------------
>>   drivers/virtio/virtio_mmio_common.h | 31 +++++++++++++++++++++++++++++++
>>   2 files changed, 32 insertions(+), 20 deletions(-)
>>   create mode 100644 drivers/virtio/virtio_mmio_common.h
>>
>> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
>> index 1733ab97..41e1c93 100644
>> --- a/drivers/virtio/virtio_mmio.c
>> +++ b/drivers/virtio/virtio_mmio.c
>> @@ -61,13 +61,12 @@
>>   #include <linux/io.h>
>>   #include <linux/list.h>
>>   #include <linux/module.h>
>> -#include <linux/platform_device.h>
>>   #include <linux/slab.h>
>>   #include <linux/spinlock.h>
>> -#include <linux/virtio.h>
>>   #include <linux/virtio_config.h>
>>   #include <uapi/linux/virtio_mmio.h>
>>   #include <linux/virtio_ring.h>
>> +#include "virtio_mmio_common.h"
>>   
>>   
>>   
>> @@ -77,24 +76,6 @@
>>   
>>   
>>   
>> -#define to_virtio_mmio_device(_plat_dev) \
>> -	container_of(_plat_dev, struct virtio_mmio_device, vdev)
>> -
>> -struct virtio_mmio_device {
>> -	struct virtio_device vdev;
>> -	struct platform_device *pdev;
>> -
>> -	void __iomem *base;
>> -	unsigned long version;
>> -
>> -	/* a list of queues so we can dispatch IRQs */
>> -	spinlock_t lock;
>> -	struct list_head virtqueues;
>> -
>> -	unsigned short notify_base;
>> -	unsigned short notify_multiplier;
>> -};
>> -
>>   struct virtio_mmio_vq_info {
>>   	/* the actual virtqueue */
>>   	struct virtqueue *vq;
>> diff --git a/drivers/virtio/virtio_mmio_common.h b/drivers/virtio/virtio_mmio_common.h
>> new file mode 100644
>> index 0000000..90cb304
>> --- /dev/null
>> +++ b/drivers/virtio/virtio_mmio_common.h
>> @@ -0,0 +1,31 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +#ifndef _DRIVERS_VIRTIO_VIRTIO_MMIO_COMMON_H
>> +#define _DRIVERS_VIRTIO_VIRTIO_MMIO_COMMON_H
>> +/*
>> + * Virtio MMIO driver - common functionality for all device versions
>> + *
>> + * This module allows virtio devices to be used over a memory-mapped device.
>> + */
>> +
>> +#include <linux/platform_device.h>
>> +#include <linux/virtio.h>
>> +
>> +#define to_virtio_mmio_device(_plat_dev) \
>> +	container_of(_plat_dev, struct virtio_mmio_device, vdev)
>> +
>> +struct virtio_mmio_device {
>> +	struct virtio_device vdev;
>> +	struct platform_device *pdev;
>> +
>> +	void __iomem *base;
>> +	unsigned long version;
>> +
>> +	/* a list of queues so we can dispatch IRQs */
>> +	spinlock_t lock;
>> +	struct list_head virtqueues;
>> +
>> +	unsigned short notify_base;
>> +	unsigned short notify_multiplier;
>> +};
>> +
>> +#endif
>> -- 
>> 1.8.3.1
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>


Return-Path: <SRS0=sqIQ=4K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5872C35671
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 07:57:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71A84208C3
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 07:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71A84208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5Pfd-0001PF-N9
	for qemu-devel@archiver.kernel.org; Sat, 22 Feb 2020 02:57:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56041)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1j5Pf0-0000ra-Tg
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 02:57:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1j5Pf0-0004N2-16
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 02:57:14 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3240 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1j5Pex-00049M-F0; Sat, 22 Feb 2020 02:57:11 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 250A63F1B51777DBFC9D;
 Sat, 22 Feb 2020 15:57:01 +0800 (CST)
Received: from [10.184.39.213] (10.184.39.213) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.439.0; Sat, 22 Feb
 2020 15:56:51 +0800
Subject: Re: [PATCH 2/2] vhost-use-blk: convert to new virtio_delete_queue
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20200213012807.45552-1-pannengyuan@huawei.com>
 <20200213012807.45552-3-pannengyuan@huawei.com>
 <20200221113118.GG1484511@stefanha-x1.localdomain>
From: Pan Nengyuan <pannengyuan@huawei.com>
Message-ID: <be4bd36a-9ada-bc66-007a-9583d5b04108@huawei.com>
Date: Sat, 22 Feb 2020 15:56:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200221113118.GG1484511@stefanha-x1.localdomain>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.39.213]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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
Cc: kwolf@redhat.com, zhang.zhanghailiang@huawei.com, qemu-block@nongnu.org,
 mst@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2/21/2020 7:31 PM, Stefan Hajnoczi wrote:
> On Thu, Feb 13, 2020 at 09:28:07AM +0800, pannengyuan@huawei.com wrote:
>> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
>> index 2eba8b9db0..ed6a5cc03b 100644
>> --- a/hw/block/vhost-user-blk.c
>> +++ b/hw/block/vhost-user-blk.c
>> @@ -420,9 +420,10 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
>>      virtio_init(vdev, "virtio-blk", VIRTIO_ID_BLOCK,
>>                  sizeof(struct virtio_blk_config));
>>  
>> +    s->virtqs = g_new0(VirtQueue *, s->num_queues);
> 
> Minor point, up to you if you want to change it: the array is fully
> initialized by the for loop in the next line.  There is no need to clear
> the memory first:
> 
> s/g_new0/g_new/
OK, it's fine, I will change it.

Thanks.

> 
>> diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-user-blk.h
>> index 108bfadeeb..f68911f6f0 100644
>> --- a/include/hw/virtio/vhost-user-blk.h
>> +++ b/include/hw/virtio/vhost-user-blk.h
>> @@ -37,6 +37,7 @@ typedef struct VHostUserBlk {
>>      struct vhost_inflight *inflight;
>>      VhostUserState vhost_user;
>>      struct vhost_virtqueue *vqs;
>> +    VirtQueue **virtqs;
> 
> Both vqs and virtqs exist and are easily confused.  Please rename vqs to
> vhost_vqs.

OK, I will do it.

Thanks.

> 


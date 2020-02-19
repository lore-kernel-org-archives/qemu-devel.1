Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBC9C34022
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 07:53:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 703D421D56
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 07:53:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 703D421D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4KB1-00083V-Ie
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 02:53:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52683)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1j4KAR-0007bo-Bf
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 02:53:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1j4KAQ-0002ef-39
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 02:53:11 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:42462 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1j4KAP-0002aW-Mx
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 02:53:10 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 4B5697F6FA75A1B453D5;
 Wed, 19 Feb 2020 15:53:01 +0800 (CST)
Received: from [10.184.39.213] (10.184.39.213) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 19 Feb
 2020 15:52:54 +0800
Subject: Re: [PATCH v2] scsi-disk: define props in scsi_block_disk to avoid
 memleaks
To: Paolo Bonzini <pbonzini@redhat.com>, <fam@euphon.net>
References: <20200114091634.60856-1-pannengyuan@huawei.com>
 <5e875870-449e-3f65-60bc-79ba5190d2fb@redhat.com>
From: Pan Nengyuan <pannengyuan@huawei.com>
Message-ID: <a7f349b8-a06b-4eee-67a2-42f082f8c081@huawei.com>
Date: Wed, 19 Feb 2020 15:52:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <5e875870-449e-3f65-60bc-79ba5190d2fb@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.39.213]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
Cc: Euler Robot <euler.robot@huawei.com>, qemu-devel@nongnu.org,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 1/22/2020 1:05 AM, Paolo Bonzini wrote:
> On 14/01/20 10:16, pannengyuan@huawei.com wrote:
>> From: Pan Nengyuan <pannengyuan@huawei.com>
>>
>> scsi_block_realize() use scsi_realize() to init some props, but
>> these props is not defined in scsi_block_disk_properties, so they will
>> not be freed.
>>
>> This patch defines these prop in scsi_block_disk_properties and aslo
>> calls scsi_unrealize to avoid memleaks, the leak stack as
>> follow(it's easy to reproduce by attaching/detaching scsi-block-disks):
>>
>> =================================================================
>> ==qemu-system-x86_64==32195==ERROR: LeakSanitizer: detected memory leaks
>>
>> Direct leak of 57 byte(s) in 3 object(s) allocated from:
>>   #0 0x7f19f8bed768 (/lib64/libasan.so.5+0xef768)  ??:?
>>   #1 0x7f19f64d9445 (/lib64/libglib-2.0.so.0+0x52445)  ??:?
>>   #2 0x7f19f64f2d92 (/lib64/libglib-2.0.so.0+0x6bd92)  ??:?
>>   #3 0x55975366e596 (qemu-system-x86_64+0x35c0596)  /mnt/sdb/qemu/hw/scsi/scsi-disk.c:2399
>>   #4 0x559753671201 (emu-system-x86_64+0x35c3201)  /mnt/sdb/qemu/hw/scsi/scsi-disk.c:2681
>>   #5 0x559753687e3e (qemu-system-x86_64+0x35d9e3e)  /mnt/sdb/qemu/hw/scsi/scsi-bus.c:58
>>   #6 0x55975368ac44 (qemu-system-x86_64+0x35dcc44)  /mnt/sdb/qemu/hw/scsi/scsi-bus.c:216
>>   #7 0x5597532a7840 (qemu-system-x86_64+0x31f9840)  /mnt/sdb/qemu/hw/core/qdev.c:876
>>
>> Direct leak of 15 byte(s) in 3 object(s) allocated from:
>>   #0 0x7f19f8bed768 (/lib64/libasan.so.5+0xef768)  ??:?
>>   #1 0x7f19f64d9445 (/lib64/libglib-2.0.so.0+0x52445)  ??:?
>>   #2 0x7f19f64f2d92 (/lib64/libglib-2.0.so.0+0x6bd92)  ??:?
>>   #3 0x55975366e06f (qemu-system-x86_64+0x35c006f)  /mnt/sdb/qemu/hw/scsi/scsi-disk.c:2388
>>   #4 0x559753671201 (qemu-system-x86_64+0x35c3201)  /mnt/sdb/qemu/hw/scsi/scsi-disk.c:2681
>>   #5 0x559753687e3e (qemu-system-x86_64+0x35d9e3e)  /mnt/sdb/qemu/hw/scsi/scsi-bus.c:58
>>   #6 0x55975368ac44 (qemu-system-x86_64+0x35dcc44)  /mnt/sdb/qemu/hw/scsi/scsi-bus.c:216
>>
>> @@ -3079,9 +3080,8 @@ static const TypeInfo scsi_cd_info = {
>>  
>>  #ifdef __linux__
>>  static Property scsi_block_properties[] = {
>> -    DEFINE_BLOCK_ERROR_PROPERTIES(SCSIDiskState, qdev.conf),         \
>> +    DEFINE_SCSI_DISK_PROPERTIES(),.
> The properties defined there shouldn't apply to scsi-block.
> 
> Can you explain what exactly is being leaked?

Ohh, I'm sorry, I missed this email and reply it so late.

When we attach a scsi-block disk, the props(version/vender/device_id) are malloced in scsi_realize() which it's called by scsi_block_realize(),
but we don't define these props in scsi_block_properties. So these props will not be released when we detach the scsi-block disk.

This patch will reuse scsi_disk_properties to define those props in scsi_block_properties to fix it.
Similarly to scsi_hd, this patch aslo set unrealize to call del_boot_device_lchs().

Thanks.

> 
> Paolo
> 
> .
> 


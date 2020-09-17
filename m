Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A09C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 14:10:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25AFF206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 14:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25AFF206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIubo-0003he-36
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 10:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1kIuNl-0002b7-RZ; Thu, 17 Sep 2020 09:55:29 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52788 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1kIuNh-0008J1-2N; Thu, 17 Sep 2020 09:55:27 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 938F63F47763929775EE;
 Thu, 17 Sep 2020 21:55:14 +0800 (CST)
Received: from [10.174.185.104] (10.174.185.104) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Thu, 17 Sep 2020 21:55:05 +0800
Subject: Re: [RFC PATCH 04/12] device_tree: add qemu_fdt_add_path
To: Andrew Jones <drjones@redhat.com>
References: <20200917032033.2020-1-fangying1@huawei.com>
 <20200917032033.2020-5-fangying1@huawei.com>
 <20200917081239.bdfhkofodqvhg3i6@kamzik.brq.redhat.com>
From: Ying Fang <fangying1@huawei.com>
Message-ID: <75888154-dec6-3a70-7eb8-3cb1a13b91a6@huawei.com>
Date: Thu, 17 Sep 2020 21:55:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200917081239.bdfhkofodqvhg3i6@kamzik.brq.redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.104]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=fangying1@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 08:23:09
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, zhang.zhanghailiang@huawei.com,
 Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, alex.chen@huawei.com,
 shannon.zhaosl@gmail.com, qemu-arm@nongnu.org, alistair.francis@wdc.com,
 imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/17/2020 4:12 PM, Andrew Jones wrote:
> On Thu, Sep 17, 2020 at 11:20:25AM +0800, Ying Fang wrote:
>> From: Andrew Jones <drjones@redhat.com>
>>
>> qemu_fdt_add_path works like qemu_fdt_add_subnode, except it
>> also recursively adds any missing parent nodes.
>>
>> Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
>> Cc: Alexander Graf <agraf@suse.de>
>> Signed-off-by: Andrew Jones <drjones@redhat.com>
>> ---
>>   device_tree.c                | 24 ++++++++++++++++++++++++
>>   include/sysemu/device_tree.h |  1 +
>>   2 files changed, 25 insertions(+)
>>
>> diff --git a/device_tree.c b/device_tree.c
>> index b335dae707..1854be3a02 100644
>> --- a/device_tree.c
>> +++ b/device_tree.c
>> @@ -524,6 +524,30 @@ int qemu_fdt_add_subnode(void *fdt, const char *name)
>>       return retval;
>>   }
>>   
>> +int qemu_fdt_add_path(void *fdt, const char *path)
>> +{
>> +    char *parent;
>> +    int offset;
>> +
>> +    offset = fdt_path_offset(fdt, path);
>> +    if (offset < 0 && offset != -FDT_ERR_NOTFOUND) {
>> +        error_report("%s Couldn't find node %s: %s", __func__, path,
>> +                     fdt_strerror(offset));
>> +        exit(1);
>> +    }
>> +
>> +    if (offset != -FDT_ERR_NOTFOUND) {
>> +        return offset;
>> +    }
>> +
>> +    parent = g_strdup(path);
>> +    strrchr(parent, '/')[0] = '\0';
>> +    qemu_fdt_add_path(fdt, parent);
>> +    g_free(parent);
>> +
>> +    return qemu_fdt_add_subnode(fdt, path);
>> +}
> 
> Igor didn't like the recursion when I posted this before so I changed
> it when doing the refresh[*] that I gave to Salil Mehta. Salil also
> works for Huawei, are you guys not working together?
> 
> [*] https://github.com/rhdrjones/qemu/commits/virt-cpu-topology-refresh

Thanks for the sync. I'll look into it. I did not know about the refresh
and the effort Salil Mehta has made on this. We are not in the same dept 
and work for different projects.

Thanks Ying.
> 
> Thanks,
> drew
> 
>> +
>>   void qemu_fdt_dumpdtb(void *fdt, int size)
>>   {
>>       const char *dumpdtb = qemu_opt_get(qemu_get_machine_opts(), "dumpdtb");
>> diff --git a/include/sysemu/device_tree.h b/include/sysemu/device_tree.h
>> index 982c89345f..15fb98af98 100644
>> --- a/include/sysemu/device_tree.h
>> +++ b/include/sysemu/device_tree.h
>> @@ -104,6 +104,7 @@ uint32_t qemu_fdt_get_phandle(void *fdt, const char *path);
>>   uint32_t qemu_fdt_alloc_phandle(void *fdt);
>>   int qemu_fdt_nop_node(void *fdt, const char *node_path);
>>   int qemu_fdt_add_subnode(void *fdt, const char *name);
>> +int qemu_fdt_add_path(void *fdt, const char *path);
>>   
>>   #define qemu_fdt_setprop_cells(fdt, node_path, property, ...)                 \
>>       do {                                                                      \
>> -- 
>> 2.23.0
>>
>>
> 
> .
> 


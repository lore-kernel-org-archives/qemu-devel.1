Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FEEC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 12:09:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E1AC20772
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 12:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E1AC20772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfjGD-0005z9-CU
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 08:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1jfjEX-0004oJ-4Z; Mon, 01 Jun 2020 08:08:01 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3772 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1jfjEV-0005cP-MF; Mon, 01 Jun 2020 08:08:00 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id BDFE388206165D7DEA85;
 Mon,  1 Jun 2020 20:07:49 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.233) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0;
 Mon, 1 Jun 2020 20:07:38 +0800
Subject: Re: About the kvm-no-adjvtime CPU property
To: Andrew Jones <drjones@redhat.com>
References: <b4389848-10fd-a906-9901-d1d354ce4842@huawei.com>
 <20200601080718.jul5r4qebpeieyfl@kamzik.brq.redhat.com>
From: Ying Fang <fangying1@huawei.com>
Message-ID: <3d8729db-067c-31f9-dd69-02a218f1b53e@huawei.com>
Date: Mon, 1 Jun 2020 20:07:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200601080718.jul5r4qebpeieyfl@kamzik.brq.redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.222.233]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191; envelope-from=fangying1@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 08:07:50
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, wu.wubin@huawei.com,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/6/1 16:07, Andrew Jones wrote:
> On Sat, May 30, 2020 at 04:56:26PM +0800, Ying Fang wrote:
>> About the kvm-no-adjvtime CPU property
>>
>> Hi Andrew,
>> To adjust virutal time, a new kvm cpu property kvm-no-adjvtime
>> was introduced to 5.0 virt machine types. However the cpu
>> property was enabled only for host-passthrough and max cpu model.
>> As for other cpu model like cortex-a57, cortex-a53, cortex-a72,
>> this kvm-adjvtime is not enabled by default, which means the
>> virutal time can not be adjust for them.
>>
>> Here, for example, if VM is configured with kvm enabled:
>>
>>    <cpu mode='custom' match='exact' check='partial'>
>>      <model fallback='allow'>cortex-a72</model>
>>      <topology sockets='2' dies='1' cores='2' threads='1'/>
>>      <numa>
>>        <cell id='0' cpus='0-1' memory='16777216' unit='KiB'/>
>>        <cell id='1' cpus='2-3' memory='16777216' unit='KiB'/>
>>      </numa>
>>    </cpu>
>>
>> We cannot adjust virtual time even if 5.0 virt machine is used.
>> So i'd like to add it to other cpu model, do you have any
>> suggestions here ?
>>
>>
> 
> Hi Fang,
> 
> The cpu feature only requires kvm.  If a cpu model may be used with kvm,
> then the feature can be allowed to be used with the model.  What I find
> interesting is that the cpu model is being used with kvm instead of 'host'
> or 'max'.  Can you explain the reasons for that?  Currently, when using
yes，the cpu model is indeed used with kvm.

There is a situation where the host cpu model is Cortex-A72 and
a 'custom' cpu mode is used to keep insrtuction set compatible between
the source and destination host machine when doing live migration.
So the host physical machine cpu model is Cortex-A72 but
host-passthrough model is mode used here.

> kvm, the guest will always effectively get 'host' anyway, even when a
> model is provided. Indeed, for a model to work, kvm requires it to exactly
> match the host cpu and even then the ID registers are passed through from
> the host CPU, not taken from QEMU's model.
In the above scenario, the cpu mode is Cortex-A72 but maybe only a 
subset of cpu feature is presented to the guest.

Since the cpu model is not 'host' here, the kvm-adjvtime is not enabled 
by default. The guest virtual time will not be adjusted.

> 
> Thanks,
> drew
> 
> 
> .
> 



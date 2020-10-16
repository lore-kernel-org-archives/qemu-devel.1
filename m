Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC869C43457
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 09:41:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21ECE20720
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 09:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21ECE20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTMEx-00061m-3K
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 05:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1kTMDp-0004x0-Tz; Fri, 16 Oct 2020 05:40:25 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33812 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1kTMDn-0006ey-3l; Fri, 16 Oct 2020 05:40:25 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 7FD254A7224686EE586D;
 Fri, 16 Oct 2020 17:40:12 +0800 (CST)
Received: from [10.174.186.67] (10.174.186.67) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Fri, 16 Oct 2020 17:40:03 +0800
Subject: Re: [RFC PATCH 00/12] hw/arm/virt: Introduce cpu and cache topology
 support
To: Andrew Jones <drjones@redhat.com>
References: <20200917032033.2020-1-fangying1@huawei.com>
 <678F3D1BB717D949B966B68EAEB446ED49E0BB94@dggemm526-mbx.china.huawei.com>
 <20201013180840.yzkncsw34xvwtoll@kamzik.brq.redhat.com>
 <7491ca46-92b2-09e0-67a8-55a90203b9cc@huawei.com>
 <20201015075900.ukz3y6cl2vhwmctx@kamzik.brq.redhat.com>
From: Ying Fang <fangying1@huawei.com>
Message-ID: <4b9472ec-b90a-8b22-16ba-670e7298c9c9@huawei.com>
Date: Fri, 16 Oct 2020 17:40:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20201015075900.ukz3y6cl2vhwmctx@kamzik.brq.redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.186.67]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32; envelope-from=fangying1@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 05:40:13
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.019,
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Chenzhendong \(alex\)" <alex.chen@huawei.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 "Zengtao \(B\)" <prime.zeng@hisilicon.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "valentin.schneider@arm.com" <valentin.schneider@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 10/15/2020 3:59 PM, Andrew Jones wrote:
> On Thu, Oct 15, 2020 at 10:07:16AM +0800, Ying Fang wrote:
>>
>>
>> On 10/14/2020 2:08 AM, Andrew Jones wrote:
>>> On Tue, Oct 13, 2020 at 12:11:20PM +0000, Zengtao (B) wrote:
>>>> Cc valentin
>>>>
>>>>> -----Original Message-----
>>>>> From: Qemu-devel
>>>>> [mailto:qemu-devel-bounces+prime.zeng=hisilicon.com@nongnu.org]
>>>>> On Behalf Of Ying Fang
>>>>> Sent: Thursday, September 17, 2020 11:20 AM
>>>>> To: qemu-devel@nongnu.org
>>>>> Cc: peter.maydell@linaro.org; drjones@redhat.com; Zhanghailiang;
>>>>> Chenzhendong (alex); shannon.zhaosl@gmail.com;
>>>>> qemu-arm@nongnu.org; alistair.francis@wdc.com; fangying;
>>>>> imammedo@redhat.com
>>>>> Subject: [RFC PATCH 00/12] hw/arm/virt: Introduce cpu and cache
>>>>> topology support
>>>>>
>>>>> An accurate cpu topology may help improve the cpu scheduler's
>>>>> decision
>>>>> making when dealing with multi-core system. So cpu topology
>>>>> description
>>>>> is helpful to provide guest with the right view. Cpu cache information
>>>>> may
>>>>> also have slight impact on the sched domain, and even userspace
>>>>> software
>>>>> may check the cpu cache information to do some optimizations. Thus
>>>>> this patch
>>>>> series is posted to provide cpu and cache topology support for arm.
>>>>>
>>>>> To make the cpu topology consistent with MPIDR, an vcpu ioctl
>>>>
>>>> For aarch64, the cpu topology don't depends on the MPDIR.
>>>> See https://patchwork.kernel.org/patch/11744387/
>>>>
>>>
>>> The topology should not be inferred from the MPIDR Aff fields,
>>
>> MPIDR is abused by ARM OEM manufactures. It is only used as a
>> identifer for a specific cpu, not representation of the topology.
> 
> Right, which is why I stated topology should not be inferred from
> it.
> 
>>
>>> but MPIDR is the CPU identifier. When describing a topology
>>> with ACPI or DT the CPU elements in the topology description
>>> must map to actual CPUs. MPIDR is that mapping link. KVM
>>> currently determines what the MPIDR of a VCPU is. If KVM
>>
>> KVM currently assigns MPIDR with vcpu->vcpu_id which mapped
>> into affinity levels. See reset_mpidr in sys_regs.c
> 
> I know, but how KVM assigns MPIDRs today is not really important
> to KVM userspace. KVM userspace shouldn't depend on a KVM
> algorithm, as it could change.
> 
>>
>>> userspace is going to determine the VCPU topology, then it
>>> also needs control over the MPIDR values, otherwise it
>>> becomes quite messy trying to get the mapping right.
>> If we are going to control MPIDR, shall we assign MPIDR with
>> vcpu_id or map topology hierarchy into affinity levels or any
>> other link schema ?
>>
> 
> We can assign them to whatever we want, as long as they're
> unique and as long as Aff0 is assigned per the GIC requirements,
> e.g. GICv3 requires that Aff0 be from 0 to 0xf. Also, when
> pinning VCPUs to PCPUs we should ensure that MPIDRs with matching
> Aff3,Aff2,Aff1 fields should actually be peers with respect to
> the GIC.

Still not clear why vCPU's MPIDR need to match pPCPU's GIC affinity.
Maybe I should read spec for GICv3.

> 
> We shouldn't try to encode topology in the MPIDR in any way,
> so we might as well simply increment a counter to assign them,
> which could possibly be the same as the VCPU ID.

Hmm, then we can leave it as it is.

> 
> Thanks,
> drew
> 
> .
> 


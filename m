Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF9FC2BC73
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 06:46:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E6A32068E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 06:21:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E6A32068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icO23-0003o2-5y
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 01:21:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50063)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhengxiang9@huawei.com>) id 1icNvs-0002U4-Ih
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 01:14:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhengxiang9@huawei.com>) id 1icNvi-0006BY-EW
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 01:14:35 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:46900 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhengxiang9@huawei.com>)
 id 1icNvY-000551-Ut; Wed, 04 Dec 2019 01:14:21 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 8B58E170EB14C16A5A99;
 Wed,  4 Dec 2019 14:14:09 +0800 (CST)
Received: from [127.0.0.1] (10.133.224.57) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Dec 2019
 14:14:02 +0800
From: Xiang Zheng <zhengxiang9@huawei.com>
Subject: Re: [PATCH 4/5] hw/arm/virt: Add FW_CFG_RAM_SIZE and FW_CFG_MAX_CPUS
 into fw_cfg
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191203122753.19792-1-zhengxiang9@huawei.com>
 <20191203122753.19792-5-zhengxiang9@huawei.com>
 <CAFEAcA8ZRufe+6P1kj8iSc40EEWohjA_FMscxjmNLJrPPQyn-A@mail.gmail.com>
Message-ID: <3f4d33e2-df25-42f3-0896-31d4df32ea64@huawei.com>
Date: Wed, 4 Dec 2019 14:14:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8ZRufe+6P1kj8iSc40EEWohjA_FMscxjmNLJrPPQyn-A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.224.57]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 wanghaibin.wang@huawei.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2019/12/3 20:32, Peter Maydell wrote:
> On Tue, 3 Dec 2019 at 12:29, Xiang Zheng <zhengxiang9@huawei.com> wrote:
>>
>> I'm not sure whether it's neccesary to add FW_CFG_RAM_SIZE and
>> FW_CFG_MAX_CPUS into fw_cfg on virt machine. This patch just makes
>> the fw_cfg-test happy.
>>
>> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
>> ---
>>  hw/arm/virt.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index d4bedc2607..26a4183775 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -1084,6 +1084,9 @@ static FWCfgState *create_fw_cfg(const VirtMachineState *vms, AddressSpace *as)
>>      fw_cfg = fw_cfg_init_mem_wide(base + 8, base, 8, base + 16, as);
>>      fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)ms->smp.cpus);
>>
>> +    fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)ram_size);
>> +    fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)ms->smp.max_cpus);
>> +
>>      nodename = g_strdup_printf("/fw-cfg@%" PRIx64, base);
>>      qemu_fdt_add_subnode(vms->fdt, nodename);
>>      qemu_fdt_setprop_string(vms->fdt, nodename,
>> --
> 
> Is there a spec anywhere that defines the meaning of these
> FW_CFG entries ? docs/specs/fw_cfg.txt defines the
> device interface but not what the 'standard' keys mean.
> I'd prefer not to add them to the virt board without knowing
> what they mean and why we have them.
> 

I cannot find a spec or doc defines these FW_CFG entries. It seems that they
are used on x86 machines to limit APIC ID values but useless on virt machine.
I will drop this patch.

-- 

Thanks,
Xiang



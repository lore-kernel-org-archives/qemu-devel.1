Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD300C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 01:53:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1D0D22D2B
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 01:53:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D0D22D2B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmSh9-00041a-UR
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 21:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gengdongjiu@huawei.com>)
 id 1jmSgV-0003S1-1n
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 21:52:43 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:49760 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gengdongjiu@huawei.com>)
 id 1jmSgS-0004uq-G7
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 21:52:42 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.53])
 by Forcepoint Email with ESMTP id A62E6387FDA899DE122F;
 Sat, 20 Jun 2020 09:52:30 +0800 (CST)
Received: from dggeme755-chm.china.huawei.com (10.3.19.101) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Sat, 20 Jun 2020 09:50:23 +0800
Received: from [127.0.0.1] (10.140.157.78) by dggeme755-chm.china.huawei.com
 (10.3.19.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Sat, 20
 Jun 2020 09:50:24 +0800
Subject: Re: [PULL 26/45] ACPI: Record Generic Error Status Block(GESB) table
To: Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>
References: <20200514142138.20875-1-peter.maydell@linaro.org>
 <20200514142138.20875-27-peter.maydell@linaro.org>
 <CAFEAcA_a4yiE9UZx=MAFUM+f0LSiNvjQ=X1+dObELRzfnTyUHQ@mail.gmail.com>
 <20200521113048-mutt-send-email-mst@kernel.org>
 <CAFEAcA-PTtLvouxo5XZmgSbeRWa4WCwH7_cC5xrg3Dnr8UyZxg@mail.gmail.com>
From: Dongjiu Geng <gengdongjiu@huawei.com>
Message-ID: <ca79ea28-9ea9-18a5-99ad-25c3eb744721@huawei.com>
Date: Sat, 20 Jun 2020 09:50:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-PTtLvouxo5XZmgSbeRWa4WCwH7_cC5xrg3Dnr8UyZxg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.140.157.78]
X-ClientProxiedBy: dggeme704-chm.china.huawei.com (10.1.199.100) To
 dggeme755-chm.china.huawei.com (10.3.19.101)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.255;
 envelope-from=gengdongjiu@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 21:52:31
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/6/20 1:21, Peter Maydell wrote:
> On Thu, 21 May 2020 at 16:31, Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> On Thu, May 21, 2020 at 02:03:36PM +0100, Peter Maydell wrote:
>>> On Thu, 14 May 2020 at 15:22, Peter Maydell <peter.maydell@linaro.org> wrote:
>>>>
>>>> From: Dongjiu Geng <gengdongjiu@huawei.com>
>>>>
>>>> kvm_arch_on_sigbus_vcpu() error injection uses source_id as
>>>> index in etc/hardware_errors to find out Error Status Data
>>>> Block entry corresponding to error source. So supported source_id
>>>> values should be assigned here and not be changed afterwards to
>>>> make sure that guest will write error into expected Error Status
>>>> Data Block.
>>>>
>>>> Before QEMU writes a new error to ACPI table, it will check whether
>>>> previous error has been acknowledged. If not acknowledged, the new
>>>> errors will be ignored and not be recorded. For the errors section
>>>> type, QEMU simulate it to memory section error.
>>>
>>> Hi; Coverity points out (CID 1428962) that there is
>>> unreachable code in this function:
>>>
>>>> +static int acpi_ghes_record_mem_error(uint64_t error_block_address,
>>>> +                                      uint64_t error_physical_addr)
>>>> +{
>>>> +    GArray *block;
>>>> +
>>>> +    /* Memory Error Section Type */
>>>> +    const uint8_t uefi_cper_mem_sec[] =
>>>> +          UUID_LE(0xA5BC1114, 0x6F64, 0x4EDE, 0xB8, 0x63, 0x3E, 0x83, \
>>>> +                  0xED, 0x7C, 0x83, 0xB1);
>>>> +
>>>> +    /* invalid fru id: ACPI 4.0: 17.3.2.6.1 Generic Error Data,
>>>> +     * Table 17-13 Generic Error Data Entry
>>>> +     */
>>>> +    QemuUUID fru_id = {};
>>>> +    uint32_t data_length;
>>>> +
>>>> +    block = g_array_new(false, true /* clear */, 1);
>>>> +
>>>> +    /* This is the length if adding a new generic error data entry*/
>>>> +    data_length = ACPI_GHES_DATA_LENGTH + ACPI_GHES_MEM_CPER_LENGTH;
>>>
>>> Here data_length has a constant value...
>>>
>>>> +
>>>> +    /*
>>>> +     * Check whether it will run out of the preallocated memory if adding a new
>>>> +     * generic error data entry
>>>> +     */
>>>> +    if ((data_length + ACPI_GHES_GESB_SIZE) > ACPI_GHES_MAX_RAW_DATA_LENGTH) {
>>>
>>> ...but here we immediately have a runtime check which can't possibly
>>> fail because of the values of the constants involved, so this
>>> if() block is dead code.
>>>
>>>> +        error_report("Not enough memory to record new CPER!!!");
>>>> +        g_array_free(block, true);
>>>> +        return -1;
>>>> +    }
>>>
>>> What was this code trying to do? Is the initial value of
>>> data_length incorrect, or is the if() condition wrong, or
>>> should this simply have been an assert() ?
> 
>> It's just a validity check. assert will do just as well.
> 
> Would somebody like to write a patch to make it assert instead, then,
> please? That should keep Coverity happy.
  I will check the comments history and make a patch, thanks a lot.

> 
> thanks
> -- PMM
> 
> .
> 



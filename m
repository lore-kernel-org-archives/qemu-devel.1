Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EE6C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 14:38:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3026A20656
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 14:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3026A20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52198 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMCrO-000843-8b
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 10:38:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xuwei5@huawei.com>) id 1hMCjv-00010K-Py
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:31:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xuwei5@huawei.com>) id 1hMCju-0006BW-O4
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:31:11 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:45394 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xuwei5@huawei.com>) id 1hMCju-0005yt-HA
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:31:10 -0400
Received: from lhreml703-cah.china.huawei.com (unknown [172.18.7.108])
	by Forcepoint Email with ESMTP id B6D45C372521642EFE5F;
	Thu,  2 May 2019 15:31:04 +0100 (IST)
Received: from [127.0.0.1] (10.202.226.56) by lhreml703-cah.china.huawei.com
	(10.201.108.44) with Microsoft SMTP Server id 14.3.408.0;
	Thu, 2 May 2019 15:30:56 +0100
To: Igor Mammedov <imammedo@redhat.com>
References: <1556170489-131927-12-git-send-email-imammedo@redhat.com>
	<1556211116-172721-1-git-send-email-xuwei5@huawei.com>
	<20190426135412.758769f9@Igors-MacBook-Pro.local>
	<b87a2b31-0389-2df0-42a6-a1593d437fcd@hisilicon.com>
	<20190502162420.6c8280c8@Igors-MacBook-Pro>
From: Wei Xu <xuwei5@hisilicon.com>
Message-ID: <9caa067d-df2e-78c6-5672-e276da3263a6@hisilicon.com>
Date: Thu, 2 May 2019 15:30:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190502162420.6c8280c8@Igors-MacBook-Pro>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.56]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 185.176.76.210
Subject: Re: [Qemu-devel] [PATCH v3 11/13] tests: acpi: add simple arm/virt
 testcase
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>,
	mst@redhat.com, linuxarm@huawei.com,
	shameerali.kolothum.thodi@huawei.com, qemu-devel@nongnu.org,
	x00249684 <xuwei5@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502143054.DJj7CSJa0aO8mnQF9iT6YyNL7xzoa3XOZsEuuLEgPvc@z>

Hi Igor,

On 5/2/2019 3:24 PM, Igor Mammedov wrote:
> On Fri, 26 Apr 2019 17:28:10 +0100
> Wei Xu <xuwei5@hisilicon.com> wrote:
> 
>> Hi Igor,
>>
>> On 4/26/2019 12:54 PM, Igor Mammedov wrote:
>>> On Fri, 26 Apr 2019 00:51:56 +0800
>>> x00249684 <xuwei5@huawei.com> wrote:
>>>
>>>> Hi Igor,
>>>>
>>>> +static void test_acpi_virt_tcg(void)
>>>> +{
>>>> +    test_data data = {
>>>> +        .machine = "virt",
>>>> +        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
>>>> +        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
>>>> +        .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
>>>> +        .ram_start = 0x40000000ULL,
>>>> +        .scan_len = 128ULL * 1024 * 1024,
>>>> +    };
>>>> +
>>>> +    test_acpi_one("-cpu cortex-a57 ", &data);
>>>>
>>>> Replaced the cortex-a57 with host and succesfully tested on the hisilicon arm64 
>>>> D05 board. Otherwise it failed with "kvm_init_vcpu failed: Invalid argument".
>>>> Is it possilbe to set the cpu type like numa-test.c?
>>>
>>> I think it works with numa-test because it uses TCG only but in case of bios-tables-test
>>> it uses accel="kvm:tcg" to leverage KVM capabilities whenever possible to speed up test.
>>>
>>> Now back to our ARM test case, uefi requirement is to use 64bit CPU (hence it was cortex-a57)
>>> however unlike x86 it obviously breaks since KVM accelerator on ARM host is used
>>> and it doesn't work with anything other than 'host' cpu model.
>>>
>>> I think we still want to use KVM whenever possible, but problem lies in that
>>> user (testcase) doesn't have an idea if KVM accelerator is available and host is 64 CPU.
>>>
>>> to sum up we need to support 2 modes:
>>>   1. host is 64 ARM, use kvm with -cpu host
>>>   2. all other cases use tcg with -cpu cortex-a57
>>>
>>> I can hack to probe if /dev/kvm is accessible and host is 64 bit and use #1
>>> otherwise fallback to #2
>>> or as quick fix do only #2 initially and think about a better solution to #1 
>>
>> Thanks!
>> Fine to me.
>>
>>>
>>> Is there any other suggestions/opinions how to approach issue/proceed.
>>
>> To check the host cpu architecture is ARM or not, maybe we can check the value
>> of "CPU implementer" is 0x41 or not from the /proc/cpuinfo.
> 
> it turned out it's more complicated.
> we also should pick a correct GIC depending on host's CPU and that
> changes ACPI tables, so it will worn on some hosts and fail on other.
Sorry, I did not consider that case.

> 
> I'll add a patch to enable test case to pick accelerator and force TCG
> for ARM tests for now.
>

Thanks!

Best Regards,
Wei

>>
>> Best Regards,
>> Wei
>>
>>>
>>> PS:
>>> we probably would like to reuse this not only for acpi tests but also for other
>>> arm/virt test cases that involve running guest code. 
>>>
>>>> Thanks!
>>>>
>>>> Best Regards,
>>>> Wei
>>>
>>>
>>> .
>>>
>>
> 
> 
> .
> 



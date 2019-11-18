Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC476C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 13:20:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC9F1206D4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 13:20:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC9F1206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWgws-0003FL-TX
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 08:20:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38384)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gengdongjiu@huawei.com>) id 1iWgvf-00025L-0i
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 08:18:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gengdongjiu@huawei.com>) id 1iWgvd-0005WR-Qf
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 08:18:54 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:48468 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gengdongjiu@huawei.com>)
 id 1iWgvE-0005Cq-6C; Mon, 18 Nov 2019 08:18:29 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 863DE3839AA8C708ED17;
 Mon, 18 Nov 2019 21:18:13 +0800 (CST)
Received: from [127.0.0.1] (10.142.68.147) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Mon, 18 Nov 2019
 21:18:03 +0800
Subject: Re: [RESEND PATCH v21 3/6] ACPI: Add APEI GHES table generation
 support
From: gengdongjiu <gengdongjiu@huawei.com>
To: Igor Mammedov <imammedo@redhat.com>, Xiang Zheng <zhengxiang9@huawei.com>
References: <20191111014048.21296-1-zhengxiang9@huawei.com>
 <20191111014048.21296-4-zhengxiang9@huawei.com>
 <20191115103801.547fc84d@redhat.com>
 <cf5e5aa4-2283-6cf9-70d0-278d167e3a13@huawei.com>
Message-ID: <87758ec2-c242-71c3-51f8-a5d348f8e7fd@huawei.com>
Date: Mon, 18 Nov 2019 21:18:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <cf5e5aa4-2283-6cf9-70d0-278d167e3a13@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.68.147]
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, kvm@vger.kernel.org,
 mst@redhat.com, wanghaibin.wang@huawei.com, mtosatti@redhat.com,
 qemu-devel@nongnu.org, linuxarm@huawei.com, shannon.zhaosl@gmail.com,
 qemu-arm@nongnu.org, james.morse@arm.com, xuwei5@huawei.com,
 jonathan.cameron@huawei.com, pbonzini@redhat.com, lersek@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2019/11/18 20:49, gengdongjiu wrote:
>>> +     */
>>> +    build_append_int_noprefix(table_data, source_id, 2);
>>> +    /* Related Source Id */
>>> +    build_append_int_noprefix(table_data, 0xffff, 2);
>>> +    /* Flags */
>>> +    build_append_int_noprefix(table_data, 0, 1);
>>> +    /* Enabled */
>>> +    build_append_int_noprefix(table_data, 1, 1);
>>> +
>>> +    /* Number of Records To Pre-allocate */
>>> +    build_append_int_noprefix(table_data, 1, 4);
>>> +    /* Max Sections Per Record */
>>> +    build_append_int_noprefix(table_data, 1, 4);
>>> +    /* Max Raw Data Length */
>>> +    build_append_int_noprefix(table_data, ACPI_GHES_MAX_RAW_DATA_LENGTH, 4);
>>> +
>>> +    /* Error Status Address */
>>> +    build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 0x40, 0,
>>> +                     4 /* QWord access */, 0);
>>> +    bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
>>> +        ACPI_GHES_ERROR_STATUS_ADDRESS_OFFSET(hest_start, source_id),
>> it's fine only if GHESv2 is the only entries in HEST, but once
>> other types are added this macro will silently fall apart and
>> cause table corruption.
   why  silently fall?
   I think the acpi_ghes.c only support GHESv2 type, not support other type.

>>
>> Instead of offset from hest_start, I suggest to use offset relative
>> to GAS structure, here is an idea>>
>> #define GAS_ADDR_OFFSET 4
>>
>>     off = table->len
>>     build_append_gas()
>>     bios_linker_loader_add_pointer(...,
>>         off + GAS_ADDR_OFFSET, ...

If use offset relative to GAS structure, the code does not easily extend to support more Generic Hardware Error Source.
if use offset relative to hest_start, just use a loop, the code can support  more error source, for example:
for (source_id = 0; i<n; source_id++)
{
   ......
    bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
        ACPI_GHES_ERROR_STATUS_ADDRESS_OFFSET(hest_start, source_id),
        sizeof(uint64_t), ACPI_GHES_ERRORS_FW_CFG_FILE,
        source_id * sizeof(uint64_t));
  .......
}

My previous series patch support 2 error sources, but now only enable 'SEA' type Error Source



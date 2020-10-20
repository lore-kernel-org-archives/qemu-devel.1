Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAC4C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 12:20:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DA602222F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 12:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA602222F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUqcw-0000nr-Fv
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 08:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liangpeng10@huawei.com>)
 id 1kUqc9-0000DW-2Z; Tue, 20 Oct 2020 08:19:41 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:33530 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liangpeng10@huawei.com>)
 id 1kUqc6-0008Hx-Nh; Tue, 20 Oct 2020 08:19:40 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id C2F9EDAD1F637220E8CB;
 Tue, 20 Oct 2020 20:19:29 +0800 (CST)
Received: from dggema765-chm.china.huawei.com (10.1.198.207) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 20 Oct 2020 20:19:29 +0800
Received: from [10.174.185.187] (10.174.185.187) by
 dggema765-chm.china.huawei.com (10.1.198.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 20 Oct 2020 20:19:29 +0800
Subject: Re: [PATCH] microbit_i2c: Fix coredump when dump-vmstate
To: Peter Maydell <peter.maydell@linaro.org>
References: <20201019093401.2993833-1-liangpeng10@huawei.com>
 <786deb83-b6f4-d778-d5ed-19f3901ad211@redhat.com>
 <0c174303-50bc-128a-26ab-c062f98cd6cd@huawei.com>
 <CAFEAcA_AQ5V4ZrWYjCD3DcnUGFsA-HBDWsQZ=SAQh6hydoa-kw@mail.gmail.com>
From: Peng Liang <liangpeng10@huawei.com>
Message-ID: <8670055b-e7b6-1bfa-22c9-b9e1e0fe473c@huawei.com>
Date: Tue, 20 Oct 2020 20:19:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_AQ5V4ZrWYjCD3DcnUGFsA-HBDWsQZ=SAQh6hydoa-kw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.185.187]
X-ClientProxiedBy: dggeme717-chm.china.huawei.com (10.1.199.113) To
 dggema765-chm.china.huawei.com (10.1.198.207)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.255;
 envelope-from=liangpeng10@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 08:19:30
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Xiangyou Xie <xiexiangyou@huawei.com>,
 qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/20/2020 7:27 PM, Peter Maydell wrote:
> On Tue, 20 Oct 2020 at 12:17, Peng Liang <liangpeng10@huawei.com> wrote:
>>
>> On 10/19/2020 6:35 PM, Philippe Mathieu-Daudé wrote:
>>> On 10/19/20 11:34 AM, Peng Liang wrote:
>>>> VMStateDescription.fields should be end with VMSTATE_END_OF_LIST().
>>>> However, microbit_i2c_vmstate doesn't follow it.  Let's change it.
>>>
>>> It might be easy to add a Coccinelle script to avoid future errors.
>>>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>
>>
>> I tried to add a Coccinelle script to add VMSTATE_END_OF_LIST() to the
>> end of VMStateDescription.fields.  For those who are not defined as
>> compound literals, it works well.  However, I cannot make it work for
>> those defined as compound literals.  And Julia doesn't think compound
>> literals are supported currently[1].  So maybe currently it's hard to
>> check the error using Coccinelle :(
> 
> I think we could probably significantly increase the chances that
> people find "missing terminator" errors in the course of normal
> debugging of their device if we made the terminator be something
> other than "is field->name NULL". That condition is quite likely
> to be satisfied by accident shortly after the real end-of-data
> (because zeroes are easy to find in memory), whereas if the condition
> is "field->flags is a magic number", for instance, then the chances of
> it being satisfied by accident are very low, and so a simple "loop
> through the field array until we find the end" is pretty likely to
> hang/crash. (If we don't already have such a loop we might need to
> add one in debug mode when a vmstate is registered.)
> 
> (This is why the REGINFO_SENTINEL used for Arm cpreg arrays is
> not a simple all-zeroes value, incidentally.)
> 
> thanks
> -- PMM
> .
> 

I found that field->flags is a bit-or field, so maybe all 0xf or other
magic number is still meaningful?  Can we use field->version_id or
field->struct_version_id as the condition?  I found they are all int
type but used as non-negative, so can we use
field->version_id/field->struct_version_id == magic number (for example,
-1) as a sentinel?

-- 
Thanks,
Peng


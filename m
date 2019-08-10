Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A84C433FF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 13:56:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF8FE218A2
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 13:56:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF8FE218A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwRqk-0005wo-UT
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 09:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34789)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1hwRqN-0005Ow-VV
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 09:55:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1hwRqJ-0002qj-Ow
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 09:55:39 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:46944)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1hwRqJ-0002go-9w; Sat, 10 Aug 2019 09:55:35 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.06809141|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.21291-0.0138966-0.773193; FP=0|0|0|0|0|-1|-1|-1;
 HT=e02c03312; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS; RN=7; RT=7; SR=0;
 TI=SMTPD_---.F9j9.MS_1565445321; 
Received: from 192.168.79.129(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.F9j9.MS_1565445321)
 by smtp.aliyun-inc.com(10.147.43.230);
 Sat, 10 Aug 2019 21:55:23 +0800
To: Alistair Francis <alistair23@gmail.com>
References: <97a6ae9f-2845-4a3c-2a31-367787622268@c-sky.com>
 <CAKmqyKMqCKS_-rxZ2WYEn+m2gDom27rd2f2FCe0LmVs9brPcAQ@mail.gmail.com>
From: LIU ZhiWei <zhiwei_liu@c-sky.com>
Message-ID: <c502163b-ed8a-89d1-6437-9b0f49e88a84@c-sky.com>
Date: Sat, 10 Aug 2019 06:55:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAKmqyKMqCKS_-rxZ2WYEn+m2gDom27rd2f2FCe0LmVs9brPcAQ@mail.gmail.com>
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 121.197.200.217
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] RISC-V: Vector && DSP Extension
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, bastian@mail.uni-paderborn.de,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 8/9/19 6:54 PM, Alistair Francis wrote:
> On Thu, Aug 8, 2019 at 2:52 AM liuzhiwei <zhiwei_liu@c-sky.com> wrote:
>> Hi all,
>>
>>      My workmate  and I have been working on Vector & Dsp extension, and
>> I'd like to share develop status  with folks.
> Cool!
>
>>      The spec references for  Vector extension is riscv-v-spec-0.7.1, and
>> riscv-p-spec-0.5 for DSP extension. The code of vector extension is
>> ready and under testing,  the first patch will be sent about two weeks
>> later. After that we will forward working on DSP extension, and send the
>> first patch in middle  October.
> What code are you talking about? Is this QEMU code?

Hi Alistair,

It's the QEMU code I have been working on these days, which implements Vector extension. It is under testing,
and will be sent later.

>>       Could the maintainers  tell me whether the specs referenced are
>> appropriate? Is anyone working on these extensions?  I'd like to get
>> your status, and maybe discuss questions and work togather.
> Just use the latest (master) from the ISA spec git repo.

I will follow your advice.Thanks for your attention to this matter.

Best Regards,

Zhiwei

>
> I don't know anyone doing vector work for QEMU. It would be very
> useful, but everyone is busy with something at the moment
> unfortunately.
>
> Alistair
>
>> Best Regards
>>
>> LIU Zhiwei
>>
>>
>>

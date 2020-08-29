Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99432C433E6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 15:51:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 658D020707
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 15:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 658D020707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kC38D-0003nt-IX
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 11:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1kC37b-0002tS-4B
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 11:50:27 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:33258)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1kC37X-00013H-3G
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 11:50:26 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07585606|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.00675958-0.00045822-0.992782;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01a16384; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=4; RT=4; SR=0; TI=SMTPD_---.IPn1l-i_1598716193; 
Received: from 192.168.3.36(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.IPn1l-i_1598716193)
 by smtp.aliyun-inc.com(10.147.42.135);
 Sat, 29 Aug 2020 23:49:54 +0800
Subject: Re: [PULL 00/18] riscv-to-apply queue
To: Alistair Francis <alistair23@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200825184836.1282371-1-alistair.francis@wdc.com>
 <CAFEAcA8=Mf=EPh__tNhJyGv8+ouD-HH+MuMb+HhtTFes+XqUSQ@mail.gmail.com>
 <CAKmqyKNxURXyNSEePPU1jY7FzcZjRThr2qAvwR393+nqUXBxJQ@mail.gmail.com>
 <CAFEAcA8x=ck1mmJ8Y8o-0NQXWhRgOg5Gp7GvHNkNnLb6rDxygg@mail.gmail.com>
 <CAKmqyKP6OUoaR6iZ6SD6qZPvYF0bKqpB_rRNeQOteg8BtcqKeQ@mail.gmail.com>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <78f899b4-b8f8-9fc7-15a3-4d56d77bb960@c-sky.com>
Date: Sat, 29 Aug 2020 23:49:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAKmqyKP6OUoaR6iZ6SD6qZPvYF0bKqpB_rRNeQOteg8BtcqKeQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/29 11:05:16
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.809,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/8/26 6:30, Alistair Francis wrote:
> On Tue, Aug 25, 2020 at 2:50 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>> On Tue, 25 Aug 2020 at 22:32, Alistair Francis <alistair23@gmail.com> wrote:
>>> On Tue, Aug 25, 2020 at 2:24 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>>>> The hypervisor related patches don't seem to have any
>>>> reviewed-by tags, which seems a shame for a fairly significant
>>>> chunk of work. Is there really nobody who can review them
>>>> for you ?
>>> Unfortunately not. They have been on the list since April and haven't
>>> received any feedback.
>>>
>>> There isn't a lot of people reviewing the RISC-V patches unfortunately.
>> :-(   I'd hoped it was a more active target than that.
> There are lots of active contributors, we are just short on reviewers.
>
> Richard and Philippe review patches and some of the RISC-V patches get
> reviewed by the RISC-V community. The main problem (which is a common
> problem in open source) is that large technical patch series just get
> ignored.
Hi Alistair,

It's really a pity.

I will review every patch that CC me in no more than a week if no other 
people reviewed this patch.

So if there too many patches, just ease to CC me.


Best Regards,
Zhiwei
>
> Alistair
>
>> -- PMM



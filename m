Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F60C3A59B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 06:43:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B18D2190F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 06:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B18D2190F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4g3l-00048Z-Qd
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 02:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1i4g31-0003Ww-In
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 02:42:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1i4g30-00058Z-1x
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 02:42:43 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:47142)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1i4g2z-0004z3-Me; Mon, 02 Sep 2019 02:42:42 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.04473828|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.457032-0.0421568-0.500811; FP=0|0|0|0|0|-1|-1|-1;
 HT=e02c03292; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS; RN=12; RT=12; SR=0;
 TI=SMTPD_---.FNKF1zu_1567406547; 
Received: from 172.16.28.187(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.FNKF1zu_1567406547)
 by smtp.aliyun-inc.com(10.147.43.230);
 Mon, 02 Sep 2019 14:42:31 +0800
To: Alistair Francis <alistair23@gmail.com>
References: <1566959818-38369-1-git-send-email-zhiwei_liu@c-sky.com>
 <CAKmqyKMDmaABGWyLZD2R-4J8=jM6hry6Bfmu498+UZzQtxsTMA@mail.gmail.com>
 <af15b620-1350-aa1a-0f02-2a46518f0ef2@c-sky.com>
 <CAKmqyKPUxyMZnnOd896aK4ZRoG+6iiBQ0E3MJbEqRv9KudbN7Q@mail.gmail.com>
From: liuzhiwei <zhiwei_liu@c-sky.com>
Message-ID: <4110dc1e-6556-bfe0-b24b-840b43521a97@c-sky.com>
Date: Mon, 2 Sep 2019 14:36:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAKmqyKPUxyMZnnOd896aK4ZRoG+6iiBQ0E3MJbEqRv9KudbN7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 121.197.200.217
Subject: Re: [Qemu-devel] [PATCH] RISCV: support riscv vector extension 0.7.1
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/8/30 上午5:50, Alistair Francis wrote:
> On Thu, Aug 29, 2019 at 5:05 AM liuzhiwei <zhiwei_liu@c-sky.com> wrote:
>> On 2019/8/29 上午5:34, Alistair Francis wrote:
>>> On Wed, Aug 28, 2019 at 12:04 AM liuzhiwei <zhiwei_liu@c-sky.com> wrote:
>>>> Change-Id: I3cf891bc400713b95f47ecca82b1bf773f3dcb25
>>>> Signed-off-by: liuzhiwei <zhiwei_liu@c-sky.com>
>>>> ---
>>>>    fpu/softfloat.c                         |   119 +
>>>>    include/fpu/softfloat.h                 |     4 +
>>>>    linux-user/riscv/cpu_loop.c             |     8 +-
>>>>    target/riscv/Makefile.objs              |     2 +-
>>>>    target/riscv/cpu.h                      |    30 +
>>>>    target/riscv/cpu_bits.h                 |    15 +
>>>>    target/riscv/cpu_helper.c               |     7 +
>>>>    target/riscv/csr.c                      |    65 +-
>>>>    target/riscv/helper.h                   |   354 +
>>>>    target/riscv/insn32.decode              |   374 +-
>>>>    target/riscv/insn_trans/trans_rvv.inc.c |   484 +
>>>>    target/riscv/translate.c                |     1 +
>>>>    target/riscv/vector_helper.c            | 26563 ++++++++++++++++++++++++++++++
>>>>    13 files changed, 28017 insertions(+), 9 deletions(-)
>>>>    create mode 100644 target/riscv/insn_trans/trans_rvv.inc.c
>>>>    create mode 100644 target/riscv/vector_helper.c
>>>>
>>> Hello,
>>>
>>> Thanks for the patch!
>>>
>>> As others have pointed out you will need to split the patch up into
>>> multiple smaller patches, otherwise it is too hard to review almost
>>> 30,000 lines of code.
>> Hi, Alistair
>>
>> I'm so sorry for the inconvenience. It will be a patch set with a cover
>> letter in V2.
> No worries.
>
>>> Can you also include a cover letter with your patch series describing
>>> how you are testing this? AFAIK vector extension support isn't in any
>>> compiler so I'm assuming you are handwriting the assembly or have
>>> toolchain patches. Either way it will help if you can share that so
>>> others can test your implementation.
>> Yes, it's handwriting assembly. The assembler in Binutils has support
>> Vector extension.  First define an function test_vadd_vv_8 in assembly
>> and then it can be called from a C program.
>>
>> The function is something like
>>
>> /* vadd.vv */
>> TEST_FUNC(test_vadd_vv_8)
>>           vsetvli        t1, x0, e8, m2
>>           vlb.v           v6, (a4)
>>           vsb.v           v6, (a3)
>>           vsetvli        t1, a0, e8, m2
>>           vlb.v           v0, (a1)
>>           vlb.v           v2, (a2)
>>           vadd.vv     v4, v0, v2
>>           vsb.v          v4, (a3)
>> ret
>>           .size   test_vadd_vv_8, .-test_vadd_vv_8
> If possible it might be worth releasing the code that you are using for testing.
Yes,  but I didn't find a good place to release these test codes currently.
>
>> It takes more time to test than to implement the instructions. Maybe
>> there is some better test method or some forced test cases in QEMU.
>> Could you give me some advice for testing?
> Richard's idea of risu seems like a good option.
All the test cases will be validated in Spike,  which has supported the 
same vector specification. But this  cross validation work may delay 
until V3.
I will split the patch, and address comments as soon as possible, to 
ensure the patch V2 can be sent next week.
Would it be all right?
>
> Thinking about it a bit more we are going to have other extensions in
> the future that will need assembly testing so setting up a test
> framework seems like a good idea. I am happy to help try and get this
> going as well.
>
> Alistair
There is usually a big difference between new a ISA extension and the 
others. I doubt there is an general framework. A very light framework  
includes
building, input aiding  generation, result validation, and report maybe 
OK .

Best Regards,
Zhiwei
>> Best Regards,
>>
>> Zhiwei
>>
>>> Alex and Richard have kindly started the review. Once you have
>>> addressed their comments and split this patch up into smaller patches
>>> you can send a v2 and we can go from there.
>>>
>>> Once again thanks for doing this implementation for QEMU!
>>>
>>> Alistair
>>>


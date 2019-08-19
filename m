Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8116EC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 13:48:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54A202082C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 13:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A202082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzi0y-0004qE-IY
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 09:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1hzhxH-0001WR-2Z
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 09:44:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1hzhxF-0002jt-Cq
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 09:44:14 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:43833)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1hzhxF-0002N0-19; Mon, 19 Aug 2019 09:44:13 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.06474514|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.0746243-0.00383168-0.921544; FP=0|0|0|0|0|-1|-1|-1;
 HT=e01a16384; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS; RN=7; RT=7; SR=0;
 TI=SMTPD_---.FEfjRoa_1566222239; 
Received: from 172.16.28.187(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.FEfjRoa_1566222239)
 by smtp.aliyun-inc.com(10.147.42.16); Mon, 19 Aug 2019 21:44:02 +0800
From: liuzhiwei <zhiwei_liu@c-sky.com>
To: Alistair Francis <alistair23@gmail.com>
References: <0141541d-43ff-98d8-e9d4-4a2fdcfdcf36@c-sky.com>
 <CAKmqyKPr0V6acB2-Y+N1-aoj-5LSofwi=Jz=u6KFJN1fPUWjzA@mail.gmail.com>
Message-ID: <2b741fb0-0f12-0f07-a516-9cc23abc0b6e@c-sky.com>
Date: Mon, 19 Aug 2019 21:39:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAKmqyKPr0V6acB2-Y+N1-aoj-5LSofwi=Jz=u6KFJN1fPUWjzA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 121.197.200.217
Subject: Re: [Qemu-devel] RISCV: when will the CLIC be ready?
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/8/17 上午1:29, Alistair Francis wrote:
> On Thu, Aug 15, 2019 at 8:39 PM liuzhiwei<zhiwei_liu@c-sky.com>  wrote:
>> Hi, Palmer
>>
>> When Michael Clark still was the maintainer of RISCV QEMU, he wrote in the mail list, "the CLIC interrupt controller is under testing,
>> and will be included in QEMU 3.1 or 3.2". It is pity that the CLIC is not in
>> included even in QEMU 4.1.0.
> I see that there is a CLIC branch available here:
> https://github.com/riscv/riscv-qemu/pull/157
>
> It looks like all of the work is in a single commit
> (https://github.com/riscv/riscv-qemu/pull/157/commits/206d9ac339feb9ef2c325402a00f0f45f453d019)
> and that most of the other commits in the PR have already made it into
> master.
>
> Although the CLIC commit is very large it doesn't seem impossible to
> manually pull out the CLIC bits and apply it onto master.
>
> Do you know the state of the CLIC model? If it's working it shouldn't
> be too hard to rebase the work and get the code into mainline.
>
> Alistair
>
Hi,  Alistair

In my opinion, the CLIC code almost works.
  
Last year when my workmate ported an RTOS, I once read the CLIC specification and used the CLIC model code. It worked through  all the tests after fixed two bugs. I also had sent the patch to Michael, but without response(maybe a wrong email address).

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 7bf6cbc..95d80ab 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -505,6 +505,9 @@ static target_ulong riscv_intr_pc(CPURISCVState *env,
      if (!(async || clic)) {
          return tvec & ~0b11;
      }
+    if (clic) {
+        cause &= 0x3ff;
+    }
  
      /* bits [1:0] encode mode; 0 = direct, 1 = vectored, 2 >= reserved */
      switch (mode1) {
@@ -645,6 +648,9 @@ void riscv_cpu_do_interrupt(CPUState *cs)
          riscv_cpu_set_mode(env, PRV_M);
      }
  
+    if (clic) {
+        env->exccode = 0;
+    }
      /* NOTE: it is not necessary to yield load reservations here. It is only
         necessary for an SC from "another hart" to cause a load reservation
         to be yielded. Refer to the memory consistency model section of the

After that, the specification has updated and the code may changed. I didn't pull new code again.

If the CLIC model may merged into the mainline, and no body maintain the code, I'd like to work on it, fixing the bugs and updating the code according to latest specification.

Best Regards,
Zhiwei

>> As we have cpus using CLIC, I have to use the out of tree qemu code in SIFIVE
>> a long time. Could you tell me when it will be upstreamed?
>>
>> Best Regards
>> Zhiwei
>>


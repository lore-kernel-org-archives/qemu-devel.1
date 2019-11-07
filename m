Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737F3C5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 18:50:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40F742084C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 18:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cs.utexas.edu header.i=@cs.utexas.edu header.b="Be8/9CPM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40F742084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cs.utexas.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSmrW-00082M-9A
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 13:50:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38557)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rajaths@cs.utexas.edu>) id 1iSmqV-0007T3-Np
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 13:49:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rajaths@cs.utexas.edu>) id 1iSmqU-00074r-2B
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 13:49:27 -0500
Received: from newman.cs.utexas.edu ([128.83.139.110]:43248)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rajaths@cs.utexas.edu>)
 id 1iSmqT-0006vs-Kt
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 13:49:25 -0500
Received: from [10.147.224.29] (wireless-10-147-224-29.public.utexas.edu
 [10.147.224.29]) (authenticated bits=0)
 by newman.cs.utexas.edu (8.14.4/8.14.4/Debian-4.1ubuntu1.1) with ESMTP id
 xA7InIRK017229
 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
 Thu, 7 Nov 2019 12:49:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.utexas.edu;
 s=default; t=1573152559;
 bh=/UY51kO0jLkXAJAlWpJH2Kvp8Bkgbz3dyaCUckFC30w=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Be8/9CPM7SEhGVy4cOyJyZcYF8xLL2WRpVczZpRWMkLsN5bEL0Cu0vczMgbsduYaW
 5Wlk1S6J57FdVFbDDbmHccxDVME7dCFnMpdg18S6q1jmXFvWJCU7v83e0mmd/yqtVF
 CeE2EgnXa7RtCkwxW9l3ECZJO0MfdtOxgqn9mIN4=
Subject: Re: Looking for issues/features for my first contribution
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <f5a16b3c-2c17-60e4-e80b-dd20b3c088cc@cs.utexas.edu>
 <CAL1e-=g8c=QJiMm1AvBCNmsTyVWoUAjL0na2HWodHCQPiLdWJw@mail.gmail.com>
 <CAL1e-=j8K+FKj=4pTd8HKkL-D=F+9hY+5bF4ibM8WE+Sp+pk=Q@mail.gmail.com>
From: Rajath Shashidhara <rajaths@cs.utexas.edu>
Message-ID: <4a0f494a-21e1-15cd-2274-b3d863139b84@cs.utexas.edu>
Date: Thu, 7 Nov 2019 12:49:18 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=j8K+FKj=4pTd8HKkL-D=F+9hY+5bF4ibM8WE+Sp+pk=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.3.9
 (newman.cs.utexas.edu [128.83.139.110]); Thu, 07 Nov 2019 12:49:19 -0600 (CST)
X-Virus-Scanned: clamav-milter 0.100.3 at newman
X-Virus-Status: Clean
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 128.83.139.110
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thank you Aleksandar ! This is really helpful.

Rajath Shashidhara

On 07-11-2019 07:33, Aleksandar Markovic wrote:
> On Thu, Nov 7, 2019 at 11:37 AM Aleksandar Markovic
> <aleksandar.m.mail@gmail.com> wrote:
>>
>>
>> On Thursday, November 7, 2019, Rajath Shashidhara <rajaths@cs.utexas.edu> wrote:
>>> Hi all,
>>>
>>> I am a Computer Science graduate student at The University of Texas at Austin (UT, Austin). I am looking forward to contributing to qemu !
>>>
>>> This semester, I am taking a class in Virtualization (https://github.com/vijay03/cs378-f19) and contributing to a virtualization related open-source project is a significant part of the course.
>>> I would be interested in contributing a patchset to qemu - possibly a self-contained feature or a reasonably complex bug fix that can be completed in under a month's time. I did look at both the bugtracker and the QEMU Google Summer of Code 2019 page [https://wiki.qemu.org/Google_Summer_of_Code_2019] for ideas. However, I would be interested in hearing from the community and I would be delighted if somebody can be suggest a suitable project !
>>>
>> Hello, Rajath!
>>
>> Thank you for expressing interest in QEMU open source project.
>>
>> There is certainly a place for you and your contributions in QEMU, and you are very welcomed!
>>
>> It looks to me the following project would fit your description:
>>
>> 'Implement emulation of DS3231 real time clock in QEMU'
>>
>> Datasheet:
>>
>> https://datasheets.maximintegrated.com/en/ds/DS3231.pdf
>>
>> The steps needed to complete it (in my opinion):
>>
>> - collect datasheets of as many as possible RTC chips already emulated in QEMU (there are around of dozen of them, see folder hw/rtc)
>>
> I did a quick Google search on datasheets of existing RTC
> implemtations, and the result is:
>
> DS1338: https://datasheets.maximintegrated.com/en/ds/DS1338-DS1338Z.pdf
> M41T80: https://www.st.com/resource/en/datasheet/m41t80.pdf
> M48T59: http://www.elektronikjk.pl/elementy_czynne/IC/M48T59V.pdf
> MC146818: https://www.nxp.com/docs/en/data-sheet/MC146818.pdf
> PL031: http://infocenter.arm.com/help/topic/com.arm.doc.ddi0224c/real_time_clock_pl031_r1p3_technical_reference_manual_DDI0224C.pdf
> TWL92230: https://datasheet.octopart.com/TWL92230C-Texas-Instruments-datasheet-150321.pdf
> Zynq RTC: https://www.xilinx.com/support/documentation/user_guides/ug1085-zynq-ultrascale-trm.pdf
> (chapter 7)
>
> Aleksandar
>
>> - do a comparative analysis of selected RTC implementations in QEMU
>>
>> - get to know general QEMU device model
>>
>> - design and implement DS3231 emulation
>>
>> I can give you (unfortunately constrained by tight time limits) some help and guidance. But there are other people in community too (more knowledgable in the area than me).
>>
>> I salute your initiative!
>>
>> Yours,
>> Aleksandar
>>
>>
>>
>>> I am an advanced C programmer with both professional and academic background in systems design & implementation - especially OS & Networks. Given my background, I feel fairly confident that I can pickup the QEMU codebase quickly.
>>>
>>> Eagerly looking forward to hearing from the community !
>>>
>>> Thanks,
>>> Rajath Shashidhara
>>>
>>>


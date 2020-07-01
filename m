Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F61C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 01:14:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6058720771
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 01:14:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6058720771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqRKY-0008GF-Mh
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 21:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jqRJi-0007ii-Rz; Tue, 30 Jun 2020 21:13:38 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:30814)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jqRJf-0003pT-Ve; Tue, 30 Jun 2020 21:13:38 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id DAB2A746331;
 Wed,  1 Jul 2020 03:13:31 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4BB7774594E; Wed,  1 Jul 2020 03:13:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4A260745712;
 Wed,  1 Jul 2020 03:13:31 +0200 (CEST)
Date: Wed, 1 Jul 2020 03:13:31 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: Re: [PATCH v3 0/5] hw/mips/malta: Add the 'malta-strict' machine,
 matching Malta hardware
In-Reply-To: <CAHiYmc6d3Q2A237qVqp6s0MagXqgy11aX9r_LuJsGkoJxRhfQw@mail.gmail.com>
Message-ID: <alpine.BSF.2.22.395.2007010248270.96257@zero.eik.bme.hu>
References: <20200630195723.1359-1-f4bug@amsat.org>
 <CAHiYmc6d3Q2A237qVqp6s0MagXqgy11aX9r_LuJsGkoJxRhfQw@mail.gmail.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-490760158-1593566011=:96257"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, qemu-trivial@nongnu.org,
 Yunqiang Su <ysu@wavecomp.com>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-490760158-1593566011=:96257
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 30 Jun 2020, Aleksandar Markovic wrote:
> As, in a very clear way, evidenced from the previous versions of this
> series, this series real goal was not not to create some new
> "malta-strict" machine, but to prepare path to creation of some
> imagined "malta-unleashed" machine which will, to the contrary of
> proclaimed goal, create a machine that could never exist in reality.
> That is why I can't accept this series.

I don't really want to be included in this discussion so please exclude me 
from any replies, I can read replies on the list but don't want my mailbox 
flooded with this thread. I could (and probably should) stay out of it but 
maybe can offer some outsider view and share a suggestion.

I haven't followed all this thread but if your problem with it is that 
something called malta should emulate that machine and not something 
non-existent "malta-unleashed" then how about introducing a new machine 
called virt which is a purely virtual machine? Arm has such a machine and 
is recommended to be used for those who just want a generic Linux machine 
without emulating any particular hardware. See here in docs:

https://wiki.qemu.org/Documentation/Platforms/ARM#Guidelines_for_choosing_a_QEMU_machine

I think Philippe was probably trying to do something like that with this 
series which is clearly not forbidden by any QEMU policy as evidenced by 
arm virt so maybe it's only a disagreement about how this should be named.

Keep malta to be modeling the Malta machine and add a new one called virt 
which can be a copy of the current malta initially just to start from 
somewhere (as arm was using versatilepb as mentioned above) but then the 
directions these machines will be developed further could be different: 
Malta would be developed to faithfully model the Malta machine, running 
its firmware, etc. while virt could allow having more RAM or virtio 
devices not available on real hardware. Why is that not acceptable?

Regards,
BALATON Zoltan

> Regards,
> Aleksandar
>
>
> уто, 30. јун 2020. у 21:58 Philippe Mathieu-Daudé <f4bug@amsat.org> је
> написао/ла:
>>
>> Hi,
>>
>> This series add a new 'malta-strict' machine, that aims to properly
>> model the real hardware (which is not what the current 'malta'
>> machine models).
>>
>> Since v2:
>> - Initialize missing malta_machine_types::class_size
>> - Remove RFC patch that confuses Aleksandar
>> - Added examples of 'malta-strict' use
>>
>> $ git backport-diff -u v2
>> Key:
>> [----] : patches are identical
>> [####] : number of functional differences between upstream/downstream patch
>> [down] : patch is downstream-only
>> The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively
>>
>> 001/5:[----] [--] 'hw/mips/malta: Trivial code movement'
>> 002/5:[----] [--] 'hw/mips/malta: Register the machine as a TypeInfo'
>> 003/5:[0001] [FC] 'hw/mips/malta: Introduce MaltaMachineClass::max_ramsize'
>> 004/5:[----] [--] 'hw/mips/malta: Introduce the 'malta-strict' machine'
>> 005/5:[----] [--] 'hw/mips/malta: Verify malta-strict machine uses correct DIMM sizes'
>>
>> Philippe Mathieu-Daudé (5):
>>   hw/mips/malta: Trivial code movement
>>   hw/mips/malta: Register the machine as a TypeInfo
>>   hw/mips/malta: Introduce MaltaMachineClass::max_ramsize
>>   hw/mips/malta: Introduce the 'malta-strict' machine
>>   hw/mips/malta: Verify malta-strict machine uses correct DIMM sizes
>>
>>  hw/mips/malta.c | 105 +++++++++++++++++++++++++++++++++++++++++-------
>>  1 file changed, 91 insertions(+), 14 deletions(-)
>>
>> --
>> 2.21.3
>>
>>
>
>
--3866299591-490760158-1593566011=:96257--


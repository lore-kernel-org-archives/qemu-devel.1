Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6F4C10F0B
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 08:12:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1DB020693
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 08:12:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1DB020693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37769 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH29N-0004jN-V5
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 04:12:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Mateja.Marjanovic@rt-rk.com>) id 1hH27r-0003mM-Dd
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 04:10:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Mateja.Marjanovic@rt-rk.com>) id 1hH27p-00087v-Ti
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 04:10:31 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:46369 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Mateja.Marjanovic@rt-rk.com>)
	id 1hH27p-00086p-Dg
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 04:10:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id 0C3E81A221D;
	Thu, 18 Apr 2019 10:10:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from [10.10.13.97] (rtrkw310-lin.domain.local [10.10.13.97])
	by mail.rt-rk.com (Postfix) with ESMTPSA id D1A591A20D0;
	Thu, 18 Apr 2019 10:10:27 +0200 (CEST)
To: Aleksandar Markovic <amarkovic@wavecomp.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1555491867-5922-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<BN6PR2201MB1251516C13CAE873ADDA73DBC6250@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<BN6PR2201MB1251599D75CE44B174BD5116C6250@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
Message-ID: <83a1c5ee-2974-7a1c-9df3-d6049894c287@rt-rk.com>
Date: Thu, 18 Apr 2019 10:10:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <BN6PR2201MB1251599D75CE44B174BD5116C6250@BN6PR2201MB1251.namprd22.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: Re: [Qemu-devel] [PATCH] target/mips: Amend tests for MSA binary
 integer operations
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
	"aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418081027.VeqjtZHbbbE74H8Hpn_4jPRZlkB9QCDSFiEH1YdycNo@z>


On 17.4.19. 22:22, Aleksandar Markovic wrote:
>> From: Aleksandar Markovic
>> Subject: Re: [PATCH] target/mips: Amend tests for MSA binary integer operations
>>
>>> From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
>>> Subject: [PATCH] target/mips: Amend tests for MSA binary integer operations
>>>
>>> Amend tests for certain MSA binary integer instructions
>>> (for example DIV_S.B) by appending two missing test cases
>>> to complete standard battery of 80 test cases for each
>>> such instruction. Expected values were pulled from the
>>> results of the MIPS64r6 machine that executed those
>>> instruction, and QEMU emulation should produce the same
>>> results.
>>>
>>> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
>>> ---
>> I'm afraid your patch doesn't apply to the tip of the source tree:
> Unfortunately, Mateja, even after resolving patch application conflicts,
> the code doesn't build.
>
> For example, wrappers for many MSA instructions are missing, and
> there are other problems too.
>
> The patch needs a major amending and refactoring, which I will do
> tomorrow, or in next few days, so that you can focus on your other
> remaining tasks (for example, explaining "active_fpu" role from
> another series, and big endian host MSA test failures).

Alright, I will focus on those tasks.

Thanks,
Mateja

>
> The good thing is that we will eventually expand test coverage.
>
> Thanks,
> Aleksandar


Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C13C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 15:28:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F16CB206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 15:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F16CB206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0SXb-0007JP-VH
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 11:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48741)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Sandra_Loosemore@mentor.com>) id 1i0SWu-0006XJ-ID
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:28:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Sandra_Loosemore@mentor.com>) id 1i0SWs-0004F3-4J
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:28:07 -0400
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:34013)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Sandra_Loosemore@mentor.com>)
 id 1i0SWr-0004DC-PD
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:28:06 -0400
IronPort-SDR: XsHyqUeQPfZS8TDdoy76roThbt94vCHz83P6MTzEKeq91rZ7wL+4Hf/e7ClTDffxfFbHZbtymt
 tvX91ziV9G5d+DV6n69RcW9jzg+spaj3cFgN4rsSC+Ts53NLs7KlL24Bd2hObnFFnM4AULvrCw
 /P5hKQrkRJQtx56QR9tLMkY1bXeroPM2/7Fg7clsHwKtkQNN1gSnOvSBR4L2cbzjJKh/JjJFx+
 SN4WK/QutvTila76pfswsIXo4P1QFdJWuKrKCDc/y5+F/ztuUy/BhSlCHyVRJMO+PEBrBnIHHY
 zmk=
X-IronPort-AV: E=Sophos;i="5.64,412,1559548800"; d="scan'208";a="40642337"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa3.mentor.iphmx.com with ESMTP; 21 Aug 2019 07:28:00 -0800
IronPort-SDR: 43ATZMWLknnrgChvW7SItBGarZ303YSjMb8zGBml07IAeyuhwM3sV/kvXg4kAFMliHRDj5H6t9
 1tSMy16oem7sEDtOlJSnCXr2oNnggyFWbSsgdTp0LaNPyeskviMMMDx4Vo3iwqI2WKSlI6dxEi
 cuxCrR90x4ef3+ppk9AqUQhw4NLK4FriFe3bySXUDtSFkBymheR8GvixM7Dua5EhBOgZL9yT3+
 NqIhokIdCyal0hdvWaIc/qL7WkH8r8dKtl1Clyez/vx3nRo76X0bL4VdfNe1tfIDiG/T/PJsWi
 2tM=
To: Laurent Vivier <laurent@vivier.eu>, <qemu-devel@nongnu.org>
References: <20190821142151.19995-1-sandra@codesourcery.com>
 <20190821142151.19995-2-sandra@codesourcery.com>
 <e84f586a-7238-7bbe-f519-bb7c370c404b@vivier.eu>
From: Sandra Loosemore <sandra@codesourcery.com>
Message-ID: <608fde9c-bcac-9e6f-98f0-c208bda2eb5a@codesourcery.com>
Date: Wed, 21 Aug 2019 09:27:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e84f586a-7238-7bbe-f519-bb7c370c404b@vivier.eu>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: svr-orw-mbx-04.mgc.mentorg.com (147.34.90.204) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.137.180
Subject: Re: [Qemu-devel] [PATCH 1/2] target/nios2: Fix bug in semihosted
 exit handling
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
Cc: Marek Vasut <marex@denx.de>, Chris Wulff <crwulff@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/21/19 8:41 AM, Laurent Vivier wrote:
> Le 21/08/2019 à 16:21, Sandra Loosemore a écrit :
>> This patch fixes a bug that caused semihosted exit to always return
>> status 0; it was incorrectly using the value of register R_ARG0 (which
>> contains the HOSTED_EXIT request number) instead of register R_ARG1.
>>
>> Signed-off-by: Sandra Loosemore <sandra@codesourcery.com>
>> ---
>>   target/nios2/nios2-semi.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/nios2/nios2-semi.c b/target/nios2/nios2-semi.c
>> index d7a80dd..06c0861 100644
>> --- a/target/nios2/nios2-semi.c
>> +++ b/target/nios2/nios2-semi.c
>> @@ -215,8 +215,8 @@ void do_nios2_semihosting(CPUNios2State *env)
>>       args = env->regs[R_ARG1];
>>       switch (nr) {
>>       case HOSTED_EXIT:
>> -        gdb_exit(env, env->regs[R_ARG0]);
>> -        exit(env->regs[R_ARG0]);
>> +        gdb_exit(env, env->regs[R_ARG1]);
>> +        exit(env->regs[R_ARG1]);
> 
> It's weird: in line 215,  env->regs[R_ARG1] is args.
> 
> Are you sure it's not something like:
> 
>          GET_ARG(0)
>          gdb_exit(env, arg0);
>          exit(arg0);
> 
> same for m68k.
> 
> Did you check the kernel code?

It's not the kernel that's involved here, it's libgloss.  And yes, the 
HOSTED_EXIT case takes an immediate argument in the register rather than 
a pointer to an argument block.

Here's the documentation for nios2 semihosting.

https://www.sourceware.org/git/gitweb.cgi?p=newlib-cygwin.git;a=blob;f=libgloss/nios2/nios2-semi.txt;h=ded3a093c03dbae84cb95b4cd45bc3e0d751eda2;hb=HEAD

And m68k:

https://www.sourceware.org/git/gitweb.cgi?p=newlib-cygwin.git;a=blob;f=libgloss/m68k/m68k-semi.txt;h=50520c15292aa7edf7eef28e09fd9202ce75b153;hb=HEAD

Again, a lot of cutting and pasting involved here.  ;-)

-Sandra


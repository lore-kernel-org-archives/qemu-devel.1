Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB892C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 10:00:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2547020789
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 10:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2547020789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc3yR-0000zQ-Pp
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 05:00:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.chen@huawei.com>)
 id 1kc3uN-0005Kt-DR; Mon, 09 Nov 2020 04:56:19 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2337)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.chen@huawei.com>)
 id 1kc3uJ-0006oQ-Ps; Mon, 09 Nov 2020 04:56:19 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CV5wX0xCDzkb91;
 Mon,  9 Nov 2020 17:55:56 +0800 (CST)
Received: from [10.174.187.138] (10.174.187.138) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Mon, 9 Nov 2020 17:56:05 +0800
Message-ID: <5FA91234.1010708@huawei.com>
Date: Mon, 9 Nov 2020 17:56:04 +0800
From: Alex Chen <alex.chen@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64;
 rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] qtest: Fix bad printf format specifiers
References: <5FA28117.3020802@huawei.com>
 <67eca43e-99ea-f2ce-5d9e-a9cb5c7a3a83@redhat.com>
 <5FA38A32.2020008@huawei.com>
 <18690aa2-3de9-70ad-477f-934724b284a0@redhat.com>
 <87wnyzouy4.fsf@dusky.pond.sub.org>
 <1fd5965d-cf5e-b41b-2029-bd3e52c3e498@redhat.com>
 <8f5ef0b8-4c43-034f-f609-e7e5ca013970@redhat.com>
 <87d00narns.fsf@dusky.pond.sub.org>
In-Reply-To: <87d00narns.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.187.138]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190; envelope-from=alex.chen@huawei.com;
 helo=szxga04-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 03:21:00
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: lvivier@redhat.com, Thomas Huth <thuth@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, QEMU <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVk?= =?UTF-8?B?w6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020/11/9 15:57, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>> On 06/11/2020 15.18, Philippe Mathieu-Daudé wrote:
>>> On 11/6/20 7:33 AM, Markus Armbruster wrote:
>>>> Thomas Huth <thuth@redhat.com> writes:
>>>>
>>>>> On 05/11/2020 06.14, AlexChen wrote:
>>>>>> On 2020/11/4 18:44, Thomas Huth wrote:
>>>>>>> On 04/11/2020 11.23, AlexChen wrote:
>>>>>>>> We should use printf format specifier "%u" instead of "%d" for
>>>>>>>> argument of type "unsigned int".
>>>>>>>>
>>>>>>>> Reported-by: Euler Robot <euler.robot@huawei.com>
>>>>>>>> Signed-off-by: Alex Chen <alex.chen@huawei.com>
>>>>>>>> ---
>>>>>>>>  tests/qtest/arm-cpu-features.c | 8 ++++----
>>>>>>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>>>>>>
[...]
>>>>>>>>
>>>>>>>
>>>>>>> max_vq and vq are both "uint32_t" and not "unsigned int" ... so if you want
>>>>>>> to fix this really really correctly, please use PRIu32 from inttypes.h instead.
>>>>>>>
>>>>>>
>>>>>> Hi Thomas,
>>>>>> Thanks for your review.
>>>>>> According to the definition of the macro PRIu32(# define PRIu32         "u"),
>>>>>> using PRIu32 works the same as using %u to print, and using PRIu32 to print
>>>>>> is relatively rare in QEMU(%u 720, PRIu32 only 120). Can we continue to use %u to
>>>>>> print max_vq and vq in this patch.
>>>>>> Of course, this is just my small small suggestion. If you think it is better to use
>>>>>> PRIu32 for printing, I will send patch V2.
>>>>>
>>>>> Well, %u happens to work since "int" is 32-bit with all current compilers
>>>>> that we support.
>>>>
>>>> Yes, it works.
>>>>
>>>>>                  But if there is ever a compiler where the size of int is
>>>>> different, you'll get a compiler warning here again.
>>>>
>>>> No, we won't.
>>>>
>>>> If we ever use a compiler where int is narrower than 32 bits, then the
>>>> type of the argument is actually uint32_t[1].  We can forget about this
>>>> case, because "int narrower than 32 bits" is not going to fly with our
>>>> code base.
>>
>> Agreed.
>>
>>>> If we ever use a compiler where int is wider than 32 bits, then the type
>>>> of the argument is *not* uint32_t[2].  PRIu32 will work anyway, because
>>>> it will actually retrieve an unsigned int argument, *not* an uint32_t
>>>> argument[3].
>>
>> I can hardly believe that this can be true. Sure, it's true for such cases
>> like this one here, where you multiply with an "int". But if you just try to
>> print a plain uint32_t variable?
> 
> Default argument promotions (§6.5.2.2 Function calls) still apply: "the
> integer promotions are performed on each argument, and arguments that
> have type float are promoted to double."
> 
>> I've seen compiler warning in cases one tries to print a 16-bit (i.e. short)
>> variable in the past if you use %d instead of the proper PRId16 (or %hd)
>> format specifier - maybe not on x86, but certainly on other architectures.
>> If you're statement was right, that should not have happened, should it?
> 
> §7.19.6.1 "The fprintf function" on length modifier 'h':
> 
>     Specifies that a following d, i, o, u, x, or X conversion specifier
>     applies to a short int or unsigned short int argument (the argument
>     will have been promoted according to the integer promotions, but its
>     value shall be converted to short int or unsigned short int before
>     printing)
> 
> Integer promotions preserve value including sign.  So, printing a short
> value with %hd first promotes it to int, then converts it back to short.
> Neither conversion has an effect.
> 
> However, printing an int with %hd has: it converts int to short.
> Implementation-defined behavior when the value doesn't fit.
> 
> Length modifier 'h' is pretty pointless with printf().  So would be a
> warning to nudge people towards its use.
> 
> In fact, GNU libc's PRIu32 does not use it.  inttypes.h:
> 
>     /* Unsigned integers.  */
>     # define PRIu8		"u"
>     # define PRIu16		"u"
>     # define PRIu32		"u"
>     # define PRIu64		__PRI64_PREFIX "u"
> 
> where __PRI64_PREFIX is "l" or "ll" depending on system-dependent
> __WORDSIZE.
> 
> In short:
> 
>>>> In other words "%" PRIu32 is just a less legible alias for "%u" in all
>>>> cases that matter.
> 

Hi Markus,

Thanks for your reply, I have learned a lot.
May I understand it as follows:
%u is used when there are parameters obtained by arithmetic operation;
otherwise, PRIu32 is used to print uint32_t type parameters?

Thanks,
Alex




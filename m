Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F23BC2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 06:40:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13DBE2072A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 06:40:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13DBE2072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM4OK-0006qb-9a
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 02:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33233)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Brice.Goglin@inria.fr>) id 1jM4Nh-00068F-KK
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 02:40:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Brice.Goglin@inria.fr>) id 1jM4Ng-0002Kc-0A
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 02:40:13 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:52860)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Brice.Goglin@inria.fr>)
 id 1jM4Nf-0002HP-LC
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 02:40:11 -0400
X-IronPort-AV: E=Sophos;i="5.72,357,1580770800"; d="scan'208";a="345309155"
Received: from 91-160-5-165.subs.proxad.net (HELO [192.168.44.21])
 ([91.160.5.165])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-SHA;
 08 Apr 2020 08:40:07 +0200
Subject: Re: linux-user: keep the name-ending parenthesis in /proc/self/stat
From: Brice Goglin <Brice.Goglin@inria.fr>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
References: <f7720d36-a5ea-ae13-220a-2e436e6a22a4@inria.fr>
 <3f2cb9a1-00aa-cc59-d685-2c88e6f986c7@redhat.com>
 <4ac78bc6-35d6-5705-9e75-4e48436d8589@inria.fr>
Autocrypt: addr=Brice.Goglin@inria.fr; prefer-encrypt=mutual; keydata=
 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
Message-ID: <197d29e7-c26d-9c55-6278-f37da0dd760e@inria.fr>
Date: Wed, 8 Apr 2020 08:40:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <4ac78bc6-35d6-5705-9e75-4e48436d8589@inria.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.134.164.104
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 31/03/2020 à 00:29, Brice Goglin a écrit :
> Le 31/03/2020 à 00:05, Philippe Mathieu-Daudé a écrit :
>> On 3/30/20 9:07 PM, Brice Goglin wrote:
>>> When the program name is very long, qemu-user may truncate it in
>>> /proc/self/stat. However the truncation must keep the ending ") "
>>> to conform to the proc manpage which says:
>>>      (2) comm  %s
>>>             The  filename of the executable, in parentheses.  This
>>>             is visible whether or not the  executable  is  swapped
>>>             out.
>>>
>>> To reproduce:
>>> $ ln -s /bin/cat <filenamewithmorethan128chars>
>>> $ qemu-x86_64 ./<filenamewithmorethan128chars> /proc/self/stat
>>>
>>> Before the patch, you get:
>>> 1134631 (<filenametruncated>0 0 0 0 0 0 0 0 ...
>>> After the patch:
>>> 1134631 (<filenametruncat>) 0 0 0 0 0 0 0 0 ...
>>>
>>> This fixes an issue with hwloc failing to parse /proc/self/stat
>>> when Ludovic Courtes was testing it in guix over qemu-aarch64.
>>>
>>> Signed-off-by: Brice Goglin<Brice.Goglin@inria.fr>
>>>
>>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>>> index 5af55fca78..a1126dcf5b 100644
>>> --- a/linux-user/syscall.c
>>> +++ b/linux-user/syscall.c
>>> @@ -7305,7 +7305,10 @@ static int open_self_stat(void *cpu_env, int fd)
>>>           snprintf(buf, sizeof(buf), "%"PRId64 " ", val);
>>>         } else if (i == 1) {
>>>           /* app name */
>>> -        snprintf(buf, sizeof(buf), "(%s) ", ts->bprm->argv[0]);
>>> +        len = snprintf(buf, sizeof(buf), "(%s) ", ts->bprm->argv[0]);
>>> +        if (len >= sizeof(buf))
>>> +          /* bring back the ending ") " that was truncated */
>>> +          strcpy(buf+sizeof(buf)-3, ") ");
>> Maybe we can avoid the sprintf() call:
>>
>> -- >8 --
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -7305,7 +7305,11 @@ static int open_self_stat(void *cpu_env, int fd)
>>          snprintf(buf, sizeof(buf), "%"PRId64 " ", val);
>>        } else if (i == 1) {
>>          /* app name */
>> -        snprintf(buf, sizeof(buf), "(%s) ", ts->bprm->argv[0]);
>> +        char *ptr = buf;
>> +
>> +        *ptr++ = '(';
>> +        ptr = stpncpy(ptr, ts->bprm->argv[0], sizeof(buf) - 3);
>> +        strcpy(ptr, ") ");
>>        } else if (i == 27) {
>>          /* stack bottom */
>>          val = start_stack;
>>
> This works too.


Hello

Is anybody going to fix this anyhow for the next release?

Thank you

Brice




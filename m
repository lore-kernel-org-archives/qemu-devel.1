Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966FDC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:16:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B425207FC
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B425207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7cFt-00060v-Tm
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7bsk-0002ns-PT
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:52:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7bsj-0001V5-JQ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:52:14 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:35385)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i7bsj-0001UY-8w
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:52:13 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MIxFi-1hrbSt1yYc-00KO17; Tue, 10 Sep 2019 10:52:01 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20190908061543.25136-1-f4bug@amsat.org>
 <20190908061543.25136-4-f4bug@amsat.org>
 <696b8e27-f383-c7bf-20ee-1f596949cbf4@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <fead7d1b-024f-0459-496d-da3ebc203c4d@vivier.eu>
Date: Tue, 10 Sep 2019 10:52:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <696b8e27-f383-c7bf-20ee-1f596949cbf4@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wCV9LnBecZUh/gUzNLEC85NnZzKvnek9ae04LAS2t6hu9eJp9Kx
 VHSQMi3kTDbKbxTdoUZFSv5r7CGQlwmAJ3v2O/8vZKHi6R08ZhAvSkhZvCmp08P8YZVv5Yz
 yQhzCut4ycBRyhWw1jY/QT0q4DTFuTlH5L1EmbsdM7SkUnxoa3tWLxIQBa6HKx/EeBnOJTL
 bz+GI00GxqS3m492Nob4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SFch8L14uh0=:q8WInwdsUfJYgiauUBFnYG
 6vIQOYMS+4k2XKQCtZ5uM/djfMmO3P3casRDCOEt2wZnZ29miVR3Hl7np3gDCGAKuhkV/282I
 wOV6r9g92xEgTbNkPWRkmMBbHx/06smOF4iE7s4tQMOSjz8F4ueO2udibca37qIPqFihHIoNH
 a71AO2lRVKF59SJqTqOPYamjcGSgN9lD86iXFktefA4W4odXPc+U+Ue2AeOFTpvsYg0QJMhMD
 FEikP/csnsimW84JAnLpkZ3ZAxDudKFDIywca2m6dBb7lJo3s2sfeyFetoOZRpW1LWXdyoxiz
 YYTzf4SKvIbY44zxgvye48JczHMFh4sjgAr7oY9PQGNQR60lac43h/n42Y+goLEIHmLpt+n6X
 dPDgefnJERzM6klYL5CKDIF8yC+z6CrmT1papAAjrk48e1BhrOK+R7AES6L0+fYc5f85SSUVc
 v70z17XJI6cdhy0esudEL31aPwEQYprhp8uqsujbrqZq21r7lIQExsbZxI/wbU6QoyRmcmJCU
 cMP19visQiJy3JaA2Q9D/1tdKxnQaImCzg9BssyjdiarVBmh6b5xZA5OnxR5DhUuC7GN3QKjw
 pNxcF4x0Le/baelJ0Dln8/r7f4rOwOmnUJ0XOKW+QJ455z+afckEAJfL97aVkiqOuW6G6QVHB
 dv5lUnwnwnjT/3NC5vw1K5G1+yUn/OnPy22sPCxyCzmiwNqhPFqQavSkte1tRFsBxOJZMKzwW
 7lqIWC/CtZteykw7446ymIDXSVlCgXhbu/cEogLooMLP+rbBPs/D8j+r61UdifePZbNAEgH9r
 /0AckrIxGBO3+qUaYZFWsDZjyJ7Ug==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
Subject: Re: [Qemu-devel] [PATCH v6 3/8] linux-user/strace: Improve
 settimeofday()
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
Cc: =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>,
 Riku Voipio <riku.voipio@iki.fi>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 10/09/2019 à 10:30, Laurent Vivier a écrit :
> Le 08/09/2019 à 08:15, Philippe Mathieu-Daudé a écrit :
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> Tested-By: Guido Günther <agx@sigxcpu.org>
>> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>>  linux-user/strace.c    | 13 +++++++++++++
>>  linux-user/strace.list |  2 +-
>>  2 files changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/linux-user/strace.c b/linux-user/strace.c
>> index 5ee9d62c25..dcf843b360 100644
>> --- a/linux-user/strace.c
>> +++ b/linux-user/strace.c
>> @@ -1584,6 +1584,19 @@ print_futimesat(const struct syscallname *name,
>>  }
>>  #endif
>>  
>> +#ifdef TARGET_NR_settimeofday
>> +static void
>> +print_settimeofday(const struct syscallname *name,
>> +                abi_long arg0, abi_long arg1, abi_long arg2,
>> +                abi_long arg3, abi_long arg4, abi_long arg5)
>> +{
>> +    print_syscall_prologue(name);
>> +    print_timeval(arg0, 0);
>> +    print_timezone(arg1, 1);
>> +    print_syscall_epilogue(name);
>> +}
>> +#endif
>> +
>>  #ifdef TARGET_NR_link
>>  static void
>>  print_link(const struct syscallname *name,
>> diff --git a/linux-user/strace.list b/linux-user/strace.list
>> index 63a946642d..1ff9168369 100644
>> --- a/linux-user/strace.list
>> +++ b/linux-user/strace.list
>> @@ -1345,7 +1345,7 @@
>>  { TARGET_NR_set_tid_address, "set_tid_address" , NULL, NULL, NULL },
>>  #endif
>>  #ifdef TARGET_NR_settimeofday
>> -{ TARGET_NR_settimeofday, "settimeofday" , NULL, NULL, NULL },
>> +{ TARGET_NR_settimeofday, "settimeofday" , NULL, print_settimeofday, NULL },
>>  #endif
>>  #ifdef TARGET_NR_setuid
>>  { TARGET_NR_setuid, "setuid" , NULL, NULL, NULL },
>>
> 
> Applied to my linux-user branch.

Unapplied as it depends on the previous one.

Thanks,
Laurent


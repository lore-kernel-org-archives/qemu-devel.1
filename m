Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC97C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:29:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D413220754
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D413220754
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO3KH-0004as-O8
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 14:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kO30U-0002kC-4N
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 14:08:42 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:35555)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kO30R-00016v-4c
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 14:08:41 -0400
Received: from [192.168.100.1] ([82.252.145.98]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MHX3X-1kB8iE38bp-00DYMp; Thu, 01 Oct 2020 20:08:15 +0200
To: Taylor Simpson <tsimpson@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1601314138-9930-1-git-send-email-tsimpson@quicinc.com>
 <1601314138-9930-28-git-send-email-tsimpson@quicinc.com>
 <97b7864c-f4b2-ae8a-9ad0-d1d3c1fb309c@vivier.eu>
 <BYAPR02MB488639031FDA8E05DA560CD5DE330@BYAPR02MB4886.namprd02.prod.outlook.com>
 <a7035857-28d6-4960-234f-27246aabbbb3@vivier.eu>
 <BYAPR02MB48863E6D16D6C5ED0ACB847EDE300@BYAPR02MB4886.namprd02.prod.outlook.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [RFC PATCH v4 27/29] Hexagon (linux-user/hexagon) Linux user
 emulation
Message-ID: <d12c9e06-927f-a47c-01b0-af7490767155@vivier.eu>
Date: Thu, 1 Oct 2020 20:08:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <BYAPR02MB48863E6D16D6C5ED0ACB847EDE300@BYAPR02MB4886.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Whm69CUaUR9FNfsrt8clfdxiCn9CvzDhF58ZbJUTz+1uv+IDJvT
 IfSZGkTyNNfHMZ8MC0pgpVDS6RSLPzFicEO57RDGtsUdfUajDmaQy6LqEM5uNeGKm4oLIEP
 WHL01LPZ+qcFDiScRv5TsavzzyvrCOtUkA+n4RgdTW/l8dcsNcfi9Ot8WFf9zlbZwtLi+it
 DIXeijTGtAm7EjATo++/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8PPnllywsMg=:0QIOEgSOXBjcTUIDPB4hLI
 DiikiAgCKE1hV40pJ9Q3/RoQdao/JUxT69UCWQlhvlV1TOZX5anrXd8NETH3SzlB5UiemW8LI
 9zfRKYsAdki/rwTMcJCe4Iwa8zzyzb/DBed1lvS9GRr79afpCMEQwAXb0C3Loz+R9KWLdtIgD
 yESoYXOP/39Wn7OViU3NpQQbNpd99b3BZNZ64kH4U3+5ota2SXqOJqeI+oVO06RLvGgZ5tOaV
 M+lP3KxwOTOuq2DmXjlCvjNZBWautjRmV1A0nQ8/VUc6Xf5zdOgHgZkOxY+S75ei/OyN+rRkV
 TQWtHw8GHZwQjkQCrxjv11psWtV80vQnBZiptZYLqyzTPLeE/Pyy0nL+HH/76D6urlvmfW9Os
 6SlASdVC8US03KWEEl5KtVU9CSylk51jwwha5U3idd5Q/EXm/mNv9oEzc45OFRwzNiE/vgN0b
 Xi1inQQSlTu+nwnKG2xzdykXs5OWgGPRohKL3q/TdB6L49xXJ+nq2sKTLa33tZe+x/PQ4opLs
 Zu2Tne2t79R7o9A3onr0fBEBMYVPFtebaonDpYN2dwKysvAb+AZR9+xa+4qcSH41LDJ38pZ7S
 McdRLlMJQToDeFX4ZQwGc8NE2dIHfnjKXbAgk9A9JbhqGF/+eGL6T5LaKpW4vYvLSXUJ/FF/S
 dbii8+N8iWDH1x08Nj6SbwlCxsH6Qh880R/KESOSjfbBYbjIETP1AD5KKlwfYS5U55mH16Ixc
 XxVNm2DXdIbIGVajx4ETotyAQnwDZZ+j68KMXJPMtHIo73u2ykQBUCCEJ8qk0XPuof0OlcVpA
 Cl5nQEgbCz3Vmq3TEuXbK6NcuqmS2+uCywRMZgqSUCBZfWYbdj5LhRDy3ITmCOn+a2qWS60
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 14:08:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.26,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: "ale@rev.ng" <ale@rev.ng>, "philmd@redhat.com" <philmd@redhat.com>,
 "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "aleksandar.m.mail@gmail.com" <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 01/10/2020 à 17:40, Taylor Simpson a écrit :
> 
> 
>> -----Original Message-----
>> From: Laurent Vivier <laurent@vivier.eu>
>> Sent: Thursday, October 1, 2020 1:53 AM
>> To: Taylor Simpson <tsimpson@quicinc.com>; qemu-devel@nongnu.org
>> Cc: richard.henderson@linaro.org; philmd@redhat.com; riku.voipio@iki.fi;
>> aleksandar.m.mail@gmail.com; ale@rev.ng
>> Subject: Re: [RFC PATCH v4 27/29] Hexagon (linux-user/hexagon) Linux user
>> emulation
>>
>> Le 30/09/2020 à 22:47, Taylor Simpson a écrit :
>>>
>>>
>>>> -----Original Message-----
>>>> From: Laurent Vivier <laurent@vivier.eu>
>>>> Sent: Monday, September 28, 2020 3:03 PM
>>>> To: Taylor Simpson <tsimpson@quicinc.com>; qemu-devel@nongnu.org
>>>> Cc: richard.henderson@linaro.org; philmd@redhat.com; riku.voipio@iki.fi;
>>>> aleksandar.m.mail@gmail.com; ale@rev.ng
>>>> Subject: Re: [RFC PATCH v4 27/29] Hexagon (linux-user/hexagon) Linux
>> user
>>>> emulation
>>>>
>>>>> +
>>>>> +syscall_nr_generators += {
>>>>> +  'hexagon': generator(sh,
>>>>> +                       arguments: [ 'cat', 'syscall_nr.h', '>', '@OUTPUT@' ],
>>>>> +                     output: '@BASENAME@_nr.h')
>>>>
>>>> Why do we need that?
>>>> The syscall_nr_generators is used to generate syscall_nr.h from syscall.tbl
>>>
>>> The other linux-user targets have this in their meson.build files.  I'll remove
>> if it's not needed.
>>
>> Not all the targets (only the ones with syscall.tbl) and they call
>> syscallhdr.sh and not cat. So you can remove it.
>>
>>>>
>>>>> +}
>>>>> diff --git a/linux-user/meson.build b/linux-user/meson.build
>>>>> index 2b94e4b..8b1dfc8 100644
>>>>> --- a/linux-user/meson.build
>>>>> +++ b/linux-user/meson.build
>>>>> @@ -22,6 +22,7 @@ syscall_nr_generators = {}
>>>>>
>>>>>  subdir('alpha')
>>>>>  subdir('arm')
>>>>> +subdir('hexagon')
>>>>
>>>> so you don't need that either
>>>
>>> OK
>>>
>>>>> -    grep -e "#define __NR_" -e "#define __NR3264"
>>>>> +    grep -e "#define __NR_" -e "#define __NR3264" | grep -v
>>>> __NR_syscalls
>>>>
>>>> Why do you remove __NR_syscalls?
>>>
>>> Older kernels have a bunch of
>>> #undef __NR_syscalls
>>> #define __NR_syscalls  X
>>>
>>> The script removes all #undef's but leaves the #define's, so we get compile
>> errors.  That symbol isn't used by qemu so it's safe to remove.
>>>
>>
>> As the syscall_nr.h generated from syscall.tbl don't have this symbol, I
>> think we can remove it. But I'm very surprised it doesn't work with it
>> for you.
>>
>> Could you put this one-line change in a separate patch?
>>
>> The best would be to re-run it once the change is made to update all the
>> generated syscall_nr.h without the __NR_syscalls line.
>>
>> Moreover the syscall_nr.h I generate from linux-5.9 for hexagon is
>> different from the one you put in this series (the 1024 -> 1079 part is
>> missing).
> 
> The syscall_nr.h I submitted is from 4.9, and we are in the process of upgrading the toolchain/kernel/etc.

Do you know why the syscalls between 1024 and 1079 are in your
syscall_nr.h while they are not in linux 4.9?
(They are normally enabled by __ARCH_WANT_SYSCALL_DEPRECATED)

> 
> Which versions of the kernel does qemu expect to support?  I'll investigate whether those versions have multiple __NR_syscalls.  If not, there's no need for that change.

For linux-user, we have all the linux-user targets at the same syscall
API level, and we update them to have the definitions from the latest
kernel.

Thanks,
Laurent


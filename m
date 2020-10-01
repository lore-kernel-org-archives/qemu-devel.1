Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F71C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 07:54:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FF372145D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 07:54:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FF372145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNtPj-0006Mr-GN
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 03:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kNtPA-0005wA-9t
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 03:53:32 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:58395)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kNtP8-0006av-At
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 03:53:32 -0400
Received: from [192.168.100.1] ([82.252.145.98]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MfqCF-1kuUGY1xJR-00gFz0; Thu, 01 Oct 2020 09:53:07 +0200
To: Taylor Simpson <tsimpson@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1601314138-9930-1-git-send-email-tsimpson@quicinc.com>
 <1601314138-9930-28-git-send-email-tsimpson@quicinc.com>
 <97b7864c-f4b2-ae8a-9ad0-d1d3c1fb309c@vivier.eu>
 <BYAPR02MB488639031FDA8E05DA560CD5DE330@BYAPR02MB4886.namprd02.prod.outlook.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 mQINBFYFJhkBEAC2me7w2+RizYOKZM+vZCx69GTewOwqzHrrHSG07MUAxJ6AY29/+HYf6EY2
 WoeuLWDmXE7A3oJoIsRecD6BXHTb0OYS20lS608anr3B0xn5g0BX7es9Mw+hV/pL+63EOCVm
 SUVTEQwbGQN62guOKnJJJfphbbv82glIC/Ei4Ky8BwZkUuXd7d5NFJKC9/GDrbWdj75cDNQx
 UZ9XXbXEKY9MHX83Uy7JFoiFDMOVHn55HnncflUncO0zDzY7CxFeQFwYRbsCXOUL9yBtqLer
 Ky8/yjBskIlNrp0uQSt9LMoMsdSjYLYhvk1StsNPg74+s4u0Q6z45+l8RAsgLw5OLtTa+ePM
 JyS7OIGNYxAX6eZk1+91a6tnqfyPcMbduxyBaYXn94HUG162BeuyBkbNoIDkB7pCByed1A7q
 q9/FbuTDwgVGVLYthYSfTtN0Y60OgNkWCMtFwKxRaXt1WFA5ceqinN/XkgA+vf2Ch72zBkJL
 RBIhfOPFv5f2Hkkj0MvsUXpOWaOjatiu0fpPo6Hw14UEpywke1zN4NKubApQOlNKZZC4hu6/
 8pv2t4HRi7s0K88jQYBRPObjrN5+owtI51xMaYzvPitHQ2053LmgsOdN9EKOqZeHAYG2SmRW
 LOxYWKX14YkZI5j/TXfKlTpwSMvXho+efN4kgFvFmP6WT+tPnwARAQABtCJMYXVyZW50IFZp
 dmllciA8bGF1cmVudEB2aXZpZXIuZXU+iQI4BBMBAgAiBQJWBTDeAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAAKCRDzDDi9Py++PCEdD/oD8LD5UWxhQrMQCsUgLlXCSM7sxGLkwmmF
 ozqSSljEGRhffxZvO35wMFcdX9Z0QOabVoFTKrT04YmvbjsErh/dP5zeM/4EhUByeOS7s6Yl
 HubMXVQTkak9Wa9Eq6irYC6L41QNzz/oTwNEqL1weV1+XC3TNnht9B76lIaELyrJvRfgsp9M
 rE+PzGPo5h7QHWdL/Cmu8yOtPLa8Y6l/ywEJ040IoiAUfzRoaJs2csMXf0eU6gVBhCJ4bs91
 jtWTXhkzdl4tdV+NOwj3j0ukPy+RjqeL2Ej+bomnPTOW8nAZ32dapmu7Fj7VApuQO/BSIHyO
 NkowMMjB46yohEepJaJZkcgseaus0x960c4ua/SUm/Nm6vioRsxyUmWd2nG0m089pp8LPopq
 WfAk1l4GciiMepp1Cxn7cnn1kmG6fhzedXZ/8FzsKjvx/aVeZwoEmucA42uGJ3Vk9TiVdZes
 lqMITkHqDIpHjC79xzlWkXOsDbA2UY/P18AtgJEZQPXbcrRBtdSifCuXdDfHvI+3exIdTpvj
 BfbgZAar8x+lcsQBugvktlQWPfAXZu4Shobi3/mDYMEDOE92dnNRD2ChNXg2IuvAL4OW40wh
 gXlkHC1ZgToNGoYVvGcZFug1NI+vCeCFchX+L3bXyLMg3rAfWMFPAZLzn42plIDMsBs+x2yP
 +bkCDQRWBSYZARAAvFJBFuX9A6eayxUPFaEczlMbGXugs0mazbOYGlyaWsiyfyc3PStHLFPj
 rSTaeJpPCjBJErwpZUN4BbpkBpaJiMuVO6egrC8Xy8/cnJakHPR2JPEvmj7Gm/L9DphTcE15
 92rxXLesWzGBbuYxKsj8LEnrrvLyi3kNW6B5LY3Id+ZmU8YTQ2zLuGV5tLiWKKxc6s3eMXNq
 wrJTCzdVd6ThXrmUfAHbcFXOycUyf9vD+s+WKpcZzCXwKgm7x1LKsJx3UhuzT8ier1L363RW
 ZaJBZ9CTPiu8R5NCSn9V+BnrP3wlFbtLqXp6imGhazT9nJF86b5BVKpF8Vl3F0/Y+UZ4gUwL
 d9cmDKBcmQU/JaRUSWvvolNu1IewZZu3rFSVgcpdaj7F/1aC0t5vLdx9KQRyEAKvEOtCmP4m
 38kU/6r33t3JuTJnkigda4+Sfu5kYGsogeYG6dNyjX5wpK5GJIJikEhdkwcLM+BUOOTi+I9u
 tX03BGSZo7FW/J7S9y0l5a8nooDs2gBRGmUgYKqQJHCDQyYut+hmcr+BGpUn9/pp2FTWijrP
 inb/Pc96YDQLQA1q2AeAFv3Rx3XoBTGl0RCY4KZ02c0kX/dm3eKfMX40XMegzlXCrqtzUk+N
 8LeipEsnOoAQcEONAWWo1HcgUIgCjhJhBEF0AcELOQzitbJGG5UAEQEAAYkCHwQYAQIACQUC
 VgUmGQIbDAAKCRDzDDi9Py++PCD3D/9VCtydWDdOyMTJvEMRQGbx0GacqpydMEWbE3kUW0ha
 US5jz5gyJZHKR3wuf1En/3z+CEAEfP1M3xNGjZvpaKZXrgWaVWfXtGLoWAVTfE231NMQKGoB
 w2Dzx5ivIqxikXB6AanBSVpRpoaHWb06tPNxDL6SVV9lZpUn03DSR6gZEZvyPheNWkvz7bE6
 FcqszV/PNvwm0C5Ju7NlJA8PBAQjkIorGnvN/vonbVh5GsRbhYPOc/JVwNNr63P76rZL8Gk/
 hb3xtcIEi5CCzab45+URG/lzc6OV2nTj9Lg0SNcRhFZ2ILE3txrmI+aXmAu26+EkxLLfqCVT
 ohb2SffQha5KgGlOSBXustQSGH0yzzZVZb+HZPEvx6d/HjQ+t9sO1bCpEgPdZjyMuuMp9N1H
 ctbwGdQM2Qb5zgXO+8ZSzwC+6rHHIdtcB8PH2j+Nd88dVGYlWFKZ36ELeZxD7iJflsE8E8yg
 OpKgu3nD0ahBDqANU/ZmNNarBJEwvM2vfusmNnWm3QMIwxNuJghRyuFfx694Im1js0ZY3LEU
 JGSHFG4ZynA+ZFUPA6Xf0wHeJOxGKCGIyeKORsteIqgnkINW9fnKJw2pgk8qHkwVc3Vu+wGS
 ZiJK0xFusPQehjWTHn9WjMG1zvQ5TQQHxau/2FkP45+nRPco6vVFQe8JmgtRF8WFJA==
Subject: Re: [RFC PATCH v4 27/29] Hexagon (linux-user/hexagon) Linux user
 emulation
Message-ID: <a7035857-28d6-4960-234f-27246aabbbb3@vivier.eu>
Date: Thu, 1 Oct 2020 09:53:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <BYAPR02MB488639031FDA8E05DA560CD5DE330@BYAPR02MB4886.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:L3XskGa+dWNvKV3gO/oR/YrTWWoOZNsKP+imErpQ/GxDRnjuN3b
 Arai6wxA/u7AlQtXzFCZQJsKYlMwHHsPUKgm2IHPVIgzeXLRNJbKTZE9jsisrmMumyHCFop
 aXldGYRpPjADEfp7Cd3Rh6srEpjtCjR7l965qXFIiAzdB4FPv6PBE7nzJKcsuSzjYF/vw8f
 H8jfg/aYs4cEqcAyk0IBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jHoiN+ADYeQ=:8r5kip2LBCvg7HeAr1DPyY
 V5J1kRTfVL3JL18LBT5jRPagXEgFVwkfWjBK6RqD+J2w1pcW7YBRXDCyqooEnroWKELoIsQBR
 9LsV+hJww7PvhYDwF3fqOPPFkjbrysp7LgW8qh7rOKdV0S+hqMLzuUprAN8HS09P9kP/TDP1V
 eRR8qVwYAd2sgM2oCKiizWdXxyQc7+w8InVEzEiQIKR1L5Dk288Us0nFxxXcjfC/aRSy1KqKW
 iw57MqnTb+g3+uq85VkK6NO2i2UD9FlY/Vzt9Q5eZ8lEp3iVA2Bs3at/W0PslD9+YEaa3T0v6
 r9Xr8PBtVK94qIdO8x7szPDtR4b7M3RE4gNHu6G0fOXOuhFwQ4biTe7PplVoWyPEG4ei9jHF7
 yvuJ+2r3+sxwOH8NS/ZcC2/zJOq+AjzYNgcokK1FO7FsYcN2z70b7kbcxTSR8Xg4q07Iyox+J
 0TwoxxUv8H7fcXg5XCVn//fo/2FEmYZjKLzAGPYux0+jUa4dXWw2Ek87utZ2dWnZ90tqI+Xbr
 Y8xCcg9neuwv9WC9XRN23mlUoBgVbKvZhiYaQvxyXdcPiN+DHhIW1LKmjgzYNg4xR50rk04jj
 cICy6ANLzzAMoz/Vlddot5fmyB8Fc5Ds1hoROLnJF3JJjWxPkMIG5k/2g/Y6czi73NQAgOUoZ
 3rSX6zl6qN7/x4ppWIvRJ6vlZNOdy5HBITASB9VyZkuQ/cJXtPLZ8ZkKoYJOtyX1oIOVy0k2J
 0bMkb1WkxImcYlMlzj6LDiq2h4jn5NqbklbecjtllvQXb+j4J2SRhpivKAUuhMOtHd+vouObU
 0d7EoV+MJsrdGMY6CjqEnemP/KeoF0KKCq1ezySRD4OkgWwqW39LaZ2JHWUcxOyM6Jzeyqx
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 03:53:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.373, SPF_HELO_NONE=0.001,
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

Le 30/09/2020 à 22:47, Taylor Simpson a écrit :
> 
> 
>> -----Original Message-----
>> From: Laurent Vivier <laurent@vivier.eu>
>> Sent: Monday, September 28, 2020 3:03 PM
>> To: Taylor Simpson <tsimpson@quicinc.com>; qemu-devel@nongnu.org
>> Cc: richard.henderson@linaro.org; philmd@redhat.com; riku.voipio@iki.fi;
>> aleksandar.m.mail@gmail.com; ale@rev.ng
>> Subject: Re: [RFC PATCH v4 27/29] Hexagon (linux-user/hexagon) Linux user
>> emulation
>>
>>> +
>>> +syscall_nr_generators += {
>>> +  'hexagon': generator(sh,
>>> +                       arguments: [ 'cat', 'syscall_nr.h', '>', '@OUTPUT@' ],
>>> +                     output: '@BASENAME@_nr.h')
>>
>> Why do we need that?
>> The syscall_nr_generators is used to generate syscall_nr.h from syscall.tbl
> 
> The other linux-user targets have this in their meson.build files.  I'll remove if it's not needed.

Not all the targets (only the ones with syscall.tbl) and they call
syscallhdr.sh and not cat. So you can remove it.

>>
>>> +}
>>> diff --git a/linux-user/meson.build b/linux-user/meson.build
>>> index 2b94e4b..8b1dfc8 100644
>>> --- a/linux-user/meson.build
>>> +++ b/linux-user/meson.build
>>> @@ -22,6 +22,7 @@ syscall_nr_generators = {}
>>>
>>>  subdir('alpha')
>>>  subdir('arm')
>>> +subdir('hexagon')
>>
>> so you don't need that either
> 
> OK
> 
>>> -    grep -e "#define __NR_" -e "#define __NR3264"
>>> +    grep -e "#define __NR_" -e "#define __NR3264" | grep -v
>> __NR_syscalls
>>
>> Why do you remove __NR_syscalls?
> 
> Older kernels have a bunch of
> #undef __NR_syscalls
> #define __NR_syscalls  X
> 
> The script removes all #undef's but leaves the #define's, so we get compile errors.  That symbol isn't used by qemu so it's safe to remove.
> 

As the syscall_nr.h generated from syscall.tbl don't have this symbol, I
think we can remove it. But I'm very surprised it doesn't work with it
for you.

Could you put this one-line change in a separate patch?

The best would be to re-run it once the change is made to update all the
generated syscall_nr.h without the __NR_syscalls line.

Moreover the syscall_nr.h I generate from linux-5.9 for hexagon is
different from the one you put in this series (the 1024 -> 1079 part is
missing).

Thanks,
Laurent




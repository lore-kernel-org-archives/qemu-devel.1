Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FE4C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 08:28:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5298120714
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 08:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5298120714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEqXt-00014l-Gv
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 04:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45639)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jEqV9-0006MC-KI
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 04:26:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jEqV8-0004qb-5U
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 04:26:03 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:36133)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jEqV7-0004mp-Sq
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 04:26:02 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MDPuq-1j6Ym82bF0-00AUxC; Thu, 19 Mar 2020 09:25:58 +0100
Subject: Re: [PULL v2 00/37] Linux user for 5.0 patches
To: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200317155116.1227513-1-laurent@vivier.eu>
 <CAFEAcA9Pd6D6xaqN7XfOwRANxm=4uOYmdaBoeQiX4_Z-bXEi9g@mail.gmail.com>
 <610f250b-64b8-1cf4-00fe-5bf2f2eba864@linaro.org>
 <b0055b37-a381-095a-a7c9-8b1327be3cce@vivier.eu>
 <95ebdfda-de48-8a44-ec86-8dd384fc98a3@linaro.org>
 <b77a5bd0-46b6-3345-d070-a998890efff2@vivier.eu>
 <0ba1e895-9f0d-49e0-d654-2663a5a858e3@linaro.org>
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
Message-ID: <84144010-01d0-50d7-a934-0c6762b0fb24@vivier.eu>
Date: Thu, 19 Mar 2020 09:25:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <0ba1e895-9f0d-49e0-d654-2663a5a858e3@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fNTTlKUdw38zabixy05PsGoXFMbfg9SR3L+IJqMsWejjKnJ+Aab
 guEYuA2PpCH6FfHNoM9FHzsAJMFbrUslyWPAn0GK4634EE3moWYrgb3ncjZuU5bU4LAIdZ7
 nulWPDUEwp8xJT3xrN4JEzBsTCT6rsteNSchlAy3I4EUBHvdt66X44NEdB3G8eTOINipHUB
 99L5t8Thl1jCVt8aJ9XFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ImHUO++inDI=:UOuK0uq4kM3yYksK8JquZc
 4xTy8IXyopLHX+sbMOdRkpPpgn7Zgau/p1LrZGoptl4EC1ZrBlg6Z4DIcqTl20B1Gyk2yF/7S
 2YmwODtkGW3zKm2ZWb1Eq4dVztWTdkTlwfJ83yz/JZxmilJGcp7tX1qErkNwCX7zquyEFo4C5
 boKIijkhQnThjrYBP3RE859ffyYjYhpg7nKSFqyn6vRpx+TDb1dLnYNJFSaOOVUn4OdC5lyhL
 POf+tY07XVj6/DNn6Sqna9lMVctLASdVE+9W3AuxmNtrLF3fVkpOjgkOXmN53+QcTr3gXk/OR
 w7KC37MIgSxKbvHsIvmpDk7Nf3AGJm/v+VBgbWaU2hlfRHCKbcrLFFQU40qQquwGtxv0RYhGP
 Ulq386Fxec5UH1BaXlsnxaCjVpui+YYHW06NtVP28V0VqR/EIVgppGQ7AhQ9N3C832q6lJinT
 hGVj8Zw+zOQmhMYYWGYjnoGt97g53X/tzewz/fhY09+9eB1O+OxbbvIU5KyAGzRBllEmkYoWs
 gju0rBuhXVzIUSWRk4r5StYNkuvNewVz8UcgiTjtVFctKNVpspXJaq8VBnaWe2o1sKJqvEmmQ
 EW7E4ZXYzjxYNrHXHwaLL7AG1h8ANdfm7/AqFMPGEHusLKG7iV1NRJ3WW9UF3mhmiDFDwD/Kg
 LwQ8PkpM+1dQ8yKNXy5nACVJEtik06bPgc4deNyZVxLAOWYwABd/mNeOv7lR0m7YOmVNpcTDB
 6PxcRYkKDZz3oJEPUwWcJFTk7zoJl6Gq6Us7yKDGsbZU7ses7H1KT5e6R992NKqn411XHeNXc
 +rlZYkA6NKAJmEZ2PyDUKY7nuQUikdAgt+kG50AE4mxIhh2qIijZCEVyBnmdMTj7je09f3H
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 18/03/2020 à 21:42, Richard Henderson a écrit :
> On 3/18/20 1:23 PM, Laurent Vivier wrote:
>> Le 18/03/2020 à 21:17, Richard Henderson a écrit :
>>> On 3/18/20 12:58 PM, Laurent Vivier wrote:
>>>>> However, from the error message above, it's clear that cpu_loop.o has not been
>>>>> rebuilt properly.
>>>>>
>>>>
>>>> In the series merged here syscall_nr.h are moved from source directory
>>>> to build directory.
>>>>
>>>> The include path of the files is based on the dependecy files (*.d), and
>>>> to force the update of this path PATCH 13 removes all the .d files that
>>>> have a dependecy on the syscall_nr.h file in the source path.
>>>>
>>>> This is added in configure:
>>>>
>>>> --- a/configure
>>>> +++ b/configure
>>>> @@ -1887,6 +1887,17 @@ fi
>>>>  # Remove old dependency files to make sure that they get properly
>>>> regenerated
>>>>  rm -f */config-devices.mak.d
>>>>
>>>> +# Remove syscall_nr.h to be sure they will be regenerated in the build
>>>> +# directory, not in the source directory
>>>> +for arch in ; do
>>>> +    # remove the file if it has been generated in the source directory
>>>> +    rm -f "${source_path}/linux-user/${arch}/syscall_nr.h"
>>>> +    # remove the dependency files
>>>> +    find . -name "*.d" \
>>>> +           -exec grep -q
>>>> "${source_path}/linux-user/${arch}/syscall_nr.h" {} \; \
>>>> +           -exec rm {} \;
>>>> +done
>>> ...
>>>> Perhaps it removes a dependency that should trigger the rebuild of
>>>> cpu_loop.o?
>>>
>>> Ah, yes indeed. It removes *all* dependencies for cpu_loop.o, so unless we
>>> touch the cpu_loop.c source file, nothing gets done.
>>>
>>> I think you're trying to be too fine grained here, since the *.o file has to go
>>> away with the *.d file.  Why not just
>>>
>>>   make ${arch}-linux-user/clean
>>>
>>> ?
>>
>> The idea was to be able to bisect the series as the syscall_nr.h were
>> added incrementally without rebuilding all the files.
>>
>> If I remove the loop in the configure where to add the "make
>> ${arch}-linux-user/clean"?
> 
> I don't know.  Can you get an exit status out of the find?
> 
> Another option might be
> 
> for f in $(find ${arch}-linux-user -name '*.d' \
>            -exec grep -q ${arch_syscall} \
>            -print); do
>   rm -f $(basename $f .d).*
> done
> 
> But frankly I don't care if all of every file gets rebuilt while bisecting, it
> just needs to work.

ok, thank you for your help.

I'm going to resend the pull request without this series to have more
time to find a solution and to test it.

Thanks,
Laurent


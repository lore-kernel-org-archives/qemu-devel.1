Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78650C31E57
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 12:13:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EB6E2084D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 12:13:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB6E2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46508 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcqW8-0000qS-JM
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 08:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58258)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hcq7f-0000PC-8n
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:48:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hcq7d-0005Ep-EJ
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:48:27 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:59375)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hcq7c-0005A1-8E
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:48:25 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MeTHG-1iB4Ow0SGq-00aWOi; Mon, 17 Jun 2019 13:47:50 +0200
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20190617114005.24603-1-berrange@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
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
Message-ID: <bad5a34e-509e-3f55-e2fe-17d28681d6fe@vivier.eu>
Date: Mon, 17 Jun 2019 13:47:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190617114005.24603-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hXTbnAvS1deEIP5S8YrJkGAQ0qoC+UdbpdgxZGFdR80DQ1rVRCB
 7D+07l8w6gFBKcZgfBWyIm3IYoThdOC+OF1FWcskoBrZ03eyWIdLhMRtNG92nrrStmlmGfR
 FQ3grSG1CGwLu8J4Zl1sURsujxWeH6an6I1DXU/usKmg+TofcRDDP4slJ+ijtSZyQiB7J5b
 Jakez/UaVGck5+62byZ+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gqX+J0nk8tQ=:OPnp4laaIrRaiLhtSYmwFb
 4Zlylo/3f7QsNxOFa9G89t/OL2RQ8GIvv6y3q4eD54nC31cH9EVxR0mD9SqQKUK64NDlWHblw
 oNTk+njmZdhX5uSNXYRFixDMqyJDF0dohCF9FDb7dP++PlGENo/222fDifRgk5y/+jMO6ljzA
 Gh9NZP1GWW12K9T/Ei0Stv5qZfBrRWfTxwuQUfIINBc/XtN/VumCqGWPclaPlLEAb0bZ8gjJP
 3N91oR5TO1HeRjWjP/AJRwvUxBosSacvQxDcysDJBFSzL+lIpqscI/JtnnF81Adds9OcyzRld
 8PbDCA4XEdb2K2NPlTX4W9WFwsXONCmErRuBsR7VWSxP+qn11WeodoZnLP5u6akc5stty9KGO
 VHfEoGY/e1cpUOTkTJIs4uQR7t7kNUPUT1bIVURV3LLvgYOo8m7E2kj9FWJj+K20kVxOiLgF9
 K1TJ+5j71Hn6j05tXiVnMPW74P541CUuj6k2m7kdvlxyWTQkYvc3OlLun51UOhqSGTI+jDf5/
 O3hy83DAcA4pf9Xlu3V0qctMmgogl6s/2HS6O+cxrFmcgTrAmTzUsHTE3o9y2iJMJLDQJbRFZ
 0sg3WSl7bIrsWisIrt9cbUipXIWKAzibYqh8Ldkzgm75GUauIOMPo71AFfYscMzlwERjy3QD8
 r4lBrxHmkcnUIwic9MmPXaf6F0k1KPTpfKAfHvYCzopyV3MeAtO0Ka19JjfHPqu6/kO1snncw
 nZfXK24tOMB/UNtC/G6RUv7XjSdpUU6fDhwsEUGDcDuHwmdDsTfhnuWwH+c=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
Subject: Re: [Qemu-devel] [PATCH] linux-user: fix includes to find
 SIOCGSTAMP with latest kernel headers
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
Cc: Riku Voipio <riku.voipio@iki.fi>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 17/06/2019 à 13:40, Daniel P. Berrangé a écrit :
> The SIOCGSTAMP symbol was previously defined in the
> asm-generic/sockios.h header file. QEMU sees that header
> indirectly via
> 
>    sys/socket.h
>     -> bits/socket.h
>         -> asm/socket.h
>             -> asm-generic/socket.h
>                 -> asm/sockios.h
>                     -> asm-generic/sockios.h
> 
> In linux kernel commit 0768e17073dc527ccd18ed5f96ce85f9985e9115
> the asm-generic/sockios.h header no longer defines SIOCGSTAMP.
> Instead it provides only SIOCGSTAMP_OLD.
> 
> The linux/sockios.h header now defines SIOCGSTAMP using either
> SIOCGSTAMP_OLD or SIOCGSTAMP_NEW as appropriate. This linux only
> header file is not pulled in by QEMU though, so we get a build
> failure:
> 
> qemu/linux-user/ioctls.h:225:9: error: ‘SIOCGSTAMP’ undeclared here (not in a function); did you mean ‘SIOCSRARP’?
>   225 |   IOCTL(SIOCGSTAMP, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timeval)))
>       |         ^~~~~~~~~~
> qemu/linux-user/syscall.c:4855:23: note: in definition of macro ‘IOCTL’
>  4855 |     { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
>       |                       ^~~
> qemu/linux-user/ioctls.h:226:9: error: ‘SIOCGSTAMPNS’ undeclared here (not in a function); did you mean ‘SIOCGSTAMP_OLD’?
>   226 |   IOCTL(SIOCGSTAMPNS, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timespec)))
>       |         ^~~~~~~~~~~~
> qemu/linux-user/syscall.c:4855:23: note: in definition of macro ‘IOCTL’
>  4855 |     { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
>       |                       ^~~
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  linux-user/syscall.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index b187c1281d..f13e260b02 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -37,6 +37,7 @@
>  #include <sched.h>
>  #include <sys/timex.h>
>  #include <sys/socket.h>
> +#include <linux/sockios.h>
>  #include <sys/un.h>
>  #include <sys/uio.h>
>  #include <poll.h>
> 

We already had a patch for that:

https://patchew.org/QEMU/20190604071915.288045-1-borntraeger@de.ibm.com/

but the value of SIOCGSTAMP depends on the size of struct timeval. The
host part must be able to process SIOCGSTAMP_OLD and SIOCGSTAMP_NEW if
it defines them.

Thanks,
Laurent


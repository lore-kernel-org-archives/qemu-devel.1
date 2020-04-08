Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F155C2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 08:52:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62F3F2074F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 08:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F3F2074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM6S2-000853-Js
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 04:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55552)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jM6DY-0000g6-0z
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 04:37:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jM60E-00086r-SA
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 04:24:07 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:54211)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jM5mO-0002El-9E
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 04:09:48 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N3KY0-1jDo0K3dMA-010Oc5; Wed, 08 Apr 2020 10:09:43 +0200
Subject: Re: linux-user: keep the name-ending parenthesis in /proc/self/stat
To: Brice Goglin <Brice.Goglin@inria.fr>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <f7720d36-a5ea-ae13-220a-2e436e6a22a4@inria.fr>
 <3f2cb9a1-00aa-cc59-d685-2c88e6f986c7@redhat.com>
 <4ac78bc6-35d6-5705-9e75-4e48436d8589@inria.fr>
 <197d29e7-c26d-9c55-6278-f37da0dd760e@inria.fr>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <413afba3-3bb2-4493-ca1b-4d9c76ee5e8e@vivier.eu>
Date: Wed, 8 Apr 2020 10:09:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <197d29e7-c26d-9c55-6278-f37da0dd760e@inria.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZTzPmXHxqqd2oovNxCTeUuqigpPLzvHtGDU6dbqNkO9kj6/vTz1
 7SqTD9C4mxeYNgo1h60BRE0zGoT9E0nHv+myctRK6UplX0dcdwKPBWxSajilVpeGuulwdeo
 6e6qrzcQG2LzUk5+kmig84uv5NR1iIKaxoeG6P032EaV3FMYFUv/+tQ1zWEk5I4H7/BVbmQ
 F2FbEcxjUyMiKON8YpqVQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XCdJhdSUV1s=:Iz8vV19iDnPAViJ78rZexP
 TerfybJEIyMsRI+slMf/7Spo9ST2XG8FmEsCEqs41tnTaXb1vL/Evj8GzF8z+Ygm1O3bdVcyX
 VZX8ilh3BPdb4ZCDDMLOmkkgHMh4YLyWJxnrZaF9tJ/IID0mHkhQmpieeJV1QOKELJmVJr3AZ
 v3EWacQPUL3gop62KWaxwlOAO7FvZskBqZ8AjHMQMaXq0hmmOdEK3f8hdT5adq9YxMKjkqbf+
 xVMnvjcZ6K5bO7UkLyEhifOq4pV58dvPzQgW/7gcF87ZPKh9vV5FG6cz3HuV+AQ6BOvl1tt2Z
 SifrzVCVf3A8I2vNRkBtYW3pz78wazjaEGRvxlXdUP1kQi5jWs9LHxyF6FsaFVFVCJILksCyf
 e1Mx5FB1rrs+2iZrWYHnwVaSt44UbhSB7zFOY6GGJ+yyBSV5QBQBJFDtgS1aFTL5BoF2pWosu
 ETtQ6pBan9u4Z4yFNyLIfqHxdMGq64ienV9HlqszoHnCYEuqBpuM1qX06fFxWrFnZnItwjRWt
 bFty7Ew92lRzTC1MPX4rS3/aAF79FOEZUs8k5h0RIc970gz9sK3vHL+HbCjLy43XMibSzwL5Z
 RRgKeqjMcJhL0fwBekMNA0NC7ENdoKaOUibMMywlQtZBxoHnsm9POK1gKD9AqZK2wLRaNSikX
 y2eSWTpVRQewNlGLO1K/h4racq7sHDB8LCkGrSsKMgHpw/mS58798GpvedkOl6imISP35omy7
 lRkKvhSiGW79FTBUtWUNqMLVpMM3uSPV/MxxXg9pZurVZlLo7/DzeXVnQiZnp1stbbt/61yK4
 6Ft6nPUU1ZSMcbJdP/vJkTu5CaW9z1e6i7kV6wIKQBTx0Iae2bc0h78OeMh9C+ytDDkfcaw
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
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

Le 08/04/2020 à 08:40, Brice Goglin a écrit :
> Le 31/03/2020 à 00:29, Brice Goglin a écrit :
>> Le 31/03/2020 à 00:05, Philippe Mathieu-Daudé a écrit :
>>> On 3/30/20 9:07 PM, Brice Goglin wrote:
>>>> When the program name is very long, qemu-user may truncate it in
>>>> /proc/self/stat. However the truncation must keep the ending ") "
>>>> to conform to the proc manpage which says:
>>>>      (2) comm  %s
>>>>             The  filename of the executable, in parentheses.  This
>>>>             is visible whether or not the  executable  is  swapped
>>>>             out.
>>>>
>>>> To reproduce:
>>>> $ ln -s /bin/cat <filenamewithmorethan128chars>
>>>> $ qemu-x86_64 ./<filenamewithmorethan128chars> /proc/self/stat
>>>>
>>>> Before the patch, you get:
>>>> 1134631 (<filenametruncated>0 0 0 0 0 0 0 0 ...
>>>> After the patch:
>>>> 1134631 (<filenametruncat>) 0 0 0 0 0 0 0 0 ...
>>>>
>>>> This fixes an issue with hwloc failing to parse /proc/self/stat
>>>> when Ludovic Courtes was testing it in guix over qemu-aarch64.
>>>>
>>>> Signed-off-by: Brice Goglin<Brice.Goglin@inria.fr>
>>>>
>>>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>>>> index 5af55fca78..a1126dcf5b 100644
>>>> --- a/linux-user/syscall.c
>>>> +++ b/linux-user/syscall.c
>>>> @@ -7305,7 +7305,10 @@ static int open_self_stat(void *cpu_env, int fd)
>>>>           snprintf(buf, sizeof(buf), "%"PRId64 " ", val);
>>>>         } else if (i == 1) {
>>>>           /* app name */
>>>> -        snprintf(buf, sizeof(buf), "(%s) ", ts->bprm->argv[0]);
>>>> +        len = snprintf(buf, sizeof(buf), "(%s) ", ts->bprm->argv[0]);
>>>> +        if (len >= sizeof(buf))
>>>> +          /* bring back the ending ") " that was truncated */
>>>> +          strcpy(buf+sizeof(buf)-3, ") ");
>>> Maybe we can avoid the sprintf() call:
>>>
>>> -- >8 --
>>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>>> --- a/linux-user/syscall.c
>>> +++ b/linux-user/syscall.c
>>> @@ -7305,7 +7305,11 @@ static int open_self_stat(void *cpu_env, int fd)
>>>          snprintf(buf, sizeof(buf), "%"PRId64 " ", val);
>>>        } else if (i == 1) {
>>>          /* app name */
>>> -        snprintf(buf, sizeof(buf), "(%s) ", ts->bprm->argv[0]);
>>> +        char *ptr = buf;
>>> +
>>> +        *ptr++ = '(';
>>> +        ptr = stpncpy(ptr, ts->bprm->argv[0], sizeof(buf) - 3);
>>> +        strcpy(ptr, ") ");
>>>        } else if (i == 27) {
>>>          /* stack bottom */
>>>          val = start_stack;
>>>
>> This works too.
> 
> 
> Hello
> 
> Is anybody going to fix this anyhow for the next release?

Hi,

we are expecting you fix the patch according to Philippe's comment and
re-send it or explain why you don't want.

Thanks,
Laurent



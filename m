Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1B6C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:12:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23FB921582
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:12:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23FB921582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyvC4-0005q9-CI
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 05:12:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40850)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iyvBC-0004RG-Uw
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 05:11:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iyvBB-0004TK-Oa
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 05:11:38 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:33879)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iyvBB-0004Rv-FX
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 05:11:37 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MTAJl-1j6s3J3bzj-00UZoC; Tue, 04 Feb 2020 11:11:23 +0100
Subject: Re: [PATCH v2 2/4] linux-user: Use `qemu_log' for strace
To: Josh Kunz <jkz@google.com>
References: <20200117192808.129398-1-jkz@google.com>
 <20200117192808.129398-3-jkz@google.com>
 <ab5d3c15-9060-47be-fdb6-70ab76dfcc06@vivier.eu>
 <CADgy-2v0kmErHVNx0X3tAcsw9ozGgfJ_pvC0xiStWo_trOcjEQ@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8ac92e9b-37f1-5955-fd14-c12ab519ee7a@vivier.eu>
Date: Tue, 4 Feb 2020 11:11:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CADgy-2v0kmErHVNx0X3tAcsw9ozGgfJ_pvC0xiStWo_trOcjEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Ws6VYDz+DXHAqLG1gtiFVYACEZDbq3aAKqc4qUHM8Nok3M1J+nR
 g0/PCkirHBQtdNIE65ii1EysbnCwteEXkZBe84YTieDrCTdMS3FbY+8Q04gJIQdpGHAb4Yd
 cR0BUQBAmVoED8WPTkGxG6gVFPR7L4UYaie0BEU1HyT47GV3gJ82Bs90s746ftvwHhjElSb
 mkEik3JNGAs+8pnZAZy5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ffDP0zTtjpM=:2PbQE0VLyBLRMT8AplfDU1
 q1+j27XM/FaC57Qb08WYiLXEU+1t92RqSFEM8XypERWCfem1HsPcPYWX/X3EZpAe4Q8guldem
 94p/S2O47wJnv4b7iIE6ORexdwwxem95LQzHfH8F/6mtJDB6wxr4Kkix4lNqT7AL58v9lVHkz
 dpZofHYF5SP/dbl7biQ4rLXutAHblOW7VMW0G3dFfAK0TZACOwhg9AwUNqTWJO69h0qEQ9cA0
 8wRV9RGoPQpXqOgF0t8AAeJEirbTh5+CmEoFCNsVo9sTg4b6mtGnsh8Vw1uIXAV+eZXIyH6BS
 0jHfD+/Y1tbwJuH/ay6l8SYPK3fsyCj7azEP/BnV1psE/L9xt3v6xadtk3rCfROBGupQCGYlI
 vmb8BCHHJvfvlYf5FDRUXTjbUlRzJYgcR8ktZ84I+3wirxCS29xUSr9Se50mZtlZqFqnON/EM
 2aoljIdZxAkAro+LUHkRkYeAKQr90sq3RmkxooIxM2qlTp8yBkuewXaqdDdhuZSeCWnG/0b4l
 uGoyu36vhbLl17EYuhOQ63EFmvRllcXSkh6fTrJwPsTTGYRyL/ODz0RqgoPjNWiAxiiKURyze
 yetCzSnhJhMNFHwRnoHslG72JXVTQ4GWBhqnbT9V/cElv6/VNfoJBPGK6ogcaZAQUH7mjCgnZ
 hXLztAb9Gn38Amuw/V4y8vHYxfPnx/aR3wn6txZxfJrvB7drj74zk/CjBbINp+be2+MUcQMvA
 DctMLKa3hoIOBTk90BrcwjHwd2Ah/IesyFDx3DAan2x5pqfdmswAAsHzXswEnU5Ovd0Tyrxz4
 +ZEaXKyC0Eh0ZvgvpuZmC3VgZOI/rde9brO5TV6zg1X9+dmEd5G4vh8tGZas9aKfP0/QgA6
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Warner Losh <imp@bsdimp.com>,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 04/02/2020 à 03:55, Josh Kunz a écrit :
> On Tue, Jan 28, 2020 at 7:07 AM Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> Le 17/01/2020 à 20:28, Josh Kunz a écrit :
>>> This change switches linux-user strace logging to use the newer `qemu_log`
>>> logging subsystem rather than the older `gemu_log` (notice the "g")
>>> logger. `qemu_log` has several advantages, namely that it allows logging
>>> to a file, and provides a more unified interface for configuration
>>> of logging (via the QEMU_LOG environment variable or options).
>>>
>>> This change introduces a new log mask: `LOG_STRACE` which is used for
>>> logging of user-mode strace messages.
>>>
>>> Signed-off-by: Josh Kunz <jkz@google.com>
>>> ---
>>>  include/qemu/log.h   |   2 +
>>>  linux-user/main.c    |  30 ++-
>>>  linux-user/qemu.h    |   1 -
>>>  linux-user/signal.c  |   2 +-
>>>  linux-user/strace.c  | 479 ++++++++++++++++++++++---------------------
>>>  linux-user/syscall.c |  13 +-
>>>  util/log.c           |   2 +
>>>  7 files changed, 278 insertions(+), 251 deletions(-)
>>>
>> ...
>>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>>> index 629f3a21b5..54e60f3807 100644
>>> --- a/linux-user/syscall.c
>>> +++ b/linux-user/syscall.c
>>> @@ -12098,14 +12098,15 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>>>      record_syscall_start(cpu, num, arg1,
>>>                           arg2, arg3, arg4, arg5, arg6, arg7, arg8);
>>>
>>> -    if (unlikely(do_strace)) {
>>> +    if (unlikely(qemu_loglevel_mask(LOG_STRACE))) {
>>>          print_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
>>> -        ret = do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
>>> -                          arg5, arg6, arg7, arg8);
>>> +    }
>>> +
>>> +    ret = do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
>>> +                      arg5, arg6, arg7, arg8);
>>> +
>>> +    if (unlikely(qemu_loglevel_mask(LOG_STRACE))) {
>>>          print_syscall_ret(num, ret);
>>> -    } else {
>>> -        ret = do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
>>> -                          arg5, arg6, arg7, arg8);
>>>      }
>>>
>>>      record_syscall_return(cpu, num, ret);
>>
>> In term of performance perhaps it sould be better to only test once for
>> the mask as it is done before?
> 
> Modern compilers will generate functionally identical sequences for
> test once or testing twice (which is to say, they recognize they are
> the same compare: https://godbolt.org/z/VyrMHf IMO testing twice is
> nicer to read, so I'm leaving it that way for now unless you object.
> 

If generated code is the same, I have no objection.

Thanks,
Laurent


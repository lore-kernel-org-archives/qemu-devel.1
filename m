Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F26FC48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 11:41:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE5F220B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 11:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE5F220B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg6IO-0007jy-8G
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 07:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42203)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hg6Gp-00076G-Oq
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 07:39:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hg6Gm-0005pJ-90
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 07:39:23 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:51261)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hg6Gj-0005fk-Jm
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 07:39:19 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MpCz1-1iMK9O3pvz-00qiWi; Wed, 26 Jun 2019 13:38:34 +0200
To: Lucien Anti-Spam <lucienmp_antispam@yahoo.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190526075056.33865-1-lucienmp_antispam@yahoo.com>
 <ab1edfe7-8498-eee6-096c-d66d6122d133@vivier.eu>
 <1c3d400a-7ea2-2bdd-8301-8f6c85075b24@linaro.org>
 <2af0f156-d1d7-4957-547a-13dc24a9a8cd@vivier.eu>
 <1277274524.199018.1561548245851@mail.yahoo.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d13878b4-d900-fe54-14fd-ff5ff11a1cc9@vivier.eu>
Date: Wed, 26 Jun 2019 13:38:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1277274524.199018.1561548245851@mail.yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JK0Mt+O7yy7crIRpug6Cu1OoNZkRaOVYvbUQaRhdmYUur+Xy+dl
 Lc7fY8MhLG+oy9iQo4q0YIAHvc8YcTGIARg0cmwwwS4nXTR/L3rXmlj7tu3kDpfMKIEY/us
 JzMP8kUk3rsBy1rV85/moBqa/1++lJDRJX9RhZpPUloFxG28voOYsp5sx5Tuns+qKV6JmUy
 PJvkx8H1lOT7QqEotac4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6cy5pnIIf5E=:88Ays13e7OBRLXLBrjPd/S
 pMGEg1NKmJxj6Q9S0GDBgkrx3ipI++eE2mV8k0jx+mp6/P9+e6iHKebOAj+UqAXdFJaRTGizD
 ZJ/u4h4bjuz5rKbt2+AtzuxLwtXVmsGvY8nCV2VyiCNKN+QVdQ1YQqgCQ3pX9lrn30c45fcQ2
 1hnrnRyUVM7cXGYPL4cU1+vpxhX3zFSTyF+4BVpqgo24eogzBUKT/ZKUPnQw4UpKOAzjq2xRI
 +7H2TgoGdI+LtDvo8bb46H1bFpfK7FTbLHtuXppwEUWJ5SmUMbc+7FSVl8umzGji0Z0SXNlfh
 h0+/nZ7cHdJiMS8KS8GfIK29c4i0giEAuIV+BP6wO4gz/lrB0bLTKV+GNs7AP1LFBVJkif2j6
 AuYj9/qqA5z8rjMhOGyQKlOtrlNJvYeCWuwXaqVYDMAdh3vmJQ/Qtax+EQUVyOemBU4ItCwIU
 urBVt5/CO5fkwK9WEqvyY4EACHkYbrFfmsuY3uLGMna6Bu9p8JPutj41AL0cMiYsIg3Qvk+K8
 MqYYwKNEYZBFyw3S3KZuOeWzUXJySaG9Bn78Q6eRUdIq4tSz6SqEami11H/85mVJJcETE5dXS
 hO2pwisnoIzQ5zq0w1EVN2z5eJKuXL8JMc3fvPrYXhMd3jHwR9Q6KMQme3af6+B48CxitZUFN
 eYoej0YZjE9iT8TMeLQ+a59uIzs7uwe/ZxPnkfhWcclR2ZgOS6FkREzXxrjXqqpDSmZna8eip
 Ts/e4tAUh8+hsDwbiHCgEEfVyx9eqSxwR1MxtWcNLMguEfIa9GYvG2oIdnA=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
Subject: Re: [Qemu-devel] [PATCH] Regression for m68k causing Single-Step
 via GDB/RSP to not single step
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
Cc: Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 "Emilio G . Cota" <cota@braap.org>, Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 26/06/2019 à 13:24, Lucien Anti-Spam a écrit :
> Hi Richard/Laurent,
> 
> Great catch, I also just stumbled on this problem as well which I didnt
> see with my other application code.
> 
> But I have another problem after applying the changes from your email,
> "RTE" and breakpoints around a MOV/BusException/RTE behave oddly.
> 
> I would like to test with the same software you are using, could you
> tell me what M68K machine setup, and images you use as well as your
> debugger please?

Hi,

I use the Q800 machine from the series:

https://patchew.org/QEMU/20190619221933.1981-1-laurent@vivier.eu/

and a kernel I cross-build from the git repo.

The debugger is the one from a debian/etch-m68k installation (a real
m68k machine or a container with qemu-m68k and configured with
binfmt_misc). I use it remotely (with command "target remote
localhost:1234" and I start qemu with "-s") . More recent gdb (native or
cross built) have a bug: they don't manage correctly the size of FP
registers (96bit), they use 64bit FP registers that is only valid with
coldfire

I pass the kernel and cmdline to qemu with "-kernel" and "-append"
parameters.

Thanks,
Laurent

> Cheers,
> Luc
> 
> On Wednesday, June 19, 2019, 04:59:12 AM GMT+9, Laurent Vivier
> <laurent@vivier.eu> wrote:
> 
> 
> Le 18/06/2019 à 21:39, Richard Henderson a écrit :
>> On 6/18/19 11:44 AM, Laurent Vivier wrote:
>>> Le 26/05/2019 à 09:50, Lucien Murray-Pitts a écrit :
>>>> A regression that was introduced, with the refactor to TranslatorOps,
>>>> drops two lines that update the PC when single-stepping is being
> performed.
>>>> ( short commit 11ab74b )
>>>>
>>>> This patch resolves that issue.
>>>
>>> Fixes: 11ab74b01e0a ("target/m68k: Convert to TranslatorOps")
>>>
>>>> Signed-off-by: Lucien Murray-Pitts <lucienmp_antispam@yahoo.com
> <mailto:lucienmp_antispam@yahoo.com>>
>>>> ---
>>>>  target/m68k/translate.c | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
>>>> index f0534a4ba0..2922ea79c3 100644
>>>> --- a/target/m68k/translate.c
>>>> +++ b/target/m68k/translate.c
>>>> @@ -6130,6 +6130,8 @@ static void m68k_tr_tb_stop(DisasContextBase
> *dcbase, CPUState *cpu)
>>>>          return;
>>>>      }
>>>>      if (dc->base.singlestep_enabled) {
>>>> +        update_cc_op(dc);
>>>> +        tcg_gen_movi_i32(QREG_PC, dc->pc);
>>>>          gen_helper_raise_exception(cpu_env, tcg_const_i32(EXCP_DEBUG));
>>>>          return;
>>>>      }
>>>>
>>>
>>> I've tested this fix single-stepping on a kernel, these two lines are
>>> not enough to fix the problem. In fact four lines have been dropped and
>>> we must re-add them all:
>>>
>>> iff --git a/target/m68k/translate.c b/target/m68k/translate.c
>>> index d0f6d1f5cc..6c78001501 100644
>>> --- a/target/m68k/translate.c
>>> +++ b/target/m68k/translate.c
>>> @@ -6200,6 +6200,10 @@ static void m68k_tr_tb_stop(DisasContextBase
> *dcbase, CPUState *cpu)
>>>          return;
>>>      }
>>>      if (dc->base.singlestep_enabled) {
>>> +        if (dc->base.is_jmp != DISAS_JUMP) {
>>> +            update_cc_op(dc);
>>> +            tcg_gen_movi_i32(QREG_PC, dc->pc);
>>> +        }
>>>          gen_helper_raise_exception(cpu_env, tcg_const_i32(EXCP_DEBUG));
>>>          return;
>>>      }
>>
>> Even this isn't quite right, according to the comments in the switch that
>> follows.  I think it'd be best written like so.
>>
>>
>> r~
>>
>>
>> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
>> index 2ae537461f..b61c7ea0f1 100644
>> --- a/target/m68k/translate.c
>> +++ b/target/m68k/translate.c
>> @@ -6124,27 +6124,34 @@ static void m68k_tr_tb_stop(DisasContextBase
> *dcbase,
>> CPUState *cpu)
>>  {
>>      DisasContext *dc = container_of(dcbase, DisasContext, base);
>>
>> -    if (dc->base.is_jmp == DISAS_NORETURN) {
>> -        return;
>> -    }
>> -    if (dc->base.singlestep_enabled) {
>> -        gen_helper_raise_exception(cpu_env, tcg_const_i32(EXCP_DEBUG));
>> -        return;
>> -    }
>> -
>>      switch (dc->base.is_jmp) {
>> +    case DISAS_NORETURN:
>> +        break;
>>      case DISAS_TOO_MANY:
>>          update_cc_op(dc);
>> -        gen_jmp_tb(dc, 0, dc->pc);
>> +        if (dc->base.singlestep_enabled) {
>> +            tcg_gen_movi_i32(QREG_PC, dc->pc);
>> +            gen_helper_raise_exception(cpu_env,
> tcg_const_i32(EXCP_DEBUG));
>> +        } else {
>> +            gen_jmp_tb(dc, 0, dc->pc);
>> +        }
>>          break;
>>      case DISAS_JUMP:
>>          /* We updated CC_OP and PC in gen_jmp/gen_jmp_im.  */
>> -        tcg_gen_lookup_and_goto_ptr();
>> +        if (dc->base.singlestep_enabled) {
>> +            gen_helper_raise_exception(cpu_env,
> tcg_const_i32(EXCP_DEBUG));
>> +        } else {
>> +            tcg_gen_lookup_and_goto_ptr();
>> +        }
>>          break;
>>      case DISAS_EXIT:
>>          /* We updated CC_OP and PC in gen_exit_tb, but also modified
>>            other state that may require returning to the main loop.  */
>> -        tcg_gen_exit_tb(NULL, 0);
>> +        if (dc->base.singlestep_enabled) {
>> +            gen_helper_raise_exception(cpu_env,
> tcg_const_i32(EXCP_DEBUG));
>> +        } else {
>> +            tcg_gen_exit_tb(NULL, 0);
>> +        }
>>          break;
>>      default:
>>          g_assert_not_reached();
>>
> 
> Yes, it works too.
> 
> Could you formally send a patch?
> 
> Thanks,
> 
> Laurent



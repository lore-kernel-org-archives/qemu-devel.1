Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824F3C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 18:43:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D8B8208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 18:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D8B8208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIyrz-0005aC-Tm
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 14:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kIypu-0003Rp-Nv; Thu, 17 Sep 2020 14:40:50 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:59807)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kIyps-0002Tb-9Y; Thu, 17 Sep 2020 14:40:50 -0400
Received: from [192.168.100.1] ([82.252.129.222]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MjjKf-1kkZbl1hT1-00lBdi; Thu, 17 Sep 2020 20:40:42 +0200
Subject: Re: [PATCH V3 08/10] disas/: fix some comment spelling errors
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 zhaolichang <zhaolichang@huawei.com>
References: <20200917075029.313-1-zhaolichang@huawei.com>
 <20200917075029.313-9-zhaolichang@huawei.com> <871rj0ztbc.fsf@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <7bd9cc11-988f-47fc-ce08-2c159c763ea0@vivier.eu>
Date: Thu, 17 Sep 2020 20:40:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <871rj0ztbc.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:cQ3VzOjwpEDPZH07QQT6CfH/PMMpTcrW109AXnccxdUpyDdUdVm
 9UicTcsUfU4j2ceTGUPYPO9R1QDeo5BMwGerpW6KJY8UCMAOuifLKJ0jVIgGi61fv/pa6HR
 zIed5IJmvim33c1BHNHUp2RMU7ap73qwaoANpLk1+CjklXk2Jp3jAoeo1g3Lv+BTPGvN3L2
 5b9qm0HZDiNpkMy4IBIZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rbV0DlESwRA=:8/PNG0NBmprYoa0+D49MwG
 ehqOUFBf9DnQDsD1Ahn7liJ0NMoqEQWpeAUxUeXPFcmTETbTlO1N1yb++xYL9rr7ktC7vEA7T
 IvueN7kZlN7u5WMHXLBYvGhwg1T7WZfkRnBLdTOd4MWgvY/ftBKfVOaSElOE1peAxm/gBmf3O
 0u0S+MU9Xy9sYHdTfwbtpG6GOybMdqhmWJf/5bHPr+tspdmvZb/sj3dAR4zHYmW6Jy9i+reKt
 sDrDX5e6ggKr/2cLP7y96u55RZ/KbFzWuShXaFx0qwIT9JTwEPr+yJc7Kg15VPjLEAsjwv80c
 dgOe16qd8Q2Mz4z0SEGhEty4Y/s8KyHhktjL5QnrG1sqc9PHvhdT5hBicdvNhpIJ+mwHVisBJ
 qoBBfXGLA9+SHyNTs8RYlwNt2ttvXXP+iZA+oXbHl/mnVWsI27xmvjotich5z9QIdu/Lt5J0h
 /aKjKkG9Ttwnyn0SlZn23JgCYb3HUpcflMcaR+RhH3RqpflVi3ydz+72j7ErJv3dOHIDkgen5
 uEsokrwAO55+ATO2ont5ibMCfyi2SuiAAIZc75t4nxH5tnWGJXtUC6KGJNudYHUiu5msTrGfI
 qAlAQFua+0zjqMvEqEk3Vz5QTgyNTr3r+sdUCxEIo1iF4Rb+Lruoq2OTghnJQuI+ZjWp5Fb16
 NW72lo+dkySbR5G1EOo8vqokNcjujJdTdvv5lf3QI/IecgT84wVDLmxP/jveTDCEvBEcmaBZE
 LoWBwI9vBv7SqNf5aikp4vqK/tLWfHooH9yBRyNlskyEAuOc4kbM3e/ucmD4T692XTw/zjuRm
 K/PJ3KJzh0UWat/BJo1QmvksAR+Un80Ry1az0c9vy9X8r0FtsJkP3zMlbnzmRwxY90G6hAo
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 14:36:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 17/09/2020 à 10:44, Alex Bennée a écrit :
> 
> zhaolichang <zhaolichang@huawei.com> writes:
> 
>> I found that there are many spelling errors in the comments of qemu,
>> so I used the spellcheck tool to check the spelling errors
>> and finally found some spelling errors in the disas folder.
>>
>> Signed-off-by: zhaolichang <zhaolichang@huawei.com>
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> 
> I suggest on your next posting you CC qemu-trivial@nongnu.org so the
> patches can get pulled in via the trivial tree.

It was.

Applied to my trivial-patches branch.

Thanks,
Laurent

> 
>> ---
>>  disas/hppa.c | 2 +-
>>  disas/m68k.c | 8 ++++----
>>  disas/ppc.c  | 2 +-
>>  3 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/disas/hppa.c b/disas/hppa.c
>> index 2dbd1fc445..dcf9a47f34 100644
>> --- a/disas/hppa.c
>> +++ b/disas/hppa.c
>> @@ -2021,7 +2021,7 @@ print_insn_hppa (bfd_vma memaddr, disassemble_info *info)
>>  			fput_fp_reg (GET_FIELD (insn, 6, 10), info);
>>  		      break;
>>  
>> -		      /* 'fA' will not generate a space before the regsiter
>> +		      /* 'fA' will not generate a space before the register
>>  			 name.  Normally that is fine.  Except that it
>>  			 causes problems with xmpyu which has no FP format
>>  			 completer.  */
>> diff --git a/disas/m68k.c b/disas/m68k.c
>> index 863409c67c..aefaecfbd6 100644
>> --- a/disas/m68k.c
>> +++ b/disas/m68k.c
>> @@ -70,7 +70,7 @@ struct floatformat
>>    unsigned int exp_start;
>>    unsigned int exp_len;
>>    /* Bias added to a "true" exponent to form the biased exponent.  It
>> -     is intentionally signed as, otherwize, -exp_bias can turn into a
>> +     is intentionally signed as, otherwise, -exp_bias can turn into a
>>       very large number (e.g., given the exp_bias of 0x3fff and a 64
>>       bit long, the equation (long)(1 - exp_bias) evaluates to
>>       4294950914) instead of -16382).  */
>> @@ -479,7 +479,7 @@ struct m68k_opcode_alias
>>        and remaining 3 bits of register shifted 9 bits in first word.
>>        Indicate upper/lower in 1 bit shifted 7 bits in second word.
>>        Use with `R' or `u' format.
>> -   n  `m' withouth upper/lower indication. (For M[S]ACx; 4 bits split
>> +   n  `m' without upper/lower indication. (For M[S]ACx; 4 bits split
>>        with MSB shifted 6 bits in first word and remaining 3 bits of
>>        register shifted 9 bits in first word.  No upper/lower
>>        indication is done.)  Use with `R' or `u' format.
>> @@ -854,7 +854,7 @@ fetch_arg (unsigned char *buffer,
>>  
>>  /* Check if an EA is valid for a particular code.  This is required
>>     for the EMAC instructions since the type of source address determines
>> -   if it is a EMAC-load instruciton if the EA is mode 2-5, otherwise it
>> +   if it is a EMAC-load instruction if the EA is mode 2-5, otherwise it
>>     is a non-load EMAC instruction and the bits mean register Ry.
>>     A similar case exists for the movem instructions where the register
>>     mask is interpreted differently for different EAs.  */
>> @@ -1080,7 +1080,7 @@ print_indexed (int basereg,
>>  
>>  /* Returns number of bytes "eaten" by the operand, or
>>     return -1 if an invalid operand was found, or -2 if
>> -   an opcode tabe error was found.
>> +   an opcode table error was found.
>>     ADDR is the pc for this arg to be relative to.  */
>>  
>>  static int
>> diff --git a/disas/ppc.c b/disas/ppc.c
>> index 63e97cfe1d..02be878198 100644
>> --- a/disas/ppc.c
>> +++ b/disas/ppc.c
>> @@ -5226,7 +5226,7 @@ operand_value_powerpc (const struct powerpc_operand *operand,
>>        if ((operand->flags & PPC_OPERAND_SIGNED) != 0)
>>  	{
>>  	  /* BITM is always some number of zeros followed by some
>> -	     number of ones, followed by some numer of zeros.  */
>> +	     number of ones, followed by some number of zeros.  */
>>  	  unsigned long top = operand->bitm;
>>  	  /* top & -top gives the rightmost 1 bit, so this
>>  	     fills in any trailing zeros.  */
> 
> 



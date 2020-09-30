Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A267C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:23:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED8422072E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED8422072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNesk-0001AK-2d
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 12:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kNepz-0008G7-5u; Wed, 30 Sep 2020 12:20:15 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:42203)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kNepv-0004Vr-PJ; Wed, 30 Sep 2020 12:20:14 -0400
Received: from [192.168.100.1] ([82.252.145.98]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MsI0K-1khwu60YPq-00tk2r; Wed, 30 Sep 2020 18:19:56 +0200
Subject: Re: [PATCH RFC 08/14] m68k/: fix some comment spelling errors
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 zhaolichang <zhaolichang@huawei.com>, qemu-trivial@nongnu.org
References: <20200930095321.2006-1-zhaolichang@huawei.com>
 <20200930095321.2006-9-zhaolichang@huawei.com>
 <a1e3bd75-8eb5-0f7f-7c2f-81e3de0a0114@vivier.eu>
 <6a8cd8ab-3a8c-bb24-2193-67b0a1cebf16@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <1f1a2609-7d2a-bbb9-08d9-e81af9c9c6ec@vivier.eu>
Date: Wed, 30 Sep 2020 18:19:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <6a8cd8ab-3a8c-bb24-2193-67b0a1cebf16@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ic6qg2sQd7+WEoc2z+1BiZfECJE3Aj0rM7GzY3wdMRYM854RIZx
 6jFNkRZco+S5Yzedl01ahX5uuqIv4rzbf4MP/NsvPAqxd5zXSxofpvImUZyeaTlsms0G+DE
 g0BgsksAD3nz0S/AevX823d863d64ZPpUnSlM3jrxTv7Funz2J67cK7YQyiPr+xIoEDCwi/
 XUOcKQUwpa5uegNEbKxcg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vazt4hVDbzY=:g9nMg6iYydF3JtwT19NmNi
 M+qWvlKGYydG8LCpYhpY+rrRncjjvjyl0nBtbQeIxRvNlVn64ChReiQ5vmOcYJugh/ipgv/nY
 cw6lMGRuwwI5XQMj+82wBdOnoW31LUL5+jWkkK5xYLF4ncsQ3TvXmruQ9y49YZSAoH9qcxeJ6
 Ydd9DNLUMtkQlApE+5Q2HDMVERvP02/k7Dlawi8zx3XAGVe2B4OlWLOd9n/AfGoOTLJZZFXn4
 4NmT9vhfjqP3gAxXKqqc6zf/T/X0VAFROJ91ssUNXT6j8I6Ognde/ZEU6mu8VbcShArkWnt0W
 AtcVUMfEAbelQbxxibqAwDZjl6OIUpoZG2cmrcNN2r7Trt/AOoLS2+ishH5iC0/IP0rHoaHgE
 RZEzgENQWNRGqoJjj5vd8JE3jeWPwXZCVuedZUwPC1YqCiwVxmveHmqi55NTR00MYIshwEHM3
 JCyIyyNPGs1OQT0I3aoznz4/40vbmOjIRKy7A5VuiL0DivBcFZkJDiESX4k6+7KJ5x8EiTiJH
 Vg5iEpYUvBU5OYjCohHnjLU546yS4TQEux5446Wrkv1d0ZIGHbsgKMDTAfp5wOHTQhucbTvoS
 DCHafQnL7I0vQKUNt6hkM82HMfQ0k1O4FoxF0A/uU547YAJljqyViEN08dxggT2AR5t4wyVhn
 hVQEfMNyShmFGqUQvBdVeovD9mjWLHEZQqO0cz1tVyACvKws2omb9wftLEKn+GQQ6ulLjjxcy
 8hgHuNaMM1SRU+KyzeR5b0FSeqGWMLrjl3bH9CLIGlRFcfe56eDD51u4O7K5z/oBvOUa/pJWG
 Sje0nx0C3t8XN1NfjVtYwrRyXQFtMV5gZhigKOCTqrWUcfD72zRjAiigBRpAkuJTusK6Wic
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 12:20:09
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 30/09/2020 à 18:03, Philippe Mathieu-Daudé a écrit :
> On 9/30/20 12:26 PM, Laurent Vivier wrote:
>> Le 30/09/2020 à 11:53, zhaolichang a écrit :
>>> I found that there are many spelling errors in the comments of qemu/target/m68k.
>>> I used spellcheck to check the spelling errors and found some errors in the folder.
>>>
>>> Signed-off-by: zhaolichang <zhaolichang@huawei.com>
>>> ---
>>>  target/m68k/translate.c | 16 ++++++++--------
>>>  1 file changed, 8 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
>>> index 3fc67aa..133a404 100644
>>> --- a/target/m68k/translate.c
>>> +++ b/target/m68k/translate.c
>>> @@ -438,7 +438,7 @@ static TCGv gen_addr_index(DisasContext *s, uint16_t ext, TCGv tmp)
>>>  }
>>>  
>>>  /*
>>> - * Handle a base + index + displacement effective addresss.
>>> + * Handle a base + index + displacement effective address.
>>>   * A NULL_QREG base means pc-relative.
>>>   */
>>>  static TCGv gen_lea_indexed(CPUM68KState *env, DisasContext *s, TCGv base)
>>> @@ -1696,7 +1696,7 @@ static void bcd_add(TCGv dest, TCGv src)
>>>  
>>>      /*
>>>       * t1 = (src + 0x066) + dest + X
>>> -     *    = result with some possible exceding 0x6
>>> +     *    = result with some possible exceeding 0x6
>>>       */
>>>  
>>>      t0 = tcg_const_i32(0x066);
>>> @@ -1706,7 +1706,7 @@ static void bcd_add(TCGv dest, TCGv src)
>>>      tcg_gen_add_i32(t1, t0, dest);
>>>      tcg_gen_add_i32(t1, t1, QREG_CC_X);
>>>  
>>> -    /* we will remove exceding 0x6 where there is no carry */
>>> +    /* we will remove exceeding 0x6 where there is no carry */
>>>  
>>>      /*
>>>       * t0 = (src + 0x0066) ^ dest
>>> @@ -1736,7 +1736,7 @@ static void bcd_add(TCGv dest, TCGv src)
>>>      tcg_temp_free(t0);
>>>  
>>>      /*
>>> -     * remove the exceding 0x6
>>> +     * remove the exceeding 0x6
>>>       * for digits that have not generated a carry
>>>       */
>>>  
>>> @@ -2638,7 +2638,7 @@ DISAS_INSN(negx)
>>>      gen_flush_flags(s); /* compute old Z */
>>>  
>>>      /*
>>> -     * Perform substract with borrow.
>>> +     * Perform subtract with borrow.
>>>       * (X, N) =  -(src + X);
>>>       */
>>>  
>>> @@ -2653,7 +2653,7 @@ DISAS_INSN(negx)
>>>      /*
>>>       * Compute signed-overflow for negation.  The normal formula for
>>>       * subtraction is (res ^ src) & (src ^ dest), but with dest==0
>>> -     * this simplies to res & src.
>>> +     * this simplifies to res & src.
>>>       */
>>>  
>>>      tcg_gen_and_i32(QREG_CC_V, QREG_CC_N, src);
>>> @@ -3159,7 +3159,7 @@ static inline void gen_subx(DisasContext *s, TCGv src, TCGv dest, int opsize)
>>>      gen_flush_flags(s); /* compute old Z */
>>>  
>>>      /*
>>> -     * Perform substract with borrow.
>>> +     * Perform subtract with borrow.
>>>       * (X, N) = dest - (src + X);
>>>       */
>>>  
>>> @@ -3169,7 +3169,7 @@ static inline void gen_subx(DisasContext *s, TCGv src, TCGv dest, int opsize)
>>>      gen_ext(QREG_CC_N, QREG_CC_N, opsize, 1);
>>>      tcg_gen_andi_i32(QREG_CC_X, QREG_CC_X, 1);
>>>  
>>> -    /* Compute signed-overflow for substract.  */
>>> +    /* Compute signed-overflow for subtract.  */
>>>  
>>>      tcg_gen_xor_i32(QREG_CC_V, QREG_CC_N, dest);
>>>      tcg_gen_xor_i32(tmp, dest, src);
>>>
>>
>> Reviewed-by: Laurent Vivier <laurent@vivier>
> 
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Yes, thanks.

> 
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 

Laurent


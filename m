Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9C8C43218
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 07:06:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42E062089E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 07:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E062089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52260 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haarc-0001p3-1w
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 03:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59278)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lvivier@redhat.com>) id 1haar3-0001Fs-8P
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 03:06:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lvivier@redhat.com>) id 1haar2-0000Tz-0N
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 03:06:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53066)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lvivier@redhat.com>)
 id 1haar1-00006i-On; Tue, 11 Jun 2019 03:05:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9FC0BC057F4B;
 Tue, 11 Jun 2019 07:05:40 +0000 (UTC)
Received: from [10.36.117.111] (ovpn-117-111.ams2.redhat.com [10.36.117.111])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1618C608CD;
 Tue, 11 Jun 2019 07:05:33 +0000 (UTC)
To: David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20190529065017.15149-1-david@gibson.dropbear.id.au>
 <20190529065017.15149-24-david@gibson.dropbear.id.au>
 <31966f5b-d46c-4b86-6852-c949d9f72497@redhat.com>
 <9218989c-c92d-6e7b-71a9-08d511c3a0b3@redhat.com>
 <32a8e668-80f5-1429-58f4-8935c973dd2b@linaro.org>
 <20190611024324.GB3998@umbus.fritz.box>
From: Laurent Vivier <lvivier@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=lvivier@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <0064e4ce-c0b9-54a9-3687-497c707eb185@redhat.com>
Date: Tue, 11 Jun 2019 09:05:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190611024324.GB3998@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 11 Jun 2019 07:05:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 23/44] target/ppc: Use vector variable
 shifts for VSL, VSR, VSRA
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/06/2019 04:43, David Gibson wrote:
> On Fri, Jun 07, 2019 at 09:28:49AM -0500, Richard Henderson wrote:
>> On 6/7/19 9:09 AM, Laurent Vivier wrote:
>>> On 07/06/2019 11:29, Laurent Vivier wrote:
>>>> On 29/05/2019 08:49, David Gibson wrote:
>>>>> From: Richard Henderson <richard.henderson@linaro.org>
>>>>>
>>>>> The gvec expanders take care of masking the shift amount
>>>>> against the element width.
>>>>>
>>>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>>>> Message-Id: <20190518191430.21686-2-richard.henderson@linaro.org>
>>>>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>>>>> ---
>>>>>  target/ppc/helper.h                 | 12 ----------
>>>>>  target/ppc/int_helper.c             | 37 -----------------------------
>>>>>  target/ppc/translate/vmx-impl.inc.c | 24 +++++++++----------
>>>>>  3 files changed, 12 insertions(+), 61 deletions(-)
>>>>
>>>> This patch introduces a regressions
>>>>  with Fedora 29 guest:
>>>>
>>>> - during kernel boot:
>>>>
>>>> [   40.397876] crypto_register_alg 'aes' = 0
>>>> [   40.577517] crypto_register_alg 'cbc(aes)' = 0
>>>> [   40.743576] crypto_register_alg 'ctr(aes)' = 0
>>>> [   41.061379] alg: skcipher: Test 1 failed (invalid result) on encryption for p8_aes_xts
>>>> [   41.062054] 00000000: 91 7c f6 9e bd 68 b2 ec 9b 9f e9 a3 ea dd a6 92
>>>> [   41.062163] 00000010: 98 10 35 57 5e dc 36 1e 9a f7 bc ba 39 f2 5c eb
>>>> [   41.062834] crypto_register_alg 'xts(aes)' = 0
>>>> [   41.077358] alg: hash: Test 2 failed for p8_ghash
>>>> [   41.077553] 00000000: 5f 89 ab f7 20 57 20 57 20 57 20 57 20 57 20 57
>>>>
>>>> - with libssl:
>>>>
>>>> # curl -o /dev/null https://www.google.com
>>>>   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
>>>>                                  Dload  Upload   Total   Spent    Left  Speed
>>>>   0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
>>>> curl: (35) error:1408F119:SSL routines:ssl3_get_record:decryption failed or bad record mac
>>>>
>>>> [before, this one fails with:
>>>> curl: (35) error:04091068:rsa routines:int_rsa_verify:bad signature ]
>>>>
>>>> If I revert this patch on top of 0d74f3b427 + "target/ppc: Fix lxvw4x, lxvh8x and lxvb16x", all works fine.
>>>>
>>>> Thanks,
>>>> Laurent
>>>>
>>>
>>> This seems to fix the problem:
>>>
>>> diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
>>> index 3b6052fe97..6f0709b307 100644
>>> --- a/accel/tcg/tcg-runtime-gvec.c
>>> +++ b/accel/tcg/tcg-runtime-gvec.c
>>> @@ -874,7 +874,7 @@ void HELPER(gvec_sar8v)(void *d, void *a, void *b,
>>> uint32_t desc)
>>>      intptr_t oprsz = simd_oprsz(desc);
>>>      intptr_t i;
>>>
>>> -    for (i = 0; i < oprsz; i += sizeof(vec8)) {
>>> +    for (i = 0; i < oprsz; i += sizeof(uint8_t)) {
>>>          uint8_t sh = *(uint8_t *)(b + i) & 7;
>>>          *(int8_t *)(d + i) = *(int8_t *)(a + i) >> sh;
>>>      }
>>
>> Grr.  I really really need to come up with a solution for testing that allows
>> me to test paths that the host cpu would not ordinarily take.  This bug is
>> hidden on a host with AVX2.
>>
>> Thanks for the digging.
> 
> Can one of you send this fix formally with a S-o-b and so forth?

I'm going to send it.

Thanks,
Laurent



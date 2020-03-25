Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D2AC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:15:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AFD220714
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AFD220714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH34G-0000ra-8i
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 06:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59421)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jH33Z-0000CN-SL
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:14:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jH33Y-0005XW-6D
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:14:41 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:34889)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jH33X-0005Wo-Tq; Wed, 25 Mar 2020 06:14:40 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N8ojI-1jMBJg0cDu-015uMG; Wed, 25 Mar 2020 11:14:30 +0100
Subject: Re: [PATCH 3/3] crypto: Redundant type conversion for AES_KEY pointer
To: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
References: <20200325092137.24020-1-kuhn.chenqun@huawei.com>
 <20200325092137.24020-4-kuhn.chenqun@huawei.com>
 <f57b72eb-fdf8-b811-64d1-04d95a15f6e6@vivier.eu>
 <7412CDE03601674DA8197E2EBD8937E83B6C24A6@dggemm511-mbx.china.huawei.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <50a8dc38-bffd-9bb3-5b4c-0088cb538269@vivier.eu>
Date: Wed, 25 Mar 2020 11:14:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <7412CDE03601674DA8197E2EBD8937E83B6C24A6@dggemm511-mbx.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JacwWEE2UmjiDBbOY0y1q8bcNjnNKefYL2HjctlJ35B0oOr/Z4v
 941x5tS+W2vr2PeiXkyd96hvqNIMCC0xHX09Vs5XaLK66Sih6wAv/o+6blqzkjj1iAwhPQK
 fVM2mb6NeO6+a55dtYkOlRy4WDIgylS0moPLZH5/aL75CqEwmmoUZBRztXYTix4fAIQxSpO
 3rO5yBVABU4AmsOM5rL7Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mFh8CiPOqDE=:Pg4TD/naBCz4W5lQ/Frb97
 chg37rfuU9aIqRRW7NgpVvWpqGJa6pqsKI4sHKIiJIGmDqS+qjuoFhNGUp/R0imVoEtvbBQTt
 xdN4a8WTRf5FpuhrF7GXMSURRIql+gavO/2IPnGyhF3knOZkYCyC/uI4+9J+hI+XzDf8tLxAm
 d7O/ARm/hcxRCPtTyDWuNE+dVsVke3OkxfUZh1QBrJEOk1sFcp+rxUFxmsDzF52zpXiqPkCna
 0MOol5wfN1qCIndJ/jPDDE+dvvPFRB0GLfLp5ygBkGgmNzHMZ6yQch9g7Ru8dt2bX0HFlwKPe
 NCqXC5v+wU6qkppmgU4t75wGPL+ydUmh536P5XTWoFxepfpWcSvQhlLrI+u6qkw4PJLUyD69n
 RCeHxR4Ouyfho0nY5xemFvofAh/M0h+NUjTFL3Blhf6KFydSc54UOOapgZDheLU733AJLPNBH
 dP5gGucmV2Hqdom7Kx0wFULot5st1MD3kduFPtbwJJKe1iZp11jrufiwDvfvHgb3aIzc6eG0s
 6gIktSl+ORCMY1gfPWDL50aAoMiGWk3I5ITNIb9C4fnpPwzNo2EIa4YH2hPPmVVamh8hsme/z
 SbrMdY/0rb7IsNvelscVUe0X8yPKQCT+GRWLfUYV97djzes1r8Y3JFChc2Rbvc6baBW3DiOJY
 VCdm6Amrxj/UmoGk0kaLJ9UOgKIdjPrKzGCpCLIOR9gCX3va6zefmYHc2imsKMmy2c25/Dma6
 L4hA+K6gPlbN5U1jnw6VTy9a57YXQT29nr0k50SxpujXipVvBA3jWjPegOyQ05bjUxbR4EZXR
 VX2MRUGZzexdPQrDBzcF8yEhTa3w88Y5TET7zrHq1ZpYj4jNXVJBcKQl7XuUx9vSn/51IRU
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 25/03/2020 à 11:06, Chenqun (kuhn) a écrit :
>> -----Original Message-----
>> From: Laurent Vivier [mailto:laurent@vivier.eu]
>> Sent: Wednesday, March 25, 2020 5:45 PM
>> To: Chenqun (kuhn) <kuhn.chenqun@huawei.com>; qemu-devel@nongnu.org;
>> qemu-trivial@nongnu.org
>> Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>; Euler Robot
>> <euler.robot@huawei.com>; Daniel P. Berrangé <berrange@redhat.com>
>> Subject: Re: [PATCH 3/3] crypto: Redundant type conversion for AES_KEY pointer
>>
>> Le 25/03/2020 à 10:21, Chen Qun a écrit :
>>> Fix: eaec903c5b8
>>>
>>
>> Did you run the coccinelle script scripts/coccinelle/typecast.cocci ?
>>
> Yes, I run it and plan to integrate it into EulerRobot so that similar issues can be discovered sooner.
> 
> Thanks.
>>
>>> Reported-by: Euler Robot <euler.robot@huawei.com>
>>> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
>>> ---
>>> Cc: "Daniel P. Berrangé" <berrange@redhat.com>
>>> ---
>>>  crypto/cipher-builtin.c | 6 ++----
>>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/crypto/cipher-builtin.c b/crypto/cipher-builtin.c index
>>> bf8413e71a..99d6280a16 100644
>>> --- a/crypto/cipher-builtin.c
>>> +++ b/crypto/cipher-builtin.c
>>> @@ -133,8 +133,7 @@ static void qcrypto_cipher_aes_xts_encrypt(const
>>> void *ctx,  {
>>>      const QCryptoCipherBuiltinAESContext *aesctx = ctx;
>>>
>>> -    qcrypto_cipher_aes_ecb_encrypt((AES_KEY *)&aesctx->enc,
>>> -                                   src, dst, length);
>>> +    qcrypto_cipher_aes_ecb_encrypt(&aesctx->enc, src, dst, length);
>>>  }
>>>
>>>
>>> @@ -145,8 +144,7 @@ static void qcrypto_cipher_aes_xts_decrypt(const
>>> void *ctx,  {
>>>      const QCryptoCipherBuiltinAESContext *aesctx = ctx;
>>>
>>> -    qcrypto_cipher_aes_ecb_decrypt((AES_KEY *)&aesctx->dec,
>>> -                                   src, dst, length);
>>> +    qcrypto_cipher_aes_ecb_decrypt(&aesctx->dec, src, dst, length);
>>>  }
>>>
>>>
>>>
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


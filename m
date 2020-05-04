Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFF7C47257
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:49:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36172206D9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:49:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36172206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVaXS-00049Z-AR
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVaLO-0007nl-DE; Mon, 04 May 2020 08:37:10 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:53281)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVaLM-0003Bf-VJ; Mon, 04 May 2020 08:37:10 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MPXpS-1jjQEd1Ymo-00MaeN; Mon, 04 May 2020 14:36:57 +0200
Subject: Re: [PATCH 3/3] crypto: Redundant type conversion for AES_KEY pointer
From: Laurent Vivier <laurent@vivier.eu>
To: Chen Qun <kuhn.chenqun@huawei.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20200325092137.24020-1-kuhn.chenqun@huawei.com>
 <20200325092137.24020-4-kuhn.chenqun@huawei.com>
 <4b614cd4-ad35-94b1-a7b6-6950fa08617c@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <adc56e1f-177f-7e57-8ffd-442d53a6f7ed@vivier.eu>
Date: Mon, 4 May 2020 14:36:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <4b614cd4-ad35-94b1-a7b6-6950fa08617c@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:toIhBEPPz1XjNnFVyu1m/FuY7EafMvd5NsePT3N6w7vly5gXbTu
 klhvauN9EwXoWayDqaOFWZJofGfSe+qRzboMo7gMvDTcJ14c4+z37qCY9kQL+o63XkvpXb5
 rqqs582oZsr/6R+Hnw8ieRW6kXc0i1d1sishYe01M5nVPVE3GXSmLY5NG+qdfOewav7udrv
 3exg+Jt3aXY+7uPWj3XbA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:94MLTOuWtok=:aOJssfuDhZLm8gvYEG7idT
 8Q3Gr0QJ2Q+EVBT4FM+chusSjTtaI6hEH/YsylMpGGSsldeXOLCMrvLqWaatjEvsAAuwpSm59
 uguVlntVXJgJWzgEtq+SRF7hU6/36XcbaB6ktQ7a5vZX26hHCKuf2aU0OqE0K8YMAu+bYIlJt
 eyTH5QnO51+/gOskTTIg+4G6jZjmX5AWfdkVALjZdmDqEVyItw00aMp+V7WWgS7clHq5QnwAD
 249B6BO3ERVFL8vNj2Ti4ffQmyKpBTyx/Fy1VP/Ew5UHEtmvEi12aV9a2WYN9O7FtRa5Q8gWs
 JjNVU+m50c0aDu5zOct+CcNLh13+LFjgMDAoITA5OHvvN7RcSqy9lozdvhrSh58CjCubNaz83
 pyJ/BMvD73rn3GNf2AxdPjMJSSc2eONIuqajAOR/2aDzvDjjGIrIsf3wcxumejr/QPvad3Rv0
 c6NZP0+GXZe7BQywN58srafsI/5ZNeD8hVqq7k76TWGBXx0XUAfjnX8cCcllbJ4nKqm67KoRM
 MMLJQAgem/owYl9s96FrGr4CZs0Stl+0PVEE5M/eckPBfUem1uWv8JqcqN2DZnO1jau+kNaB5
 kYG8pP01MFgPkKFNwHbux/ZXvwQBCU+IaLzfPm/aGpKw4z8I1zYaZFkUHlnzhZjMGU9E8g0bu
 axMTnsBifiK7ETmbgJtC77vCIWhGg47abnTIWolbcCwDoCi7mTLqxg3qqbfpuZsiPwNTK8EPu
 NoNEyznazTqWve+LqdxQigRCArwCzs+7j4V+FLqFJZzctpPXxpvpzsCwJOQNnELzco7UkRWRX
 KBAb1ot5rby3F/4vh/L6obWw2ttTIbbudbLisSu1pV7KwhgsVGiQ/ZxCmPP/ryeSJWJkHmh
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 08:37:07
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 zhang.zhanghailiang@huawei.com, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 03/04/2020 à 10:47, Laurent Vivier a écrit :
> Le 25/03/2020 à 10:21, Chen Qun a écrit :
>> Fix: eaec903c5b8
>>
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
>> ---
>> Cc: "Daniel P. Berrangé" <berrange@redhat.com>
>> ---
>>  crypto/cipher-builtin.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/crypto/cipher-builtin.c b/crypto/cipher-builtin.c
>> index bf8413e71a..99d6280a16 100644
>> --- a/crypto/cipher-builtin.c
>> +++ b/crypto/cipher-builtin.c
>> @@ -133,8 +133,7 @@ static void qcrypto_cipher_aes_xts_encrypt(const void *ctx,
>>  {
>>      const QCryptoCipherBuiltinAESContext *aesctx = ctx;
>>  
>> -    qcrypto_cipher_aes_ecb_encrypt((AES_KEY *)&aesctx->enc,
>> -                                   src, dst, length);
>> +    qcrypto_cipher_aes_ecb_encrypt(&aesctx->enc, src, dst, length);
>>  }
>>  
>>  
>> @@ -145,8 +144,7 @@ static void qcrypto_cipher_aes_xts_decrypt(const void *ctx,
>>  {
>>      const QCryptoCipherBuiltinAESContext *aesctx = ctx;
>>  
>> -    qcrypto_cipher_aes_ecb_decrypt((AES_KEY *)&aesctx->dec,
>> -                                   src, dst, length);
>> +    qcrypto_cipher_aes_ecb_decrypt(&aesctx->dec, src, dst, length);
>>  }
>>  
>>  
>>
> 
> Applied to my trivial-patches-for-5.1 branch.

Removed from the queue because of build errors:

https://travis-ci.com/github/vivier/qemu/jobs/327261040

In file included from /home/travis/build/vivier/qemu/crypto/cipher.c:157:0:
1251/home/travis/build/vivier/qemu/crypto/cipher-builtin.c: In function
‘qcrypto_cipher_aes_xts_encrypt’:
1252/home/travis/build/vivier/qemu/crypto/cipher-builtin.c:136:36:
error: passing argument 1 of ‘qcrypto_cipher_aes_ecb_encrypt’ discards
‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
1253     qcrypto_cipher_aes_ecb_encrypt(&aesctx->enc, src, dst, length);
1254                                    ^
1255/home/travis/build/vivier/qemu/crypto/cipher-builtin.c:77:13: note:
expected ‘AES_KEY * {aka struct aes_key_st *}’ but argument is of type
‘const AES_KEY * {aka const struct aes_key_st *}’
1256 static void qcrypto_cipher_aes_ecb_encrypt(AES_KEY *key,
1257             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1258/home/travis/build/vivier/qemu/crypto/cipher-builtin.c: In function
‘qcrypto_cipher_aes_xts_decrypt’:
1259/home/travis/build/vivier/qemu/crypto/cipher-builtin.c:147:36:
error: passing argument 1 of ‘qcrypto_cipher_aes_ecb_decrypt’ discards
‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
1260     qcrypto_cipher_aes_ecb_decrypt(&aesctx->dec, src, dst, length);
1261                                    ^
1262/home/travis/build/vivier/qemu/crypto/cipher-builtin.c:103:13: note:
expected ‘AES_KEY * {aka struct aes_key_st *}’ but argument is of type
‘const AES_KEY * {aka const struct aes_key_st *}’
1263 static void qcrypto_cipher_aes_ecb_decrypt(AES_KEY *key,
1264             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1265cc1: all warnings being treated as errors
1266/home/travis/build/vivier/qemu/rules.mak:69: recipe for target
'crypto/cipher.o' failed
1267make: *** [crypto/cipher.o] Error 1
1268make: *** Waiting for unfinished jobs....


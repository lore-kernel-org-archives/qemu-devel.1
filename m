Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAD4C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:32:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B435920661
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B435920661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVaH8-0007kr-Qx
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVaGV-0006rK-RJ; Mon, 04 May 2020 08:32:07 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:34633)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVaGU-0008Vf-I0; Mon, 04 May 2020 08:32:07 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MTw02-1jf2B63pdy-00R3EV; Mon, 04 May 2020 14:32:03 +0200
Subject: Re: [PULL 00/20] Trivial branch for 5.1 patches
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200504115758.283914-1-laurent@vivier.eu>
 <CAFEAcA_FDt+1+ezAyRE-fwdd=VuG5YNThkKiHHTUOYqtRHLoyg@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <53fb1df6-10e9-25ef-7e41-b2613e4885b2@vivier.eu>
Date: Mon, 4 May 2020 14:32:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_FDt+1+ezAyRE-fwdd=VuG5YNThkKiHHTUOYqtRHLoyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:izH7r0CVvUJmFdwMyqh4C/qOsjIf/D4KQ30/1AvOvXl25tKOR6K
 LwSp63fQeZVGjH3xrmFg1zMl8h5QIFej37wohDcX5j0YNP91qW90pEUl2TohOoOzQmLlRHP
 4kS+6/E93D6ZKOgaUtl3WR3fyMUVYKHaS62EGPxTmjYz8O3a1kPywCh1gAlcpSOjPTBFEyz
 Lecv5wPzYwvYRgnZdXBtA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5p0Uo9SZ8Ys=:YCAOrJwyH4ToThfg/l5Hq7
 diYZHZtyubiMziXf79qY2GFv2Sg+NJaKSPky5LLWwmgh/svVqbG9mIozSUosAqKsHZ6cpAifn
 m74k8wkEGntB8MkW9ObHivxHLGQOclNSsZFjy3J0G84kUx2ow1SGOPFhJ4F9EQpHFI8A1w04G
 sIHC6QPJD4RCYaRnM8hzen3D+3wrXb0TZ1lrAnJ8UHo8GYTdLCS46ev17hxzJk3neLVPa+Hwh
 ASAYOvAe9nSiiYi/fQQ+qiM0YGT5wEfO7eDMsxLETYK9JRPsaMs1oAjo7EkAsjZwTJOn0mLqG
 LGdWSakvfjPTp9ZfQJb3T4lFcYkWjEiQXeM+ANe0NWFgGd86g7q5lFzYktaQX3xiws3LKVi5r
 e8bbE+WbD1nBpqqR0o9S+L4zq61fvDWQHCWvvLlL/6tXDGUCpU5jvrAaEXaZmnT1hzRtC+sjA
 eaplc6ssX7cjh0WSaDtDRhC89afnXiKb1GfNxd6H8FBl6MYaYdf49/1rDXnNEFZ/pVm1TYAaU
 vZMgmV0KihIlZ70aicW+aievN4G5YXr7zk0aGzY1rKSH74hDzlAb/AARuZS0J3AM93UPTHSje
 yat5KldrWDj4FbjplKN7ONgarOWk0Av/CMUZsxrzhjRbOtiHJ17iAW9NU5TR6hHT9hyXgTIEc
 Y8GBVtqtbsd1s2cOWUoli48w8SDv6qw40UdlGCxu/nkQPjNcLvaYyXxAK+1/DAJJ2OQyRktAZ
 ezgMAHGvCD+yy2RsfasfSzdmPqOkaDdsOTh6X29yeR+byHOE6A+KTrcbbGIHNPPDF1lMv7xJJ
 Mlo8ocEaX5R74GXqslK+tCWW78r/LGjEtvnA3MFBJP3sPuTC+6q/N32WvEHbjvu8Y0jgh1e
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 08:32:04
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 04/05/2020 à 14:17, Peter Maydell a écrit :
> On Mon, 4 May 2020 at 13:05, Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> The following changes since commit 2ef486e76d64436be90f7359a3071fb2a56ce835:
>>
>>   Merge remote-tracking branch 'remotes/marcel/tags/rdma-pull-request' into s=
>> taging (2020-05-03 14:12:56 +0100)
>>
>> are available in the Git repository at:
>>
>>   git://github.com/vivier/qemu.git tags/trivial-branch-for-5.1-pull-request
>>
>> for you to fetch changes up to 4341a0106781043a708c061b676312e5bb5d4488:
>>
>>   hw/timer/pxa2xx_timer: Add assertion to silent static analyzer warning (202=
>> 0-05-04 12:06:21 +0200)
>>
>> ----------------------------------------------------------------
>> trivial patches (20200504)
>>
>> Silent static analyzer warning
>> Remove dead assignments
>> Support -chardev serial on macOS
>> Update MAINTAINERS
>> Some cosmetic changes
> 
> 
> Compile failure, OSX:
> /Users/pm215/src/qemu-for-merges/block/file-posix.c:1620:9: error:
> unused variable 'ret' [-Werror,-Wunused-variable]
>     int ret;
>         ^
> 
> Compile failure, aarch32 (but probably the result of whatever
> crypto options/dependent libraries are on that setup):
> 
> In file included from /home/peter.maydell/qemu/crypto/cipher.c:157:0:
> /home/peter.maydell/qemu/crypto/cipher-builtin.c: In function
> 'qcrypto_cipher_aes_xts_encrypt':
> /home/peter.maydell/qemu/crypto/cipher-builtin.c:136:36: error:
> passing argument 1 of 'qcrypto_cipher_aes_ecb_encrypt' discards
> 'const' qualifier from pointer target type
> [-Werror=discarded-qualifiers]
>      qcrypto_cipher_aes_ecb_encrypt(&aesctx->enc, src, dst, length);
>                                     ^
> /home/peter.maydell/qemu/crypto/cipher-builtin.c:77:13: note: expected
> 'AES_KEY * {aka struct aes_key_st *}' but argument is of type 'const
> AES_KEY * {aka const struct aes_key_st *}'
>  static void qcrypto_cipher_aes_ecb_encrypt(AES_KEY *key,
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /home/peter.maydell/qemu/crypto/cipher-builtin.c: In function
> 'qcrypto_cipher_aes_xts_decrypt':
> /home/peter.maydell/qemu/crypto/cipher-builtin.c:147:36: error:
> passing argument 1 of 'qcrypto_cipher_aes_ecb_decrypt' discards
> 'const' qualifier from pointer target type
> [-Werror=discarded-qualifiers]
>      qcrypto_cipher_aes_ecb_decrypt(&aesctx->dec, src, dst, length);
>                                     ^
> /home/peter.maydell/qemu/crypto/cipher-builtin.c:103:13: note:
> expected 'AES_KEY * {aka struct aes_key_st *}' but argument is of type
> 'const AES_KEY * {aka const struct aes_key_st *}'
>  static void qcrypto_cipher_aes_ecb_decrypt(AES_KEY *key,
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Thank you. Next time I will wait end of travis-ci job...

Laurent


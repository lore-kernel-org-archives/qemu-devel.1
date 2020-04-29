Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD207C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:31:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F1BC2074A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F1BC2074A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTnjr-00017E-Hg
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 10:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jTniH-0008Rs-O1
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:29:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jTnhA-00082Q-3U
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:29:25 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:59475)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jTnh9-000823-CP
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:28:15 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1Mtf39-1jBIEV0U1P-00v9Vq; Wed, 29 Apr 2020 16:27:56 +0200
Subject: Re: [PATCH 1/2] softfloat: m68k: infinity is a valid encoding
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <1588094279-17913-1-git-send-email-frederic.konrad@adacore.com>
 <1588094279-17913-2-git-send-email-frederic.konrad@adacore.com>
 <87d07rlac5.fsf@linaro.org> <9f6c1efc-a195-0f5d-8c34-4dfb45d910f8@vivier.eu>
 <87a72ulk1z.fsf@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <1a78341c-b481-c9f2-f8fd-f50ab3bf197f@vivier.eu>
Date: Wed, 29 Apr 2020 16:27:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87a72ulk1z.fsf@linaro.org>
Content-Type: multipart/mixed; boundary="------------28FFA7FEB0FA5544334CCF97"
Content-Language: fr
X-Provags-ID: V03:K1:96pDyngteyBJfC8dID8RbuhDyOOmSUb3wZGwLUdNaQ63qFCHWA9
 4FFcbXDG9cdG9KTg6xkca+lZa7kM2GI/MxcyEm38a37/rlm9jnJi9vrDtXSlt3o9d5EGLfj
 nDSoKcbSfGjGsRy7uEL8utVmpIqqej0Md1oOZFxP5ac98MiOYHr1RLEhNOLxkx2RdF6cWXd
 s9yTDRMN/OtuOk2aCDHow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ha5ww0lD7tA=:IfJ2BuT5Z6S3D7RGHXO37s
 r+nfTOtPcHz6Bo3xT/BuDnUSAdWSWPYozB+TDhCZ75FzWv2KfHPg+0fTKcKihyM1z8lswh04f
 MqXx3S7ZuR5Xkt5gdoeWy422uLIcQgjZXROtxtF7fbHs3wVTArEaVoXnrtj9s/mz5SnAANlPr
 GXCaqAEvHE2yXjeFC9tEEOYJdtwOETt+BqskhPtUHVKzX9pLJa5Iyjd+j0qUYQV/ptlerBeW8
 Cj6hFuvx43tFbk0Vb56bcc5nlp3AoRDaGzcsrXUbbuvq1Ow3HeDMVZCZ+Xdb5GTKLUPLiuDFT
 omAXob9kNHnJ+FrpY+xCTi6EcrxKzawgDMua4tqTFyYgDMSNOGZYCYoXPiskWWxiyd2S8RLYN
 3eogIAskdCJL/QTgl8603Ptl90qk3971jVp5hlxutSTvIsFZdc+8A++zmxkEkj1ysFxAdf8fT
 oaVBVltVmgKWt7TOZBDuDgnWzZXyJlZTh0gY8wk8BMU6WmA0/6KOJX2ZFABV5mOWT1ACAkaOA
 i7besGR/sjc3KAU/tgMicnYb7RWXqqSkcY4Wjt8FiHBn3CLpZtVGt6Zp8dtUs1D9kAtaOjHhw
 MrUGGsOCUjNEdxFAunHMV429lVzunUuCs1LpDOQJKzt5haZRhuIjds1qxzX0QqArsR5TNm2BM
 G3ezZnOa12uJVW5zx/F7hWVugSHmc3ZQ/gOtD4llVo8vSwn5SjMRWraGj1IwF+RE4MI8syeiM
 cKT1Txoj+7tVLy8M1deY+gYtN6mZtsMoOxm7vKJY1zGAxe4Xz6h19TvX2mWDWsSilbLOli1Zk
 PHLtBTxkNhUt/GE5J6okULdHDLjuIy4OPNVH2oNTxPMQUpwp3W1SKJCz/2P2S1F4SwQYMwn
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 10:28:12
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Received-From: 212.227.126.130
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>, philmd@redhat.com,
 qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------28FFA7FEB0FA5544334CCF97
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Le 29/04/2020 à 11:26, Alex Bennée a écrit :
> 
> Laurent Vivier <laurent@vivier.eu> writes:
> 
>> Le 28/04/2020 à 20:43, Alex Bennée a écrit :
>>>
>>> KONRAD Frederic <frederic.konrad@adacore.com> writes:
>>>
>>>> The MC68881 say about infinities (3.2.4):
>>>>
>>>> "*For the extended precision format, the most significant bit of the
>>>> mantissa (the integer bit) is a don't care."
>>>>
>>>> https://www.nxp.com/docs/en/reference-manual/MC68881UM.pdf
>>>>
>>>> The m68k extended format is implemented with the floatx80 and
>>>> floatx80_invalid_encoding currently treats 0x7fff00000000000000000000 as
>>>> an invalid encoding.  This patch fixes floatx80_invalid_encoding so it
>>>> accepts that the most significant bit of the mantissa can be 0.
>>>>
>>>> This bug can be revealed with the following code which pushes extended
>>>> infinity on the stack as a double and then reloads it as a double.  It
>>>> should normally be converted and read back as infinity and is currently
>>>> read back as nan:
>>>
>>> Do you have any real HW on which you could record some .ref files for
>>> the various multiarch float tests we have (float_convs/float_madds)?
>>> Does this different of invalid encoding show up when you add them?
>>
>> On my side, in the past when I started to implement m68k FPU, I used
>> TestFloat and SoftFloat I have ported to m68k and I compare the result
>> in QEMU and in a Quadra 800.
> 
> Surely TestFloat and SoftFloat is all emulation though?
> 
> Anyway if you have a Quadra 800 running Linux could you generate some
> .ref files for the float_convs and float_madds test cases. The binaries
> are static so you should just be able to copy them and run.
> 
>

Here are the files I have generated on Q800.

Thanks,
Laurent


--------------28FFA7FEB0FA5544334CCF97
Content-Type: application/gzip;
 name="float_madds.ref.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="float_madds.ref.gz"

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
--------------28FFA7FEB0FA5544334CCF97
Content-Type: application/gzip;
 name="float_convs.ref.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="float_convs.ref.gz"

H4sICCSLqV4CA2Zsb2F0X2NvbnZzLnJlZgDtmc1u4zYUhffzFAKyySBwcfkjkcpu0HYxaNEC
RVHMVrLEIkBrB/nBBH36UrLcmhYvKXcxUaZHS5HHuB9JixK/q6ur4pf986672/1ePO2LXd88
9I9P79zD/s/i0d/8o78tnJLXm12zu6UXN13v3xVD927/3I49Kn3sQXTs09Phel9c//zDEBgS
d7snJW8LKbTRVqlaFtcff/rtw48fvzvpUenbopZSKUO1qnVNlRJa6qCr7/mc/rGpR/7H/uew
dzs3wtoDQAT20GOEpdMrBruZCqy05WgFx8ZlT+A2BzpJShsyspaioiQdvYhvghmarvsbIc3I
bdhJzmWJtqbPTv8aR0RYo1s5oyI1jIiirWrKmhuRVNaPSFUFHd7KiGypbdrqnKquhwHx+bIr
W25AEtFhPGTQ/lbGQwlnSjqD2mjyUE1bW9c2lhuPRJSo7UzQHhuPsbrvP3349tfibBjOWk7G
Id4yy8RhSyq11ucVV5WvuO4bKxspOdhE1MO2XdC+CliKXPcbIYeSLfG7QC7rca3I7g9fEtfX
FK/4xq/Ff6ucsy4LZkGDe1O5h3shXHDvpF8EKDcFlkfKRdXqZo+rWJa+YKXoctYx6VH7anWo
42tExaCO7yiKQU0kR9SgfR2olkQzW4cjqjVuS9SxqGzSozoK2lezgLezgvWIOv5Zq9QCjicH
VBG0r/a/OjwwX5S7/LF0QxNo/pNDRJ60gkUUkeetWACnE3AyBafTcDoLx8xiEpGZRfEfZ1H4
ejVd/sAdg/MhiH4lR2ZRsogyMosyC1e2jhobh5Ods6Vm4PjgCBc0M3DMLCYRmVnMg/p3fDf/
JDmA6ppc1zKgfHAEDZpjoIoFVSyoYkHVgq2k7SOrbtgQtDGuc+x6TSQH1D5oj6FWZUkqsmin
+wxskDpBnaUY3C0lcHtK4LLJCXdLWVzN4OokrmZw9RJcmcIVKVyZwZVZ3JLBLZO4JYNbLlnM
LlJ0NeI6v5htYjFzyQHXBe3RbUb5sTSxjXRq4LaaIHe608xylyzoI/LlC/oEObOgxwoth2zT
yJZDtkuQRRI5Mcts8ogs8sg1h1ynkWsOuc4iJ07IDH+4lj1b0wvO1v45HjPc0dqGP1sT7JGa
SB2g5c6NDX/mnD9y1guOnF8D+iAJDP+qf7QIZsEr/WsAHJSO4aXP0fmYN+98vl7Uq1Oh+Xz/
uXnoHmEzYTNhM2EzYTNhM2EzYTNhM2EzYTNhM2EzYTNhM2EzYTNhM2EzYTNhM2EzYTNhM2Ez
YTNhM2EzV2Yzu/3nHXwmfCZ8JnwmfCZ8JnwmfCZ8JnwmfCZ8JnwmfCZ8JnwmfCZ8JnwmfCZ8
JnwmfCZ8JnwmfCZ8JnzmGn2mT/3VP+xhM2EzYTNhM2EzYTNhM2EzYTNhM2EzYTNhM2EzYTNh
M2EzYTNhM2EzYTNhM2EzYTNhM2EzYTNhM18f9W9iIyszPXMAAA==
--------------28FFA7FEB0FA5544334CCF97--


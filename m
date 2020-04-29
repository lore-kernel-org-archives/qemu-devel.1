Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4B1C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:44:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9391920775
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:44:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9391920775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTjGj-0000vK-L1
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 05:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35198)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jTjG9-0000E7-35
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:44:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jTjG8-0003Nv-As
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:44:04 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:51293)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jTjG7-0003NY-MP
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:44:04 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Mzhf5-1jGLGV0WHp-00vk4J; Wed, 29 Apr 2020 11:43:46 +0200
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <1588094279-17913-1-git-send-email-frederic.konrad@adacore.com>
 <1588094279-17913-2-git-send-email-frederic.konrad@adacore.com>
 <87d07rlac5.fsf@linaro.org> <9f6c1efc-a195-0f5d-8c34-4dfb45d910f8@vivier.eu>
 <87a72ulk1z.fsf@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH 1/2] softfloat: m68k: infinity is a valid encoding
Message-ID: <b6a2a382-6124-5ece-22b3-2af153fd9ffe@vivier.eu>
Date: Wed, 29 Apr 2020 11:43:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87a72ulk1z.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:obsAXJX2ua2gdTZOdfg62KXJOzTMICCGJTlh+1W2PE/SZxR3y9T
 M2rsvO2JeFcWKIyc7hwNUJWP+L9HWq4TtcJF6/Zwfko/fvC+xeMVpyPty8GZDifRQzFUFyi
 ht9RALujIt7waQCnTYDKYEZaz8Qnlj97ZAitUVX3Ek+Q5ODa6VqOQkBxu6MM/rFBYpMC2+I
 aMg9D+CRePagNV8de1Zjw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DnqyVftIBYE=:7hg/0DLvynztK9zsi3nEAu
 2/jM28jRca9wEa1EREesUKF65wos4+XEv7OaywKTvz/k8SaIHQhJTdRyJ6kz7Sr48epjpOYZD
 ILCDmS5c88LU+uhHq5cO5hIiaEszDMzs5Cv+2ecFe5P2/R4J0YKOOWtu6HZqx6hlF/scjCcfv
 tz7jt7ZOFLdtfYsmj+ZzrX0LF+/jaw2hY7GUz8l3S3G/kbVDdPSpBqXxuj/CLDjRXOXWUrUw0
 PJtW14+VCjA595/tE9xCB8A765I6LLkRhASef1K2Aa/Gn5DMQB2ECz41JcJV3VAWmV1v/kaU2
 TB/ERWxqYUiyMTGDqoFwXcOUlIJQcphxUDhTQZNDJvRks+FLWjR+03tlbPv2XTWQ7Yd33aWUI
 bjslsUoE1J/CRkamLshf/iIHxmM0MSxIa+XCu1UZi41/lRsC6Eu9k1vcrUu1wHQNcR01ZNrUO
 Km8YilkWBvgeGP76bCn3NxPBNbEZz78lpGULXW7X00r4ezSTBgTBsLIT7R33aF0fI3bLN1erl
 0f+xzVH5SlLLYmupkggB3rE7bodx70osa9o6QOIDmykn4b3knauF6Dnw5UVkdHVx+UI9vN8Aq
 9ARucLxLCiICR/9bPmUbTDdueomiuxhLVZK6LKS+5bx+5n8tZwrA1Y3Hra2DKvdwixFuNXcxd
 ImwZf1wi4+3ZBN5wklC75mDXqnzkzCuv5jfcwGSMPR/dpMapzxhILg6YRSj+nHLKAYmb4lgl7
 N9Mwd6NG3oP/ohbOZit4ABqaalYV/AK5LcCYW/mOaB9SYBrnOp9GlhzWZ6OzRdTXcboHzBFB3
 cP93/smijhkxD2T9E6d8winEwRagf56Y7Mx5h+Ie1LHunIT3ww1WBZYyooNXedAr9bbRBzw
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 04:42:38
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>, philmd@redhat.com,
 qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
Is there any HOWTO somewhere? Or should I dig into the code as usual?

Thanks,
Laurent


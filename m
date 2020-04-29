Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B5CC83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:51:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4495520775
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4495520775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTiR4-0007ZB-A1
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 04:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57026)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jTiP5-0006xJ-9L
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:50:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jTiOo-0002fx-6k
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:49:15 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:42149)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jTiOn-0002do-KR
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:48:57 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N7Qp1-1j6TyP0mc9-017m8Y; Wed, 29 Apr 2020 10:48:40 +0200
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>
References: <1588094279-17913-1-git-send-email-frederic.konrad@adacore.com>
 <1588094279-17913-2-git-send-email-frederic.konrad@adacore.com>
 <87d07rlac5.fsf@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH 1/2] softfloat: m68k: infinity is a valid encoding
Message-ID: <9f6c1efc-a195-0f5d-8c34-4dfb45d910f8@vivier.eu>
Date: Wed, 29 Apr 2020 10:48:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87d07rlac5.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:sDVfGgviY7+KIDWpkCw5vFgKsb3A7ixHtOUYZ6kCOqBTF+WIKx0
 VhBiaCH6zJrm+rQfQ+Tc/ZTS3lQASxYZVCudok2XS6NRxyko5kxHhkMSuIhQznSKs98c66u
 GCwtDVQAkUCaA4WVQT3Ya3XlsKfd9FqZKjSuzsFg4NfhTQGWKEHCGq5M2u+Rj1WCLPNcZNG
 jlygotr+KrgAkaIoOulxg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+B12m7Hs4Vs=:2QDEM42TZRlrRCRfJTj1P/
 dojiHtpB+v4WP3akJBkwWb79avuD825NaEkliZurDrH19cw8ECVMXwpJSkH781qIDWcfnYc9F
 DnBWxoUEBneGrgfONtioV8uYIMx4pbWXsvJyFMmBhluBSIIf1OqKuRDXhRq5aHTrjjGhWPkdb
 qO9VnDJ2w6j3+5RrOXnOIdhZco0ARbyIumBon6UEKP7MHsN9iGwDW+8cd68jIo5R6VTvQLUmr
 FQo8mwvyCgxh4M+VJg3Yv4PhGErH5O6mLTmtTITtBWnnbjmvvGo6/7JWGKScGsrHgXyqyxcoT
 Ms/m1i82V6CwC8+RdNc87k1o9sIgCFLA6G7yUg1u7194wvanqSl1qokXXU+XdoEHLFWLFHHtq
 rz53XADnaiing62PYi97nmXHxb4dRlvgL6oF4tnwGAB3Nk9qNL0md1vFlO3jf+Ah/6EW0YKV0
 wDOOpGi4b5KlXTeLhx9pGORGSF+6aX5bpPLA2DreoMhdbRlgRYxdQG1WzN/4a9Vh97yS+x9bf
 urwVMapieRsC1GiUhNylYjOxviWHHuQAsvq2G1/smXj2049bnczoYdnZk8x0xlPJZTcAMF3n5
 WDFJkmqpaNdmWKfmo/cPjeNmhX4WtPfiMWlT2jRPFuv1aO8wbIjrBGp6UlFYb8TIPkOsGSS/3
 sV/4dddqzng0PJCywQnaOBP0DBBnuQtPfvdKDzH4TE74I5zgwhMcMqLyl6hfAWUfKNXecGqsl
 yrAwEiU+MvF4YcI7vd5vUQZIDADZbDRWiCaPwN8lvO8kkb4bjq2YC1L0TU1myYg7WI/Krux9r
 KZX9pgrKWPU4cnLMev+T1xkm6qB6KVMxy6x1Qa+TTt5eqHA8MGhufwsBKM3NS3/qd2Gzdtn
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 04:48:56
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
Cc: Peter Maydell <peter.maydell@linaro.org>, philmd@redhat.com,
 qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 28/04/2020 à 20:43, Alex Bennée a écrit :
> 
> KONRAD Frederic <frederic.konrad@adacore.com> writes:
> 
>> The MC68881 say about infinities (3.2.4):
>>
>> "*For the extended precision format, the most significant bit of the
>> mantissa (the integer bit) is a don't care."
>>
>> https://www.nxp.com/docs/en/reference-manual/MC68881UM.pdf
>>
>> The m68k extended format is implemented with the floatx80 and
>> floatx80_invalid_encoding currently treats 0x7fff00000000000000000000 as
>> an invalid encoding.  This patch fixes floatx80_invalid_encoding so it
>> accepts that the most significant bit of the mantissa can be 0.
>>
>> This bug can be revealed with the following code which pushes extended
>> infinity on the stack as a double and then reloads it as a double.  It
>> should normally be converted and read back as infinity and is currently
>> read back as nan:
> 
> Do you have any real HW on which you could record some .ref files for
> the various multiarch float tests we have (float_convs/float_madds)?
> Does this different of invalid encoding show up when you add them?

On my side, in the past when I started to implement m68k FPU, I used
TestFloat and SoftFloat I have ported to m68k and I compare the result
in QEMU and in a Quadra 800.

https://github.com/vivier/m68k-testfloat
https://github.com/vivier/m68k-softfloat

I also used the gcc and libc testsuite to detect problems but this was a
very slow process...

I have also ported RISU to m68k, but I didn't add FPU test in it (does
it support FPU test?).

Thanks,
Laurent


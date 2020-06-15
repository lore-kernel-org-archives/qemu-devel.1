Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5825C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:47:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ED6B2067B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:47:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ED6B2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jksH6-0006av-PL
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 12:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jksFq-0005n0-Iv
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 12:46:42 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:42695)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jksFn-0002pJ-Tb
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 12:46:38 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M593i-1jjlmv0wwG-0019I6; Mon, 15 Jun 2020 18:46:17 +0200
To: Fred Konrad <konrad@adacore.com>, qemu-devel@nongnu.org
References: <1588094279-17913-1-git-send-email-frederic.konrad@adacore.com>
 <1588094279-17913-2-git-send-email-frederic.konrad@adacore.com>
 <1f4d93eb-0b89-5189-0147-3a456197cc0d@vivier.eu>
 <0cfb0348-d6db-db68-3181-85a605bfa91b@adacore.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH 1/2] softfloat: m68k: infinity is a valid encoding
Message-ID: <6224f733-3655-ff14-4fc2-8435f0f531cf@vivier.eu>
Date: Mon, 15 Jun 2020 18:46:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <0cfb0348-d6db-db68-3181-85a605bfa91b@adacore.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:OIVBYbMFctURwBHakP4YWy3jluYXvO2MmjJeTTPEzOI9+4YKvGN
 tVDt2odOIQhR1E9pWJe9hx2COOjJCf2OqPsNkRxdk65GsO4Nk0kO96wyetaSHHgVMiCGQV7
 eJHxXutGBDetot6mHqxrFu5ziKAjah6jvybaHF/pGoVwzrxv+bXLgsh2Vys6SckteEDSpEm
 AGHkru6P7RQC5qbqi35Tg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zu7HxR9H2Tw=:IMMz2O4F9uqIU6r+XaYXLh
 GQap9A4wy3diPHBNIyp//G/Qh5epGoZrrYu1TCKGSBD0XF2ANcTvApqSH/2mfhhH8xjreBA7M
 S4r2144sWRc80LbggW8N4Crmyrzu5LJjhZLyfqgBywyVpDDEcPJvXgcPTTIFPHYmIVVonTgZy
 3wTeZG4sD4OqYkCyMnsgIBys6NwRIusJ5a550JVY2ueayaRxmU6WPP04BZkVWegUKOGFSU60n
 jDAs7xVnR9uZKxgc9OCgILoATg9QYoTrXY8uhvn93P4bhSY5n4DmC0mIi5yCPSweztMWWHIKB
 GJX1kZLuyekeUYOup5zgzLa/Bq8c3Iaj7KHr2E0yMfmvC/9wm73sRG9yOWGwDjMNsWVH/W0Wi
 7F3FswRM6hv+uX/Y6QNLzaOISMeCKKK5rbUyxcUO0RxuDVCPvliQjkPYAJPvnWLDvscpnhb7n
 X7MnBl+GPhBnZuat3Q3Tszu51lwgruJOwcxn2bQ9BC+f9QJv2y2zQldXd4CPqtAFUFzPM/USC
 tHfqxQMUz6LFocn/MXxcO9CCUaEIPJnUkrF+c+K2YRymEh5Sf5oh101VVl2BGJT8WeidOO/4y
 BLyLDmKvIj0oQTOJmvlghPLU1hn5QdEMs16fRMzM/NzXVzf8n0pyOU8HZ9Yz+h6w/btOE5Tvs
 IsnQ8gew/AUbH+9DcEok4ZGwZur+kX/YPJ2yqyS3szYDfGRBoRbTNyW+Aa+2cLD58sqSogvJp
 gKt2uwB2cVp/qQun390gbYPL67qek01r95ZrA8otCYDXy6jlmXkLyLiosDMt6bwQ5eqyyQ8Mz
 W8yVBzVMi4RJdwpPSe94ZAPJKk1BJPoJStNVb4jpp99ZlyZYzwdfVGHqeN/rLc9MglpADnL
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 12:46:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 Aurelien Jarno <aurelien@aurel32.net>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 15/06/2020 à 17:59, Fred Konrad a écrit :
> Missed this one sorry.
> 
> Le 6/12/20 à 10:31 AM, Laurent Vivier a écrit :
>> Le 28/04/2020 à 19:17, KONRAD Frederic a écrit :
>>> The MC68881 say about infinities (3.2.4):
>>>
>>> "*For the extended precision format, the most significant bit of the
>>> mantissa (the integer bit) is a don't care."
>>>
>>> https://www.nxp.com/docs/en/reference-manual/MC68881UM.pdf
>>>
>>> The m68k extended format is implemented with the floatx80 and
>>> floatx80_invalid_encoding currently treats 0x7fff00000000000000000000 as
>>> an invalid encoding.  This patch fixes floatx80_invalid_encoding so it
>>> accepts that the most significant bit of the mantissa can be 0.
>>>
>>> This bug can be revealed with the following code which pushes extended
>>> infinity on the stack as a double and then reloads it as a double.  It
>>> should normally be converted and read back as infinity and is currently
>>> read back as nan:
>>>
>>>          .global _start
>>>          .text
>>> _start:
>>>          lea val, %a0
>>>          lea fp, %fp
>>>          fmovex (%a0), %fp0
>>>          fmoved %fp0, %fp@(-8)
>>>          fmoved %fp@(-8), %fp0
>>> end:
>>>          bra end
>>>
>>> .align 0x4
>>> val:
>>>          .fill 1, 4, 0x7fff0000
>>>          .fill 1, 4, 0x00000000
>>>          .fill 1, 4, 0x00000000
>>> .align 0x4
>>>          .fill 0x100, 1, 0
>>> fp:
>>>
> 
> [...]
> 
>>
>> According to "M68000 FAMILY PROGRAMMER’S REFERENCE MANUAL" the explicit
>> integer bit is "Don't care" for signed infinite (a.high == 0x7FFF) (this
>> is the case this patch manages).
>>
>> But wit a zero exponent and a non zero mantissa, it's a denormal number,
>> and a signed zero has also a zero explicit integer bit but a zero
>> mantissa. (both cases are already managed in the existing code).
>>
>> with a non zero exponent less than the maximum value it's an unnormal
>> number.
>>
>> The denormal and unnormal numbers must be managed during the load
>> operation in the m68k TCG emulation to generate directly the FP_UNIMP
>> exception.
> 
> Is this already handled in the TCG code?

No, I have a skeleton with a workaround but if we enable the exception
the kernel crashes because the size of the frame saved in the stack by
fsave is not the one expected by the kernel (we save an IDLE frame and
not the UNIMP frame).

https://github.com/vivier/qemu-m68k/commit/c1297f61db283ccd592333f56907bd2961f1843c

I've also sent a patch similar to yours but disabling totally the
floatx80_invalid_encoding() check.

https://patchew.org/QEMU/20200612140400.2130118-1-laurent@vivier.eu/

Thanks,
Laurent



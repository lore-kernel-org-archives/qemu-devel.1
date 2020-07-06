Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330FDC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 19:45:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0402A20675
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 19:45:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0402A20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsX3p-0007qF-A2
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 15:45:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jsX2m-000692-2e
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 15:44:48 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:36931)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jsX2k-0000vh-9m
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 15:44:47 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Ml72g-1kdv4Z46BA-00lY8W; Mon, 06 Jul 2020 21:44:44 +0200
Subject: Re: [PATCH] softfloat,m68k: disable floatx80_invalid_encoding() for
 m68k
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200612140400.2130118-1-laurent@vivier.eu>
 <87o8ospol2.fsf@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e2ee6216-8cc4-9a0e-3cca-5cbb26242fd8@vivier.eu>
Date: Mon, 6 Jul 2020 21:44:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87o8ospol2.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NRpMs6nMQ5CbZRZW7jwCuQcuiFHtipO6Dk2u5CkU6leNWVjAH7q
 /wzXtdt8oMIC6fT+l236LaYWkmkPUZ66xCpwWin5Yg7Y55elaai2MZTTLxd+dUWW8f49tMf
 OrO0rhaWzN6gOx4EWViRRy7O+Cj4zFBGEo05Aj8CtmdWTBhKoPAzspmwTfKEGD2Sg+zvXoU
 7tIcnMyNs4Z9h8+xIshwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Qg9pXgLwq1k=:ogovYneuMflqFgTZd/GvK+
 TbEnB9H4JetPL9YbTjy7oY4702/Lv6zz5DpXEVzirOKLplI/e3W/6rINUS87JHQ2KEIvwtu+Z
 S/WdLV3N7vAYbiur0OkAh65GOEQCinsP5A/4X/jD+wZku9sQOyJRPPxq5CdO+KI/OKGCwBF70
 XN6qonqwxN0ZLGiN4r4aaT8nr73xU60YmwHe7D0eSLk2/07cSh558sYqwHVpvL/gbUxcGliWq
 aHF5D80XxmiwUiArFP7HpbPN32+v11XSTGKGhrdHD4UGBXv5nIm4xphhj28IQg0fUnTah7ZI+
 Uxfh7lDVi1h2fA22tzgHBoPomj5dsZMxmjfASENMyAVm5bt5EG9klJSXSO52pnpW5tRp4zada
 3DFEZuSteSeiK9cLe4B5DkTH0S6E/zaMrNLRGjxVtKp0r50RTTl+ZTGml7K80ymOwQ2cpHXnz
 r/wNCWKHorYpCQ2vrPqV8jJ44dTishrkrsT5F704621IRx49mLoueNP+I/sDa05JXUgMXHqOY
 bU7+Lxngd23lz4D4FHguoSavcn++nGGfcWKXp5hCqWxLeFdRt68ZnOkD3Cbg9Eb8JUMmI3I7a
 EZjX9I4/NP628QDbKKlOfxwk8Ea6twgIc+hM4xsjQT0mhbi/2wGdi2nI0ikEcGTFUOjz6U7Hg
 gb/QS3b5oiRmWd7uI5gVoWaePylf4HW9hQ07MExbks7mY3Znq2MsBmvWQZ2FI4IlFZx2L+BSu
 5BrXoHBdti8C5x94PKkoc6KKLFaFhTuTGuTm0Tm9x0xkJdjqF7DNhdtMRuUQvLMW82+sWAyU5
 7WzLrTMUpCfGmYKlVeCrJgSues35l9cghxP7e31DjhDLMQrbAwIO3hzXITOSLoDXV2/Tofb
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 15:44:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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

Le 06/07/2020 à 18:58, Alex Bennée a écrit :
> Laurent Vivier <laurent@vivier.eu> writes:
> 
>> According to the comment, this definition of invalid encoding is given
>> by intel developer's manual, and doesn't comply with 680x0 FPU.
>>
>> With m68k, the explicit integer bit can be zero in the case of:
>>  - zeros                (exp == 0, mantissa == 0)
>>  - denormalized numbers (exp == 0, mantissa != 0)
>>  - unnormalized numbers (exp != 0, exp < 0x7FFF)
>>  - infinities           (exp == 0x7FFF, mantissa == 0)
>>  - not-a-numbers        (exp == 0x7FFF, mantissa != 0)
>>
>> For infinities and NaNs, the explicit integer bit can be either one or
>> zero.
>>
>> The IEEE 754 standard does not define a zero integer bit. Such a number
>> is an unnormalized number. Hardware does not directly support
>> denormalized and unnormalized numbers, but implicitly supports them by
>> trapping them as unimplemented data types, allowing efficient conversion
>> in software.
>>
>> See "M68000 FAMILY PROGRAMMER’S REFERENCE MANUAL",
>>     "1.6 FLOATING-POINT DATA TYPES"
>>
>> We will implement in the m68k TCG emulator the FP_UNIMP exception to
>> trap into the kernel to normalize the number. In case of linux-user,
>> the number will be normalized by QEMU.
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> 
> Apologies for the private reply, was using my fallback tooling while
> email was down and that doesn't automatically include the group address.
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> 
> By all means take it via the m68k tree. 

Thank you.

Applied to my m68k branch.

Laurent



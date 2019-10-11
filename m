Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BBBECE596
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 18:19:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E31C622475
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 18:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="werZnh12"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E31C622475
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIzVV-0006uu-N5
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 14:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38521)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iIxVe-0004za-CO
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 12:11:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iIxVc-00006l-Vx
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 12:11:18 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52337)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iIxVc-000056-PD
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 12:11:16 -0400
Received: by mail-wm1-x344.google.com with SMTP id r19so11002594wmh.2
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 09:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ykBkr4wLZ8by053B9fC+i1LD9/Y+OEvWheBFJa3ExSU=;
 b=werZnh12LH66CpzYAMyPSa9uY1THzE28Q+AohnVQl2mKHYDvrq6+z+aOkcX/wY84hT
 wO7SMqFw+BYZuwoypZdPxsRYS0ALgvYPUQJkdW4/uuVftyjXbp9sr4zGbo1PwFc4/1ch
 weU68oKuV3EaopC552HmYFA2sp89UCdpUKqmOtD2udMMhDcGHyvfZB8jUcnsH/yVshib
 UJMjbFa522b0kwj5XJegEsiq9PGULqlmv11+0oOQYjgTSaSB7pZBjVNXZpvYe1GGFwX/
 Y95/hOgPnyRJdSu45hinv4T2MsV5+r4NtwnVcfSB5sD2jh2Bw71TIVQn/0oYS6jUUvH4
 70Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ykBkr4wLZ8by053B9fC+i1LD9/Y+OEvWheBFJa3ExSU=;
 b=rGsFKg9Gkoyiid5T1OIhva1qhbo6GRQeedCsYBOozNW2lmB2Rybkd0dw7SD9hUY1Zu
 zdDxuYj5TfuPvdq383opQUdNUtv5Cx2P+I8ClxKMFiyPXYu0njXG9QVmygj2EXtbnR3a
 7VP0VV6jsTVATccAfgC7zkY3mU6dUapQillZzXlg90KepsKS3RO7qf94LynlAxYZeUgP
 Q5vVfK5xjmv5Rly7D4gJExH/NlsOhvX83Rt2fsQhLicA90vINGidWqwmtXVyvMXEjX5A
 9/7N8TWX2e8xhq8ylVb6sMZ5z1Y3naEUr+xmrtIAzYI+6pP7qEFCTZDrWx8NLrRYJcbC
 AKxw==
X-Gm-Message-State: APjAAAXyMUn69W5k+epwEdA+p4ae3iUKCEPOE/EVQgp6TV1SOBhUc7Dv
 l6GK63pwFbQqJilPElrCL3d8/A==
X-Google-Smtp-Source: APXvYqybB0bgSI5hOKdkgFKMxzD3Wtfr+oDIualjHyK0hl9VXBlPe32ewWNAy/rXAtRj4E7qDSUo5g==
X-Received: by 2002:a7b:ca4b:: with SMTP id m11mr3704111wml.129.1570810274888; 
 Fri, 11 Oct 2019 09:11:14 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d15sm10644880wru.50.2019.10.11.09.11.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 09:11:14 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 623531FF87;
 Fri, 11 Oct 2019 17:11:13 +0100 (BST)
References: <20190902140134.74081-1-mrolnik@gmail.com>
 <949009b8-58ec-4a9e-cfd7-7d4611fad380@redhat.com>
 <CAL1e-=h1PV6djRgWXikjnU79Ca7Pjfw9=0u9__Nz00FJ4R49Hg@mail.gmail.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [Qemu-devel] [PATCH v30 0/8] QEMU AVR 8 bit cores
In-reply-to: <CAL1e-=h1PV6djRgWXikjnU79Ca7Pjfw9=0u9__Nz00FJ4R49Hg@mail.gmail.com>
Date: Fri, 11 Oct 2019 17:11:13 +0100
Message-ID: <87y2xrl0ta.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Aleksandar Markovic <aleksandar.m.mail@gmail.com> writes:

> On Friday, October 11, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om>
> wrote:
>
>> Hi Michael,
>>
>> On 9/2/19 4:01 PM, Michael Rolnik wrote:
>>
>>> This series of patches adds 8bit AVR cores to QEMU.
>>> All instruction, except BREAK/DES/SPM/SPMX, are implemented. Not fully
>>> tested yet.
>>> However I was able to execute simple code with functions. e.g fibonacci
>>> calculation.
>>> This series of patches include a non real, sample board.
>>> No fuses support yet. PC is set to 0 at reset.
>>>
>>> the patches include the following
>>> 1. just a basic 8bit AVR CPU, without instruction decoding or translati=
on
>>> 2. CPU features which allow define the following 8bit AVR cores
>>>       avr1
>>>       avr2 avr25
>>>       avr3 avr31 avr35
>>>       avr4
>>>       avr5 avr51
>>>       avr6
>>>       xmega2 xmega4 xmega5 xmega6 xmega7
>>> 3. a definition of sample machine with SRAM, FLASH and CPU which allows
>>> to execute simple code
>>> 4. encoding for all AVR instructions
>>> 5. interrupt handling
>>> 6. helpers for IN, OUT, SLEEP, WBR & unsupported instructions
>>> 7. a decoder which given an opcode decides what istruction it is
>>> 8. translation of AVR instruction into TCG
>>> 9. all features together
>>>
>>> [..]
>>
>>> Michael Rolnik (7):
>>>    target/avr: Add outward facing interfaces and core CPU logic
>>>    target/avr: Add instruction helpers
>>>    target/avr: Add instruction decoding
>>>    target/avr: Add instruction translation
>>>    target/avr: Add example board configuration
>>>    target/avr: Register AVR support with the rest of QEMU, the build
>>>      system, and the MAINTAINERS file
>>>    target/avr: Add tests
>>>
>>> Sarah Harris (1):
>>>    target/avr: Add limited support for USART and 16 bit timer periphera=
ls
>>>
>>
>> Overall architecture patches look good, but I'd like some more time to
>> review the hardware patches. Unfortunately I won't have time until Novem=
ber.
>> There was a chat on IRC about your series,
>>
> I don't see the reason why do you initiate IRC communication on this topi=
c,
> if we have the mailing list for discussing such important issues as
> introducing a new target (that should be definitely visible to all
> participants).

IRC is often a good way of quickly discussing something when someone is
about (often as a tangent from another discussion). I don't think there
is anything wrong with that as long as it's followed up on the mailing
list.

>
>> I suggested Richard we could merge patches 1-4 and 7. They are almost
>> sufficient to run the qemu-avr-tests gdbstub tests (but not the FreeRTOS
>> ones).

Which is was ;-)

--
Alex Benn=C3=A9e


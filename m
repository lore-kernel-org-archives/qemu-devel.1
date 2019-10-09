Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373BAC47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:08:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE4B721848
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qYwKHRnZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE4B721848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIGNZ-00031e-GU
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 14:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55149)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iI8uk-0008TS-U6
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 06:09:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iI8uh-0004nD-M8
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 06:09:50 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:39195)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iI8uh-0004n3-DI
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 06:09:47 -0400
Received: by mail-ot1-x330.google.com with SMTP id s22so1207995otr.6
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 03:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=R83R8yhJciWnWovJSyrosPAyeV4SIdlVvQKP3NXnhBI=;
 b=qYwKHRnZugD6D4qVpdaSuZ3l7T+j5mstb+waqJ1O5LpjTozIq4e9BiktaPb/LIcKOe
 hUElxEJYaCnLKEvdPuUE04ioUISfE2BRLQjW42QDCpLasm+beoLZmRo5Ub/k1evKtDDD
 Iy+fA7xfYaA6pjlKCBGhDOv20alG8W/lLKenX3uJOJ9ewKEqbIVzZeuKv0yIEXwHQb/t
 8+9Pr4fYsx2vG4A66QP7i+Dt2OOblR4l+rH1h+dZ4WXN1N08jo0Xs/4WOFa3BWoHg0vo
 EXoS+IL0Wpuu/6kjmEQ1coXM+gtNL2x7yPIfnfQNdya7qsidTrl0wsIt9pdeLg0yy3VS
 JppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=R83R8yhJciWnWovJSyrosPAyeV4SIdlVvQKP3NXnhBI=;
 b=bGkiceP6nNWLpdAcCO7x6f3TP/FNa8ISpBs2NrMSQ5QUNTAF1415ghryGSbuFyR//4
 4apRdDE67jOlozO8+qYnb/rYSohtAraikdN5PdDpJQ55qUeVgoiIv5g6ouvSTHM0hBwf
 mvDjbX+GJRcGbyA1cIQCBy7wwTX11x+HOvvQ9qmDtv8lDkvQlwiZsOIpSYYkr8vbpZrh
 YC0qODRXYybBjIEzqcwlx/GAdgXb9Vsn3JQoZakNjvxvOjVZnirB/SjNTHLsdVmBPNBE
 njETOSEubWvcE9Wfbh7pIOj35NoH8SWyJzmQqUUCExE0QRJnu/XsPZWPdpNHTsjMj42Y
 svFA==
X-Gm-Message-State: APjAAAXxp1Ik3PzH92QjW8QTEq26RnOX/L6SZkytmZgvy3D1i2NDQ2Hw
 5Kvz3FlH3u/xV7rfCvGub+QWjuF7POH75Gz5Qoo=
X-Google-Smtp-Source: APXvYqy2Wl4JPaV4XhbThBZlk1McWJofJRLE0+WBWoiZUML5nmwkzv12r574p6wiyzp7bgOPRuvCNhxde3v+i34e85w=
X-Received: by 2002:a9d:684c:: with SMTP id c12mr2164303oto.341.1570615786283; 
 Wed, 09 Oct 2019 03:09:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP;
 Wed, 9 Oct 2019 03:09:45 -0700 (PDT)
In-Reply-To: <b36ea61cf3566e8f154ec1f9e90867d8@ispras.ru>
References: <caedac8d3f9f15f3245011b7d6b3f7bf@ispras.ru>
 <87a7ack180.fsf@linaro.org>
 <CAL1e-=gBEAiTMBHz_zXzJXPSzkaM9R1NtNaaPFrUg+JA4_nwCg@mail.gmail.com>
 <b36ea61cf3566e8f154ec1f9e90867d8@ispras.ru>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 9 Oct 2019 12:09:45 +0200
Message-ID: <CAL1e-=jjidHjc0OBcuxeHb4uq5wxFuBBr+h=T4nxVE8MkkLCGw@mail.gmail.com>
Subject: Re: [PATCH] target/mips: add gdb xml files
To: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Content-Type: multipart/alternative; boundary="000000000000052a690594777ca2"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::330
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
Cc: "arikalo@wavecomp.com" <arikalo@wavecomp.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Qemu Devel <qemu-devel@nongnu.org>,
 "amarkovic@wavecomp.com" <amarkovic@wavecomp.com>,
 "philmd@redhat.com" <philmd@redhat.com>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000052a690594777ca2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday, October 9, 2019, Mikhail Abakumov <mikhail.abakumov@ispras.ru=
>
wrote:

> Aleksandar Markovic =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2019-10-08 16:37:
>
>> On Monday, October 7, 2019, Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> wrote:
>>
>> Mikhail Abakumov <mikhail.abakumov@ispras.ru> writes:
>>>
>>> From: Mikhail Abakumov <mikhail.abakumov@ispras>
>>>>
>>>
>>> Hmm the email got truncated here.
>>>
>>>
>>>> This patch add xml files with gdb registers for mips.
>>>>
>>>> Signed-off-by: Mikhail Abakumov <mikhail.abakumov@ispras>
>>>> ---
>>>> configure | 3 ++
>>>> gdb-xml/mips-core.xml | 84
>>>>
>>> +++++++++++++++++++++++++++++++++++++++++
>>>
>>>> gdb-xml/mips64-core.xml | 84
>>>> +++++++++++++++++++++++++++++++++++++++++
>>>>
>>>
>>> Otherwise for the configure/xml:
>>>
>>> Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>
>>> I assume the changes will go in via a MIPS tree.
>>>
>>
>> Yes, this should go via mips tree. Thanks for taking a look.
>>
>> Mikhail, thanks for this effort.
>>
>> Is there any way to include MSA registers, possibly in a separate
>> file, and in a separate patch? What about a separate file for FPU
>> registers? Can you take a look at corresponding solutions for other
>> architectures?
>>
>
> Thanks for the feedback.
>
> Yes, I did it initially. But looking at other architectures, redid it.
> Everywhere, one main xml-file is used for registers, described
> in the target/gdbstub. And additional ones are appended through
> 'gdb_register_coprocessor'.
> In the current patch, I made a description of the registers described
> only in the target/gdbstub. In the future, I think FPU registers
> can be moved to a separate file, but then need to move them from
> the mips/gdbstub.



Mikhail,

Your implementation assumes that 64-bit CPU always has 64-bit FPU, and
32-bit CPU - 32-bit FPU. However, that is not always true.

Please see related patch for RISC-V:

https://patchew.org/QEMU/20190821162831.27811-1-georg.kotheimer@kernkonzept=
.com/

... and correct your solution in a similar way.

Keep also in mind that, in general, gdb xml support should work for all (or
at least, almost all) QEMU-supported MIPS CPUs, not just the most common.
For example, is your solution correct for R4000 CPU? Is the register layout
the same for, for example, "ancient" R4000 and "moderm" I6400?

Thanks again!

Aleksandar




>
>> Yours,
>> Aleksandar
>>
>> target/mips/cpu.c | 11 ++++++
>>>> 4 files changed, 182 insertions(+)
>>>> create mode 100644 gdb-xml/mips-core.xml
>>>> create mode 100644 gdb-xml/mips64-core.xml
>>>>
>>>> diff --git a/configure b/configure
>>>> index 8f8446f52b..5bb2c62194 100755
>>>> --- a/configure
>>>> +++ b/configure
>>>> @@ -7466,12 +7466,14 @@ case "$target_name" in
>>>> mips|mipsel)
>>>> mttcg=3D"yes"
>>>> TARGET_ARCH=3Dmips
>>>> + gdb_xml_files=3D"mips-core.xml"
>>>> echo "TARGET_ABI_MIPSO32=3Dy" >> $config_target_mak
>>>> ;;
>>>> mipsn32|mipsn32el)
>>>> mttcg=3D"yes"
>>>> TARGET_ARCH=3Dmips64
>>>> TARGET_BASE_ARCH=3Dmips
>>>> + gdb_xml_files=3D"mips64-core.xml"
>>>> echo "TARGET_ABI_MIPSN32=3Dy" >> $config_target_mak
>>>> echo "TARGET_ABI32=3Dy" >> $config_target_mak
>>>> ;;
>>>> @@ -7479,6 +7481,7 @@ case "$target_name" in
>>>> mttcg=3D"yes"
>>>> TARGET_ARCH=3Dmips64
>>>> TARGET_BASE_ARCH=3Dmips
>>>> + gdb_xml_files=3D"mips64-core.xml"
>>>> echo "TARGET_ABI_MIPSN64=3Dy" >> $config_target_mak
>>>> ;;
>>>> moxie)
>>>> diff --git a/gdb-xml/mips-core.xml b/gdb-xml/mips-core.xml
>>>> new file mode 100644
>>>> index 0000000000..a46b2993eb
>>>> --- /dev/null
>>>> +++ b/gdb-xml/mips-core.xml
>>>> @@ -0,0 +1,84 @@
>>>> +<?xml version=3D"1.0"?>
>>>> +<!-- Copyright (C) 2010-2019 Free Software Foundation, Inc.
>>>> +
>>>> + Copying and distribution of this file, with or without
>>>> modification,
>>>> + are permitted in any medium without royalty provided the
>>>>
>>> copyright
>>>
>>>> + notice and this notice are preserved. -->
>>>> +
>>>> +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
>>>> +<feature name=3D"org.gnu.gdb.mips">
>>>> + <reg name=3D"zero" bitsize=3D"32"/>
>>>> + <reg name=3D"at" bitsize=3D"32"/>
>>>> + <reg name=3D"v0" bitsize=3D"32"/>
>>>> + <reg name=3D"v1" bitsize=3D"32"/>
>>>> + <reg name=3D"a0" bitsize=3D"32"/>
>>>> + <reg name=3D"a1" bitsize=3D"32"/>
>>>> + <reg name=3D"a2" bitsize=3D"32"/>
>>>> + <reg name=3D"a3" bitsize=3D"32"/>
>>>> + <reg name=3D"t0" bitsize=3D"32"/>
>>>> + <reg name=3D"t1" bitsize=3D"32"/>
>>>> + <reg name=3D"t2" bitsize=3D"32"/>
>>>> + <reg name=3D"t3" bitsize=3D"32"/>
>>>> + <reg name=3D"t4" bitsize=3D"32"/>
>>>> + <reg name=3D"t5" bitsize=3D"32"/>
>>>> + <reg name=3D"t6" bitsize=3D"32"/>
>>>> + <reg name=3D"t7" bitsize=3D"32"/>
>>>> + <reg name=3D"s0" bitsize=3D"32"/>
>>>> + <reg name=3D"s1" bitsize=3D"32"/>
>>>> + <reg name=3D"s2" bitsize=3D"32"/>
>>>> + <reg name=3D"s3" bitsize=3D"32"/>
>>>> + <reg name=3D"s4" bitsize=3D"32"/>
>>>> + <reg name=3D"s5" bitsize=3D"32"/>
>>>> + <reg name=3D"s6" bitsize=3D"32"/>
>>>> + <reg name=3D"s7" bitsize=3D"32"/>
>>>> + <reg name=3D"t8" bitsize=3D"32"/>
>>>> + <reg name=3D"t9" bitsize=3D"32"/>
>>>> + <reg name=3D"k0" bitsize=3D"32"/>
>>>> + <reg name=3D"k1" bitsize=3D"32"/>
>>>> + <reg name=3D"gp" bitsize=3D"32"/>
>>>> + <reg name=3D"sp" bitsize=3D"32"/>
>>>> + <reg name=3D"s8" bitsize=3D"32"/>
>>>> + <reg name=3D"ra" bitsize=3D"32"/>
>>>> + <reg name=3D"sr" bitsize=3D"32"/>
>>>> + <reg name=3D"lo" bitsize=3D"32"/>
>>>> + <reg name=3D"hi" bitsize=3D"32"/>
>>>> + <reg name=3D"bad" bitsize=3D"32"/>
>>>> + <reg name=3D"cause" bitsize=3D"32"/>
>>>> + <reg name=3D"pc" bitsize=3D"32"/>
>>>> +
>>>> + <reg name=3D"f0" bitsize=3D"32" regnum=3D"38"/>
>>>> + <reg name=3D"f1" bitsize=3D"32"/>
>>>> + <reg name=3D"f2" bitsize=3D"32"/>
>>>> + <reg name=3D"f3" bitsize=3D"32"/>
>>>> + <reg name=3D"f4" bitsize=3D"32"/>
>>>> + <reg name=3D"f5" bitsize=3D"32"/>
>>>> + <reg name=3D"f6" bitsize=3D"32"/>
>>>> + <reg name=3D"f7" bitsize=3D"32"/>
>>>> + <reg name=3D"f8" bitsize=3D"32"/>
>>>> + <reg name=3D"f9" bitsize=3D"32"/>
>>>> + <reg name=3D"f10" bitsize=3D"32"/>
>>>> + <reg name=3D"f11" bitsize=3D"32"/>
>>>> + <reg name=3D"f12" bitsize=3D"32"/>
>>>> + <reg name=3D"f13" bitsize=3D"32"/>
>>>> + <reg name=3D"f14" bitsize=3D"32"/>
>>>> + <reg name=3D"f15" bitsize=3D"32"/>
>>>> + <reg name=3D"f16" bitsize=3D"32"/>
>>>> + <reg name=3D"f17" bitsize=3D"32"/>
>>>> + <reg name=3D"f18" bitsize=3D"32"/>
>>>> + <reg name=3D"f19" bitsize=3D"32"/>
>>>> + <reg name=3D"f20" bitsize=3D"32"/>
>>>> + <reg name=3D"f21" bitsize=3D"32"/>
>>>> + <reg name=3D"f22" bitsize=3D"32"/>
>>>> + <reg name=3D"f23" bitsize=3D"32"/>
>>>> + <reg name=3D"f24" bitsize=3D"32"/>
>>>> + <reg name=3D"f25" bitsize=3D"32"/>
>>>> + <reg name=3D"f26" bitsize=3D"32"/>
>>>> + <reg name=3D"f27" bitsize=3D"32"/>
>>>> + <reg name=3D"f28" bitsize=3D"32"/>
>>>> + <reg name=3D"f29" bitsize=3D"32"/>
>>>> + <reg name=3D"f30" bitsize=3D"32"/>
>>>> + <reg name=3D"f31" bitsize=3D"32"/>
>>>> + <reg name=3D"fsr" bitsize=3D"32" group=3D"float"/>
>>>> + <reg name=3D"fir" bitsize=3D"32" group=3D"float"/>
>>>> + <reg name=3D"fp" bitsize=3D"32" group=3D"float"/>
>>>> +</feature>
>>>> diff --git a/gdb-xml/mips64-core.xml b/gdb-xml/mips64-core.xml
>>>> new file mode 100644
>>>> index 0000000000..cc1a15ad56
>>>> --- /dev/null
>>>> +++ b/gdb-xml/mips64-core.xml
>>>> @@ -0,0 +1,84 @@
>>>> +<?xml version=3D"1.0"?>
>>>> +<!-- Copyright (C) 2010-2019 Free Software Foundation, Inc.
>>>> +
>>>> + Copying and distribution of this file, with or without
>>>> modification,
>>>> + are permitted in any medium without royalty provided the
>>>>
>>> copyright
>>>
>>>> + notice and this notice are preserved. -->
>>>> +
>>>> +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
>>>> +<feature name=3D"org.gnu.gdb.mips64">
>>>> + <reg name=3D"zero" bitsize=3D"64"/>
>>>> + <reg name=3D"at" bitsize=3D"64"/>
>>>> + <reg name=3D"v0" bitsize=3D"64"/>
>>>> + <reg name=3D"v1" bitsize=3D"64"/>
>>>> + <reg name=3D"a0" bitsize=3D"64"/>
>>>> + <reg name=3D"a1" bitsize=3D"64"/>
>>>> + <reg name=3D"a2" bitsize=3D"64"/>
>>>> + <reg name=3D"a3" bitsize=3D"64"/>
>>>> + <reg name=3D"t0" bitsize=3D"64"/>
>>>> + <reg name=3D"t1" bitsize=3D"64"/>
>>>> + <reg name=3D"t2" bitsize=3D"64"/>
>>>> + <reg name=3D"t3" bitsize=3D"64"/>
>>>> + <reg name=3D"t4" bitsize=3D"64"/>
>>>> + <reg name=3D"t5" bitsize=3D"64"/>
>>>> + <reg name=3D"t6" bitsize=3D"64"/>
>>>> + <reg name=3D"t7" bitsize=3D"64"/>
>>>> + <reg name=3D"s0" bitsize=3D"64"/>
>>>> + <reg name=3D"s1" bitsize=3D"64"/>
>>>> + <reg name=3D"s2" bitsize=3D"64"/>
>>>> + <reg name=3D"s3" bitsize=3D"64"/>
>>>> + <reg name=3D"s4" bitsize=3D"64"/>
>>>> + <reg name=3D"s5" bitsize=3D"64"/>
>>>> + <reg name=3D"s6" bitsize=3D"64"/>
>>>> + <reg name=3D"s7" bitsize=3D"64"/>
>>>> + <reg name=3D"t8" bitsize=3D"64"/>
>>>> + <reg name=3D"t9" bitsize=3D"64"/>
>>>> + <reg name=3D"k0" bitsize=3D"64"/>
>>>> + <reg name=3D"k1" bitsize=3D"64"/>
>>>> + <reg name=3D"gp" bitsize=3D"64"/>
>>>> + <reg name=3D"sp" bitsize=3D"64"/>
>>>> + <reg name=3D"s8" bitsize=3D"64"/>
>>>> + <reg name=3D"ra" bitsize=3D"64"/>
>>>> + <reg name=3D"sr" bitsize=3D"64"/>
>>>> + <reg name=3D"lo" bitsize=3D"64"/>
>>>> + <reg name=3D"hi" bitsize=3D"64"/>
>>>> + <reg name=3D"bad" bitsize=3D"64"/>
>>>> + <reg name=3D"cause" bitsize=3D"64"/>
>>>> + <reg name=3D"pc" bitsize=3D"64"/>
>>>> +
>>>> + <reg name=3D"f0" bitsize=3D"64" regnum=3D"38"/>
>>>> + <reg name=3D"f1" bitsize=3D"64"/>
>>>> + <reg name=3D"f2" bitsize=3D"64"/>
>>>> + <reg name=3D"f3" bitsize=3D"64"/>
>>>> + <reg name=3D"f4" bitsize=3D"64"/>
>>>> + <reg name=3D"f5" bitsize=3D"64"/>
>>>> + <reg name=3D"f6" bitsize=3D"64"/>
>>>> + <reg name=3D"f7" bitsize=3D"64"/>
>>>> + <reg name=3D"f8" bitsize=3D"64"/>
>>>> + <reg name=3D"f9" bitsize=3D"64"/>
>>>> + <reg name=3D"f10" bitsize=3D"64"/>
>>>> + <reg name=3D"f11" bitsize=3D"64"/>
>>>> + <reg name=3D"f12" bitsize=3D"64"/>
>>>> + <reg name=3D"f13" bitsize=3D"64"/>
>>>> + <reg name=3D"f14" bitsize=3D"64"/>
>>>> + <reg name=3D"f15" bitsize=3D"64"/>
>>>> + <reg name=3D"f16" bitsize=3D"64"/>
>>>> + <reg name=3D"f17" bitsize=3D"64"/>
>>>> + <reg name=3D"f18" bitsize=3D"64"/>
>>>> + <reg name=3D"f19" bitsize=3D"64"/>
>>>> + <reg name=3D"f20" bitsize=3D"64"/>
>>>> + <reg name=3D"f21" bitsize=3D"64"/>
>>>> + <reg name=3D"f22" bitsize=3D"64"/>
>>>> + <reg name=3D"f23" bitsize=3D"64"/>
>>>> + <reg name=3D"f24" bitsize=3D"64"/>
>>>> + <reg name=3D"f25" bitsize=3D"64"/>
>>>> + <reg name=3D"f26" bitsize=3D"64"/>
>>>> + <reg name=3D"f27" bitsize=3D"64"/>
>>>> + <reg name=3D"f28" bitsize=3D"64"/>
>>>> + <reg name=3D"f29" bitsize=3D"64"/>
>>>> + <reg name=3D"f30" bitsize=3D"64"/>
>>>> + <reg name=3D"f31" bitsize=3D"64"/>
>>>> + <reg name=3D"fsr" bitsize=3D"64" group=3D"float"/>
>>>> + <reg name=3D"fir" bitsize=3D"64" group=3D"float"/>
>>>> + <reg name=3D"fp" bitsize=3D"64" group=3D"float"/>
>>>> +</feature>
>>>> diff --git a/target/mips/cpu.c b/target/mips/cpu.c
>>>> index bbcf7ca463..014f1db59e 100644
>>>> --- a/target/mips/cpu.c
>>>> +++ b/target/mips/cpu.c
>>>> @@ -181,6 +181,11 @@ static ObjectClass
>>>>
>>> *mips_cpu_class_by_name(const
>>>
>>>> char *cpu_model)
>>>> return oc;
>>>> }
>>>>
>>>> +static gchar *mips_gdb_arch_name(CPUState *cs)
>>>> +{
>>>> + return g_strdup("mips");
>>>> +}
>>>> +
>>>> static void mips_cpu_class_init(ObjectClass *c, void *data)
>>>> {
>>>> MIPSCPUClass *mcc =3D MIPS_CPU_CLASS(c);
>>>> @@ -213,6 +218,12 @@ static void mips_cpu_class_init(ObjectClass
>>>>
>>> *c,
>>>
>>>> void *data)
>>>> cc->tlb_fill =3D mips_cpu_tlb_fill;
>>>> #endif
>>>>
>>>> + cc->gdb_arch_name =3D mips_gdb_arch_name;
>>>> +#ifdef TARGET_MIPS64
>>>> + cc->gdb_core_xml_file =3D "mips64-core.xml";
>>>> +#else
>>>> + cc->gdb_core_xml_file =3D "mips-core.xml";
>>>> +#endif
>>>> cc->gdb_num_core_regs =3D 73;
>>>> cc->gdb_stop_before_watchpoint =3D true;
>>>> }
>>>>
>>>
>>> --
>>> Alex Benn=C3=A9e
>>>
>>
> --
> Mikhail Abakumov
>

--000000000000052a690594777ca2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Wednesday, October 9, 2019, Mikhail Abakumov &lt;<a href=3D"mail=
to:mikhail.abakumov@ispras.ru">mikhail.abakumov@ispras.ru</a>&gt; wrote:<br=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">Aleksandar Markovic =D0=BF=D0=B8=D1=81=D0=
=B0=D0=BB 2019-10-08 16:37:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On Monday, October 7, 2019, Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.ben=
nee@linaro.org" target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
wrote:<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Mikhail Abakumov &lt;<a href=3D"mailto:mikhail.abakumov@ispras.ru" target=
=3D"_blank">mikhail.abakumov@ispras.ru</a>&gt; writes:<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
From: Mikhail Abakumov &lt;mikhail.abakumov@ispras&gt;<br>
</blockquote>
<br>
Hmm the email got truncated here.<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
This patch add xml files with gdb registers for mips.<br>
<br>
Signed-off-by: Mikhail Abakumov &lt;mikhail.abakumov@ispras&gt;<br>
---<br>
configure | 3 ++<br>
gdb-xml/mips-core.xml | 84<br>
</blockquote>
++++++++++++++++++++++++++++++<wbr>+++++++++++<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
gdb-xml/mips64-core.xml | 84<br>
++++++++++++++++++++++++++++++<wbr>+++++++++++<br>
</blockquote>
<br>
Otherwise for the configure/xml:<br>
<br>
Acked-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org" ta=
rget=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
<br>
I assume the changes will go in via a MIPS tree.<br>
</blockquote>
<br>
Yes, this should go via mips tree. Thanks for taking a look.<br>
<br>
Mikhail, thanks for this effort.<br>
<br>
Is there any way to include MSA registers, possibly in a separate<br>
file, and in a separate patch? What about a separate file for FPU<br>
registers? Can you take a look at corresponding solutions for other<br>
architectures?<br>
</blockquote>
<br>
Thanks for the feedback.<br>
<br>
Yes, I did it initially. But looking at other architectures, redid it.<br>
Everywhere, one main xml-file is used for registers, described<br>
in the target/gdbstub. And additional ones are appended through<br>
&#39;gdb_register_coprocessor&#39;.<br>
In the current patch, I made a description of the registers described<br>
only in the target/gdbstub. In the future, I think FPU registers<br>
can be moved to a separate file, but then need to move them from<br>
the mips/gdbstub.</blockquote><div><br></div><div><br></div><div>Mikhail,</=
div><div><br></div><div>Your implementation assumes that 64-bit CPU always =
has 64-bit FPU, and 32-bit CPU - 32-bit FPU. However, that is not always tr=
ue.</div><div><br></div><div>Please see related patch for RISC-V:</div><div=
><br></div><div><a href=3D"https://patchew.org/QEMU/20190821162831.27811-1-=
georg.kotheimer@kernkonzept.com/">https://patchew.org/QEMU/20190821162831.2=
7811-1-georg.kotheimer@kernkonzept.com/</a><br></div><div><br></div><div>..=
. and correct your solution in a similar way.</div><div><br></div><div>Keep=
 also in mind that, in general, gdb xml support should work for all (or at =
least, almost all) QEMU-supported MIPS CPUs, not just the most common. For =
example, is your solution correct for R4000 CPU? Is the register layout the=
 same for, for example, &quot;ancient&quot; R4000 and &quot;moderm&quot; I6=
400?</div><div><br></div><div>Thanks again!</div><div><br></div><div>Aleksa=
ndar</div><div><br></div><div><br></div><div><br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
Yours,<br>
Aleksandar<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
target/mips/cpu.c | 11 ++++++<br>
4 files changed, 182 insertions(+)<br>
create mode 100644 gdb-xml/mips-core.xml<br>
create mode 100644 gdb-xml/mips64-core.xml<br>
<br>
diff --git a/configure b/configure<br>
index 8f8446f52b..5bb2c62194 100755<br>
--- a/configure<br>
+++ b/configure<br>
@@ -7466,12 +7466,14 @@ case &quot;$target_name&quot; in<br>
mips|mipsel)<br>
mttcg=3D&quot;yes&quot;<br>
TARGET_ARCH=3Dmips<br>
+ gdb_xml_files=3D&quot;mips-core.xml&quot;<br>
echo &quot;TARGET_ABI_MIPSO32=3Dy&quot; &gt;&gt; $config_target_mak<br>
;;<br>
mipsn32|mipsn32el)<br>
mttcg=3D&quot;yes&quot;<br>
TARGET_ARCH=3Dmips64<br>
TARGET_BASE_ARCH=3Dmips<br>
+ gdb_xml_files=3D&quot;mips64-core.xml<wbr>&quot;<br>
echo &quot;TARGET_ABI_MIPSN32=3Dy&quot; &gt;&gt; $config_target_mak<br>
echo &quot;TARGET_ABI32=3Dy&quot; &gt;&gt; $config_target_mak<br>
;;<br>
@@ -7479,6 +7481,7 @@ case &quot;$target_name&quot; in<br>
mttcg=3D&quot;yes&quot;<br>
TARGET_ARCH=3Dmips64<br>
TARGET_BASE_ARCH=3Dmips<br>
+ gdb_xml_files=3D&quot;mips64-core.xml<wbr>&quot;<br>
echo &quot;TARGET_ABI_MIPSN64=3Dy&quot; &gt;&gt; $config_target_mak<br>
;;<br>
moxie)<br>
diff --git a/gdb-xml/mips-core.xml b/gdb-xml/mips-core.xml<br>
new file mode 100644<br>
index 0000000000..a46b2993eb<br>
--- /dev/null<br>
+++ b/gdb-xml/mips-core.xml<br>
@@ -0,0 +1,84 @@<br>
+&lt;?xml version=3D&quot;1.0&quot;?&gt;<br>
+&lt;!-- Copyright (C) 2010-2019 Free Software Foundation, Inc.<br>
+<br>
+ Copying and distribution of this file, with or without<br>
modification,<br>
+ are permitted in any medium without royalty provided the<br>
</blockquote>
copyright<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
+ notice and this notice are preserved. --&gt;<br>
+<br>
+&lt;!DOCTYPE feature SYSTEM &quot;gdb-target.dtd&quot;&gt;<br>
+&lt;feature name=3D&quot;org.gnu.gdb.mips&quot;&gt;<br>
+ &lt;reg name=3D&quot;zero&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;at&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;v0&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;v1&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;a0&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;a1&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;a2&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;a3&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;t0&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;t1&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;t2&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;t3&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;t4&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;t5&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;t6&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;t7&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;s0&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;s1&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;s2&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;s3&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;s4&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;s5&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;s6&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;s7&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;t8&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;t9&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;k0&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;k1&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;gp&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;sp&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;s8&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;ra&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;sr&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;lo&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;hi&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;bad&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;cause&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;pc&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+<br>
+ &lt;reg name=3D&quot;f0&quot; bitsize=3D&quot;32&quot; regnum=3D&quot;38&=
quot;/&gt;<br>
+ &lt;reg name=3D&quot;f1&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f2&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f3&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f4&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f5&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f6&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f7&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f8&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f9&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f10&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f11&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f12&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f13&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f14&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f15&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f16&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f17&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f18&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f19&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f20&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f21&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f22&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f23&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f24&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f25&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f26&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f27&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f28&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f29&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f30&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f31&quot; bitsize=3D&quot;32&quot;/&gt;<br>
+ &lt;reg name=3D&quot;fsr&quot; bitsize=3D&quot;32&quot; group=3D&quot;flo=
at&quot;/&gt;<br>
+ &lt;reg name=3D&quot;fir&quot; bitsize=3D&quot;32&quot; group=3D&quot;flo=
at&quot;/&gt;<br>
+ &lt;reg name=3D&quot;fp&quot; bitsize=3D&quot;32&quot; group=3D&quot;floa=
t&quot;/&gt;<br>
+&lt;/feature&gt;<br>
diff --git a/gdb-xml/mips64-core.xml b/gdb-xml/mips64-core.xml<br>
new file mode 100644<br>
index 0000000000..cc1a15ad56<br>
--- /dev/null<br>
+++ b/gdb-xml/mips64-core.xml<br>
@@ -0,0 +1,84 @@<br>
+&lt;?xml version=3D&quot;1.0&quot;?&gt;<br>
+&lt;!-- Copyright (C) 2010-2019 Free Software Foundation, Inc.<br>
+<br>
+ Copying and distribution of this file, with or without<br>
modification,<br>
+ are permitted in any medium without royalty provided the<br>
</blockquote>
copyright<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
+ notice and this notice are preserved. --&gt;<br>
+<br>
+&lt;!DOCTYPE feature SYSTEM &quot;gdb-target.dtd&quot;&gt;<br>
+&lt;feature name=3D&quot;org.gnu.gdb.mips64&quot;&gt;<br>
+ &lt;reg name=3D&quot;zero&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;at&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;v0&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;v1&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;a0&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;a1&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;a2&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;a3&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;t0&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;t1&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;t2&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;t3&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;t4&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;t5&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;t6&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;t7&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;s0&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;s1&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;s2&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;s3&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;s4&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;s5&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;s6&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;s7&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;t8&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;t9&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;k0&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;k1&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;gp&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;sp&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;s8&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;ra&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;sr&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;lo&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;hi&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;bad&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;cause&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;pc&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+<br>
+ &lt;reg name=3D&quot;f0&quot; bitsize=3D&quot;64&quot; regnum=3D&quot;38&=
quot;/&gt;<br>
+ &lt;reg name=3D&quot;f1&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f2&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f3&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f4&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f5&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f6&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f7&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f8&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f9&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f10&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f11&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f12&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f13&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f14&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f15&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f16&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f17&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f18&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f19&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f20&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f21&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f22&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f23&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f24&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f25&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f26&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f27&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f28&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f29&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f30&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;f31&quot; bitsize=3D&quot;64&quot;/&gt;<br>
+ &lt;reg name=3D&quot;fsr&quot; bitsize=3D&quot;64&quot; group=3D&quot;flo=
at&quot;/&gt;<br>
+ &lt;reg name=3D&quot;fir&quot; bitsize=3D&quot;64&quot; group=3D&quot;flo=
at&quot;/&gt;<br>
+ &lt;reg name=3D&quot;fp&quot; bitsize=3D&quot;64&quot; group=3D&quot;floa=
t&quot;/&gt;<br>
+&lt;/feature&gt;<br>
diff --git a/target/mips/cpu.c b/target/mips/cpu.c<br>
index bbcf7ca463..014f1db59e 100644<br>
--- a/target/mips/cpu.c<br>
+++ b/target/mips/cpu.c<br>
@@ -181,6 +181,11 @@ static ObjectClass<br>
</blockquote>
*mips_cpu_class_by_name(const<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
char *cpu_model)<br>
return oc;<br>
}<br>
<br>
+static gchar *mips_gdb_arch_name(CPUState *cs)<br>
+{<br>
+ return g_strdup(&quot;mips&quot;);<br>
+}<br>
+<br>
static void mips_cpu_class_init(ObjectClas<wbr>s *c, void *data)<br>
{<br>
MIPSCPUClass *mcc =3D MIPS_CPU_CLASS(c);<br>
@@ -213,6 +218,12 @@ static void mips_cpu_class_init(ObjectClas<wbr>s<br>
</blockquote>
*c,<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
void *data)<br>
cc-&gt;tlb_fill =3D mips_cpu_tlb_fill;<br>
#endif<br>
<br>
+ cc-&gt;gdb_arch_name =3D mips_gdb_arch_name;<br>
+#ifdef TARGET_MIPS64<br>
+ cc-&gt;gdb_core_xml_file =3D &quot;mips64-core.xml&quot;;<br>
+#else<br>
+ cc-&gt;gdb_core_xml_file =3D &quot;mips-core.xml&quot;;<br>
+#endif<br>
cc-&gt;gdb_num_core_regs =3D 73;<br>
cc-&gt;gdb_stop_before_watchpoint =3D true;<br>
}<br>
</blockquote>
<br>
--<br>
Alex Benn=C3=A9e<br>
</blockquote></blockquote>
<br>
-- <br>
Mikhail Abakumov<br>
</blockquote>

--000000000000052a690594777ca2--


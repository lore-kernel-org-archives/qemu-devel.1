Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4D4C2BABC
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:33:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3696420719
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IDk8yMqZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3696420719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLkbo-0003zd-F7
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 05:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34777)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jLkb4-0003Yi-Ru
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:32:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jLkb1-0002tA-UK
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:32:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55572
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jLkb1-0002sH-Q5
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:32:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586251959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Noezla98a7thp64dkaCo6AjndZhujR3kRQa1RRAVM7M=;
 b=IDk8yMqZdGLuD0iRzBiPxbFn7bny43N6+biHulbOfnd6nSDnfQdBsXDGBy6wlw0SqUr4Ns
 p0SlrIJ7mfvKiVyD3mYqp4W9wB61pY5AyxmwccBypXf+PBvXKLY8z1i3t+V6/JbbdiUXIx
 auwNkBUIB6BUBBktLbLeYuykAI3NAc4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-ENlEtMjmPWm9we7mtyIZAw-1; Tue, 07 Apr 2020 05:32:34 -0400
X-MC-Unique: ENlEtMjmPWm9we7mtyIZAw-1
Received: by mail-ed1-f72.google.com with SMTP id i61so2613264edc.2
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 02:32:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LUjlHmxFgjfk8cFf8PaR/YsYTbI5swvwrRfHXeWBPx0=;
 b=hTjJ+aULBeCLpWPNr2SkIgKceQP2fHurtViUvSx0zV0BTLeeVMs7Ye6nMolPZLgYqE
 NaB8GQpkiRS4VYXXO+PhbXm4x8clpa5uoyspV4iwaJL8YCyzL2YcYuQPnlhvbyC1nB+Z
 o2gr4VYlSjZY442qr4sKrR9n6TXLM9k1gcR1Y4sEUgugfI9eg0u9N5lRM6syt6NQ85TT
 0xAETjDZrMNGRVKQ1ahkSH+6N1eLVzuxZEWDX7PKW7Yp7sWtRHXGUUYqQPNuO7VwntUF
 86aV0Noe8Rpf1fjrnv/SgMfnLQsbLauzAAtY6/jJGUTMKYwe+uc32cyKIT1R2EXdKPH0
 6pIA==
X-Gm-Message-State: AGi0Pubkq2Qfhhj7aNlV5PTImf4LILiqg4IlHnY0K0Q7PQ4KEXljNwif
 IXWD6IFaCkxfKBb5XKDSwg5Wz8RBnQA6Es/qQZjiv/tB0x3wHUr+XpfeGzOFPasd0505zkXqyVh
 pNUpyLzeL7q1XZB8=
X-Received: by 2002:a50:fb02:: with SMTP id d2mr1078069edq.384.1586251953032; 
 Tue, 07 Apr 2020 02:32:33 -0700 (PDT)
X-Google-Smtp-Source: APiQypIsFqkbHzhUJHAGk+mAKa8UJr4FkXV6O2aF3bUsXJY6Dxf/RQogc15sIE/jIIKfGPlgtiOHxw==
X-Received: by 2002:a50:fb02:: with SMTP id d2mr1078047edq.384.1586251952710; 
 Tue, 07 Apr 2020 02:32:32 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id d20sm2631215edn.12.2020.04.07.02.32.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2020 02:32:32 -0700 (PDT)
Subject: Re: [RFC PATCH-for-5.0?] target/mips/translate: Report exception in
 delay slot as UNPREDICTABLE
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200406235418.18315-1-f4bug@amsat.org>
 <CAFEAcA8rPhPKTjxh-iPkP8qpRpCCYEDgepCK=MSwy96h_kk_7w@mail.gmail.com>
 <894d16c7-4f6d-a842-ec28-f2a0b7cc2565@redhat.com>
Message-ID: <cabe97ae-91ca-b88c-5690-9a18eca8c521@redhat.com>
Date: Tue, 7 Apr 2020 11:32:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <894d16c7-4f6d-a842-ec28-f2a0b7cc2565@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 "Emilio G . Cota" <cota@braap.org>, Brian Campbell <bacam@z273.org.uk>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/7/20 11:23 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 4/7/20 10:35 AM, Peter Maydell wrote:
>> On Tue, 7 Apr 2020 at 00:55, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>=20
>> wrote:
>>>
>>> Using the BC1ANY4F instruction with a 24Kf core (MIPS32R2
>>> & ASE_MIPS16) we get:
>>>
>>> =C2=A0=C2=A0 $ echo -ne '\x03\x20\xf8\x09EEEE' > cop1x.bin
>>> =C2=A0=C2=A0 $ qemu-system-mipsel -bios cop1x.bin
>>> =C2=A0=C2=A0 unknown branch 0x13000
>>> =C2=A0=C2=A0 Aborted (core dumped)
>>
>>> This is because this COP1X instruction generates a Reserved
>>> Instruction when used with this core, however we are in a delay
>>> slot, and exceptions in delay slot are architecturally unpredictable.
>>>
>>> Core dumps confunse users. Instead, report a friendlier error message:
>>>
>>> =C2=A0=C2=A0 $ qemu-system-mipsel -bios cop1x.bin
>>> =C2=A0=C2=A0 qemu-system-mipsel: Exception in delay slot is UNPREDICTAB=
LE
>>
>> UNPREDICTABLE behaviour should not in QEMU include
>> causing QEMU to exit. You can log it with LOG_GUEST_ERROR
>> if you like but you should do something plausible (ideally what
>> some bit of real hardware does when this situation happens).
>=20
> OK. I have no clue how real 24Kf deals with it - I don't own one -, it=20
> is not in my list of interests (and my list of interests - which I can=20
> reproduce - is not modeled in QEMU).
>=20
>>
>> PS: does MIPS use the "UNPREDICTABLE" terminology? I
>> thought it was an Arm-ism, but maybe it's caught on more widely.
>=20
> At least it appears in my MIPS32 ISA Vol II (Revision 0.95) copy from 200=
1:
>=20
> 1.2=C2=A0 UNPREDICTABLE and UNDEFINED
>=20
> 1.2.1=C2=A0 UNPREDICTABLE
> UNPREDICTABLE results may vary from processor implementation to=20
> implementation, instruction to instruction, oras a function of time on=20
> the same implementation or instruction. Software can never depend on=20
> results that are UNPREDICTABLE. UNPREDICTABLE operations may cause a=20
> result to be generated or not. If a result is generated,it is=20
> UNPREDICTABLE. UNPREDICTABLE operations may cause arbitrary exceptions.
> UNPREDICTABLE results or operations have several implementation=20
> restrictions:
> =E2=80=A2 Implementations of operations generating UNPREDICTABLE results =
must=20
> not depend on any data source (memory or internal state) which is=20
> inaccessible in the current processor mode
> =E2=80=A2 UNPREDICTABLE operations must not read, write, or modify the co=
ntents=20
> of memory or internal state which is inaccessible in the current=20
> processor mode. For example, UNPREDICTABLE operations executed in user=20
> mode must not access memory or internal state that is only accessible in=
=20
> Kernel Mode or Debug Mode or in another process
> =E2=80=A2 UNPREDICTABLE operations must not halt or hang the processor
>=20
> 1.2.2=C2=A0 UNDEFINED
> UNDEFINED operations or behavior may vary from processor implementation=
=20
> to implementation, instruction to instruction, or as a function of time=
=20
> on the same implementation or instruction. UNDEFINED operations or=20
> behavior may vary from nothing to creating an environment in which=20
> execution can no longer continue. UNDEFINED operations or behavior may=20
> cause data loss.
> UNDEFINED operations or behavior has one implementation restriction:
> =E2=80=A2 UNDEFINED operations or behavior must not cause the processor t=
o hang=20
> (that is, enter a state from which there is no exit other than powering=
=20
> down the processor). The assertion of any of the reset signals must=20
> restore the processorto an operational state
>=20
> Then:
>=20
> Jump and Link Register (JALR)
>=20
> Processor operation is UNPREDICTABLE if a branch, jump, ERET, DERET, or=
=20
> WAIT instruction is placed in the delay slot of a branch or jump.
>=20
> ---
>=20
> On Vol I Rev 6.01:
>=20
> 5.3.2.1=C2=A0 Control Transfer Instructions in Delay Slots and Forbidden =
Slots
>=20
> In MIPS architectures prior to Release 6. if a control transfer=20
> instruction (CTI) is placed in a branch delay slot, the operation of=20
> both instructions is UNPREDICTABLE. In Release 6, if a CTI is placed in=
=20
> a branch delay slot or a compact branch forbidden slot, implementations=
=20
> are required to signal a Reserved Instruction exception.

Which also means this patch is incorrect for CPUs implementing the=20
Release 6 (which I'm not familiar with).

>=20
> The following instructions are forbidden in branch delay slots and=20
> forbidden slots: any CTI, including branches and jumps, ERET, ERETNC,=20
> DERET, WAIT, and PAUSE. Their occurrence is required to signal a=20
> Reserved Instruction exception.
>=20
> 5.3.2.2=C2=A0 Exceptions and Delay and Forbidden Slots
>=20
> If an exception or interrupt prevents the completion of an instruction=20
> in a delay slot or forbidden slot, the hardware reports an Exception PC=
=20
> (CP0 EPC) of the branch, with a status bit set (StatusBD) to indicate=20
> that the exception was for the instruction in the delay slot of the branc=
h.
> By convention, if an exception or interrupt prevents the completion of=20
> an instruction in a branch delay or forbidden slot, the branch=20
> instruction is re-executed and branch instructions must be restartable=20
> to permit this. In particular, procedure calls must be restartable. To=20
> insure that a procedure call is restartable, procedure calls that have a=
=20
> delay slot or forbidden slot (branch/jump-and-link instructions) should=
=20
> not use the register in which the return link is stored (usu-ally GPR=20
> 31) as a source register. This applies to all branch/jump-and-link=20
> instructions that have both a slot (delay or forbidden) and source=20
> registers, both for conditions (e.g., BGEZAL or BGEZALC) or for jump=20
> targets (JALR).
>=20
> ---
>=20
> I would have expected the behavior match the UNDEFINED description, as=20
> Yongbok Kim commented here:
> https://bugs.launchpad.net/qemu/+bug/1663287/comments/3
>=20
>  =C2=A0 branches in a delay slot is "undefined" in the pre-Release
>  =C2=A0 6 architecture. MIPS architectre release 6 defines to signal
>  =C2=A0 Reserved Instruction exceptions for such cases.
>=20
> But it really appears as UNPREDICTABLE.



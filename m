Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCF6C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:26:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E26AC206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T9HesKF2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E26AC206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLkV8-0000y2-4T
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 05:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33375)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jLkRq-0003hb-2b
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:23:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jLkRo-0001Lq-Fr
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:23:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45304
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jLkRo-0001LU-Bn
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586251387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5VEUgAvoMJxzRpJvs8K8aY4kHruWOPsgrxkzEpOoPwA=;
 b=T9HesKF2uO073Y3wn94YiMCsPLtTFh2jWEKmXRg0JMpZd1oGlRhT9mOknj/nvgB03TH7uc
 wTQ7ZpanvhZa94zzZAItjcayNthet0HhVqx6eysFuf1+xwLetrgxpnJ6C4HbdxEQinv4kg
 8rXYuzOvjfldljyu6ulNiHvTM3K6oWM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-hR6cKSkAOqu5XLjpRZ8duA-1; Tue, 07 Apr 2020 05:23:04 -0400
X-MC-Unique: hR6cKSkAOqu5XLjpRZ8duA-1
Received: by mail-ed1-f69.google.com with SMTP id d4so2210561edn.22
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 02:23:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=J/7z0cY0SidIaFUVPNCYvuk1OI41tAruWTM7cOSN+lw=;
 b=W4NseAgbVXTzcm1iHQk3xnzBSRu9nt7xWN+gGs86dOZv47vHMuzc3w59VlET6dUQ80
 yQQgsWqOKvJ20/qvoqhcKEkJDxcqsdv7BJG2R7Q1zDgF3z98+lVHWPEyh6G5dPici4jP
 eXzAiF7jhzh5qC7sXBG/AF93p0+Zd1GXe8eBVm18PIp8lzkCnkp4Bgfgk+dCswmTzdNp
 AlUWqnWvCPvWoFE4sNjjbCwwNfND8nkdC52/NJpCPGCMmYEXIhDRpa8G3EdnEsHk1YfR
 D77wTFnLUG/33nHmvkF3h/zUNxDhJEk7pT7zs9xazMpLufipHvay9hX8qoJazAbOPw9o
 tedg==
X-Gm-Message-State: AGi0PuasAn+hdZsHvflKAiB+iveJ+3QQGme7hD4HWaRUFPc6dlUUf8lZ
 iOmrKLvktWySilJrQSv0cWVq6myaRP2CO2Mf/HWtw2ImxeXDwwnpVJ/GsBSd3dhDiwZ1rGBO/ds
 NZ7CfXxm8SSld1co=
X-Received: by 2002:a17:906:ae85:: with SMTP id
 md5mr1123321ejb.165.1586251383038; 
 Tue, 07 Apr 2020 02:23:03 -0700 (PDT)
X-Google-Smtp-Source: APiQypJlvjp/XWcfomIq+FouyxdubgIdV9tUMhvqhGwCKBgyZKGZSXUJ3rSXr5xuzytdQqP9eo6lBA==
X-Received: by 2002:a17:906:ae85:: with SMTP id
 md5mr1123301ejb.165.1586251382752; 
 Tue, 07 Apr 2020 02:23:02 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id o33sm2642155eda.30.2020.04.07.02.23.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2020 02:23:02 -0700 (PDT)
Subject: Re: [RFC PATCH-for-5.0?] target/mips/translate: Report exception in
 delay slot as UNPREDICTABLE
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200406235418.18315-1-f4bug@amsat.org>
 <CAFEAcA8rPhPKTjxh-iPkP8qpRpCCYEDgepCK=MSwy96h_kk_7w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <894d16c7-4f6d-a842-ec28-f2a0b7cc2565@redhat.com>
Date: Tue, 7 Apr 2020 11:23:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8rPhPKTjxh-iPkP8qpRpCCYEDgepCK=MSwy96h_kk_7w@mail.gmail.com>
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

On 4/7/20 10:35 AM, Peter Maydell wrote:
> On Tue, 7 Apr 2020 at 00:55, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>>
>> Using the BC1ANY4F instruction with a 24Kf core (MIPS32R2
>> & ASE_MIPS16) we get:
>>
>>    $ echo -ne '\x03\x20\xf8\x09EEEE' > cop1x.bin
>>    $ qemu-system-mipsel -bios cop1x.bin
>>    unknown branch 0x13000
>>    Aborted (core dumped)
>=20
>> This is because this COP1X instruction generates a Reserved
>> Instruction when used with this core, however we are in a delay
>> slot, and exceptions in delay slot are architecturally unpredictable.
>>
>> Core dumps confunse users. Instead, report a friendlier error message:
>>
>>    $ qemu-system-mipsel -bios cop1x.bin
>>    qemu-system-mipsel: Exception in delay slot is UNPREDICTABLE
>=20
> UNPREDICTABLE behaviour should not in QEMU include
> causing QEMU to exit. You can log it with LOG_GUEST_ERROR
> if you like but you should do something plausible (ideally what
> some bit of real hardware does when this situation happens).

OK. I have no clue how real 24Kf deals with it - I don't own one -, it=20
is not in my list of interests (and my list of interests - which I can=20
reproduce - is not modeled in QEMU).

>=20
> PS: does MIPS use the "UNPREDICTABLE" terminology? I
> thought it was an Arm-ism, but maybe it's caught on more widely.

At least it appears in my MIPS32 ISA Vol II (Revision 0.95) copy from 2001:

1.2  UNPREDICTABLE and UNDEFINED

1.2.1  UNPREDICTABLE
UNPREDICTABLE results may vary from processor implementation to=20
implementation, instruction to instruction, oras a function of time on=20
the same implementation or instruction. Software can never depend on=20
results that are UNPREDICTABLE. UNPREDICTABLE operations may cause a=20
result to be generated or not. If a result is generated,it is=20
UNPREDICTABLE. UNPREDICTABLE operations may cause arbitrary exceptions.
UNPREDICTABLE results or operations have several implementation=20
restrictions:
=E2=80=A2 Implementations of operations generating UNPREDICTABLE results mu=
st=20
not depend on any data source (memory or internal state) which is=20
inaccessible in the current processor mode
=E2=80=A2 UNPREDICTABLE operations must not read, write, or modify the cont=
ents=20
of memory or internal state which is inaccessible in the current=20
processor mode. For example, UNPREDICTABLE operations executed in user=20
mode must not access memory or internal state that is only accessible in=20
Kernel Mode or Debug Mode or in another process
=E2=80=A2 UNPREDICTABLE operations must not halt or hang the processor

1.2.2  UNDEFINED
UNDEFINED operations or behavior may vary from processor implementation=20
to implementation, instruction to instruction, or as a function of time=20
on the same implementation or instruction. UNDEFINED operations or=20
behavior may vary from nothing to creating an environment in which=20
execution can no longer continue. UNDEFINED operations or behavior may=20
cause data loss.
UNDEFINED operations or behavior has one implementation restriction:
=E2=80=A2 UNDEFINED operations or behavior must not cause the processor to =
hang=20
(that is, enter a state from which there is no exit other than powering=20
down the processor). The assertion of any of the reset signals must=20
restore the processorto an operational state

Then:

Jump and Link Register (JALR)

Processor operation is UNPREDICTABLE if a branch, jump, ERET, DERET, or=20
WAIT instruction is placed in the delay slot of a branch or jump.

---

On Vol I Rev 6.01:

5.3.2.1  Control Transfer Instructions in Delay Slots and Forbidden Slots

In MIPS architectures prior to Release 6. if a control transfer=20
instruction (CTI) is placed in a branch delay slot, the operation of=20
both instructions is UNPREDICTABLE. In Release 6, if a CTI is placed in=20
a branch delay slot or a compact branch forbidden slot, implementations=20
are required to signal a Reserved Instruction exception.

The following instructions are forbidden in branch delay slots and=20
forbidden slots: any CTI, including branches and jumps, ERET, ERETNC,=20
DERET, WAIT, and PAUSE. Their occurrence is required to signal a=20
Reserved Instruction exception.

5.3.2.2  Exceptions and Delay and Forbidden Slots

If an exception or interrupt prevents the completion of an instruction=20
in a delay slot or forbidden slot, the hardware reports an Exception PC=20
(CP0 EPC) of the branch, with a status bit set (StatusBD) to indicate=20
that the exception was for the instruction in the delay slot of the branch.
By convention, if an exception or interrupt prevents the completion of=20
an instruction in a branch delay or forbidden slot, the branch=20
instruction is re-executed and branch instructions must be restartable=20
to permit this. In particular, procedure calls must be restartable. To=20
insure that a procedure call is restartable, procedure calls that have a=20
delay slot or forbidden slot (branch/jump-and-link instructions) should=20
not use the register in which the return link is stored (usu-ally GPR=20
31) as a source register. This applies to all branch/jump-and-link=20
instructions that have both a slot (delay or forbidden) and source=20
registers, both for conditions (e.g., BGEZAL or BGEZALC) or for jump=20
targets (JALR).

---

I would have expected the behavior match the UNDEFINED description, as=20
Yongbok Kim commented here:
https://bugs.launchpad.net/qemu/+bug/1663287/comments/3

   branches in a delay slot is "undefined" in the pre-Release
   6 architecture. MIPS architectre release 6 defines to signal
   Reserved Instruction exceptions for such cases.

But it really appears as UNPREDICTABLE.



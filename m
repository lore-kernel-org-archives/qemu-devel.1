Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845FFC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 11:55:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3D57204FD
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 11:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qso0HxCV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3D57204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGheO-0002um-U5
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 07:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kGhdf-0002F7-S8
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 07:54:47 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40563)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kGhdd-0003zx-MF
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 07:54:47 -0400
Received: by mail-wr1-x442.google.com with SMTP id j2so11193540wrx.7
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 04:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=VFoByf3PGihN1goL6ZvA0tVV1xMv374D+1AeJJt5zEA=;
 b=Qso0HxCVaDQSBn24j4wojHz0Md1wLVlP/dfoZxSJbugpvYVlbocbWgooRaFpwqEwrz
 dGuCUkJWkpXCRd5yIUdqow9BLZ8MkgRoyvw6ZV3/WP456SotF27lM5lvkDuDt6wrynKY
 n99/g4GYt9QFaL5m7GLvIeWDhF+omjFLLmbfDwRNngNUo73lsuBnZV6U80btWujgkEsU
 2maz9Q78CsLGxXVJJaIQz19lJmAJBLJGIF1d9FOfK6aF7m+sB9h/YH8VE+p3P/LesUlM
 DKxeKB+NMpOkSJKvD192XhH/4mwQY430S9T+B9M3JcJ8HcQveMYPhuxEln4ye5dNP4D+
 wxhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=VFoByf3PGihN1goL6ZvA0tVV1xMv374D+1AeJJt5zEA=;
 b=pDwb4HOayBEMNmwF24105y2j7rwqpzcjaHIm6efeHsyhOFjjAjwsh1En/z9S6RwaBd
 6ICB79k+rdcpgTrX6u3q8sSYW90CTkQ/pwJeysnl52SdKFfc75ifnNID5etkY2vK1B25
 u8W8IyAulWjOEfLFd5VuV0OFxAGFjVvBKU4DELc49t2cwUaoQB7+gfiCvxf9tK6r4tho
 vw9Xn1rIqYSSdfk44d25v32XyUCwcS6Lzo7NrnD3tyQ+Di9aa1przB/S89sXk21hh9og
 k4rjIFFz4oHdwddsXJwOOTeS+XLFRe1fc/lRDPEyI/GFrD9e8/JJkhXobISiVvvLQOU2
 hgjQ==
X-Gm-Message-State: AOAM531uvCZCS/d6KefLMSrQuGasL8fsR+On0OcGFONz1zPhMki+JcCD
 yzP+x0uY/cBdchWjW0f5oav4HA==
X-Google-Smtp-Source: ABdhPJyBUNDi2sD7TcOrddCOjdElcn+sdzDE5WWsVCI/hJvmIPtY0E7JHiGnEIH1187xUxoFe36HHA==
X-Received: by 2002:adf:ff90:: with SMTP id j16mr1853174wrr.105.1599825284160; 
 Fri, 11 Sep 2020 04:54:44 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t22sm4745118wmt.1.2020.09.11.04.54.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2020 04:54:42 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 53D111FF7E;
 Fri, 11 Sep 2020 12:54:42 +0100 (BST)
References: <159970958159.31371.12301700684467003959.malonedeb@wampee.canonical.com>
 <92de5ee0-629a-640a-d547-8c2d650742f2@vivier.eu>
 <87tuw4odwk.fsf@linaro.org> <87r1r8odph.fsf@linaro.org>
 <CAGTPX+DAoJcw2y9gPjkP6kGXEQW7=e1tohM8vND9j9Qtxuc5vw@mail.gmail.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Bug 1895080 <1895080@bugs.launchpad.net>
Subject: Re: [Bug 1895080] [NEW] pgb_reserved_va: Assertion `addr == test'
 failed
In-reply-to: <CAGTPX+DAoJcw2y9gPjkP6kGXEQW7=e1tohM8vND9j9Qtxuc5vw@mail.gmail.com>
Date: Fri, 11 Sep 2020 12:54:42 +0100
Message-ID: <87o8mco7el.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


Hansni Bu <1895080@bugs.launchpad.net> writes:

> No, it's not set by CentOS-7.5.
> Does it mean that we just cannot run the ELF in such a case? I've tried
> many times, the assert always fails. Maybe, we can blame CentOS-7.5.

The trouble is without MAP_FIXED_NOREPLACE we are at the mercy of the
host kernel to allow the address request to be honoured. A plain
MAP_FIXED won't do as it can clober existing mappings. In theory a
suitable hole has been identified but sometimes the kernel makes a
decision to offset the suggested mapping for it's own reasons.=20

> BTW: with the option "-p 65536", the case runs successfully.

Hmm interesting. I wonder if we are seeing a fail due to mmap_min_addr?
What does:

  /proc/sys/vm/mmap_min_addr

give you on the system?

You can manually set the reserved_va and the base address using -R and
-B although that is more of a developer work around. I think moving the
assert to the condition above would be an improvement just because it
tells us what the requested base address was and what the kernel decided
to give us.

>
> On Fri, Sep 11, 2020 at 5:50 PM Alex Benn=C3=A9e <1895080@bugs.launchpad.=
net>
> wrote:
>
>> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>>
>> > Laurent Vivier <laurent@vivier.eu> writes:
>> >
>> <snip>
>> >>> Then trying qemu-riscv32 with a simple ELF, I get:
>> >>> linux-user/elfload.c:2341: pgb_reserved_va: Assertion `addr =3D=3D t=
est'
>> failed.
>> >>>
>> >>> strace shows that:
>> >>> mmap(0x1000, 4294963200, PROT_NONE,
>> MAP_PRIVATE|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) =3D 0x10000
>> >>> write(2, "qemu-riscv32: ../qemu.git/linux-"..., 103qemu-riscv32:
>> ../qemu.git/linux-user/elfload.c:2341: pgb_reserved_va: Assertion `addr =
=3D=3D
>> test' failed.
>> >>> ) =3D 103
>> >>>
>> >>> The source code is in the function pgb_reserved_va (linux-
>> >>> user/elfload.c). I think mmap cannot guarantee that the returned
>> pointer
>> >>> (test) equals to the parameter of addr. So is this a bug to assert
>> (addr
>> >>> =3D=3D test)?
>> >>
>> > I'm assuming CentOS 7.5 actually has a definition for
>> > MAP_FIXED_NOREPLACE which should ensure we get what we asked for -
>> > otherwise we are in the position of hoping the kernel honours what we
>> > asked for.
>>
>> Doh re-reading I see it's not set in the strace output. Maybe we should
>> promote the assert case to the failure leg so we have:
>>
>>     if (addr =3D=3D MAP_FAILED || addr !=3D test) {
>>         error_report(...)
>>     }
>>
>> so we at least fail with a user friendly error rather than an abort?
>>
>> --
>> Alex Benn=C3=A9e
>>
>> --
>> You received this bug notification because you are subscribed to the bug
>> report.
>> https://bugs.launchpad.net/bugs/1895080
>>
>> Title:
>>   pgb_reserved_va: Assertion `addr =3D=3D test' failed
>>
>> Status in QEMU:
>>   New
>>
>> Bug description:
>>   This problem occurs on CentOS-7.5 (64-bit) with qemu-5.1.0, qemu head
>>   (commit 9435a8b3dd35f1f926f1b9127e8a906217a5518a) for riscv32-linux-
>>   user.
>>
>>   Firstly, compile fails:
>>   Compiling C object libqemu-riscv32-linux-user.fa.p/linux-user_strace.c=
.o
>>   ../qemu.git/linux-user/strace.c:1210:18: error: =E2=80=98FALLOC_FL_KEE=
P_SIZE=E2=80=99
>> undeclared here (not in a function)
>>        FLAG_GENERIC(FALLOC_FL_KEEP_SIZE),
>>
>>   I have to add below include to linux-user/strace.c
>>   diff --git a/linux-user/strace.c b/linux-user/strace.c
>>   index 11fea14fba..22e51d4a8a 100644
>>   --- a/linux-user/strace.c
>>   +++ b/linux-user/strace.c
>>   @@ -7,6 +7,7 @@
>>    #include <sys/mount.h>
>>    #include <arpa/inet.h>
>>    #include <netinet/tcp.h>
>>   +#include <linux/falloc.h>
>>    #include <linux/if_packet.h>
>>    #include <linux/netlink.h>
>>    #include <sched.h>
>>
>>   Then trying qemu-riscv32 with a simple ELF, I get:
>>   linux-user/elfload.c:2341: pgb_reserved_va: Assertion `addr =3D=3D tes=
t'
>> failed.
>>
>>   strace shows that:
>>   mmap(0x1000, 4294963200, PROT_NONE,
>> MAP_PRIVATE|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) =3D 0x10000
>>   write(2, "qemu-riscv32: ../qemu.git/linux-"..., 103qemu-riscv32:
>> ../qemu.git/linux-user/elfload.c:2341: pgb_reserved_va: Assertion `addr =
=3D=3D
>> test' failed.
>>   ) =3D 103
>>
>>   The source code is in the function pgb_reserved_va (linux-
>>   user/elfload.c). I think mmap cannot guarantee that the returned
>>   pointer (test) equals to the parameter of addr. So is this a bug to
>>   assert (addr =3D=3D test)?
>>
>>   Attached configure script and test ELF file.
>>
>>   Thanks.
>>
>> To manage notifications about this bug go to:
>> https://bugs.launchpad.net/qemu/+bug/1895080/+subscriptions
>>


--=20
Alex Benn=C3=A9e


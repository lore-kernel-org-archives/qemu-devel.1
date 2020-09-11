Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52285C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 14:48:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1741223BD
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 14:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wRuHjmDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1741223BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGkLY-0004bs-Jq
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 10:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kGkKR-0003lJ-1A
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 10:47:07 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44519)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kGkKO-00075X-LE
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 10:47:06 -0400
Received: by mail-wr1-x444.google.com with SMTP id s12so11731066wrw.11
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 07:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Ea76MJ47jAYiA6wXyZ/DEkVFDAARxGqrNURaYM66h3g=;
 b=wRuHjmDobcDXeA8JOzGC+xNdm1AD5UbmLcZWr84Uotlyz7nuHhYXlya+Rw0B0+wjTs
 U1meiHKQGWmyPj0vQBI8hKzC5XdeS8YBNAzh6NVQvt75IxpmpKIpuA6Xus0jSeSp36y0
 oVDtdzxtKD6wmunOdobDEKdE+H4+423boUBkIs07NETE48qnmYqjRM8S2T5fKziBAtsR
 H9Se5gEydyP3zqz96ZBhsYh/2Je+8WPPp40Cek/faGCXxoX+qOv6SLf+lZo+ILZHUM6E
 joBQX063z96ZLTaB6GGmklxqWkDQKhwRZDi4fb8se88SiZkMIbxvY8t9JKcuEdTzoQl2
 hHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Ea76MJ47jAYiA6wXyZ/DEkVFDAARxGqrNURaYM66h3g=;
 b=Oc0ODDoKzAomMLDilH2lEnO68K5jJBLBvgdy5y+GonNygcam6LXPi7CKLfQJT7xQ5Y
 T35pvNaO2IsndG0iy76K6Ntav6kw4kC7p5MuOG/+vvEQFOC6mhYMKU3I6Z4JITzS+sLg
 Zjsczc+PHhERjG2OhrG9FDIKLuaLCNHhDs/mx9dj31P37I15sOKF+gjx/wLjbkDrUYt/
 DqEtdhb2rFLYteER6NfEUnEVu27+OZ6H09l5SV6IhEdQ2OQGMGX2wyK5gQi9U7zp/Mqv
 OuMPpWRp7DePCFiHLRwrhanNB4sXvvyunXZngnGihuLEV47OWMIx4572Nrfeidjylclq
 GIPg==
X-Gm-Message-State: AOAM5322J+m4ONijeCtarIr6Xr8LVAKUiWpOciHSmVZmvY8y4/XMNzNn
 Q154TfqoUdktFDFtKtfevwBMvQ==
X-Google-Smtp-Source: ABdhPJzpESWA5nu4VwgbB25PZDeK7AEiy/hQqMsuSYff6mFpduI7zQePo8xab/P/jCu1nYV4XiOp3g==
X-Received: by 2002:adf:f585:: with SMTP id f5mr2565615wro.64.1599835622297;
 Fri, 11 Sep 2020 07:47:02 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m3sm5021599wrs.83.2020.09.11.07.47.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2020 07:47:01 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6DC491FF7E;
 Fri, 11 Sep 2020 15:47:00 +0100 (BST)
References: <159970958159.31371.12301700684467003959.malonedeb@wampee.canonical.com>
 <92de5ee0-629a-640a-d547-8c2d650742f2@vivier.eu>
 <87tuw4odwk.fsf@linaro.org> <87r1r8odph.fsf@linaro.org>
 <CAGTPX+DAoJcw2y9gPjkP6kGXEQW7=e1tohM8vND9j9Qtxuc5vw@mail.gmail.com>
 <87o8mco7el.fsf@linaro.org>
 <CAGTPX+Dacxwh8O7XE+6j5OE8gnFoN-2DYuCNDENVtWtbCkDa=Q@mail.gmail.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Bug 1895080 <1895080@bugs.launchpad.net>
Subject: Re: [Bug 1895080] [NEW] pgb_reserved_va: Assertion `addr == test'
 failed
In-reply-to: <CAGTPX+Dacxwh8O7XE+6j5OE8gnFoN-2DYuCNDENVtWtbCkDa=Q@mail.gmail.com>
Date: Fri, 11 Sep 2020 15:47:00 +0100
Message-ID: <87k0x0nzff.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
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

>> > No, it's not set by CentOS-7.5.
>> > Does it mean that we just cannot run the ELF in such a case? I've tried
>> > many times, the assert always fails. Maybe, we can blame CentOS-7.5.
>>
>> The trouble is without MAP_FIXED_NOREPLACE we are at the mercy of the
>> host kernel to allow the address request to be honoured. A plain
>> MAP_FIXED won't do as it can clober existing mappings. In theory a
>> suitable hole has been identified but sometimes the kernel makes a
>> decision to offset the suggested mapping for it's own reasons.
>>
>
> MAP_FIXED_NOREPLACE is quite a new feature.
>
>
>> > BTW: with the option "-p 65536", the case runs successfully.
>>
>> Hmm interesting. I wonder if we are seeing a fail due to mmap_min_addr?
>> What does:
>>
>>   /proc/sys/vm/mmap_min_addr
>>
>> give you on the system?
>>
>
> It gives me 4096. And guest_base has this value. Maybe that's the strange
> point. mmap_min_addr give us 0x1000. While we are requesting this address,
> the kernel gives us 0x10000.

Yeah the meaning of mmap_min_addr should be exactly that which is odd
why the kernel doesn't honour the request. That said it seems to be a
user tweakable knob so you could just up it.

>>
>> You can manually set the reserved_va and the base address using -R and
>> -B although that is more of a developer work around. I think moving the
>> assert to the condition above would be an improvement just because it
>> tells us what the requested base address was and what the kernel decided
>> to give us.
>>
>
> Setting guest_base with -B to 0x10000 works. Tried some -R values, no luc=
k.
> Agree to print a more hintful message.

OK - one other test you try is running inside a chroot which *does not*
have visibility of /proc. That will cause it to fall back to the old
probing technique of trying multiple mmap operations to find the hole. I
suspect that works because the attempt to map 0x1000 would fail the
check. The reason we default to probing /proc/self/map now is that brute
force technique falls over when trying to probe for a hole on 64 bit
systems, especially when built with stack protection/clang debug
instrumentation.

In the meantime I'll spin up a patch to improve the failure mode.

>
>
>>
>> >
>> > On Fri, Sep 11, 2020 at 5:50 PM Alex Benn=C3=A9e <1895080@bugs.launchp=
ad.net>
>> > wrote:
>> >
>> >> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>> >>
>> >> > Laurent Vivier <laurent@vivier.eu> writes:
>> >> >
>> >> <snip>
>> >> >>> Then trying qemu-riscv32 with a simple ELF, I get:
>> >> >>> linux-user/elfload.c:2341: pgb_reserved_va: Assertion `addr =3D=
=3D test'
>> >> failed.
>> >> >>>
>> >> >>> strace shows that:
>> >> >>> mmap(0x1000, 4294963200, PROT_NONE,
>> >> MAP_PRIVATE|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) =3D 0x10000
>> >> >>> write(2, "qemu-riscv32: ../qemu.git/linux-"..., 103qemu-riscv32:
>> >> ../qemu.git/linux-user/elfload.c:2341: pgb_reserved_va: Assertion `ad=
dr
>> =3D=3D
>> >> test' failed.
>> >> >>> ) =3D 103
>> >> >>>
>> >> >>> The source code is in the function pgb_reserved_va (linux-
>> >> >>> user/elfload.c). I think mmap cannot guarantee that the returned
>> >> pointer
>> >> >>> (test) equals to the parameter of addr. So is this a bug to assert
>> >> (addr
>> >> >>> =3D=3D test)?
>> >> >>
>> >> > I'm assuming CentOS 7.5 actually has a definition for
>> >> > MAP_FIXED_NOREPLACE which should ensure we get what we asked for -
>> >> > otherwise we are in the position of hoping the kernel honours what =
we
>> >> > asked for.
>> >>
>> >> Doh re-reading I see it's not set in the strace output. Maybe we shou=
ld
>> >> promote the assert case to the failure leg so we have:
>> >>
>> >>     if (addr =3D=3D MAP_FAILED || addr !=3D test) {
>> >>         error_report(...)
>> >>     }
>> >>
>> >> so we at least fail with a user friendly error rather than an abort?
>> >>
>> >> --
>> >> Alex Benn=C3=A9e
>> >>
>> >> --
>> >> You received this bug notification because you are subscribed to the =
bug
>> >> report.
>> >> https://bugs.launchpad.net/bugs/1895080
>> >>
>> >> Title:
>> >>   pgb_reserved_va: Assertion `addr =3D=3D test' failed
>> >>
>> >> Status in QEMU:
>> >>   New
>> >>
>> >> Bug description:
>> >>   This problem occurs on CentOS-7.5 (64-bit) with qemu-5.1.0, qemu he=
ad
>> >>   (commit 9435a8b3dd35f1f926f1b9127e8a906217a5518a) for riscv32-linux-
>> >>   user.
>> >>
>> >>   Firstly, compile fails:
>> >>   Compiling C object
>> libqemu-riscv32-linux-user.fa.p/linux-user_strace.c.o
>> >>   ../qemu.git/linux-user/strace.c:1210:18: error: =E2=80=98FALLOC_FL_=
KEEP_SIZE=E2=80=99
>> >> undeclared here (not in a function)
>> >>        FLAG_GENERIC(FALLOC_FL_KEEP_SIZE),
>> >>
>> >>   I have to add below include to linux-user/strace.c
>> >>   diff --git a/linux-user/strace.c b/linux-user/strace.c
>> >>   index 11fea14fba..22e51d4a8a 100644
>> >>   --- a/linux-user/strace.c
>> >>   +++ b/linux-user/strace.c
>> >>   @@ -7,6 +7,7 @@
>> >>    #include <sys/mount.h>
>> >>    #include <arpa/inet.h>
>> >>    #include <netinet/tcp.h>
>> >>   +#include <linux/falloc.h>
>> >>    #include <linux/if_packet.h>
>> >>    #include <linux/netlink.h>
>> >>    #include <sched.h>
>> >>
>> >>   Then trying qemu-riscv32 with a simple ELF, I get:
>> >>   linux-user/elfload.c:2341: pgb_reserved_va: Assertion `addr =3D=3D =
test'
>> >> failed.
>> >>
>> >>   strace shows that:
>> >>   mmap(0x1000, 4294963200, PROT_NONE,
>> >> MAP_PRIVATE|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) =3D 0x10000
>> >>   write(2, "qemu-riscv32: ../qemu.git/linux-"..., 103qemu-riscv32:
>> >> ../qemu.git/linux-user/elfload.c:2341: pgb_reserved_va: Assertion `ad=
dr
>> =3D=3D
>> >> test' failed.
>> >>   ) =3D 103
>> >>
>> >>   The source code is in the function pgb_reserved_va (linux-
>> >>   user/elfload.c). I think mmap cannot guarantee that the returned
>> >>   pointer (test) equals to the parameter of addr. So is this a bug to
>> >>   assert (addr =3D=3D test)?
>> >>
>> >>   Attached configure script and test ELF file.
>> >>
>> >>   Thanks.
>> >>
>> >> To manage notifications about this bug go to:
>> >> https://bugs.launchpad.net/qemu/+bug/1895080/+subscriptions
>> >>
>>
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


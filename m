Received: from eggs.gnu.org ([2001:4830:134:3::10]:44160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dcWra-0005J1-0E
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:05:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dcWrX-0008Or-CB
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:05:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60851)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dcWrX-0008Nq-5Z
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:05:27 -0400
References: <20170726084153.10121-1-maozy.fnst@cn.fujitsu.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <22692d29-fede-58cc-de75-c3420d768a43@redhat.com>
Date: Tue, 1 Aug 2017 15:05:23 +0200
MIME-Version: 1.0
In-Reply-To: <20170726084153.10121-1-maozy.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] hw/scsi/vmw_pvscsi: Remove the dead
 error handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry@daynix.com>, Markus Armbruster <armbru@redhat.com>

On 26/07/2017 10:41, Mao Zhongyi wrote:
> qemu_bh_new() is a wrapper around aio_bh_new(), which returns
> null only when g_new() does. It doesn't. So remove the dead
> error handling.
> 
> Cc: Dmitry Fleytman <dmitry@daynix.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> ---
>  hw/scsi/vmw_pvscsi.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
> index 4a106da..d92973e 100644
> --- a/hw/scsi/vmw_pvscsi.c
> +++ b/hw/scsi/vmw_pvscsi.c
> @@ -1138,10 +1138,6 @@ pvscsi_init(PCIDevice *pci_dev)
>      }
>  
>      s->completion_worker = qemu_bh_new(pvscsi_process_completion_queue, s);
> -    if (!s->completion_worker) {
> -        pvscsi_cleanup_msi(s);
> -        return -ENOMEM;
> -    }
>  
>      scsi_bus_new(&s->bus, sizeof(s->bus), DEVICE(pci_dev),
>                   &pvscsi_scsi_info, NULL);
> 


Queued both patches, thanks.

Paolo

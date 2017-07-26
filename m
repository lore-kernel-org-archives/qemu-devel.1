Received: from eggs.gnu.org ([2001:4830:134:3::10]:34422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1daIvR-0003xK-JD
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 05:48:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1daIvN-0000qm-A6
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 05:48:17 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:37951)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dmitry@daynix.com>) id 1daIvM-0000qW-W2
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 05:48:13 -0400
Received: by mail-wm0-x234.google.com with SMTP id m85so62580285wma.1
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 02:48:12 -0700 (PDT)
From: Dmitry Fleytman <dmitry@daynix.com>
Message-Id: <F5CEF1B2-1B92-49AB-AC20-8B451BC02740@daynix.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Wed, 26 Jul 2017 12:48:10 +0300
In-Reply-To: <20170726084153.10121-1-maozy.fnst@cn.fujitsu.com>
References: <20170726084153.10121-1-maozy.fnst@cn.fujitsu.com>
Content-Type: text/plain;
	charset=us-ascii
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
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>


> On 26 Jul 2017, at 11:41 AM, Mao Zhongyi <maozy.fnst@cn.fujitsu.com> wrote:
> 
> qemu_bh_new() is a wrapper around aio_bh_new(), which returns
> null only when g_new() does. It doesn't. So remove the dead
> error handling.
> 

Acked-by: Dmitry Fleytman <dmitry@daynix.com <mailto:dmitry@daynix.com>>


> Cc: Dmitry Fleytman <dmitry@daynix.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> ---
> hw/scsi/vmw_pvscsi.c | 4 ----
> 1 file changed, 4 deletions(-)
> 
> diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
> index 4a106da..d92973e 100644
> --- a/hw/scsi/vmw_pvscsi.c
> +++ b/hw/scsi/vmw_pvscsi.c
> @@ -1138,10 +1138,6 @@ pvscsi_init(PCIDevice *pci_dev)
>     }
> 
>     s->completion_worker = qemu_bh_new(pvscsi_process_completion_queue, s);
> -    if (!s->completion_worker) {
> -        pvscsi_cleanup_msi(s);
> -        return -ENOMEM;
> -    }
> 
>     scsi_bus_new(&s->bus, sizeof(s->bus), DEVICE(pci_dev),
>                  &pvscsi_scsi_info, NULL);
> -- 
> 2.9.4
> 
> 
> 

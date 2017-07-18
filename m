Received: from eggs.gnu.org ([2001:4830:134:3::10]:41000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dXTqn-000791-Ff
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:51:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dXTqj-0006Ip-Dt
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:51:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dXTqj-0006HO-7q
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:51:45 -0400
References: <20170718142455.32676-1-cohuck@redhat.com>
	<20170718142455.32676-10-cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <bdde63a3-8432-1a66-dcce-9a45be0a472b@redhat.com>
Date: Tue, 18 Jul 2017 16:51:41 +0200
MIME-Version: 1.0
In-Reply-To: <20170718142455.32676-10-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v2 9/9] s390x: refine pci dependencies
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com

On 18.07.2017 16:24, Cornelia Huck wrote:
> VIRTIO_PCI should properly depend on CONFIG_PCI.
> With this change, we can switch off pci for s390x by removing
> 'CONFIG_PCI=y' from the default config.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  default-configs/s390x-softmmu.mak | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/default-configs/s390x-softmmu.mak b/default-configs/s390x-softmmu.mak
> index b227a36179..7adaa4a4fe 100644
> --- a/default-configs/s390x-softmmu.mak
> +++ b/default-configs/s390x-softmmu.mak
> @@ -1,5 +1,5 @@
>  CONFIG_PCI=y
> -CONFIG_VIRTIO_PCI=y
> +CONFIG_VIRTIO_PCI=$(CONFIG_PCI)
>  CONFIG_VHOST_USER_SCSI=$(CONFIG_LINUX)
>  CONFIG_VIRTIO=y
>  CONFIG_SCLPCONSOLE=y

Reviewed-by: Thomas Huth <thuth@redhat.com>

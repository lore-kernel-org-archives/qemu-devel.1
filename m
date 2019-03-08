Received: from eggs.gnu.org ([209.51.188.92]:43139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1h2JZt-0006oU-VV
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:46:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1h2JZs-0007JN-K5
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:46:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1h2JZp-0007FW-8i
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:46:34 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C29553092656
	for <qemu-devel@nongnu.org>; Fri,  8 Mar 2019 17:46:29 +0000 (UTC)
Date: Fri, 8 Mar 2019 10:46:28 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190308104628.2ab2b1e2@x1.home>
In-Reply-To: <20190308173622.21386-1-pbonzini@redhat.com>
References: <20190308173622.21386-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vfio-pci: enable by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On Fri,  8 Mar 2019 18:36:22 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> CONFIG_VFIO_PCI was not "default y" - and once you do that, it is also important
> to disable it if PCI is not there.
> 
> Reported-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/vfio/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Thanks Paolo!  FWIW...

Tested-by: Alex Williamson <alex.williamson@redhat.com>

> diff --git a/hw/vfio/Kconfig b/hw/vfio/Kconfig
> index ebda9fdf22..34da2a3cfd 100644
> --- a/hw/vfio/Kconfig
> +++ b/hw/vfio/Kconfig
> @@ -4,8 +4,9 @@ config VFIO
>  
>  config VFIO_PCI
>      bool
> +    default y
>      select VFIO
> -    depends on LINUX
> +    depends on LINUX && PCI
>  
>  config VFIO_CCW
>      bool

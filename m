Received: from eggs.gnu.org ([209.51.188.92]:38163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1h2vxO-0004Xo-6l
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 06:45:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1h2vmE-0000JX-Qy
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 06:33:55 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:37385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1h2vmE-0000JC-HG
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 06:33:54 -0400
Received: by mail-qt1-x844.google.com with SMTP id z17so2026469qtn.4
	for <qemu-devel@nongnu.org>; Sun, 10 Mar 2019 03:33:54 -0700 (PDT)
Received: from [192.168.15.40] ([191.193.152.252])
	by smtp.gmail.com with ESMTPSA id u13sm1796369qtb.2.2019.03.10.03.33.52
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 10 Mar 2019 03:33:52 -0700 (PDT)
References: <20190308173622.21386-1-pbonzini@redhat.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <bc54c197-b87c-c4a9-8c93-d32dafaa6e27@gmail.com>
Date: Sun, 10 Mar 2019 07:33:49 -0300
MIME-Version: 1.0
In-Reply-To: <20190308173622.21386-1-pbonzini@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: qemu-devel@nongnu.org

Just faced this problem when trying to test vfio-pci using upstream:

qemu-system-ppc64: -device vfio-pci,host=0035:03:00.0,id=hostdev8: 
'vfio-pci' is not a valid device model name


This patch fixed it.

Tested-by: Daniel Henrique Barboza <danielhb413@gmail.com>


On 3/8/19 2:36 PM, Paolo Bonzini wrote:
> CONFIG_VFIO_PCI was not "default y" - and once you do that, it is also important
> to disable it if PCI is not there.
>
> Reported-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/vfio/Kconfig | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/vfio/Kconfig b/hw/vfio/Kconfig
> index ebda9fdf22..34da2a3cfd 100644
> --- a/hw/vfio/Kconfig
> +++ b/hw/vfio/Kconfig
> @@ -4,8 +4,9 @@ config VFIO
>   
>   config VFIO_PCI
>       bool
> +    default y
>       select VFIO
> -    depends on LINUX
> +    depends on LINUX && PCI
>   
>   config VFIO_CCW
>       bool

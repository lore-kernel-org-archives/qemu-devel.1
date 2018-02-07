Received: from eggs.gnu.org ([2001:4830:134:3::10]:40147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ejUkk-0003tX-92
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:47:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ejUkg-0004iN-CB
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:47:30 -0500
References: <20180207155531.28446-1-cohuck@redhat.com>
	<20180207155531.28446-3-cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fa06df22-4a5e-813f-ad59-db36262ec21d@redhat.com>
Date: Wed, 7 Feb 2018 19:47:06 +0100
MIME-Version: 1.0
In-Reply-To: <20180207155531.28446-3-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] MAINTAINERS: reorganize s390-ccw bios
 maintainership
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, david@redhat.com

On 07.02.2018 16:55, Cornelia Huck wrote:
> Split it out from the s390-ccw-virtio machine, add Thomas as a
> maintainer in addition to Christian.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  MAINTAINERS | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e24273a574..bd2dc7ed7c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -855,15 +855,22 @@ F: hw/char/sclp*.[hc]
>  F: hw/char/terminal3270.c
>  F: hw/s390x/
>  F: include/hw/s390x/
> -F: pc-bios/s390-ccw/
>  F: hw/watchdog/wdt_diag288.c
>  F: include/hw/watchdog/wdt_diag288.h
> -F: pc-bios/s390-ccw.img
>  F: default-configs/s390x-softmmu.mak
>  T: git git://github.com/cohuck/qemu.git s390-next
>  T: git git://github.com/borntraeger/qemu.git s390-next
>  L: qemu-s390x@nongnu.org
>  
> +S390-ccw Bios
> +M: Christian Borntraeger <borntraeger@de.ibm.com>
> +M: Thomas Huth <thuth@redhat.com>
> +S: Supported
> +F: pc-bios/s390-ccw/
> +F: pc-bios/s390-ccw.img
> +T: git git://github.com/borntraeger/qemu.git s390-next
> +L: qemu-s390x@nongnu.org
> +
>  UniCore32 Machines
>  -------------
>  PKUnity-3 SoC initramfs-with-busybox
> 

Acked-by: Thomas Huth <thuth@redhat.com>

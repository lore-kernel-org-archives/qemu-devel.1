Received: from eggs.gnu.org ([2001:4830:134:3::10]:46005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fG20g-0005QQ-5X
	for qemu-devel@nongnu.org; Tue, 08 May 2018 08:46:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fG20c-0004EW-2A
	for qemu-devel@nongnu.org; Tue, 08 May 2018 08:46:26 -0400
Date: Tue, 8 May 2018 14:46:08 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180508144608.4c4e8180.cohuck@redhat.com>
In-Reply-To: <1525782303-16940-7-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1525782303-16940-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1525782303-16940-7-git-send-email-akrowiak@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 6/6] MAINTAINERS: add entries for AP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net

On Tue,  8 May 2018 08:25:03 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> Added entries for the s390 adjunct processor (AP) support.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> ---
>  MAINTAINERS |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 459e359..c9e8d7b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -82,6 +82,7 @@ S390
>  M: Cornelia Huck <cohuck@redhat.com>
>  S: Supported
>  F: default-configs/s390x-softmmu.mak
> +F: docs/vfio-ap.txt
>  F: gdb-xml/s390*.xml
>  F: hw/char/sclp*.[hc]
>  F: hw/char/terminal3270.c
> @@ -89,6 +90,7 @@ F: hw/intc/s390_flic.c
>  F: hw/intc/s390_flic_kvm.c
>  F: hw/s390x/
>  F: hw/vfio/ccw.c
> +F: hw/vfio/ap.c
>  F: hw/watchdog/wdt_diag288.c
>  F: include/hw/s390x/
>  F: include/hw/watchdog/wdt_diag288.h
> @@ -1152,6 +1154,18 @@ F: include/hw/s390x/s390-ccw.h
>  T: git git://github.com/cohuck/qemu.git s390-next
>  L: qemu-s390x@nongnu.org
>  
> +vfio-ap
> +M: Christian Borntraeger <borntraeger@de.ibm.com>
> +M: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> +M: Halil Pasic <pasic@linux.vnet.ibm.com>
> +M: Pierre Morel <pmorel@linux.vnet.ibm.com>

Dumb question: Aren't you folks dropping the 'vnet' part in the future?

> +S: Maintained
> +F: hw/vfio/ap.c
> +F: hw/s390x/ap-device.c
> +F: include/hw/s390x/ap-device.h
> +F: docs/vfio-ap.txt
> +L: qemu-s390x@nongnu.org
> +
>  vhost
>  M: Michael S. Tsirkin <mst@redhat.com>
>  S: Supported

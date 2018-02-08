Received: from eggs.gnu.org ([2001:4830:134:3::10]:33366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ejl9E-0001Y6-En
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 07:17:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ejl9A-000385-GT
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 07:17:52 -0500
References: <20180207155531.28446-1-cohuck@redhat.com>
	<20180207155531.28446-2-cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <6507139f-441c-d8f7-1c0b-c2878f736b01@redhat.com>
Date: Thu, 8 Feb 2018 13:17:36 +0100
MIME-Version: 1.0
In-Reply-To: <20180207155531.28446-2-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] MAINTAINERS: add myself as overall
 s390x maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, thuth@redhat.com

On 07.02.2018 16:55, Cornelia Huck wrote:
> All your mainframes are belong to me.

This looks like an easy way to get a lot of expensive hardware :)

> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  MAINTAINERS | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bbc3a617c2..e24273a574 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -76,6 +76,29 @@ K: ^Subject:.*(?i)trivial
>  T: git git://git.corpit.ru/qemu.git trivial-patches
>  T: git git://github.com/vivier/qemu.git trivial-patches
>  
> +Architecture support
> +--------------------
> +S390
> +M: Cornelia Huck <cohuck@redhat.com>
> +S: Supported
> +F: default-configs/s390x-softmmu.mak
> +F: gdb-xml/s390*.xml
> +F: hw/char/sclp*.[hc]
> +F: hw/char/terminal3270.c
> +F: hw/intc/s390_flic.c
> +F: hw/intc/s390_flic_kvm.c
> +F: hw/s390x/
> +F: hw/vfio/ccw.c
> +F: hw/watchdog/wdt_diag288.c
> +F: include/hw/s390x/
> +F: include/hw/watchdog/wdt_diag288.h
> +F: pc-bios/s390-ccw/
> +F: pc-bios/s390-ccw.img
> +F: target/s390x/
> +K: ^Subject:.*(?i)s390(x|)
> +T: git git://github.com/cohuck/qemu.git s390-next
> +L: qemu-s390x@nongnu.org
> +
>  Guest CPU cores (TCG):
>  ----------------------
>  Overall
> 


-- 

Thanks,

David / dhildenb

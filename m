Received: from eggs.gnu.org ([2001:4830:134:3::10]:54551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gJZHV-0003is-IT
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 02:26:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gJZHR-0002lz-AE
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 02:26:41 -0500
References: <1540827745-20795-1-git-send-email-borntraeger@de.ibm.com>
	<1540827745-20795-5-git-send-email-borntraeger@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2616fc3e-5ee1-cc8d-7a25-e664637f5a3f@redhat.com>
Date: Mon, 5 Nov 2018 08:26:29 +0100
MIME-Version: 1.0
In-Reply-To: <1540827745-20795-5-git-send-email-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/4] MAINTAINERS: s390/boot: the ipl code
 and the bios belong together
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, David Hildenbrand <david@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Janosch Frank <frankja@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Collin Walling <walling@linux.ibm.com>

On 2018-10-29 16:42, Christian Borntraeger wrote:
> The s390-ccw bios and the ipl code do work in lock-step. Let us merge
> them in the maintainer file.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e63cfa2..8ce223d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -946,10 +946,11 @@ T: git git://github.com/cohuck/qemu.git s390-next
>  T: git git://github.com/borntraeger/qemu.git s390-next
>  L: qemu-s390x@nongnu.org
>  
> -S390-ccw Bios
> +S390-ccw boot
>  M: Christian Borntraeger <borntraeger@de.ibm.com>
>  M: Thomas Huth <thuth@redhat.com>
>  S: Supported
> +F: hw/s390x/ipl.*
>  F: pc-bios/s390-ccw/
>  F: pc-bios/s390-ccw.img
>  T: git git://github.com/borntraeger/qemu.git s390-next
> 

Acked-by: Thomas Huth <thuth@redhat.com>

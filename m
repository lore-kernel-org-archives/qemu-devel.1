Received: from eggs.gnu.org ([209.51.188.92]:32996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gyHmd-0000qT-Bd
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:03:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gyHmb-0003aA-I1
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:03:07 -0500
References: <20190225142407.9477-1-muriloo@linux.ibm.com>
	<20190225142407.9477-3-muriloo@linux.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <664222ad-f92f-bbb5-6f6f-dea39b77cc52@redhat.com>
Date: Mon, 25 Feb 2019 09:02:57 -0600
MIME-Version: 1.0
In-Reply-To: <20190225142407.9477-3-muriloo@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] ppc/pnv: add INITRD_MAX_SIZE constant
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Murilo Opsfelder Araujo <mopsfelder@gmail.com>, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

On 2/25/19 8:24 AM, Murilo Opsfelder Araujo wrote:
> The current 0x10000000 value is actually 256MiB, not 128MB as the comment
> suggests. Move it to a constant and fix the comment (no change in the size
> value).
> 
> Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> ---
>  hw/ppc/pnv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 000707164e..514439db20 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -56,6 +56,7 @@
>  #define KERNEL_LOAD_ADDR        0x20000000
>  #define KERNEL_MAX_SIZE         0x10000000    /* 256MiB */
>  #define INITRD_LOAD_ADDR        0x60000000
> +#define INITRD_MAX_SIZE         0x10000000    /* 256MiB */

Why not #include "qemu/units.h" and spell this:

#define INITRD_MAX_SIZE (256 * MiB)

and so on for the other values?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

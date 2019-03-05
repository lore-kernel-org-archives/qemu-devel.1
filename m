Received: from eggs.gnu.org ([209.51.188.92]:45913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h14PK-0002FW-P4
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 02:22:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h14PJ-0000L9-WE
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 02:22:34 -0500
References: <1551466776-29123-1-git-send-email-jjherne@linux.ibm.com>
	<1551466776-29123-10-git-send-email-jjherne@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e6f488bd-a83d-c550-857b-f1cacf73eccd@redhat.com>
Date: Tue, 5 Mar 2019 08:22:23 +0100
MIME-Version: 1.0
In-Reply-To: <1551466776-29123-10-git-send-email-jjherne@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3 09/16] s390-bios: ptr2u32
 and u32toptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On 01/03/2019 19.59, Jason J. Herne wrote:
> Introduce inline functions to convert between pointers and unsigned 32-bit
> ints. These are used to hide the ugliness required to  avoid compiler
> warnings.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> Acked-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  pc-bios/s390-ccw/helper.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 pc-bios/s390-ccw/helper.h
> 
> diff --git a/pc-bios/s390-ccw/helper.h b/pc-bios/s390-ccw/helper.h
> new file mode 100644
> index 0000000..b8bc61b
> --- /dev/null
> +++ b/pc-bios/s390-ccw/helper.h
> @@ -0,0 +1,16 @@
> +#ifndef S390_CCW_HELPER_H
> +#define S390_CCW_HELPER_H
> +
> +/* Avoids compiler warnings when casting a pointer to a u32 */
> +static inline uint32_t ptr2u32(void *ptr)
> +{

Would it make sense to add an IPL_assert(ptr <= 0xffffffff) here?

> +    return (uint32_t)(uint64_t)ptr;
> +}
> +
> +/* Avoids compiler warnings when casting a u32 to a pointer */
> +static inline void *u32toptr(uint32_t n)
> +{
> +    return (void *)(uint64_t)n;
> +}
> +
> +#endif

Reviewed-by: Thomas Huth <thuth@redhat.com>

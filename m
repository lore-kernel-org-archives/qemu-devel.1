Received: from eggs.gnu.org ([209.51.188.92]:52819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gtXca-0004Yf-Jy
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 07:57:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gtXW1-0002JL-Hp
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 07:50:23 -0500
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
	<1548768562-20007-10-git-send-email-jjherne@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3cd7f6a5-ac0b-f945-358b-4838da0d8d9c@redhat.com>
Date: Tue, 12 Feb 2019 13:50:14 +0100
MIME-Version: 1.0
In-Reply-To: <1548768562-20007-10-git-send-email-jjherne@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 09/15] s390-bios: ptr2u32 and
 u32toptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On 2019-01-29 14:29, Jason J. Herne wrote:
> Introduce inline functions to convert between pointers and unsigned 32-bit
> ints. These are used to hide the ugliness required to  avoid compiler
> warnings.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/libc.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/pc-bios/s390-ccw/libc.h b/pc-bios/s390-ccw/libc.h
> index 818517f..e198f0b 100644
> --- a/pc-bios/s390-ccw/libc.h
> +++ b/pc-bios/s390-ccw/libc.h
> @@ -19,6 +19,18 @@ typedef unsigned short     uint16_t;
>  typedef unsigned int       uint32_t;
>  typedef unsigned long long uint64_t;
>  
> +/* Avoids compiler warnings when casting a pointer to a u32 */
> +static inline uint32_t ptr2u32(void *ptr)
> +{
> +    return (uint32_t)(uint64_t)ptr;
> +}
> +
> +/* Avoids compiler warnings when casting a u32 to a pointer */
> +static inline void *u32toptr(uint32_t n)
> +{
> +    return (void *)(uint64_t)n;
> +}

Could you please put this into another header? libc.h is for
standard-compliant libc functions, and these are no standard functions,
as far as I know.

 Thanks,
  Thomas

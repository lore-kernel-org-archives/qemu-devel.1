Received: from eggs.gnu.org ([2001:4830:134:3::10]:34691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gXnGW-0008T7-DL
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:12:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gXnGS-0002aO-0C
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:12:28 -0500
References: <1544792887-14575-1-git-send-email-thuth@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <4c36a841-ac16-8d93-b23f-8df80e79579c@redhat.com>
Date: Fri, 14 Dec 2018 14:12:17 +0100
MIME-Version: 1.0
In-Reply-To: <1544792887-14575-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/s390x: Fix bad mask in time2tod()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-stable@nongnu.org

On 14.12.18 14:08, Thomas Huth wrote:
> The time2tod() function tries to deal with the 9 uppermost bits in the
> time value, but uses the wrong mask for this: 0xff80000000000000 should
> be used instead of 0xff10000000000000 here.
> 
> Fixes: 14055ce53c2d901d826ffad7fb7d6bb8ab46bdfd
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  include/hw/s390x/tod.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/s390x/tod.h b/include/hw/s390x/tod.h
> index cbd7552..47ef9de 100644
> --- a/include/hw/s390x/tod.h
> +++ b/include/hw/s390x/tod.h
> @@ -56,7 +56,7 @@ typedef struct S390TODClass {
>  /* Converts ns to s390's clock format */
>  static inline uint64_t time2tod(uint64_t ns)
>  {
> -    return (ns << 9) / 125 + (((ns & 0xff10000000000000ull) / 125) << 9);
> +    return (ns << 9) / 125 + (((ns & 0xff80000000000000ull) / 125) << 9);
>  }
>  
>  /* Converts s390's clock format to ns */
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb

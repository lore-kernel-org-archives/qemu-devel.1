Received: from eggs.gnu.org ([2001:4830:134:3::10]:57451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fIsrI-00024Y-S2
	for qemu-devel@nongnu.org; Wed, 16 May 2018 05:36:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fIsrF-0004PY-Mh
	for qemu-devel@nongnu.org; Wed, 16 May 2018 05:36:32 -0400
References: <1525774672-11913-1-git-send-email-thuth@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <6884ca18-75ed-d386-c63c-03db269fffd6@redhat.com>
Date: Wed, 16 May 2018 11:36:27 +0200
MIME-Version: 1.0
In-Reply-To: <1525774672-11913-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] pc-bios/s390-ccw: struct
 tpi_info must be declared as aligned(4)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org

On 08.05.2018 12:17, Thomas Huth wrote:
> I've run into a compilation error today with the current version of GCC 8:
> 
> In file included from s390-ccw.h:49,
>                  from main.c:12:
> cio.h:128:1: error: alignment 1 of 'struct tpi_info' is less than 4 [-Werror=packed-not-aligned]
>  } __attribute__ ((packed));
>  ^
> cc1: all warnings being treated as errors
> 
> Since the struct tpi_info contains an element ("struct subchannel_id schid")
> which is marked as aligned(4), we've got to mark the struct tpi_info as
> aligned(4), too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  pc-bios/s390-ccw/cio.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/pc-bios/s390-ccw/cio.h b/pc-bios/s390-ccw/cio.h
> index 55eaeee..1a0795f 100644
> --- a/pc-bios/s390-ccw/cio.h
> +++ b/pc-bios/s390-ccw/cio.h
> @@ -125,7 +125,7 @@ struct tpi_info {
>      __u32 reserved3  : 12;
>      __u32 int_type   : 3;
>      __u32 reserved4  : 12;
> -} __attribute__ ((packed));
> +} __attribute__ ((packed, aligned(4)));
>  
>  /* channel command word (type 1) */
>  struct ccw1 {
> 

Late but still
Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb

Received: from eggs.gnu.org ([2001:4830:134:3::10]:52817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eKPqA-0003vu-Lr
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 09:29:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eKPq5-0000Qy-L9
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 09:29:26 -0500
References: <20171130140536.31164-1-cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <cde3b71f-3760-5eb7-cfdb-35dd1cd356c8@redhat.com>
Date: Thu, 30 Nov 2017 15:29:14 +0100
MIME-Version: 1.0
In-Reply-To: <20171130140536.31164-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/s390x: nuke DPRINTF in helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: rth@twiddle.net, agraf@suse.de, borntraeger@de.ibm.com, thuth@redhat.com

On 30.11.2017 15:05, Cornelia Huck wrote:
> It is not used anywhere.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  target/s390x/helper.c | 18 ------------------
>  1 file changed, 18 deletions(-)
> 
> diff --git a/target/s390x/helper.c b/target/s390x/helper.c
> index 246ba20f0d..35d9741918 100644
> --- a/target/s390x/helper.c
> +++ b/target/s390x/helper.c
> @@ -31,24 +31,6 @@
>  #include "sysemu/sysemu.h"
>  #endif
>  
> -//#define DEBUG_S390
> -//#define DEBUG_S390_STDOUT
> -
> -#ifdef DEBUG_S390
> -#ifdef DEBUG_S390_STDOUT
> -#define DPRINTF(fmt, ...) \
> -    do { fprintf(stderr, fmt, ## __VA_ARGS__); \
> -         if (qemu_log_separate()) qemu_log(fmt, ##__VA_ARGS__); } while (0)
> -#else
> -#define DPRINTF(fmt, ...) \
> -    do { qemu_log(fmt, ## __VA_ARGS__); } while (0)
> -#endif
> -#else
> -#define DPRINTF(fmt, ...) \
> -    do { } while (0)
> -#endif
> -
> -
>  #ifndef CONFIG_USER_ONLY
>  void s390x_tod_timer(void *opaque)
>  {
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb

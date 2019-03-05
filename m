Received: from eggs.gnu.org ([209.51.188.92]:59811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h12zK-0002sW-73
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 00:51:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h12zJ-0005RY-8c
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 00:51:38 -0500
References: <1551466776-29123-1-git-send-email-jjherne@linux.ibm.com>
	<1551466776-29123-7-git-send-email-jjherne@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e3f0d9ab-c98b-d500-12e6-cfcc1a2b2a1b@redhat.com>
Date: Tue, 5 Mar 2019 06:51:32 +0100
MIME-Version: 1.0
In-Reply-To: <1551466776-29123-7-git-send-email-jjherne@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3 06/16] s390-bios: Clean up
 cio.h
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
> Add proper typedefs to all structs and modify all bit fields to use consistent
> formatting.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> Reviewed-by: Collin Walling <walling@linux.ibm.com>
> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/cio.h      | 152 ++++++++++++++++++++++----------------------
>  pc-bios/s390-ccw/s390-ccw.h |   8 ---
>  2 files changed, 76 insertions(+), 84 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/cio.h b/pc-bios/s390-ccw/cio.h
> index 1a0795f..2f58256 100644
> --- a/pc-bios/s390-ccw/cio.h
> +++ b/pc-bios/s390-ccw/cio.h
[...]
> -struct subchannel_id {
> -        __u32 cssid  : 8;
> -        __u32        : 4;
> -        __u32 m      : 1;
> -        __u32 ssid   : 2;
> -        __u32 one    : 1;
> -        __u32 sch_no : 16;
> -} __attribute__ ((packed, aligned(4)));
> +} __attribute__ ((packed, aligned(4))) Schib;
> +
> +typedef struct subchannel_id {
> +        __u32 cssid:8;
> +        __u32:4;

__u32:4 looks a little bit funny. Not sure, but maybe this should be
given a name like "reserved" or so?

> +        __u32 m:1;
> +        __u32 ssid:2;
> +        __u32 one:1;
> +        __u32 sch_no:16;
> +} __attribute__ ((packed, aligned(4))) SubChannelId;
>  
>  struct chsc_header {
>      __u16 length;
>      __u16 code;
>  } __attribute__((packed));
[...]
> @@ -162,27 +162,27 @@ struct ccw1 {
>  /*
>   * Command-mode operation request block
>   */
> -struct cmd_orb {
> -    __u32 intparm;    /* interruption parameter */
> -    __u32 key:4;      /* flags, like key, suspend control, etc. */
> -    __u32 spnd:1;     /* suspend control */
> -    __u32 res1:1;     /* reserved */
> -    __u32 mod:1;      /* modification control */
> -    __u32 sync:1;     /* synchronize control */
> -    __u32 fmt:1;      /* format control */
> -    __u32 pfch:1;     /* prefetch control */
> -    __u32 isic:1;     /* initial-status-interruption control */
> -    __u32 alcc:1;     /* address-limit-checking control */
> -    __u32 ssic:1;     /* suppress-suspended-interr. control */
> -    __u32 res2:1;     /* reserved */
> -    __u32 c64:1;      /* IDAW/QDIO 64 bit control  */
> -    __u32 i2k:1;      /* IDAW 2/4kB block size control */
> -    __u32 lpm:8;      /* logical path mask */
> -    __u32 ils:1;      /* incorrect length */
> -    __u32 zero:6;     /* reserved zeros */
> -    __u32 orbx:1;     /* ORB extension control */
> -    __u32 cpa;    /* channel program address */
> -}  __attribute__ ((packed, aligned(4)));
> +typedef struct cmd_orb {
> +    __u32 intparm;  /* interruption parameter */
> +    __u32 key:4;    /* flags, like key, suspend control, etc. */
> +    __u32 spnd:1;   /* suspend control */
> +    __u32 res1:1;   /* reserved */
> +    __u32 mod:1;    /* modification control */
> +    __u32 sync:1;   /* synchronize control */
> +    __u32 fmt:1;    /* format control */
> +    __u32 pfch:1;   /* prefetch control */
> +    __u32 isic:1;   /* initial-status-interruption control */
> +    __u32 alcc:1;   /* address-limit-checking control */
> +    __u32 ssic:1;   /* suppress-suspended-interr. control */
> +    __u32 res2:1;   /* reserved */
> +    __u32 c64:1;    /* IDAW/QDIO 64 bit control  */
> +    __u32 i2k:1;    /* IDAW 2/4kB block size control */
> +    __u32 lpm:8;    /* logical path mask */
> +    __u32 ils:1;    /* incorrect length */
> +    __u32 zero:6;   /* reserved zeros */
> +    __u32 orbx:1;   /* ORB extension control */
> +    __u32 cpa;      /* channel program address */
> +}  __attribute__ ((packed, aligned(4))) CmdOrb;

The white space changes to this struct look like unnecessary code churn
to me ... I'd like to suggest to keep the comments at the old
indentation level.

With that fixed:

Reviewed-by: Thomas Huth <thuth@redhat.com>

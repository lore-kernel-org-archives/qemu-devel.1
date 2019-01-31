Received: from eggs.gnu.org ([209.51.188.92]:37763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1gpDFn-0000Tr-O5
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 09:23:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1gpDFl-0000Io-Ck
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 09:23:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54760
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1gpDFk-0000Fd-Rp
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 09:23:41 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0VEK7vs124486
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 09:23:35 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qc1pvbfub-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 09:23:35 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Thu, 31 Jan 2019 14:23:34 -0000
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
	<1548768562-20007-7-git-send-email-jjherne@linux.ibm.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Thu, 31 Jan 2019 09:23:30 -0500
MIME-Version: 1.0
In-Reply-To: <1548768562-20007-7-git-send-email-jjherne@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <79bf1c26-0271-3d92-d2a9-d63a924faccc@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 06/15] s390-bios: Clean up cio.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com



On 01/29/2019 08:29 AM, Jason J. Herne wrote:
> Add proper typedefs to all structs and modify all bit fields to use consistent
> formatting.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> Reviewed-by: Collin Walling <walling@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/cio.h      | 86 ++++++++++++++++++++++-----------------------
>   pc-bios/s390-ccw/s390-ccw.h |  8 -----
>   2 files changed, 43 insertions(+), 51 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/cio.h b/pc-bios/s390-ccw/cio.h
> index 1a0795f..a48eee5 100644
> --- a/pc-bios/s390-ccw/cio.h
> +++ b/pc-bios/s390-ccw/cio.h
> @@ -53,12 +53,12 @@ struct schib_config {
>       __u64 mba;
>       __u32 intparm;
>       __u16 mbi;
> -    __u32 isc:3;
> -    __u32 ena:1;
> -    __u32 mme:2;
> -    __u32 mp:1;
> -    __u32 csense:1;
> -    __u32 mbfc:1;
> +    __u32 isc    : 3;
> +    __u32 ena    : 1;
> +    __u32 mme    : 2;
> +    __u32 mp     : 1;
> +    __u32 csense : 1;
> +    __u32 mbfc   : 1;
>   } __attribute__ ((packed));
>   
>   struct scsw {
> @@ -77,41 +77,41 @@ struct scsw {
>   /*
>    * subchannel information block
>    */
> -struct schib {
> +typedef struct schib {
>       struct pmcw pmcw;     /* path management control word */
>       struct scsw scsw;     /* subchannel status word */
>       __u64 mba;            /* measurement block address */
>       __u8 mda[4];          /* model dependent area */
> -} __attribute__ ((packed,aligned(4)));
> +} __attribute__ ((packed, aligned(4))) Schib;
>   
> -struct subchannel_id {
> +typedef struct subchannel_id {
>           __u32 cssid  : 8;
>           __u32        : 4;
>           __u32 m      : 1;
>           __u32 ssid   : 2;
>           __u32 one    : 1;
>           __u32 sch_no : 16;
> -} __attribute__ ((packed, aligned(4)));
> +} __attribute__ ((packed, aligned(4))) SubChannelId;
>   
>   struct chsc_header {
>       __u16 length;
>       __u16 code;
>   } __attribute__((packed));
>   
> -struct chsc_area_sda {
> +typedef struct chsc_area_sda {
>       struct chsc_header request;
> -    __u8 reserved1:4;
> -    __u8 format:4;
> +    __u8 reserved1  : 4;
> +    __u8 format     : 4;
>       __u8 reserved2;
>       __u16 operation_code;
>       __u32 reserved3;
>       __u32 reserved4;
>       __u32 operation_data_area[252];
>       struct chsc_header response;
> -    __u32 reserved5:4;
> -    __u32 format2:4;
> -    __u32 reserved6:24;
> -} __attribute__((packed));
> +    __u32 reserved5 : 4;
> +    __u32 format2   : 4;
> +    __u32 reserved6 : 24;
> +} __attribute__((packed)) ChscAreaSda;
>   
>   /*
>    * TPI info structure
> @@ -128,12 +128,12 @@ struct tpi_info {
>   } __attribute__ ((packed, aligned(4)));
>   
>   /* channel command word (type 1) */
> -struct ccw1 {
> +typedef struct ccw1 {
>       __u8 cmd_code;
>       __u8 flags;
>       __u16 count;
>       __u32 cda;
> -} __attribute__ ((packed, aligned(8)));
> +} __attribute__ ((packed, aligned(8))) Ccw1;
>   
>   #define CCW_FLAG_DC              0x80
>   #define CCW_FLAG_CC              0x40
> @@ -162,27 +162,27 @@ struct ccw1 {
>   /*
>    * Command-mode operation request block
>    */
> -struct cmd_orb {
> +typedef struct cmd_orb {
>       __u32 intparm;    /* interruption parameter */
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
> +    __u32 key  : 4;   /* flags, like key, suspend control, etc. */
> +    __u32 spnd : 1;   /* suspend control */
> +    __u32 res1 : 1;   /* reserved */
> +    __u32 mod  : 1;   /* modification control */
> +    __u32 sync : 1;   /* synchronize control */
> +    __u32 fmt  : 1;   /* format control */
> +    __u32 pfch : 1;   /* prefetch control */
> +    __u32 isic : 1;   /* initial-status-interruption control */
> +    __u32 alcc : 1;   /* address-limit-checking control */
> +    __u32 ssic : 1;   /* suppress-suspended-interr. control */
> +    __u32 res2 : 1;   /* reserved */
> +    __u32 c64  : 1;   /* IDAW/QDIO 64 bit control  */
> +    __u32 i2k  : 1;   /* IDAW 2/4kB block size control */
> +    __u32 lpm  : 8;   /* logical path mask */
> +    __u32 ils  : 1;   /* incorrect length */
> +    __u32 zero : 6;   /* reserved zeros */
> +    __u32 orbx : 1;   /* ORB extension control */
> +    __u32 cpa;        /* channel program address */
> +}  __attribute__ ((packed, aligned(4))) CmdOrb;
>   
>   struct ciw {
>       __u8 type;
> @@ -193,7 +193,7 @@ struct ciw {
>   /*
>    * sense-id response buffer layout
>    */
> -struct senseid {
> +typedef struct senseid {
>       /* common part */
>       __u8  reserved;   /* always 0x'FF' */
>       __u16 cu_type;    /* control unit type */
> @@ -203,15 +203,15 @@ struct senseid {
>       __u8  unused;     /* padding byte */
>       /* extended part */
>       struct ciw ciw[62];
> -}  __attribute__ ((packed, aligned(4)));
> +}  __attribute__ ((packed, aligned(4))) SenseId;
>   
>   /* interruption response block */
> -struct irb {
> +typedef struct irb {
>       struct scsw scsw;
>       __u32 esw[5];
>       __u32 ecw[8];
>       __u32 emw[8];
> -}  __attribute__ ((packed, aligned(4)));
> +}  __attribute__ ((packed, aligned(4))) Irb;
>   
>   /*
>    * Some S390 specific IO instructions as inline
> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
> index 9828aa2..241c6d0 100644
> --- a/pc-bios/s390-ccw/s390-ccw.h
> +++ b/pc-bios/s390-ccw/s390-ccw.h
> @@ -49,14 +49,6 @@ typedef unsigned long long __u64;
>   #include "cio.h"
>   #include "iplb.h"
>   
> -typedef struct irb Irb;
> -typedef struct ccw1 Ccw1;
> -typedef struct cmd_orb CmdOrb;
> -typedef struct schib Schib;
> -typedef struct chsc_area_sda ChscAreaSda;
> -typedef struct senseid SenseId;
> -typedef struct subchannel_id SubChannelId;
> -
>   /* start.s */
>   void disabled_wait(void);
>   void consume_sclp_int(void);
> 


Reviewed-by: Farhan Ali <alifm@linux.ibm.com>

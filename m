Received: from eggs.gnu.org ([209.51.188.92]:34382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gx8wd-0006Wj-J5
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 06:24:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gx8wc-0006m1-2P
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 06:24:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52001
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1gx8wa-0006OE-HJ
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 06:24:41 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1MBOJLC119762
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 06:24:23 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qtf6e30fm-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 06:24:22 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 22 Feb 2019 11:24:12 -0000
References: <20190222081153.14206-1-david@redhat.com>
	<20190222081153.14206-3-david@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 22 Feb 2019 12:24:06 +0100
MIME-Version: 1.0
In-Reply-To: <20190222081153.14206-3-david@redhat.com>
Content-Language: en-US
Message-Id: <b57d9722-9c1a-bdd3-78de-f8df221bab3f@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 2/3] s390x: use a
 QEMU-style typedef + name for SIGP save area struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>



On 22.02.2019 09:11, David Hildenbrand wrote:
> Convert this to QEMU style.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

> ---
>  target/s390x/helper.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/target/s390x/helper.c b/target/s390x/helper.c
> index f3fcf96482..a7edd5df7d 100644
> --- a/target/s390x/helper.c
> +++ b/target/s390x/helper.c
> @@ -211,7 +211,7 @@ void s390_cpu_recompute_watchpoints(CPUState *cs)
>      }
>  }
>  
> -struct sigp_save_area {
> +typedef struct SigpSaveArea {
>      uint64_t    fprs[16];                       /* 0x0000 */
>      uint64_t    grs[16];                        /* 0x0080 */
>      PSW         psw;                            /* 0x0100 */
> @@ -225,13 +225,13 @@ struct sigp_save_area {
>      uint8_t     pad_0x0138[0x0140 - 0x0138];    /* 0x0138 */
>      uint32_t    ars[16];                        /* 0x0140 */
>      uint64_t    crs[16];                        /* 0x0384 */
> -};
> -QEMU_BUILD_BUG_ON(sizeof(struct sigp_save_area) != 512);
> +} SigpSaveArea;
> +QEMU_BUILD_BUG_ON(sizeof(SigpSaveArea) != 512);
>  
>  int s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch)
>  {
>      static const uint8_t ar_id = 1;
> -    struct sigp_save_area *sa;
> +    SigpSaveArea *sa;
>      hwaddr len = sizeof(*sa);
>      int i;
>  
> 

Received: from eggs.gnu.org ([209.51.188.92]:48199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gt6pu-0003K7-Bp
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 03:21:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gt6pq-0005FP-M6
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 03:21:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53588)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1gt6pm-0005BL-Uk
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 03:21:01 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1B8Knjc024376
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 03:20:57 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qk507s9x2-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 03:20:53 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 11 Feb 2019 08:19:58 -0000
References: <20190208221111.25237-1-walling@linux.ibm.com>
	<20190208221111.25237-2-walling@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 11 Feb 2019 09:19:53 +0100
MIME-Version: 1.0
In-Reply-To: <20190208221111.25237-2-walling@linux.ibm.com>
Content-Language: en-US
Message-Id: <45dd2dde-4dff-1199-f26b-55fe1fe343dd@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 2/2] s390x/cpumodel: add z14
 GA2 model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pasic@linux.ibm.com, rth@twiddle.net, cohuck@redhat.com, david@redhat.com



On 08.02.2019 23:11, Collin Walling wrote:
> Introduce the z14 GA2 cpu model for QEMU. There are no new features
> introduced with this model, and will inherit the same feature set as
> z14 GA1.
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

> ---
>  target/s390x/cpu_models.c   | 1 +
>  target/s390x/gen-features.c | 7 +++++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 7c253ff308..968c21cd47 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -79,6 +79,7 @@ static S390CPUDef s390_cpu_defs[] = {
>      CPUDEF_INIT(0x2964, 13, 2, 47, 0x08000000U, "z13.2", "IBM z13 GA2"),
>      CPUDEF_INIT(0x2965, 13, 2, 47, 0x08000000U, "z13s", "IBM z13s GA1"),
>      CPUDEF_INIT(0x3906, 14, 1, 47, 0x08000000U, "z14", "IBM z14 GA1"),
> +    CPUDEF_INIT(0x3906, 14, 2, 47, 0x08000000U, "z14.2", "IBM z14 GA2"),
>      CPUDEF_INIT(0x3907, 14, 1, 47, 0x08000000U, "z14ZR1", "IBM z14 Model ZR1 GA1"),
>  };
>  
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index d258d67dca..3026fbd88e 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -353,6 +353,8 @@ static uint16_t base_GEN14_GA1[] = {
>      S390_FEAT_ORDER_PRESERVING_COMPRESSION,
>  };
>  
> +#define base_GEN14_GA2 EmptyFeat
> +
>  /* Full features (in order of release)
>   * Automatically includes corresponding base features.
>   * Full features are all features this hardware supports even if kvm/QEMU do not
> @@ -480,6 +482,8 @@ static uint16_t full_GEN14_GA1[] = {
>      S390_FEAT_GROUP_MULTIPLE_EPOCH_PTFF,
>  };
>  
> +#define full_GEN14_GA2 EmptyFeat
> +
>  /* Default features (in order of release)
>   * Automatically includes corresponding base features.
>   * Default features are all features this version of QEMU supports for this
> @@ -553,6 +557,8 @@ static uint16_t default_GEN14_GA1[] = {
>      S390_FEAT_MULTIPLE_EPOCH,
>  };
>  
> +#define default_GEN14_GA2 EmptyFeat
> +
>  /* QEMU (CPU model) features */
>  
>  static uint16_t qemu_V2_11[] = {
> @@ -661,6 +667,7 @@ static CpuFeatDefSpec CpuFeatDef[] = {
>      CPU_FEAT_INITIALIZER(GEN13_GA1),
>      CPU_FEAT_INITIALIZER(GEN13_GA2),
>      CPU_FEAT_INITIALIZER(GEN14_GA1),
> +    CPU_FEAT_INITIALIZER(GEN14_GA2),
>  };
>  
>  #define FEAT_GROUP_INITIALIZER(_name)                  \
> 

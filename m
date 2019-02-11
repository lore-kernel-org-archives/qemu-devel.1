Received: from eggs.gnu.org ([209.51.188.92]:53089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gt7Ik-0001oB-JT
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 03:50:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gt7Ii-0002Vf-NL
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 03:50:54 -0500
References: <20190208221111.25237-1-walling@linux.ibm.com>
	<20190208221111.25237-2-walling@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <562f6aa7-dcc1-b913-86a2-3ed1e051c720@redhat.com>
Date: Mon, 11 Feb 2019 09:50:43 +0100
MIME-Version: 1.0
In-Reply-To: <20190208221111.25237-2-walling@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] s390x/cpumodel: add z14 GA2 model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, pasic@linux.ibm.com, rth@twiddle.net

On 08.02.19 23:11, Collin Walling wrote:
> Introduce the z14 GA2 cpu model for QEMU. There are no new features
> introduced with this model, and will inherit the same feature set as
> z14 GA1.
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
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

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb

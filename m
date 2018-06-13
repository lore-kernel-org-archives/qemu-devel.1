Received: from eggs.gnu.org ([2001:4830:134:3::10]:49930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fT38h-0006Ft-Bw
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 06:36:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fT38e-000820-9T
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 06:36:31 -0400
References: <20180613081819.147178-1-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <96496ca2-686c-d0f2-f55a-31468b7379f9@redhat.com>
Date: Wed, 13 Jun 2018 12:36:25 +0200
MIME-Version: 1.0
In-Reply-To: <20180613081819.147178-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x/cpumodels: add z14 Model ZR1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 13.06.2018 10:18, Christian Borntraeger wrote:
> introduce the new z14 Model ZR1 cpu model. Mostly identical to z14, only
> the cpu type differs (3906 vs. 3907)
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  target/s390x/cpu_models.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index e10035aaa8..cfdbccf46d 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -79,6 +79,7 @@ static S390CPUDef s390_cpu_defs[] = {
>      CPUDEF_INIT(0x2964, 13, 2, 47, 0x08000000U, "z13.2", "IBM z13 GA2"),
>      CPUDEF_INIT(0x2965, 13, 2, 47, 0x08000000U, "z13s", "IBM z13s GA1"),
>      CPUDEF_INIT(0x3906, 14, 1, 47, 0x08000000U, "z14", "IBM z14 GA1"),
> +    CPUDEF_INIT(0x3907, 14, 1, 47, 0x08000000U, "z14ZR1", "IBM z14 Model ZR1 GA1"),
>  };
>  
>  #define QEMU_MAX_CPU_TYPE 0x2827
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb

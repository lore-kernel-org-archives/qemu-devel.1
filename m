Received: from eggs.gnu.org ([209.51.188.92]:48263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hL3R8-0006RN-AJ
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 06:23:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hL3M2-0006QZ-JL
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 06:17:47 -0400
References: <20190429090250.7648-1-borntraeger@de.ibm.com>
	<20190429090250.7648-10-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <e04f4b12-1dae-d14d-0d73-364b465806c3@redhat.com>
Date: Mon, 29 Apr 2019 12:17:37 +0200
MIME-Version: 1.0
In-Reply-To: <20190429090250.7648-10-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 9/9] s390x/cpumodel: wire up 8561 and
 8562 as gen15 machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>, Richard Henderson <rth@twiddle.net>, Collin Walling <walling@linux.ibm.com>, "Jason J . Herne" <jjherne@linux.ibm.com>

On 29.04.19 11:02, Christian Borntraeger wrote:
> 8561 and 8562 will be gen15 machines. There is no name yet, lets us use
> gen15a and gen15tb as base name. Later on we can provide aliases with

nit: gen15b

> the proper name.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  target/s390x/cpu_models.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index d683635eb5..21ea819483 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -43,10 +43,9 @@
>      }
>  
>  /*
> - * CPU definiton list in order of release. For now, base features of a
> - * following release are always a subset of base features of the previous
> - * release. Same is correct for the other feature sets.
> - * A BC release always follows the corresponding EC release.
> + * CPU definition list in order of release. Up to generation 14 base features
> + * of a following release have been a superset of the previous release. With
> + * generation 15 one base feature and one optional feature have been deprecated.
>   */
>  static S390CPUDef s390_cpu_defs[] = {
>      CPUDEF_INIT(0x2064, 7, 1, 38, 0x00000000U, "z900", "IBM zSeries 900 GA1"),
> @@ -83,6 +82,8 @@ static S390CPUDef s390_cpu_defs[] = {
>      CPUDEF_INIT(0x3906, 14, 1, 47, 0x08000000U, "z14", "IBM z14 GA1"),
>      CPUDEF_INIT(0x3906, 14, 2, 47, 0x08000000U, "z14.2", "IBM z14 GA2"),
>      CPUDEF_INIT(0x3907, 14, 1, 47, 0x08000000U, "z14ZR1", "IBM z14 Model ZR1 GA1"),
> +    CPUDEF_INIT(0x8561, 15, 1, 47, 0x08000000U, "gen15a", "IBM 8561 GA1"),
> +    CPUDEF_INIT(0x8562, 15, 1, 47, 0x08000000U, "gen15b", "IBM 8562 GA1"),
>  };
>  
>  #define QEMU_MAX_CPU_TYPE 0x2827
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb

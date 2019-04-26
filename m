Received: from eggs.gnu.org ([209.51.188.92]:53273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hJypc-0007Zh-G1
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:15:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hJypa-0008B8-0z
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:15:51 -0400
References: <20190426111003.21246-1-borntraeger@de.ibm.com>
	<20190426111003.21246-3-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <94f35695-4c1e-401f-90f4-66e331174eee@redhat.com>
Date: Fri, 26 Apr 2019 13:15:43 +0200
MIME-Version: 1.0
In-Reply-To: <20190426111003.21246-3-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 02/10] s390x/cpumodel: ignore csske for
 expansion
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

On 26.04.19 13:09, Christian Borntraeger wrote:
> csske will be removed in a future machine. Ignore it for expanding the
> cpu model. Otherwise qemu falls back to z9.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: qemu-stable@nongnu.org
> ---
>  target/s390x/cpu_models.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index e5afa15512..b4bb5de635 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -1322,6 +1322,8 @@ static void init_ignored_base_feat(void)
>           S390_FEAT_KM_TDEA_192,
>           S390_FEAT_KIMD_SHA_1,
>           S390_FEAT_KLMD_SHA_1,
> +         /* CSSKE is deprecated on newer generations */
> +         S390_FEAT_CONDITIONAL_SSKE,
>      };
>      int i;
>  
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb

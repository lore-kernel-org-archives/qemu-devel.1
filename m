Received: from eggs.gnu.org ([209.51.188.92]:39342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hH6ai-0002eG-UA
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:56:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hH6ah-0005Jx-P9
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:56:36 -0400
References: <20190418113110.160664-1-borntraeger@de.ibm.com>
	<20190418113110.160664-6-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <21fcea12-9893-248b-e38d-850607cc33f0@redhat.com>
Date: Thu, 18 Apr 2019 14:56:30 +0200
MIME-Version: 1.0
In-Reply-To: <20190418113110.160664-6-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/10] s390x/cpumodel: vector enhancements
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

On 18.04.19 13:31, Christian Borntraeger wrote:
> Add vector enhancements to the cpu model.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  target/s390x/cpu_features.c     | 2 ++
>  target/s390x/cpu_features_def.h | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
> index 4d624b2256..ed3f6aa969 100644
> --- a/target/s390x/cpu_features.c
> +++ b/target/s390x/cpu_features.c
> @@ -108,6 +108,8 @@ static const S390FeatDef s390_features[] = {
>      FEAT_INIT("irbm", S390_FEAT_TYPE_STFL, 145, "Insert-reference-bits-multiple facility"),
>      FEAT_INIT("msa8-base", S390_FEAT_TYPE_STFL, 146, "Message-security-assist-extension-8 facility (excluding subfunctions)"),
>      FEAT_INIT("cmmnt", S390_FEAT_TYPE_STFL, 147, "CMM: ESSA-enhancement (no translate) facility"),
> +    FEAT_INIT("vxeh2", S390_FEAT_TYPE_STFL, 148, "Vector Enhancements facility 2"),
> +    FEAT_INIT("vxbeh", S390_FEAT_TYPE_STFL, 152, "Vector BCD enhancements facility 1"),
>      FEAT_INIT("msa9-base", S390_FEAT_TYPE_STFL, 155, "Message-security-assist-extension-9 facility (excluding subfunctions)"),
>      FEAT_INIT("etoken", S390_FEAT_TYPE_STFL, 156, "Etoken facility"),

BTW, to make this less error prone I thought about converting this into
something like

FEAT_INIT(VECTOR_ENH2, "vxeh2", S390_FEAT_TYPE_STFL, 148, "Vector
Enhancements facility 2"),

and internally use

.[S390_FEAT_##FEAT] = { ...

Or similar. But don't have time for that right now.

>  
> diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_features_def.h
> index 030784811b..ce2223c9d7 100644
> --- a/target/s390x/cpu_features_def.h
> +++ b/target/s390x/cpu_features_def.h
> @@ -96,6 +96,8 @@ typedef enum {
>      S390_FEAT_INSERT_REFERENCE_BITS_MULT,
>      S390_FEAT_MSA_EXT_8,
>      S390_FEAT_CMM_NT,
> +    S390_FEAT_VECTOR_ENH2,
> +    S390_FEAT_VECTOR_BCD_ENH,
>      S390_FEAT_MSA_EXT_9,
>      S390_FEAT_ETOKEN,
>  
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb

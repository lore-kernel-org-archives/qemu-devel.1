Received: from eggs.gnu.org ([209.51.188.92]:44588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hH95j-00012S-RI
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:36:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hH95i-0007wW-SI
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:36:47 -0400
References: <20190418113110.160664-1-borntraeger@de.ibm.com>
	<20190418113110.160664-8-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <2a98f8a0-15bc-aa3d-f4ad-71059d65dad8@redhat.com>
Date: Thu, 18 Apr 2019 17:36:40 +0200
MIME-Version: 1.0
In-Reply-To: <20190418113110.160664-8-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/10] s390x/cpumodel: deflate
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
> add the deflate conversion facility.

Nit:

"s390x/cpumodel: add Deflate-conversion facility"

> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  target/s390x/cpu_features.c     |  9 +++++++++
>  target/s390x/cpu_features.h     |  1 +
>  target/s390x/cpu_features_def.h |  7 +++++++
>  target/s390x/gen-features.c     | 12 ++++++++++++
>  target/s390x/kvm.c              |  6 ++++++
>  5 files changed, 35 insertions(+)
> 
> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
> index e0a4769c19..5f37e655fe 100644
> --- a/target/s390x/cpu_features.c
> +++ b/target/s390x/cpu_features.c
> @@ -110,6 +110,7 @@ static const S390FeatDef s390_features[] = {
>      FEAT_INIT("cmmnt", S390_FEAT_TYPE_STFL, 147, "CMM: ESSA-enhancement (no translate) facility"),
>      FEAT_INIT("vxeh2", S390_FEAT_TYPE_STFL, 148, "Vector Enhancements facility 2"),
>      FEAT_INIT("esort-base", S390_FEAT_TYPE_STFL, 150, "Enhanced-sort facility (excluding subfunctions)"),
> +    FEAT_INIT("deflate-base", S390_FEAT_TYPE_STFL, 151, "Deflate-conversion facility (excluding subfunctions)"),
>      FEAT_INIT("vxbeh", S390_FEAT_TYPE_STFL, 152, "Vector BCD enhancements facility 1"),
>      FEAT_INIT("msa9-base", S390_FEAT_TYPE_STFL, 155, "Message-security-assist-extension-9 facility (excluding subfunctions)"),
>      FEAT_INIT("etoken", S390_FEAT_TYPE_STFL, 156, "Etoken facility"),
> @@ -347,6 +348,11 @@ static const S390FeatDef s390_features[] = {
>      FEAT_INIT("sortl-32", S390_FEAT_TYPE_SORTL, 130, "SORTL 32 input lists"),
>      FEAT_INIT("sortl-128", S390_FEAT_TYPE_SORTL, 132, "SORTL 128 input lists"),
>      FEAT_INIT("sortl-f0", S390_FEAT_TYPE_SORTL, 192, "SORTL format 0 parameter-block"),
> +
> +    FEAT_INIT("dfltcc-gdht", S390_FEAT_TYPE_DFLTCC, 1, "DFLTCC GDHT"),
> +    FEAT_INIT("dfltcc-cmpr", S390_FEAT_TYPE_DFLTCC, 2, "DFLTCC CMPR"),
> +    FEAT_INIT("dfltcc-xpnd", S390_FEAT_TYPE_DFLTCC, 4, "DFLTCC XPND"),
> +    FEAT_INIT("dfltcc-f0", S390_FEAT_TYPE_DFLTCC, 192, "DFLTCC format 0 parameter-block"),
>  };

Just wonder, "format 0 parameter-block" is actually a feature right,
like "format 0 can be used". Can we hide format-0, IOW could that be
like "query" and always supported? (especially due to backwards
compatibility)


-- 

Thanks,

David / dhildenb

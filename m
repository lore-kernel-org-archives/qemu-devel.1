Received: from eggs.gnu.org ([2001:4830:134:3::10]:46666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ezHIO-0005RV-W9
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 03:39:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ezHIL-0006Lu-UA
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 03:39:29 -0400
References: <20180320130702.188689-1-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <0fd5429f-9745-7897-2386-d2cf30325174@redhat.com>
Date: Fri, 23 Mar 2018 08:39:16 +0100
MIME-Version: 1.0
In-Reply-To: <20180320130702.188689-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] s390x/cpumodel: fix feature groups and
 breakage of MSA8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>

On 20.03.2018 14:07, Christian Borntraeger wrote:
> Since commit 46a99c9f73c7 ("s390x/cpumodel: model PTFF subfunctions
> for Multiple-epoch facility") -cpu help no longer shows the MSA8
> feature group. Turns out that we forgot to add the new MEPOCH_PTFF
> group enum.
> 
> Fixes: 46a99c9f73c7 ("s390x/cpumodel: model PTFF subfunctions for Multiple-epoch facility")
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  target/s390x/cpu_features.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
> index e306aa7ab2..968b12fdfe 100644
> --- a/target/s390x/cpu_features.h
> +++ b/target/s390x/cpu_features.h
> @@ -78,6 +78,7 @@ typedef enum {
>      S390_FEAT_GROUP_MSA_EXT_6,
>      S390_FEAT_GROUP_MSA_EXT_7,
>      S390_FEAT_GROUP_MSA_EXT_8,
> +    S390_FEAT_GROUP_MULTIPLE_EPOCH_PTFF,
>      S390_FEAT_GROUP_MAX,
>  } S390FeatGroup;
>  
> 

Indeed, thanks!

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb

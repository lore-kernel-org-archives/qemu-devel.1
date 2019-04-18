Received: from eggs.gnu.org ([209.51.188.92]:38430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hH6Xb-0000fX-Jz
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:53:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hH6Xa-0003x9-HD
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:53:23 -0400
References: <20190418113110.160664-1-borntraeger@de.ibm.com>
	<20190418113110.160664-4-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <93c7c457-e6dc-c033-db71-bce4f39c0a10@redhat.com>
Date: Thu, 18 Apr 2019 14:53:16 +0200
MIME-Version: 1.0
In-Reply-To: <20190418113110.160664-4-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/10] s390x/cpumodel:
 Miscellaneous-Instruction-Extensions Facility 3
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
> Provide the "Miscellaneous-Instruction-Extensions Facility 3" via
> stfle.61.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  target/s390x/cpu_features.c     | 1 +
>  target/s390x/cpu_features_def.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
> index 1843c84aaa..bbd8902087 100644
> --- a/target/s390x/cpu_features.c
> +++ b/target/s390x/cpu_features.c
> @@ -83,6 +83,7 @@ static const S390FeatDef s390_features[] = {
>      FEAT_INIT("minste2", S390_FEAT_TYPE_STFL, 58, "Miscellaneous-instruction-extensions facility 2"),
>      FEAT_INIT("sema", S390_FEAT_TYPE_STFL, 59, "Semaphore-assist facility"),
>      FEAT_INIT("tsi", S390_FEAT_TYPE_STFL, 60, "Time-slice Instrumentation facility"),
> +    FEAT_INIT("minste3", S390_FEAT_TYPE_STFL, 61, "Miscellaneous-Instruction-Extensions Facility 3"),
>      FEAT_INIT("ri", S390_FEAT_TYPE_STFL, 64, "CPU runtime-instrumentation facility"),
>      FEAT_INIT("zpci", S390_FEAT_TYPE_STFL, 69, "z/PCI facility"),
>      FEAT_INIT("aen", S390_FEAT_TYPE_STFL, 71, "General-purpose-adapter-event-notification facility"),
> diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_features_def.h
> index 5fc7e7bf01..31dd678301 100644
> --- a/target/s390x/cpu_features_def.h
> +++ b/target/s390x/cpu_features_def.h
> @@ -71,6 +71,7 @@ typedef enum {
>      S390_FEAT_MISC_INSTRUCTION_EXT,
>      S390_FEAT_SEMAPHORE_ASSIST,
>      S390_FEAT_TIME_SLICE_INSTRUMENTATION,
> +    S390_FEAT_MISC_INSTRUCTION_EXT3,
>      S390_FEAT_RUNTIME_INSTRUMENTATION,
>      S390_FEAT_ZPCI,
>      S390_FEAT_ADAPTER_EVENT_NOTIFICATION,
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb

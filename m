Received: from eggs.gnu.org ([2001:4830:134:3::10]:40501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dYAXz-00023s-Kb
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 08:27:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dYAXu-0006ec-KG
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 08:27:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:14762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dYAXu-0006dd-E9
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 08:27:10 -0400
References: <1500550051-7821-1-git-send-email-borntraeger@de.ibm.com>
	<1500550051-7821-2-git-send-email-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <cf3ec2a7-5d9b-eebc-ff81-c0c9c50c9ea5@redhat.com>
Date: Thu, 20 Jul 2017 14:27:04 +0200
MIME-Version: 1.0
In-Reply-To: <1500550051-7821-2-git-send-email-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] s390/cpumodel: remove KSS from the
 default model of z14
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>

On 20.07.2017 13:27, Christian Borntraeger wrote:
> The SIE_KSS feature will allow a guest to use KSS for a nested guest.
> To create a nested guest the SIE_F2 facility is still necessary.
> Since SIE_F2 is not part of the default model it does not make
> a lot of sense to provide the SIE_KSS feature in the default model.
> Let's also create a dependency check.

Makes sense.

Acked-by: David Hildenbrand <david@redhat.com>

> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> ---
>  target/s390x/cpu_models.c   | 1 +
>  target/s390x/gen-features.c | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index f4e5bb6..d91b7b8 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -723,6 +723,7 @@ static void check_consistency(const S390CPUModel *model)
>          { S390_FEAT_KLMD_SHAKE_256, S390_FEAT_MSA },
>          { S390_FEAT_PRNO_TRNG_QRTCR, S390_FEAT_MSA_EXT_5 },
>          { S390_FEAT_PRNO_TRNG, S390_FEAT_MSA_EXT_5 },
> +        { S390_FEAT_SIE_KSS, S390_FEAT_SIE_F2 },
>      };
>      int i;
>  
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index cf69157..c8dc104 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -535,7 +535,6 @@ static uint16_t default_GEN14_GA1[] = {
>      S390_FEAT_GROUP_MSA_EXT_6,
>      S390_FEAT_GROUP_MSA_EXT_7,
>      S390_FEAT_GROUP_MSA_EXT_8,
> -    S390_FEAT_SIE_KSS,
>  };
>  
>  /****** END FEATURE DEFS ******/
> 


-- 

Thanks,

David

Received: from eggs.gnu.org ([2001:4830:134:3::10]:42401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dX9ve-0002th-S9
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:35:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dX9vb-0001pa-Jw
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:35:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dX9vb-0001pB-D9
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:35:27 -0400
References: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
	<1500028867-134709-38-git-send-email-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <e6bcec43-a424-1964-d025-7e5bd7985e33@redhat.com>
Date: Mon, 17 Jul 2017 19:35:23 +0200
MIME-Version: 1.0
In-Reply-To: <1500028867-134709-38-git-send-email-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 37/40] s390x/kvm: Enable KSS facility for
 nested virtualization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On 14.07.2017 12:41, Christian Borntraeger wrote:
> From: Farhan Ali <alifm@linux.vnet.ibm.com>
> 
> If the host supports keyless subset (KSS) then first level
> guest (G2) should enable KSS facility as well.
> 
> Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
> Reviewed-by: Eric Farman <farman@linux.vnet.ibm.com>
> Acked-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  target/s390x/kvm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 8c6cc0a..c773bd6 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -2508,6 +2508,7 @@ static int kvm_to_feat[][2] = {
>      { KVM_S390_VM_CPU_FEAT_CMMA, S390_FEAT_SIE_CMMA },
>      { KVM_S390_VM_CPU_FEAT_PFMFI, S390_FEAT_SIE_PFMFI},
>      { KVM_S390_VM_CPU_FEAT_SIGPIF, S390_FEAT_SIE_SIGPIF},
> +    { KVM_S390_VM_CPU_FEAT_KSS, S390_FEAT_SIE_KSS},
>  };
>  
>  static int query_cpu_feat(S390FeatBitmap features)
> 

This bit is not part of any cpu model, so how is this helpful?
(AFAIK it will simply be dropped from the host model)

-- 

Thanks,

David

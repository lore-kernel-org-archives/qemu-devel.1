Received: from eggs.gnu.org ([2001:4830:134:3::10]:33207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dv3FQ-0007rK-Gp
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 11:18:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dv3FL-0007dA-R6
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 11:18:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41364)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dv3FL-0007cA-Ky
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 11:18:35 -0400
References: <20170921151446.40015-1-borntraeger@de.ibm.com>
	<20170921151446.40015-2-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <7252ba2e-c950-3ee3-c898-713b54d542ad@redhat.com>
Date: Thu, 21 Sep 2017 17:18:31 +0200
MIME-Version: 1.0
In-Reply-To: <20170921151446.40015-2-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] s390x/ais: for 2.10 stable: disable
 ais facility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>

On 21.09.2017 17:14, Christian Borntraeger wrote:
> The migration interface for ais was introduced with kernel 4.13
> but the capability itself had been active since 4.12. As migration
> support is considered necessary lets disable ais in the 2.10
> stable version. A proper fix and re-enablement will be done
> for qemu 2.11.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  target/s390x/kvm.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index c4c5791..eb0dbb3 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -308,8 +308,13 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>          }
>      }
>  
> -    /* Try to enable AIS facility */
> -    kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0);
> +    /*
> +     * The migration interface for ais was introduced with kernel 4.13
> +     * but the capability itself had been active since 4.12. As migration
> +     * support is considered necessary let's disable ais in the 2.10
> +     * machine.
> +     */
> +    /* kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0); */
>  
>      qemu_mutex_init(&qemu_sigp_mutex);
>  
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David

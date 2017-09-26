Received: from eggs.gnu.org ([2001:4830:134:3::10]:49714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dwoYO-00053C-Sl
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 08:01:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dwoYL-0004Ic-SJ
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 08:01:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dwoYL-0004IJ-MV
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 08:01:29 -0400
References: <20170922083855.102341-1-borntraeger@de.ibm.com>
	<20170922083855.102341-2-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <187f09ae-bb47-bf1f-3010-4260536485be@redhat.com>
Date: Tue, 26 Sep 2017 14:01:22 +0200
MIME-Version: 1.0
In-Reply-To: <20170922083855.102341-2-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH/RFC 1/3] s390x/ais: disable ais facility as
 it is broken
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>

On 22.09.2017 10:38, Christian Borntraeger wrote:
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
> index 720cb1d..ebb75ca 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -311,8 +311,13 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
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

Received: from eggs.gnu.org ([2001:4830:134:3::10]:50104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ddcZ7-0003aE-J5
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 09:24:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ddcY3-0003cA-33
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 09:22:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1ddcY2-0003ay-PL
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 09:21:50 -0400
References: <20170804112946.5247-1-cohuck@redhat.com>
	<20170804112946.5247-5-cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <858caf11-8150-dd62-2554-4a37ad9326df@redhat.com>
Date: Fri, 4 Aug 2017 15:21:41 +0200
MIME-Version: 1.0
In-Reply-To: <20170804112946.5247-5-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 4/9] s390x/pci: do not advertise pci on
 non-pci builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com

On 04.08.2017 13:29, Cornelia Huck wrote:
> Only set the zpci feature bit on builds that actually support pci.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  target/s390x/kvm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index c4c5791d27..bc62bba5b7 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -2662,7 +2662,9 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
>      }
>  
>      /* We emulate a zPCI bus and AEN, therefore we don't need HW support */
> -    set_bit(S390_FEAT_ZPCI, model->features);
> +    if (pci_available) {
> +        set_bit(S390_FEAT_ZPCI, model->features);
> +    }
>      set_bit(S390_FEAT_ADAPTER_EVENT_NOTIFICATION, model->features);
>  
>      if (s390_known_cpu_type(cpu_type)) {
> 

Yup, looks good to me.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David

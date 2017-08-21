Received: from eggs.gnu.org ([2001:4830:134:3::10]:57002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1djlpv-00019E-Al
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 08:29:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1djlps-00077N-K9
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 08:29:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1djlps-000779-E8
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 08:29:40 -0400
References: <20170821091614.28251-1-cohuck@redhat.com>
	<20170821091614.28251-6-cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f7ae0842-8112-657f-8779-69d722ac5335@redhat.com>
Date: Mon, 21 Aug 2017 14:29:28 +0200
MIME-Version: 1.0
In-Reply-To: <20170821091614.28251-6-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 05/10] s390x/pci: do not advertise pci
 on non-pci builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, david@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com

On 21.08.2017 11:16, Cornelia Huck wrote:
> Only set the zpci feature bit on builds that actually support pci.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
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

Reviewed-by: Thomas Huth <thuth@redhat.com>

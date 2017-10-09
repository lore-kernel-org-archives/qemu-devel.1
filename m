Received: from eggs.gnu.org ([2001:4830:134:3::10]:55270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e1U4T-0005Vh-EK
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 05:09:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e1U4Q-0004Gu-9I
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 05:09:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e1U4Q-0004Gc-2s
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 05:09:54 -0400
Date: Mon, 9 Oct 2017 11:09:49 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171009110949.6246e351.cohuck@redhat.com>
In-Reply-To: <1507124979-8880-2-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1507124979-8880-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1507124979-8880-2-git-send-email-pmorel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/5] s390x/kvm: Enable AIS from CPU
 model always
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

On Wed,  4 Oct 2017 15:49:35 +0200
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> As this patchset will introduce AIS emulation, we always enable
> Adapter Interrupt Suppression, depending only from the CPU model.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> ---
>  target/s390x/kvm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 931b85f..06fe56d 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -2807,6 +2807,7 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
>      if (pci_available) {
>          set_bit(S390_FEAT_ZPCI, model->features);
>      }
> +    set_bit(S390_FEAT_ADAPTER_INT_SUPPRESSION, model->features);
>      set_bit(S390_FEAT_ADAPTER_EVENT_NOTIFICATION, model->features);
>  
>      if (s390_known_cpu_type(cpu_type)) {

I would move that patch until after emulation has actually been
provided.

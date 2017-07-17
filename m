Received: from eggs.gnu.org ([2001:4830:134:3::10]:39127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dX9kE-00041g-2A
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:23:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dX9kB-00041f-Pk
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:23:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dX9kB-00040U-J2
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:23:39 -0400
References: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
	<1500028867-134709-33-git-send-email-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <7c021c65-3824-3c87-2bc6-c8045da1513a@redhat.com>
Date: Mon, 17 Jul 2017 19:23:31 +0200
MIME-Version: 1.0
In-Reply-To: <1500028867-134709-33-git-send-email-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 32/40] s390x/cpumodel: add zpci,
 aen and ais facilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>


> +    /* Try to enable AIS facility */
> +    kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0);
> +
>      qemu_mutex_init(&qemu_sigp_mutex);
>  
>      return 0;
> @@ -2635,6 +2638,10 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
>          set_bit(S390_FEAT_CMM, model->features);
>      }
>  
> +    /* set zpci and aen facilities */

This comment is not helpful. This should rather say something like "we
emulate a zPCI bus in QEMU, therefore we don't depend on the host
capabilities"

> +    set_bit(S390_FEAT_ZPCI, model->features);
> +    set_bit(S390_FEAT_ADAPTER_EVENT_NOTIFICATION, model->features);
> +
>      if (s390_known_cpu_type(cpu_type)) {
>          /* we want the exact model, even if some features are missing */
>          model->def = s390_find_cpu_def(cpu_type, ibc_gen(unblocked_ibc),
> 

-- 

Thanks,

David

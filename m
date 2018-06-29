Received: from eggs.gnu.org ([2001:4830:134:3::10]:51937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1fYsQp-0001dU-Di
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 08:23:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1fYsQl-0003wm-Bf
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 08:23:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60832 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1fYsQl-0003uI-7D
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 08:23:15 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20180610184927.19309-1-vkuznets@redhat.com>
Date: Fri, 29 Jun 2018 14:23:11 +0200
In-Reply-To: <20180610184927.19309-1-vkuznets@redhat.com> (Vitaly Kuznetsov's
	message of "Sun, 10 Jun 2018 20:49:27 +0200")
Message-ID: <87lgaxdbo0.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] i386/kvm: add support for Hyper-V TLB flush
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> Add support for Hyper-V TLB flush which recently got added to KVM.
>
> Just like regular Hyper-V we announce HV_EX_PROCESSOR_MASKS_RECOMMENDED
> regardless of how many vCPUs we have. Windows is 'smart' and uses less
> expensive non-EX Hypercall whenever possible (when it wants to flush TLB
> for all vCPUs or the maximum vCPU index in the vCPU set requires flushing
> is less than 64).
>

Ping?

-- 
  Vitaly

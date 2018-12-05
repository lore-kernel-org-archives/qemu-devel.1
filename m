Received: from eggs.gnu.org ([2001:4830:134:3::10]:40843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1gUWyv-0007Kw-70
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 08:12:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1gUWyq-0004hZ-Q1
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 08:12:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1gUWyq-0004ec-K0
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 08:12:44 -0500
From: Vitaly Kuznetsov <vkuznets@redhat.com>
In-Reply-To: <20181204180808.GC18284@habkost.net>
References: <20181126135958.20956-1-vkuznets@redhat.com>
	<c30c335e-ca21-1179-670b-d4506ce14571@redhat.com>
	<878t1chzj8.fsf@vitty.brq.redhat.com>
	<20181130183608.GQ18284@habkost.net>
	<871s6yy9st.fsf@vitty.brq.redhat.com>
	<20181204180808.GC18284@habkost.net>
Date: Wed, 05 Dec 2018 14:12:39 +0100
Message-ID: <874lbsce2g.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] i386/kvm: expose
 HV_CPUID_ENLIGHTMENT_INFO.EAX and HV_CPUID_NESTED_FEATURES.EAX as feature
 words
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Marcelo Tosatti <mtosatti@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>

Eduardo Habkost <ehabkost@redhat.com> writes:

>>            [...] Some time ago when merging direct mode stimers for KVM
>> Paolo suggested we stop adding capabilities to KVM for each individulat
>> feature and replace them with something like KVM_GET_SUPPORTED_HV_CPUID
>> ioctl returning all Hyper-V related feature words. When this is done we
>> can reconsider how Qemu discoveres Hyper-V related KVM features and as
>> part of this work we can take a closer look at feature words and
>> feat_names.
>
> Why a separate ioctl instead of extending GET_SUPPORTED_CPUID?

Unfortunatelly both KVM and Hyper-V use feature leaves 0x40000000,
0x40000001 (so it's up to the userspace - qemu in our case - what to
expose to the guest) and GET_SUPPORTED_CPUID already returns KVM's. Not
sure this can be changed (to e.g. returning these leaves twice with
different flags) without breaking userspace. New ioctl is safer.

-- 
Vitaly

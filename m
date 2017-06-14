Received: from eggs.gnu.org ([2001:4830:134:3::10]:58410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dL8UG-0001tL-Ft
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 09:37:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dL8UA-0007NX-Tt
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 09:37:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dL8UA-0007NI-N4
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 09:37:26 -0400
References: <20170606181948.16238-1-rkagan@virtuozzo.com>
	<20170606181948.16238-6-rkagan@virtuozzo.com>
	<20170613185752.GZ5016@thinpad.lan.raisama.net>
	<20170614112506.GI2004@rkaganb.sw.ru>
	<6bb8f5e3-b6bf-c62a-93f3-9fe338d43881@redhat.com>
	<20170614130149.GD5016@thinpad.lan.raisama.net>
	<20170614151117.42235246@nial.brq.redhat.com>
	<71b4d258-4299-43dd-ec0c-e7a2ab9e128e@redhat.com>
	<20170614132216.GF5016@thinpad.lan.raisama.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <49e83521-4551-8196-dc82-e877d3c97365@redhat.com>
Date: Wed, 14 Jun 2017 15:37:20 +0200
MIME-Version: 1.0
In-Reply-To: <20170614132216.GF5016@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/23] hyperv: ensure VP index equal to
 QEMU cpu_index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>



On 14/06/2017 15:22, Eduardo Habkost wrote:
>> Yes, definitely.  At this point let's add a new "KVM_CAP_HYPERV_SYNIC2"
>> capability and declare the old one broken, that will make things easier.
> What do we need a capability for?  Can't we just call
> KVM_SET_MSRS using arch_id (== apic_id) and warn the user if it
> doesn't work?

As mentioned in the review of patch 16/23, we may want to break
backwards compatibility (meaning we drop the old capability and
introduce a new one) for other reasons.

Paolo

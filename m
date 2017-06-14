Received: from eggs.gnu.org ([2001:4830:134:3::10]:33517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dL7F9-0005Us-Nz
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 08:17:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dL7F6-0002Qd-Hy
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 08:17:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dL7F6-0002QQ-B9
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 08:17:48 -0400
References: <20170606181948.16238-1-rkagan@virtuozzo.com>
	<20170606181948.16238-12-rkagan@virtuozzo.com>
	<20170613190256.GA5016@thinpad.lan.raisama.net>
	<a28bb4a6-dde2-5bde-d8fc-62509615da62@redhat.com>
	<20170614121447.GA2044@rkaganb.sw.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fedf511f-9621-5b37-4182-dfc2ce73b29e@redhat.com>
Date: Wed, 14 Jun 2017 14:17:44 +0200
MIME-Version: 1.0
In-Reply-To: <20170614121447.GA2044@rkaganb.sw.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/23] hyperv: address HvSintRoute by
 X86CPU pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>



On 14/06/2017 14:14, Roman Kagan wrote:
>>> vcpu_id risks being confused KVM's vcpu_id (which is the CPU APIC
>>> ID in x86).  If you are already touching this code, this could be
>>> renamed to vp_index to avoid confusion.
>> Actually the VP_INDEX is _also_ the vcpu_id.  Should we just document
>> that KVM makes the VP_INDEX equal to the CPU APIC id, and adjust patch 5
>> accordingly?
> I think here it makes sense to follow Eduardo's suggestion because this
> code doesn't need to know how VP_INDEX is defined.

Yes, I agree.  Sorry if that wasn't clear---Eduardo's comment just made
me notice this possible solution to the issue of patch 5.

Paolo

> The real matter is discussed in patch 5, yes.

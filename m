Received: from eggs.gnu.org ([2001:4830:134:3::10]:32908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dL7CO-000457-HL
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 08:15:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dL7CL-0001kR-Br
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 08:15:00 -0400
Received: from mail-ve1eur01on0092.outbound.protection.outlook.com
	([104.47.1.92]:6622
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1dL7CK-0001jx-J6
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 08:14:57 -0400
Date: Wed, 14 Jun 2017 15:14:48 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20170614121447.GA2044@rkaganb.sw.ru>
References: <20170606181948.16238-1-rkagan@virtuozzo.com>
	<20170606181948.16238-12-rkagan@virtuozzo.com>
	<20170613190256.GA5016@thinpad.lan.raisama.net>
	<a28bb4a6-dde2-5bde-d8fc-62509615da62@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a28bb4a6-dde2-5bde-d8fc-62509615da62@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

On Wed, Jun 14, 2017 at 01:08:43PM +0200, Paolo Bonzini wrote:
> 
> 
> On 13/06/2017 21:02, Eduardo Habkost wrote:
> >> @@ -101,16 +101,18 @@ static void hv_test_dev_control(void *opaque, hwaddr addr, uint64_t data,
> >>      uint8_t sint = data & 0xFF;
> >>      uint8_t vcpu_id = (data >> 8ULL) & 0xFF;
> >
> > vcpu_id risks being confused KVM's vcpu_id (which is the CPU APIC
> > ID in x86).  If you are already touching this code, this could be
> > renamed to vp_index to avoid confusion.
> 
> Actually the VP_INDEX is _also_ the vcpu_id.  Should we just document
> that KVM makes the VP_INDEX equal to the CPU APIC id, and adjust patch 5
> accordingly?

I think here it makes sense to follow Eduardo's suggestion because this
code doesn't need to know how VP_INDEX is defined.

The real matter is discussed in patch 5, yes.

Thanks,
Roman.

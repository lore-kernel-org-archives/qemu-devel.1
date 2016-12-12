Received: from eggs.gnu.org ([2001:4830:134:3::10]:57723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cGUuW-0000sU-L3
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 13:01:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cGUuS-0004Jh-Me
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 13:01:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cGUuS-0004JQ-Gz
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 13:01:08 -0500
Date: Mon, 12 Dec 2016 16:01:05 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20161212180105.GF3808@thinpad.lan.raisama.net>
References: <20161210172148.361793326@redhat.com>
	<20161210172324.482367805@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161210172324.482367805@redhat.com>
Subject: Re: [Qemu-devel] [qemu patch V4 2/2] kvmclock: reduce kvmclock
 difference on migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, Dr David Alan Gilbert <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, Radim Krcmar <rkrcmar@redhat.com>

On Sat, Dec 10, 2016 at 03:21:50PM -0200, Marcelo Tosatti wrote:
[...]
>  static void kvmclock_realize(DeviceState *dev, Error **errp)
>  {
>      KVMClockState *s = KVM_CLOCK(dev);
>  
> +    if (kvm_has_adjust_clock_stable()) {
> +        s->clock_is_reliable = true;
> +    }
> +

This seems unnecessary, as kvmclock_vm_state_change() makes sure
it is set at the same time as s->clock. Should we just remove it?

>      qemu_add_vm_change_state_handler(kvmclock_vm_state_change, s);
>  }
>  
[...]

-- 
Eduardo

Received: from eggs.gnu.org ([209.51.188.92]:56050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1goVNF-0004Gu-5b
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:32:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1goVGm-0006jx-Vk
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:25:58 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1goVGm-0006j6-6K
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:25:48 -0500
Received: by mail-wr1-f66.google.com with SMTP id u4so22540389wrp.3
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 07:25:44 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
In-Reply-To: <20190128191017.GW4136@habkost.net>
References: <20190125114155.32062-1-vkuznets@redhat.com>
	<20190125114155.32062-5-vkuznets@redhat.com>
	<20190125124738.GB30730@rkaganb.sw.ru>
	<87bm44onnh.fsf@vitty.brq.redhat.com>
	<20190128113017.GA2435@rkaganb.sw.ru>
	<87lg34zy37.fsf@vitty.brq.redhat.com>
	<20190128182229.GF2585@work-vm> <20190128191017.GW4136@habkost.net>
Date: Tue, 29 Jan 2019 16:25:40 +0100
Message-ID: <874l9rzdsb.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC 4/8] i386/kvm: Implement 'hv-all'
 pass-through mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Roman Kagan <rkagan@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcelo Tosatti <mtosatti@redhat.com>

Eduardo Habkost <ehabkost@redhat.com> writes:

>
> If libvirt is involved, it's much simpler and safer to use
> something like <cpu mode="host-model">, which generates a
> migration-safe CPU configuration based on the current host.  Live
> migration support with "-cpu host" is only useful for experiments
> and carefully controlled environments.
>
> Is there a real need to make hv-all migratable?  What would be
> the use case, exactly?  If there's no clear use case, I would
> recommend making it a migration blocker.

There's no clear use-case; I noticed that we keep adding Hyper-V
enlightenments and these make Windows' life on KVM easier so we
recommend enabling them all (and, with an exception for hv-evmcs, which
I also don't enable with hv-all, I'm unawere of cases which would
require disabling certain Hyper-V enlightenments).

hv-all is mostly a convenience feature. I plan to take a look at
'host-model' to see if we can borrow some ideas from there (that would
actually be ideal - build a set of 'hv-*' enlightenments based on
capabilites of the current host) but I'm also not totally against
keeping it the way it is and making it a migration blocker for the time
being (and making it a 'developer-only' feature).

-- 
Vitaly

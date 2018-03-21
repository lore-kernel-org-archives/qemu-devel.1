Received: from eggs.gnu.org ([2001:4830:134:3::10]:55494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eyhNP-0003lJ-F4
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:18:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eyhNM-0001vP-BP
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:18:15 -0400
Received: from mail-am5eur03hn0215.outbound.protection.outlook.com
	([104.47.8.215]:17753
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1eyhNL-0001uf-37
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:18:12 -0400
Date: Wed, 21 Mar 2018 20:17:55 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20180321171755.GJ14983@rkaganb.sw.ru>
References: <20180320173500.32065-1-vkuznets@redhat.com>
	<20180320173500.32065-3-vkuznets@redhat.com>
	<46c08ea1-27f7-e581-f93f-cf635950062f@redhat.com>
	<87605p768t.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87605p768t.fsf@vitty.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/2] i386/kvm: lower requirements for
 Hyper-V frequency MSRs exposure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org

On Wed, Mar 21, 2018 at 05:17:38PM +0100, Vitaly Kuznetsov wrote:
> (What I'm worried about with all our hv_* knobs is that more of them we
> have easier it is to assemble some frankenstien which won't look like
> any existing Hyper-V version; we're probably not doing a very good job
> tesing all possible hv_* combinations as people probably use 'all or
> nothing'. In case we end up finding a bug in Windows with some weird
> hv_* combination it's unlikely Microsoft will bother fixing at as it
> doesn't reproduce on any existent Hyper-V version.

I agree that this is getting cumbersome, but, given that features get
added incrementally and we need to be able to maintain backwards
compatibility, I'm afraid this is unavoidable.

> That said, it would be great to eventually have something like
> 'hv_ws2012r2' property making us look exactly the same real WS2012R2
> looks like. Unfortunatelly, I'm unsure about a path to get there).

I'm tempted to delegate this -- combining features into user-friendly
sets -- to the upper layers: libvirt or even something on top of it.

Roman.

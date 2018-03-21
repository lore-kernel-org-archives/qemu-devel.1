Received: from eggs.gnu.org ([2001:4830:134:3::10]:37362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eybSS-0000lH-QF
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 06:59:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eybSP-0003YM-Mf
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 06:59:04 -0400
Received: from mail-db5eur01hn0226.outbound.protection.outlook.com
	([104.47.2.226]:1991
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1eybSP-0003Ve-71
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 06:59:01 -0400
Date: Wed, 21 Mar 2018 13:58:44 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20180321105844.GA14983@rkaganb.sw.ru>
References: <20180316170020.8212-1-vkuznets@redhat.com>
	<20180316170020.8212-2-vkuznets@redhat.com>
	<20180319170603.GA12962@rkaganb.sw.ru>
	<87a7v47z4r.fsf@vitty.brq.redhat.com>
	<20180320181652.GV3417@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320181652.GV3417@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] i386/kvm: add support for Hyper-V
 reenlightenment MSRs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org

On Tue, Mar 20, 2018 at 03:16:52PM -0300, Eduardo Habkost wrote:
> On Mon, Mar 19, 2018 at 06:29:08PM +0100, Vitaly Kuznetsov wrote:
> > Roman Kagan <rkagan@virtuozzo.com> writes:
> > > (This is also a problem with has_msr_hv_frequencies, and is in general a
> > > long-standing issue of hv_* properties being done differently from the
> > > rest of CPUID features.)
> > 
> > Suggestions? (To be honest I don't really like us adding new hv_*
> > property for every new Hyper-V feature we support. I doubt anyone needs
> > 'partial' Hyper-V emulation. It would be nice to have a single versioned
> > 'hv' feature implying everything. We may then forbid migrations to older
> > hv versions. But I don't really know the history of why we decided to go
> > with a separate hv_* for every feature we add).
> 
> You will need "partial" emulation if you want to support
> live-migration to/from a host where the KVM or QEMU don't support
> all the features from the current host.
> 
> Is this something the current Hyper-V code already supports, or
> it's something known to be broken?

There's at least one case I mentioned above where it's broken, but, as
Paolo pointed out, the real Windows guests wouldn't notice because they
didn't use the feature due to missing INVTSC.

I myself haven't tested all possible combinations of hv_* flags and KVM
versions, but from code inspection I don't immediately see anything else
that's obviously broken in this regard.

Roman.

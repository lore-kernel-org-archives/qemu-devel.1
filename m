Received: from eggs.gnu.org ([2001:4830:134:3::10]:57473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gKpGo-0005Si-NB
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:43:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gKpGf-0001hU-T3
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:43:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gKpGf-0001GN-FR
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:43:01 -0500
Date: Thu, 8 Nov 2018 16:42:42 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181108184242.GQ12503@habkost.net>
References: <e496287e-f8ba-3608-42e1-efb697cfc784@redhat.com>
	<20181107154114.GC27585@caravaggio>
	<dd68d3e8-6448-3a67-3212-fd3d3bfba2e2@redhat.com>
	<20181107192414.GH12503@habkost.net>
	<c6bbfeb8-53c5-0e0c-cf36-14e586cfb581@redhat.com>
	<a0decaa7-d83b-b0ad-60ea-aa0890feb905@redhat.com>
	<20181108130648.GJ12503@habkost.net>
	<95a93d53-f87d-bd96-9363-582c4eae4160@redhat.com>
	<20181108171437.GM12503@habkost.net>
	<dda55f75-58d3-111c-4f43-99a9f686981e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dda55f75-58d3-111c-4f43-99a9f686981e@redhat.com>
Subject: Re: [Qemu-devel] QEMU and Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, "Zhong, Yang" <yang.zhong@intel.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Nov 08, 2018 at 06:58:11PM +0100, Paolo Bonzini wrote:
> On 08/11/2018 18:14, Eduardo Habkost wrote:
> > Keeping in mind that I might be talking about extra challenges we
> > won't address right now (no cart before the horse), I have new
> > questions:
> > 
> > Why you say backends are not a target configuration and
> > accelerators are?  What's the definition of "target
> > configuration"?
> 
> Something that affects the way

?

> 
> > Are we explicitly restricting the scope of this work to
> > enabling/disabling device emulation code right now?  Why?  Why
> > wouldn't we use kconfig to enable/disable simple backends with no
> > host dependency like SLIRP?
> 
> I think it would be more confusing if some backends were to use kconfig
> and some wouldn't.  We could certainly add something like
> 
> config VHOST_NET
>     depends on HOST_LINUX
>     default y
> 
> config SPICE
>     depends on HAVE_SPICE_SERVER
>     default Y
> 
> etc. but I think we agree it's more of a long term idea.

Agreed.

> 
> > Don't we want to make backends configurable per binary, too?
> > e.g.: I would expect the default configuration for a NEMU-like
> > binary to disable many backends.
> 
> Sure, we could do that.  However, right now you cannot have multiple
> binaries for a single target, so you couldn't have one single build
> include both a "full-blown" and a "reduced" x86 target.  Therefore,
> including e.g. SLIRP in qemu-system-arm but not in qemu-system-x86_64
> does not seem too interesting to me.  It would be different if you could
> build qemu-system-arm, qemu-system-x86_64, qemu-system-x86_64-lite, etc.

Understood.  I assumed this would be one of the short-term goals.
We can work on that later, then.


> 
> Paolo
> 
> > 
> >> It would surely be possible for configure to call into minikconf to
> >> parse a configuration file and apply dependencies (do we actually have
> >> dependencies across configure options?) or something like that, but
> >> let's not put the cart before the horse...
> > 
> > Agreed.
> > 
> 

-- 
Eduardo

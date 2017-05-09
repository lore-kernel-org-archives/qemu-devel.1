Received: from eggs.gnu.org ([2001:4830:134:3::10]:38718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8BUO-0003qO-SU
	for qemu-devel@nongnu.org; Tue, 09 May 2017 16:12:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8BUM-0002zH-6P
	for qemu-devel@nongnu.org; Tue, 09 May 2017 16:12:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d8BUM-0002xO-09
	for qemu-devel@nongnu.org; Tue, 09 May 2017 16:12:06 -0400
Date: Tue, 9 May 2017 17:12:01 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170509201201.GB3482@thinpad.lan.raisama.net>
References: <20170509132736.10071-1-berrange@redhat.com>
	<040c1e25-224f-1a8a-9f60-7238e6ad5df6@twiddle.net>
	<20170509141336.GF27432@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170509141336.GF27432@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/2] Support CPUID signature for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Tue, May 09, 2017 at 03:13:37PM +0100, Richard W.M. Jones wrote:
> On Tue, May 09, 2017 at 07:05:51AM -0700, Richard Henderson wrote:
> > On 05/09/2017 06:27 AM, Daniel P. Berrange wrote:
> > >This enables report of a signature in CPUID for the TCG
> > >interpretor.
> > >
> > >Changed in v4:
> > >
> > >  - Report 0x40000001 in EAX for 0x40000000 index (Eduardo)
> > >  - Report all zeros for 0x40000001 index (Eduardo)
> > >  - Make code style consistent when checking limits (Eduardo)
> > >
> > >Changed in v3:
> > >
> > >  - Simplify CPU limit code still further (Eduardo)
> > >
> > >Changed in v2:
> > >
> > >  - Rewrite the way we bounds check / cap the CPUID index
> > >    to use a flat switch, instead of nested ifs (Eduardo)
> > >  - Add a 'tcg-cpuid' property to allow it to be hidden
> > >    (Eduardo)
> > >  - Hide the TCG signature for old machine types
> > >  - Force code to a no-op if tcg_enabled() is false (Eduardo)
> > >
> > >
> > >NB, I did not introduce a general 'hypervisor-cpuid' property
> > >to obsolete the existing 'kvm=off|on' -cpu property, since it
> > >appears impossible to get the back compat semantics right,
> > >as described in a previous reply.
> > >
> > >Daniel P. Berrange (2):
> > >   i386: rewrite way CPUID index is validated
> > >   i386: expose "TCGTCGTCGTCG" in the 0x40000000 CPUID leaf
> > 
> > I probably should have commented earlier but...  what's the point?
> > 
> > If you want the guest os to actually do anything with this, what do
> > you gain for advertising TCG over KVM?
> 
> I can see this being useful from virt-what, since it would allow
> vendors to diagnose problems being caused by TCG (since as Dan
> mentions in the other reply and as you are already well acquainted
> with, TCG and KVM don't present or emulate quite the same thing).
> 
> That said, I don't think it's anything more than a nice to have.

We also have systemd-detect-virt, and the ConditionVirtualization
option in systemd.

-- 
Eduardo

Received: from eggs.gnu.org ([2001:4830:134:3::10]:56948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fJ06K-0007WC-6j
	for qemu-devel@nongnu.org; Wed, 16 May 2018 13:20:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fJ06G-0006NI-W8
	for qemu-devel@nongnu.org; Wed, 16 May 2018 13:20:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fJ06G-0006N2-Po
	for qemu-devel@nongnu.org; Wed, 16 May 2018 13:20:28 -0400
Date: Wed, 16 May 2018 14:20:22 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180516172022.GN25013@localhost.localdomain>
References: <20180419195610.GA29865@localhost.localdomain>
	<98f48c44-e55a-2bd2-0d41-5643f35bce68@redhat.com>
	<20180419215320.GC29865@localhost.localdomain>
	<20180512010007-mutt-send-email-mst@kernel.org>
	<c4f7f4bd-80ce-3d84-fb0d-a7ac22333afd@redhat.com>
	<20180516172121-mutt-send-email-mst@kernel.org>
	<2871c099-79fe-8432-12c9-637e743cc89c@redhat.com>
	<20180516180847-mutt-send-email-mst@kernel.org>
	<20180516153350.GM25013@localhost.localdomain>
	<20180516183513-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516183513-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH RESEND v2] i386/kvm: add support for
 KVM_CAP_X86_DISABLE_EXITS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Wanpeng Li <kernellwp@gmail.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>

On Wed, May 16, 2018 at 07:21:04PM +0300, Michael S. Tsirkin wrote:
> On Wed, May 16, 2018 at 12:33:50PM -0300, Eduardo Habkost wrote:
> > On Wed, May 16, 2018 at 06:13:17PM +0300, Michael S. Tsirkin wrote:
> > > On Wed, May 16, 2018 at 05:04:41PM +0200, Paolo Bonzini wrote:
> > > > On 16/05/2018 16:22, Michael S. Tsirkin wrote:
> > > > >> kvm-hint-dedicated=on only sets the CPUID bit, which Linux for example
> > > > >> uses that to disable pv spinlocks.  "-realtime dedicated-cpus=on" only
> > > > >> disables the vmexits.  You can use the two independently.
> > > > >
> > > > > But when would you want to use the two independently?
> > > > 
> > > > 1) For testing
> > > > 
> > > > 2) When some of your QEMUs are too old to support kvm-hint-dedicated=on,
> > > > you may still want to use -realtime dedicated-cpus=on to get better
> > > > performance on the new one.
> > > > 
> > > > Paolo
> > > 
> > > For the second purpose, can't we handle this using machine types?
> > 
> > Machine-type compatibility code deals with defaults when options
> > are omitted, not for making the meaning of explicit options
> > depend on the machine-type.
> > 
> > e.g. having "-machine pc-q35-2.11 -cpu ...,+kvm-hint-dedicated=on"
> > not expose the CPUID bit that was explicitly requested in the
> > command-line would be a bad idea.
> 
> Why? We have machine type affecting guest visible device behaviours
> for years.

Do you have an example where a machine-type overrides an option
explicitly set by the user?

-- 
Eduardo

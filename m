Received: from eggs.gnu.org ([2001:4830:134:3::10]:57992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eYgXv-0007KN-Rv
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 18:09:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eYgXs-0004up-Je
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 18:09:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eYgXs-0004uT-9q
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 18:09:32 -0500
Date: Mon, 8 Jan 2018 18:09:30 -0500 (EST)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <848013447.31735187.1515452970885.JavaMail.zimbra@redhat.com>
In-Reply-To: <20180108225625.GP6646@localhost.localdomain>
References: <20180108205052.24385-1-vincent@bernat.im>
	<20180108211623.GJ6646@localhost.localdomain>
	<242287261.31733448.1515451036017.JavaMail.zimbra@redhat.com>
	<20180108225625.GP6646@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target-i386: add pcid to both Sandy Bridge
 and Ivy Bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Vincent Bernat <vincent@bernat.im>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org



----- Original Message -----
> From: "Eduardo Habkost" <ehabkost@redhat.com>
> To: "Paolo Bonzini" <pbonzini@redhat.com>
> Cc: "Vincent Bernat" <vincent@bernat.im>, "Richard Henderson" <rth@twiddle.net>, qemu-devel@nongnu.org
> Sent: Monday, January 8, 2018 11:56:25 PM
> Subject: Re: [PATCH] target-i386: add pcid to both Sandy Bridge and Ivy Bridge
> 
> On Mon, Jan 08, 2018 at 05:37:16PM -0500, Paolo Bonzini wrote:
> > 
> > 
> > ----- Original Message -----
> > > From: "Eduardo Habkost" <ehabkost@redhat.com>
> > > To: "Vincent Bernat" <vincent@bernat.im>
> > > Cc: "Paolo Bonzini" <pbonzini@redhat.com>, "Richard Henderson"
> > > <rth@twiddle.net>, qemu-devel@nongnu.org
> > > Sent: Monday, January 8, 2018 10:16:23 PM
> > > Subject: Re: [PATCH] target-i386: add pcid to both Sandy Bridge and Ivy
> > > Bridge
> > > 
> > > On Mon, Jan 08, 2018 at 09:50:52PM +0100, Vincent Bernat wrote:
> > > > PCID has been introduced in Sandy Bridge and, currently, KVM doesn't
> > > > object exposing it to VM as long as it is present on the host. Update
> > > > CPU model for both Sandy Bridge and Ivy Bridge accordingly.
> > > > 
> > > > Signed-off-by: Vincent Bernat <vincent@bernat.im>
> > > 
> > > Thanks for your patch.
> > > 
> > > We need two things, though:
> > > 
> > > First, confirming that all hosts where the SandyBridge and
> > > IvyBridge CPU models are runnable will support exposing PCID to
> > > guests (otherwise updating QEMU can make a runnable VM
> > > configuration suddenly stop being runnable).  This can happen if
> > > the host kernel is too old.
> > 
> > I've been reading it's also Westmere.  I'll check more carefully tomorrow.
> > The difference between consumer and server SKUs is important too.
> > 
> > > One possible way to work around this problem is to declare that
> > > QEMU 2.12 with KVM will require Linux v3.6 and newer (because we
> > > need Linux kernel commit ad756a1603c5 "KVM: VMX: Implement
> > > PCID/INVPCID for guests with EPT").
> > 
> > Note that PCID is still not supported for guests without EPT, so
> > this would break ept=0 with recent "-cpu" models.  I'm not sure of
> > a way to fix it; probably it just has to be documented.
> 
> GET_SUPPORTED_CPUID seems to still return PCID as supported
> without EPT, doesn't it?

Indeed it is!  It will also be useful for KPTI performance without
INVPCID, but it won't be useful without EPT.

Paolo

> (BTW, is PCID useful for KPTI performance without INVPCID?)

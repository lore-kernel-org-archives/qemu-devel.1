Received: from eggs.gnu.org ([2001:4830:134:3::10]:59165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fPp7E-0006yN-5A
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 09:01:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fPp78-0002VL-FR
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 09:01:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54098 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fPp78-0002UL-AH
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 09:01:34 -0400
Date: Mon, 4 Jun 2018 14:01:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180604130129.GG19749@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180603092749.107476-1-marcel.apfelbaum@gmail.com>
	<20180604042928-mutt-send-email-mst@kernel.org>
	<20180604125415.GN7451@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180604125415.GN7451@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH RFC] hw/pc: set q35 as the default x86
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, pbonzini@redhat.com, qemu-devel@nongnu.org, rth@twiddle.net

On Mon, Jun 04, 2018 at 09:54:15AM -0300, Eduardo Habkost wrote:
> On Mon, Jun 04, 2018 at 04:38:22AM +0300, Michael S. Tsirkin wrote:
> > On Sun, Jun 03, 2018 at 12:27:49PM +0300, Marcel Apfelbaum wrote:
> > > Moving to QEMU 3.0 seems like a good opportunity for such a change.
> > > 
> > > I440FX is really old and does not support modern features like IOMMU.
> > > Q35's SATA emulation is faster than pc's IDE, native PCI express hotplug
> > > is cleaner than ACPI based one and so on...
> > > 
> > > Also the libvirt guys added very good support for the Q35 machine (thanks!).
> > > 
> > > Management software should always specify the machine type and for the
> > > current setups, adding '-machine pc' to the command line is not such a
> > > big deal.
> > > 
> > > In time the pc machine will fade out and we will probably stop adding
> > > new versions at some point.
> > > 
> > > Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > 
> > For command line users, I think changing the default isn't nice.
> > 
> > Yes it's easy to add -machine pc but there's no documentation
> > that tells you to do so. Add to that shortcuts like -cdrom
> > stop working, hotplug needs extra bridges to work, and one
> > can see that while management tool users benefit from q35,
> > command line users will suffer.
> > 
> > Can't we add a tag for management without changing the command line
> > default? How about "management-default"? "recommended"? "latest"?
> 
> We could add new aliases if they are useful for management
> software, but we would need a well-defined use case and set of
> requirements+expectations for the new alias.

I'm not convinced by the idea of adding a distinct default "for mgmt". All
the problems described wrt 'q35' vs 'pc' apply equally to management apps
as they do to humans. It just happens that one common mgmt layer (libvirt)
knows how to handle some of the complexity of q35. Other mgmt apps though
are just as likely to be hurt by the change as humans are. So effectively
the proposed "for mgmt" is actually  "for libvirt >= some version", which
feels like a layering violation to me.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

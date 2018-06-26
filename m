Received: from eggs.gnu.org ([2001:4830:134:3::10]:40453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fXqYI-0005gw-Mb
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:10:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fXqYG-0001CL-07
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:10:46 -0400
Date: Tue, 26 Jun 2018 17:10:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180626161038.GF32319@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <743d495e-51cd-8c8e-293e-026b8dece74a@redhat.com>
	<87lgb3xsv8.fsf@dusky.pond.sub.org>
	<4292432f-5f26-6925-4c14-ad1370e36e5b@redhat.com>
	<20180625173056.GM7451@localhost.localdomain>
	<97504b42-9ebe-45c5-6ff3-b43102c8374a@redhat.com>
	<20180625195126.GN7451@localhost.localdomain>
	<a931e759-879b-6f6b-3524-4b5a78fed323@redhat.com>
	<20180626122908.GQ7451@localhost.localdomain>
	<577768c0-5205-2fb4-209f-845332fe158d@redhat.com>
	<20180626160623.GT7451@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180626160623.GT7451@localhost.localdomain>
Subject: Re: [Qemu-devel] [RFC PATCH 4/4] qemu-options: Do not show
 -enable-kvm and -enable-hax in the docs anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, zhang.zhanghailiang@huawei.com, Ben Warren <ben@skyportsystems.com>, qemu-trivial@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On Tue, Jun 26, 2018 at 01:06:23PM -0300, Eduardo Habkost wrote:
> On Tue, Jun 26, 2018 at 03:05:33PM +0200, Paolo Bonzini wrote:
> > On 26/06/2018 14:29, Eduardo Habkost wrote:
> > > On Tue, Jun 26, 2018 at 07:57:18AM +0200, Paolo Bonzini wrote:
> > >> On 25/06/2018 21:51, Eduardo Habkost wrote:
> > >>> In either case, I'm not arguing (yet) for changing the default
> > >>> upstream.  I'm just arguing for upstream QEMU to not make any
> > >>> promises about the default.
> > >>
> > >> It would be a guest ABI breakage for TCG guests, so it would only apply
> > >> to new machine types.  I don't think it's worth the complication.
> > > 
> > > That's exactly the point: I want to stop promising a stable guest
> > > ABI when the accelerator is omitted, because I see no benefit in
> > > wasting energy on this.
> > 
> > On the other hand I see no benefit in changing a default that people are
> > obviously not using (since most people use KVM, not TCG).  Distros will
> > keep shipping, and people will keep using qemu-kvm even if we change the
> > default.
> 
> Not changing the default is different from promising we will keep
> ABI compatibility if the accelerator is omitted.  I just want to
> get rid of the latter.

I guess the key question is what is the risk of causing problems if we
switch from tcg to kvm:tcg when accelerator is omitted ?

Based on what I've seen the likely troublespot would be people who are
using QEMU inside a guest with nested-virt enabled. Some nested-virt
impls are buggy and will cause L2 guest hangs, or worse L1 host crashes.
Then again we're not causing that brokenness - just revealing what
already exists.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

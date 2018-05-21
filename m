Received: from eggs.gnu.org ([2001:4830:134:3::10]:60201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fKpnl-00064N-El
	for qemu-devel@nongnu.org; Mon, 21 May 2018 14:44:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fKpnj-00054V-Fe
	for qemu-devel@nongnu.org; Mon, 21 May 2018 14:44:57 -0400
Date: Mon, 21 May 2018 19:44:40 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180521184440.GB8214@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180518180440-mutt-send-email-mst@kernel.org>
	<20180518170956.GI8615@redhat.com>
	<20180518174133.GC25013@localhost.localdomain>
	<87bmdc18q5.fsf@dusky.pond.sub.org>
	<20180521182928.GO25013@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180521182928.GO25013@localhost.localdomain>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, kwolf@redhat.com, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com

On Mon, May 21, 2018 at 03:29:28PM -0300, Eduardo Habkost wrote:
> On Sat, May 19, 2018 at 08:05:06AM +0200, Markus Armbruster wrote:
> > Eduardo Habkost <ehabkost@redhat.com> writes:
> > 
> > [...]
> > > About being more expressive than just a single list of key,value
> > > pairs, I don't see any evidence of that being necessary for the
> > > problems we're trying to address.
> > 
> > Short history of a configuration format you might have encountered:

[snip]

> > How confident are we a single list of (key, value) is really all we're
> > going to need?
> > 
> > Even if we think it is, would it be possible to provide for a future
> > extension to trees at next to no cost?
> 
> I'm confident that a list of key,values is all we need for the
> current problem.

I'm not convinced. A disk image may work with Q35 or i440fx,  or
work with any of virtio, ide or sata disk. So that already means
values have to be arrays, not scalars. You could do that with a
simple key,value list, but only by defining a mapping of arrays
into a flattened form. eg do we allow repeated keys, or do we
allow array indexes on keys. 

> The point here is to allow users to simply copy an existing disk
> image, and it will contain enough hints for a cloud stack to
> choose reasonable defaults for machine-type and disk type
> automatically.  Requiring the user to perform a separate step to
> encapsulate the disk image in another file format defeats the
> whole purpose of the proposal.

It doesn't have to mean more work for the user - the application
that is used to create the image can do that on their behalf.
oVirt for example can import/export OVA files, containing OVF
metadata. I could imagine virt-manager, and other tools adding
export ability without much trouble if this was deemed a desirable
thing. Bundling gives ability to have multiple disk images in one
archive, which is something OVF does.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

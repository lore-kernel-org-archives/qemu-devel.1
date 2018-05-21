Received: from eggs.gnu.org ([2001:4830:134:3::10]:55350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fKpZ2-0006XK-Eb
	for qemu-devel@nongnu.org; Mon, 21 May 2018 14:29:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fKpZ1-00063X-EH
	for qemu-devel@nongnu.org; Mon, 21 May 2018 14:29:44 -0400
Date: Mon, 21 May 2018 15:29:28 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180521182928.GO25013@localhost.localdomain>
References: <20180518180440-mutt-send-email-mst@kernel.org>
	<20180518170956.GI8615@redhat.com>
	<20180518174133.GC25013@localhost.localdomain>
	<87bmdc18q5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bmdc18q5.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, kwolf@redhat.com, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com

On Sat, May 19, 2018 at 08:05:06AM +0200, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
> [...]
> > About being more expressive than just a single list of key,value
> > pairs, I don't see any evidence of that being necessary for the
> > problems we're trying to address.
> 
> Short history of a configuration format you might have encountered:
> 
> 1. A couple of (key, value) is all we ne need for the problems we're
> trying to address.  (v0.4, 2003)
> 
> 2.1. I got this one special snowflake problem where I actually need a few
> related values.  Fortunately, this little ad hoc parser can take apart
> the key's single value easily.  (ca. v0.8, 2005)
> 
> ...
> 
> 2.n. Snowflakes are surprisingly common, but fortunately one more little
> ad hoc parser can't hurt.
> 
> 3. Umm, this is getting messy.  Let's have proper infrastructure for
> two-level keys.  Surely two levels are all we ne need for the problems
> we're trying to address.  Fortunately, we can bolt them on without too
> much trouble.  (v0.12, 2009)
> 
> 4. Err, trees, I'm afraid we actually need trees.  Fortunately, we can
> hack them into the existing two-level infrastructure without too much
> trouble.  (v1.3, 2013)
> 
> 5. You are in a maze of twisting little passages, all different.
> (today)
> 
> 
> How confident are we a single list of (key, value) is really all we're
> going to need?
> 
> Even if we think it is, would it be possible to provide for a future
> extension to trees at next to no cost?

I'm confident that a list of key,values is all we need for the
current problem.

I also agree that being possible to represent trees is a good
idea, and it would probably have next to no cost.

But I disagree if the point here is "we will eventually need much
more complex data in the future, so let's require users to move
to OVF instead".

The point here is to allow users to simply copy an existing disk
image, and it will contain enough hints for a cloud stack to
choose reasonable defaults for machine-type and disk type
automatically.  Requiring the user to perform a separate step to
encapsulate the disk image in another file format defeats the
whole purpose of the proposal.

-- 
Eduardo

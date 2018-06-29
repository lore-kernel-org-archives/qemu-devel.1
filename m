Received: from eggs.gnu.org ([2001:4830:134:3::10]:48148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYvYF-0006ce-NH
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:43:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYvYE-0004Mk-MZ
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:43:11 -0400
Date: Fri, 29 Jun 2018 16:43:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180629154300.GX27016@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180628190723.276458-1-eblake@redhat.com>
	<20180628190723.276458-4-eblake@redhat.com>
	<20180629084444.GC15588@localhost.localdomain>
	<41be61a0-9048-c08f-1a9a-1c213f5103ef@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <41be61a0-9048-c08f-1a9a-1c213f5103ef@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 3/6] qcow2: Reduce REFT_OFFSET_MASK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, berto@igalia.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

On Fri, Jun 29, 2018 at 10:22:22AM -0500, Eric Blake wrote:
> On 06/29/2018 03:44 AM, Kevin Wolf wrote:
> > Am 28.06.2018 um 21:07 hat Eric Blake geschrieben:
> > > Match our code to the spec change in the previous patch - there's
> > > no reason for the refcount table to allow larger offsets than the
> > > L1/L2 tables.
> > 
> > What about internal snapshots? And anyway, because of the metadata
> > overhead, the physical image size of a fully allocated image is always
> > going to be at least minimally larger than the virtual disk size.
> > 
> > I'm not necessarily opposed to making the change if there is a good
> > reason to make it, but I don't see a real need for it and the
> > justification used here and also in the previous patch is incorrect.
> 
> The fact that ext4 cannot hold an image this large is already an indication
> that setting this limit on the refcount table is NOT going to bite real
> users.

NB, RHEL-7 defaults to xfs and this supports file sizes way larger
than ext4 does, so not sure we should consider ext4 as representative
of real world limits anymore.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

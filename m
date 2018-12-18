Received: from eggs.gnu.org ([2001:4830:134:3::10]:58470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gZJKG-0007cC-H1
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 12:38:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gZJKF-0000YK-Cj
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 12:38:36 -0500
Date: Tue, 18 Dec 2018 17:38:01 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181218173801.GG4807@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181218110333.22558-1-philmd@redhat.com>
	<20181218092648-mutt-send-email-mst@kernel.org>
	<028f1498-d0bc-e920-1c7c-9a1f0bdded58@redhat.com>
	<20181218095334-mutt-send-email-mst@kernel.org>
	<42bc04b0-71b7-c9aa-554e-a337351b1e7e@redhat.com>
	<20181218120201-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181218120201-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] Fix strncpy() warnings for GCC8 new
 -Wstringop-truncation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Ben Pye <ben@curlybracket.co.uk>, Stefan Weil <sw@weilnetz.de>, Howard Spoelstra <hsp.cat7@gmail.com>, Jeff Cody <jcody@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Thomas Huth <thuth@redhat.com>, Liu Yuan <namei.unix@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, David Hildenbrand <david@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, 1803872@bugs.launchpad.net, Juan Quintela <quintela@redhat.com>

On Tue, Dec 18, 2018 at 12:03:34PM -0500, Michael S. Tsirkin wrote:
> On Tue, Dec 18, 2018 at 05:38:17PM +0100, Paolo Bonzini wrote:
> > On 18/12/18 15:54, Michael S. Tsirkin wrote:
> > > On Tue, Dec 18, 2018 at 03:45:08PM +0100, Paolo Bonzini wrote:
> > >> On 18/12/18 15:31, Michael S. Tsirkin wrote:
> > >>> Do you happen to know why does it build fine with
> > >>> Gcc 8.2.1?
> > >>>
> > >>> Reading the GCC manual it seems that
> > >>> there is a "nostring" attribute that means
> > >>> "might not be 0 terminated".
> > >>> I think we should switch to that which fixes the warning
> > >>> but also warns if someone tries to misuse these
> > >>> as C-strings.
> > >>>
> > >>> Seems to be a better option, does it not?
> > >>>
> > >>>
> > >>
> > >> Using strpadcpy is clever and self-documenting, though.  We have it
> > >> already, so why not use it.
> > >>
> > >> Paolo
> > > 
> > > The advantage of nonstring is that it will catch attempts to
> > > use these fields with functions that expect a 0 terminated string.
> > > 
> > > strpadcpy will instead just silence the warning.
> > 
> > Ah, I see.  We could also do both, that's a matter of taste.
> > 
> > Paolo
> 
> Do you happen to know how to make gcc check the buffer size
> for strpadcpy? Is the name strncpy just hard-coded?

GCC provides  strncpy as a builtin function and its warning only
checks its builtin.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

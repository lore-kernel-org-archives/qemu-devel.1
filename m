Received: from eggs.gnu.org ([2001:4830:134:3::10]:53266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZGlq-0006Mk-8Q
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:54:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZGlp-0001mE-5M
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:54:54 -0500
Date: Tue, 18 Dec 2018 09:54:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181218095334-mutt-send-email-mst@kernel.org>
References: <20181218110333.22558-1-philmd@redhat.com>
	<20181218092648-mutt-send-email-mst@kernel.org>
	<028f1498-d0bc-e920-1c7c-9a1f0bdded58@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <028f1498-d0bc-e920-1c7c-9a1f0bdded58@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Ben Pye <ben@curlybracket.co.uk>, Stefan Weil <sw@weilnetz.de>, Howard Spoelstra <hsp.cat7@gmail.com>, Jeff Cody <jcody@redhat.com>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Thomas Huth <thuth@redhat.com>, Liu Yuan <namei.unix@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, David Hildenbrand <david@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, 1803872@bugs.launchpad.net, Juan Quintela <quintela@redhat.com>

On Tue, Dec 18, 2018 at 03:45:08PM +0100, Paolo Bonzini wrote:
> On 18/12/18 15:31, Michael S. Tsirkin wrote:
> > Do you happen to know why does it build fine with
> > Gcc 8.2.1?
> > 
> > Reading the GCC manual it seems that
> > there is a "nostring" attribute that means
> > "might not be 0 terminated".
> > I think we should switch to that which fixes the warning
> > but also warns if someone tries to misuse these
> > as C-strings.
> > 
> > Seems to be a better option, does it not?
> > 
> > 
> 
> Using strpadcpy is clever and self-documenting, though.  We have it
> already, so why not use it.
> 
> Paolo

The advantage of nonstring is that it will catch attempts to
use these fields with functions that expect a 0 terminated string.

strpadcpy will instead just silence the warning.


-- 
MST

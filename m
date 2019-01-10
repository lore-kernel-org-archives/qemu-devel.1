Received: from eggs.gnu.org ([209.51.188.92]:37697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ghORY-0005jD-QN
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 19:43:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ghORX-0002nk-4b
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 19:43:32 -0500
Date: Wed, 9 Jan 2019 22:43:07 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190110004307.GE4500@habkost.net>
References: <20190107193020.21744-1-ehabkost@redhat.com>
	<20190107193020.21744-4-ehabkost@redhat.com>
	<20190108064543.asg63onrb3hpripf@sirius.home.kraxel.org>
	<20190108112012.78f3dbb9.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108112012.78f3dbb9.cohuck@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] machine: Use shorter format for
 GlobalProperty arrays
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, xen-devel@lists.xenproject.org, Richard Henderson <rth@twiddle.net>

On Tue, Jan 08, 2019 at 11:20:12AM +0100, Cornelia Huck wrote:
> On Tue, 8 Jan 2019 07:45:43 +0100
> Gerd Hoffmann <kraxel@redhat.com> wrote:
> 
> >   Hi,
> > 
> > > +    { "migration", "decompress-error-check", "off" },
> > > +    { "hda-audio", "use-timer", "false" },
> > > +    { "cirrus-vga", "global-vmstate", "true" },
> > > +    { "VGA", "global-vmstate", "true" },
> > > +    { "vmware-svga", "global-vmstate", "true" },
> > > +    { "qxl-vga", "global-vmstate", "true" },  
> > 
> > I'd like to have the fields aligned.  Especially in cases like this one
> > where multiple devices get the same value assigned it makes things more
> > readable:
> > 
> >     { "migration",   "decompress-error-check", "off"   },
> >     { "hda-audio",   "use-timer",              "false" },
> >     { "cirrus-vga",  "global-vmstate",         "true"  },
> >     { "VGA",         "global-vmstate",         "true"  },
> >     { "vmware-svga", "global-vmstate",         "true"  },
> >     { "qxl-vga",     "global-vmstate",         "true"  },
> > 
> > thanks,
> >   Gerd
> > 
> 
> I'm a bit on the fence here. It does make things more readable (at
> least in your example), but I find editing aligned tables a bit
> annoying. OTOH, that won't happen often, anyway.

I'm unsure, too.  Also, not merging this series is increasing the
likelihood of conflicts with other patches.  I'm queueing this
version, and we can discuss alignment alternatives later.

(I'm less worried about conflicts caused by future alignment
patches because alignment conflicts are easier to sort out than
redoing the .driver/.property/.value conversion).

-- 
Eduardo

Received: from eggs.gnu.org ([209.51.188.92]:40266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ggoUp-00025P-S0
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 05:20:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ggoUm-0006oE-KX
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 05:20:30 -0500
Date: Tue, 8 Jan 2019 11:20:12 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190108112012.78f3dbb9.cohuck@redhat.com>
In-Reply-To: <20190108064543.asg63onrb3hpripf@sirius.home.kraxel.org>
References: <20190107193020.21744-1-ehabkost@redhat.com>
	<20190107193020.21744-4-ehabkost@redhat.com>
	<20190108064543.asg63onrb3hpripf@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, xen-devel@lists.xenproject.org, Richard Henderson <rth@twiddle.net>

On Tue, 8 Jan 2019 07:45:43 +0100
Gerd Hoffmann <kraxel@redhat.com> wrote:

>   Hi,
> 
> > +    { "migration", "decompress-error-check", "off" },
> > +    { "hda-audio", "use-timer", "false" },
> > +    { "cirrus-vga", "global-vmstate", "true" },
> > +    { "VGA", "global-vmstate", "true" },
> > +    { "vmware-svga", "global-vmstate", "true" },
> > +    { "qxl-vga", "global-vmstate", "true" },  
> 
> I'd like to have the fields aligned.  Especially in cases like this one
> where multiple devices get the same value assigned it makes things more
> readable:
> 
>     { "migration",   "decompress-error-check", "off"   },
>     { "hda-audio",   "use-timer",              "false" },
>     { "cirrus-vga",  "global-vmstate",         "true"  },
>     { "VGA",         "global-vmstate",         "true"  },
>     { "vmware-svga", "global-vmstate",         "true"  },
>     { "qxl-vga",     "global-vmstate",         "true"  },
> 
> thanks,
>   Gerd
> 

I'm a bit on the fence here. It does make things more readable (at
least in your example), but I find editing aligned tables a bit
annoying. OTOH, that won't happen often, anyway.

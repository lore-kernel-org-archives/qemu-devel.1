Received: from eggs.gnu.org ([209.51.188.92]:55508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ggl9I-0000Pe-4R
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 01:46:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ggl9D-0003Td-BR
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 01:46:02 -0500
Date: Tue, 8 Jan 2019 07:45:43 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190108064543.asg63onrb3hpripf@sirius.home.kraxel.org>
References: <20190107193020.21744-1-ehabkost@redhat.com>
	<20190107193020.21744-4-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107193020.21744-4-ehabkost@redhat.com>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, xen-devel@lists.xenproject.org, Richard Henderson <rth@twiddle.net>

  Hi,

> +    { "migration", "decompress-error-check", "off" },
> +    { "hda-audio", "use-timer", "false" },
> +    { "cirrus-vga", "global-vmstate", "true" },
> +    { "VGA", "global-vmstate", "true" },
> +    { "vmware-svga", "global-vmstate", "true" },
> +    { "qxl-vga", "global-vmstate", "true" },

I'd like to have the fields aligned.  Especially in cases like this one
where multiple devices get the same value assigned it makes things more
readable:

    { "migration",   "decompress-error-check", "off"   },
    { "hda-audio",   "use-timer",              "false" },
    { "cirrus-vga",  "global-vmstate",         "true"  },
    { "VGA",         "global-vmstate",         "true"  },
    { "vmware-svga", "global-vmstate",         "true"  },
    { "qxl-vga",     "global-vmstate",         "true"  },

thanks,
  Gerd

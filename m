Received: from eggs.gnu.org ([2001:4830:134:3::10]:42646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1faxmM-0003Xd-MO
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 02:30:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1faxmJ-00006E-JZ
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 02:30:10 -0400
Date: Thu, 5 Jul 2018 08:30:03 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180705063003.awyx3lhgrt5nm7it@sirius.home.kraxel.org>
References: <20180704112859.20146-1-kraxel@redhat.com>
	<20180704185321.GZ7451@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704185321.GZ7451@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH] vga: make stdvga the global default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <aleksandar.markovic@mips.com>, Aurelien Jarno <aurelien@aurel32.net>, "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, Sebastian Bauer <mail@sebastianbauer.info>

> > -    m->default_display = "std";
> >      machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
> 
> I wouldn't like to do this.  Long term, it would be a good idea
> to have zero machines with default_display==NULL, so let's keep
> default_machine="std" on PC?

Fine with me, I'll send a v2.

> > -        } else if (vga_interface_available(VGA_CIRRUS)) {
> > -            vga_model = "cirrus";
> >          } else if (vga_interface_available(VGA_STD)) {
> >              vga_model = "std";
> > +        } else if (vga_interface_available(VGA_CIRRUS)) {
> > +            vga_model = "cirrus";
> 
> If we don't make the machines above have default_display=NULL, we
> won't need this hunk, right?  In either case, I suggest doing
> this change on a separate patch.

ok.

cheers,
  Gerd

Received: from eggs.gnu.org ([2001:4830:134:3::10]:34508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cgBe9-0001J0-UE
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:42:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cgBe6-0007eJ-P2
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:42:29 -0500
Message-ID: <1487688140.2694.84.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Feb 2017 15:42:20 +0100
In-Reply-To: <02a49a30-aa68-6484-0957-85009948296e@redhat.com>
References: <1487603763-14932-1-git-send-email-kraxel@redhat.com>
	<02a49a30-aa68-6484-0957-85009948296e@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [RfC PATCH] vga: wire up -g <width>x<height>
 switch for virtio and qxl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

  Hi,

> I think the basic idea of the patch is good, but I'd remove the qxl
> FIXMEs for the final version of the patch (spice is likely not working
> on Sparc and PPC anyway yet).

Sure, just wanted have a rfc out of the door before going debug the qxl
issue.

> > -#ifdef TARGET_SPARC
> > +#if defined(TARGET_SPARC)
> >  int graphic_width =3D 1024;
> >  int graphic_height =3D 768;
> >  int graphic_depth =3D 8;
> > -#else
> > +#elif defined(TARGET_PPC)
> >  int graphic_width =3D 800;
> >  int graphic_height =3D 600;
> >  int graphic_depth =3D 32;
> > +#else
> > +int graphic_width;
> > +int graphic_height;
> > +int graphic_depth;
> >  #endif
>=20
> IMHO we could also switch the default resolution on ppc to 1024x768, so
> you could simplify that code to something like that:

Cc'ing qemu-ppc list.  Comments on the suggestion?

> And maybe Sparc can even work fine with 32 bpp nowadays, too, so you
> could completely get rid of the ifdefery here?

Depends on the sparc display devices, so no for the general case.

I think the better policy would be to just not initialize the graphics_*
variables and let the machine and/or display adapter pick a sane default
then.

cheers,
  Gerd

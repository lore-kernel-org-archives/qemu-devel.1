Received: from eggs.gnu.org ([2001:4830:134:3::10]:55132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dg71p-0003Ex-4f
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 06:18:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dg71n-0005os-R1
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 06:18:53 -0400
Date: Fri, 11 Aug 2017 11:18:36 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170811101836.GI2554@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170810160451.32723-1-berrange@redhat.com>
	<20170810160451.32723-3-berrange@redhat.com>
	<84729972-e3ab-676c-df66-4e28b754728d@redhat.com>
	<20170811091504.GE2554@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170811091504.GE2554@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/8] io: introduce a network socket
 listener API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Fri, Aug 11, 2017 at 10:15:04AM +0100, Daniel P. Berrange wrote:
> On Thu, Aug 10, 2017 at 01:12:25PM -0500, Eric Blake wrote:
> > On 08/10/2017 11:04 AM, Daniel P. Berrange wrote:
> > > The existing QIOChannelSocket class provides the ability to
> > > listen on a single socket at a time. This patch introduces
> > > a QIONetListener class that provides a higher level API
> > > concept around listening for network services, allowing
> > > for listening on multiple sockets.
> > > 
> > > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > > ---
> > 
> > > +++ b/include/io/net-listener.h
> > > @@ -0,0 +1,174 @@
> > > +/*
> > > + * QEMU I/O network listener
> > > + *
> > > + * Copyright (c) 2016 Red Hat, Inc.
> > 
> > Want to add 2017?
> > 
> > At least it's covered by MAINTAINERS :)
> > 
> > 
> > > +/**
> > > + * qio_net_listener_is_disconnected:
> > > + * @listener: the network listener object
> > > + *
> > > + * Determine if the listener is connected to any socket
> > > + * channels
> > > + *
> > > + * Returns: TRUE if connected, FALSE otherwise
> > > + */
> > > +gboolean qio_net_listener_is_disconnected(QIONetListener *listener);
> > > +
> > 
> > Must it return gboolean, or is bool sufficient?
> 
> bool is fine.
> 
> > 
> > TRUE if connected for a function named 'is_disconnected' sounds
> > backwards.  Avoid the double negative, name it:
> > 
> > qio_net_listener_is_connected(), returning true if connected
> 
> The docs are wrong, as you noticed below
> 
> > 
> > > +++ b/io/net-listener.c
> > > @@ -0,0 +1,315 @@
> > > +/*
> > > + * QEMU network listener
> > > + *
> > > + * Copyright (c) 2016 Red Hat, Inc.
> > 
> > More 2017.  Probably for the whole series :)
> > 
> > 
> > > +static gboolean qio_net_listener_channel_func(QIOChannel *ioc,
> > > +                                              GIOCondition condition,
> > > +                                              gpointer opaque)
> > > +{
> > 
> > Again, can we use bool instead of gboolean?
> 
> Yes

Opps, no, this one must be gboolean. The others can be bool though.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

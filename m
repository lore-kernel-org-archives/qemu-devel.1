Received: from eggs.gnu.org ([2001:4830:134:3::10]:33771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dg9EN-00052E-Qh
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 08:40:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dg9EM-0007dY-LA
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 08:39:59 -0400
Date: Fri, 11 Aug 2017 13:39:43 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170811123942.GC2076@work-vm>
References: <20170810160451.32723-1-berrange@redhat.com>
	<20170810160451.32723-3-berrange@redhat.com>
	<20170811122559.GB2076@work-vm> <20170811122936.GK2554@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170811122936.GK2554@redhat.com>
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org

* Daniel P. Berrange (berrange@redhat.com) wrote:
> On Fri, Aug 11, 2017 at 01:26:00PM +0100, Dr. David Alan Gilbert wrote:
> > * Daniel P. Berrange (berrange@redhat.com) wrote:
> > > The existing QIOChannelSocket class provides the ability to
> > > listen on a single socket at a time. This patch introduces
> > > a QIONetListener class that provides a higher level API
> > > concept around listening for network services, allowing
> > > for listening on multiple sockets.
> > 
> > What protects against a connection on more than one of the sockets?
> 
> That's not the responsibility of this module. If a backend only
> wants to allow a single client at a time, it has to unregister
> the new client callback and re-register when it is ready to
> accept a new client. This aspect is no different to the existing
> case of multiple clients connecting to a single listener socket.

OK, and we guarantee that we never call accept() twice because we
make sure we do that unregister before we get back to the main loop?

Dave

> 
> Regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

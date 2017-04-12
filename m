Received: from eggs.gnu.org ([2001:4830:134:3::10]:42661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cyG5x-00076c-8O
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 07:05:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cyG5t-0003hv-Fm
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 07:05:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55250)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cyG5t-0003ha-9l
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 07:05:49 -0400
Date: Wed, 12 Apr 2017 12:05:42 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170412110542.GC12839@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170406210917.6896-1-eblake@redhat.com>
	<877f2pnb2t.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877f2pnb2t.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH] event: Add signal information to SHUTDOWN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>

On Wed, Apr 12, 2017 at 01:02:02PM +0200, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
> > qemu_kill_report() is already able to tell whether a shutdown
> > was triggered by guest action (no output) or by a host signal
> > (a message about termination is printed via error_report); but
> > this information is then lost.  Libvirt would like to be able
> > to distinguish between a SHUTDOWN event triggered solely by
> > guest request and one triggered by a SIGTERM on the host.
> >
> > Enhance the SHUTDOWN event to pass the value of shutdown_signal
> > through to the monitor client, suitably remapped into a
> > platform-neutral string.  Note that mingw lacks decent signal
> 
> I understand the desire to distinguish between guest-initiated and
> host-initiated shutdown, but I'm not sure why libvirt (or anyone) would
> care for the exact signal.  Can you explain?

Libvirt doesn't care from a functional POV - it merely needs to distinguish
host vs guest. Any signal info would merely informational and thus logged.
So signal info would realistically only be used someone is trying to
troubleshoot some problem and needs to understand exactly what triggered
it.


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|

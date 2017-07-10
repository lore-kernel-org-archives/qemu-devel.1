Received: from eggs.gnu.org ([2001:4830:134:3::10]:44285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dUYjR-0002dX-US
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 09:28:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dUYjQ-0000f3-SS
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 09:28:09 -0400
Date: Mon, 10 Jul 2017 14:27:56 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170710132756.GA6770@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1498733831-15254-1-git-send-email-pl@kamp.de>
	<1498733831-15254-3-git-send-email-pl@kamp.de>
	<20170710131007.GE5772@noname.redhat.com>
	<136f3543-665b-a138-1ff0-f96e2aaca0b4@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <136f3543-665b-a138-1ff0-f96e2aaca0b4@kamp.de>
Subject: Re: [Qemu-devel] [PATCH V2 2/8] qapi: add compress parameters to
 Qcow2 Blockdev options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, lersek@redhat.com, den@openvz.org, mreitz@redhat.com, eblake@redhat.com

On Mon, Jul 10, 2017 at 03:24:02PM +0200, Peter Lieven wrote:
> Am 10.07.2017 um 15:10 schrieb Kevin Wolf:
> > Am 29.06.2017 um 12:57 hat Peter Lieven geschrieben:
> > > Signed-off-by: Peter Lieven <pl@kamp.de>
> > > ---
> > >   qapi/block-core.json | 44 +++++++++++++++++++++++++++++++++++++++++++-
> > >   1 file changed, 43 insertions(+), 1 deletion(-)
> > How does this make sense as a runtime option? What would happen if the
> > image contains one compression format and I specify another one on the
> > command line or in blockdev-add?
> > 
> > Shouldn't it just be a create-time option and when you run qemu, it uses
> > whatever format that image has?
> 
> I was asked to add it here. It is indeed only a create option and has no
> other effect.

I think there was some mis-understanding. I suggested adding QAPI schema
to define the options needed during create, and then use QAPI functions
when processing the create. In patch 4 you've just used the traditional
qemu opts functions to query the parameters, so there's no validation
that what's being processed actually matches the QAPI schema. The QAPI
schema additions for create would need to be defined indepenantly of
the runtime options too.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

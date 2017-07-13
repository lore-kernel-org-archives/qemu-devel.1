Received: from eggs.gnu.org ([2001:4830:134:3::10]:44661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dVaH6-0002Fs-OI
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 05:19:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dVaH5-0007Zo-GN
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 05:19:08 -0400
Date: Thu, 13 Jul 2017 10:18:55 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170713091855.GC4011@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1498733831-15254-1-git-send-email-pl@kamp.de>
	<1498733831-15254-3-git-send-email-pl@kamp.de>
	<20170710131007.GE5772@noname.redhat.com>
	<136f3543-665b-a138-1ff0-f96e2aaca0b4@kamp.de>
	<20170710133038.GH5772@noname.redhat.com>
	<bc7a3168-c7de-ad6d-dc7d-09fab4f6e561@kamp.de>
	<20170713085241.GB4139@noname.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170713085241.GB4139@noname.redhat.com>
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org, qemu-devel@nongnu.org, lersek@redhat.com, den@openvz.org, mreitz@redhat.com, eblake@redhat.com

On Thu, Jul 13, 2017 at 10:52:41AM +0200, Kevin Wolf wrote:
> Am 13.07.2017 um 10:45 hat Peter Lieven geschrieben:
> > Am 10.07.2017 um 15:30 schrieb Kevin Wolf:
> > >Am 10.07.2017 um 15:24 hat Peter Lieven geschrieben:
> > >>Am 10.07.2017 um 15:10 schrieb Kevin Wolf:
> > >>>Am 29.06.2017 um 12:57 hat Peter Lieven geschrieben:
> > >>>>Signed-off-by: Peter Lieven <pl@kamp.de>
> > >>>>---
> > >>>>  qapi/block-core.json | 44 +++++++++++++++++++++++++++++++++++++++++++-
> > >>>>  1 file changed, 43 insertions(+), 1 deletion(-)
> > >>>How does this make sense as a runtime option? What would happen if the
> > >>>image contains one compression format and I specify another one on the
> > >>>command line or in blockdev-add?
> > >>>
> > >>>Shouldn't it just be a create-time option and when you run qemu, it uses
> > >>>whatever format that image has?
> > >>I was asked to add it here. It is indeed only a create option and has
> > >>no other effect.
> > >But if it's only a create option, why is it added to blockdev-add?
> > 
> > Is there already a separate schemata for the create options?
> 
> If you mean a separate schema file, no. Putting it in the same file
> isn't a problem either, but hooking it up in structs used by
> blockdev-add (or other QMP commands) probably is.
> 
> So if you want to follow Dan's suggestion, I think you just need to put
> the new type into the schema, without referencing it anywhere except in
> qcow2's .bdrv_create C implementation.

Yep, that's exactly what I intended by my suggestion

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

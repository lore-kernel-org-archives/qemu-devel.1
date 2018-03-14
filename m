Received: from eggs.gnu.org ([2001:4830:134:3::10]:33239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ew4Re-00073O-Jt
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 07:19:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ew4Rd-0005uX-Ek
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 07:19:46 -0400
Date: Wed, 14 Mar 2018 11:19:36 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180314111936.GE17603@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180309214611.19122-1-kwolf@redhat.com>
	<20180309214611.19122-4-kwolf@redhat.com>
	<660ad007-7a00-6b0e-5700-e1c9274b2f6d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <660ad007-7a00-6b0e-5700-e1c9274b2f6d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/7] qcow: Support .bdrv_co_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, den@openvz.org, jcody@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

On Wed, Mar 14, 2018 at 06:16:18AM -0500, Eric Blake wrote:
> On 03/09/2018 03:46 PM, Kevin Wolf wrote:
> > This adds the .bdrv_co_create driver callback to qcow, which
> > enables image creation over QMP.
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >   qapi/block-core.json |  21 +++++-
> >   block/qcow.c         | 196 ++++++++++++++++++++++++++++++++++-----------------
> >   2 files changed, 150 insertions(+), 67 deletions(-)
> 
> >   ##
> > +# @BlockdevCreateOptionsQcow:
> > +#
> > +# Driver specific image creation options for qcow.
> > +#
> > +# @file             Node to create the image format on
> > +# @size             Size of the virtual disk in bytes
> > +# @backing-file     File name of the backing file if a backing file
> > +#                   should be used
> > +# @encrypt          Encryption options if the image should be encrypted
> 
> Idea for followup patch - we should strongly document that encryption of
> qcow is discouraged as insecure, and/or mention that qcow2 is generally a
> better option than qcow when creating images over QMP.

Yes to the encryption note, but we should definitely document that
'qcow' is deprecated in general - there's little good reason you would
want to use it - it has terrible performance when allocating new clusters.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

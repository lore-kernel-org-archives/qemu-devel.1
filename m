Received: from eggs.gnu.org ([2001:4830:134:3::10]:40672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dGLfI-0006dW-6D
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 04:41:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dGLfH-00078y-82
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 04:41:08 -0400
Date: Thu, 1 Jun 2017 09:40:57 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170601084057.GD1490@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170509173342.29286-1-berrange@redhat.com>
	<20170509173342.29286-6-berrange@redhat.com>
	<1762f0c5-9881-99bb-6134-2877257d2895@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1762f0c5-9881-99bb-6134-2877257d2895@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 5/5] iotests: chown LUKS device before
 qemu-io launches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Wed, May 31, 2017 at 06:15:27PM +0200, Max Reitz wrote:
> On 2017-05-09 19:33, Daniel P. Berrange wrote:
> > On some distros, whenever you close a block device file
> > descriptor there is a udev rule that resets the file
> > permissions. This can race with the test script when
> > we run qemu-io multiple times against the same block
> > device. Occasionally the second qemu-io invocation
> > will find udev has reset the permissions causing failure.
> > 
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  tests/qemu-iotests/149     |  13 +-
> >  tests/qemu-iotests/149.out | 344 ++++++++++++++++++++++-----------------------
> >  2 files changed, 178 insertions(+), 179 deletions(-)
> > 
> > diff --git a/tests/qemu-iotests/149 b/tests/qemu-iotests/149
> > index 5faf585..bc628ce 100755
> > --- a/tests/qemu-iotests/149
> > +++ b/tests/qemu-iotests/149
> > @@ -23,6 +23,7 @@
> >  import subprocess
> >  import os
> >  import os.path
> > +import time
> 
> Why?

That's left over cruft from debugging this test. I'll kill it.

> Rest looks good.

Does that count for "reviewed-by" if i kill the import ?

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

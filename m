Received: from eggs.gnu.org ([2001:4830:134:3::10]:39138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dqM3I-0006wb-P9
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 12:22:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dqM3F-0004Yq-LW
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 12:22:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dqM3F-0004Xi-Fm
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 12:22:41 -0400
Date: Fri, 8 Sep 2017 17:22:35 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170908162235.GL32645@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170724181544.20292-1-brandon.carpenter@cypherpath.com>
	<20170725083603.GC26394@redhat.com>
	<1504887484.8245.0@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1504887484.8245.0@smtp.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] io: Always remove an old channel watch
 before adding a new one.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brandon Carpenter <brandon.carpenter@cypherpath.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com

On Fri, Sep 08, 2017 at 09:18:04AM -0700, Brandon Carpenter wrote:
> I haven't seen this patch hit master yet and am about to submit a patch set
> that is dependent on this one because it triggers the bug fixed by this
> patch, causing a segmentation fault. Is it preferred that I include this
> patch in that series with the Reviewed-by: tags or to just reference this
> patch in the cover letter?

Yes, if you re-post the patch as part of a larger just, add any
Reviewed-by tags to the commit message when you re-post.

> On Tue, Jul 25, 2017 at 1:36 AM, Daniel P. Berrange <berrange@redhat.com>
> wrote:
> > On Mon, Jul 24, 2017 at 11:15:44AM -0700, Brandon Carpenter wrote:
> > >  Also set saved handle to zero when removing without adding a new
> > > watch.
> > > 
> > >  Signed-off-by: Brandon Carpenter <brandon.carpenter@cypherpath.com>
> > >  ---
> > >   ui/vnc-auth-vencrypt.c | 3 +++
> > >   ui/vnc-ws.c            | 6 ++++++
> > >   ui/vnc.c               | 4 ++++
> > >   3 files changed, 13 insertions(+)
> > 
> > Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
> > 
> > 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

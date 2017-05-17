Received: from eggs.gnu.org ([2001:4830:134:3::10]:34249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dAxsk-0002U0-KM
	for qemu-devel@nongnu.org; Wed, 17 May 2017 08:16:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dAxsZ-0000gK-0h
	for qemu-devel@nongnu.org; Wed, 17 May 2017 08:16:46 -0400
Date: Wed, 17 May 2017 13:15:23 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170517121523.GG970@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170505102153.758-1-famz@redhat.com>
	<20170517021302.GF27669@lemon.lan>
	<20170517115932.GC4856@noname.redhat.com>
	<20170517121051.GC17629@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170517121051.GC17629@lemon.lan>
Subject: Re: [Qemu-devel] [PATCH] iotests: 147: Don't test inet6 if not
 available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Wed, May 17, 2017 at 08:10:51PM +0800, Fam Zheng wrote:
> On Wed, 05/17 13:59, Kevin Wolf wrote:
> > Am 17.05.2017 um 04:13 hat Fam Zheng geschrieben:
> > > On Fri, 05/05 18:21, Fam Zheng wrote:
> > > > This is the case in our docker tests, as we use --net=none there. Skip
> > > > this method.
> > > 
> > > Ping. Is this patch okay?
> > 
> > I thought you might want to respond to Dan's comment. If you don't plan
> > to make the change he suggests, let me know and I'll queue the patch as
> > it is.
> 
> This check is enough for me and I think it's good to go.

That's fine with me - i didn't intend my comments to be a blocker. In
general getaddrinfo should only return IPv6 addrs, if IPv6 is actually
usable.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

Received: from eggs.gnu.org ([2001:4830:134:3::10]:35383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnn1N-0005Gh-GR
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 10:34:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnn1M-0004GX-L3
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 10:34:09 -0400
Date: Fri, 1 Sep 2017 15:33:48 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170901143348.GP31680@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170901105434.3288-1-berrange@redhat.com>
	<5fff868d-4d35-ec3f-cdd8-9b7363c4e6d3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5fff868d-4d35-ec3f-cdd8-9b7363c4e6d3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] Fix / skip recent iotests with LUKS
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

On Fri, Sep 01, 2017 at 09:26:30AM -0500, Eric Blake wrote:
> On 09/01/2017 05:54 AM, Daniel P. Berrange wrote:
> > Two recently added iotests are currently breaking 'check -luks',
> > fix the easy one and disable the hard one.
> > 
> > Daniel P. Berrange (2):
> >   iotests: rewrite 192 to use _launch_qemu to fix LUKS support
> >   iotests: blacklist 194 with the luks driver
> 
> Since both tests involve an NBD server, I can take this series through
> my NBD queue.  Or, since both involve LUKS, you can push it in your next
> crypto pull request.  Any preferences?

Best if either you or a block maintainer queue it i think

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

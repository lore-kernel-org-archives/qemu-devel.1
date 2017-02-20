Received: from eggs.gnu.org ([2001:4830:134:3::10]:48481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cfnA1-0004E1-9O
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 07:33:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cfnA0-0006Pn-Cc
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 07:33:45 -0500
Date: Mon, 20 Feb 2017 12:33:33 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170220123333.GM15874@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170203120254.15062-1-berrange@redhat.com>
	<20170203120254.15062-5-berrange@redhat.com>
	<a022512c-83c6-2059-bee9-dd7dc368d6f6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a022512c-83c6-2059-bee9-dd7dc368d6f6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/6] qemu-img: add support for -o arg to
 dd command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>

On Fri, Feb 03, 2017 at 11:07:13PM +0100, Max Reitz wrote:
> On 03.02.2017 13:02, Daniel P. Berrange wrote:
> > The -o arg to the convert command allows specification of format/protocol
> > options for the newly created image. This adds a -o arg to the dd command
> > to get feature parity.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  qemu-img-cmds.hx |  2 +-
> >  qemu-img.c       | 32 +++++++++++++++++++++++++++++++-
> >  qemu-img.texi    |  6 ++++--
> >  3 files changed, 36 insertions(+), 4 deletions(-)
> 
> I don't like this patch for the same reasons as for patch 3, but I like
> it a bit better. The code introduced here is exactly the same as for
> img_convert(), so merging the two would (or "is going to", I hope) be
> trivial.
> 
> So a pretty weak
> 
> Reviewed-by: Max Reitz <mreitz@redhat.com>

Again, I'll drop this patch for now.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|

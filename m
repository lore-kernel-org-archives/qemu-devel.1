Received: from eggs.gnu.org ([2001:4830:134:3::10]:45876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eEBva-0003yd-BX
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 05:25:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eEBvZ-0007kN-Fv
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 05:25:18 -0500
Date: Mon, 13 Nov 2017 10:25:08 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171113102508.GB18828@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171110221329.24176-1-mreitz@redhat.com>
	<20171110221329.24176-4-mreitz@redhat.com>
	<bca02e7e-3a75-0f37-eebd-7b5a948109b6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bca02e7e-3a75-0f37-eebd-7b5a948109b6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12 3/3] block: Deprecate "backing": ""
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On Fri, Nov 10, 2017 at 04:21:05PM -0600, Eric Blake wrote:
> On 11/10/2017 04:13 PM, Max Reitz wrote:
> > We have a clear replacement, so let's deprecate it.
> > 
> > Signed-off-by: Max Reitz <mreitz@redhat.com>
> > ---
> >  qapi/block-core.json | 4 ++--
> >  block.c              | 4 ++++
> >  qemu-doc.texi        | 7 +++++++
> >  qemu-options.hx      | 4 ++--
> >  4 files changed, 15 insertions(+), 4 deletions(-)
> 
> Dan has more details on the proper documentation to tweak when declaring
> something deprecated.  So this patch is incomplete, but what you have
> makes sense.

Its ok, Max has added to the relevant appendix in qemu-doc.texi

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

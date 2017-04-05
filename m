Received: from eggs.gnu.org ([2001:4830:134:3::10]:48721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cvg9U-0005PP-Hc
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:18:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cvg9T-00015n-0o
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:18:52 -0400
Date: Wed, 5 Apr 2017 09:18:35 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20170405081835.GB30620@redhat.com>
References: <20170118161653.19296-1-eblake@redhat.com>
	<20170118161653.19296-3-eblake@redhat.com>
	<87lgu7flkc.fsf@dusky.pond.sub.org>
	<9e16eb02-dc8b-b25f-0aba-d4a9ff3b5a02@redhat.com>
	<274218e6-5539-9eef-56bc-c2de4d11a593@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <274218e6-5539-9eef-56bc-c2de4d11a593@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/6] qdict: Add convenience helpers for
 wrapped puts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Gerd Hoffmann <kraxel@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Alberto Garcia <berto@igalia.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Anthony Perard <anthony.perard@citrix.com>, Fam Zheng <famz@redhat.com>, Chrysostomos Nanakos <chris@include.gr>, Stefan Weil <sw@weilnetz.de>, Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "open list:X86" <xen-devel@lists.xensource.com>, Stefan Hajnoczi <stefanha@redhat.com>, Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Julia Lawall <julia.lawall@lip6.fr>

On Tue, Apr 04, 2017 at 05:41:08PM -0500, Eric Blake wrote:
> On 01/19/2017 08:38 AM, Eric Blake wrote:
> > On 01/19/2017 03:25 AM, Markus Armbruster wrote:
> >> Eric Blake <eblake@redhat.com> writes:
> >>
> >>> Quite a few users of qdict_put() were manually wrapping a
> >>> non-QObject. We can make such call-sites shorter, by providing
> >>> common macros to do the tedious work.  Also shorten nearby
> >>> qdict_put_obj(,,QOBJECT()) sequences.
> >>>
> >>> Signed-off-by: Eric Blake <eblake@redhat.com>
> >>> Reviewed-by: Alberto Garcia <berto@igalia.com>
> >>>
> >>> ---
> >>>
> >>> v2: rebase to current master
> >>>
> >>> I'm okay if you want me to break this patch into smaller pieces.
> >>
> >> I guess I'm okay with a single piece, but I'd like to know how you did
> >> the conversion.  Coccinelle?  Manually?
> > 
> > Manual, via grepping for put_obj.*QOBJECT. I'll see if I can do the same
> > under Coccinelle (at which point, committing the script will make it
> > easier to rerun cleanups if later code reintroduces poor usage
> > patterns), so maybe I have a v3 coming up.
> 
> I've got a Coccinelle patch (mostly) working now - but it has one
> shortfall - I found places in tests/check-qdict.c that coccinelle
> didn't, and traced it to the fact that our use of g_assert_cmpint(expr,
> ==, expr) throws off the coccinelle parser so badly that it silently
> ignores the entire function body containing the use of that macro.

Julia ^ is this a known issue?

If Eric is using the Fedora version of coccinelle, then he would be
using either 1.0.6 or 1.0.5.

> v3 will be posted soon, with the best of both worlds (coccinelle
> caught spots that I missed, not to mention recent code base changes;
> and my manual search found the spots in tests/ that coccinelle
> missed).

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html

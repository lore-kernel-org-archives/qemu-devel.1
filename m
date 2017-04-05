Received: from eggs.gnu.org ([2001:4830:134:3::10]:36439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cvgpS-0005kM-C1
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 05:02:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cvgpP-0000ni-6l
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 05:02:14 -0400
Date: Wed, 5 Apr 2017 10:01:51 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20170405090151.GK30620@redhat.com>
References: <20170118161653.19296-1-eblake@redhat.com>
	<20170118161653.19296-3-eblake@redhat.com>
	<87lgu7flkc.fsf@dusky.pond.sub.org>
	<9e16eb02-dc8b-b25f-0aba-d4a9ff3b5a02@redhat.com>
	<274218e6-5539-9eef-56bc-c2de4d11a593@redhat.com>
	<20170405081835.GB30620@redhat.com>
	<alpine.DEB.2.20.1704051020170.3005@hadrien>
	<20170405082443.GD30620@redhat.com>
	<alpine.DEB.2.20.1704051037490.3005@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1704051037490.3005@hadrien>
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
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Gerd Hoffmann <kraxel@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Alberto Garcia <berto@igalia.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Anthony Perard <anthony.perard@citrix.com>, Fam Zheng <famz@redhat.com>, Chrysostomos Nanakos <chris@include.gr>, Stefan Weil <sw@weilnetz.de>, Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "open list:X86" <xen-devel@lists.xensource.com>, Stefan Hajnoczi <stefanha@redhat.com>, Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Apr 05, 2017 at 10:38:37AM +0200, Julia Lawall wrote:
> OK, there is nothing special about g_assert_cmpint, but Coccinelle expects
> expressions or types in function argument lists, so it gives a parse error
> on finding an ==.

I should have checked the coccinelle mailing list before asking you,
because I see that Eric already asked this question and you answered
it.  For reference, that is here:

  https://systeme.lip6.fr/pipermail/cocci/2017-April/004107.html

Thanks again,

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org

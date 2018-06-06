Received: from eggs.gnu.org ([2001:4830:134:3::10]:33716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fQWo8-0000Hg-Hr
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 07:40:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fQWo7-0006he-B6
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 07:40:52 -0400
Date: Wed, 6 Jun 2018 12:40:35 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20180606114035.GG1455@redhat.com>
References: <20180524113251.GB4660@redhat.com>
	<d9bb2cb9-d9dc-8fe0-a767-10d9cbbab803@redhat.com>
	<20180528183058.GG2209@redhat.com>
	<20180528183833.GJ4580@localhost.localdomain>
	<20180528212054.GH2209@redhat.com>
	<20180528212510.GC4660@redhat.com>
	<20180529064415.GA4756@localhost.localdomain>
	<2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
	<20180606123237.2235ae4a@kitsune.suse.cz>
	<bc97cdc3-85ba-e053-0816-b6bc431064fb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc97cdc3-85ba-e053-0816-b6bc431064fb@redhat.com>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com, ehabkost@redhat.com, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On Wed, Jun 06, 2018 at 01:02:53PM +0200, Max Reitz wrote:
> (I'm wondering if we could write a block driver that could provide such
> a chunk allocation transparently to qcow2...  Note that a qcow2 file
> does not need to be continuous, so you could in theory indeed store the
> qcow2 file and its data in completely separate places in a tar file.)

nbdkit-split-plugin
(https://github.com/libguestfs/nbdkit/tree/master/plugins/split).  It
currently doesn't support resizing although it could do fairly easily.

> Yeah, but why make qcow2 that format?  That's what I completely fail to
> understand.

I started off a long reply here, but I think you're right.  If we
cannot make people decide on and use a proper disk image + metadata
container, then it's also unlikely we'll get them to add sensible
metadata to their qcow2 images either :-(

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org

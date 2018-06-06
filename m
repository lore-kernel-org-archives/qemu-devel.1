Received: from eggs.gnu.org ([2001:4830:134:3::10]:53215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fQZec-0001Uf-S5
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:43:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fQZeb-0007MF-Op
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:43:14 -0400
Date: Wed, 6 Jun 2018 17:43:03 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180606173140-mutt-send-email-mst@kernel.org>
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
Cc: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>, Kevin Wolf <kwolf@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com, ehabkost@redhat.com, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>

On Wed, Jun 06, 2018 at 01:02:53PM +0200, Max Reitz wrote:
> Yeah, but why make qcow2 that format?  That's what I completely fail to
> understand.

Because why not? It's cheap to add it there and is much easier
than teaching people about a new container format.

Eric Blake put it very well I think.  There are several things that
several people would like to see addressed:

(1) A sensible list of guest visible aspects of the VM
  preserving which across VM restarts we deem critical enough to support
  starting guests.
  At this point this includes at least architecture and machine type.

(2) A compact file format for serializing list (1)

(3) Ability to store file (2) in a qcow2 image


You are asking why store (2) in qcow2 image specifically. The answer is
it's just one place where we can store it. The answer is we don't need
to involve qemu-block at all for storing it in other places.

But for many people it will be handy to have it in the same file, and
qcow2 is popular enough that many people will be well served if it's
there.

-- 
MT

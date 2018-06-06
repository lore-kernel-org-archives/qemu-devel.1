Received: from eggs.gnu.org ([2001:4830:134:3::10]:58928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fQZqi-0003IB-0K
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:55:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fQZqh-0005Fm-7S
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:55:44 -0400
Date: Wed, 6 Jun 2018 17:55:37 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180606174635-mutt-send-email-mst@kernel.org>
References: <20180528212510.GC4660@redhat.com>
	<20180529064415.GA4756@localhost.localdomain>
	<2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
	<20180606123237.2235ae4a@kitsune.suse.cz>
	<bc97cdc3-85ba-e053-0816-b6bc431064fb@redhat.com>
	<20180606131929.44d0fd6b@kitsune.suse.cz>
	<93233bff-604b-c891-90ce-64fe1eaaaab5@redhat.com>
	<20180606113720.GA2661@work-vm>
	<2c833e2c-f0bb-ea98-a703-54fb9447bd2f@redhat.com>
	<20180606134233.GQ7451@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606134233.GQ7451@localhost.localdomain>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com

On Wed, Jun 06, 2018 at 10:42:33AM -0300, Eduardo Habkost wrote:
> > If we want a grand vision where a single file stores the whole VM, why
> > not invest the work and make it right from the start?
> 
> We don't want a grand vision where a single file stores the whole
> VM.  This is exactly what I would like to avoid, by not inventing
> a whole different appliance file format.

Besides, trying to get a grand vision from the start is a sure
way to never have the design leave the drawing board.

What we are asking for at this point is a way to stick a named blob in
an image that people can use with qemu without jumping through hoops.

It seems like a generic enough addition that it seems highly likely
to be useful down the road and harmless enough that maintaining
it won't become a burden.

Can we agree on that as a first step, so we can build that foundation
and move on to actually building ways to use it?

-- 
MST

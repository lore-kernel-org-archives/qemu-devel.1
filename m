Received: from eggs.gnu.org ([2001:4830:134:3::10]:48881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fSNX7-0006eN-TA
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:10:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fSNX6-00042G-PE
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:10:57 -0400
Date: Mon, 11 Jun 2018 16:10:43 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180611141043.GG15038@localhost.localdomain>
References: <20180529064415.GA4756@localhost.localdomain>
	<2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
	<20180606123237.2235ae4a@kitsune.suse.cz>
	<bc97cdc3-85ba-e053-0816-b6bc431064fb@redhat.com>
	<20180606131929.44d0fd6b@kitsune.suse.cz>
	<93233bff-604b-c891-90ce-64fe1eaaaab5@redhat.com>
	<20180606113720.GA2661@work-vm>
	<2c833e2c-f0bb-ea98-a703-54fb9447bd2f@redhat.com>
	<20180606134233.GQ7451@localhost.localdomain>
	<20180606174635-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606174635-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>, qemu-block@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com

Am 06.06.2018 um 16:55 hat Michael S. Tsirkin geschrieben:
> On Wed, Jun 06, 2018 at 10:42:33AM -0300, Eduardo Habkost wrote:
> > > If we want a grand vision where a single file stores the whole VM, why
> > > not invest the work and make it right from the start?
> > 
> > We don't want a grand vision where a single file stores the whole
> > VM.  This is exactly what I would like to avoid, by not inventing
> > a whole different appliance file format.
> 
> Besides, trying to get a grand vision from the start is a sure
> way to never have the design leave the drawing board.
> 
> What we are asking for at this point is a way to stick a named blob in
> an image that people can use with qemu without jumping through hoops.
> 
> It seems like a generic enough addition that it seems highly likely
> to be useful down the road and harmless enough that maintaining
> it won't become a burden.
> 
> Can we agree on that as a first step, so we can build that foundation
> and move on to actually building ways to use it?

As you don't seem to believe Max, here's my opinion: No.

I'm okay with adding some well-specified information to qcow2 (I'm
thinking of a JSON document that is validated against a schema) where
the meaning is clear from the qcow2 spec, for all users.

Allowing undefined blobs would add data to qcow2 images whose meaning is
only understood by whatever highlevel tool that wrote it, and thereby
fragment the one qcow2 format that we have today into many subformats
whose specs are scattered all over the net (if they even exist). This is
not where I want to go.

So before I'll even think of adding some extra information, we're back
to what I already said two weeks ago: Show me what you want to store
there. If we go with my proposal to use JSON, show me the JSON schema
(with doc comments, obviously) and we'll talk.

Kevin

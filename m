Received: from eggs.gnu.org ([2001:4830:134:3::10]:60018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fskJ7-0004cP-JB
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 03:45:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fskHA-00080S-Oo
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 03:43:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40344 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fskHA-000808-Kj
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 03:43:28 -0400
Date: Thu, 23 Aug 2018 09:43:21 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180823074321.wx7wix7jwsfrcbk5@sirius.home.kraxel.org>
References: <20180822095421.11765-1-quintela@redhat.com>
	<20180822095421.11765-8-quintela@redhat.com>
	<0d3a215b-4916-b0a6-5654-5d64fcf6c996@redhat.com>
	<87y3cyo4ax.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y3cyo4ax.fsf@trasno.org>
Subject: Re: [Qemu-devel] [PATCH v3 07/10] check: Only test boot-serial when
 sga is compiled in
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

> > Reviewed-by: Thomas Huth <thuth@redhat.com>
> >
> > Off-topic: I wonder whether we could even deprecate the SGA device
> > nowadays, since the main seabios now can redirect the console to the
> > serial port, too?
> 
> No idea, but then I think we can deprecate it, we already have enough
> weird things around.

Deprecating sure.  Actually dropping is not so easy I think.  The switch
is not transparent to the guest, which implies live migration
compatibility isssues.

So the only thing we can do is blocking it for new machine types (3.1+).
Then, in a bunch of years when we deprecate 3.1 & older machine types,
we can actually remove it.

I remember we even discussed that a while back ...
Oh yes: https://git.kraxel.org/cgit/qemu/commit/?h=work/no-sgabios&id=408690999429fdf44011c49b3af6efa50f369b1e
Somehow never ended up being merged.

cheers,
  Gerd

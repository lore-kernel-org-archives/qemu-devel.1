Received: from eggs.gnu.org ([2001:4830:134:3::10]:54709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <msuchanek@suse.de>) id 1fSI0E-0000zI-D2
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 04:16:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <msuchanek@suse.de>) id 1fSI0D-0005rD-EW
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 04:16:38 -0400
Date: Mon, 11 Jun 2018 10:16:28 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Message-ID: <20180611101628.7997f256@naga.suse.cz>
In-Reply-To: <20180611044053-mutt-send-email-mst@kernel.org>
References: <20180606111406.GD2660@work-vm>
	<9e8b49fb-0162-bf35-21bb-acc0dc28555f@redhat.com>
	<20180606120050.GB2661@work-vm>
	<61a301dd-8e50-8799-8328-341d6ab744f5@redhat.com>
	<20180606143134.GG2660@work-vm>
	<39bcee27-329a-61d8-47fa-678b431b0a79@redhat.com>
	<20180606175551-mutt-send-email-mst@kernel.org>
	<8fc775cd-f98c-c795-3935-855e56f01b68@redhat.com>
	<20180608002005-mutt-send-email-mst@kernel.org>
	<5dc0b886-a7c3-50a6-e4db-bde26919af3a@redhat.com>
	<20180611044053-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, armbru@redhat.com, qemu-devel@nongnu.org, "Richard
	W.M. Jones" <rjones@redhat.com>, stefanha@redhat.com, "Dr. David Alan
	Gilbert" <dgilbert@redhat.com>

On Mon, 11 Jun 2018 05:06:53 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Sat, Jun 09, 2018 at 11:34:03PM +0200, Max Reitz wrote:
....
> > Dave was saying that the worst thing about the whole q35 thing is
> > that users download an image and have no idea why it isn't
> > working.  Figuring that out may take a long time, because nothing
> > is even throwing an error message.
> > 
> > If we had a new format, users couldn't even run it in qemu, so they
> > would quickly figure out that in order to run this VM, they need to
> > update their stack.  
> 
> Since then users of old software can't use your
> image at all, then most people simply will not create
> the new fangled image format.

They will have to because without the new fangles the images just don't
work.

> 
> > If we just add this information to qcow2, those users with outdated
> > qemu versions would again have to figure out why the image isn't
> > working.  
> 
> By that metric compatibility is never worth it unless you have
> ability to add new functionality retroactively to existing
> software.

Compatibility is worth it when you add a new extension that is useful
but not critical. When the image does not work without interpreting the
extended metadata, the failure is hard to diagnose, and old versions of
qemu just ignore the extended metadata the extension failed the primary
purpose: making images work out of the box.

Thanks

Michal

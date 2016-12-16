Received: from eggs.gnu.org ([2001:4830:134:3::10]:38449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cHoNV-0002sS-Ep
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 04:00:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cHoNR-0003lA-88
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 04:00:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1cHoNR-0003jY-2L
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 04:00:29 -0500
Date: Fri, 16 Dec 2016 10:00:24 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20161216090024.GA4434@noname.redhat.com>
References: <20161214142518.10504-1-stefanha@redhat.com>
	<20161215063226-mutt-send-email-mst@kernel.org>
	<20161215075028.GD26169@stefanha-x1.localdomain>
	<1481793479.21413.6.camel@redhat.com>
	<20161215170523-mutt-send-email-mst@kernel.org>
	<1481819150.21413.21.camel@redhat.com>
	<20161215202505-mutt-send-email-mst@kernel.org>
	<20161215211838-mutt-send-email-mst@kernel.org>
	<d6eb5b6d-3e8b-be10-33b6-289ef1ffec1a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6eb5b6d-3e8b-be10-33b6-289ef1ffec1a@redhat.com>
Subject: Re: [Qemu-devel] regression in 2.8: unable to exit screen grab in
 SDL mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Cole Robinson <crobinso@redhat.com>

Am 16.12.2016 um 09:26 hat Thomas Huth geschrieben:
> On 15.12.2016 20:19, Michael S. Tsirkin wrote:
> > On Thu, Dec 15, 2016 at 09:15:27PM +0200, Michael S. Tsirkin wrote:
> >> On Thu, Dec 15, 2016 at 05:25:50PM +0100, Gerd Hoffmann wrote:
> >>>> Do we fix this or disable SDL altogether?
> >>>
> >>> Well, it can't be *that* bad, otherwise it would not went unnoticed for
> >>> a whole release cycle.
> >>
> >> That's what I'm saying, maybe no one uses SDL anymore.
> 
> It's maybe not as common as the GTK interface, but as far as I know
> people still use the SDL interface. For example here:
> 
>  https://bugs.launchpad.net/qemu/+bug/922076
> 
> ... so I would recommend to keep the SDL code in QEMU.

When I actualy use qemu rather than just doing a quick test, I generally
prefer SDL, too, because the GTK frontend still grabs some keys like F10
for itself instead of passing them to the guest. And using HMP for
something as simple as that - no, thanks.

Kevin

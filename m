Received: from eggs.gnu.org ([2001:4830:134:3::10]:49542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=869086d29=anthony.perard@citrix.com>)
	id 1gUBdQ-0007jL-5m
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:25:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=869086d29=anthony.perard@citrix.com>)
	id 1gUBdM-0001Cs-47
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:25:12 -0500
Date: Tue, 4 Dec 2018 14:24:59 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181204142459.GV14786@perard.uk.xensource.com>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
	<20181121151211.15997-8-paul.durrant@citrix.com>
	<20181203162424.GM14786@perard.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181203162424.GM14786@perard.uk.xensource.com>
Subject: Re: [Qemu-devel] [PATCH 07/18] xen: add event channel interface for
 XenDevice-s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>

On Mon, Dec 03, 2018 at 04:24:24PM +0000, Anthony PERARD wrote:
> On Wed, Nov 21, 2018 at 03:12:00PM +0000, Paul Durrant wrote:
> > +static void xen_device_event(void *opaque)
> > +{
> > +    XenDevice *xendev = opaque;
> > +    unsigned long port = xenevtchn_pending(xendev->xeh);
> > +
> > +    notifier_list_notify(&xendev->event_notifiers, (void *)port);
> 
> I wonder if a Notifier is a good fit for XenDevice, like here for the
> events or the xenstore watches in previous patches, as NotifierLists are
> normaly used when every Notifiers want to do something, but here there
> is only one that is going to do something. But I guess it might not be
> much better to write a loop in here rather than use the one in
> notifier_list_notify.

I've seen that you use GHashTable in a following patch, wouldn't that be
useful to use for xenstore watches and evtchn events as well?


-- 
Anthony PERARD

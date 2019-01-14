Received: from eggs.gnu.org ([209.51.188.92]:50079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9106bec1f=anthony.perard@citrix.com>)
	id 1gj12F-0004pL-NX
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:08:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9106bec1f=anthony.perard@citrix.com>)
	id 1gj12D-0005HZ-SP
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:08:07 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:49088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=9106bec1f=anthony.perard@citrix.com>)
	id 1gj12B-0005FB-V4
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:08:05 -0500
Date: Mon, 14 Jan 2019 12:07:56 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20190114120756.GA1271@perard.uk.xensource.com>
References: <20190111180941.6198-1-anthony.perard@citrix.com>
	<20190111181127.GN1508@perard.uk.xensource.com>
	<CAFEAcA-+_-Eq_qm-G4+Guy9nL-Xja9k6fEOUJPd6_3LoG9P0Qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-+_-Eq_qm-G4+Guy9nL-Xja9k6fEOUJPd6_3LoG9P0Qg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] xen: Fix event channel interface for
 XenDevice-s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "open list:X86" <xen-devel@lists.xenproject.org>, Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul.durrant@citrix.com>

On Fri, Jan 11, 2019 at 06:16:45PM +0000, Peter Maydell wrote:
> On Fri, 11 Jan 2019 at 18:13, Anthony PERARD <anthony.perard@citrix.com> wrote:
> >
> > On Fri, Jan 11, 2019 at 06:09:41PM +0000, Anthony PERARD wrote:
> > > Patch "xen: add event channel interface for XenDevice-s" makes use of
> > > the type xenevtchn_port_or_error_t, but this isn't avaiable before Xen
> > > 4.7. Also the function xen_device_bind_event_channel assign the return
> > > value of xenevtchn_bind_interdomain to channel->local_port but check the
> > > result for error with xendev->local_port.
> > >
> > > Fix by:
> > > - removing local_port from struct XenDevice as it isn't use anywere.
> > > - adding a compatibility typedef for xenevtchn_port_or_error_t for Xen
> > >   4.6 and earlier.
> > >
> > > As extra, replace the type of XenEventChannel->local_port by
> > > evtchn_port_t.
> > >
> > > Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
> >
> > Notes:
> > This patch fix "xen: add event channel interface for XenDevice-s" that
> > isn't commited yet, of the patch series "Xen PV backend 'qdevification'".
> 
> Thanks for the fix. I assume you're going to squash it into the
> appropriate patch in that pullrequest ?

Yes, it's a good idea to squash it. I'll resubmit the pullreq shortly.

-- 
Anthony PERARD

Received: from eggs.gnu.org ([209.51.188.92]:47929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gi1MY-0005qK-U2
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 13:16:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gi1MY-00024D-6e
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 13:16:58 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:34344)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gi1MX-000243-V4
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 13:16:58 -0500
Received: by mail-ot1-x344.google.com with SMTP id t5so13941088otk.1
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 10:16:57 -0800 (PST)
MIME-Version: 1.0
References: <20190111180941.6198-1-anthony.perard@citrix.com>
	<20190111181127.GN1508@perard.uk.xensource.com>
In-Reply-To: <20190111181127.GN1508@perard.uk.xensource.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Jan 2019 18:16:45 +0000
Message-ID: <CAFEAcA-+_-Eq_qm-G4+Guy9nL-Xja9k6fEOUJPd6_3LoG9P0Qg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "open list:X86" <xen-devel@lists.xenproject.org>, Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul.durrant@citrix.com>

On Fri, 11 Jan 2019 at 18:13, Anthony PERARD <anthony.perard@citrix.com> wrote:
>
> On Fri, Jan 11, 2019 at 06:09:41PM +0000, Anthony PERARD wrote:
> > Patch "xen: add event channel interface for XenDevice-s" makes use of
> > the type xenevtchn_port_or_error_t, but this isn't avaiable before Xen
> > 4.7. Also the function xen_device_bind_event_channel assign the return
> > value of xenevtchn_bind_interdomain to channel->local_port but check the
> > result for error with xendev->local_port.
> >
> > Fix by:
> > - removing local_port from struct XenDevice as it isn't use anywere.
> > - adding a compatibility typedef for xenevtchn_port_or_error_t for Xen
> >   4.6 and earlier.
> >
> > As extra, replace the type of XenEventChannel->local_port by
> > evtchn_port_t.
> >
> > Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
>
> Notes:
> This patch fix "xen: add event channel interface for XenDevice-s" that
> isn't commited yet, of the patch series "Xen PV backend 'qdevification'".

Thanks for the fix. I assume you're going to squash it into the
appropriate patch in that pullrequest ?

thanks
-- PMM

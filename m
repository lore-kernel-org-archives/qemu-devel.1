Received: from eggs.gnu.org ([2001:4830:134:3::10]:57678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eo5A4-0003LJ-8y
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 05:28:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eo59z-0003iT-EV
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 05:28:36 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37142 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eo59z-0003iC-9H
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 05:28:31 -0500
Date: Tue, 20 Feb 2018 11:28:14 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180220102814.rtcvsrsdtdndcfez@sirius.home.kraxel.org>
References: <20180219111458.25983-1-kraxel@redhat.com>
	<20180219151649.13a197f9@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180219151649.13a197f9@w520.home>
Subject: Re: [Qemu-devel] [PATCH v4 0/7] vfio: add display support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, Tina Zhang <tina.zhang@intel.com>, intel-gvt-dev@lists.freedesktop.org, Kirti Wankhede <kwankhede@nvidia.com>

On Mon, Feb 19, 2018 at 03:16:49PM -0700, Alex Williamson wrote:
> On Mon, 19 Feb 2018 12:14:51 +0100
> Gerd Hoffmann <kraxel@redhat.com> wrote:
> 
> > This series adds support for a vgpu display to the qemu vfio code.
> > For now only regions are supported, dmabufs will follow later.
> > 
> > This version adds a patch to allow devices disable hotplugging, which
> > will be used by vfio display support.  Also fixed issues Alex found in
> > review.
> 
> Looks ok to me, if this is to go through my tree I'll need a qdev ack
> for 4/7.  If you want to go a different route, for 5-7:
> 
> Acked-by: Alex Williamson <alex.williamson@redhat.com>
> 
> I'm still a bit confused though, what's preventing us from adding
> dmabuf support now?  It's strange to provide the implementation for the
> proprietary, unavailable vendor driver implementation first.  Is GVT-g
> broken, lagging?  Thanks,

A bit more complicated because it depends on user interface changes ...

Sneak preview at https://www.kraxel.org/cgit/qemu/log/?h=work/intel-vgpu
Note: branch is a moving target ;)

State:
  vfio:  Working, needs some cleanups though (drop debug logging, ...).
  gtk:   Working, needs some minor cleanups too.
  spice: Partly working (no mouse ptr yet).
  sdl:   Not working.  Need to figure how I get a egl context (instead
         of glx).  Possibly requires SDL 2.2.  Tina looked at this a
         while back, need to look at some old mails ...

Current plan:
  (1) fix/complete spice support.
  (2) cleanup patches, send them out.
  (3) look at the SDL issues.

Received: from eggs.gnu.org ([2001:4830:134:3::10]:60202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ePpfR-0001fa-BO
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:04:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ePpfL-0000VY-9S
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:04:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ePpfL-0000UL-3M
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:04:39 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 496F5C01CB9B
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 13:04:38 +0000 (UTC)
Date: Fri, 15 Dec 2017 13:04:14 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171215130414.GB14126@work-vm>
References: <20171212202040.GA2458@work-vm>
	<20171215122519.ov4alinnlqrlvio7@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171215122519.ov4alinnlqrlvio7@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] No uhd (3840x2160) guest res?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

* Gerd Hoffmann (kraxel@redhat.com) wrote:
> On Tue, Dec 12, 2017 at 08:20:41PM +0000, Dr. David Alan Gilbert wrote:
> > My guests don't seem to offer the standard uhd resolution of 3840x2160
> > - what should be providing that?
> > 
> > I'm running an f27 gnome (X or wayland) guest with:
> > 
> > ./x86_64-softmmu/qemu-system-x86_64 -device virtio-vga --enable-kvm -m 2G /home/vmimages/fedora27.qcow2
> > 
> > and the guest lists:
> > 4096x2160
> > 2480x1680
> > 2560x1600
> > 1920x1440
> > 1856x1392
> > 1792x1344
> > 2048x1152
> > 1920x1200
> > 1920x1080
> > (and smaller)
> > 
> > given that it can offer 4096x2160, I assume it's not running out of RAM.
> > 
> > I couldn't find anywhere with those higher resolutions listed
> > in seabios to consider changing.
> 
> linux kernel has a list of standard vesa resolutions in drm somewhere,
> iirc all virt drm drivers just use that for the mode list.

I see drivers/video/fbdev/core/modedb.c, but there are modes that I see
in the guest that aren't in there; e.g. I see a 4096x2160 listed in the
guest (the 2480x1680 seems to have gone?!).  I don't see it in SeaBIOS
either.

Looking at the VESA CVT 1.2 standard I don't see a UHD def (it's got
some that are similar but not quite the right res).

(I do see a UHD mode defined in qxl, but qxl is unusable and qemu aborts
with newer guest kernels).

Dave


> > 
> > Dave
> > 
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

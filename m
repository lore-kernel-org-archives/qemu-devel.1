Received: from eggs.gnu.org ([2001:4830:134:3::10]:46858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gZ8c9-00057a-Cp
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:12:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gZ8c4-0002TJ-DM
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:12:21 -0500
Date: Tue, 18 Dec 2018 07:12:13 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181218061213.a7x7hdxkczsawt5w@sirius.home.kraxel.org>
References: <20181207160806.13569-1-mark.cave-ayland@ilande.co.uk>
	<20181207160806.13569-3-mark.cave-ayland@ilande.co.uk>
	<20181212083250.56xfzy5j4t4o6ale@sirius.home.kraxel.org>
	<f7fb9204-bfc1-f27b-d66c-51e650a30cd5@ilande.co.uk>
	<20181212133809.evtizdym6awwkw7f@sirius.home.kraxel.org>
	<4d66d1ac-8b4a-748d-543a-1642e153e323@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d66d1ac-8b4a-748d-543a-1642e153e323@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 2/3] mac_newworld: enable access to EDID
 data for the VGA device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

  Hi,

> >> Otherwise a guest driver that assumes it is always present and tries
> >> to read from that area of memory will crash.
> > 
> > Oh, reading should work no matter what.  You just don't find valid edid
> > data there if it is turned off.
> 
> Thanks for the info. My current use case for this is passing a set of possible guest
> display resolutions from the host to the guest driver, rather than using an internal
> hard-coded list. I guess that over time QEMU could become "smarter" about building
> the list of supported resolutions depending upon the capabilities of the host?

Yes, that is the plan.  There are xres and yres properties already,
which will show up as preferred resolution in the edid blob.

The generator also supports to set the maximum display resolution, and
the display dpi (needed when we add hidpi support some day).

stdvga doesn't support to change the edid dynamically (i.e. on window
resize) because the hardware doesn't support interrupts, so we can't
easily signal edid updates to the guest.

cheers,
  Gerd

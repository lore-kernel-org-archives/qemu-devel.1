Received: from eggs.gnu.org ([209.51.188.92]:58323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gzb1M-0002mi-L8
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 00:47:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gzb1L-0005qb-OY
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 00:47:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gzb1L-0005qG-Hu
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 00:47:43 -0500
Date: Fri, 1 Mar 2019 06:47:40 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190301054740.kmju3elrma5eqd4u@sirius.home.kraxel.org>
References: <CAKyx-3Paa6_RreGZw3sT+qmwu1=_DLnR_RDxa_gN20vwD1EnLw@mail.gmail.com>
	<20190225152618.r3epnypkpu6fyokt@sirius.home.kraxel.org>
	<A17B6D30-F428-48E5-B9D0-6F6E7DEE3778@gmail.com>
	<20190226064347.i5kvwazmz3xcupkj@sirius.home.kraxel.org>
	<CAKyx-3OOkkdSQ=UAucP_ZpormrEczwNhEpAnVtFeQOSOrnD7Vg@mail.gmail.com>
	<20190227052755.3lgo3265kaa6bzmi@sirius.home.kraxel.org>
	<1ef851d2-4148-56f0-65ac-a0e75022f20e@ilande.co.uk>
	<CAKyx-3OsujsekrxTa1e=4FNb=pNQxELr8XccS9r2-9_9SxoWtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKyx-3OsujsekrxTa1e=4FNb=pNQxELr8XccS9r2-9_9SxoWtQ@mail.gmail.com>
Subject: Re: [Qemu-devel] Questions about EDID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: G 3 <programmingkidx@gmail.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel qemu-devel <qemu-devel@nongnu.org>

On Thu, Feb 28, 2019 at 11:53:43AM -0500, G 3 wrote:
> On Thu, Feb 28, 2019 at 12:01 AM Mark Cave-Ayland <
> mark.cave-ayland@ilande.co.uk> wrote:
> 
> > On 27/02/2019 05:27, Gerd Hoffmann wrote:
> >
> > > On Tue, Feb 26, 2019 at 04:11:06PM -0500, G 3 wrote:
> > >> When I use edid=on, I do see a lot of extra resolutions available in
> > Mac OS
> > >> 9 and Mac OS X, just not the resolution I want to use. Is there some
> > kind
> > >> of rule like the resolution value has to be divisible by a certain
> > number?
> > >
> > > qemu doesn't have such a requirement.
> > > Might be the guest drivers have.
> > > Try making width/height multiple of 8 or 16.
> >
> > Right, at the moment all the MacOS driver does is parse the resolution
> > list from the
> > EDID and add them to the dropdown list - it doesn't support the xres and
> > yres properties.
> >
> 
> Gerd, could the xres +yres numbers be added to the list of resolutions
> then?

That is already the case:

qemu-edid -x 1234 -y 567 | edid-decode
[ ... ]
First detailed timing is preferred timing
Established timings supported:
  640x480@60Hz
  800x600@60Hz
  1024x768@60Hz
Standard timings supported:
  2048x1152@60Hz
  1920x1080@60Hz
Detailed mode: Clock 73.170 MHz, 485 mm x 223 mm
               1234 1542 1579 1665 hborder 0
               ^^^^
                567  569  571  586 vborder 0
                ^^^
               -hsync -vsync 
[ ... ]

cheers,
  Gerd

Received: from eggs.gnu.org ([2001:4830:134:3::10]:55673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gP46c-0000cW-At
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 06:22:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gP46b-0005RM-OH
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 06:22:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gP46b-0005Pt-Iz
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 06:22:09 -0500
Date: Tue, 20 Nov 2018 12:22:03 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181120112203.rzhhdl6hhsjf5twt@sirius.home.kraxel.org>
References: <CAGxU2F658=XjoHnF6Qq5FqBZAE68BBtMFt-6HcKp_PVxTynOnw@mail.gmail.com>
	<20181119084855.uyira2lpu73mu2fo@sirius.home.kraxel.org>
	<CAGxU2F4O4aKzrJky7EFeWaHFuBKPwi_Z-j7G7m+ENRojVG_5vA@mail.gmail.com>
	<20181119130713.GB6443@stefanha-x1.localdomain>
	<20181119141543.o6xl4vfptajuksi3@sirius.home.kraxel.org>
	<CAGxU2F4kUD85FMVEAcOpWUAGF98G2KR9O8EVAkzBDmA+DkS2KA@mail.gmail.com>
	<20181120062109.eahirgygm4br3ov7@sirius.home.kraxel.org>
	<CAGxU2F64uK5oygQecZKOPpsyb--Pth9U00P_gghrtYDwQrSGtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGxU2F64uK5oygQecZKOPpsyb--Pth9U00P_gghrtYDwQrSGtg@mail.gmail.com>
Subject: Re: [Qemu-devel] SeaBIOS booting time optimization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Rob Bradford <robert.bradford@intel.com>, seabios@seabios.org, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

  Hi,

> > Background:  The drivers in seabios work on both virtual and physical
> > hardware (you can run seabios as coreboot payload on physical hardware).
> > There are quite a few places where are delays and timeouts which are
> > required to work properly on physical hardware.  But typically virtual
> > hardware is alot faster.  There is -- for example -- no time needed to
> > establish a sata link.  Link detection in ahci is instant on qemu.
> 
> I'll investigate also other timeouts.

I'd focus on legacy lpc/isa hardware here.  PCI-ish hardware which has
such timeouts (sata, usb, ...) typically isn't present in the virtual
machine if you care about performance.  Or, in other words, the best way
to handle the sata link detection delay is to use "qemu -M q35,sata=off".

cheers,
  Gerd

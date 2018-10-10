Received: from eggs.gnu.org ([2001:4830:134:3::10]:46117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gABrb-0003ko-I6
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 06:37:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gABrX-0005iv-JT
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 06:37:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gABrX-0005iV-CL
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 06:37:07 -0400
Date: Wed, 10 Oct 2018 12:37:04 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181010103704.jqgfp3kiaiqu4hzt@sirius.home.kraxel.org>
References: <20181009131052.18500-1-lhrazky@redhat.com>
	<20181009131052.18500-2-lhrazky@redhat.com>
	<1539113618.12871.122.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539113618.12871.122.camel@redhat.com>
Subject: Re: [Qemu-devel] [Spice-devel] [RFC PATCH spice 1/2] QXL interface:
 add functions to identify monitors in the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jonathon Jongsma <jjongsma@redhat.com>
Cc: =?utf-8?B?THVrw6HFoSBIcsOhemvDvQ==?= <lhrazky@redhat.com>, spice-devel@lists.freedesktop.org, qemu-devel@nongnu.org

  Hi,

> > + * Sets the hardware (e.g. PCI) path of the graphics device
> > represented by this QXL interface instance.
> 
> So, this comment suggests that the caller might be able to provide a
> path that is not a PCI path. But the implementation below (mostly the
> debug output, I suppose...) assumes a PCI path. Do we need to support
> non-PCI paths?

Certainly not for the initial revision, maybe never.

But thanks to the "pci/" prefix we should be able to add support for
other paths later in case it turns out we need it.

> > + * Returns: The actual SPICE server monitor_id associated with the
> > display
> 
> So, if I remember correctly, Gerd recommended returning this value from
> the function. But I think it needs more explanation here. What exactly
> is a "monitor_id" supposed to represent? It is not used in your follow-
> up qemu patch so it's hard to tell.

IIRC the plan was to ditch the global monior_id idea and use the
(channel_id, display_id) tuple everywhere ...

cheers,
  Gerd

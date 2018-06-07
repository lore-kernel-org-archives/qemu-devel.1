Received: from eggs.gnu.org ([2001:4830:134:3::10]:50634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fR1gR-0003VJ-E4
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 16:39:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fR1gQ-0002Sp-1m
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 16:38:59 -0400
Date: Thu, 7 Jun 2018 22:38:49 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180607203849.pyjqgdtaxlya7p5o@sirius.home.kraxel.org>
References: <20180606163246.GL3064@redhat.com>
	<f3914a591a46c9d489f2fa1ad2ac4fd0c5a9e5b6.camel@redhat.com>
	<20180607102257.GH28827@redhat.com>
	<2afb9305deb37c8ca4f930235eaf52486ab0153e.camel@redhat.com>
	<20180607123847.GL28827@redhat.com> <20180607134953.GN2522@work-vm>
	<63fece55c4708744d9289fedf42d67ebb1bccbdd.camel@redhat.com>
	<20180607144527.GO2522@work-vm>
	<6d393743ee2358c900448a949734fc565a148050.camel@redhat.com>
	<20180607152548.GQ2522@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607152548.GQ2522@work-vm>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Andrea Bolognani <abologna@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, armbru@redhat.com, "Richard W.M. Jones" <rjones@redhat.com>, stefanha@redhat.com, Max Reitz <mreitz@redhat.com>

  Hi,

> > I could be wrong, but I feel like it's significantly less likely
> > that a random QEMU binary won't like a random EFI ROM than it is
> > for a random EFI ROM to not like a random EFI NVRAM.
> 
> True, but it's not that rare to find SeaBIOS+qemu version problems;

Hmm?  Any recent examples?  Since we switched over to have qemu generate
the acpi tables instead of expecting the firmware doing it (qemu 1.5 or
1.6 IIRC) there where no hard lockstep updates.  Only soft dependencies
a'la "if you want use the new qemu feature foo you also need a seabios
supporting the new feature foo".

> so I'll assume the same happens with EFI.

We try to avoid it but sometimes it doesn't work out as we like.

cheers,
  Gerd

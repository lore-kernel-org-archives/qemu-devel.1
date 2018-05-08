Received: from eggs.gnu.org ([2001:4830:134:3::10]:59233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fFwqC-000075-Qn
	for qemu-devel@nongnu.org; Tue, 08 May 2018 03:15:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fFwq8-0001I9-9T
	for qemu-devel@nongnu.org; Tue, 08 May 2018 03:15:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59958 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fFwq8-0001Ho-2R
	for qemu-devel@nongnu.org; Tue, 08 May 2018 03:15:12 -0400
Date: Tue, 8 May 2018 09:14:54 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180508071454.jhamtvwy6lsc3c5q@sirius.home.kraxel.org>
References: <20180507101013.32736-1-kraxel@redhat.com>
	<CAFEAcA-a74RLKXi=v7w-8v9h6A_QFSKeNxK64AvCYKxc_VN+uA@mail.gmail.com>
	<20180507121126.gjeufzppsc7qspgm@sirius.home.kraxel.org>
	<CAFEAcA_hgd7P5fjgqpc00_PzoAdMzBuABombyAnk4ej6a2itoA@mail.gmail.com>
	<20180507143006.7jodoxul7aplhyh3@sirius.home.kraxel.org>
	<CAFEAcA_yutOHAQWcvqm-cfB8EUwmrsw0JrRPF6+eTPtzVOpnpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_yutOHAQWcvqm-cfB8EUwmrsw0JrRPF6+eTPtzVOpnpA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] vga: print friendly error message in case
 multiple vga devices are added
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Mon, May 07, 2018 at 06:00:56PM +0100, Peter Maydell wrote:
> On 7 May 2018 at 15:30, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > The only one which passes global_vmstate == false is "-device
> > secondary-vga", and that does *not* register vga ioports (the
> > registers can be accessed via mmio pci bar though).
> 
> Looks like virtio-vga does as well.

Oh, ok.  Didn't remember that one.  Probably because there is no reason
to worry about live migration backward compatibility for this one.

Guess I have to rethink the logic then.

cheers,
  Gerd

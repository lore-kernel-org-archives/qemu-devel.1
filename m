Received: from eggs.gnu.org ([2001:4830:134:3::10]:54377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fFh9f-0000ly-PX
	for qemu-devel@nongnu.org; Mon, 07 May 2018 10:30:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fFh9c-0007Ir-8m
	for qemu-devel@nongnu.org; Mon, 07 May 2018 10:30:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43086 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fFh9c-0007IT-57
	for qemu-devel@nongnu.org; Mon, 07 May 2018 10:30:16 -0400
Date: Mon, 7 May 2018 16:30:06 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180507143006.7jodoxul7aplhyh3@sirius.home.kraxel.org>
References: <20180507101013.32736-1-kraxel@redhat.com>
	<CAFEAcA-a74RLKXi=v7w-8v9h6A_QFSKeNxK64AvCYKxc_VN+uA@mail.gmail.com>
	<20180507121126.gjeufzppsc7qspgm@sirius.home.kraxel.org>
	<CAFEAcA_hgd7P5fjgqpc00_PzoAdMzBuABombyAnk4ej6a2itoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_hgd7P5fjgqpc00_PzoAdMzBuABombyAnk4ej6a2itoA@mail.gmail.com>
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

On Mon, May 07, 2018 at 02:36:30PM +0100, Peter Maydell wrote:
> On 7 May 2018 at 13:11, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >> This seems like a bit of an irritating reason to refuse to
> >> allow multiple VGA devices though, since we could make
> >> them work by having the vmstate be not-global.
> >
> > Multiple vga devices will also try to use the same isa vga
> > ports.  Seems that doesn't make qemu abort any more, which
> > used to happen in older versions.
> 
> Oh, good point. Shouldn't we be checking for that on
> some other thing than whether global_vmstate is set here,
> though? Otherwise it won't work consistently for the
> vga devices which pass 'false'.

The only one which passes global_vmstate == false is "-device
secondary-vga", and that does *not* register vga ioports (the
registers can be accessed via mmio pci bar though).

So, right now global_vmstate == "registers vga ioports", and
I don't expect that to change.

cheers,
  Gerd

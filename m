Received: from eggs.gnu.org ([2001:4830:134:3::10]:55421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cbpUH-0002qB-DO
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 09:14:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cbpUD-0001Iy-Av
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 09:14:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1cbpUD-0001If-5H
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 09:14:13 -0500
Date: Thu, 9 Feb 2017 15:14:09 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20170209141409.jouhevc75qtfrozx@kamzik.brq.redhat.com>
References: <1486575331-14455-1-git-send-email-abologna@redhat.com>
	<1486575331-14455-3-git-send-email-abologna@redhat.com>
	<CAFEAcA8+wfPQXXhoYZDv8LAOS6=4_P9kyaHONuMQcb7VmkVyxw@mail.gmail.com>
	<1486582091.3641.32.camel@redhat.com>
	<CAFEAcA_txm4n6U1k3ZsTqb=91j5bm9H1i4FtzR92ybnFy-WJ_Q@mail.gmail.com>
	<1486648432.3641.43.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1486648432.3641.43.camel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 2/2] mach-virt: Provide sample
 configuration files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On Thu, Feb 09, 2017 at 02:53:52PM +0100, Andrea Bolognani wrote:
> On Wed, 2017-02-08 at 19:36 +0000, Peter Maydell wrote:
> > The trouble with using virtconsole is that you have to
> > get quite a long way forward (probing and setting up
> > PCI, etc) before you can get any kind of console output.
> > "System doesn't boot and doesn't produce any output"
> > is a common and really annoying failure mode in the
> > ARM world, and I think that using virtconsole is
> > asking for that kind of thing to happen more rather
> > than less often. (Plus having two different serial
> > ports in the guest means that now the user has to
> > configure where both of them are supposed to output.)
> 
> You don't get one unless you use '-serial stdio' or
> something like that in my experience, so if you use the
> sample configuration file as I posted it you will only
> get one serial console, the VirtIO-based one.

The emulated UART is there no matter what, it's built-in on
the board. Whether it gets wired up to the console, stdio in
this case, depends on the '-serial stdio'. Adding the virtio-
console introduces another serial port, but OSes can still
discover the PL011 and try to use that in addition.

Thanks,
drew

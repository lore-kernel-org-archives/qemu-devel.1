Received: from eggs.gnu.org ([2001:4830:134:3::10]:38139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e40ks-0007cB-GH
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 04:28:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e40kn-0007Yp-Oc
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 04:28:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1e40kn-0007XI-HL
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 04:28:05 -0400
Date: Mon, 16 Oct 2017 10:27:55 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171016082755.GA5145@localhost.localdomain>
References: <20171012235439.19457-1-anatol.pomozov@gmail.com>
	<20171012235439.19457-3-anatol.pomozov@gmail.com>
	<20171013192550.GC3246@localhost.localdomain>
	<CAOMFOmW+r86WHWPUMtG54BrAQXqSWZ67oF-6G697ox-7AKL4GA@mail.gmail.com>
	<20171013232114.GD3246@localhost.localdomain>
	<CAFEAcA-zYJUOqH=WU_XnyxEfiZM7a2yqmzndTrf=pKkp=1wUGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-zYJUOqH=WU_XnyxEfiZM7a2yqmzndTrf=pKkp=1wUGA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 2/4] multiboot: load any machine type of ELF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Anatol Pomozov <anatol.pomozov@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Am 14.10.2017 um 15:41 hat Peter Maydell geschrieben:
> On 14 October 2017 at 00:21, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > I don't believe the spec restricts that, but I don't see why it
> > would be useful to load an ELF file that doesn't match the target
> > architecture (e.g. loading non-x86 ELF files on a x86 machine
> > like PC).
> 
> Agreed. If we have non i386 boards that want to use multiboot
> we should probably move the common code out of hw/i386...

Impossible with Multiboot 1, it's a spec that is really made for i386.

The spec isn't really explicit about it being a requirement, but it does
say that its target are 32-bit OSes on PCs, and it defines the boot
state in terms of i386 registers, so it doesn't make sense for non-x86.

>From my interpretation of the spec, even support for 64-bit ELFs seems
to be (implicitly) out of spec (there is one place where it even says
"refer to the i386 ELF documentation for details"), but if GRUB
implements it...

Kevin

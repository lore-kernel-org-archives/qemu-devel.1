Received: from eggs.gnu.org ([2001:4830:134:3::10]:54572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e39Gg-0003hx-Bm
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 19:21:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e39Gb-000818-1h
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 19:21:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e39Ga-00080X-SB
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 19:21:20 -0400
Date: Fri, 13 Oct 2017 20:21:14 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171013232114.GD3246@localhost.localdomain>
References: <20171012235439.19457-1-anatol.pomozov@gmail.com>
	<20171012235439.19457-3-anatol.pomozov@gmail.com>
	<20171013192550.GC3246@localhost.localdomain>
	<CAOMFOmW+r86WHWPUMtG54BrAQXqSWZ67oF-6G697ox-7AKL4GA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMFOmW+r86WHWPUMtG54BrAQXqSWZ67oF-6G697ox-7AKL4GA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 2/4] multiboot: load any machine type of ELF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>

On Fri, Oct 13, 2017 at 02:25:43PM -0700, Anatol Pomozov wrote:
> Hi
> 
> On Fri, Oct 13, 2017 at 12:25 PM, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > On Thu, Oct 12, 2017 at 04:54:37PM -0700, Anatol Pomozov wrote:
> >> x86 is not the only architecture supported by multiboot.
> >> For example GRUB supports MIPS architecture as well.
> >>
> >> Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
> >> ---
> >>  hw/i386/multiboot.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
> >> index c9254f313e..7dacd6d827 100644
> >> --- a/hw/i386/multiboot.c
> >> +++ b/hw/i386/multiboot.c
> >> @@ -173,7 +173,7 @@ int load_multiboot(FWCfgState *fw_cfg,
> >>          }
> >>
> >>          kernel_size = load_elf(kernel_filename, NULL, NULL, &elf_entry,
> >> -                               &elf_low, &elf_high, 0, I386_ELF_MACHINE,
> >> +                               &elf_low, &elf_high, 0, EM_NONE,
> >>                                 0, 0);
> >
> > I assume we still want PC to reject non-x86 ELF files.
> 
> Does multiboot spec states this restriction? I've heard that there are
> attempts to implement multiboot at ARM [1] [2]. Also multiboot2 spec
> mentions MIPS as one of the target architectures.
> 
> [1] https://github.com/jncronin/rpi-boot/blob/master/MULTIBOOT-ARM
> [2] https://wiki.linaro.org/AndrePrzywara/Multiboot

I don't believe the spec restricts that, but I don't see why it
would be useful to load an ELF file that doesn't match the target
architecture (e.g. loading non-x86 ELF files on a x86 machine
like PC).

> 
> >  Isn't it
> > better to add a elf_machine argument to load_multiboot() so each
> > load_multiboot() caller can specify what's the expected
> > architecture?
> >
> >
> >>          if (kernel_size < 0) {
> >>              fprintf(stderr, "Error while loading elf kernel\n");
> >> --
> >> 2.15.0.rc0.271.g36b669edcc-goog
> >>
> >
> > --
> > Eduardo

-- 
Eduardo

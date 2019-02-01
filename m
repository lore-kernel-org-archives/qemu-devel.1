Received: from eggs.gnu.org ([209.51.188.92]:37047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gpbiu-0003Mq-FO
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:31:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gpbil-0005EF-Cm
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:31:20 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55349)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gpbih-0005Cf-6u
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:31:12 -0500
Received: by mail-wm1-x344.google.com with SMTP id y139so6688775wmc.5
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 08:31:09 -0800 (PST)
References: <20190201145035.22739-1-peter.maydell@linaro.org>
	<20190201145035.22739-3-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Message-ID: <87o97vv5ca.fsf@zen.linaroharston>
In-reply-to: <20190201145035.22739-3-peter.maydell@linaro.org>
Date: Fri, 01 Feb 2019 16:31:07 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/11] docs: Convert memory.txt to rst
 format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>


Peter Maydell <peter.maydell@linaro.org> writes:

> Convert the memory API documentation from plain text
> to restructured text format.
>
> This is a very minimal conversion: all I had to change
> was to mark up the ASCII art parts as Sphinx expects
> for 'literal blocks', and fix up the bulleted lists
> (Sphinx expects no leading space before the bullet, and
> wants a blank line before after any list).
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  docs/devel/{memory.txt =3D> memory.rst} | 128 ++++++++++++++------------
>  1 file changed, 70 insertions(+), 58 deletions(-)
>  rename docs/devel/{memory.txt =3D> memory.rst} (85%)
>
> diff --git a/docs/devel/memory.txt b/docs/devel/memory.rst
> similarity index 85%
> rename from docs/devel/memory.txt
> rename to docs/devel/memory.rst
> index 42577e1d860..b6a4c37ea5e 100644
> --- a/docs/devel/memory.txt
> +++ b/docs/devel/memory.rst
> @@ -1,19 +1,20 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  The memory API
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  The memory API models the memory and I/O buses and controllers of a QEMU
>  machine.  It attempts to allow modelling of:
>
> - - ordinary RAM
> - - memory-mapped I/O (MMIO)
> - - memory controllers that can dynamically reroute physical memory regio=
ns
> -   to different destinations
> +- ordinary RAM
> +- memory-mapped I/O (MMIO)
> +- memory controllers that can dynamically reroute physical memory regions
> +  to different destinations
>
>  The memory model provides support for
>
> - - tracking RAM changes by the guest
> - - setting up coalesced memory for kvm
> - - setting up ioeventfd regions for kvm
> +- tracking RAM changes by the guest
> +- setting up coalesced memory for kvm
> +- setting up ioeventfd regions for kvm
>
>  Memory is modelled as an acyclic graph of MemoryRegion objects.  Sinks
>  (leaves) are RAM and MMIO regions, while other nodes represent
> @@ -98,25 +99,30 @@ ROM device memory region types), this host memory nee=
ds to be
>  copied to the destination on migration. These APIs which allocate
>  the host memory for you will also register the memory so it is
>  migrated:
> - - memory_region_init_ram()
> - - memory_region_init_rom()
> - - memory_region_init_rom_device()
> +
> +- memory_region_init_ram()
> +- memory_region_init_rom()
> +- memory_region_init_rom_device()
>
>  For most devices and boards this is the correct thing. If you
>  have a special case where you need to manage the migration of
>  the backing memory yourself, you can call the functions:
> - - memory_region_init_ram_nomigrate()
> - - memory_region_init_rom_nomigrate()
> - - memory_region_init_rom_device_nomigrate()
> +
> +- memory_region_init_ram_nomigrate()
> +- memory_region_init_rom_nomigrate()
> +- memory_region_init_rom_device_nomigrate()
> +
>  which only initialize the MemoryRegion and leave handling
>  migration to the caller.
>
>  The functions:
> - - memory_region_init_resizeable_ram()
> - - memory_region_init_ram_from_file()
> - - memory_region_init_ram_from_fd()
> - - memory_region_init_ram_ptr()
> - - memory_region_init_ram_device_ptr()
> +
> +- memory_region_init_resizeable_ram()
> +- memory_region_init_ram_from_file()
> +- memory_region_init_ram_from_fd()
> +- memory_region_init_ram_ptr()
> +- memory_region_init_ram_device_ptr()
> +
>  are for special cases only, and so they do not automatically
>  register the backing memory for migration; the caller must
>  manage migration if necessary.
> @@ -218,7 +224,7 @@ For example, suppose we have a container A of size 0x=
8000 with two subregions
>  B and C. B is a container mapped at 0x2000, size 0x4000, priority 2; C is
>  an MMIO region mapped at 0x0, size 0x6000, priority 1. B currently has t=
wo
>  of its own subregions: D of size 0x1000 at offset 0 and E of size 0x1000=
 at
> -offset 0x2000. As a diagram:
> +offset 0x2000. As a diagram::
>
>          0      1000   2000   3000   4000   5000   6000   7000   8000
>          |------|------|------|------|------|------|------|------|
> @@ -228,8 +234,9 @@ offset 0x2000. As a diagram:
>    D:                  [DDDDD]
>    E:                                [EEEEE]
>
> -The regions that will be seen within this address range then are:
> -        [CCCCCCCCCCCC][DDDDD][CCCCC][EEEEE][CCCCC]
> +The regions that will be seen within this address range then are::
> +
> +  [CCCCCCCCCCCC][DDDDD][CCCCC][EEEEE][CCCCC]
>
>  Since B has higher priority than C, its subregions appear in the flat map
>  even where they overlap with C. In ranges where B has not mapped anything
> @@ -237,8 +244,9 @@ C's region appears.
>
>  If B had provided its own MMIO operations (ie it was not a pure containe=
r)
>  then these would be used for any addresses in its range not handled by
> -D or E, and the result would be:
> -        [CCCCCCCCCCCC][DDDDD][BBBBB][EEEEE][BBBBB]
> +D or E, and the result would be::
> +
> +  [CCCCCCCCCCCC][DDDDD][BBBBB][EEEEE][BBBBB]
>
>  Priority values are local to a container, because the priorities of two
>  regions are only compared when they are both children of the same contai=
ner.
> @@ -257,6 +265,7 @@ guest accesses an address:
>
>  - all direct subregions of the root region are matched against the addre=
ss, in
>    descending priority order
> +
>    - if the address lies outside the region offset/size, the subregion is
>      discarded
>    - if the subregion is a leaf (RAM or MMIO), the search terminates, ret=
urning
> @@ -270,36 +279,39 @@ guest accesses an address:
>      address range), then if this is a container with its own MMIO or RAM
>      backing the search terminates, returning the container itself. Other=
wise
>      we continue with the next subregion in priority order
> +
>  - if none of the subregions match the address then the search terminates
>    with no match found
>
>  Example memory map
>  ------------------
>
> -system_memory: container@0-2^48-1
> - |
> - +---- lomem: alias@0-0xdfffffff ---> #ram (0-0xdfffffff)
> - |
> - +---- himem: alias@0x100000000-0x11fffffff ---> #ram (0xe0000000-0xffff=
ffff)
> - |
> - +---- vga-window: alias@0xa0000-0xbffff ---> #pci (0xa0000-0xbffff)
> - |      (prio 1)
> - |
> - +---- pci-hole: alias@0xe0000000-0xffffffff ---> #pci (0xe0000000-0xfff=
fffff)
> +::
>
> -pci (0-2^32-1)
> - |
> - +--- vga-area: container@0xa0000-0xbffff
> - |      |
> - |      +--- alias@0x00000-0x7fff  ---> #vram (0x010000-0x017fff)
> - |      |
> - |      +--- alias@0x08000-0xffff  ---> #vram (0x020000-0x027fff)
> - |
> - +---- vram: ram@0xe1000000-0xe1ffffff
> - |
> - +---- vga-mmio: mmio@0xe2000000-0xe200ffff
> +  system_memory: container@0-2^48-1
> +   |
> +   +---- lomem: alias@0-0xdfffffff ---> #ram (0-0xdfffffff)
> +   |
> +   +---- himem: alias@0x100000000-0x11fffffff ---> #ram (0xe0000000-0xff=
ffffff)
> +   |
> +   +---- vga-window: alias@0xa0000-0xbffff ---> #pci (0xa0000-0xbffff)
> +   |      (prio 1)
> +   |
> +   +---- pci-hole: alias@0xe0000000-0xffffffff ---> #pci (0xe0000000-0xf=
fffffff)
>
> -ram: ram@0x00000000-0xffffffff
> +  pci (0-2^32-1)
> +   |
> +   +--- vga-area: container@0xa0000-0xbffff
> +   |      |
> +   |      +--- alias@0x00000-0x7fff  ---> #vram (0x010000-0x017fff)
> +   |      |
> +   |      +--- alias@0x08000-0xffff  ---> #vram (0x020000-0x027fff)
> +   |
> +   +---- vram: ram@0xe1000000-0xe1ffffff
> +   |
> +   +---- vga-mmio: mmio@0xe2000000-0xe200ffff
> +
> +  ram: ram@0x00000000-0xffffffff
>
>  This is a (simplified) PC memory map. The 4GB RAM block is mapped into t=
he
>  system address space via two aliases: "lomem" is a 1:1 mapping of the fi=
rst
> @@ -336,16 +348,16 @@ rather than completing successfully; those devices =
can use the
>  In addition various constraints can be supplied to control how these
>  callbacks are called:
>
> - - .valid.min_access_size, .valid.max_access_size define the access sizes
> -   (in bytes) which the device accepts; accesses outside this range will
> -   have device and bus specific behaviour (ignored, or machine check)
> - - .valid.unaligned specifies that the *device being modelled* supports
> -    unaligned accesses; if false, unaligned accesses will invoke the
> -    appropriate bus or CPU specific behaviour.
> - - .impl.min_access_size, .impl.max_access_size define the access sizes
> -   (in bytes) supported by the *implementation*; other access sizes will=
 be
> -   emulated using the ones available.  For example a 4-byte write will be
> -   emulated using four 1-byte writes, if .impl.max_access_size =3D 1.
> - - .impl.unaligned specifies that the *implementation* supports unaligned
> -   accesses; if false, unaligned accesses will be emulated by two aligned
> -   accesses.
> +- .valid.min_access_size, .valid.max_access_size define the access sizes
> +  (in bytes) which the device accepts; accesses outside this range will
> +  have device and bus specific behaviour (ignored, or machine check)
> +- .valid.unaligned specifies that the *device being modelled* supports
> +  unaligned accesses; if false, unaligned accesses will invoke the
> +  appropriate bus or CPU specific behaviour.
> +- .impl.min_access_size, .impl.max_access_size define the access sizes
> +  (in bytes) supported by the *implementation*; other access sizes will =
be
> +  emulated using the ones available.  For example a 4-byte write will be
> +  emulated using four 1-byte writes, if .impl.max_access_size =3D 1.
> +- .impl.unaligned specifies that the *implementation* supports unaligned
> +  accesses; if false, unaligned accesses will be emulated by two aligned
> +  accesses.


--
Alex Benn=C3=A9e

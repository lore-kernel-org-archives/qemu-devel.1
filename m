Received: from eggs.gnu.org ([209.51.188.92]:38827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpa9Y-0008Jt-FA
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:50:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpa9W-00044c-2D
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:50:48 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46538)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpa9V-000432-MJ
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:50:45 -0500
Received: by mail-wr1-x444.google.com with SMTP id l9so7329238wrt.13
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 06:50:42 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Feb 2019 14:50:26 +0000
Message-Id: <20190201145035.22739-3-peter.maydell@linaro.org>
In-Reply-To: <20190201145035.22739-1-peter.maydell@linaro.org>
References: <20190201145035.22739-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 02/11] docs: Convert memory.txt to rst format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Convert the memory API documentation from plain text
to restructured text format.

This is a very minimal conversion: all I had to change
was to mark up the ASCII art parts as Sphinx expects
for 'literal blocks', and fix up the bulleted lists
(Sphinx expects no leading space before the bullet, and
wants a blank line before after any list).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/devel/{memory.txt => memory.rst} | 128 ++++++++++++++------------
 1 file changed, 70 insertions(+), 58 deletions(-)
 rename docs/devel/{memory.txt => memory.rst} (85%)

diff --git a/docs/devel/memory.txt b/docs/devel/memory.rst
similarity index 85%
rename from docs/devel/memory.txt
rename to docs/devel/memory.rst
index 42577e1d860..b6a4c37ea5e 100644
--- a/docs/devel/memory.txt
+++ b/docs/devel/memory.rst
@@ -1,19 +1,20 @@
+==============
 The memory API
 ==============
 
 The memory API models the memory and I/O buses and controllers of a QEMU
 machine.  It attempts to allow modelling of:
 
- - ordinary RAM
- - memory-mapped I/O (MMIO)
- - memory controllers that can dynamically reroute physical memory regions
-   to different destinations
+- ordinary RAM
+- memory-mapped I/O (MMIO)
+- memory controllers that can dynamically reroute physical memory regions
+  to different destinations
 
 The memory model provides support for
 
- - tracking RAM changes by the guest
- - setting up coalesced memory for kvm
- - setting up ioeventfd regions for kvm
+- tracking RAM changes by the guest
+- setting up coalesced memory for kvm
+- setting up ioeventfd regions for kvm
 
 Memory is modelled as an acyclic graph of MemoryRegion objects.  Sinks
 (leaves) are RAM and MMIO regions, while other nodes represent
@@ -98,25 +99,30 @@ ROM device memory region types), this host memory needs to be
 copied to the destination on migration. These APIs which allocate
 the host memory for you will also register the memory so it is
 migrated:
- - memory_region_init_ram()
- - memory_region_init_rom()
- - memory_region_init_rom_device()
+
+- memory_region_init_ram()
+- memory_region_init_rom()
+- memory_region_init_rom_device()
 
 For most devices and boards this is the correct thing. If you
 have a special case where you need to manage the migration of
 the backing memory yourself, you can call the functions:
- - memory_region_init_ram_nomigrate()
- - memory_region_init_rom_nomigrate()
- - memory_region_init_rom_device_nomigrate()
+
+- memory_region_init_ram_nomigrate()
+- memory_region_init_rom_nomigrate()
+- memory_region_init_rom_device_nomigrate()
+
 which only initialize the MemoryRegion and leave handling
 migration to the caller.
 
 The functions:
- - memory_region_init_resizeable_ram()
- - memory_region_init_ram_from_file()
- - memory_region_init_ram_from_fd()
- - memory_region_init_ram_ptr()
- - memory_region_init_ram_device_ptr()
+
+- memory_region_init_resizeable_ram()
+- memory_region_init_ram_from_file()
+- memory_region_init_ram_from_fd()
+- memory_region_init_ram_ptr()
+- memory_region_init_ram_device_ptr()
+
 are for special cases only, and so they do not automatically
 register the backing memory for migration; the caller must
 manage migration if necessary.
@@ -218,7 +224,7 @@ For example, suppose we have a container A of size 0x8000 with two subregions
 B and C. B is a container mapped at 0x2000, size 0x4000, priority 2; C is
 an MMIO region mapped at 0x0, size 0x6000, priority 1. B currently has two
 of its own subregions: D of size 0x1000 at offset 0 and E of size 0x1000 at
-offset 0x2000. As a diagram:
+offset 0x2000. As a diagram::
 
         0      1000   2000   3000   4000   5000   6000   7000   8000
         |------|------|------|------|------|------|------|------|
@@ -228,8 +234,9 @@ offset 0x2000. As a diagram:
   D:                  [DDDDD]
   E:                                [EEEEE]
 
-The regions that will be seen within this address range then are:
-        [CCCCCCCCCCCC][DDDDD][CCCCC][EEEEE][CCCCC]
+The regions that will be seen within this address range then are::
+
+  [CCCCCCCCCCCC][DDDDD][CCCCC][EEEEE][CCCCC]
 
 Since B has higher priority than C, its subregions appear in the flat map
 even where they overlap with C. In ranges where B has not mapped anything
@@ -237,8 +244,9 @@ C's region appears.
 
 If B had provided its own MMIO operations (ie it was not a pure container)
 then these would be used for any addresses in its range not handled by
-D or E, and the result would be:
-        [CCCCCCCCCCCC][DDDDD][BBBBB][EEEEE][BBBBB]
+D or E, and the result would be::
+
+  [CCCCCCCCCCCC][DDDDD][BBBBB][EEEEE][BBBBB]
 
 Priority values are local to a container, because the priorities of two
 regions are only compared when they are both children of the same container.
@@ -257,6 +265,7 @@ guest accesses an address:
 
 - all direct subregions of the root region are matched against the address, in
   descending priority order
+
   - if the address lies outside the region offset/size, the subregion is
     discarded
   - if the subregion is a leaf (RAM or MMIO), the search terminates, returning
@@ -270,36 +279,39 @@ guest accesses an address:
     address range), then if this is a container with its own MMIO or RAM
     backing the search terminates, returning the container itself. Otherwise
     we continue with the next subregion in priority order
+
 - if none of the subregions match the address then the search terminates
   with no match found
 
 Example memory map
 ------------------
 
-system_memory: container@0-2^48-1
- |
- +---- lomem: alias@0-0xdfffffff ---> #ram (0-0xdfffffff)
- |
- +---- himem: alias@0x100000000-0x11fffffff ---> #ram (0xe0000000-0xffffffff)
- |
- +---- vga-window: alias@0xa0000-0xbffff ---> #pci (0xa0000-0xbffff)
- |      (prio 1)
- |
- +---- pci-hole: alias@0xe0000000-0xffffffff ---> #pci (0xe0000000-0xffffffff)
+::
 
-pci (0-2^32-1)
- |
- +--- vga-area: container@0xa0000-0xbffff
- |      |
- |      +--- alias@0x00000-0x7fff  ---> #vram (0x010000-0x017fff)
- |      |
- |      +--- alias@0x08000-0xffff  ---> #vram (0x020000-0x027fff)
- |
- +---- vram: ram@0xe1000000-0xe1ffffff
- |
- +---- vga-mmio: mmio@0xe2000000-0xe200ffff
+  system_memory: container@0-2^48-1
+   |
+   +---- lomem: alias@0-0xdfffffff ---> #ram (0-0xdfffffff)
+   |
+   +---- himem: alias@0x100000000-0x11fffffff ---> #ram (0xe0000000-0xffffffff)
+   |
+   +---- vga-window: alias@0xa0000-0xbffff ---> #pci (0xa0000-0xbffff)
+   |      (prio 1)
+   |
+   +---- pci-hole: alias@0xe0000000-0xffffffff ---> #pci (0xe0000000-0xffffffff)
 
-ram: ram@0x00000000-0xffffffff
+  pci (0-2^32-1)
+   |
+   +--- vga-area: container@0xa0000-0xbffff
+   |      |
+   |      +--- alias@0x00000-0x7fff  ---> #vram (0x010000-0x017fff)
+   |      |
+   |      +--- alias@0x08000-0xffff  ---> #vram (0x020000-0x027fff)
+   |
+   +---- vram: ram@0xe1000000-0xe1ffffff
+   |
+   +---- vga-mmio: mmio@0xe2000000-0xe200ffff
+
+  ram: ram@0x00000000-0xffffffff
 
 This is a (simplified) PC memory map. The 4GB RAM block is mapped into the
 system address space via two aliases: "lomem" is a 1:1 mapping of the first
@@ -336,16 +348,16 @@ rather than completing successfully; those devices can use the
 In addition various constraints can be supplied to control how these
 callbacks are called:
 
- - .valid.min_access_size, .valid.max_access_size define the access sizes
-   (in bytes) which the device accepts; accesses outside this range will
-   have device and bus specific behaviour (ignored, or machine check)
- - .valid.unaligned specifies that the *device being modelled* supports
-    unaligned accesses; if false, unaligned accesses will invoke the
-    appropriate bus or CPU specific behaviour.
- - .impl.min_access_size, .impl.max_access_size define the access sizes
-   (in bytes) supported by the *implementation*; other access sizes will be
-   emulated using the ones available.  For example a 4-byte write will be
-   emulated using four 1-byte writes, if .impl.max_access_size = 1.
- - .impl.unaligned specifies that the *implementation* supports unaligned
-   accesses; if false, unaligned accesses will be emulated by two aligned
-   accesses.
+- .valid.min_access_size, .valid.max_access_size define the access sizes
+  (in bytes) which the device accepts; accesses outside this range will
+  have device and bus specific behaviour (ignored, or machine check)
+- .valid.unaligned specifies that the *device being modelled* supports
+  unaligned accesses; if false, unaligned accesses will invoke the
+  appropriate bus or CPU specific behaviour.
+- .impl.min_access_size, .impl.max_access_size define the access sizes
+  (in bytes) supported by the *implementation*; other access sizes will be
+  emulated using the ones available.  For example a 4-byte write will be
+  emulated using four 1-byte writes, if .impl.max_access_size = 1.
+- .impl.unaligned specifies that the *implementation* supports unaligned
+  accesses; if false, unaligned accesses will be emulated by two aligned
+  accesses.
-- 
2.20.1

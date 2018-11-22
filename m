Received: from eggs.gnu.org ([2001:4830:134:3::10]:51923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gPp8h-0007xA-An
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 08:35:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gPp8g-0001mT-6J
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 08:35:27 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Nov 2018 13:35:05 +0000
Message-Id: <20181122133507.30950-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-4.0 0/2] Rename
 cpu_physical_memory_write_rom() to address_space_write_rom()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

The API of cpu_physical_memory_write_rom() is odd, because it
takes an AddressSpace, unlike all the other cpu_physical_memory_*
access functions. We note this oddity as a TODO in the
docs/devel/loads-stores.rst documentation.

Rename cpu_physical_memory_write_rom() to address_space_write_rom(),
and give it an API that matches address_space_write().
We also adjest the cpu_physical_memory_write_rom_internal()
function which is local to exec.c similarly.

thanks
-- PMM
    
Peter Maydell (2):
  exec.c: Rename cpu_physical_memory_write_rom_internal()
  Rename cpu_physical_memory_write_rom() to address_space_write_rom()

 include/exec/cpu-common.h   |  2 --
 include/exec/memory.h       | 26 ++++++++++++++++++++++++++
 exec.c                      | 30 +++++++++++++++++++-----------
 hw/core/loader.c            |  4 ++--
 hw/intc/apic.c              |  7 ++++---
 hw/misc/tz-mpc.c            |  2 +-
 hw/sparc/sun4m.c            |  5 +++--
 docs/devel/loads-stores.rst | 35 ++++++++++++++++-------------------
 8 files changed, 71 insertions(+), 40 deletions(-)

-- 
2.19.1

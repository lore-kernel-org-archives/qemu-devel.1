Received: from eggs.gnu.org ([2001:4830:134:3::10]:35352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dau2N-0002Pp-PN
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 21:25:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dau2K-0001x5-Fb
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 21:25:55 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 27 Jul 2017 22:25:34 -0300
Message-Id: <20170728012542.29975-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 0/8] docs: fix broken paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, Eric Blake <eblake@redhat.com>

Hi, following Cleber Rosa example I cleaned more invalid references.

Eric said this can wait 2.11, however these patches don't change any code
generated, I think the 2.10 users deserve an up-to-date doc :p

I used the following command (and consider include it in some CI test job):

$ git grep docs/ \
      | sed -ne "s/.* \(docs[^ :)}\"\']*\).*/\1/p" \
      | sed -e 's/\(.*\)\.$/\1/p' | sort -u | while read p;do
    ls -ld $p 1>/dev/null
  done

Regards,

Phil.

Cleber Rosa (1):
  docs: fix broken paths to docs/interop dir

Philippe Mathieu-Daudé (7):
  docs: fix broken paths to docs/interop/qcow2.txt
  docs: fix broken paths to docs/devel/qapi-code-gen.txt
  docs: fix broken paths to docs/devel/atomics.txt
  docs: fix broken paths to docs/devel/tracing.txt
  docs: fix broken paths to docs/config/ich9-ehci-uhci.cfg
  docs: fix broken paths to docs/specs/ivshmem-spec.txt
  docs: fix broken paths to docs/spin/

 audio/trace-events                  | 2 +-
 block/trace-events                  | 2 +-
 chardev/trace-events                | 2 +-
 crypto/trace-events                 | 2 +-
 docs/devel/lockcnt.txt              | 2 +-
 docs/devel/writing-qmp-commands.txt | 4 ++--
 docs/qcow2-cache.txt                | 2 +-
 docs/specs/pci-ids.txt              | 2 +-
 docs/spin/aio_notify.promela        | 6 +++---
 docs/spin/aio_notify_accept.promela | 4 ++--
 docs/spin/aio_notify_bug.promela    | 4 ++--
 docs/spin/tcg-exclusive.promela     | 2 +-
 docs/usb2.txt                       | 2 +-
 hw/9pfs/trace-events                | 2 +-
 hw/acpi/trace-events                | 2 +-
 hw/alpha/trace-events               | 2 +-
 hw/arm/trace-events                 | 2 +-
 hw/audio/trace-events               | 2 +-
 hw/block/dataplane/trace-events     | 2 +-
 hw/block/trace-events               | 2 +-
 hw/char/trace-events                | 2 +-
 hw/display/trace-events             | 2 +-
 hw/dma/trace-events                 | 2 +-
 hw/i386/trace-events                | 2 +-
 hw/input/trace-events               | 2 +-
 hw/intc/trace-events                | 2 +-
 hw/isa/trace-events                 | 2 +-
 hw/mem/trace-events                 | 2 +-
 hw/misc/trace-events                | 2 +-
 hw/net/trace-events                 | 2 +-
 hw/nvram/trace-events               | 2 +-
 hw/pci/trace-events                 | 2 +-
 hw/ppc/trace-events                 | 2 +-
 hw/s390x/trace-events               | 2 +-
 hw/scsi/trace-events                | 2 +-
 hw/sd/trace-events                  | 2 +-
 hw/sparc/trace-events               | 2 +-
 hw/timer/trace-events               | 2 +-
 hw/usb/trace-events                 | 2 +-
 hw/vfio/trace-events                | 2 +-
 hw/virtio/trace-events              | 2 +-
 hw/xen/trace-events                 | 2 +-
 include/block/aio.h                 | 2 +-
 include/qapi/visitor.h              | 2 +-
 include/qemu/atomic.h               | 4 ++--
 io/trace-events                     | 2 +-
 linux-user/trace-events             | 2 +-
 migration/trace-events              | 2 +-
 net/trace-events                    | 2 +-
 qapi-schema.json                    | 4 ++--
 qapi/introspect.json                | 2 +-
 qapi/qapi-util.c                    | 2 +-
 qom/trace-events                    | 2 +-
 scripts/qapi2texi.py                | 2 +-
 scripts/simpletrace.py              | 2 +-
 target/arm/trace-events             | 2 +-
 target/i386/trace-events            | 2 +-
 target/mips/trace-events            | 2 +-
 target/ppc/trace-events             | 2 +-
 target/s390x/trace-events           | 2 +-
 target/sparc/trace-events           | 2 +-
 tcg/README                          | 2 +-
 ui/trace-events                     | 2 +-
 util/trace-events                   | 2 +-
 64 files changed, 71 insertions(+), 71 deletions(-)

-- 
2.13.3

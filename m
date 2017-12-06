Received: from eggs.gnu.org ([2001:4830:134:3::10]:48750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfC3-00086K-Pb
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfC0-000094-KF
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38256)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfC0-00007U-BI
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:16 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JE2JX107149
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:17:13 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2epm1wf6nq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:17:12 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 12:17:11 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:15:53 -0600
Message-Id: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 00/55] Patch Round-up for stable 2.10.2,
 freeze on 2017-12-13
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org

Hi everyone,                                                                                              

The following new patches are queued for QEMU stable v2.10.2:

  https://github.com/mdroth/qemu/commits/stable-2.10-staging

The release is planned for 2017-12-18:

  https://wiki.qemu.org/Planning/2.10

Please respond here or CC qemu-stable@nongnu.org on any patches you
think should be included in the release.

Testing/feedback is greatly appreciated.

Thanks!

----------------------------------------------------------------

The following changes since commit 7851197b812b383ae1208c5d86391c5179c8209d:

  Update version for 2.10.1 release (2017-10-02 12:42:58 -0500)

are available in the git repository at:

  git://github.com/mdroth/qemu.git stable-2.10-staging

for you to fetch changes up to 9c7714afd7b574245c86c6bad40ecbcc2992aeec:

  vga: handle cirrus vbe mode wraparounds. (2017-12-06 13:01:53 -0600)

----------------------------------------------------------------
Alexey Kardashevskiy (16):
      exec: Explicitly export target AS from address_space_translate_internal
      memory: Open code FlatView rendering
      memory: Move FlatView allocation to a helper
      memory: Move AddressSpaceDispatch from AddressSpace to FlatView
      memory: Remove AddressSpace pointer from AddressSpaceDispatch
      memory: Switch memory from using AddressSpace to FlatView
      memory: Cleanup after switching to FlatView
      memory: Rename mem_begin/mem_commit/mem_add helpers
      memory: Store physical root MR in FlatView
      memory: Alloc dispatch tree where topology is generared
      memory: Move address_space_update_ioeventfds
      memory: Share FlatView's and dispatch trees between address spaces
      memory: Do not allocate FlatView in address_space_init
      memory: Get rid of address_space_init_shareable
      memory: Create FlatView directly
      memory: Share special empty FlatView

Daniel Henrique Barboza (2):
      hw/ppc: CAS reset on early device hotplug
      hw/ppc: clear pending_events on machine reset

Daniel P. Berrange (1):
      io: monitor encoutput buffer size from websocket GSource

Eric Auger (1):
      hw/intc/arm_gicv3_its: Don't abort on table save failure

Eric Blake (6):
      block: Perform copy-on-read in loop
      nbd/client: Use error_prepend() correctly
      nbd/server: CVE-2017-15119 Reject options larger than 32M
      nbd/server: CVE-2017-15118 Stack smash on large export name
      nbd-client: Refuse read-only client with BDRV_O_RDWR
      nbd/client: Don't hard-disconnect on ESHUTDOWN from server

Gerd Hoffmann (2):
      vga: drop line_offset variable
      vga: handle cirrus vbe mode wraparounds.

Greg Kurz (3):
      ppc: fix setting of compat mode
      spapr: reset DRCs after devices
      vhost: fix error check in vhost_verify_ring_mappings()

Jason Wang (1):
      virtio-net: don't touch virtqueue if vm is stopped

Jens Freimann (2):
      net/socket: fix coverity issue
      net: fix check for number of parameters to -netdev socket

Jim Somerville (1):
      kvmclock: use the updated system_timer_msr

Max Reitz (4):
      qcow2: Fix unaligned preallocated truncation
      qcow2: Always execute preallocate() in a coroutine
      iotests: Add cluster_size=64k to 125
      util/stats64: Fix min/max comparisons

Maxime Coquelin (3):
      memory: fix off-by-one error in memory_region_notify_one()
      virtio: Add queue interface to restore avail index from vring used index
      vhost: restore avail index from vring used index on disconnection

Michael Olbrich (1):
      hw/sd: fix out-of-bounds check for multi block reads

Michael Roth (1):
      scripts/make-release: ship u-boot source as a tarball

Paolo Bonzini (4):
      memory: avoid "resurrection" of dead FlatViews
      memory: trace FlatView creation and destruction
      memory: seek FlatView sharing candidates among children subregions
      nios2: define tcg_env

Peter Lieven (1):
      block/nfs: fix nfs_client_open for filesize greater than 1TB

Peter Maydell (1):
      translate.c: Fix usermode big-endian AArch32 LDREXD and STREXD

Peter Xu (2):
      exec: add page_mask for flatview_do_translate
      exec: simplify address_space_get_iotlb_entry

Thomas Huth (1):
      hw/usb/bus: Remove bad object_unparent() from usb_try_create_simple()

Vladimir Sementsov-Ogievskiy (2):
      block/mirror: check backing in bdrv_mirror_top_flush
      nbd/server: fix nbd_negotiate_handle_info

 block/io.c                     | 118 ++++++----
 block/mirror.c                 |   4 +
 block/nbd-client.c             |   9 +
 block/nfs.c                    |   7 +-
 block/qcow2.c                  |  42 +++-
 cpus.c                         |   5 +-
 docs/devel/atomics.txt         |   1 +
 exec.c                         | 316 ++++++++++++++-------------
 hw/arm/armv7m.c                |   9 +-
 hw/display/vga.c               |  33 ++-
 hw/i386/kvm/clock.c            |   3 +-
 hw/intc/arm_gicv3_its_kvm.c    |   8 +-
 hw/intc/openpic_kvm.c          |   2 +-
 hw/net/virtio-net.c            |   3 +-
 hw/ppc/spapr.c                 |  48 ++++-
 hw/ppc/spapr_drc.c             |   9 +-
 hw/ppc/spapr_events.c          |  11 +
 hw/sd/sd.c                     |  12 +-
 hw/usb/bus.c                   |   4 +-
 hw/virtio/vhost.c              |  10 +-
 hw/virtio/virtio.c             |  10 +
 include/exec/memory-internal.h |  12 +-
 include/exec/memory.h          |  72 +++----
 include/hw/arm/armv7m.h        |   2 +-
 include/hw/ppc/spapr.h         |   1 +
 include/hw/ppc/spapr_drc.h     |   1 +
 include/hw/virtio/virtio.h     |   1 +
 include/qemu/atomic.h          |   8 +
 include/qemu/typedefs.h        |   1 +
 io/channel-websock.c           |   8 +-
 memory.c                       | 271 +++++++++++++++++------
 nbd/client.c                   |  56 +++--
 nbd/server.c                   |  13 +-
 net/socket.c                   |   6 +-
 scripts/make-release           |   4 +
 target/arm/cpu.c               |  15 +-
 target/arm/translate.c         |  39 +++-
 target/i386/cpu.c              |   5 +-
 target/nios2/translate.c       |   1 +
 target/ppc/compat.c            |   2 +-
 tests/qemu-iotests/058         |   8 +-
 tests/qemu-iotests/125         |   7 +-
 tests/qemu-iotests/125.out     | 480 ++++++++++++++++++++++++++++++++++++-----
 tests/qemu-iotests/140         |   4 +-
 tests/qemu-iotests/147         |   1 +
 trace-events                   |   3 +
 util/stats64.c                 |   4 +-
 47 files changed, 1220 insertions(+), 469 deletions(-)

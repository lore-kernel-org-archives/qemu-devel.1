Received: from eggs.gnu.org ([209.51.188.92]:43971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gwI89-0003Hn-5M
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 22:01:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gwI87-0001Uf-6i
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 22:01:05 -0500
Date: Wed, 20 Feb 2019 11:00:25 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190220030025.GA25796@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <1550652953-24393-1-git-send-email-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550652953-24393-1-git-send-email-like.xu@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH] doc: update .gitignore and fix typos for
 docs in tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Like Xu <like.xu@linux.intel.com>
Cc: qemu-trivial@nongnu.org, Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org

On Wed, Feb 20, 2019 at 04:55:53PM +0800, Like Xu wrote:
>Signed-off-by: Like Xu <like.xu@linux.intel.com>
>---
> .gitignore                     | 1 +
> docs/COLO-FT.txt               | 2 +-
> docs/amd-memory-encryption.txt | 2 +-
> docs/can.txt                   | 2 +-
> docs/colo-proxy.txt            | 6 +++---
> docs/cpu-hotplug.rst           | 2 +-
> docs/qcow2-cache.txt           | 2 +-
> docs/qemu-block-drivers.texi   | 2 +-
> docs/qemu-cpu-models.texi      | 4 ++--
> docs/rdma.txt                  | 2 +-
> docs/replay.txt                | 2 +-
> docs/usb-storage.txt           | 2 +-
> docs/vfio-ap.txt               | 2 +-
> 13 files changed, 16 insertions(+), 15 deletions(-)
>
>diff --git a/.gitignore b/.gitignore
>index b66b772..6cb0016 100644
>--- a/.gitignore
>+++ b/.gitignore
>@@ -90,6 +90,7 @@
> *.d
> !/scripts/qemu-guest-agent/fsfreeze-hook.d
> *.o
>+*.patch
> .sdk
> *.gcda
> *.gcno

suggest to split this into a standalone one.

>diff --git a/docs/COLO-FT.txt b/docs/COLO-FT.txt
>index e2686bb..ad24680 100644
>--- a/docs/COLO-FT.txt
>+++ b/docs/COLO-FT.txt
>@@ -102,7 +102,7 @@ to make sure the state of VM in Secondary side is always consistent with VM in
> Primary side.
> 
> COLO Proxy:
>-Delivers packets to Primary and Seconday, and then compare the responses from
>+Delivers packets to Primary and Secondary, and then compare the responses from
> both side. Then decide whether to start a checkpoint according to some rules.
> Please refer to docs/colo-proxy.txt for more information.
> 
>diff --git a/docs/amd-memory-encryption.txt b/docs/amd-memory-encryption.txt
>index f483795..43bf3ee 100644
>--- a/docs/amd-memory-encryption.txt
>+++ b/docs/amd-memory-encryption.txt
>@@ -97,7 +97,7 @@ References
> AMD Memory Encryption whitepaper:
> http://amd-dev.wpengine.netdna-cdn.com/wordpress/media/2013/12/AMD_Memory_Encryption_Whitepaper_v7-Public.pdf
> 
>-Secure Encrypted Virutualization Key Management:
>+Secure Encrypted Virtualization Key Management:
> [1] http://support.amd.com/TechDocs/55766_SEV-KM API_Specification.pdf
> 
> KVM Forum slides:
>diff --git a/docs/can.txt b/docs/can.txt
>index 7ba23b2..9fa6ed5 100644
>--- a/docs/can.txt
>+++ b/docs/can.txt
>@@ -99,7 +99,7 @@ Links to other resources
>      https://gitlab.fel.cvut.cz/canbus/qemu-canbus
>  (3) RTEMS page describing project
>      https://devel.rtems.org/wiki/Developer/Simulators/QEMU/CANEmulation
>- (4) RTLWS 2015 article about the projevt and its use with CANopen emulation
>+ (4) RTLWS 2015 article about the project and its use with CANopen emulation
>      http://rtime.felk.cvut.cz/publications/public/rtlws2015-qemu-can.pdf
>      Slides
>      http://rtime.felk.cvut.cz/publications/public/rtlws2015-qemu-can-slides.pdf
>diff --git a/docs/colo-proxy.txt b/docs/colo-proxy.txt
>index 1f8e4b4..7074da7 100644
>--- a/docs/colo-proxy.txt
>+++ b/docs/colo-proxy.txt
>@@ -41,7 +41,7 @@ Below is a COLO proxy ascii figure:
> |         |  +------------------------------------------------------+  |                        |        |                              |
> |netfilter|  |                       |                         |    |  |   netfilter            |        |                              |
> | +----------+ +----------------------------+                  |    |  |  +-----------------------------------------------------------+ |
>-| |       |  |                       |      |        out       |    |  |  |                     |        |  filter excute order       | |
>+| |       |  |                       |      |        out       |    |  |  |                     |        |  filter execute order       | |
                                                                                                                                        ^
                                                                                                                                  remove one space here?

> | |       |  |          +-----------------------------+        |    |  |  |                     |        | +------------------->      | |
> | |       |  |          |            |      |         |        |    |  |  |                     |        |   TCP                      | |
> | | +-----+--+-+  +-----v----+ +-----v----+ |pri +----+----+sec|    |  |  | +------------+  +---+----+---v+rewriter++  +------------+ | |
>@@ -53,7 +53,7 @@ Below is a COLO proxy ascii figure:
> | |      |   tx        |   rx           rx  |                  |  |    |  |            tx                        all       |  rx      | |
> | |      |             |                    |                  |  |    |  +-----------------------------------------------------------+ |
> | |      |             +--------------+     |                  |  |    |                                                   |            |
>-| |      |   filter excute order      |     |                  |  |    |                                                   |            |
>+| |      |   filter execute order      |     |                  |  |    |                                                   |            |

                                      the same as above

> | |      |  +---------------->        |     |                  |  +--------------------------------------------------------+            |
> | +-----------------------------------------+                  |       |                                                                |
> |        |                            |                        |       |                                                                |
>@@ -92,7 +92,7 @@ but do nothing, just pass to next filter.
> 
> Redirect Server Filter --> COLO-Compare
> COLO-compare receive primary guest packet then
>-waiting scondary redirect packet to compare it.
>+waiting secondary redirect packet to compare it.
> If packet same,send queued primary packet and clear
> queued secondary packet, Otherwise send primary packet
> and do checkpoint.
>diff --git a/docs/cpu-hotplug.rst b/docs/cpu-hotplug.rst
>index 1c268e0..cfeb79f 100644
>--- a/docs/cpu-hotplug.rst
>+++ b/docs/cpu-hotplug.rst
>@@ -137,6 +137,6 @@ From the 'qmp-shell', invoke the QMP ``device_del`` command::
>     vCPU hot-unplug requires guest cooperation; so the ``device_del``
>     command above does not guarantee vCPU removal -- it's a "request to
>     unplug".  At this point, the guest will get a System Control
>-    Interupt (SCI) and calls the ACPI handler for the affected vCPU
>+    Interrupt (SCI) and calls the ACPI handler for the affected vCPU
>     device.  Then the guest kernel will bring the vCPU offline and tell
>     QEMU to unplug it.
>diff --git a/docs/qcow2-cache.txt b/docs/qcow2-cache.txt
>index c459bf5..c1e7751 100644
>--- a/docs/qcow2-cache.txt
>+++ b/docs/qcow2-cache.txt
>@@ -55,7 +55,7 @@ value can improve the I/O performance significantly.
> 
> The refcount blocks
> -------------------
>-The qcow2 format also mantains a reference count for each cluster.
>+The qcow2 format also maintains a reference count for each cluster.
> Reference counts are used for cluster allocation and internal
> snapshots. The data is stored in a two-level structure similar to the
> L1/L2 tables described above.
>diff --git a/docs/qemu-block-drivers.texi b/docs/qemu-block-drivers.texi
>index 38e9f34..1b1ac19 100644
>--- a/docs/qemu-block-drivers.texi
>+++ b/docs/qemu-block-drivers.texi
>@@ -632,7 +632,7 @@ qemu-system-i386 -drive file=iscsi://127.0.0.1/iqn.qemu.test/1 \
> @end example
> 
> 
>-Howto set up a simple iSCSI target on loopback and accessing it via QEMU:
>+How to set up a simple iSCSI target on loopback and accessing it via QEMU:
> @example
> This example shows how to set up an iSCSI target with one CDROM and one DISK
> using the Linux STGT software target. This target is available on Red Hat based
>diff --git a/docs/qemu-cpu-models.texi b/docs/qemu-cpu-models.texi
>index 475d434..4354fe8 100644
>--- a/docs/qemu-cpu-models.texi
>+++ b/docs/qemu-cpu-models.texi
>@@ -287,7 +287,7 @@ Must be explicitly turned on for all AMD CPU models.
> This provides higher performance than virt-ssbd so should be
> exposed to guests whenever available in the host. virt-ssbd
> should none the less also be exposed for maximum guest
>-compatability as some kernels only know about virt-ssbd.
>+compatibility as some kernels only know about virt-ssbd.
> 
> 
> @item @code{amd-no-ssb}
>@@ -296,7 +296,7 @@ Recommended to indicate the host is not vulnerable CVE-2018-3639
> 
> Not included by default in any AMD CPU model.
> 
>-Future hardware genarations of CPU will not be vulnerable to
>+Future hardware generations of CPU will not be vulnerable to
> CVE-2018-3639, and thus the guest should be told not to enable
> its mitigations, by exposing amd-no-ssb. This is mutually
> exclusive with virt-ssbd and amd-ssbd.
>diff --git a/docs/rdma.txt b/docs/rdma.txt
>index e6f9902..1e6f23e 100644
>--- a/docs/rdma.txt
>+++ b/docs/rdma.txt
>@@ -30,7 +30,7 @@ of the significantly lower latency and higher throughput over TCP/IP. This is
> because the RDMA I/O architecture reduces the number of interrupts and
> data copies by bypassing the host networking stack. In particular, a TCP-based
> migration, under certain types of memory-bound workloads, may take a more
>-unpredicatable amount of time to complete the migration if the amount of
>+unpredictable amount of time to complete the migration if the amount of
> memory tracked during each live migration iteration round cannot keep pace
> with the rate of dirty memory produced by the workload.
> 
>diff --git a/docs/replay.txt b/docs/replay.txt
>index 3497585..ee6aee9 100644
>--- a/docs/replay.txt
>+++ b/docs/replay.txt
>@@ -290,7 +290,7 @@ E.g., '-serial stdio' in record mode, and '-serial null' in replay mode.
> Replay log format
> -----------------
> 
>-Record/replay log consits of the header and the sequence of execution
>+Record/replay log consists of the header and the sequence of execution
> events. The header includes 4-byte replay version id and 8-byte reserved
> field. Version is updated every time replay log format changes to prevent
> using replay log created by another build of qemu.
>diff --git a/docs/usb-storage.txt b/docs/usb-storage.txt
>index 551af6f..3df6d05 100644
>--- a/docs/usb-storage.txt
>+++ b/docs/usb-storage.txt
>@@ -16,7 +16,7 @@ too):
> 
> 
> Number two is the newer usb attached scsi transport.  This one doesn't
>-automagically create a scsi disk, so you have to explicitly attach one
>+automatically create a scsi disk, so you have to explicitly attach one
> manually.  Multiple logical units are supported.  Here is an example
> with tree logical units:
> 
>diff --git a/docs/vfio-ap.txt b/docs/vfio-ap.txt
>index 1233968..30f3c66 100644
>--- a/docs/vfio-ap.txt
>+++ b/docs/vfio-ap.txt
>@@ -624,7 +624,7 @@ These are the steps:
>       -> IOMMU Hardware Support
>          select S390 AP IOMMU Support
>       -> VFIO Non-Privileged userspace driver framework
>-         -> Mediated device driver frramework
>+         -> Mediated device driver framework
>             -> VFIO driver for Mediated devices
>    -> I/O subsystem
>       -> VFIO support for AP devices

others looks good to me.

>-- 
>1.8.3.1
>

-- 
Wei Yang
Help you, Help me

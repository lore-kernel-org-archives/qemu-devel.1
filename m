Received: from eggs.gnu.org ([2001:4830:134:3::10]:46156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ez5uJ-0001AA-79
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 15:30:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ez5u0-0007SB-C1
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 15:29:51 -0400
Date: Thu, 22 Mar 2018 21:28:10 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1521746188-496856-2-git-send-email-mst@redhat.com>
References: <1521746188-496856-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521746188-496856-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/2] qemu: move generated files to qemu-build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, David Hildenbrand <david@redhat.com>, Jeff Cody <jcody@redhat.com>, Zhang Chen <zhangckid@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, Keith Busch <keith.busch@intel.com>, Max Filippov <jcmvbkbc@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Eric Blake <eblake@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Josh Durgin <jdurgin@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Alberto Garcia <berto@igalia.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Ben Warren <ben@skyportsystems.com>, Marcel Apfelbaum <marcel@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Markus Armbruster <armbru@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org, =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Anthony Perard <anthony.perard@citrix.com>, Liu Yuan <namei.unix@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Andrzej Zaborowski <balrogg@gmail.com>, Jason Wang <jasowang@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>, Amit Shah <amit@kernel.org>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>, Alistair Francis <alistair@alistair23.me>, Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>, Yuval Shaia <yuval.shaia@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org, John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>, Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, qemu-block@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Wen Congyang <wencongyang2@huawei.com>, qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, Juan Quintela <quintela@redhat.com>, Max Reitz <mreitz@redhat.com>, Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, Hannes Reinecke <hare@suse.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Fabien Chouteau <chouteau@adacore.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Alexander Graf <agraf@suse.de>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>

See patch 1 for description and motivation.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/devel/build-system.txt               |  2 +-
 docs/devel/tracing.txt                    |  6 +++---
 crypto/cipherpriv.h                       |  2 +-
 include/block/block.h                     |  2 +-
 include/block/dirty-bitmap.h              |  2 +-
 include/block/nbd.h                       |  2 +-
 include/chardev/char.h                    |  2 +-
 include/crypto/cipher.h                   |  2 +-
 include/crypto/hash.h                     |  2 +-
 include/crypto/hmac.h                     |  2 +-
 include/crypto/secret.h                   |  2 +-
 include/crypto/tlscreds.h                 |  2 +-
 include/exec/cpu_ldst_template.h          |  2 +-
 include/exec/cpu_ldst_useronly_template.h |  2 +-
 include/exec/helper-gen.h                 |  4 ++--
 include/exec/helper-proto.h               |  2 +-
 include/exec/helper-tcg.h                 |  2 +-
 include/hw/block/block.h                  |  2 +-
 include/hw/block/fdc.h                    |  2 +-
 include/hw/ppc/spapr_drc.h                |  2 +-
 include/hw/qdev-properties.h              |  4 ++--
 include/hw/xen/xen_common.h               |  2 +-
 include/io/dns-resolver.h                 |  2 +-
 include/migration/colo.h                  |  2 +-
 include/migration/failover.h              |  2 +-
 include/migration/global_state.h          |  2 +-
 include/monitor/monitor.h                 |  2 +-
 include/net/filter.h                      |  2 +-
 include/net/net.h                         |  2 +-
 include/qapi/error.h                      |  2 +-
 include/qapi/qmp/qobject.h                |  2 +-
 include/qapi/visitor.h                    |  2 +-
 include/qemu/osdep.h                      |  4 ++--
 include/qemu/sockets.h                    |  2 +-
 include/qemu/throttle.h                   |  2 +-
 include/qom/cpu.h                         |  2 +-
 include/qom/object.h                      |  2 +-
 include/sysemu/arch_init.h                |  2 +-
 include/sysemu/balloon.h                  |  2 +-
 include/sysemu/dump.h                     |  2 +-
 include/sysemu/hostmem.h                  |  2 +-
 include/sysemu/replay.h                   |  4 ++--
 include/sysemu/sysemu.h                   |  2 +-
 include/sysemu/tpm.h                      |  2 +-
 include/sysemu/watchdog.h                 |  2 +-
 include/sysemu/whpx.h                     |  2 +-
 include/trace-tcg.h                       |  2 +-
 include/ui/console.h                      |  2 +-
 include/ui/input.h                        |  2 +-
 migration/migration.h                     |  2 +-
 migration/ram.h                           |  2 +-
 net/tap_int.h                             |  2 +-
 qemu-options-wrapper.h                    |  2 +-
 replication.h                             |  2 +-
 target/s390x/cpu_models.h                 |  2 +-
 ui/vnc.h                                  |  2 +-
 accel/kvm/kvm-all.c                       |  2 +-
 accel/tcg/cpu-exec.c                      |  2 +-
 accel/tcg/translate-all.c                 |  2 +-
 arch_init.c                               |  2 +-
 audio/alsaaudio.c                         |  2 +-
 audio/ossaudio.c                          |  2 +-
 backends/hostmem.c                        |  2 +-
 balloon.c                                 |  4 ++--
 block.c                                   |  6 +++---
 block/backup.c                            |  2 +-
 block/block-backend.c                     |  4 ++--
 block/commit.c                            |  2 +-
 block/create.c                            |  2 +-
 block/crypto.c                            |  2 +-
 block/dirty-bitmap.c                      |  2 +-
 block/file-posix.c                        |  2 +-
 block/file-win32.c                        |  2 +-
 block/io.c                                |  2 +-
 block/iscsi.c                             |  2 +-
 block/mirror.c                            |  2 +-
 block/nbd.c                               |  2 +-
 block/nfs.c                               |  4 ++--
 block/nvme.c                              |  2 +-
 block/qapi.c                              |  4 ++--
 block/qcow2-cache.c                       |  2 +-
 block/qcow2-cluster.c                     |  2 +-
 block/qcow2.c                             |  6 +++---
 block/qed-l2-cache.c                      |  2 +-
 block/qed-table.c                         |  2 +-
 block/qed.c                               |  2 +-
 block/quorum.c                            |  2 +-
 block/rbd.c                               |  2 +-
 block/sheepdog.c                          |  4 ++--
 block/ssh.c                               |  4 ++--
 block/stream.c                            |  2 +-
 block/throttle-groups.c                   |  2 +-
 block/vxhs.c                              |  2 +-
 block/write-threshold.c                   |  4 ++--
 blockdev-nbd.c                            |  2 +-
 blockdev.c                                |  8 ++++----
 blockjob.c                                |  2 +-
 bsd-user/main.c                           |  2 +-
 chardev/char-ringbuf.c                    |  2 +-
 chardev/char-socket.c                     |  2 +-
 chardev/char.c                            |  2 +-
 chardev/spice.c                           |  2 +-
 chardev/wctablet.c                        |  2 +-
 cpus.c                                    |  4 ++--
 crypto/secret.c                           |  2 +-
 crypto/tlscreds.c                         |  2 +-
 crypto/tlscredsanon.c                     |  2 +-
 crypto/tlscredsx509.c                     |  2 +-
 crypto/tlssession.c                       |  2 +-
 dma-helpers.c                             |  2 +-
 dump.c                                    |  4 ++--
 exec.c                                    |  2 +-
 gdbstub.c                                 |  2 +-
 hmp.c                                     | 20 +++++++++----------
 hw/9pfs/9p.c                              |  2 +-
 hw/acpi/core.c                            |  4 ++--
 hw/acpi/cpu.c                             |  4 ++--
 hw/acpi/memory_hotplug.c                  |  4 ++--
 hw/acpi/tco.c                             |  2 +-
 hw/acpi/vmgenid.c                         |  2 +-
 hw/alpha/pci.c                            |  2 +-
 hw/arm/iotkit.c                           |  2 +-
 hw/arm/virt-acpi-build.c                  |  2 +-
 hw/audio/cs4231.c                         |  2 +-
 hw/audio/milkymist-ac97.c                 |  2 +-
 hw/block/block.c                          |  2 +-
 hw/block/dataplane/virtio-blk.c           |  2 +-
 hw/block/hd-geometry.c                    |  4 ++--
 hw/block/nvme.c                           |  2 +-
 hw/block/virtio-blk.c                     |  2 +-
 hw/block/xen_disk.c                       |  2 +-
 hw/char/cmsdk-apb-uart.c                  |  2 +-
 hw/char/escc.c                            |  2 +-
 hw/char/grlib_apbuart.c                   |  2 +-
 hw/char/lm32_juart.c                      |  2 +-
 hw/char/lm32_uart.c                       |  2 +-
 hw/char/milkymist-uart.c                  |  2 +-
 hw/char/pl011.c                           |  2 +-
 hw/char/virtio-console.c                  |  4 ++--
 hw/char/virtio-serial-bus.c               |  2 +-
 hw/core/machine.c                         |  2 +-
 hw/core/qdev.c                            |  2 +-
 hw/display/cirrus_vga.c                   |  2 +-
 hw/display/g364fb.c                       |  2 +-
 hw/display/jazz_led.c                     |  2 +-
 hw/display/milkymist-tmu2.c               |  2 +-
 hw/display/milkymist-vgafb.c              |  2 +-
 hw/display/qxl-render.c                   |  2 +-
 hw/display/qxl.c                          |  2 +-
 hw/display/sii9022.c                      |  2 +-
 hw/display/vga.c                          |  2 +-
 hw/display/virtio-gpu-3d.c                |  2 +-
 hw/display/virtio-gpu.c                   |  2 +-
 hw/display/vmware_vga.c                   |  2 +-
 hw/display/xenfb.c                        |  2 +-
 hw/dma/i8257.c                            |  2 +-
 hw/dma/rc4030.c                           |  2 +-
 hw/dma/sparc32_dma.c                      |  2 +-
 hw/hppa/pci.c                             |  2 +-
 hw/i386/amd_iommu.c                       |  2 +-
 hw/i386/intel_iommu.c                     |  2 +-
 hw/i386/pc.c                              |  2 +-
 hw/i386/vmport.c                          |  2 +-
 hw/i386/x86-iommu.c                       |  2 +-
 hw/i386/xen/xen-hvm.c                     |  4 ++--
 hw/i386/xen/xen-mapcache.c                |  2 +-
 hw/i386/xen/xen_platform.c                |  2 +-
 hw/i386/xen/xen_pvdevice.c                |  2 +-
 hw/ide/ahci-allwinner.c                   |  2 +-
 hw/ide/ahci.c                             |  2 +-
 hw/ide/atapi.c                            |  2 +-
 hw/ide/cmd646.c                           |  2 +-
 hw/ide/core.c                             |  2 +-
 hw/ide/pci.c                              |  2 +-
 hw/ide/piix.c                             |  2 +-
 hw/ide/sii3112.c                          |  2 +-
 hw/ide/via.c                              |  2 +-
 hw/input/adb-kbd.c                        |  2 +-
 hw/input/adb-mouse.c                      |  2 +-
 hw/input/hid.c                            |  2 +-
 hw/input/milkymist-softusb.c              |  2 +-
 hw/input/ps2.c                            |  2 +-
 hw/input/virtio-input.c                   |  2 +-
 hw/intc/apic.c                            |  2 +-
 hw/intc/apic_common.c                     |  2 +-
 hw/intc/arm_gic.c                         |  2 +-
 hw/intc/arm_gicv3_cpuif.c                 |  2 +-
 hw/intc/arm_gicv3_dist.c                  |  2 +-
 hw/intc/arm_gicv3_redist.c                |  2 +-
 hw/intc/armv7m_nvic.c                     |  2 +-
 hw/intc/aspeed_vic.c                      |  2 +-
 hw/intc/grlib_irqmp.c                     |  2 +-
 hw/intc/heathrow_pic.c                    |  2 +-
 hw/intc/i8259.c                           |  2 +-
 hw/intc/ioapic.c                          |  2 +-
 hw/intc/lm32_pic.c                        |  2 +-
 hw/intc/s390_flic.c                       |  2 +-
 hw/intc/s390_flic_kvm.c                   |  2 +-
 hw/intc/slavio_intctl.c                   |  2 +-
 hw/intc/xics.c                            |  2 +-
 hw/intc/xics_kvm.c                        |  2 +-
 hw/intc/xics_spapr.c                      |  2 +-
 hw/ipmi/ipmi.c                            |  2 +-
 hw/isa/pc87312.c                          |  2 +-
 hw/mem/pc-dimm.c                          |  2 +-
 hw/misc/aspeed_scu.c                      |  2 +-
 hw/misc/aspeed_sdmc.c                     |  2 +-
 hw/misc/eccmemctl.c                       |  2 +-
 hw/misc/imx7_gpr.c                        |  2 +-
 hw/misc/iotkit-secctl.c                   |  2 +-
 hw/misc/macio/cuda.c                      |  2 +-
 hw/misc/milkymist-hpdmc.c                 |  2 +-
 hw/misc/milkymist-pfpu.c                  |  2 +-
 hw/misc/mmio_interface.c                  |  2 +-
 hw/misc/mos6522.c                         |  2 +-
 hw/misc/mps2-fpgaio.c                     |  2 +-
 hw/misc/mps2-scc.c                        |  2 +-
 hw/misc/msf2-sysreg.c                     |  2 +-
 hw/misc/slavio_misc.c                     |  2 +-
 hw/misc/tz-ppc.c                          |  2 +-
 hw/net/e1000e.c                           |  2 +-
 hw/net/e1000e_core.c                      |  2 +-
 hw/net/e1000x_common.c                    |  2 +-
 hw/net/lance.c                            |  2 +-
 hw/net/milkymist-minimac2.c               |  2 +-
 hw/net/mipsnet.c                          |  2 +-
 hw/net/net_rx_pkt.c                       |  2 +-
 hw/net/opencores_eth.c                    |  2 +-
 hw/net/pcnet-pci.c                        |  2 +-
 hw/net/pcnet.c                            |  2 +-
 hw/net/rocker/qmp-norocker.c              |  2 +-
 hw/net/rocker/rocker.c                    |  2 +-
 hw/net/rocker/rocker_fp.c                 |  2 +-
 hw/net/rocker/rocker_of_dpa.c             |  2 +-
 hw/net/spapr_llan.c                       |  2 +-
 hw/net/sungem.c                           |  2 +-
 hw/net/sunhme.c                           |  2 +-
 hw/net/virtio-net.c                       |  2 +-
 hw/nvram/ds1225y.c                        |  2 +-
 hw/nvram/fw_cfg.c                         |  2 +-
 hw/pci-host/grackle.c                     |  2 +-
 hw/pci-host/sabre.c                       |  2 +-
 hw/pci-host/uninorth.c                    |  2 +-
 hw/pci/msix.c                             |  2 +-
 hw/pci/pci-stub.c                         |  2 +-
 hw/pci/pci.c                              |  4 ++--
 hw/pci/pci_host.c                         |  2 +-
 hw/ppc/mac_newworld.c                     |  2 +-
 hw/ppc/ppc.c                              |  2 +-
 hw/ppc/ppc440_pcix.c                      |  2 +-
 hw/ppc/ppc4xx_pci.c                       |  2 +-
 hw/ppc/prep.c                             |  2 +-
 hw/ppc/prep_systemio.c                    |  2 +-
 hw/ppc/rs6000_mc.c                        |  2 +-
 hw/ppc/spapr.c                            |  2 +-
 hw/ppc/spapr_drc.c                        |  2 +-
 hw/ppc/spapr_hcall.c                      |  2 +-
 hw/ppc/spapr_iommu.c                      |  2 +-
 hw/ppc/spapr_ovec.c                       |  2 +-
 hw/ppc/spapr_pci.c                        |  2 +-
 hw/ppc/spapr_rtas.c                       |  2 +-
 hw/ppc/spapr_rtas_ddw.c                   |  2 +-
 hw/ppc/spapr_rtc.c                        |  2 +-
 hw/ppc/spapr_vio.c                        |  2 +-
 hw/rdma/rdma_backend.c                    |  2 +-
 hw/rdma/vmw/pvrdma_main.c                 |  2 +-
 hw/s390x/css.c                            |  2 +-
 hw/s390x/s390-skeys.c                     |  2 +-
 hw/s390x/virtio-ccw.c                     |  2 +-
 hw/scsi/esp-pci.c                         |  2 +-
 hw/scsi/esp.c                             |  2 +-
 hw/scsi/megasas.c                         |  2 +-
 hw/scsi/mptconfig.c                       |  2 +-
 hw/scsi/mptendian.c                       |  2 +-
 hw/scsi/mptsas.c                          |  2 +-
 hw/scsi/scsi-bus.c                        |  2 +-
 hw/scsi/spapr_vscsi.c                     |  2 +-
 hw/scsi/vmw_pvscsi.c                      |  2 +-
 hw/sd/core.c                              |  2 +-
 hw/sd/milkymist-memcard.c                 |  2 +-
 hw/sd/pxa2xx_mmci.c                       |  2 +-
 hw/sd/sd.c                                |  2 +-
 hw/sd/sdhci.c                             |  2 +-
 hw/sparc/leon3.c                          |  2 +-
 hw/sparc/sun4m.c                          |  2 +-
 hw/sparc/sun4m_iommu.c                    |  2 +-
 hw/sparc64/sparc64.c                      |  2 +-
 hw/sparc64/sun4u.c                        |  2 +-
 hw/sparc64/sun4u_iommu.c                  |  2 +-
 hw/timer/armv7m_systick.c                 |  2 +-
 hw/timer/aspeed_timer.c                   |  2 +-
 hw/timer/cmsdk-apb-timer.c                |  2 +-
 hw/timer/grlib_gptimer.c                  |  2 +-
 hw/timer/lm32_timer.c                     |  2 +-
 hw/timer/mc146818rtc.c                    |  4 ++--
 hw/timer/milkymist-sysctl.c               |  2 +-
 hw/timer/slavio_timer.c                   |  2 +-
 hw/timer/xlnx-zynqmp-rtc.c                |  2 +-
 hw/tpm/tpm_crb.c                          |  2 +-
 hw/tpm/tpm_emulator.c                     |  4 ++--
 hw/tpm/tpm_passthrough.c                  |  4 ++--
 hw/tpm/tpm_tis.c                          |  2 +-
 hw/tpm/tpm_util.c                         |  2 +-
 hw/usb/bus.c                              |  2 +-
 hw/usb/combined-packet.c                  |  2 +-
 hw/usb/core.c                             |  2 +-
 hw/usb/desc.c                             |  2 +-
 hw/usb/dev-hub.c                          |  2 +-
 hw/usb/dev-mtp.c                          |  2 +-
 hw/usb/dev-uas.c                          |  2 +-
 hw/usb/hcd-ehci.c                         |  2 +-
 hw/usb/hcd-ohci.c                         |  2 +-
 hw/usb/hcd-uhci.c                         |  2 +-
 hw/usb/hcd-xhci.c                         |  2 +-
 hw/usb/host-libusb.c                      |  2 +-
 hw/vfio/common.c                          |  2 +-
 hw/vfio/pci-quirks.c                      |  2 +-
 hw/vfio/pci.c                             |  2 +-
 hw/vfio/platform.c                        |  2 +-
 hw/vfio/spapr.c                           |  2 +-
 hw/virtio/vhost-user.c                    |  2 +-
 hw/virtio/vhost.c                         |  2 +-
 hw/virtio/virtio-balloon.c                |  4 ++--
 hw/virtio/virtio-rng.c                    |  2 +-
 hw/virtio/virtio.c                        |  2 +-
 hw/watchdog/watchdog.c                    |  4 ++--
 io/channel-buffer.c                       |  2 +-
 io/channel-command.c                      |  2 +-
 io/channel-file.c                         |  2 +-
 io/channel-socket.c                       |  4 ++--
 io/channel-tls.c                          |  2 +-
 io/channel-websock.c                      |  2 +-
 io/dns-resolver.c                         |  2 +-
 io/task.c                                 |  2 +-
 ioport.c                                  |  2 +-
 iothread.c                                |  2 +-
 linux-user/main.c                         |  2 +-
 linux-user/signal.c                       |  2 +-
 memory.c                                  |  2 +-
 migration/channel.c                       |  2 +-
 migration/colo-comm.c                     |  2 +-
 migration/colo-failover.c                 |  4 ++--
 migration/colo.c                          |  4 ++--
 migration/exec.c                          |  2 +-
 migration/fd.c                            |  2 +-
 migration/global_state.c                  |  2 +-
 migration/migration.c                     |  6 +++---
 migration/postcopy-ram.c                  |  2 +-
 migration/qemu-file.c                     |  2 +-
 migration/ram.c                           |  4 ++--
 migration/rdma.c                          |  2 +-
 migration/savevm.c                        |  6 +++---
 migration/socket.c                        |  2 +-
 migration/tls.c                           |  2 +-
 migration/vmstate-types.c                 |  2 +-
 migration/vmstate.c                       |  2 +-
 monitor.c                                 | 12 ++++++------
 nbd/client.c                              |  2 +-
 nbd/common.c                              |  2 +-
 nbd/server.c                              |  2 +-
 net/colo-compare.c                        |  2 +-
 net/colo.c                                |  2 +-
 net/filter-buffer.c                       |  2 +-
 net/filter-mirror.c                       |  2 +-
 net/filter-rewriter.c                     |  2 +-
 net/net.c                                 |  4 ++--
 net/vhost-user.c                          |  4 ++--
 numa.c                                    |  4 ++--
 qapi/qapi-visit-core.c                    |  2 +-
 qdev-monitor.c                            |  2 +-
 qemu-img.c                                |  8 ++++----
 qemu-io.c                                 |  2 +-
 qemu-nbd.c                                |  2 +-
 qga/main.c                                |  2 +-
 qmp.c                                     |  8 ++++----
 qom/cpu.c                                 |  2 +-
 qom/object.c                              |  4 ++--
 replay/replay-input.c                     |  2 +-
 scsi/pr-manager.c                         |  2 +-
 scsi/qemu-pr-helper.c                     |  2 +-
 stubs/tpm.c                               |  2 +-
 stubs/uuid.c                              |  2 +-
 stubs/vmgenid.c                           |  2 +-
 stubs/xen-hvm.c                           |  2 +-
 target/arm/helper.c                       |  2 +-
 target/arm/monitor.c                      |  2 +-
 target/i386/cpu.c                         |  4 ++--
 target/i386/kvm.c                         |  2 +-
 target/mips/translate.c                   |  2 +-
 target/ppc/kvm.c                          |  2 +-
 target/s390x/cpu.c                        |  6 +++---
 target/s390x/cpu_features.c               |  2 +-
 target/s390x/ioinst.c                     |  2 +-
 target/s390x/kvm.c                        |  2 +-
 target/s390x/mmu_helper.c                 |  2 +-
 target/s390x/sigp.c                       |  4 ++--
 target/sparc/int32_helper.c               |  2 +-
 target/sparc/int64_helper.c               |  2 +-
 target/sparc/mmu_helper.c                 |  2 +-
 target/sparc/win_helper.c                 |  2 +-
 tests/qmp-test.c                          |  4 ++--
 tests/tcg/test_path.c                     |  2 +-
 tests/test-char.c                         |  2 +-
 tests/test-qmp-cmds.c                     |  6 +++---
 tests/test-qmp-event.c                    |  2 +-
 tests/test-qobject-input-visitor.c        |  6 +++---
 tpm.c                                     |  2 +-
 trace/control-target.c                    |  2 +-
 trace/control.c                           |  4 ++--
 trace/ftrace.c                            |  2 +-
 trace/qmp.c                               |  2 +-
 ui/console.c                              |  4 ++--
 ui/gtk-egl.c                              |  2 +-
 ui/gtk-gl-area.c                          |  2 +-
 ui/gtk.c                                  |  4 ++--
 ui/input-keymap.c                         | 32 +++++++++++++++----------------
 ui/input-legacy.c                         |  2 +-
 ui/input.c                                |  4 ++--
 ui/keymaps.c                              |  2 +-
 ui/shader.c                               |  6 +++---
 ui/spice-core.c                           |  4 ++--
 ui/spice-display.c                        |  2 +-
 ui/vnc-auth-sasl.c                        |  2 +-
 ui/vnc-auth-vencrypt.c                    |  2 +-
 ui/vnc-ws.c                               |  2 +-
 ui/vnc.c                                  |  6 +++---
 ui/x_keymap.c                             |  2 +-
 util/aio-posix.c                          |  2 +-
 util/async.c                              |  2 +-
 util/buffer.c                             |  2 +-
 util/hbitmap.c                            |  2 +-
 util/lockcnt.c                            |  2 +-
 util/oslib-posix.c                        |  2 +-
 util/oslib-win32.c                        |  2 +-
 util/qemu-config.c                        |  2 +-
 util/qemu-coroutine-lock.c                |  2 +-
 util/qemu-coroutine.c                     |  2 +-
 util/qemu-sockets.c                       |  2 +-
 util/qemu-thread-posix.c                  |  2 +-
 util/qemu-thread-win32.c                  |  2 +-
 util/thread-pool.c                        |  2 +-
 util/vfio-helpers.c                       |  4 ++--
 vl.c                                      | 14 +++++++-------
 scripts/qapi/types.py                     |  6 +++---
 scripts/qapi/visit.py                     |  6 +++---
 scripts/tracetool/backend/dtrace.py       |  4 ++--
 scripts/tracetool/format/c.py             |  4 ++--
 scripts/tracetool/format/tcg_h.py         |  4 ++--
 scripts/tracetool/format/tcg_helper_c.py  |  4 ++--
 target/s390x/Makefile.objs                |  7 ++++---
 trace-events                              |  2 +-
 ui/cocoa.m                                |  4 ++--
 version.rc                                |  2 +-
 453 files changed, 571 insertions(+), 570 deletions(-)

diff --git a/docs/devel/build-system.txt b/docs/devel/build-system.txt
index 52501f2..df924f4 100644
--- a/docs/devel/build-system.txt
+++ b/docs/devel/build-system.txt
@@ -385,7 +385,7 @@ block/Makefile.objs
 If there are any rules defined in the Makefile.objs file, they should
 all use $(obj) as a prefix to the target, e.g.
 
-  $(obj)/generated-tcg-tracers.h: $(obj)/generated-tcg-tracers.h-timestamp
+  qemu-build/$(obj)/generated-tcg-tracers.h: qemu-build/$(obj)/generated-tcg-tracers.h-timestamp
 
 
 - Makefile.target
diff --git a/docs/devel/tracing.txt b/docs/devel/tracing.txt
index 07abbb3..341b510 100644
--- a/docs/devel/tracing.txt
+++ b/docs/devel/tracing.txt
@@ -52,7 +52,7 @@ In the sub-directory the following files will be automatically generated
 Source files in the sub-directory should #include the local 'trace.h' file,
 without any sub-directory path prefix. eg io/channel-buffer.c would do
 
-  #include "trace.h"
+  #include "qemu-build/trace.h"
 
 To access the 'io/trace.h' file. While it is possible to include a trace.h
 file from outside a source files' own sub-directory, this is discouraged in
@@ -67,7 +67,7 @@ a trace.h in the current directory, vs the top level directory.
 
 Trace events are invoked directly from source code like this:
 
-    #include "trace.h"  /* needed for trace event prototype */
+    #include "qemu-build/trace.h"  /* needed for trace event prototype */
     
     void *qemu_vmalloc(size_t size)
     {
@@ -333,7 +333,7 @@ performed to generate values that are only used as arguments for a trace
 function. In these cases you can use the macro 'TRACE_${EVENT_NAME}_ENABLED' to
 guard such computations and avoid its compilation when the event is disabled:
 
-    #include "trace.h"  /* needed for trace event prototype */
+    #include "qemu-build/trace.h"  /* needed for trace event prototype */
     
     void *qemu_vmalloc(size_t size)
     {
diff --git a/crypto/cipherpriv.h b/crypto/cipherpriv.h
index 0823239..980214d 100644
--- a/crypto/cipherpriv.h
+++ b/crypto/cipherpriv.h
@@ -15,7 +15,7 @@
 #ifndef QCRYPTO_CIPHERPRIV_H
 #define QCRYPTO_CIPHERPRIV_H
 
-#include "qapi/qapi-types-crypto.h"
+#include "qemu-build/qapi/qapi-types-crypto.h"
 
 typedef struct QCryptoCipherDriver QCryptoCipherDriver;
 
diff --git a/include/block/block.h b/include/block/block.h
index cdec363..508fa1a 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -2,7 +2,7 @@
 #define BLOCK_H
 
 #include "block/aio.h"
-#include "qapi/qapi-types-block-core.h"
+#include "qemu-build/qapi/qapi-types-block-core.h"
 #include "block/aio-wait.h"
 #include "qemu/iov.h"
 #include "qemu/coroutine.h"
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 09efec6..8596b3f 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -2,7 +2,7 @@
 #define BLOCK_DIRTY_BITMAP_H
 
 #include "qemu-common.h"
-#include "qapi/qapi-types-block-core.h"
+#include "qemu-build/qapi/qapi-types-block-core.h"
 #include "qemu/hbitmap.h"
 
 BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDriverState *bs,
diff --git a/include/block/nbd.h b/include/block/nbd.h
index 2285637..2dfb994 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -20,7 +20,7 @@
 #ifndef NBD_H
 #define NBD_H
 
-#include "qapi/qapi-types-block.h"
+#include "qemu-build/qapi/qapi-types-block.h"
 #include "io/channel-socket.h"
 #include "crypto/tlscreds.h"
 
diff --git a/include/chardev/char.h b/include/chardev/char.h
index ebf1e0b..9934666 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -1,7 +1,7 @@
 #ifndef QEMU_CHAR_H
 #define QEMU_CHAR_H
 
-#include "qapi/qapi-types-char.h"
+#include "qemu-build/qapi/qapi-types-char.h"
 #include "qemu/main-loop.h"
 #include "qemu/bitmap.h"
 #include "qom/object.h"
diff --git a/include/crypto/cipher.h b/include/crypto/cipher.h
index bce2d4c..5a27c6a 100644
--- a/include/crypto/cipher.h
+++ b/include/crypto/cipher.h
@@ -21,7 +21,7 @@
 #ifndef QCRYPTO_CIPHER_H
 #define QCRYPTO_CIPHER_H
 
-#include "qapi/qapi-types-crypto.h"
+#include "qemu-build/qapi/qapi-types-crypto.h"
 
 typedef struct QCryptoCipher QCryptoCipher;
 
diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index 077ac7b..0890622 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -21,7 +21,7 @@
 #ifndef QCRYPTO_HASH_H
 #define QCRYPTO_HASH_H
 
-#include "qapi/qapi-types-crypto.h"
+#include "qemu-build/qapi/qapi-types-crypto.h"
 
 /* See also "QCryptoHashAlgorithm" defined in qapi/crypto.json */
 
diff --git a/include/crypto/hmac.h b/include/crypto/hmac.h
index aa3c97a..15e3ac7 100644
--- a/include/crypto/hmac.h
+++ b/include/crypto/hmac.h
@@ -12,7 +12,7 @@
 #ifndef QCRYPTO_HMAC_H
 #define QCRYPTO_HMAC_H
 
-#include "qapi/qapi-types-crypto.h"
+#include "qemu-build/qapi/qapi-types-crypto.h"
 
 typedef struct QCryptoHmac QCryptoHmac;
 struct QCryptoHmac {
diff --git a/include/crypto/secret.h b/include/crypto/secret.h
index edd0e13..e93cd7c 100644
--- a/include/crypto/secret.h
+++ b/include/crypto/secret.h
@@ -21,7 +21,7 @@
 #ifndef QCRYPTO_SECRET_H
 #define QCRYPTO_SECRET_H
 
-#include "qapi/qapi-types-crypto.h"
+#include "qemu-build/qapi/qapi-types-crypto.h"
 #include "qom/object.h"
 
 #define TYPE_QCRYPTO_SECRET "secret"
diff --git a/include/crypto/tlscreds.h b/include/crypto/tlscreds.h
index 6b011e1..0d60ee9 100644
--- a/include/crypto/tlscreds.h
+++ b/include/crypto/tlscreds.h
@@ -21,7 +21,7 @@
 #ifndef QCRYPTO_TLSCREDS_H
 #define QCRYPTO_TLSCREDS_H
 
-#include "qapi/qapi-types-crypto.h"
+#include "qemu-build/qapi/qapi-types-crypto.h"
 #include "qom/object.h"
 
 #ifdef CONFIG_GNUTLS
diff --git a/include/exec/cpu_ldst_template.h b/include/exec/cpu_ldst_template.h
index 4db2302..403004a 100644
--- a/include/exec/cpu_ldst_template.h
+++ b/include/exec/cpu_ldst_template.h
@@ -25,7 +25,7 @@
  */
 
 #if !defined(SOFTMMU_CODE_ACCESS)
-#include "trace-root.h"
+#include "qemu-build/trace-root.h"
 #endif
 
 #include "trace/mem.h"
diff --git a/include/exec/cpu_ldst_useronly_template.h b/include/exec/cpu_ldst_useronly_template.h
index c168f31..1112a51 100644
--- a/include/exec/cpu_ldst_useronly_template.h
+++ b/include/exec/cpu_ldst_useronly_template.h
@@ -24,7 +24,7 @@
  */
 
 #if !defined(CODE_ACCESS)
-#include "trace-root.h"
+#include "qemu-build/trace-root.h"
 #endif
 
 #include "trace/mem.h"
diff --git a/include/exec/helper-gen.h b/include/exec/helper-gen.h
index 22381a1..25a1f18 100644
--- a/include/exec/helper-gen.h
+++ b/include/exec/helper-gen.h
@@ -67,8 +67,8 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
 }
 
 #include "helper.h"
-#include "trace/generated-helpers.h"
-#include "trace/generated-helpers-wrappers.h"
+#include "qemu-build/trace/generated-helpers.h"
+#include "qemu-build/trace/generated-helpers-wrappers.h"
 #include "tcg-runtime.h"
 
 #undef DEF_HELPER_FLAGS_0
diff --git a/include/exec/helper-proto.h b/include/exec/helper-proto.h
index 74943ed..91d5711 100644
--- a/include/exec/helper-proto.h
+++ b/include/exec/helper-proto.h
@@ -31,7 +31,7 @@ dh_ctype(ret) HELPER(name) (dh_ctype(t1), dh_ctype(t2), dh_ctype(t3), \
                             dh_ctype(t4), dh_ctype(t5), dh_ctype(t6));
 
 #include "helper.h"
-#include "trace/generated-helpers.h"
+#include "qemu-build/trace/generated-helpers.h"
 #include "tcg-runtime.h"
 
 #undef DEF_HELPER_FLAGS_0
diff --git a/include/exec/helper-tcg.h b/include/exec/helper-tcg.h
index b3bdb0c..cd98a79 100644
--- a/include/exec/helper-tcg.h
+++ b/include/exec/helper-tcg.h
@@ -46,7 +46,7 @@
     | dh_sizemask(t5, 5) | dh_sizemask(t6, 6) },
 
 #include "helper.h"
-#include "trace/generated-helpers.h"
+#include "qemu-build/trace/generated-helpers.h"
 #include "tcg-runtime.h"
 
 #undef str
diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index d4f4dff..0208196 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -12,7 +12,7 @@
 #define HW_BLOCK_H
 
 #include "qemu-common.h"
-#include "qapi/qapi-types-block-core.h"
+#include "qemu-build/qapi/qapi-types-block-core.h"
 
 /* Configuration */
 
diff --git a/include/hw/block/fdc.h b/include/hw/block/fdc.h
index 3b813c7..7654e7f 100644
--- a/include/hw/block/fdc.h
+++ b/include/hw/block/fdc.h
@@ -2,7 +2,7 @@
 #define HW_FDC_H
 
 #include "qemu-common.h"
-#include "qapi/qapi-types-block.h"
+#include "qemu-build/qapi/qapi-types-block.h"
 
 /* fdc.c */
 #define MAX_FD 2
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index f6ff32e..8439be7 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -14,7 +14,7 @@
 #define HW_SPAPR_DRC_H
 
 #include <libfdt.h>
-#include "qapi/qapi-types-run-state.h"
+#include "qemu-build/qapi/qapi-types-run-state.h"
 #include "qom/object.h"
 #include "sysemu/sysemu.h"
 #include "hw/qdev.h"
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index b2ad8e9..30f0f38 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -1,8 +1,8 @@
 #ifndef QEMU_QDEV_PROPERTIES_H
 #define QEMU_QDEV_PROPERTIES_H
 
-#include "qapi/qapi-types-block.h"
-#include "qapi/qapi-types-misc.h"
+#include "qemu-build/qapi/qapi-types-block.h"
+#include "qemu-build/qapi/qapi-types-misc.h"
 #include "hw/qdev-core.h"
 
 /*** qdev-properties.c ***/
diff --git a/include/hw/xen/xen_common.h b/include/hw/xen/xen_common.h
index 64a978e..b45a55b 100644
--- a/include/hw/xen/xen_common.h
+++ b/include/hw/xen/xen_common.h
@@ -18,7 +18,7 @@
 #include "hw/xen/xen.h"
 #include "hw/pci/pci.h"
 #include "qemu/queue.h"
-#include "hw/xen/trace.h"
+#include "qemu-build/hw/xen/trace.h"
 
 extern xc_interface *xen_xc;
 
diff --git a/include/io/dns-resolver.h b/include/io/dns-resolver.h
index 1a16218..2699542 100644
--- a/include/io/dns-resolver.h
+++ b/include/io/dns-resolver.h
@@ -22,7 +22,7 @@
 #define QIO_DNS_RESOLVER_H
 
 #include "qemu-common.h"
-#include "qapi/qapi-types-sockets.h"
+#include "qemu-build/qapi/qapi-types-sockets.h"
 #include "qom/object.h"
 #include "io/task.h"
 
diff --git a/include/migration/colo.h b/include/migration/colo.h
index 2fe48ad..7bb1e8a 100644
--- a/include/migration/colo.h
+++ b/include/migration/colo.h
@@ -14,7 +14,7 @@
 #define QEMU_COLO_H
 
 #include "qemu-common.h"
-#include "qapi/qapi-types-migration.h"
+#include "qemu-build/qapi/qapi-types-migration.h"
 
 void colo_info_init(void);
 
diff --git a/include/migration/failover.h b/include/migration/failover.h
index 4c37218..01d90ab 100644
--- a/include/migration/failover.h
+++ b/include/migration/failover.h
@@ -14,7 +14,7 @@
 #define QEMU_FAILOVER_H
 
 #include "qemu-common.h"
-#include "qapi/qapi-types-migration.h"
+#include "qemu-build/qapi/qapi-types-migration.h"
 
 void failover_init_state(void);
 FailoverStatus failover_set_state(FailoverStatus old_state,
diff --git a/include/migration/global_state.h b/include/migration/global_state.h
index fd22dd3..1de6f3e 100644
--- a/include/migration/global_state.h
+++ b/include/migration/global_state.h
@@ -13,7 +13,7 @@
 #ifndef QEMU_MIGRATION_GLOBAL_STATE_H
 #define QEMU_MIGRATION_GLOBAL_STATE_H
 
-#include "qapi/qapi-types-run-state.h"
+#include "qemu-build/qapi/qapi-types-run-state.h"
 #include "sysemu/sysemu.h"
 
 void register_global_state(void);
diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index d1024d4..8ae3f5d 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -3,7 +3,7 @@
 
 #include "qemu-common.h"
 #include "block/block.h"
-#include "qapi/qapi-types-misc.h"
+#include "qemu-build/qapi/qapi-types-misc.h"
 #include "qemu/readline.h"
 
 extern Monitor *cur_mon;
diff --git a/include/net/filter.h b/include/net/filter.h
index 435acd6..f3bf5d3 100644
--- a/include/net/filter.h
+++ b/include/net/filter.h
@@ -9,7 +9,7 @@
 #ifndef QEMU_NET_FILTER_H
 #define QEMU_NET_FILTER_H
 
-#include "qapi/qapi-types-net.h"
+#include "qemu-build/qapi/qapi-types-net.h"
 #include "qom/object.h"
 #include "qemu-common.h"
 #include "net/queue.h"
diff --git a/include/net/net.h b/include/net/net.h
index a943e96..176ab74 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -2,7 +2,7 @@
 #define QEMU_NET_H
 
 #include "qemu/queue.h"
-#include "qapi/qapi-types-net.h"
+#include "qemu-build/qapi/qapi-types-net.h"
 #include "net/queue.h"
 #include "migration/vmstate.h"
 
diff --git a/include/qapi/error.h b/include/qapi/error.h
index bcb86a7..c5abd67 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -115,7 +115,7 @@
 #ifndef ERROR_H
 #define ERROR_H
 
-#include "qapi/qapi-types-common.h"
+#include "qemu-build/qapi/qapi-types-common.h"
 
 /*
  * Overall category of an error.
diff --git a/include/qapi/qmp/qobject.h b/include/qapi/qmp/qobject.h
index 012439a..b90574e 100644
--- a/include/qapi/qmp/qobject.h
+++ b/include/qapi/qmp/qobject.h
@@ -32,7 +32,7 @@
 #ifndef QOBJECT_H
 #define QOBJECT_H
 
-#include "qapi/qapi-builtin-types.h"
+#include "qemu-build/qapi/qapi-builtin-types.h"
 
 struct QObject {
     QType type;
diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
index 5b2ed3f..b45d135 100644
--- a/include/qapi/visitor.h
+++ b/include/qapi/visitor.h
@@ -15,7 +15,7 @@
 #ifndef QAPI_VISITOR_H
 #define QAPI_VISITOR_H
 
-#include "qapi/qapi-builtin-types.h"
+#include "qemu-build/qapi/qapi-builtin-types.h"
 
 /*
  * The QAPI schema defines both a set of C data types, and a QMP wire
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 4165806..e438fcf 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -27,9 +27,9 @@
 #ifndef QEMU_OSDEP_H
 #define QEMU_OSDEP_H
 
-#include "config-host.h"
+#include "qemu-build/config-host.h"
 #ifdef NEED_CPU_H
-#include "config-target.h"
+#include "qemu-build/config-target.h"
 #else
 #include "exec/poison.h"
 #endif
diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
index e88d4c3..13ae91e 100644
--- a/include/qemu/sockets.h
+++ b/include/qemu/sockets.h
@@ -9,7 +9,7 @@ int inet_aton(const char *cp, struct in_addr *ia);
 
 #endif /* !_WIN32 */
 
-#include "qapi/qapi-types-sockets.h"
+#include "qemu-build/qapi/qapi-types-sockets.h"
 
 /* misc helpers */
 int qemu_socket(int domain, int type, int protocol);
diff --git a/include/qemu/throttle.h b/include/qemu/throttle.h
index abeb886..98a7a3d 100644
--- a/include/qemu/throttle.h
+++ b/include/qemu/throttle.h
@@ -26,7 +26,7 @@
 #define THROTTLE_H
 
 #include "qemu-common.h"
-#include "qapi/qapi-types-block-core.h"
+#include "qemu-build/qapi/qapi-types-block-core.h"
 #include "qemu/timer.h"
 
 #define THROTTLE_VALUE_MAX 1000000000000000LL
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index dc6d495..50372bf 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -24,7 +24,7 @@
 #include "disas/bfd.h"
 #include "exec/hwaddr.h"
 #include "exec/memattrs.h"
-#include "qapi/qapi-types-run-state.h"
+#include "qemu-build/qapi/qapi-types-run-state.h"
 #include "qemu/bitmap.h"
 #include "qemu/queue.h"
 #include "qemu/thread.h"
diff --git a/include/qom/object.h b/include/qom/object.h
index 4f07090..52ee819 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -14,7 +14,7 @@
 #ifndef QEMU_OBJECT_H
 #define QEMU_OBJECT_H
 
-#include "qapi/qapi-builtin-types.h"
+#include "qemu-build/qapi/qapi-builtin-types.h"
 #include "qemu/queue.h"
 
 struct TypeImpl;
diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index 32abdfe..26aba01 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -1,7 +1,7 @@
 #ifndef QEMU_ARCH_INIT_H
 #define QEMU_ARCH_INIT_H
 
-#include "qapi/qapi-types-misc.h"
+#include "qemu-build/qapi/qapi-types-misc.h"
 
 enum {
     QEMU_ARCH_ALL = -1,
diff --git a/include/sysemu/balloon.h b/include/sysemu/balloon.h
index 66543ae..1a26270 100644
--- a/include/sysemu/balloon.h
+++ b/include/sysemu/balloon.h
@@ -14,7 +14,7 @@
 #ifndef QEMU_BALLOON_H
 #define QEMU_BALLOON_H
 
-#include "qapi/qapi-types-misc.h"
+#include "qemu-build/qapi/qapi-types-misc.h"
 
 typedef void (QEMUBalloonEvent)(void *opaque, ram_addr_t target);
 typedef void (QEMUBalloonStatus)(void *opaque, BalloonInfo *info);
diff --git a/include/sysemu/dump.h b/include/sysemu/dump.h
index d824bc0..8fd374d 100644
--- a/include/sysemu/dump.h
+++ b/include/sysemu/dump.h
@@ -14,7 +14,7 @@
 #ifndef DUMP_H
 #define DUMP_H
 
-#include "qapi/qapi-types-misc.h"
+#include "qemu-build/qapi/qapi-types-misc.h"
 
 #define MAKEDUMPFILE_SIGNATURE      "makedumpfile"
 #define MAX_SIZE_MDF_HEADER         (4096) /* max size of makedumpfile_header */
diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
index 47bc984..b99f3f3 100644
--- a/include/sysemu/hostmem.h
+++ b/include/sysemu/hostmem.h
@@ -14,7 +14,7 @@
 #define SYSEMU_HOSTMEM_H
 
 #include "sysemu/sysemu.h" /* for MAX_NODES */
-#include "qapi/qapi-types-misc.h"
+#include "qemu-build/qapi/qapi-types-misc.h"
 #include "qom/object.h"
 #include "exec/memory.h"
 #include "qemu/bitmap.h"
diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index c0204e6..f8a01a0 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -13,8 +13,8 @@
  */
 
 #include "sysemu.h"
-#include "qapi/qapi-types-misc.h"
-#include "qapi/qapi-types-ui.h"
+#include "qemu-build/qapi/qapi-types-misc.h"
+#include "qemu-build/qapi/qapi-types-ui.h"
 
 /* replay clock kinds */
 enum ReplayClockKind {
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 356bfdc..5b9b4fb 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -2,7 +2,7 @@
 #define SYSEMU_H
 /* Misc. things related to the system emulator.  */
 
-#include "qapi/qapi-types-run-state.h"
+#include "qemu-build/qapi/qapi-types-run-state.h"
 #include "qemu/queue.h"
 #include "qemu/timer.h"
 #include "qemu/notify.h"
diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
index 9ae1ab6..15965eb 100644
--- a/include/sysemu/tpm.h
+++ b/include/sysemu/tpm.h
@@ -12,7 +12,7 @@
 #ifndef QEMU_TPM_H
 #define QEMU_TPM_H
 
-#include "qapi/qapi-types-tpm.h"
+#include "qemu-build/qapi/qapi-types-tpm.h"
 #include "qom/object.h"
 
 int tpm_config_parse(QemuOptsList *opts_list, const char *optarg);
diff --git a/include/sysemu/watchdog.h b/include/sysemu/watchdog.h
index a08d163..a799d59 100644
--- a/include/sysemu/watchdog.h
+++ b/include/sysemu/watchdog.h
@@ -23,7 +23,7 @@
 #define QEMU_WATCHDOG_H
 
 #include "qemu/queue.h"
-#include "qapi/qapi-types-run-state.h"
+#include "qemu-build/qapi/qapi-types-run-state.h"
 
 struct WatchdogTimerModel {
     QLIST_ENTRY(WatchdogTimerModel) entry;
diff --git a/include/sysemu/whpx.h b/include/sysemu/whpx.h
index 89592ae..0eb5af8 100644
--- a/include/sysemu/whpx.h
+++ b/include/sysemu/whpx.h
@@ -13,7 +13,7 @@
 #ifndef QEMU_WHPX_H
 #define QEMU_WHPX_H
 
-#include "config-host.h"
+#include "qemu-build/config-host.h"
 #include "qemu-common.h"
 
 int whpx_init_vcpu(CPUState *cpu);
diff --git a/include/trace-tcg.h b/include/trace-tcg.h
index da68608..af8a25e 100644
--- a/include/trace-tcg.h
+++ b/include/trace-tcg.h
@@ -1,6 +1,6 @@
 #ifndef TRACE_TCG_H
 #define TRACE_TCG_H
 
-#include "trace/generated-tcg-tracers.h"
+#include "qemu-build/trace/generated-tcg-tracers.h"
 
 #endif /* TRACE_TCG_H */
diff --git a/include/ui/console.h b/include/ui/console.h
index 5fca9af..8638f2d 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -5,7 +5,7 @@
 #include "qom/object.h"
 #include "qemu/notify.h"
 #include "qemu/error-report.h"
-#include "qapi/qapi-types-ui.h"
+#include "qemu-build/qapi/qapi-types-ui.h"
 
 #ifdef CONFIG_OPENGL
 # include <epoxy/gl.h>
diff --git a/include/ui/input.h b/include/ui/input.h
index 16395ab..aa60f6e 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -1,7 +1,7 @@
 #ifndef INPUT_H
 #define INPUT_H
 
-#include "qapi/qapi-types-ui.h"
+#include "qemu-build/qapi/qapi-types-ui.h"
 
 #define INPUT_EVENT_MASK_KEY   (1<<INPUT_EVENT_KIND_KEY)
 #define INPUT_EVENT_MASK_BTN   (1<<INPUT_EVENT_KIND_BTN)
diff --git a/migration/migration.h b/migration/migration.h
index 83dc36b..925cd6a 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -15,7 +15,7 @@
 #define QEMU_MIGRATION_H
 
 #include "qemu-common.h"
-#include "qapi/qapi-types-migration.h"
+#include "qemu-build/qapi/qapi-types-migration.h"
 #include "qemu/thread.h"
 #include "exec/cpu-common.h"
 #include "qemu/coroutine_int.h"
diff --git a/migration/ram.h b/migration/ram.h
index 5030be1..c293c8c 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -30,7 +30,7 @@
 #define QEMU_MIGRATION_RAM_H
 
 #include "qemu-common.h"
-#include "qapi/qapi-types-migration.h"
+#include "qemu-build/qapi/qapi-types-migration.h"
 #include "exec/cpu-common.h"
 
 extern MigrationStats ram_counters;
diff --git a/net/tap_int.h b/net/tap_int.h
index 9f931d5..31b0857 100644
--- a/net/tap_int.h
+++ b/net/tap_int.h
@@ -27,7 +27,7 @@
 #define NET_TAP_INT_H
 
 #include "qemu-common.h"
-#include "qapi/qapi-types-net.h"
+#include "qemu-build/qapi/qapi-types-net.h"
 
 int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
              int vnet_hdr_required, int mq_required, Error **errp);
diff --git a/qemu-options-wrapper.h b/qemu-options-wrapper.h
index 13bfea0..8b9cc70 100644
--- a/qemu-options-wrapper.h
+++ b/qemu-options-wrapper.h
@@ -29,7 +29,7 @@
 #error "qemu-options-wrapper.h included with no option defined"
 #endif
 
-#include "qemu-options.def"
+#include "qemu-build/qemu-options.def"
 
 #undef DEF
 #undef DEFHEADING
diff --git a/replication.h b/replication.h
index 8faefe0..3b76211 100644
--- a/replication.h
+++ b/replication.h
@@ -15,7 +15,7 @@
 #ifndef REPLICATION_H
 #define REPLICATION_H
 
-#include "qapi/qapi-types-block-core.h"
+#include "qemu-build/qapi/qapi-types-block-core.h"
 #include "qemu/queue.h"
 
 typedef struct ReplicationOps ReplicationOps;
diff --git a/target/s390x/cpu_models.h b/target/s390x/cpu_models.h
index 11cf538..c0f31fb 100644
--- a/target/s390x/cpu_models.h
+++ b/target/s390x/cpu_models.h
@@ -14,7 +14,7 @@
 #define TARGET_S390X_CPU_MODELS_H
 
 #include "cpu_features.h"
-#include "gen-features.h"
+#include "qemu-build/gen-features.h"
 #include "qom/cpu.h"
 
 /* static CPU definition */
diff --git a/ui/vnc.h b/ui/vnc.h
index 7b29def..b2cfae5 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -28,7 +28,7 @@
 #define QEMU_VNC_H
 
 #include "qemu-common.h"
-#include "qapi/qapi-types-ui.h"
+#include "qemu-build/qapi/qapi-types-ui.h"
 #include "qemu/queue.h"
 #include "qemu/thread.h"
 #include "ui/console.h"
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index b91fcb7..69d5317 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -36,7 +36,7 @@
 #include "exec/ram_addr.h"
 #include "exec/address-spaces.h"
 #include "qemu/event_notifier.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "hw/irq.h"
 
 #include "hw/boards.h"
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 280200f..9c64f2c 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -18,7 +18,7 @@
  */
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "disas/disas.h"
 #include "exec/exec-all.h"
 #include "tcg.h"
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 67795cd..691b8fc 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -25,7 +25,7 @@
 #include "qemu-common.h"
 #define NO_CPU_IO_DEFS
 #include "cpu.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "disas/disas.h"
 #include "exec/exec-all.h"
 #include "tcg.h"
diff --git a/arch_init.c b/arch_init.c
index 6ee0747..5b8880b 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -28,7 +28,7 @@
 #include "sysemu/arch_init.h"
 #include "hw/pci/pci.h"
 #include "hw/audio/soundhw.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qemu-build/qapi/qapi-commands-misc.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "hw/acpi/acpi.h"
diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 362a227..16ce529 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -26,7 +26,7 @@
 #include "qemu-common.h"
 #include "qemu/main-loop.h"
 #include "audio.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #if QEMU_GNUC_PREREQ(4, 3)
 #pragma GCC diagnostic ignored "-Waddress"
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index 6c69622..7ad1cc7 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -28,7 +28,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/host-utils.h"
 #include "audio.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #define AUDIO_CAP "oss"
 #include "audio_int.h"
diff --git a/backends/hostmem.c b/backends/hostmem.c
index f610936..c42ef09 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -14,7 +14,7 @@
 #include "sysemu/hostmem.h"
 #include "hw/boards.h"
 #include "qapi/error.h"
-#include "qapi/qapi-builtin-visit.h"
+#include "qemu-build/qapi/qapi-builtin-visit.h"
 #include "qapi/visitor.h"
 #include "qemu/config-file.h"
 #include "qom/object_interfaces.h"
diff --git a/balloon.c b/balloon.c
index 6bf0a96..9841971 100644
--- a/balloon.c
+++ b/balloon.c
@@ -29,9 +29,9 @@
 #include "exec/cpu-common.h"
 #include "sysemu/kvm.h"
 #include "sysemu/balloon.h"
-#include "trace-root.h"
+#include "qemu-build/trace-root.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qemu-build/qapi/qapi-commands-misc.h"
 #include "qapi/qmp/qerror.h"
 
 static QEMUBalloonEvent *balloon_event_fn;
diff --git a/block.c b/block.c
index 75a9fd4..e35ba2d 100644
--- a/block.c
+++ b/block.c
@@ -23,19 +23,19 @@
  */
 
 #include "qemu/osdep.h"
-#include "block/trace.h"
+#include "qemu-build/block/trace.h"
 #include "block/block_int.h"
 #include "block/blockjob.h"
 #include "block/nbd.h"
 #include "qemu/error-report.h"
-#include "module_block.h"
+#include "qemu-build/module_block.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qobject-output-visitor.h"
-#include "qapi/qapi-visit-block-core.h"
+#include "qemu-build/qapi/qapi-visit-block-core.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/sysemu.h"
 #include "qemu/notify.h"
diff --git a/block/backup.c b/block/backup.c
index 4a16a37..16ef235 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -13,7 +13,7 @@
 
 #include "qemu/osdep.h"
 
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "block/block.h"
 #include "block/block_int.h"
 #include "block/blockjob_int.h"
diff --git a/block/block-backend.c b/block/block-backend.c
index f2e0a85..6b9f502 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -18,10 +18,10 @@
 #include "sysemu/blockdev.h"
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
-#include "qapi/qapi-events-block.h"
+#include "qemu-build/qapi/qapi-events-block.h"
 #include "qemu/id.h"
 #include "qemu/option.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "migration/misc.h"
 
 /* Number of coroutines to reserve per attached device model */
diff --git a/block/commit.c b/block/commit.c
index 1943c9c..f9462a7 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -14,7 +14,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "block/block_int.h"
 #include "block/blockjob_int.h"
 #include "qapi/error.h"
diff --git a/block/create.c b/block/create.c
index 8bd8a03..198fa33 100644
--- a/block/create.c
+++ b/block/create.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "block/block_int.h"
-#include "qapi/qapi-commands-block-core.h"
+#include "qemu-build/qapi/qapi-commands-block-core.h"
 #include "qapi/error.h"
 
 typedef struct BlockdevCreateCo {
diff --git a/block/crypto.c b/block/crypto.c
index e6095e7..8d550b4 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -24,7 +24,7 @@
 #include "sysemu/block-backend.h"
 #include "crypto/block.h"
 #include "qapi/opts-visitor.h"
-#include "qapi/qapi-visit-crypto.h"
+#include "qemu-build/qapi/qapi-visit-crypto.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/error.h"
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 909f051..4d18c21 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "block/block_int.h"
 #include "block/blockjob.h"
 
diff --git a/block/file-posix.c b/block/file-posix.c
index d7fb772..7918b5e 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -29,7 +29,7 @@
 #include "block/block_int.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "block/thread-pool.h"
 #include "qemu/iov.h"
 #include "block/raw-aio.h"
diff --git a/block/file-win32.c b/block/file-win32.c
index 2e2f746..d6ee6aa 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -29,7 +29,7 @@
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "block/raw-aio.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "block/thread-pool.h"
 #include "qemu/iov.h"
 #include "qapi/qmp/qdict.h"
diff --git a/block/io.c b/block/io.c
index 2b09c65..d1d8ef3 100644
--- a/block/io.c
+++ b/block/io.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "sysemu/block-backend.h"
 #include "block/aio-wait.h"
 #include "block/blockjob.h"
diff --git a/block/iscsi.c b/block/iscsi.c
index a82170f..0cf83d8 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -38,7 +38,7 @@
 #include "qemu/option.h"
 #include "qemu/uuid.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qemu-build/qapi/qapi-commands-misc.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
 #include "crypto/secret.h"
diff --git a/block/mirror.c b/block/mirror.c
index f5bf620..a8e36d9 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -13,7 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "block/blockjob_int.h"
 #include "block/block_int.h"
 #include "sysemu/block-backend.h"
diff --git a/block/nbd.c b/block/nbd.c
index d4e4172..6c3550c 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -33,7 +33,7 @@
 #include "block/block_int.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
-#include "qapi/qapi-visit-sockets.h"
+#include "qemu-build/qapi/qapi-visit-sockets.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/qmp/qdict.h"
diff --git a/block/nfs.c b/block/nfs.c
index 2577df4..b916a6b 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -29,13 +29,13 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "block/block_int.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qemu/iov.h"
 #include "qemu/option.h"
 #include "qemu/uri.h"
 #include "qemu/cutils.h"
 #include "sysemu/sysemu.h"
-#include "qapi/qapi-visit-block-core.h"
+#include "qemu-build/qapi/qapi-visit-block-core.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qobject-input-visitor.h"
diff --git a/block/nvme.c b/block/nvme.c
index 8bca57a..d17e1b7 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -21,7 +21,7 @@
 #include "qemu/option.h"
 #include "qemu/vfio-helpers.h"
 #include "block/block_int.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #include "block/nvme.h"
 
diff --git a/block/qapi.c b/block/qapi.c
index 4c9923d..dd2d5b8 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -28,9 +28,9 @@
 #include "block/throttle-groups.h"
 #include "block/write-threshold.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-block-core.h"
+#include "qemu-build/qapi/qapi-commands-block-core.h"
 #include "qapi/qobject-output-visitor.h"
-#include "qapi/qapi-visit-block-core.h"
+#include "qemu-build/qapi/qapi-visit-block-core.h"
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index d9dafa3..867e05f 100644
--- a/block/qcow2-cache.c
+++ b/block/qcow2-cache.c
@@ -26,7 +26,7 @@
 #include "block/block_int.h"
 #include "qemu-common.h"
 #include "qcow2.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 typedef struct Qcow2CachedTable {
     int64_t  offset;
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 1aee726..0e0cef3 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -30,7 +30,7 @@
 #include "block/block_int.h"
 #include "block/qcow2.h"
 #include "qemu/bswap.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 int qcow2_shrink_l1_table(BlockDriverState *bs, uint64_t exact_size)
 {
diff --git a/block/qcow2.c b/block/qcow2.c
index 7472af6..8b32378 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -30,15 +30,15 @@
 #include "block/qcow2.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "qapi/qapi-events-block-core.h"
+#include "qemu-build/qapi/qapi-events-block-core.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qemu/option_int.h"
 #include "qemu/cutils.h"
 #include "qemu/bswap.h"
 #include "qapi/qobject-input-visitor.h"
-#include "qapi/qapi-visit-block-core.h"
+#include "qemu-build/qapi/qapi-visit-block-core.h"
 #include "block/crypto.h"
 
 /*
diff --git a/block/qed-l2-cache.c b/block/qed-l2-cache.c
index b548362..f317642 100644
--- a/block/qed-l2-cache.c
+++ b/block/qed-l2-cache.c
@@ -51,7 +51,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qed.h"
 
 /* Each L2 holds 2GB so this let's us fully cache a 100GB disk */
diff --git a/block/qed-table.c b/block/qed-table.c
index 7df5680..62a1bf4 100644
--- a/block/qed-table.c
+++ b/block/qed-table.c
@@ -13,7 +13,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qemu/sockets.h" /* for EINPROGRESS on Windows */
 #include "qed.h"
 #include "qemu/bswap.h"
diff --git a/block/qed.c b/block/qed.c
index 5e6a6bf..0001c71 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -17,7 +17,7 @@
 #include "qemu/timer.h"
 #include "qemu/bswap.h"
 #include "qemu/option.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qed.h"
 #include "sysemu/block-backend.h"
 
diff --git a/block/quorum.c b/block/quorum.c
index 14333c1..a25fc07 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -18,7 +18,7 @@
 #include "qemu/option.h"
 #include "block/block_int.h"
 #include "qapi/error.h"
-#include "qapi/qapi-events-block.h"
+#include "qemu-build/qapi/qapi-events-block.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qlist.h"
diff --git a/block/rbd.c b/block/rbd.c
index 294ed07..fe0a57c 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -25,7 +25,7 @@
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qlist.h"
 #include "qapi/qobject-input-visitor.h"
-#include "qapi/qapi-visit-block-core.h"
+#include "qemu-build/qapi/qapi-visit-block-core.h"
 
 /*
  * When specifying the image filename use:
diff --git a/block/sheepdog.c b/block/sheepdog.c
index 8680b29..ac94636 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -14,8 +14,8 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qapi-visit-sockets.h"
-#include "qapi/qapi-visit-block-core.h"
+#include "qemu-build/qapi/qapi-visit-sockets.h"
+#include "qemu-build/qapi/qapi-visit-block-core.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
diff --git a/block/ssh.c b/block/ssh.c
index ab3acf0..dbc8354 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -34,8 +34,8 @@
 #include "qemu/cutils.h"
 #include "qemu/sockets.h"
 #include "qemu/uri.h"
-#include "qapi/qapi-visit-sockets.h"
-#include "qapi/qapi-visit-block-core.h"
+#include "qemu-build/qapi/qapi-visit-sockets.h"
+#include "qemu-build/qapi/qapi-visit-block-core.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qobject-input-visitor.h"
diff --git a/block/stream.c b/block/stream.c
index 499cdac..04f4ce2 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -12,7 +12,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "block/block_int.h"
 #include "block/blockjob_int.h"
 #include "qapi/error.h"
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 36cc043..00bb97e 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -30,7 +30,7 @@
 #include "qemu/thread.h"
 #include "sysemu/qtest.h"
 #include "qapi/error.h"
-#include "qapi/qapi-visit-block-core.h"
+#include "qemu-build/qapi/qapi-visit-block-core.h"
 #include "qom/object.h"
 #include "qom/object_interfaces.h"
 
diff --git a/block/vxhs.c b/block/vxhs.c
index 75cc6c8..5c01cef 100644
--- a/block/vxhs.c
+++ b/block/vxhs.c
@@ -15,7 +15,7 @@
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qemu/uri.h"
 #include "qapi/error.h"
 #include "qemu/uuid.h"
diff --git a/block/write-threshold.c b/block/write-threshold.c
index 1d48fc2..5c97154 100644
--- a/block/write-threshold.c
+++ b/block/write-threshold.c
@@ -16,8 +16,8 @@
 #include "block/write-threshold.h"
 #include "qemu/notify.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-block-core.h"
-#include "qapi/qapi-events-block-core.h"
+#include "qemu-build/qapi/qapi-commands-block-core.h"
+#include "qemu-build/qapi/qapi-events-block-core.h"
 
 uint64_t bdrv_write_threshold_get(const BlockDriverState *bs)
 {
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 65a8473..98f0076 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -14,7 +14,7 @@
 #include "sysemu/block-backend.h"
 #include "hw/block/block.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-block.h"
+#include "qemu-build/qapi/qapi-commands-block.h"
 #include "sysemu/sysemu.h"
 #include "block/nbd.h"
 #include "io/channel-socket.h"
diff --git a/blockdev.c b/blockdev.c
index 1fbfd3a..c475105 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -40,9 +40,9 @@
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
-#include "qapi/qapi-commands-block.h"
-#include "qapi/qapi-commands-transaction.h"
-#include "qapi/qapi-visit-block-core.h"
+#include "qemu-build/qapi/qapi-commands-block.h"
+#include "qemu-build/qapi/qapi-commands-transaction.h"
+#include "qemu-build/qapi/qapi-visit-block-core.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
@@ -53,7 +53,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/iothread.h"
 #include "block/block_int.h"
-#include "block/trace.h"
+#include "qemu-build/block/trace.h"
 #include "sysemu/arch_init.h"
 #include "sysemu/qtest.h"
 #include "qemu/cutils.h"
diff --git a/blockjob.c b/blockjob.c
index 801d29d..8b9a9c3 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -30,7 +30,7 @@
 #include "block/block_int.h"
 #include "sysemu/block-backend.h"
 #include "qapi/error.h"
-#include "qapi/qapi-events-block-core.h"
+#include "qemu-build/qapi/qapi-events-block-core.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/coroutine.h"
 #include "qemu/id.h"
diff --git a/bsd-user/main.c b/bsd-user/main.c
index efef5ff..3d3ca33 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -17,7 +17,7 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
-#include "qemu-version.h"
+#include "qemu-build/qemu-version.h"
 #include <machine/trap.h>
 
 #include "qapi/error.h"
diff --git a/chardev/char-ringbuf.c b/chardev/char-ringbuf.c
index 87832e2..bec68d6 100644
--- a/chardev/char-ringbuf.c
+++ b/chardev/char-ringbuf.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "chardev/char.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-char.h"
+#include "qemu-build/qapi/qapi-commands-char.h"
 #include "qemu/base64.h"
 #include "qemu/option.h"
 
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index a220803..84133cb 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -31,7 +31,7 @@
 #include "qemu/option.h"
 #include "qapi/error.h"
 #include "qapi/clone-visitor.h"
-#include "qapi/qapi-visit-sockets.h"
+#include "qemu-build/qapi/qapi-visit-sockets.h"
 
 #include "chardev/char-io.h"
 
diff --git a/chardev/char.c b/chardev/char.c
index 5d7b079..8c7f724 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -30,7 +30,7 @@
 #include "qemu/error-report.h"
 #include "chardev/char.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-char.h"
+#include "qemu-build/qapi/qapi-commands-char.h"
 #include "qapi/qmp/qerror.h"
 #include "sysemu/replay.h"
 #include "qemu/help_option.h"
diff --git a/chardev/spice.c b/chardev/spice.c
index e66e3ad..0411d8a 100644
--- a/chardev/spice.c
+++ b/chardev/spice.c
@@ -1,5 +1,5 @@
 #include "qemu/osdep.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "ui/qemu-spice.h"
 #include "chardev/char.h"
 #include "qapi/error.h"
diff --git a/chardev/wctablet.c b/chardev/wctablet.c
index 969d014..b3d70aa 100644
--- a/chardev/wctablet.c
+++ b/chardev/wctablet.c
@@ -31,7 +31,7 @@
 #include "chardev/char-serial.h"
 #include "ui/console.h"
 #include "ui/input.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 
 #define WC_OUTPUT_BUF_MAX_LEN 512
diff --git a/cpus.c b/cpus.c
index c652da8..ccbeba1 100644
--- a/cpus.c
+++ b/cpus.c
@@ -27,8 +27,8 @@
 #include "cpu.h"
 #include "monitor/monitor.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
-#include "qapi/qapi-events-run-state.h"
+#include "qemu-build/qapi/qapi-commands-misc.h"
+#include "qemu-build/qapi/qapi-events-run-state.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 #include "sysemu/sysemu.h"
diff --git a/crypto/secret.c b/crypto/secret.c
index 388abd7..a55786f 100644
--- a/crypto/secret.c
+++ b/crypto/secret.c
@@ -24,7 +24,7 @@
 #include "qapi/error.h"
 #include "qom/object_interfaces.h"
 #include "qemu/base64.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 
 static void
diff --git a/crypto/tlscreds.c b/crypto/tlscreds.c
index 3cd4103..10aa1cc 100644
--- a/crypto/tlscreds.c
+++ b/crypto/tlscreds.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "crypto/tlscredspriv.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #define DH_BITS 2048
 
diff --git a/crypto/tlscredsanon.c b/crypto/tlscredsanon.c
index 1464220..d22d1e7 100644
--- a/crypto/tlscredsanon.c
+++ b/crypto/tlscredsanon.c
@@ -23,7 +23,7 @@
 #include "crypto/tlscredspriv.h"
 #include "qapi/error.h"
 #include "qom/object_interfaces.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 
 #ifdef CONFIG_GNUTLS
diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
index 50eb54f..a3dd491 100644
--- a/crypto/tlscredsx509.c
+++ b/crypto/tlscredsx509.c
@@ -24,7 +24,7 @@
 #include "crypto/secret.h"
 #include "qapi/error.h"
 #include "qom/object_interfaces.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 
 #ifdef CONFIG_GNUTLS
diff --git a/crypto/tlssession.c b/crypto/tlssession.c
index 96a02de..1226cff 100644
--- a/crypto/tlssession.c
+++ b/crypto/tlssession.c
@@ -24,7 +24,7 @@
 #include "crypto/tlscredsx509.h"
 #include "qapi/error.h"
 #include "qemu/acl.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #ifdef CONFIG_GNUTLS
 
diff --git a/dma-helpers.c b/dma-helpers.c
index 2d7e02d..b819443 100644
--- a/dma-helpers.c
+++ b/dma-helpers.c
@@ -10,7 +10,7 @@
 #include "qemu/osdep.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/dma.h"
-#include "trace-root.h"
+#include "qemu-build/trace-root.h"
 #include "qemu/thread.h"
 #include "qemu/main-loop.h"
 
diff --git a/dump.c b/dump.c
index 097e60b..345c2c1 100644
--- a/dump.c
+++ b/dump.c
@@ -23,8 +23,8 @@
 #include "sysemu/memory_mapping.h"
 #include "sysemu/cpus.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
-#include "qapi/qapi-events-misc.h"
+#include "qemu-build/qapi/qapi-commands-misc.h"
+#include "qemu-build/qapi/qapi-events-misc.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 #include "hw/misc/vmcoreinfo.h"
diff --git a/exec.c b/exec.c
index 0eb890d..630288c 100644
--- a/exec.c
+++ b/exec.c
@@ -46,7 +46,7 @@
 #include "sysemu/hw_accel.h"
 #include "exec/address-spaces.h"
 #include "sysemu/xen-mapcache.h"
-#include "trace-root.h"
+#include "qemu-build/trace-root.h"
 
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
 #include <linux/falloc.h>
diff --git a/gdbstub.c b/gdbstub.c
index f1d5148..707a8ff 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -21,7 +21,7 @@
 #include "qemu/error-report.h"
 #include "qemu/cutils.h"
 #include "cpu.h"
-#include "trace-root.h"
+#include "qemu-build/trace-root.h"
 #ifdef CONFIG_USER_ONLY
 #include "qemu.h"
 #else
diff --git a/hmp.c b/hmp.c
index a277517..c8429a8 100644
--- a/hmp.c
+++ b/hmp.c
@@ -28,16 +28,16 @@
 #include "monitor/qdev.h"
 #include "qapi/error.h"
 #include "qapi/opts-visitor.h"
-#include "qapi/qapi-builtin-visit.h"
-#include "qapi/qapi-commands-block.h"
-#include "qapi/qapi-commands-char.h"
-#include "qapi/qapi-commands-migration.h"
-#include "qapi/qapi-commands-misc.h"
-#include "qapi/qapi-commands-net.h"
-#include "qapi/qapi-commands-rocker.h"
-#include "qapi/qapi-commands-run-state.h"
-#include "qapi/qapi-commands-tpm.h"
-#include "qapi/qapi-commands-ui.h"
+#include "qemu-build/qapi/qapi-builtin-visit.h"
+#include "qemu-build/qapi/qapi-commands-block.h"
+#include "qemu-build/qapi/qapi-commands-char.h"
+#include "qemu-build/qapi/qapi-commands-migration.h"
+#include "qemu-build/qapi/qapi-commands-misc.h"
+#include "qemu-build/qapi/qapi-commands-net.h"
+#include "qemu-build/qapi/qapi-commands-rocker.h"
+#include "qemu-build/qapi/qapi-commands-run-state.h"
+#include "qemu-build/qapi/qapi-commands-tpm.h"
+#include "qemu-build/qapi/qapi-commands-ui.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/string-input-visitor.h"
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 48fa48e..01724fe 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -22,7 +22,7 @@
 #include "fsdev/qemu-fsdev.h"
 #include "9p-xattr.h"
 #include "coth.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "migration/blocker.h"
 #include "sysemu/qtest.h"
 
diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index b8d3901..a4f8b9c 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -27,8 +27,8 @@
 #include "qemu/config-file.h"
 #include "qapi/error.h"
 #include "qapi/opts-visitor.h"
-#include "qapi/qapi-events-run-state.h"
-#include "qapi/qapi-visit-misc.h"
+#include "qemu-build/qapi/qapi-events-run-state.h"
+#include "qemu-build/qapi/qapi-visit-misc.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 
diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 5ae595e..ffc2365 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -2,8 +2,8 @@
 #include "hw/boards.h"
 #include "hw/acpi/cpu.h"
 #include "qapi/error.h"
-#include "qapi/qapi-events-misc.h"
-#include "trace.h"
+#include "qemu-build/qapi/qapi-events-misc.h"
+#include "qemu-build/trace.h"
 #include "sysemu/numa.h"
 
 #define ACPI_CPU_HOTPLUG_REG_LEN 12
diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
index 0ff1712..3f605ad 100644
--- a/hw/acpi/memory_hotplug.c
+++ b/hw/acpi/memory_hotplug.c
@@ -4,9 +4,9 @@
 #include "hw/mem/pc-dimm.h"
 #include "hw/boards.h"
 #include "hw/qdev-core.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qapi/error.h"
-#include "qapi/qapi-events-misc.h"
+#include "qemu-build/qapi/qapi-events-misc.h"
 
 #define MEMORY_SLOTS_NUMBER          "MDNR"
 #define MEMORY_HOTPLUG_IO_REGION     "HPMR"
diff --git a/hw/acpi/tco.c b/hw/acpi/tco.c
index a914396..7838d0a 100644
--- a/hw/acpi/tco.c
+++ b/hw/acpi/tco.c
@@ -12,7 +12,7 @@
 #include "hw/i386/ich9.h"
 
 #include "hw/acpi/tco.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 //#define DEBUG
 
diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index d78b579..b6bad64 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -12,7 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qemu-build/qapi/qapi-commands-misc.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/aml-build.h"
 #include "hw/acpi/vmgenid.h"
diff --git a/hw/alpha/pci.c b/hw/alpha/pci.c
index 8dde637..ed73926 100644
--- a/hw/alpha/pci.c
+++ b/hw/alpha/pci.c
@@ -11,7 +11,7 @@
 #include "alpha_sys.h"
 #include "qemu/log.h"
 #include "sysemu/sysemu.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 
 /* Fallback for unassigned PCI I/O operations.  Avoids MCHK.  */
diff --git a/hw/arm/iotkit.c b/hw/arm/iotkit.c
index c5f0a5b..e7902be 100644
--- a/hw/arm/iotkit.c
+++ b/hw/arm/iotkit.c
@@ -12,7 +12,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qapi/error.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "hw/sysbus.h"
 #include "hw/registerfields.h"
 #include "hw/arm/iotkit.h"
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index c7c6a57..a4e2070 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -30,7 +30,7 @@
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "qemu/bitmap.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qom/cpu.h"
 #include "target/arm/cpu.h"
 #include "hw/acpi/acpi-defs.h"
diff --git a/hw/audio/cs4231.c b/hw/audio/cs4231.c
index 30690f9..a1f8c04 100644
--- a/hw/audio/cs4231.c
+++ b/hw/audio/cs4231.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 /*
  * In addition to Crystal CS4231 there is a DMA controller on Sparc.
diff --git a/hw/audio/milkymist-ac97.c b/hw/audio/milkymist-ac97.c
index bc8db71..890d69b 100644
--- a/hw/audio/milkymist-ac97.c
+++ b/hw/audio/milkymist-ac97.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "audio/audio.h"
 #include "qemu/error-report.h"
 
diff --git a/hw/block/block.c b/hw/block/block.c
index b91e2b6..87b8604 100644
--- a/hw/block/block.c
+++ b/hw/block/block.c
@@ -12,7 +12,7 @@
 #include "sysemu/block-backend.h"
 #include "hw/block/block.h"
 #include "qapi/error.h"
-#include "qapi/qapi-types-block.h"
+#include "qemu-build/qapi/qapi-types-block.h"
 #include "qemu/error-report.h"
 
 void blkconf_serial(BlockConf *conf, char **serial)
diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-blk.c
index 101f32c..f771f60 100644
--- a/hw/block/dataplane/virtio-blk.c
+++ b/hw/block/dataplane/virtio-blk.c
@@ -14,7 +14,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qemu/iov.h"
 #include "qemu/thread.h"
 #include "qemu/error-report.h"
diff --git a/hw/block/hd-geometry.c b/hw/block/hd-geometry.c
index 79384a2..a9bd329 100644
--- a/hw/block/hd-geometry.c
+++ b/hw/block/hd-geometry.c
@@ -32,10 +32,10 @@
 
 #include "qemu/osdep.h"
 #include "sysemu/block-backend.h"
-#include "qapi/qapi-types-block.h"
+#include "qemu-build/qapi/qapi-types-block.h"
 #include "qemu/bswap.h"
 #include "hw/block/block.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 struct partition {
         uint8_t boot_ind;           /* 0x80 - active */
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 85d2406..5588147 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -35,7 +35,7 @@
 #include "sysemu/block-backend.h"
 
 #include "qemu/log.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "nvme.h"
 
 #define NVME_GUEST_ERR(trace, fmt, ...) \
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index b1532e4..25b1b7a 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -16,7 +16,7 @@
 #include "qemu-common.h"
 #include "qemu/iov.h"
 #include "qemu/error-report.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "hw/block/block.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
index f74fcd4..a3230d7 100644
--- a/hw/block/xen_disk.c
+++ b/hw/block/xen_disk.c
@@ -32,7 +32,7 @@
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 /* ------------------------------------------------------------- */
 
diff --git a/hw/char/cmsdk-apb-uart.c b/hw/char/cmsdk-apb-uart.c
index 1ad1e14..2049fb7 100644
--- a/hw/char/cmsdk-apb-uart.c
+++ b/hw/char/cmsdk-apb-uart.c
@@ -18,7 +18,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qapi/error.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "hw/sysbus.h"
 #include "hw/registerfields.h"
 #include "chardev/char-fe.h"
diff --git a/hw/char/escc.c b/hw/char/escc.c
index 628f5f8..5dc9d6d 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -27,7 +27,7 @@
 #include "hw/sysbus.h"
 #include "hw/char/escc.h"
 #include "ui/console.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 /*
  * Chipset docs:
diff --git a/hw/char/grlib_apbuart.c b/hw/char/grlib_apbuart.c
index bac11be..1de92e4 100644
--- a/hw/char/grlib_apbuart.c
+++ b/hw/char/grlib_apbuart.c
@@ -26,7 +26,7 @@
 #include "hw/sysbus.h"
 #include "chardev/char-fe.h"
 
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #define UART_REG_SIZE 20     /* Size of memory mapped registers */
 
diff --git a/hw/char/lm32_juart.c b/hw/char/lm32_juart.c
index d75c835..4015395 100644
--- a/hw/char/lm32_juart.c
+++ b/hw/char/lm32_juart.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "chardev/char-fe.h"
 
 #include "hw/char/lm32_juart.h"
diff --git a/hw/char/lm32_uart.c b/hw/char/lm32_uart.c
index c4a3b9b..023eefa 100644
--- a/hw/char/lm32_uart.c
+++ b/hw/char/lm32_uart.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "chardev/char-fe.h"
 #include "qemu/error-report.h"
 
diff --git a/hw/char/milkymist-uart.c b/hw/char/milkymist-uart.c
index 548ee27..b5b61de 100644
--- a/hw/char/milkymist-uart.c
+++ b/hw/char/milkymist-uart.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "chardev/char-fe.h"
 #include "qemu/error-report.h"
 
diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 2aa277f..10d7d3a 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -11,7 +11,7 @@
 #include "hw/sysbus.h"
 #include "chardev/char-fe.h"
 #include "qemu/log.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #define TYPE_PL011 "pl011"
 #define PL011(obj) OBJECT_CHECK(PL011State, (obj), TYPE_PL011)
diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index 679a824..3c43082 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -13,10 +13,10 @@
 #include "qemu/osdep.h"
 #include "chardev/char-fe.h"
 #include "qemu/error-report.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "hw/virtio/virtio-serial.h"
 #include "qapi/error.h"
-#include "qapi/qapi-events-char.h"
+#include "qemu-build/qapi/qapi-events-char.h"
 
 #define TYPE_VIRTIO_CONSOLE_SERIAL_PORT "virtserialport"
 #define VIRTIO_CONSOLE(obj) \
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 9470bd7..69fbfa9 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -25,7 +25,7 @@
 #include "qemu/error-report.h"
 #include "qemu/queue.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "hw/virtio/virtio-serial.h"
 #include "hw/virtio/virtio-access.h"
 
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 5e2bbcd..0b48e74 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "hw/boards.h"
 #include "qapi/error.h"
-#include "qapi/qapi-visit-common.h"
+#include "qemu-build/qapi/qapi-visit-common.h"
 #include "qapi/visitor.h"
 #include "hw/sysbus.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index f6f9247..5003440 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -29,7 +29,7 @@
 #include "hw/qdev.h"
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
-#include "qapi/qapi-events-misc.h"
+#include "qemu-build/qapi/qapi-events-misc.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 138ae96..e01022c 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -28,7 +28,7 @@
  */
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "ui/pixel_ops.h"
diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
index 3d75394..5aca941 100644
--- a/hw/display/g364fb.c
+++ b/hw/display/g364fb.c
@@ -22,7 +22,7 @@
 #include "qemu/error-report.h"
 #include "ui/console.h"
 #include "ui/pixel_ops.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "hw/sysbus.h"
 
 typedef struct G364State {
diff --git a/hw/display/jazz_led.c b/hw/display/jazz_led.c
index 3c97d56..c48b623 100644
--- a/hw/display/jazz_led.c
+++ b/hw/display/jazz_led.c
@@ -26,7 +26,7 @@
 #include "qemu-common.h"
 #include "ui/console.h"
 #include "ui/pixel_ops.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "hw/sysbus.h"
 
 typedef enum {
diff --git a/hw/display/milkymist-tmu2.c b/hw/display/milkymist-tmu2.c
index 3ce44fd..981b15f 100644
--- a/hw/display/milkymist-tmu2.c
+++ b/hw/display/milkymist-tmu2.c
@@ -27,7 +27,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
diff --git a/hw/display/milkymist-vgafb.c b/hw/display/milkymist-vgafb.c
index 177fdac..fec6c2f 100644
--- a/hw/display/milkymist-vgafb.c
+++ b/hw/display/milkymist-vgafb.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "ui/console.h"
 #include "framebuffer.h"
 #include "ui/pixel_ops.h"
diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
index e7ac4f8..53d8376 100644
--- a/hw/display/qxl-render.c
+++ b/hw/display/qxl-render.c
@@ -21,7 +21,7 @@
 
 #include "qemu/osdep.h"
 #include "qxl.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 static void qxl_blit(PCIQXLDevice *qxl, QXLRect *rect)
 {
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index a71714c..587dba5 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -28,7 +28,7 @@
 #include "qemu/atomic.h"
 #include "sysemu/sysemu.h"
 #include "migration/blocker.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #include "qxl.h"
 
diff --git a/hw/display/sii9022.c b/hw/display/sii9022.c
index eaf11a6..a95963a 100644
--- a/hw/display/sii9022.c
+++ b/hw/display/sii9022.c
@@ -17,7 +17,7 @@
 #include "qemu-common.h"
 #include "hw/i2c/i2c.h"
 #include "hw/i2c/i2c-ddc.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #define SII9022_SYS_CTRL_DATA 0x1a
 #define SII9022_SYS_CTRL_PWR_DWN 0x10
diff --git a/hw/display/vga.c b/hw/display/vga.c
index 7218133..2cb1c24 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -31,7 +31,7 @@
 #include "ui/pixel_ops.h"
 #include "qemu/timer.h"
 #include "hw/xen/xen.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 //#define DEBUG_VGA_MEM
 //#define DEBUG_VGA_REG
diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
index 3558f38..c97a85d 100644
--- a/hw/display/virtio-gpu-3d.c
+++ b/hw/display/virtio-gpu-3d.c
@@ -14,7 +14,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qemu/iov.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-gpu.h"
 
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 2dd3c34..b20d33d 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -15,7 +15,7 @@
 #include "qemu-common.h"
 #include "qemu/iov.h"
 #include "ui/console.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-gpu.h"
 #include "hw/virtio/virtio-bus.h"
diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index bd3e8b3..f33b0b6 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -25,7 +25,7 @@
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/loader.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "ui/vnc.h"
 #include "hw/pci/pci.h"
 
diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index f5afcc0..ad8e662 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -36,7 +36,7 @@
 #include <xen/io/kbdif.h>
 #include <xen/io/protocols.h>
 
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #ifndef BTN_LEFT
 #define BTN_LEFT 0x110 /* from <linux/input.h> */
diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index bd23e89..fd7c000 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -26,7 +26,7 @@
 #include "hw/isa/isa.h"
 #include "hw/isa/i8257.h"
 #include "qemu/main-loop.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #define I8257(obj) \
     OBJECT_CHECK(I8257State, (obj), TYPE_I8257)
diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
index 5d4833e..88d82a5 100644
--- a/hw/dma/rc4030.c
+++ b/hw/dma/rc4030.c
@@ -29,7 +29,7 @@
 #include "qemu/timer.h"
 #include "qemu/log.h"
 #include "exec/address-spaces.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 /********************************************************/
 /* rc4030 emulation                                     */
diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index 7b00a27..3073750 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -32,7 +32,7 @@
 #include "hw/sysbus.h"
 #include "sysemu/dma.h"
 #include "qapi/error.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 /*
  * This is the DMA controller part of chip STP2000 (Master I/O), also
diff --git a/hw/hppa/pci.c b/hw/hppa/pci.c
index 7664202..93630ad 100644
--- a/hw/hppa/pci.c
+++ b/hw/hppa/pci.c
@@ -8,7 +8,7 @@
 #include "hppa_sys.h"
 #include "qemu/log.h"
 #include "sysemu/sysemu.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 
 /* Fallback for unassigned PCI I/O operations.  Avoids MCHK.  */
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 63d46ff..bd769a7 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -26,7 +26,7 @@
 #include "amd_iommu.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 /* used AMD-Vi MMIO registers */
 const char *amdvi_mmio_low[] = {
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index fb31de9..11d5528 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -35,7 +35,7 @@
 #include "sysemu/kvm.h"
 #include "hw/i386/apic_internal.h"
 #include "kvm_i386.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 static void vtd_define_quad(IntelIOMMUState *s, hwaddr addr, uint64_t val,
                             uint64_t wmask, uint64_t w1cmask)
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 35fcb6e..1a24aae 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -67,7 +67,7 @@
 #include "acpi-build.h"
 #include "hw/mem/pc-dimm.h"
 #include "qapi/error.h"
-#include "qapi/qapi-visit-common.h"
+#include "qemu-build/qapi/qapi-visit-common.h"
 #include "qapi/visitor.h"
 #include "qom/cpu.h"
 #include "hw/nmi.h"
diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 116aa09..cc871e9 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -28,7 +28,7 @@
 #include "sysemu/hw_accel.h"
 #include "hw/qdev.h"
 #include "qemu/log.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #define VMPORT_CMD_GETVERSION 0x0a
 #define VMPORT_CMD_GETRAMSIZE 0x14
diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
index 8a01a2d..fd3f838 100644
--- a/hw/i386/x86-iommu.c
+++ b/hw/i386/x86-iommu.c
@@ -24,7 +24,7 @@
 #include "hw/i386/pc.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 void x86_iommu_iec_register_notifier(X86IOMMUState *iommu,
                                      iec_notify_fn fn, void *data)
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index f24b7d4..7c33390 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -17,11 +17,11 @@
 #include "hw/xen/xen_common.h"
 #include "hw/xen/xen_backend.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qemu-build/qapi/qapi-commands-misc.h"
 #include "qemu/error-report.h"
 #include "qemu/range.h"
 #include "sysemu/xen-mapcache.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "exec/address-spaces.h"
 
 #include <xen/hvm/ioreq.h>
diff --git a/hw/i386/xen/xen-mapcache.c b/hw/i386/xen/xen-mapcache.c
index efa35dc..fc9a2f2 100644
--- a/hw/i386/xen/xen-mapcache.c
+++ b/hw/i386/xen/xen-mapcache.c
@@ -20,7 +20,7 @@
 #include <xen/hvm/params.h>
 
 #include "sysemu/xen-mapcache.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 
 //#define MAPCACHE_DEBUG
diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
index deb7a0c..2996cfd 100644
--- a/hw/i386/xen/xen_platform.c
+++ b/hw/i386/xen/xen_platform.c
@@ -31,7 +31,7 @@
 #include "hw/irq.h"
 #include "hw/xen/xen_common.h"
 #include "hw/xen/xen_backend.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "exec/address-spaces.h"
 #include "sysemu/block-backend.h"
 #include "qemu/error-report.h"
diff --git a/hw/i386/xen/xen_pvdevice.c b/hw/i386/xen/xen_pvdevice.c
index f748823..49e1dfb 100644
--- a/hw/i386/xen/xen_pvdevice.c
+++ b/hw/i386/xen/xen_pvdevice.c
@@ -33,7 +33,7 @@
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #define TYPE_XEN_PV_DEVICE  "xen-pvdevice"
 
diff --git a/hw/ide/ahci-allwinner.c b/hw/ide/ahci-allwinner.c
index c3f1604..eefbe00 100644
--- a/hw/ide/ahci-allwinner.c
+++ b/hw/ide/ahci-allwinner.c
@@ -23,7 +23,7 @@
 #include "hw/ide/internal.h"
 #include "hw/ide/ahci_internal.h"
 
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #define ALLWINNER_AHCI_BISTAFR    ((0xa0 - ALLWINNER_AHCI_MMIO_OFF) / 4)
 #define ALLWINNER_AHCI_BISTCR     ((0xa4 - ALLWINNER_AHCI_MMIO_OFF) / 4)
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index e22d7be..5fea126 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -33,7 +33,7 @@
 #include "hw/ide/pci.h"
 #include "hw/ide/ahci_internal.h"
 
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 static void check_cmd(AHCIState *s, int port);
 static int handle_cmd(AHCIState *s, int port, uint8_t slot);
diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
index c0509c8..be6132a 100644
--- a/hw/ide/atapi.c
+++ b/hw/ide/atapi.c
@@ -27,7 +27,7 @@
 #include "hw/ide/internal.h"
 #include "hw/scsi/scsi.h"
 #include "sysemu/block-backend.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #define ATAPI_SECTOR_BITS (2 + BDRV_SECTOR_BITS)
 #define ATAPI_SECTOR_SIZE (1 << ATAPI_SECTOR_BITS)
diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index 65aff51..905c1b6 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -31,7 +31,7 @@
 #include "sysemu/dma.h"
 
 #include "hw/ide/pci.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 /* CMD646 specific */
 #define CFR		0x50
diff --git a/hw/ide/core.c b/hw/ide/core.c
index 139c843..aa82897 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -38,7 +38,7 @@
 #include "qemu/cutils.h"
 
 #include "hw/ide/internal.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 /* These values were based on a Seagate ST3500418AS but have been modified
    to make more sense in QEMU */
diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index 1ab0a89..38395ca 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -30,7 +30,7 @@
 #include "sysemu/dma.h"
 #include "qemu/error-report.h"
 #include "hw/ide/pci.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #define BMDMA_PAGE_SIZE 4096
 
diff --git a/hw/ide/piix.c b/hw/ide/piix.c
index a3afe1f..60763cf 100644
--- a/hw/ide/piix.c
+++ b/hw/ide/piix.c
@@ -33,7 +33,7 @@
 #include "sysemu/dma.h"
 
 #include "hw/ide/pci.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 static uint64_t bmdma_read(void *opaque, hwaddr addr, unsigned size)
 {
diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
index e3896c6..c676280 100644
--- a/hw/ide/sii3112.c
+++ b/hw/ide/sii3112.c
@@ -14,7 +14,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/ide/pci.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #define TYPE_SII3112_PCI "sii3112"
 #define SII3112_PCI(obj) OBJECT_CHECK(SiI3112PCIState, (obj), \
diff --git a/hw/ide/via.c b/hw/ide/via.c
index 117ac4d..c221964 100644
--- a/hw/ide/via.c
+++ b/hw/ide/via.c
@@ -32,7 +32,7 @@
 #include "sysemu/dma.h"
 
 #include "hw/ide/pci.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 static uint64_t bmdma_read(void *opaque, hwaddr addr,
                            unsigned size)
diff --git a/hw/input/adb-kbd.c b/hw/input/adb-kbd.c
index 50b6271..592b8d8 100644
--- a/hw/input/adb-kbd.c
+++ b/hw/input/adb-kbd.c
@@ -27,7 +27,7 @@
 #include "hw/input/adb-keys.h"
 #include "sysemu/sysemu.h"
 #include "adb-internal.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #define ADB_KEYBOARD(obj) OBJECT_CHECK(KBDState, (obj), TYPE_ADB_KEYBOARD)
 
diff --git a/hw/input/adb-mouse.c b/hw/input/adb-mouse.c
index 3ba6027..9db65df 100644
--- a/hw/input/adb-mouse.c
+++ b/hw/input/adb-mouse.c
@@ -25,7 +25,7 @@
 #include "ui/console.h"
 #include "hw/input/adb.h"
 #include "adb-internal.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #define ADB_MOUSE(obj) OBJECT_CHECK(MouseState, (obj), TYPE_ADB_MOUSE)
 
diff --git a/hw/input/hid.c b/hw/input/hid.c
index aa4fb82..6be9b70 100644
--- a/hw/input/hid.c
+++ b/hw/input/hid.c
@@ -27,7 +27,7 @@
 #include "ui/console.h"
 #include "qemu/timer.h"
 #include "hw/input/hid.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #define HID_USAGE_ERROR_ROLLOVER        0x01
 #define HID_USAGE_POSTFAIL              0x02
diff --git a/hw/input/milkymist-softusb.c b/hw/input/milkymist-softusb.c
index ef8f47c..0a336d6 100644
--- a/hw/input/milkymist-softusb.c
+++ b/hw/input/milkymist-softusb.c
@@ -25,7 +25,7 @@
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "ui/console.h"
 #include "hw/input/hid.h"
 #include "qemu/error-report.h"
diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 06f5d2a..0fc84a3 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -29,7 +29,7 @@
 #include "ui/input.h"
 #include "sysemu/sysemu.h"
 
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 /* debug PC keyboard */
 //#define DEBUG_KBD
diff --git a/hw/input/virtio-input.c b/hw/input/virtio-input.c
index 0e42f0d..9a84052 100644
--- a/hw/input/virtio-input.c
+++ b/hw/input/virtio-input.c
@@ -7,7 +7,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/iov.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #include "hw/qdev.h"
 #include "hw/virtio/virtio.h"
diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index 6fda52b..b90eed7 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -25,7 +25,7 @@
 #include "hw/i386/ioapic.h"
 #include "hw/pci/msi.h"
 #include "qemu/host-utils.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "hw/i386/pc.h"
 #include "hw/i386/apic-msidef.h"
 #include "qapi/error.h"
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 78903ea..5280702 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -25,7 +25,7 @@
 #include "qapi/visitor.h"
 #include "hw/i386/apic.h"
 #include "hw/i386/apic_internal.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "sysemu/hax.h"
 #include "sysemu/kvm.h"
 #include "hw/qdev.h"
diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index ea0323f..594bc51 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -24,7 +24,7 @@
 #include "qapi/error.h"
 #include "qom/cpu.h"
 #include "qemu/log.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "sysemu/kvm.h"
 
 /* #define DEBUG_GIC */
diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 5cbafaf..bda5b7e 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -15,7 +15,7 @@
 #include "qemu/osdep.h"
 #include "qemu/bitops.h"
 #include "qemu/main-loop.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "gicv3_internal.h"
 #include "cpu.h"
 
diff --git a/hw/intc/arm_gicv3_dist.c b/hw/intc/arm_gicv3_dist.c
index 93fe936..9fc83b5 100644
--- a/hw/intc/arm_gicv3_dist.c
+++ b/hw/intc/arm_gicv3_dist.c
@@ -11,7 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "gicv3_internal.h"
 
 /* The GICD_NSACR registers contain a two bit field for each interrupt which
diff --git a/hw/intc/arm_gicv3_redist.c b/hw/intc/arm_gicv3_redist.c
index 8a8684d..8381f05 100644
--- a/hw/intc/arm_gicv3_redist.c
+++ b/hw/intc/arm_gicv3_redist.c
@@ -11,7 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "gicv3_internal.h"
 
 static uint32_t mask_group(GICv3CPUState *cs, MemTxAttrs attrs)
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index c51151f..6ad4888 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -21,7 +21,7 @@
 #include "target/arm/cpu.h"
 #include "exec/exec-all.h"
 #include "qemu/log.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 /* IRQ number counting:
  *
diff --git a/hw/intc/aspeed_vic.c b/hw/intc/aspeed_vic.c
index 2370e74..6634d0a 100644
--- a/hw/intc/aspeed_vic.c
+++ b/hw/intc/aspeed_vic.c
@@ -31,7 +31,7 @@
 #include "hw/intc/aspeed_vic.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #define AVIC_NEW_BASE_OFFSET 0x80
 
diff --git a/hw/intc/grlib_irqmp.c b/hw/intc/grlib_irqmp.c
index d6f9cb3..89547f2 100644
--- a/hw/intc/grlib_irqmp.c
+++ b/hw/intc/grlib_irqmp.c
@@ -30,7 +30,7 @@
 
 #include "hw/sparc/grlib.h"
 
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qapi/error.h"
 
 #define IRQMP_MAX_CPU 16
diff --git a/hw/intc/heathrow_pic.c b/hw/intc/heathrow_pic.c
index 393fdd7..a47f0e5 100644
--- a/hw/intc/heathrow_pic.c
+++ b/hw/intc/heathrow_pic.c
@@ -26,7 +26,7 @@
 #include "hw/hw.h"
 #include "hw/ppc/mac.h"
 #include "hw/intc/heathrow_pic.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 static inline int heathrow_check_irq(HeathrowPICState *pic)
 {
diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 76f3d87..706516f 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -28,7 +28,7 @@
 #include "qemu/timer.h"
 #include "qemu/log.h"
 #include "hw/isa/i8259_internal.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 /* debug PIC */
 //#define DEBUG_PIC
diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 36139a4..3c8cfe5 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -33,7 +33,7 @@
 #include "target/i386/cpu.h"
 #include "hw/i386/apic-msidef.h"
 #include "hw/i386/x86-iommu.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #define APIC_DELIVERY_MODE_SHIFT 8
 #define APIC_POLARITY_SHIFT 14
diff --git a/hw/intc/lm32_pic.c b/hw/intc/lm32_pic.c
index db6c7af..097968f 100644
--- a/hw/intc/lm32_pic.c
+++ b/hw/intc/lm32_pic.c
@@ -22,7 +22,7 @@
 #include "hw/hw.h"
 #include "monitor/monitor.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "hw/lm32/lm32_pic.h"
 #include "hw/intc/intc.h"
 
diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index 5f8168f..2b2ac6e 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -16,7 +16,7 @@
 #include "hw/s390x/ioinst.h"
 #include "hw/s390x/s390_flic.h"
 #include "hw/s390x/css.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "cpu.h"
 #include "hw/qdev.h"
 #include "qapi/error.h"
diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index 3f804ad..9852477 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -22,7 +22,7 @@
 #include "hw/s390x/s390_flic.h"
 #include "hw/s390x/adapter.h"
 #include "hw/s390x/css.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #define FLIC_SAVE_INITIAL_SIZE getpagesize()
 #define FLIC_FAILED (-1UL)
diff --git a/hw/intc/slavio_intctl.c b/hw/intc/slavio_intctl.c
index 817e026..2351801 100644
--- a/hw/intc/slavio_intctl.c
+++ b/hw/intc/slavio_intctl.c
@@ -26,7 +26,7 @@
 #include "monitor/monitor.h"
 #include "hw/sysbus.h"
 #include "hw/intc/intc.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 //#define DEBUG_IRQ_COUNT
 
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index e73e623..700d591 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -30,7 +30,7 @@
 #include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qemu/timer.h"
 #include "hw/ppc/xics.h"
 #include "qemu/error-report.h"
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 89fb20e..74a684e 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -30,7 +30,7 @@
 #include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "sysemu/kvm.h"
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/xics.h"
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index 2e27b92..93a0c3e 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -28,7 +28,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "hw/hw.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qemu/timer.h"
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/xics.h"
diff --git a/hw/ipmi/ipmi.c b/hw/ipmi/ipmi.c
index 9be281f..6edf78f 100644
--- a/hw/ipmi/ipmi.c
+++ b/hw/ipmi/ipmi.c
@@ -28,7 +28,7 @@
 #include "sysemu/sysemu.h"
 #include "qom/object_interfaces.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qemu-build/qapi/qapi-commands-misc.h"
 #include "qapi/visitor.h"
 
 static uint32_t ipmi_current_uuid = 1;
diff --git a/hw/isa/pc87312.c b/hw/isa/pc87312.c
index 48b29e3..bf8a125 100644
--- a/hw/isa/pc87312.c
+++ b/hw/isa/pc87312.c
@@ -31,7 +31,7 @@
 #include "sysemu/blockdev.h"
 #include "sysemu/sysemu.h"
 #include "chardev/char.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 
 #define REG_FER 0
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 51350d9..a94788b 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -27,7 +27,7 @@
 #include "qemu/range.h"
 #include "sysemu/numa.h"
 #include "sysemu/kvm.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "hw/virtio/vhost.h"
 
 typedef struct pc_dimms_capacity {
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 5e6d574..c725e6c 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -16,7 +16,7 @@
 #include "qapi/visitor.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #define TO_REG(offset) ((offset) >> 2)
 
diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index 0df008e..07a2b05 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -14,7 +14,7 @@
 #include "hw/misc/aspeed_scu.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 /* Protection Key Register */
 #define R_PROT            (0x00 / 4)
diff --git a/hw/misc/eccmemctl.c b/hw/misc/eccmemctl.c
index bb7cc52..c088a0e 100644
--- a/hw/misc/eccmemctl.c
+++ b/hw/misc/eccmemctl.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 /* There are 3 versions of this chip used in SMP sun4m systems:
  * MCC (version 0, implementation 0) SS-600MP
diff --git a/hw/misc/imx7_gpr.c b/hw/misc/imx7_gpr.c
index c2a9df2..327cf87 100644
--- a/hw/misc/imx7_gpr.c
+++ b/hw/misc/imx7_gpr.c
@@ -17,7 +17,7 @@
 #include "qemu/log.h"
 #include "sysemu/sysemu.h"
 
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 enum IMX7GPRRegisters {
     IOMUXC_GPR0  = 0x00,
diff --git a/hw/misc/iotkit-secctl.c b/hw/misc/iotkit-secctl.c
index ddd1584..f30ed6c 100644
--- a/hw/misc/iotkit-secctl.c
+++ b/hw/misc/iotkit-secctl.c
@@ -12,7 +12,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qapi/error.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "hw/sysbus.h"
 #include "hw/registerfields.h"
 #include "hw/misc/iotkit-secctl.h"
diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index bd9b862..5429f9f 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -32,7 +32,7 @@
 #include "sysemu/sysemu.h"
 #include "qemu/cutils.h"
 #include "qemu/log.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 /* Bits in B data register: all active low */
 #define TREQ            0x08    /* Transfer request (input) */
diff --git a/hw/misc/milkymist-hpdmc.c b/hw/misc/milkymist-hpdmc.c
index e6140ee..49f0ceb 100644
--- a/hw/misc/milkymist-hpdmc.c
+++ b/hw/misc/milkymist-hpdmc.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qemu/error-report.h"
 
 enum {
diff --git a/hw/misc/milkymist-pfpu.c b/hw/misc/milkymist-pfpu.c
index 86f5e38..b98f292 100644
--- a/hw/misc/milkymist-pfpu.c
+++ b/hw/misc/milkymist-pfpu.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include <math.h>
diff --git a/hw/misc/mmio_interface.c b/hw/misc/mmio_interface.c
index 3b0e203..27046da 100644
--- a/hw/misc/mmio_interface.c
+++ b/hw/misc/mmio_interface.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "hw/qdev-properties.h"
 #include "hw/misc/mmio_interface.h"
 #include "qapi/error.h"
diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
index 8ad9fc8..7160aaa 100644
--- a/hw/misc/mos6522.c
+++ b/hw/misc/mos6522.c
@@ -31,7 +31,7 @@
 #include "sysemu/sysemu.h"
 #include "qemu/cutils.h"
 #include "qemu/log.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 /* XXX: implement all timer modes */
 
diff --git a/hw/misc/mps2-fpgaio.c b/hw/misc/mps2-fpgaio.c
index 7394a05..205f3fa 100644
--- a/hw/misc/mps2-fpgaio.c
+++ b/hw/misc/mps2-fpgaio.c
@@ -18,7 +18,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qapi/error.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "hw/sysbus.h"
 #include "hw/registerfields.h"
 #include "hw/misc/mps2-fpgaio.h"
diff --git a/hw/misc/mps2-scc.c b/hw/misc/mps2-scc.c
index 6a9d251..70a22eb 100644
--- a/hw/misc/mps2-scc.c
+++ b/hw/misc/mps2-scc.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "hw/sysbus.h"
 #include "hw/registerfields.h"
 #include "hw/misc/mps2-scc.h"
diff --git a/hw/misc/msf2-sysreg.c b/hw/misc/msf2-sysreg.c
index 6eb5011..a132b2b 100644
--- a/hw/misc/msf2-sysreg.c
+++ b/hw/misc/msf2-sysreg.c
@@ -17,7 +17,7 @@
 #include "qemu/log.h"
 #include "hw/misc/msf2-sysreg.h"
 #include "qemu/error-report.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 static inline int msf2_divbits(uint32_t div)
 {
diff --git a/hw/misc/slavio_misc.c b/hw/misc/slavio_misc.c
index 0b33cdc..ba8fc73 100644
--- a/hw/misc/slavio_misc.c
+++ b/hw/misc/slavio_misc.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "sysemu/sysemu.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 /*
  * This is the auxio port, chip control and system control part of
diff --git a/hw/misc/tz-ppc.c b/hw/misc/tz-ppc.c
index 3dd045c..d30056f 100644
--- a/hw/misc/tz-ppc.c
+++ b/hw/misc/tz-ppc.c
@@ -12,7 +12,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qapi/error.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "hw/sysbus.h"
 #include "hw/registerfields.h"
 #include "hw/misc/tz-ppc.h"
diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index 16a9417..1c81235 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -46,7 +46,7 @@
 #include "e1000x_common.h"
 #include "e1000e_core.h"
 
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qapi/error.h"
 
 #define TYPE_E1000E "e1000e"
diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index c93c466..ed45329 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -46,7 +46,7 @@
 #include "e1000x_common.h"
 #include "e1000e_core.h"
 
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #define E1000E_MIN_XITR     (500) /* No more then 7813 interrupts per
                                      second according to spec 10.2.4.2 */
diff --git a/hw/net/e1000x_common.c b/hw/net/e1000x_common.c
index eb0e097..2944294 100644
--- a/hw/net/e1000x_common.c
+++ b/hw/net/e1000x_common.c
@@ -29,7 +29,7 @@
 
 #include "e1000x_common.h"
 
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 bool e1000x_rx_ready(PCIDevice *d, uint32_t *mac)
 {
diff --git a/hw/net/lance.c b/hw/net/lance.c
index a08d5ac..af54c34 100644
--- a/hw/net/lance.c
+++ b/hw/net/lance.c
@@ -39,7 +39,7 @@
 #include "qemu/timer.h"
 #include "hw/sparc/sparc32_dma.h"
 #include "hw/net/lance.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "sysemu/sysemu.h"
 
 
diff --git a/hw/net/milkymist-minimac2.c b/hw/net/milkymist-minimac2.c
index 3eaa19d..63ee005 100644
--- a/hw/net/milkymist-minimac2.c
+++ b/hw/net/milkymist-minimac2.c
@@ -28,7 +28,7 @@
 #include "cpu.h" /* FIXME: why does this use TARGET_PAGE_ALIGN? */
 #include "hw/hw.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "net/net.h"
 #include "qemu/error-report.h"
 
diff --git a/hw/net/mipsnet.c b/hw/net/mipsnet.c
index 5a63df7..ab1cc50 100644
--- a/hw/net/mipsnet.c
+++ b/hw/net/mipsnet.c
@@ -1,7 +1,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "net/net.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "hw/sysbus.h"
 
 /* MIPSnet register offsets */
diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
index 98a5030..273f978 100644
--- a/hw/net/net_rx_pkt.c
+++ b/hw/net/net_rx_pkt.c
@@ -16,7 +16,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "net_rx_pkt.h"
 #include "net/checksum.h"
 #include "net/tap.h"
diff --git a/hw/net/opencores_eth.c b/hw/net/opencores_eth.c
index d42b79c..9a4e874 100644
--- a/hw/net/opencores_eth.c
+++ b/hw/net/opencores_eth.c
@@ -38,7 +38,7 @@
 #include "net/net.h"
 #include "net/eth.h"
 #include "sysemu/sysemu.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 /* RECSMALL is not used because it breaks tap networking in linux:
  * incoming ARP responses are too short
diff --git a/hw/net/pcnet-pci.c b/hw/net/pcnet-pci.c
index 70dc8b3..feb1cd7 100644
--- a/hw/net/pcnet-pci.c
+++ b/hw/net/pcnet-pci.c
@@ -33,7 +33,7 @@
 #include "qemu/timer.h"
 #include "sysemu/dma.h"
 #include "sysemu/sysemu.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #include "pcnet.h"
 
diff --git a/hw/net/pcnet.c b/hw/net/pcnet.c
index 0c44554..9848a74 100644
--- a/hw/net/pcnet.c
+++ b/hw/net/pcnet.c
@@ -41,7 +41,7 @@
 #include "net/eth.h"
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #include "pcnet.h"
 
diff --git a/hw/net/rocker/qmp-norocker.c b/hw/net/rocker/qmp-norocker.c
index 0d60513..4e5674d 100644
--- a/hw/net/rocker/qmp-norocker.c
+++ b/hw/net/rocker/qmp-norocker.c
@@ -18,7 +18,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-rocker.h"
+#include "qemu-build/qapi/qapi-commands-rocker.h"
 #include "qapi/qmp/qerror.h"
 
 RockerSwitch *qmp_query_rocker(const char *name, Error **errp)
diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index c02cbef..2118fba 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -22,7 +22,7 @@
 #include "net/net.h"
 #include "net/eth.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-rocker.h"
+#include "qemu-build/qapi/qapi-commands-rocker.h"
 #include "qemu/iov.h"
 #include "qemu/bitops.h"
 
diff --git a/hw/net/rocker/rocker_fp.c b/hw/net/rocker/rocker_fp.c
index 27b17c8..97d2cba 100644
--- a/hw/net/rocker/rocker_fp.c
+++ b/hw/net/rocker/rocker_fp.c
@@ -16,7 +16,7 @@
 
 #include "qemu/osdep.h"
 #include "net/clients.h"
-#include "qapi/qapi-types-rocker.h"
+#include "qemu-build/qapi/qapi-types-rocker.h"
 #include "rocker.h"
 #include "rocker_hw.h"
 #include "rocker_fp.h"
diff --git a/hw/net/rocker/rocker_of_dpa.c b/hw/net/rocker/rocker_of_dpa.c
index 6004672..223705f 100644
--- a/hw/net/rocker/rocker_of_dpa.c
+++ b/hw/net/rocker/rocker_of_dpa.c
@@ -17,7 +17,7 @@
 #include "qemu/osdep.h"
 #include "net/eth.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-rocker.h"
+#include "qemu-build/qapi/qapi-commands-rocker.h"
 #include "qemu/iov.h"
 #include "qemu/timer.h"
 
diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
index d239e4b..71aff77 100644
--- a/hw/net/spapr_llan.c
+++ b/hw/net/spapr_llan.c
@@ -34,7 +34,7 @@
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_vio.h"
 #include "sysemu/sysemu.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #include <libfdt.h>
 
diff --git a/hw/net/sungem.c b/hw/net/sungem.c
index 60f1e47..7a1a50b 100644
--- a/hw/net/sungem.c
+++ b/hw/net/sungem.c
@@ -15,7 +15,7 @@
 #include "net/checksum.h"
 #include "hw/net/mii.h"
 #include "sysemu/sysemu.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #define TYPE_SUNGEM "sungem"
 
diff --git a/hw/net/sunhme.c b/hw/net/sunhme.c
index 7558fca..7b8cb28 100644
--- a/hw/net/sunhme.c
+++ b/hw/net/sunhme.c
@@ -30,7 +30,7 @@
 #include "net/checksum.h"
 #include "net/eth.h"
 #include "sysemu/sysemu.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #define HME_REG_SIZE                   0x8000
 
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 67ad38c..ec6a6ab 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -23,7 +23,7 @@
 #include "net/vhost_net.h"
 #include "hw/virtio/virtio-bus.h"
 #include "qapi/error.h"
-#include "qapi/qapi-events-net.h"
+#include "qemu-build/qapi/qapi-events-net.h"
 #include "hw/virtio/virtio-access.h"
 #include "migration/misc.h"
 #include "standard-headers/linux/ethtool.h"
diff --git a/hw/nvram/ds1225y.c b/hw/nvram/ds1225y.c
index ad7345f..ab876ff 100644
--- a/hw/nvram/ds1225y.c
+++ b/hw/nvram/ds1225y.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 typedef struct {
     MemoryRegion iomem;
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 2a0739d..acbb338 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -30,7 +30,7 @@
 #include "hw/isa/isa.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
index 033588b..13025af 100644
--- a/hw/pci-host/grackle.c
+++ b/hw/pci-host/grackle.c
@@ -27,7 +27,7 @@
 #include "hw/pci/pci_host.h"
 #include "hw/ppc/mac.h"
 #include "hw/pci/pci.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #define GRACKLE_PCI_HOST_BRIDGE(obj) \
     OBJECT_CHECK(GrackleState, (obj), TYPE_GRACKLE_PCI_HOST_BRIDGE)
diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index e2f4ee4..6d5c111 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -35,7 +35,7 @@
 #include "sysemu/sysemu.h"
 #include "exec/address-spaces.h"
 #include "qemu/log.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 /*
  * Chipset docs:
diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index 66991da..cd9c4aa 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -26,7 +26,7 @@
 #include "hw/ppc/mac.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 static const int unin_irq_line[] = { 0x1b, 0x1c, 0x1d, 0x1e };
 
diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index c944c02..8c71d65 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -22,7 +22,7 @@
 #include "hw/xen/xen.h"
 #include "qemu/range.h"
 #include "qapi/error.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #define MSIX_CAP_LENGTH 12
 
diff --git a/hw/pci/pci-stub.c b/hw/pci/pci-stub.c
index b941a0e..07aaec0 100644
--- a/hw/pci/pci-stub.c
+++ b/hw/pci/pci-stub.c
@@ -22,7 +22,7 @@
 #include "sysemu/sysemu.h"
 #include "monitor/monitor.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qemu-build/qapi/qapi-commands-misc.h"
 #include "qapi/qmp/qerror.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/msi.h"
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index f98efdc..55c7dc5 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -34,14 +34,14 @@
 #include "hw/loader.h"
 #include "qemu/error-report.h"
 #include "qemu/range.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "exec/address-spaces.h"
 #include "hw/hotplug.h"
 #include "hw/boards.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qemu-build/qapi/qapi-commands-misc.h"
 #include "qemu/cutils.h"
 
 //#define DEBUG_PCI
diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index 5eaa935..0d89437 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -22,7 +22,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
 #include "hw/pci/pci_bus.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 /* debug PCI */
 //#define DEBUG_PCI
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index a749e25..83256df 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -73,7 +73,7 @@
 #include "exec/address-spaces.h"
 #include "hw/sysbus.h"
 #include "qemu/cutils.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #define MAX_IDE_BUS 2
 #define CFG_ADDR 0xf0000510
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index ec4be25..c588e44 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -36,7 +36,7 @@
 #include "hw/loader.h"
 #include "sysemu/kvm.h"
 #include "kvm_ppc.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 //#define PPC_DEBUG_IRQ
 //#define PPC_DEBUG_TB
diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
index ab2626a..9a41d7e 100644
--- a/hw/ppc/ppc440_pcix.c
+++ b/hw/ppc/ppc440_pcix.c
@@ -27,7 +27,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
 #include "exec/address-spaces.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 struct PLBOutMap {
     uint64_t la;
diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
index b7642ba..a33cfba 100644
--- a/hw/ppc/ppc4xx_pci.c
+++ b/hw/ppc/ppc4xx_pci.c
@@ -26,7 +26,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
 #include "exec/address-spaces.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 struct PCIMasterMap {
     uint32_t la;
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 096d4d4..cf339fd 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -48,7 +48,7 @@
 #include "sysemu/kvm.h"
 #include "sysemu/qtest.h"
 #include "exec/address-spaces.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "elf.h"
 #include "qemu/cutils.h"
 #include "kvm_ppc.h"
diff --git a/hw/ppc/prep_systemio.c b/hw/ppc/prep_systemio.c
index 50893ec..30844e3 100644
--- a/hw/ppc/prep_systemio.c
+++ b/hw/ppc/prep_systemio.c
@@ -28,7 +28,7 @@
 #include "qemu/error-report.h" /* for error_report() */
 #include "sysemu/sysemu.h" /* for vm_stop() */
 #include "cpu.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #define TYPE_PREP_SYSTEMIO "prep-systemio"
 #define PREP_SYSTEMIO(obj) \
diff --git a/hw/ppc/rs6000_mc.c b/hw/ppc/rs6000_mc.c
index b613565..874a453 100644
--- a/hw/ppc/rs6000_mc.c
+++ b/hw/ppc/rs6000_mc.c
@@ -22,7 +22,7 @@
 #include "exec/address-spaces.h"
 #include "hw/boards.h"
 #include "qapi/error.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #define TYPE_RS6000MC "rs6000-mc"
 #define RS6000MC_DEVICE(obj) \
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 44a0670..febe680 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -67,7 +67,7 @@
 #include "hw/usb.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "hw/nmi.h"
 #include "hw/intc/intc.h"
 
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index aa25113..7349e89 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -22,7 +22,7 @@
 #include "qemu/error-report.h"
 #include "hw/ppc/spapr.h" /* for RTAS return codes */
 #include "hw/pci-host/spapr.h" /* spapr_phb_remove_pci_device_cb callback */
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #define DRC_CONTAINER_PATH "/dr-connector"
 #define DRC_INDEX_TYPE_SHIFT 28
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 16bccdd..a072daa 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -10,7 +10,7 @@
 #include "hw/ppc/spapr.h"
 #include "mmu-hash64.h"
 #include "cpu-models.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "kvm_ppc.h"
 #include "hw/ppc/spapr_ovec.h"
 #include "mmu-book3s-v3.h"
diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index aaa6010..4afcd0f 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -25,7 +25,7 @@
 #include "kvm_ppc.h"
 #include "sysemu/dma.h"
 #include "exec/address-spaces.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_vio.h"
diff --git a/hw/ppc/spapr_ovec.c b/hw/ppc/spapr_ovec.c
index 41df4c3..44332d1 100644
--- a/hw/ppc/spapr_ovec.c
+++ b/hw/ppc/spapr_ovec.c
@@ -16,7 +16,7 @@
 #include "qemu/bitmap.h"
 #include "exec/address-spaces.h"
 #include "qemu/error-report.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include <libfdt.h>
 
 #define OV_MAXBYTES 256 /* not including length byte */
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 39a1498..eef7732 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -37,7 +37,7 @@
 #include "exec/address-spaces.h"
 #include "exec/ram_addr.h"
 #include <libfdt.h>
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qemu/error-report.h"
 #include "qapi/qmp/qerror.h"
 #include "hw/ppc/fdt.h"
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 0ec5fa4..153e623 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -43,7 +43,7 @@
 #include <libfdt.h>
 #include "hw/ppc/spapr_drc.h"
 #include "qemu/cutils.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "hw/ppc/fdt.h"
 
 static void rtas_display_character(PowerPCCPU *cpu, sPAPRMachineState *spapr,
diff --git a/hw/ppc/spapr_rtas_ddw.c b/hw/ppc/spapr_rtas_ddw.c
index 177dcff..3368a3a 100644
--- a/hw/ppc/spapr_rtas_ddw.c
+++ b/hw/ppc/spapr_rtas_ddw.c
@@ -22,7 +22,7 @@
 #include "qemu/error-report.h"
 #include "hw/ppc/spapr.h"
 #include "hw/pci-host/spapr.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 static int spapr_phb_get_active_win_num_cb(Object *child, void *opaque)
 {
diff --git a/hw/ppc/spapr_rtc.c b/hw/ppc/spapr_rtc.c
index a373605..17fbd55 100644
--- a/hw/ppc/spapr_rtc.c
+++ b/hw/ppc/spapr_rtc.c
@@ -31,7 +31,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/ppc/spapr.h"
 #include "qapi/error.h"
-#include "qapi/qapi-events-misc.h"
+#include "qemu-build/qapi/qapi-events-misc.h"
 #include "qemu/cutils.h"
 
 void spapr_rtc_read(sPAPRRTCState *rtc, struct tm *tm, uint32_t *ns)
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index 472dd6f..169f5ac 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -37,7 +37,7 @@
 #include "hw/ppc/spapr_vio.h"
 #include "hw/ppc/xics.h"
 #include "hw/ppc/fdt.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #include <libfdt.h>
 
diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index f85c7b2..d453e73 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -19,7 +19,7 @@
 
 #include <infiniband/verbs.h>
 
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "rdma_utils.h"
 #include "rdma_rm.h"
 #include "rdma_backend.h"
diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index 25ea02a..5df0794 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -23,7 +23,7 @@
 #include "hw/qdev-core.h"
 #include "hw/qdev-properties.h"
 #include "cpu.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #include "../rdma_rm.h"
 #include "../rdma_backend.h"
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 301bf17..e971175 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -19,7 +19,7 @@
 #include "cpu.h"
 #include "hw/s390x/ioinst.h"
 #include "hw/s390x/css.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "hw/s390x/s390_flic.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index 76241c2..5f779d2 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -13,7 +13,7 @@
 #include "hw/boards.h"
 #include "hw/s390x/storage-keys.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qemu-build/qapi/qapi-commands-misc.h"
 #include "qapi/qmp/qdict.h"
 #include "qemu/error-report.h"
 #include "sysemu/kvm.h"
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index e51fbef..90b1775 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -32,7 +32,7 @@
 #include "hw/s390x/ioinst.h"
 #include "hw/s390x/css.h"
 #include "virtio-ccw.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "hw/s390x/css-bridge.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 
diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
index 419fc66..b81a1ec 100644
--- a/hw/scsi/esp-pci.c
+++ b/hw/scsi/esp-pci.c
@@ -27,7 +27,7 @@
 #include "hw/pci/pci.h"
 #include "hw/nvram/eeprom93xx.h"
 #include "hw/scsi/esp.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
 
diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 45975c2..1c6e588 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -26,7 +26,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "hw/scsi/esp.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qemu/log.h"
 
 /*
diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index ba1afa3..1df3ada 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -28,7 +28,7 @@
 #include "qemu/iov.h"
 #include "hw/scsi/scsi.h"
 #include "scsi/constants.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qapi/error.h"
 #include "mfi.h"
 
diff --git a/hw/scsi/mptconfig.c b/hw/scsi/mptconfig.c
index 87a416a..6e1899f 100644
--- a/hw/scsi/mptconfig.c
+++ b/hw/scsi/mptconfig.c
@@ -22,7 +22,7 @@
 
 #include "mptsas.h"
 #include "mpi.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 /* Generic functions for marshaling and unmarshaling.  */
 
diff --git a/hw/scsi/mptendian.c b/hw/scsi/mptendian.c
index 3415229..ea72f0d 100644
--- a/hw/scsi/mptendian.c
+++ b/hw/scsi/mptendian.c
@@ -29,7 +29,7 @@
 #include "qemu/iov.h"
 #include "hw/scsi/scsi.h"
 #include "scsi/constants.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #include "mptsas.h"
 #include "mpi.h"
diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index 3f061f3..ff8cdaa 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -31,7 +31,7 @@
 #include "qemu/iov.h"
 #include "hw/scsi/scsi.h"
 #include "scsi/constants.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qapi/error.h"
 #include "mptsas.h"
 #include "mpi.h"
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 1eaeffc..735f2d1 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -8,7 +8,7 @@
 #include "hw/qdev.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "sysemu/dma.h"
 #include "qemu/cutils.h"
 
diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index a9e49c7..274fefb 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -42,7 +42,7 @@
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_vio.h"
 #include "viosrp.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #include <libfdt.h>
 
diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index a3a019e..1e3e595 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -31,7 +31,7 @@
 #include "scsi/constants.h"
 #include "hw/pci/msi.h"
 #include "vmw_pvscsi.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 
 #define PVSCSI_USE_64BIT         (true)
diff --git a/hw/sd/core.c b/hw/sd/core.c
index 3c6eae6..ecd2077 100644
--- a/hw/sd/core.c
+++ b/hw/sd/core.c
@@ -23,7 +23,7 @@
 #include "hw/qdev-core.h"
 #include "sysemu/block-backend.h"
 #include "hw/sd/sd.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 static inline const char *sdbus_name(SDBus *sdbus)
 {
diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
index 5570c1e..02a3a52 100644
--- a/hw/sd/milkymist-memcard.c
+++ b/hw/sd/milkymist-memcard.c
@@ -26,7 +26,7 @@
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "sysemu/sysemu.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "include/qapi/error.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmci.c
index 82f8ec0..2325977 100644
--- a/hw/sd/pxa2xx_mmci.c
+++ b/hw/sd/pxa2xx_mmci.c
@@ -20,7 +20,7 @@
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #define TYPE_PXA2XX_MMCI "pxa2xx-mmci"
 #define PXA2XX_MMCI(obj) OBJECT_CHECK(PXA2xxMMCIState, (obj), TYPE_PXA2XX_MMCI)
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 235e051..e09d161 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -43,7 +43,7 @@
 #include "qemu/timer.h"
 #include "qemu/log.h"
 #include "sdmmc-internal.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 //#define DEBUG_SD 1
 
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 1b828b1..d655a99 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -35,7 +35,7 @@
 #include "sdhci-internal.h"
 #include "qemu/log.h"
 #include "qemu/cutils.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #define TYPE_SDHCI_BUS "sdhci-bus"
 #define SDHCI_BUS(obj) OBJECT_CHECK(SDBus, (obj), TYPE_SDHCI_BUS)
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index bba3aa3..79e0736 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -34,7 +34,7 @@
 #include "hw/boards.h"
 #include "hw/loader.h"
 #include "elf.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "exec/address-spaces.h"
 
 #include "hw/sparc/grlib.h"
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 0f5804b..779c7e5 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -45,7 +45,7 @@
 #include "hw/loader.h"
 #include "elf.h"
 #include "sysemu/block-backend.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qemu/cutils.h"
 
 /*
diff --git a/hw/sparc/sun4m_iommu.c b/hw/sparc/sun4m_iommu.c
index b677601..0be884c 100644
--- a/hw/sparc/sun4m_iommu.c
+++ b/hw/sparc/sun4m_iommu.c
@@ -26,7 +26,7 @@
 #include "hw/sparc/sun4m_iommu.h"
 #include "hw/sysbus.h"
 #include "exec/address-spaces.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 /*
  * I/O MMU used by Sun4m systems
diff --git a/hw/sparc64/sparc64.c b/hw/sparc64/sparc64.c
index 4083889..64f2872 100644
--- a/hw/sparc64/sparc64.c
+++ b/hw/sparc64/sparc64.c
@@ -28,7 +28,7 @@
 #include "hw/char/serial.h"
 #include "hw/sparc/sparc64.h"
 #include "qemu/timer.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 
 #define TICK_MAX             0x7fffffffffffffffULL
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index da28ab9..0571111 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -49,7 +49,7 @@
 #include "hw/ide/pci.h"
 #include "hw/loader.h"
 #include "elf.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qemu/cutils.h"
 
 #define KERNEL_LOAD_ADDR     0x00404000
diff --git a/hw/sparc64/sun4u_iommu.c b/hw/sparc64/sun4u_iommu.c
index eb3aaa8..2b5c813 100644
--- a/hw/sparc64/sun4u_iommu.c
+++ b/hw/sparc64/sun4u_iommu.c
@@ -29,7 +29,7 @@
 #include "hw/sparc/sun4u_iommu.h"
 #include "exec/address-spaces.h"
 #include "qemu/log.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 
 #define IOMMU_PAGE_SIZE_8K      (1ULL << 13)
diff --git a/hw/timer/armv7m_systick.c b/hw/timer/armv7m_systick.c
index df8d280..b3da9ed 100644
--- a/hw/timer/armv7m_systick.c
+++ b/hw/timer/armv7m_systick.c
@@ -15,7 +15,7 @@
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
 #include "qemu/log.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 /* qemu timers run at 1GHz.   We want something closer to 1MHz.  */
 #define SYSTICK_SCALE 1000ULL
diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index 50acbf5..a655d59 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -16,7 +16,7 @@
 #include "qemu/bitops.h"
 #include "qemu/timer.h"
 #include "qemu/log.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #define TIMER_NR_REGS 4
 
diff --git a/hw/timer/cmsdk-apb-timer.c b/hw/timer/cmsdk-apb-timer.c
index 9878746..927325d 100644
--- a/hw/timer/cmsdk-apb-timer.c
+++ b/hw/timer/cmsdk-apb-timer.c
@@ -31,7 +31,7 @@
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "qapi/error.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "hw/sysbus.h"
 #include "hw/registerfields.h"
 #include "hw/timer/cmsdk-apb-timer.h"
diff --git a/hw/timer/grlib_gptimer.c b/hw/timer/grlib_gptimer.c
index 4ed96e9..85cc77e 100644
--- a/hw/timer/grlib_gptimer.c
+++ b/hw/timer/grlib_gptimer.c
@@ -28,7 +28,7 @@
 #include "hw/ptimer.h"
 #include "qemu/main-loop.h"
 
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #define UNIT_REG_SIZE    16     /* Size of memory mapped regs for the unit */
 #define GPTIMER_REG_SIZE 16     /* Size of memory mapped regs for a GPTimer */
diff --git a/hw/timer/lm32_timer.c b/hw/timer/lm32_timer.c
index 2a07b59..a902129 100644
--- a/hw/timer/lm32_timer.c
+++ b/hw/timer/lm32_timer.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qemu/timer.h"
 #include "hw/ptimer.h"
 #include "qemu/error-report.h"
diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 6f1f723..b7a2f72 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -31,8 +31,8 @@
 #include "sysemu/replay.h"
 #include "hw/timer/mc146818rtc.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
-#include "qapi/qapi-events-misc.h"
+#include "qemu-build/qapi/qapi-commands-misc.h"
+#include "qemu-build/qapi/qapi-events-misc.h"
 #include "qapi/visitor.h"
 
 #ifdef TARGET_I386
diff --git a/hw/timer/milkymist-sysctl.c b/hw/timer/milkymist-sysctl.c
index 93bc6e17..88ac5a1 100644
--- a/hw/timer/milkymist-sysctl.c
+++ b/hw/timer/milkymist-sysctl.c
@@ -25,7 +25,7 @@
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "sysemu/sysemu.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qemu/timer.h"
 #include "hw/ptimer.h"
 #include "qemu/error-report.h"
diff --git a/hw/timer/slavio_timer.c b/hw/timer/slavio_timer.c
index 4694b65..8fab81a 100644
--- a/hw/timer/slavio_timer.c
+++ b/hw/timer/slavio_timer.c
@@ -26,7 +26,7 @@
 #include "qemu/timer.h"
 #include "hw/ptimer.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qemu/main-loop.h"
 
 /*
diff --git a/hw/timer/xlnx-zynqmp-rtc.c b/hw/timer/xlnx-zynqmp-rtc.c
index c98dc3d..9a66109 100644
--- a/hw/timer/xlnx-zynqmp-rtc.c
+++ b/hw/timer/xlnx-zynqmp-rtc.c
@@ -32,7 +32,7 @@
 #include "hw/ptimer.h"
 #include "qemu/cutils.h"
 #include "sysemu/sysemu.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "hw/timer/xlnx-zynqmp-rtc.h"
 
 #ifndef XLNX_ZYNQMP_RTC_ERR_DEBUG
diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index d8917cb..ec4a12a 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -29,7 +29,7 @@
 #include "sysemu/reset.h"
 #include "tpm_int.h"
 #include "tpm_util.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 typedef struct CRBState {
     DeviceState parent_obj;
diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index 6418ef0..1ddc7aa 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -38,9 +38,9 @@
 #include "migration/blocker.h"
 #include "qapi/error.h"
 #include "qapi/clone-visitor.h"
-#include "qapi/qapi-visit-tpm.h"
+#include "qemu-build/qapi/qapi-visit-tpm.h"
 #include "chardev/char-fe.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #define TYPE_TPM_EMULATOR "tpm-emulator"
 #define TPM_EMULATOR(obj) \
diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index 479317e..fcb9b24 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -30,9 +30,9 @@
 #include "tpm_int.h"
 #include "hw/hw.h"
 #include "qapi/clone-visitor.h"
-#include "qapi/qapi-visit-tpm.h"
+#include "qemu-build/qapi/qapi-visit-tpm.h"
 #include "tpm_util.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #define TYPE_TPM_PASSTHROUGH "tpm-passthrough"
 #define TPM_PASSTHROUGH(obj) \
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 2ac7e74..cd26fc7 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -31,7 +31,7 @@
 #include "sysemu/tpm_backend.h"
 #include "tpm_int.h"
 #include "tpm_util.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #define TPM_TIS_NUM_LOCALITIES      5     /* per spec */
 #define TPM_TIS_LOCALITY_SHIFT      12
diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
index ee41757..92b4634 100644
--- a/hw/tpm/tpm_util.c
+++ b/hw/tpm/tpm_util.c
@@ -28,7 +28,7 @@
 #include "exec/memory.h"
 #include "sysemu/tpm_backend.h"
 #include "hw/qdev.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 /* tpm backend property */
 
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index 11f7720..250562f 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -6,7 +6,7 @@
 #include "qemu/error-report.h"
 #include "sysemu/sysemu.h"
 #include "monitor/monitor.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qemu/cutils.h"
 
 static void usb_bus_dev_print(Monitor *mon, DeviceState *qdev, int indent);
diff --git a/hw/usb/combined-packet.c b/hw/usb/combined-packet.c
index 48cac87..ed73b39 100644
--- a/hw/usb/combined-packet.c
+++ b/hw/usb/combined-packet.c
@@ -23,7 +23,7 @@
 #include "qemu-common.h"
 #include "hw/usb.h"
 #include "qemu/iov.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 static void usb_combined_packet_add(USBCombinedPacket *combined, USBPacket *p)
 {
diff --git a/hw/usb/core.c b/hw/usb/core.c
index 241ae66..aebdf9d 100644
--- a/hw/usb/core.c
+++ b/hw/usb/core.c
@@ -27,7 +27,7 @@
 #include "qemu-common.h"
 #include "hw/usb.h"
 #include "qemu/iov.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 void usb_pick_speed(USBPort *port)
 {
diff --git a/hw/usb/desc.c b/hw/usb/desc.c
index 85c15ad..bf8848a 100644
--- a/hw/usb/desc.c
+++ b/hw/usb/desc.c
@@ -2,7 +2,7 @@
 
 #include "hw/usb.h"
 #include "hw/usb/desc.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 /* ------------------------------------------------------------------ */
 
diff --git a/hw/usb/dev-hub.c b/hw/usb/dev-hub.c
index 752e30c..38dc602 100644
--- a/hw/usb/dev-hub.c
+++ b/hw/usb/dev-hub.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "hw/usb.h"
 #include "hw/usb/desc.h"
 #include "qemu/error-report.h"
diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 6ecf70a..8bb683f 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -22,7 +22,7 @@
 
 #include "qemu-common.h"
 #include "qemu/iov.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "hw/usb.h"
 #include "hw/usb/desc.h"
 
diff --git a/hw/usb/dev-uas.c b/hw/usb/dev-uas.c
index c218b53..8ee94d3 100644
--- a/hw/usb/dev-uas.c
+++ b/hw/usb/dev-uas.c
@@ -13,7 +13,7 @@
 #include "qemu-common.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qemu/error-report.h"
 
 #include "hw/usb.h"
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 01342326..705e9d4 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -31,7 +31,7 @@
 #include "qapi/error.h"
 #include "hw/usb/ehci-regs.h"
 #include "hw/usb/hcd-ehci.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qemu/error-report.h"
 
 #define FRAME_TIMER_FREQ 1000
diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index d4c0293..c38adcc 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -33,7 +33,7 @@
 #include "hw/pci/pci.h"
 #include "hw/sysbus.h"
 #include "hw/qdev-dma.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 /* This causes frames to occur 1000x slower */
 //#define OHCI_TIME_WARP 1
diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index 836b11f..52e7e1d 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -34,7 +34,7 @@
 #include "qemu/timer.h"
 #include "qemu/iov.h"
 #include "sysemu/dma.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qemu/main-loop.h"
 
 #define FRAME_TIMER_FREQ 1000
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 721beb5..74ba2a7 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -26,7 +26,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qapi/error.h"
 
 #include "hcd-xhci.h"
diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 1b0be07..b57b56c 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -44,7 +44,7 @@
 #include "monitor/monitor.h"
 #include "qemu/error-report.h"
 #include "sysemu/sysemu.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #include "hw/usb.h"
 
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index f895e3c..b077b93 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -33,7 +33,7 @@
 #include "qemu/error-report.h"
 #include "qemu/range.h"
 #include "sysemu/kvm.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qapi/error.h"
 
 struct vfio_group_head vfio_group_list =
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index e5779a7..3c88563 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -17,7 +17,7 @@
 #include "qapi/visitor.h"
 #include "hw/nvram/fw_cfg.h"
 #include "pci.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 /* Use uin32_t for vendor & device so PCI_ANY_ID expands and cannot match hw */
 static bool vfio_pci_is(VFIOPCIDevice *vdev, uint32_t vendor, uint32_t device)
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 3ba3cbc..b7d0c32 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -31,7 +31,7 @@
 #include "sysemu/kvm.h"
 #include "sysemu/sysemu.h"
 #include "pci.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qapi/error.h"
 
 #define MSIX_CAP_LENGTH 12
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 5c921c2..28e17eb 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -26,7 +26,7 @@
 #include "exec/memory.h"
 #include "qemu/queue.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "hw/platform-bus.h"
 #include "sysemu/kvm.h"
 
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 259397c..6913842 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -16,7 +16,7 @@
 #include "hw/vfio/vfio-common.h"
 #include "hw/hw.h"
 #include "qemu/error-report.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 static bool vfio_prereg_listener_skipped_section(MemoryRegionSection *section)
 {
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 44aea5c..b0dd38d 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -20,7 +20,7 @@
 #include "sysemu/cryptodev.h"
 #include "migration/migration.h"
 #include "migration/postcopy-ram.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #include <sys/ioctl.h>
 #include <sys/socket.h>
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 250f886..f07fe8f 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -27,7 +27,7 @@
 #include "hw/virtio/virtio-access.h"
 #include "migration/blocker.h"
 #include "sysemu/dma.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 /* enabled until disconnected backend stabilizes */
 #define _VHOST_DEBUG 1
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index f456cea..ddb18c4 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -24,9 +24,9 @@
 #include "sysemu/kvm.h"
 #include "exec/address-spaces.h"
 #include "qapi/error.h"
-#include "qapi/qapi-events-misc.h"
+#include "qemu-build/qapi/qapi-events-misc.h"
 #include "qapi/visitor.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qemu/error-report.h"
 
 #include "hw/virtio/virtio-bus.h"
diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index 289bbca..5d2c26c 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -17,7 +17,7 @@
 #include "hw/virtio/virtio-rng.h"
 #include "sysemu/rng.h"
 #include "qom/object_interfaces.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 static bool is_guest_ready(VirtIORNG *vrng)
 {
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 006d3d1..0d3dfed 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -15,7 +15,7 @@
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "exec/address-spaces.h"
 #include "qemu/error-report.h"
 #include "hw/virtio/virtio.h"
diff --git a/hw/watchdog/watchdog.c b/hw/watchdog/watchdog.c
index 6e8ba06..6946fec 100644
--- a/hw/watchdog/watchdog.c
+++ b/hw/watchdog/watchdog.c
@@ -24,8 +24,8 @@
 #include "qemu/config-file.h"
 #include "qemu/queue.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-run-state.h"
-#include "qapi/qapi-events-run-state.h"
+#include "qemu-build/qapi/qapi-commands-run-state.h"
+#include "qemu-build/qapi/qapi-events-run-state.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/watchdog.h"
 #include "hw/nmi.h"
diff --git a/io/channel-buffer.c b/io/channel-buffer.c
index 43d7959..4bc4f9f 100644
--- a/io/channel-buffer.c
+++ b/io/channel-buffer.c
@@ -22,7 +22,7 @@
 #include "io/channel-buffer.h"
 #include "io/channel-watch.h"
 #include "qemu/sockets.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 QIOChannelBuffer *
 qio_channel_buffer_new(size_t capacity)
diff --git a/io/channel-command.c b/io/channel-command.c
index 3e7eb17..d04efb1 100644
--- a/io/channel-command.c
+++ b/io/channel-command.c
@@ -23,7 +23,7 @@
 #include "io/channel-watch.h"
 #include "qapi/error.h"
 #include "qemu/sockets.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 
 QIOChannelCommand *
diff --git a/io/channel-file.c b/io/channel-file.c
index db948ab..e852a37 100644
--- a/io/channel-file.c
+++ b/io/channel-file.c
@@ -23,7 +23,7 @@
 #include "io/channel-watch.h"
 #include "qapi/error.h"
 #include "qemu/sockets.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 QIOChannelFile *
 qio_channel_file_new_fd(int fd)
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 57cfb4d..52caafb 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -20,10 +20,10 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qapi-visit-sockets.h"
+#include "qemu-build/qapi/qapi-visit-sockets.h"
 #include "io/channel-socket.h"
 #include "io/channel-watch.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qapi/clone-visitor.h"
 
 #define SOCKET_MAX_FDS 16
diff --git a/io/channel-tls.c b/io/channel-tls.c
index 9628e6f..228eacf 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "io/channel-tls.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 
 static ssize_t qio_channel_tls_write_handler(const char *buf,
diff --git a/io/channel-websock.c b/io/channel-websock.c
index ec48a30..a606558 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -23,7 +23,7 @@
 #include "qemu/bswap.h"
 #include "io/channel-websock.h"
 #include "crypto/hash.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qemu/iov.h"
 
 /* Max amount to allow in rawinput/encoutput buffers */
diff --git a/io/dns-resolver.c b/io/dns-resolver.c
index 187f725..856a4de 100644
--- a/io/dns-resolver.c
+++ b/io/dns-resolver.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "io/dns-resolver.h"
 #include "qapi/clone-visitor.h"
-#include "qapi/qapi-visit-sockets.h"
+#include "qemu-build/qapi/qapi-visit-sockets.h"
 #include "qemu/sockets.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
diff --git a/io/task.c b/io/task.c
index 2886a2c..b194d55 100644
--- a/io/task.c
+++ b/io/task.c
@@ -22,7 +22,7 @@
 #include "io/task.h"
 #include "qapi/error.h"
 #include "qemu/thread.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 struct QIOTask {
     Object *source;
diff --git a/ioport.c b/ioport.c
index 1a65add..b025c98 100644
--- a/ioport.c
+++ b/ioport.c
@@ -29,7 +29,7 @@
 #include "qemu-common.h"
 #include "cpu.h"
 #include "exec/ioport.h"
-#include "trace-root.h"
+#include "qemu-build/trace-root.h"
 #include "exec/memory.h"
 #include "exec/address-spaces.h"
 
diff --git a/iothread.c b/iothread.c
index 1b3463c..c329454 100644
--- a/iothread.c
+++ b/iothread.c
@@ -19,7 +19,7 @@
 #include "block/block.h"
 #include "sysemu/iothread.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qemu-build/qapi/qapi-commands-misc.h"
 #include "qemu/error-report.h"
 #include "qemu/rcu.h"
 #include "qemu/main-loop.h"
diff --git a/linux-user/main.c b/linux-user/main.c
index 7bc9bc7..e0715ce 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -17,7 +17,7 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
-#include "qemu-version.h"
+#include "qemu-build/qemu-version.h"
 #include <sys/syscall.h>
 #include <sys/resource.h>
 
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 2ce5d7a..f1d47a1 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -24,7 +24,7 @@
 #include "qemu.h"
 #include "qemu-common.h"
 #include "target_signal.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 static struct target_sigaltstack target_sigaltstack_used = {
     .ss_sp = 0,
diff --git a/memory.c b/memory.c
index e70b64b..1e31e3e 100644
--- a/memory.c
+++ b/memory.c
@@ -24,7 +24,7 @@
 #include "qemu/bitops.h"
 #include "qemu/error-report.h"
 #include "qom/object.h"
-#include "trace-root.h"
+#include "qemu-build/trace-root.h"
 
 #include "exec/memory-internal.h"
 #include "exec/ram_addr.h"
diff --git a/migration/channel.c b/migration/channel.c
index c5eaf0f..ffd6d8a 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -15,7 +15,7 @@
 #include "tls.h"
 #include "migration.h"
 #include "qemu-file-channel.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qapi/error.h"
 #include "io/channel-tls.h"
 
diff --git a/migration/colo-comm.c b/migration/colo-comm.c
index df26e4d..e2d161d 100644
--- a/migration/colo-comm.c
+++ b/migration/colo-comm.c
@@ -15,7 +15,7 @@
 #include "migration.h"
 #include "migration/colo.h"
 #include "migration/vmstate.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 typedef struct {
      bool colo_requested;
diff --git a/migration/colo-failover.c b/migration/colo-failover.c
index 0ae0c41..f712fc2 100644
--- a/migration/colo-failover.c
+++ b/migration/colo-failover.c
@@ -16,10 +16,10 @@
 #include "qemu/main-loop.h"
 #include "migration.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-migration.h"
+#include "qemu-build/qapi/qapi-commands-migration.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 static QEMUBH *failover_bh;
 static FailoverStatus failover_state;
diff --git a/migration/colo.c b/migration/colo.c
index 4381067..40eb3e2 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-migration.h"
+#include "qemu-build/qapi/qapi-commands-migration.h"
 #include "qemu-file-channel.h"
 #include "migration.h"
 #include "qemu-file.h"
@@ -21,7 +21,7 @@
 #include "migration/colo.h"
 #include "block.h"
 #include "io/channel-buffer.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qemu/error-report.h"
 #include "migration/failover.h"
 #include "replication.h"
diff --git a/migration/exec.c b/migration/exec.c
index 0bc5a42..bbb865b 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -21,7 +21,7 @@
 #include "channel.h"
 #include "exec.h"
 #include "io/channel-command.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 
 void exec_start_outgoing_migration(MigrationState *s, const char *command, Error **errp)
diff --git a/migration/fd.c b/migration/fd.c
index cd06182..f7ef2bd 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -19,7 +19,7 @@
 #include "fd.h"
 #include "monitor/monitor.h"
 #include "io/channel-util.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 
 void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **errp)
diff --git a/migration/global_state.c b/migration/global_state.c
index 8e8ab5c..cc82e70 100644
--- a/migration/global_state.c
+++ b/migration/global_state.c
@@ -17,7 +17,7 @@
 #include "migration.h"
 #include "migration/global_state.h"
 #include "migration/vmstate.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 typedef struct {
     uint32_t size;
diff --git a/migration/migration.c b/migration/migration.c
index 1f22f46..e24946f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -31,15 +31,15 @@
 #include "migration/vmstate.h"
 #include "block/block.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-migration.h"
-#include "qapi/qapi-events-migration.h"
+#include "qemu-build/qapi/qapi-commands-migration.h"
+#include "qemu-build/qapi/qapi-events-migration.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qnull.h"
 #include "qemu/rcu.h"
 #include "block.h"
 #include "postcopy-ram.h"
 #include "qemu/thread.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "exec/target_page.h"
 #include "io/channel-buffer.h"
 #include "migration/colo.h"
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index efd7793..3344b33 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -28,7 +28,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/balloon.h"
 #include "qemu/error-report.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 /* Arbitrary limit on size of each discard command,
  * keeps them around ~200 bytes
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 2ab2bf3..09917cd 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -28,7 +28,7 @@
 #include "qemu/iov.h"
 #include "migration.h"
 #include "qemu-file.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #define IO_BUF_SIZE 32768
 #define MAX_IOV_SIZE MIN(IOV_MAX, 64)
diff --git a/migration/ram.c b/migration/ram.c
index 6ce7770..13cbf79 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -43,9 +43,9 @@
 #include "migration/page_cache.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "qapi/qapi-events-migration.h"
+#include "qemu-build/qapi/qapi-events-migration.h"
 #include "qapi/qmp/qerror.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "exec/ram_addr.h"
 #include "exec/target_page.h"
 #include "qemu/rcu_queue.h"
diff --git a/migration/rdma.c b/migration/rdma.c
index da474fc..f0c5800 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -31,7 +31,7 @@
 #include <netdb.h>
 #include <arpa/inet.h>
 #include <rdma/rdma_cma.h>
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 /*
  * Print and error on both the Monitor and the Log file.
diff --git a/migration/savevm.c b/migration/savevm.c
index 305c3ce..2f72434 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -41,14 +41,14 @@
 #include "savevm.h"
 #include "postcopy-ram.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-migration.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qemu-build/qapi/qapi-commands-migration.h"
+#include "qemu-build/qapi/qapi-commands-misc.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 #include "sysemu/cpus.h"
 #include "exec/memory.h"
 #include "exec/target_page.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qemu/iov.h"
 #include "block/snapshot.h"
 #include "qemu/cutils.h"
diff --git a/migration/socket.c b/migration/socket.c
index 8a93fb1..f212818 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -24,7 +24,7 @@
 #include "migration.h"
 #include "qemu-file.h"
 #include "io/channel-socket.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 
 static SocketAddress *tcp_build_address(const char *host_port, Error **errp)
diff --git a/migration/tls.c b/migration/tls.c
index 3b9e8c9..e099c4b 100644
--- a/migration/tls.c
+++ b/migration/tls.c
@@ -26,7 +26,7 @@
 #include "crypto/tlscreds.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 static QCryptoTLSCreds *
 migration_tls_get_creds(MigrationState *s,
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index 48184c3..edead82 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -18,7 +18,7 @@
 #include "migration/vmstate.h"
 #include "qemu/error-report.h"
 #include "qemu/queue.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 /* bool */
 
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 0b3282c..e65dc06 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -18,7 +18,7 @@
 #include "qemu-file.h"
 #include "qemu/bitops.h"
 #include "qemu/error-report.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qjson.h"
 
 static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
diff --git a/monitor.c b/monitor.c
index a4417f2..76f95c3 100644
--- a/monitor.c
+++ b/monitor.c
@@ -59,7 +59,7 @@
 #include "qapi/qmp/json-streamer.h"
 #include "qapi/qmp/json-parser.h"
 #include "qom/object_interfaces.h"
-#include "trace-root.h"
+#include "qemu-build/trace-root.h"
 #include "trace/control.h"
 #include "monitor/hmp-target.h"
 #ifdef CONFIG_TRACE_SIMPLE
@@ -72,11 +72,11 @@
 #include "hmp.h"
 #include "qemu/thread.h"
 #include "block/qapi.h"
-#include "qapi/qapi-commands.h"
-#include "qapi/qapi-events.h"
+#include "qemu-build/qapi/qapi-commands.h"
+#include "qemu-build/qapi/qapi-events.h"
 #include "qapi/error.h"
 #include "qapi/qmp-event.h"
-#include "qapi/qapi-introspect.h"
+#include "qemu-build/qapi/qapi-introspect.h"
 #include "sysemu/qtest.h"
 #include "sysemu/cpus.h"
 #include "qemu/cutils.h"
@@ -2320,13 +2320,13 @@ int monitor_fd_param(Monitor *mon, const char *fdname, Error **errp)
 
 /* Please update hmp-commands.hx when adding or changing commands */
 static mon_cmd_t info_cmds[] = {
-#include "hmp-commands-info.h"
+#include "qemu-build/hmp-commands-info.h"
     { NULL, NULL, },
 };
 
 /* mon_cmds and info_cmds would be sorted at runtime */
 static mon_cmd_t mon_cmds[] = {
-#include "hmp-commands.h"
+#include "qemu-build/hmp-commands.h"
     { NULL, NULL, },
 };
 
diff --git a/nbd/client.c b/nbd/client.c
index dcad23a..12ffb97 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "nbd-internal.h"
 
 /* Definitions for opaque data types */
diff --git a/nbd/common.c b/nbd/common.c
index 8c95c1d..eb90ef4 100644
--- a/nbd/common.c
+++ b/nbd/common.c
@@ -17,7 +17,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "nbd-internal.h"
 
 /* Discard length bytes from channel.  Return -errno on failure and 0 on
diff --git a/nbd/server.c b/nbd/server.c
index e714bfe..3ff96e3 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "nbd-internal.h"
 
 static int system_errno_to_nbd_errno(int err)
diff --git a/net/colo-compare.c b/net/colo-compare.c
index 23b2d2c..a05930a 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -14,7 +14,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qemu-common.h"
 #include "qapi/error.h"
 #include "net/net.h"
diff --git a/net/colo.c b/net/colo.c
index 8426265..8e6896d 100644
--- a/net/colo.c
+++ b/net/colo.c
@@ -13,7 +13,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "net/colo.h"
 
 uint32_t connection_key_hash(const void *opaque)
diff --git a/net/filter-buffer.c b/net/filter-buffer.c
index f7265c5..065d492 100644
--- a/net/filter-buffer.c
+++ b/net/filter-buffer.c
@@ -13,7 +13,7 @@
 #include "qemu-common.h"
 #include "qemu/timer.h"
 #include "qemu/iov.h"
-#include "qapi/qapi-builtin-visit.h"
+#include "qemu-build/qapi/qapi-builtin-visit.h"
 #include "qapi/qmp/qerror.h"
 #include "qom/object.h"
 
diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index 3a61cf2..1749307 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -17,7 +17,7 @@
 #include "qom/object.h"
 #include "qemu/main-loop.h"
 #include "qemu/error-report.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "chardev/char-fe.h"
 #include "qemu/iov.h"
 #include "qemu/sockets.h"
diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
index 62dad2d..5058b8f 100644
--- a/net/filter-rewriter.c
+++ b/net/filter-rewriter.c
@@ -10,7 +10,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "net/colo.h"
 #include "net/filter.h"
 #include "net/net.h"
diff --git a/net/net.c b/net/net.c
index 5222e45..b209c4b 100644
--- a/net/net.c
+++ b/net/net.c
@@ -33,8 +33,8 @@
 
 #include "monitor/monitor.h"
 #include "qemu/help_option.h"
-#include "qapi/qapi-commands-net.h"
-#include "qapi/qapi-visit-net.h"
+#include "qemu-build/qapi/qapi-commands-net.h"
+#include "qemu-build/qapi/qapi-visit-net.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
diff --git a/net/vhost-user.c b/net/vhost-user.c
index e0f16c8..2636c4e 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -14,11 +14,11 @@
 #include "net/vhost-user.h"
 #include "chardev/char-fe.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-net.h"
+#include "qemu-build/qapi/qapi-commands-net.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 typedef struct VhostUserState {
     NetClientState nc;
diff --git a/numa.c b/numa.c
index 1116c90..ce83f19 100644
--- a/numa.c
+++ b/numa.c
@@ -31,8 +31,8 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/opts-visitor.h"
-#include "qapi/qapi-commands-misc.h"
-#include "qapi/qapi-visit-misc.h"
+#include "qemu-build/qapi/qapi-commands-misc.h"
+#include "qemu-build/qapi/qapi-visit-misc.h"
 #include "hw/boards.h"
 #include "sysemu/hostmem.h"
 #include "hw/mem/pc-dimm.h"
diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
index d9a1137..0610e3d 100644
--- a/qapi/qapi-visit-core.c
+++ b/qapi/qapi-visit-core.c
@@ -18,7 +18,7 @@
 #include "qapi/qmp/qerror.h"
 #include "qapi/visitor.h"
 #include "qapi/visitor-impl.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 void visit_complete(Visitor *v, void *opaque)
 {
diff --git a/qdev-monitor.c b/qdev-monitor.c
index b7e3291..61314384 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -24,7 +24,7 @@
 #include "monitor/qdev.h"
 #include "sysemu/arch_init.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qemu-build/qapi/qapi-commands-misc.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/config-file.h"
diff --git a/qemu-img.c b/qemu-img.c
index 088d890..1e2cf9f 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -25,9 +25,9 @@
 #include "qemu/osdep.h"
 #include <getopt.h>
 
-#include "qemu-version.h"
+#include "qemu-build/qemu-version.h"
 #include "qapi/error.h"
-#include "qapi/qapi-visit-block-core.h"
+#include "qemu-build/qapi/qapi-visit-block-core.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qdict.h"
@@ -121,7 +121,7 @@ static void QEMU_NORETURN help(void)
            "Command syntax:\n"
 #define DEF(option, callback, arg_string)        \
            "  " arg_string "\n"
-#include "qemu-img-cmds.h"
+#include "qemu-build/qemu-img-cmds.h"
 #undef DEF
 #undef GEN_DOCS
            "\n"
@@ -4683,7 +4683,7 @@ out:
 static const img_cmd_t img_cmds[] = {
 #define DEF(option, callback, arg_string)        \
     { option, callback },
-#include "qemu-img-cmds.h"
+#include "qemu-build/qemu-img-cmds.h"
 #undef DEF
 #undef GEN_DOCS
     { NULL, NULL, },
diff --git a/qemu-io.c b/qemu-io.c
index 160fb2a..b774b1e 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -30,7 +30,7 @@
 #include "block/block_int.h"
 #include "trace/control.h"
 #include "crypto/init.h"
-#include "qemu-version.h"
+#include "qemu-build/qemu-version.h"
 
 #define CMD_NOFILE_OK   0x01
 
diff --git a/qemu-nbd.c b/qemu-nbd.c
index ed5d9b5..3da6911 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -41,7 +41,7 @@
 #include "io/net-listener.h"
 #include "crypto/init.h"
 #include "trace/control.h"
-#include "qemu-version.h"
+#include "qemu-build/qemu-version.h"
 
 #define SOCKET_PATH                "/var/lock/qemu-nbd-%s"
 #define QEMU_NBD_OPT_CACHE         256
diff --git a/qga/main.c b/qga/main.c
index f9c8305..772b960 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -33,7 +33,7 @@
 #include "qemu/help_option.h"
 #include "qemu/sockets.h"
 #include "qemu/systemd.h"
-#include "qemu-version.h"
+#include "qemu-build/qemu-version.h"
 #ifdef _WIN32
 #include "qga/service-win32.h"
 #include "qga/vss-win32.h"
diff --git a/qmp.c b/qmp.c
index 4b2517d..a3b257e 100644
--- a/qmp.c
+++ b/qmp.c
@@ -14,7 +14,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-version.h"
+#include "qemu-build/qemu-version.h"
 #include "qemu/cutils.h"
 #include "qemu/option.h"
 #include "monitor/monitor.h"
@@ -31,9 +31,9 @@
 #include "sysemu/block-backend.h"
 #include "qom/qom-qobject.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-block-core.h"
-#include "qapi/qapi-commands-misc.h"
-#include "qapi/qapi-commands-ui.h"
+#include "qemu-build/qapi/qapi-commands-block-core.h"
+#include "qemu-build/qapi/qapi-commands-misc.h"
+#include "qemu-build/qapi/qapi-commands-ui.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/qobject-input-visitor.h"
diff --git a/qom/cpu.c b/qom/cpu.c
index e42d9a7..5c30dc5 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -31,7 +31,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
-#include "trace-root.h"
+#include "qemu-build/trace-root.h"
 
 CPUInterruptHandler cpu_interrupt_handler;
 
diff --git a/qom/object.c b/qom/object.c
index 755ad03..4191489 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -18,9 +18,9 @@
 #include "qapi/visitor.h"
 #include "qapi/string-input-visitor.h"
 #include "qapi/string-output-visitor.h"
-#include "qapi/qapi-builtin-visit.h"
+#include "qemu-build/qapi/qapi-builtin-visit.h"
 #include "qapi/qmp/qerror.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 /* TODO: replace QObject with a simpler visitor to avoid a dependency
  * of the QOM core on QObject?  */
diff --git a/replay/replay-input.c b/replay/replay-input.c
index 6ee8b5f..3206cd1 100644
--- a/replay/replay-input.c
+++ b/replay/replay-input.c
@@ -16,7 +16,7 @@
 #include "qemu/notify.h"
 #include "ui/input.h"
 #include "qapi/clone-visitor.h"
-#include "qapi/qapi-visit-ui.h"
+#include "qemu-build/qapi/qapi-visit-ui.h"
 
 void replay_save_input_event(InputEvent *evt)
 {
diff --git a/scsi/pr-manager.c b/scsi/pr-manager.c
index 87c45db..acdca0a 100644
--- a/scsi/pr-manager.c
+++ b/scsi/pr-manager.c
@@ -16,7 +16,7 @@
 #include "block/aio.h"
 #include "block/thread-pool.h"
 #include "scsi/pr-manager.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 typedef struct PRManagerData {
     PRManager *pr_mgr;
diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index 9fe615c..ab4e9e1 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -49,7 +49,7 @@
 #include "qapi/qmp/qstring.h"
 #include "io/channel-socket.h"
 #include "trace/control.h"
-#include "qemu-version.h"
+#include "qemu-build/qemu-version.h"
 
 #include "block/aio.h"
 #include "block/thread-pool.h"
diff --git a/stubs/tpm.c b/stubs/tpm.c
index 6729bc8..6310808 100644
--- a/stubs/tpm.c
+++ b/stubs/tpm.c
@@ -6,7 +6,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/qapi-commands-tpm.h"
+#include "qemu-build/qapi/qapi-commands-tpm.h"
 #include "sysemu/tpm.h"
 
 int tpm_init(void)
diff --git a/stubs/uuid.c b/stubs/uuid.c
index a802e98..314a334 100644
--- a/stubs/uuid.c
+++ b/stubs/uuid.c
@@ -1,6 +1,6 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qemu-build/qapi/qapi-commands-misc.h"
 #include "qemu/uuid.h"
 
 UuidInfo *qmp_query_uuid(Error **errp)
diff --git a/stubs/vmgenid.c b/stubs/vmgenid.c
index 568e42b..089cefd 100644
--- a/stubs/vmgenid.c
+++ b/stubs/vmgenid.c
@@ -1,6 +1,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qemu-build/qapi/qapi-commands-misc.h"
 #include "qapi/qmp/qerror.h"
 
 GuidInfo *qmp_query_vm_generation_id(Error **errp)
diff --git a/stubs/xen-hvm.c b/stubs/xen-hvm.c
index 0067bcc..16a98a2 100644
--- a/stubs/xen-hvm.c
+++ b/stubs/xen-hvm.c
@@ -12,7 +12,7 @@
 #include "qemu-common.h"
 #include "hw/xen/xen.h"
 #include "exec/memory.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qemu-build/qapi/qapi-commands-misc.h"
 
 int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num)
 {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 09893e3..92f1ad1 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1,6 +1,6 @@
 #include "qemu/osdep.h"
 #include "target/arm/idau.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "cpu.h"
 #include "internals.h"
 #include "exec/gdbstub.h"
diff --git a/target/arm/monitor.c b/target/arm/monitor.c
index 4cdd267..3dba379 100644
--- a/target/arm/monitor.c
+++ b/target/arm/monitor.c
@@ -23,7 +23,7 @@
 #include "qemu/osdep.h"
 #include "hw/boards.h"
 #include "kvm_arm.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qemu-build/qapi/qapi-commands-misc.h"
 
 static GICCapability *gic_cap_new(int version)
 {
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ec1efd3..78c8589 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -31,8 +31,8 @@
 #include "qemu/option.h"
 #include "qemu/config-file.h"
 #include "qapi/error.h"
-#include "qapi/qapi-visit-misc.h"
-#include "qapi/qapi-visit-run-state.h"
+#include "qemu-build/qapi/qapi-visit-misc.h"
+#include "qemu-build/qapi/qapi-visit-run-state.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/visitor.h"
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index d996cca..ba75706 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -46,7 +46,7 @@
 #include "hw/pci/msix.h"
 #include "migration/blocker.h"
 #include "exec/memattrs.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 //#define DEBUG_KVM
 
diff --git a/target/mips/translate.c b/target/mips/translate.c
index d05ee67..13080ff 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -34,7 +34,7 @@
 #include "exec/helper-gen.h"
 #include "exec/semihost.h"
 
-#include "target/mips/trace.h"
+#include "qemu-build/target/mips/trace.h"
 #include "trace-tcg.h"
 #include "exec/log.h"
 
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 79a436a..8540161 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -40,7 +40,7 @@
 #include "hw/ppc/spapr_cpu_core.h"
 #include "hw/ppc/ppc.h"
 #include "sysemu/watchdog.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "exec/gdbstub.h"
 #include "exec/memattrs.h"
 #include "exec/ram_addr.h"
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index c2b775f..c3d2b69 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -33,10 +33,10 @@
 #include "qemu/cutils.h"
 #include "qemu/timer.h"
 #include "qemu/error-report.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qapi/visitor.h"
-#include "qapi/qapi-visit-misc.h"
-#include "qapi/qapi-visit-run-state.h"
+#include "qemu-build/qapi/qapi-visit-misc.h"
+#include "qemu-build/qapi/qapi-visit-run-state.h"
 #include "sysemu/hw_accel.h"
 #include "exec/exec-all.h"
 #include "hw/qdev-properties.h"
diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 3b9e274..5af78be 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "cpu_features.h"
-#include "gen-features.h"
+#include "qemu-build/gen-features.h"
 
 #define FEAT_INIT(_name, _type, _bit, _desc) \
     {                                                \
diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index 83c164a..382420e 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -14,7 +14,7 @@
 #include "cpu.h"
 #include "internal.h"
 #include "hw/s390x/ioinst.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "hw/s390x/s390-pci-bus.h"
 
 int ioinst_disassemble_sch_ident(uint32_t value, int *m, int *cssid, int *ssid,
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index f570896..ef0a8f2 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -40,7 +40,7 @@
 #include "sysemu/device_tree.h"
 #include "exec/gdbstub.h"
 #include "exec/address-spaces.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "hw/s390x/s390-pci-inst.h"
 #include "hw/s390x/s390-pci-bus.h"
 #include "hw/s390x/ipl.h"
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 1deeb6e..664102d 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -23,7 +23,7 @@
 #include "kvm_s390x.h"
 #include "sysemu/kvm.h"
 #include "exec/exec-all.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "hw/s390x/storage-keys.h"
 
 /* #define DEBUG_S390 */
diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index aff1530..581ccaa 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -16,8 +16,8 @@
 #include "exec/address-spaces.h"
 #include "exec/exec-all.h"
 #include "sysemu/sysemu.h"
-#include "trace.h"
-#include "qapi/qapi-types-misc.h"
+#include "qemu-build/trace.h"
+#include "qemu-build/qapi/qapi-types-misc.h"
 
 QemuMutex qemu_sigp_mutex;
 
diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index c772492..da754d4 100644
--- a/target/sparc/int32_helper.c
+++ b/target/sparc/int32_helper.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "sysemu/sysemu.h"
 #include "exec/log.h"
 
diff --git a/target/sparc/int64_helper.c b/target/sparc/int64_helper.c
index f3e7f32..773a4d7 100644
--- a/target/sparc/int64_helper.c
+++ b/target/sparc/int64_helper.c
@@ -22,7 +22,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "exec/log.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #define DEBUG_PCALL
 
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index f8886ae..e0dc377 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "exec/address-spaces.h"
 
 /* Sparc MMU emulation */
diff --git a/target/sparc/win_helper.c b/target/sparc/win_helper.c
index 8290a21..e47304a 100644
--- a/target/sparc/win_helper.c
+++ b/target/sparc/win_helper.c
@@ -22,7 +22,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 static inline void memcpy32(target_ulong *dst, const target_ulong *src)
 {
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 22445d9..c0e86c1 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -13,8 +13,8 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 #include "qapi/error.h"
-#include "qapi/qapi-visit-introspect.h"
-#include "qapi/qapi-visit-misc.h"
+#include "qemu-build/qapi/qapi-visit-introspect.h"
+#include "qemu-build/qapi/qapi-visit-misc.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
 #include "qapi/qobject-input-visitor.h"
diff --git a/tests/tcg/test_path.c b/tests/tcg/test_path.c
index 1c29bce..5775653 100644
--- a/tests/tcg/test_path.c
+++ b/tests/tcg/test_path.c
@@ -1,5 +1,5 @@
 /* Test path override code */
-#include "config-host.h"
+#include "qemu-build/config-host.h"
 #include "util/cutils.c"
 #include "util/hexdump.c"
 #include "util/iov.c"
diff --git a/tests/test-char.c b/tests/test-char.c
index b3a77af..bbb4524 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -8,7 +8,7 @@
 #include "chardev/char-mux.h"
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-char.h"
+#include "qemu-build/qapi/qapi-commands-char.h"
 #include "qapi/qmp/qdict.h"
 #include "qom/qom-qobject.h"
 
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index 5b1cee6..b98fc68 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -6,9 +6,9 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "qapi/qobject-input-visitor.h"
-#include "tests/test-qapi-types.h"
-#include "tests/test-qapi-visit.h"
-#include "test-qapi-commands.h"
+#include "qemu-build/tests/test-qapi-types.h"
+#include "qemu-build/tests/test-qapi-visit.h"
+#include "qemu-build/test-qapi-commands.h"
 
 static QmpCommandList qmp_commands;
 
diff --git a/tests/test-qmp-event.c b/tests/test-qmp-event.c
index 31f35b3..2be2ce5 100644
--- a/tests/test-qmp-event.c
+++ b/tests/test-qmp-event.c
@@ -20,7 +20,7 @@
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp-event.h"
-#include "test-qapi-events.h"
+#include "qemu-build/test-qapi-events.h"
 
 typedef struct TestEventData {
     QDict *expect;
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-input-visitor.c
index 79b1a8c..a67561c 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -15,7 +15,7 @@
 
 #include "qemu-common.h"
 #include "qapi/error.h"
-#include "qapi/qapi-visit-introspect.h"
+#include "qemu-build/qapi/qapi-visit-introspect.h"
 #include "qapi/qobject-input-visitor.h"
 #include "test-qapi-visit.h"
 #include "qapi/qmp/qbool.h"
@@ -24,8 +24,8 @@
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp/qjson.h"
-#include "test-qapi-introspect.h"
-#include "qapi/qapi-introspect.h"
+#include "qemu-build/test-qapi-introspect.h"
+#include "qemu-build/qapi/qapi-introspect.h"
 
 typedef struct TestInputVisitorData {
     QObject *obj;
diff --git a/tpm.c b/tpm.c
index 9303172..38c51f3 100644
--- a/tpm.c
+++ b/tpm.c
@@ -15,7 +15,7 @@
 #include "qemu/osdep.h"
 
 #include "qapi/error.h"
-#include "qapi/qapi-commands-tpm.h"
+#include "qemu-build/qapi/qapi-commands-tpm.h"
 #include "qapi/qmp/qerror.h"
 #include "sysemu/tpm_backend.h"
 #include "sysemu/tpm.h"
diff --git a/trace/control-target.c b/trace/control-target.c
index 706b2ce..1301bca 100644
--- a/trace/control-target.c
+++ b/trace/control-target.c
@@ -9,7 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "trace-root.h"
+#include "qemu-build/trace-root.h"
 #include "trace/control.h"
 #include "translate-all.h"
 
diff --git a/trace/control.c b/trace/control.c
index e40cfca..ff68373 100644
--- a/trace/control.c
+++ b/trace/control.c
@@ -15,7 +15,7 @@
 #include "trace/simple.h"
 #endif
 #ifdef CONFIG_TRACE_FTRACE
-#include "trace/ftrace.h"
+#include "qemu-build/trace/ftrace.h"
 #endif
 #ifdef CONFIG_TRACE_LOG
 #include "qemu/log.h"
@@ -27,7 +27,7 @@
 #include "qemu/error-report.h"
 #include "qemu/config-file.h"
 #include "monitor/monitor.h"
-#include "trace-root.h"
+#include "qemu-build/trace-root.h"
 
 int trace_events_enabled_count;
 
diff --git a/trace/ftrace.c b/trace/ftrace.c
index 61692a8..54e6cf3 100644
--- a/trace/ftrace.c
+++ b/trace/ftrace.c
@@ -11,7 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "trace/control.h"
-#include "trace/ftrace.h"
+#include "qemu-build/trace/ftrace.h"
 
 int trace_marker_fd;
 
diff --git a/trace/qmp.c b/trace/qmp.c
index 756086c..7a53b2f 100644
--- a/trace/qmp.c
+++ b/trace/qmp.c
@@ -9,7 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-trace.h"
+#include "qemu-build/qapi/qapi-commands-trace.h"
 #include "trace/control.h"
 
 
diff --git a/ui/console.c b/ui/console.c
index a8868fc..3b2588a 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -26,11 +26,11 @@
 #include "ui/console.h"
 #include "hw/qdev-core.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-ui.h"
+#include "qemu-build/qapi/qapi-commands-ui.h"
 #include "qemu/option.h"
 #include "qemu/timer.h"
 #include "chardev/char-fe.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "exec/memory.h"
 
 #define DEFAULT_BACKSCROLL 512
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 9390c67..00133ee 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -14,7 +14,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #include "ui/console.h"
 #include "ui/gtk.h"
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 147ad6f..8fb84b0 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -10,7 +10,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #include "ui/console.h"
 #include "ui/gtk.h"
diff --git a/ui/gtk.c b/ui/gtk.c
index ef5bc42..c30abdc 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -37,7 +37,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qemu-build/qapi/qapi-commands-misc.h"
 #include "qemu/cutils.h"
 
 #include "ui/console.h"
@@ -50,7 +50,7 @@
 #endif
 #include <math.h>
 
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "ui/input.h"
 #include "sysemu/sysemu.h"
 #include "keymaps.h"
diff --git a/ui/input-keymap.c b/ui/input-keymap.c
index 3d4e66b..168d5bb 100644
--- a/ui/input-keymap.c
+++ b/ui/input-keymap.c
@@ -5,22 +5,22 @@
 
 #include "standard-headers/linux/input.h"
 
-#include "ui/input-keymap-atset1-to-qcode.c"
-#include "ui/input-keymap-linux-to-qcode.c"
-#include "ui/input-keymap-qcode-to-atset1.c"
-#include "ui/input-keymap-qcode-to-atset2.c"
-#include "ui/input-keymap-qcode-to-atset3.c"
-#include "ui/input-keymap-qcode-to-linux.c"
-#include "ui/input-keymap-qcode-to-qnum.c"
-#include "ui/input-keymap-qcode-to-sun.c"
-#include "ui/input-keymap-qnum-to-qcode.c"
-#include "ui/input-keymap-usb-to-qcode.c"
-#include "ui/input-keymap-win32-to-qcode.c"
-#include "ui/input-keymap-x11-to-qcode.c"
-#include "ui/input-keymap-xorgevdev-to-qcode.c"
-#include "ui/input-keymap-xorgkbd-to-qcode.c"
-#include "ui/input-keymap-xorgxquartz-to-qcode.c"
-#include "ui/input-keymap-xorgxwin-to-qcode.c"
+#include "qemu-build/ui/input-keymap-atset1-to-qcode.c"
+#include "qemu-build/ui/input-keymap-linux-to-qcode.c"
+#include "qemu-build/ui/input-keymap-qcode-to-atset1.c"
+#include "qemu-build/ui/input-keymap-qcode-to-atset2.c"
+#include "qemu-build/ui/input-keymap-qcode-to-atset3.c"
+#include "qemu-build/ui/input-keymap-qcode-to-linux.c"
+#include "qemu-build/ui/input-keymap-qcode-to-qnum.c"
+#include "qemu-build/ui/input-keymap-qcode-to-sun.c"
+#include "qemu-build/ui/input-keymap-qnum-to-qcode.c"
+#include "qemu-build/ui/input-keymap-usb-to-qcode.c"
+#include "qemu-build/ui/input-keymap-win32-to-qcode.c"
+#include "qemu-build/ui/input-keymap-x11-to-qcode.c"
+#include "qemu-build/ui/input-keymap-xorgevdev-to-qcode.c"
+#include "qemu-build/ui/input-keymap-xorgkbd-to-qcode.c"
+#include "qemu-build/ui/input-keymap-xorgxquartz-to-qcode.c"
+#include "qemu-build/ui/input-keymap-xorgxwin-to-qcode.c"
 
 int qemu_input_linux_to_qcode(unsigned int lnx)
 {
diff --git a/ui/input-legacy.c b/ui/input-legacy.c
index e5d4db1..8ec0122 100644
--- a/ui/input-legacy.c
+++ b/ui/input-legacy.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/qapi-commands-ui.h"
+#include "qemu-build/qapi/qapi-commands-ui.h"
 #include "sysemu/sysemu.h"
 #include "ui/console.h"
 #include "ui/keymaps.h"
diff --git a/ui/input.c b/ui/input.c
index 51b1019..022cdbc 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -1,10 +1,10 @@
 #include "qemu/osdep.h"
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-ui.h"
+#include "qemu-build/qapi/qapi-commands-ui.h"
 #include "qapi/qmp/qdict.h"
 #include "qemu/error-report.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "ui/input.h"
 #include "ui/console.h"
 #include "sysemu/replay.h"
diff --git a/ui/keymaps.c b/ui/keymaps.c
index 43fe604..89ba2df 100644
--- a/ui/keymaps.c
+++ b/ui/keymaps.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "keymaps.h"
 #include "sysemu/sysemu.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qemu/error-report.h"
 
 struct keysym2code {
diff --git a/ui/shader.c b/ui/shader.c
index 008458b..c022808 100644
--- a/ui/shader.c
+++ b/ui/shader.c
@@ -28,9 +28,9 @@
 #include "qemu-common.h"
 #include "ui/shader.h"
 
-#include "shader/texture-blit-vert.h"
-#include "shader/texture-blit-flip-vert.h"
-#include "shader/texture-blit-frag.h"
+#include "qemu-build/ui/shader/texture-blit-vert.h"
+#include "qemu-build/ui/shader/texture-blit-flip-vert.h"
+#include "qemu-build/ui/shader/texture-blit-frag.h"
 
 struct QemuGLShader {
     GLint texture_blit_prog;
diff --git a/ui/spice-core.c b/ui/spice-core.c
index ae8921a..840d448 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -29,8 +29,8 @@
 #include "qemu-x509.h"
 #include "qemu/sockets.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-ui.h"
-#include "qapi/qapi-events-ui.h"
+#include "qemu-build/qapi/qapi-commands-ui.h"
+#include "qemu-build/qapi/qapi-events-ui.h"
 #include "qemu/notify.h"
 #include "qemu/option.h"
 #include "migration/misc.h"
diff --git a/ui/spice-display.c b/ui/spice-display.c
index fe73482..bd282ab 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -22,7 +22,7 @@
 #include "qemu/queue.h"
 #include "ui/console.h"
 #include "sysemu/sysemu.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #include "ui/spice-display.h"
 
diff --git a/ui/vnc-auth-sasl.c b/ui/vnc-auth-sasl.c
index 3751a77..6910b31 100644
--- a/ui/vnc-auth-sasl.c
+++ b/ui/vnc-auth-sasl.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "vnc.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 /* Max amount of data we send/recv for SASL steps to prevent DOS */
 #define SASL_DATA_MAX_LEN (1024 * 1024)
diff --git a/ui/vnc-auth-vencrypt.c b/ui/vnc-auth-vencrypt.c
index d99ea36..49bab2e 100644
--- a/ui/vnc-auth-vencrypt.c
+++ b/ui/vnc-auth-vencrypt.c
@@ -28,7 +28,7 @@
 #include "vnc.h"
 #include "qapi/error.h"
 #include "qemu/main-loop.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 static void start_auth_vencrypt_subauth(VncState *vs)
 {
diff --git a/ui/vnc-ws.c b/ui/vnc-ws.c
index 950f1cd..c4948af 100644
--- a/ui/vnc-ws.c
+++ b/ui/vnc-ws.c
@@ -23,7 +23,7 @@
 #include "vnc.h"
 #include "io/channel-websock.h"
 #include "qemu/bswap.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 static void vncws_tls_handshake_done(QIOTask *task,
                                      gpointer user_data)
diff --git a/ui/vnc.c b/ui/vnc.c
index e164eb7..23aa43f 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -27,7 +27,7 @@
 #include "qemu/osdep.h"
 #include "vnc.h"
 #include "vnc-jobs.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "sysemu/sysemu.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
@@ -35,9 +35,9 @@
 #include "qemu/timer.h"
 #include "qemu/acl.h"
 #include "qemu/config-file.h"
-#include "qapi/qapi-events.h"
+#include "qemu-build/qapi/qapi-events.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-ui.h"
+#include "qemu-build/qapi/qapi-commands-ui.h"
 #include "ui/input.h"
 #include "crypto/hash.h"
 #include "crypto/tlscredsanon.h"
diff --git a/ui/x_keymap.c b/ui/x_keymap.c
index 22e0e77..3feb1d5 100644
--- a/ui/x_keymap.c
+++ b/ui/x_keymap.c
@@ -12,7 +12,7 @@
 #include "qemu/osdep.h"
 
 #include "x_keymap.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qemu/notify.h"
 #include "ui/input.h"
 
diff --git a/util/aio-posix.c b/util/aio-posix.c
index d8f0cb4..42c7f6b 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -19,7 +19,7 @@
 #include "qemu/rcu_queue.h"
 #include "qemu/sockets.h"
 #include "qemu/cutils.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #ifdef CONFIG_EPOLL_CREATE1
 #include <sys/epoll.h>
 #endif
diff --git a/util/async.c b/util/async.c
index 4dd9d95..3cec0ef 100644
--- a/util/async.c
+++ b/util/async.c
@@ -32,7 +32,7 @@
 #include "qemu/atomic.h"
 #include "block/raw-aio.h"
 #include "qemu/coroutine_int.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 /***********************************************************/
 /* bottom halves (can be seen as timers which expire ASAP) */
diff --git a/util/buffer.c b/util/buffer.c
index d8bb874..dddf64f 100644
--- a/util/buffer.c
+++ b/util/buffer.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "qemu/host-utils.h"
 #include "qemu/buffer.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #define BUFFER_MIN_INIT_SIZE     4096
 #define BUFFER_MIN_SHRINK_SIZE  65536
diff --git a/util/hbitmap.c b/util/hbitmap.c
index 58a2c93..f345968 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -12,7 +12,7 @@
 #include "qemu/osdep.h"
 #include "qemu/hbitmap.h"
 #include "qemu/host-utils.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "crypto/hash.h"
 
 /* HBitmaps provides an array of bits.  The bits are stored as usual in an
diff --git a/util/lockcnt.c b/util/lockcnt.c
index 4f88dcf..b46cdb9 100644
--- a/util/lockcnt.c
+++ b/util/lockcnt.c
@@ -9,7 +9,7 @@
 #include "qemu/osdep.h"
 #include "qemu/thread.h"
 #include "qemu/atomic.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #ifdef CONFIG_LINUX
 #include "qemu/futex.h"
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 13b6f8d..dfd642e 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -32,7 +32,7 @@
 #include <glib/gprintf.h>
 
 #include "sysemu/sysemu.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qapi/error.h"
 #include "qemu/sockets.h"
 #include <libgen.h>
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index bb5ad28..0527c90 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -34,7 +34,7 @@
 #include "qapi/error.h"
 #include "sysemu/sysemu.h"
 #include "qemu/main-loop.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qemu/sockets.h"
 #include "qemu/cutils.h"
 
diff --git a/util/qemu-config.c b/util/qemu-config.c
index c651c48..9e1aecc 100644
--- a/util/qemu-config.c
+++ b/util/qemu-config.c
@@ -1,6 +1,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qemu-build/qapi/qapi-commands-misc.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
 #include "qemu-common.h"
diff --git a/util/qemu-coroutine-lock.c b/util/qemu-coroutine-lock.c
index 5a80c10..ead32f3 100644
--- a/util/qemu-coroutine-lock.c
+++ b/util/qemu-coroutine-lock.c
@@ -33,7 +33,7 @@
 #include "qemu/processor.h"
 #include "qemu/queue.h"
 #include "block/aio.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 void qemu_co_queue_init(CoQueue *queue)
 {
diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
index 9eff7fd..9b8c50b 100644
--- a/util/qemu-coroutine.c
+++ b/util/qemu-coroutine.c
@@ -13,7 +13,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qemu-common.h"
 #include "qemu/thread.h"
 #include "qemu/atomic.h"
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 7f13e8a..d80f75c 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -24,7 +24,7 @@
 #include "monitor/monitor.h"
 #include "qapi/clone-visitor.h"
 #include "qapi/error.h"
-#include "qapi/qapi-visit-sockets.h"
+#include "qemu-build/qapi/qapi-visit-sockets.h"
 #include "qemu/sockets.h"
 #include "qemu/main-loop.h"
 #include "qapi/qobject-input-visitor.h"
diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index b789cf3..ff24d14 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -14,7 +14,7 @@
 #include "qemu/thread.h"
 #include "qemu/atomic.h"
 #include "qemu/notify.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 static bool name_threads;
 
diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
index ab60c0d..8f4e401 100644
--- a/util/qemu-thread-win32.c
+++ b/util/qemu-thread-win32.c
@@ -19,7 +19,7 @@
 #include "qemu-common.h"
 #include "qemu/thread.h"
 #include "qemu/notify.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include <process.h>
 
 static bool name_threads;
diff --git a/util/thread-pool.c b/util/thread-pool.c
index 610646d..70fdb84 100644
--- a/util/thread-pool.c
+++ b/util/thread-pool.c
@@ -19,7 +19,7 @@
 #include "qemu/queue.h"
 #include "qemu/thread.h"
 #include "qemu/coroutine.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "block/thread-pool.h"
 #include "qemu/main-loop.h"
 
diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 006674c..acb7180 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -16,13 +16,13 @@
 #include "qapi/error.h"
 #include "exec/ramlist.h"
 #include "exec/cpu-common.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 #include "qemu/queue.h"
 #include "qemu/error-report.h"
 #include "standard-headers/linux/pci_regs.h"
 #include "qemu/event_notifier.h"
 #include "qemu/vfio-helpers.h"
-#include "trace.h"
+#include "qemu-build/trace.h"
 
 #define QEMU_VFIO_DEBUG 0
 
diff --git a/vl.c b/vl.c
index 0b15811..98697ca 100644
--- a/vl.c
+++ b/vl.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-version.h"
+#include "qemu-build/qemu-version.h"
 #include "qemu/cutils.h"
 #include "qemu/help_option.h"
 #include "qemu/uuid.h"
@@ -112,7 +112,7 @@ int main(int argc, char **argv)
 
 #include "slirp/libslirp.h"
 
-#include "trace-root.h"
+#include "qemu-build/trace-root.h"
 #include "trace/control.h"
 #include "qemu/queue.h"
 #include "sysemu/arch_init.h"
@@ -124,11 +124,11 @@ int main(int argc, char **argv)
 #include "exec/semihost.h"
 #include "crypto/init.h"
 #include "sysemu/replay.h"
-#include "qapi/qapi-events-run-state.h"
-#include "qapi/qapi-visit-block-core.h"
-#include "qapi/qapi-commands-block-core.h"
-#include "qapi/qapi-commands-misc.h"
-#include "qapi/qapi-commands-run-state.h"
+#include "qemu-build/qapi/qapi-events-run-state.h"
+#include "qemu-build/qapi/qapi-visit-block-core.h"
+#include "qemu-build/qapi/qapi-commands-block-core.h"
+#include "qemu-build/qapi/qapi-commands-misc.h"
+#include "qemu-build/qapi/qapi-commands-run-state.h"
 #include "qapi/qmp/qerror.h"
 #include "sysemu/iothread.h"
 
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index 64d9c0f..2d80f0b 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -177,8 +177,8 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCVisitor):
         self._genc.preamble_add(mcgen('''
 #include "qemu/osdep.h"
 #include "qapi/dealloc-visitor.h"
-#include "qapi/qapi-builtin-types.h"
-#include "qapi/qapi-builtin-visit.h"
+#include "qemu-build/qapi/qapi-builtin-types.h"
+#include "qemu-build/qapi/qapi-builtin-visit.h"
 '''))
         self._genh.preamble_add(mcgen('''
 #include "qapi/util.h"
@@ -195,7 +195,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCVisitor):
 ''',
                                       types=types, visit=visit))
         self._genh.preamble_add(mcgen('''
-#include "qapi/qapi-builtin-types.h"
+#include "qemu-build/qapi/qapi-builtin-types.h"
 '''))
 
     def visit_begin(self, schema):
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 5d72d89..c8c2e5a 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -274,11 +274,11 @@ class QAPISchemaGenVisitVisitor(QAPISchemaModularCVisitor):
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qapi/error.h"
-#include "qapi/qapi-builtin-visit.h"
+#include "qemu-build/qapi/qapi-builtin-visit.h"
 '''))
         self._genh.preamble_add(mcgen('''
 #include "qapi/visitor.h"
-#include "qapi/qapi-builtin-types.h"
+#include "qemu-build/qapi/qapi-builtin-types.h"
 
 ''',
                                       prefix=prefix))
@@ -295,7 +295,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaModularCVisitor):
 ''',
                                       visit=visit, prefix=self._prefix))
         self._genh.preamble_add(mcgen('''
-#include "qapi/qapi-builtin-visit.h"
+#include "qemu-build/qapi/qapi-builtin-visit.h"
 #include "%(types)s.h"
 
 ''',
diff --git a/scripts/tracetool/backend/dtrace.py b/scripts/tracetool/backend/dtrace.py
index c2f3a4e..5f6e2d1 100644
--- a/scripts/tracetool/backend/dtrace.py
+++ b/scripts/tracetool/backend/dtrace.py
@@ -37,9 +37,9 @@ def binary():
 
 def generate_h_begin(events, group):
     if group == "root":
-        header = "trace-dtrace-root.h"
+        header = "qemu-build/trace-dtrace-root.h"
     else:
-        header = "trace-dtrace.h"
+        header = "qemu-build/trace-dtrace.h"
 
     out('#include "%s"' % header,
         '')
diff --git a/scripts/tracetool/format/c.py b/scripts/tracetool/format/c.py
index 833c05a..37600e9 100644
--- a/scripts/tracetool/format/c.py
+++ b/scripts/tracetool/format/c.py
@@ -21,9 +21,9 @@ def generate(events, backend, group):
                      if "disable" not in e.properties]
 
     if group == "root":
-        header = "trace-root.h"
+        header = "qemu-build/trace-root.h"
     else:
-        header = "trace.h"
+        header = "qemu-build/trace.h"
 
     out('/* This file is autogenerated by tracetool, do not edit. */',
         '',
diff --git a/scripts/tracetool/format/tcg_h.py b/scripts/tracetool/format/tcg_h.py
index 1651cc3..d7cac01 100644
--- a/scripts/tracetool/format/tcg_h.py
+++ b/scripts/tracetool/format/tcg_h.py
@@ -29,9 +29,9 @@ def vcpu_transform_args(args):
 
 def generate(events, backend, group):
     if group == "root":
-        header = "trace-root.h"
+        header = "qemu-build/trace-root.h"
     else:
-        header = "trace.h"
+        header = "qemu-build/trace.h"
 
     out('/* This file is autogenerated by tracetool, do not edit. */',
         '/* You must include this file after the inclusion of helper.h */',
diff --git a/scripts/tracetool/format/tcg_helper_c.py b/scripts/tracetool/format/tcg_helper_c.py
index bbbd6ad..cafcf8f 100644
--- a/scripts/tracetool/format/tcg_helper_c.py
+++ b/scripts/tracetool/format/tcg_helper_c.py
@@ -42,9 +42,9 @@ def vcpu_transform_args(args, mode):
 
 def generate(events, backend, group):
     if group == "root":
-        header = "trace-root.h"
+        header = "qemu-build/trace-root.h"
     else:
-        header = "trace.h"
+        header = "qemu-build/trace.h"
 
     events = [e for e in events
               if "disable" not in e.properties]
diff --git a/target/s390x/Makefile.objs b/target/s390x/Makefile.objs
index 31932de..f373a5e 100644
--- a/target/s390x/Makefile.objs
+++ b/target/s390x/Makefile.objs
@@ -10,12 +10,13 @@ obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
 feat-src = $(SRC_PATH)/target/$(TARGET_BASE_ARCH)/
 feat-dst = $(BUILD_DIR)/$(TARGET_DIR)
 ifneq ($(MAKECMDGOALS),clean)
-GENERATED_FILES += $(feat-dst)gen-features.h
+GENERATED_FILES += $(feat-dst)qemu-build/gen-features.h
 endif
 
-$(feat-dst)gen-features.h: $(feat-dst)gen-features.h-timestamp
+$(feat-dst)qemu-build/gen-features.h: $(feat-dst)qemu-build/gen-features.h-timestamp
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-$(feat-dst)gen-features.h-timestamp: $(feat-dst)gen-features
+$(feat-dst)qemu-build/gen-features.h-timestamp: $(feat-dst)gen-features
+	$(call quiet-command,mkdir -p $(dir $@), "MKDIR $(dir $@)")
 	$(call quiet-command,$< >$@,"GEN","$(TARGET_DIR)gen-features.h")
 
 $(feat-dst)gen-features: $(feat-src)gen-features.c
diff --git a/trace-events b/trace-events
index 2c3e3d7..8a46fc0 100644
--- a/trace-events
+++ b/trace-events
@@ -8,7 +8,7 @@
 #    string.
 #
 # 2. Call the trace event from code using trace_##name, e.g. multiwrite_cb() ->
-#    trace_multiwrite_cb().  The source file must #include "trace.h".
+#    trace_multiwrite_cb().  The source file must #include "qemu-build/trace.h".
 #
 # Format of a trace event:
 #
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 18de0bb..82142a6 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -32,9 +32,9 @@
 #include "ui/input.h"
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands.h"
+#include "qemu-build/qapi/qapi-commands.h"
 #include "sysemu/blockdev.h"
-#include "qemu-version.h"
+#include "qemu-build/qemu-version.h"
 #include <Carbon/Carbon.h>
 #include "qom/cpu.h"
 
diff --git a/version.rc b/version.rc
index d8e1569..aa44961 100644
--- a/version.rc
+++ b/version.rc
@@ -1,5 +1,5 @@
 #include <winver.h>
-#include "config-host.h"
+#include "qemu-build/config-host.h"
 
 VS_VERSION_INFO VERSIONINFO
 FILEVERSION CONFIG_FILEVERSION
-- 
MST
